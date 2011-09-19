/* SR3.cpp symbol ranking file compressor, 27.10.2007.
(C) 2007, Matt Mahoney, matmahoney@yahoo.com

To compile (g++ 3.4.5, upx 3.00w):
g++ -Wall sr3a.cpp -O2 -Os -march=pentiumpro -fomit-frame-pointer -s -o sr3a.exe
upx -qqq sr3a.exe

- ****************************************************
  Update by Ben Golightly (2010)
    * Modified to delete original files after (de)compression
    * Modified to be quieter
- ****************************************************
  Update by Nania Francesco Antonio (Italy):
    * added Wave compression;
    * implemented compression Txt,Bmp,Doc etc;
    * require only 64 MB of memory;
- ****************************************************
- ****************************************************
  Update by Andrew Paterson (UK):
    * Changed file id to sR3;
    * "Profile" stored as 1 byte;
    * Additional file types detected
    * Will create sr2 or (new) sr3 compressed files;
    * Will decompress sr2, old sr3 and new sr3 files;
    * Avoid some issues with endianness;
    * Does not use global variables;
    * Small efficiency improvements;
- ****************************************************

    LICENSE for sr3a.cpp

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of
    the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details at
    Visit <http://www.gnu.org/copyleft/gpl.html>.

To compress to sr3:    sr3a c input output
        or for sr2:    sr3a c2 input output
To decompress sr2/sr3: sr3a d input output
    or for old sr3:    sr3a d3 input output

There is no limit on file size.  The size of files over 2 GB will
be reported as -1 (but still compressed and uncompressed correctly).

To compile (g++ 3.4.5, upx 3.00w):
g++ -Wall sr3a.cpp -O2 -Os -march=pentiumpro -fomit-frame-pointer -s -o sr3a.exe
upx -qqq sr3a.exe


PROGRAM DESCRIPTION

SR2 is a symbol ranking compressor.  The "2" means it is the second
compressor of this type, the first being SRANK by P. M. Fenwick in
1997-98, available at ftp://ftp.cs.auckland.ac.nz/pub/staff/peter-f/srank.c

A symbol ranking compressor maintains a list (a move-to-front queue)
of the most recently seen symbols (bytes) in the current context in
order of time since last seen.  After coding, the symbol is moved
to the front of the queue.

The original SRANK used a table of 2^10 to 2^18 hashed order-3
contexts and a queue length of 3.  Hits were Huffman coded using
1, 3, or 4 bits.  Misses were coded from a second order-0 queue
using 7 bits (top 32) or 12 bits.

SR2 uses a table of size 2^20 hashed order-4 contexts and a queue
length of 3 (c1, c2, c3), plus a 6 bit count (n) of consecutive hits.
Hits and misses are both arithmetic coded using both an order-1 context
(last coded byte) and the count as context, or order-0 and count if the
count is greater than 3.  Codes and updates are as follows:

  Input    Code        (c1  c2  c3  n) next state
  -----    ----        --------------------------
  Initial              (0,  0,  0,  0)
    c1     0           (c1, c2, c3, min(n+1, 63))
    c2     110         (c2, c1, c3, 1)
    c3     111         (c3, c1, c2, 1)
  other c  10cccccccc  (c,  c1, c2, 0)

After coding byte c, the hash index h is updated to h*160+c+1 (mod 2^20)
which depends on only the last 4 bytes.  Hash collisions are not detected.
The values are packed into a 32 bit integer as follows: c1 in bits 0-7,
c2 in 8-15, c3 in 16-24, n in 25-30.

End of file is marked by coding c1 as a literal.  The compressor adds a
3 byte header "sR\x02" or "sR\x03" which is checked by the decompressor.
For sr3-format files, this header is followed by a byte representing the
file type (currently 0-25).

Codes and literals are arithmetic coded most significant byte (MSB)
first.  The secondary context passed to the arithmetic coder is
uniquely determined by the previously coded bits of the current
code (258 possibilities), n (64 possibilities), and the previously
coded byte for the case of n < 4 (256 possibilities) for a total
of 258 * (256 * 4 + 60) = 279,672 secondary contexts.

Each of these contexts maps to a table entry containing a probability (p)
that the next bit will be a 1, and a count (n).  The entry is updated
as follows:

  Input      (p, n) next state
  -------    -----------------
  Initial    (.5, 0)
    0        (p - p/(n+2), min(n+1, 127))
    1        (p + (1-p)/(n+2), min(n+1, 127))

p is represented as a 25 bit scaled unsigned integer, packed with n into
a 32 bit integer (p in bits 8-31, n in 0-7).  To avoid division (which
is slow), the second term is computed by scaling p to 23 bits (discarding
2 low bits), multiplying by 512/(n+2) from a lookup table to produce
a 32 bit result, then scaling to 25 bits.

An arithmetic code represents a bit string S as a base-256 fraction between
x1 = p(<S) and x2 = p(<S)+p(S), where p(S) is the probability of S, and
p(<S) means the sum of the probabilities of all strings lexicographically
before S.  An arithmetic code can be computed incrementally because
p(S) = p(S1) * p(S2|S1) * p(S3|S1..2) * p(S4|S1..3) *...* p(Sn|S1..n-1)
where P(Si|S1..i-1) means the probability of the i'th bit of S given
the first i-1 bits.  Furthermore the range (x1,x2) (initially (0,1))
narrows given each new symbol probability.  As the leading base-256
digits of x1 and x2 match, they can be output.  We approximate (x1,x2)
so that only the first 4 nonmatching digits need to be kept in memory
(as 32 bit integers).

The arithmetic coder state is updated as follows.  Note that the
lexicographical order is reversed (1 before 0), which makes no difference.
The input is the bit to be coded (0 or 1) and the probability (p) from
the secondary context table.

  Input    (x1, x2) next state
  -------  -------------------
  Initial  (0, 2^32-1)
    0      ((x2-x1)*p+1, x2)
    1      (x1, (x2-x1)*p)

To avoid overflow, x2-x1 is scaled to 20 bits (discarding the low
12 bits) and p is scaled to 12 bits (discarding the low 13 bits).

During decompression, the bit is determined by comparing the compressed
data (x) with (x2-x1)*p.  If it is less or equal, then the next bit is
1, else 0.

x1 and x2 represent 4 digits of a base 256 number with the most
significant digit in bits 24-31.  If the leading
digits are equal, they are shifted out.  During decompression, the
next input byte would be shifted into x as well.

  while x1/256^3 = x2/256^3
    if compressing then output x1 / 256^3
    (x1, x2) <-- (x1 * 256 (mod 2^32), x2 * 256 + 255 (mod 2^32))
    if decompressing then x <-- x * 256 + next input byte (mod 2^32)

Thus, it is always true that x2 > x1, and there is never a case
where a bit cannot be coded.  In the worst case, x2 = x1 + 1, so
that (x2-x1)*p = x1 due to integer truncation and because 0 <= p < 1.
In this case (x1, x2) is updated to either (x1, x1) or (x2, x2), after
which 4 bytes are shifted and the new state is (0, 2^32-1).

OPTIMIZATION NOTES

- A queue depth greater than 3 has little benefit for compression
  (confirming Fenwick's observation).

- Increasing the table size beyond 2^20 helps compression surprisingly
  little.  It hurts speed because there are more cache misses.
  Modern computer speed is limited more by slow memory than by
  computation.

- Allowing n to count to 255 (instead of 63) improves compression a
  tiny bit on larger files but hurts smaller files.

- SR2 uses an order 4 context.  On some small files, order 3 compresses
  better.  It is rare that any order other than 3 or 4 would be best.
  Order 4 is usually best for larger files.

- It might be possible to improve compression by maintaining both
  order 3 and 4 contexts, and choosing whichever has the higher n
  (indicating greater predictability).  However this would almost
  double compression time because time is dominated by cache misses.

- The choice of codes for c1, c2, c3 and literals affects compression
  speed, but not ratio.  The chosen codes are good for highly redundant
  files.  For harder to compress files, it would be better to code
  literals using 9 bits and assign longer codes to c1, c2 and c3.

- Allowing multi-byte symbols for c1 (say, up to 4 bytes) would reduce
  the number of lookups in highly redundant data, but the added
  complexity was found to negate any speed advantage.  It does not
  improve compression ratio.

- Packing c1, c2, c3, n into a 32 bit integer is a little faster than
  byte operations.  The organization was chosen to optimize the coding
  of c1 and literals, which are more common than c2 and c3.

- The assignment of secondary context codes is irrelevant to compressed
  data content.  The codes were assigned to minimize cache misses in
  the secondary table.  Consecutive bits in codes have adjacent
  contexts.  Literals are divided into two 4-bit nibbles, so that the
  context of the previous 0 to 3 bits spans a range of 15 values,
  fitting in one 64-byte cache line.

- The cache is not aligned.  It could be, but then it would not be possible
  to fit the first nibble and the two preceding bits into one cache line.
  It would be possible if literals had 9-bit codes, but then c1 would
  require 2 bits, slowing down compression of highly redundant files.

- Packing p and n together in the secondary context table costs some
  bit operations, but saves memory (and pressure on the cache).

- In the arithmetic coder, compression could be improved very slightly,
  at the cost of either speed or assembler code, with a more accurate
  calculation of (x2-x1)*p (as in PAQ).

- Splitting the program into a separate decompressor improves speed.
  For reasons I don't understand, inlining code and unrolling loops
  in the decompressor slowed down the compressor and vice versa.

- g++ is faster than Borland or Mars.  I haven't tried other compilers.

- In g++, -O3 is no faster than -O2, -march=pentium4 is no faster
  than -march=pentiumpro.  For some reason -Os (optimize for size)
  makes it faster.  -fomit-frame-pointer always helps.


BENCHMARKS

The following are some benchmarks on enwik9 (1,000,000,000 bytes)
from  the large text benchmark at
http://cs.fit.edu/~mmahoney/compression/text.html
Compression and decompression times are process times (not including
disk I/O) in seconds as measured with timer 3.01 on a 2.2 GHz
Athlon-64 with 2 GB memory in WinXP Home (32 bit).

Compressor                     Size      Comp  Decomp  Memory (MB)
-------------              -----------   ----  ------  ------
QuickLZ 1.30b              410,633,262     48      12     3
srank 1.1                  409,217,739     51      45     2
InfoZIP 2.3.1 -9           322,592,120    104      35     0.1
gzip 1.3.5 -9              322,591,995    107      56     1.4
sr2                        273,906,319     99     109     6
bzip2 1.0.2 -9             253,977,839    379     129     8
cabarc 1.00.0601 -m lzx:21 250,756,595   1619      15    20
ppmd J -m256 -o10 -r1      183,964,915    880     895   256
ppmonstr J -m1700 -o16     157,007,383   3574   ~3600  1700
paq8hp12any -8             132,045,026  56993  ~57000  1850

Calgary corpus (gzip -9, sr2)
--------------
  34,900 BIB.gz
 312,281 BOOK1.gz
 206,158 BOOK2.gz
  68,414 GEO.gz
 144,400 NEWS.gz
  10,320 OBJ1.gz
  81,087 OBJ2.gz
  18,543 PAPER1.gz
  29,667 PAPER2.gz
  52,381 PIC.gz
  13,261 PROGC.gz
  16,164 PROGL.gz
  11,186 PROGP.gz
  18,862 TRANS.gz
1,017,624 bytes

  34,017 BIB.sr2
 276,364 BOOK1.sr2
 189,651 BOOK2.sr2
  61,876 GEO.sr2
 139,184 NEWS.sr2
  11,061 OBJ1.sr2
  88,325 OBJ2.sr2
  19,943 PAPER1.sr2
  29,744 PAPER2.sr2
  54,603 PIC.sr2
  14,957 PROGC.sr2
  19,022 PROGL.sr2
  13,831 PROGP.sr2
  22,630 TRANS.sr2
  975,208 bytes

maximumcompression.com
----------------------
  841,463 a10.jpg.gz
1,732,385 acrord32.exe.gz
1,050,495 english.dic.gz
3,833,206 FlashMX.pdf.gz
1,337,914 fp.log.gz
2,188,891 mso97.dll.gz
1,007,497 ohs.doc.gz
1,254,355 rafale.bmp.gz
  840,488 vcfiu.hlp.gz
  862,955 world95.txt.gz
14,949,649 bytes

  841,840 a10.jpg.sr2
1,903,791 acrord32.exe.sr2
  649,876 english.dic.sr2
3,850,838 FlashMX.pdf.sr2
  699,171 fp.log.sr2
2,274,079 mso97.dll.sr2
  953,569 ohs.doc.sr2
1,006,034 rafale.bmp.sr2
  882,891 vcfiu.hlp.sr2
  796,777 world95.txt.sr2
13,858,866 bytes

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define NDEBUG  // remove for debugging
#include <assert.h>
#include <malloc.h>
#include <cstring>

#define MAX_PROFILE 25

/* static const char *profiles[] = {
  "",           //  0 - Default
  " (LOG)",     //  1 - Log files
  " (BMP)",     //  2 - Bitmap image
  " (Dict)",    //  3 - Dictionary
  " (EXE)",     //  4 - Executable
  " (HLP)",     //  5 - Help file
  " (ZIP)",     //  6 - ZIP compressed file
  " (PDF)",     //  7 - Adobe Acrobat file
  " (JPEG)",    //  8 - JPEG image
  " (Text)",    //  9 - Text
  " (ISO)",     // 10 - ISO disk image
  " (PGM)",     // 11 - PGM image
  " (DSG)",     // 12 - Doom save game
  " (MP3)",     // 13 - MPEG audio file
  " (DOC)",     // 14 - MS Word file
  " (PNG)",     // 15 - PNG image
  " (GZIP)",    // 16 - GZIP compressed file
  " (BZ2)",     // 17 - BZIP2 compressed file
  " (WAV)",     // 18 - stereo - 16 bit
  " (WAV-M16)", // 19 - mono - 16 bit
  " (WAV-S8)",  // 20 - stereo - 16 bit
  " (WAV-M8)",  // 21 - mono - 8 bit
  " (WAV-S24)", // 22 - stereo HQ - 24 bit
  " (WAV-M24)", // 23 - mono HQ - 24 bit
  " (WAV-S32)", // 24 - stereo HQ - 32 bit
  " (WAV-M32)", // 25 - mono HQ - 32 bit
}; */


// Identifying bytes for different file types
static const unsigned char BMP_HEADER[]  = { 77 };
static const unsigned char BZ2_HEADER1[] = { 90, 104 };
static const unsigned char BZ2_HEADER2[] = { 49, 65, 89, 38, 83, 89 };
static const unsigned char DSG_HEADER[]  = { 68, 79, 79, 77, 32 };
static const unsigned char EXE_HEADER[]  = { 90, 144, 0, 3, 0, 0, 0 };
static const unsigned char GZP_HEADER[]  = { 139, 8, 0 };
static const unsigned char HLP_HEADER[]  = { 95, 3, 0 };
static const unsigned char JPG_HEADER1[] = { 216, 255, 224 };
static const unsigned char JPG_HEADER2[] = { 74, 70, 73, 70 };
static const unsigned char MPG_HEADER[]  = { 68, 51, 3 };
static const unsigned char PDF_HEADER[]  = { 80, 68, 70 };
static const unsigned char PGM_HEADER[]  = { 53, 10, 55 };
static const unsigned char PNG_HEADER[]  = { 80, 78, 71, 13, 10, 26, 10 };
static const unsigned char DOC_HEADER[]  = { 207, 17, 224, 161, 177, 26, 225 };
static const unsigned char WAV_HEADER[]  = { 73, 70, 70 };
static const unsigned char ZIP_HEADER[]  = { 75, 3, 4, 20, 0, 2, 0, 8, 0 };


// 8, 16, 32 bit unsigned types (adjust as appropriate)
typedef unsigned char  U8;
typedef unsigned short U16;
typedef unsigned int   U32;


// ----------------------------------------------------------------------------
// Get the unsigned 16-bit value starting at the given position

U16 Peekw(unsigned char *memory)
{
  // U16 result;
  // memcpy(&result,memory,2);
  // return (result);
  U16 lsb = *memory;
  U16 msb = *(memory + 1);
  return ((msb << 8) | lsb);
}

// ----------------------------------------------------------------------------
// Error handler: print message if any, and exit

void quit(const char* message=0)
{
  if (message) printf("%s\n", message);
  exit(1);
}

// ----------------------------------------------------------------------------
// Get the hash multiplier based on the file type

int GetMult(int profile)
{
  int shft = 5;
  if (profile == 2) shft = 6; // BMP
  return (5 << shft);
}


// ----------------------------------------------------------------------------
// Get the number of channels based on the file type (default = 1)

int GetChannels(int profile)
{
  int channels = 1;
       if (profile == 18) channels = 4; // Wave Audio - stereo - 16 bit
  else if (profile == 19) channels = 2; // Wave Audio - mono - 16 bit
  else if (profile == 20) channels = 2; // Wave Audio - stereo - 8 bit
  // else if (profile == 21) channels = 1; // Wave Audio - mono - 8 bit
  else if (profile == 22) channels = 6; // Wave Audio - stereo HQ - 24 bit
  else if (profile == 23) channels = 3; // Wave Audio - mono HQ - 24 bit
  else if (profile == 24) channels = 8; // Wave Audio - stereo HQ - 32 bit
  else if (profile == 25) channels = 4; // Wave Audio - mono HQ - 32 bit
  return channels;
}


// ----------------------------------------------------------------------------
// Create an array p of n elements of type T

template <class T> void alloc(T*&p, int n)
{
  p=(T*)calloc(n, sizeof(T));
  if (!p) quit("out of memory");
}


// ----------------------------------------------------------------------------
// A StateMap maps a secondary context to a probability.  Methods:
//
// Statemap sm(n) creates a StateMap with n contexts using 4*n bytes memory.
// sm.p(cxt) predicts next bit (0..4K-1) in context cxt (0..n-1).
// sm.update(cxt, y) updates model for actual bit y (0..1) in cxt (0..n-1).

class StateMap
{
protected:
  const int N;  // Number of contexts
  U32 *t;       // cxt -> prediction in high 25 bits, count in low 7 bits
  static int dt[128];  // i -> 1K/(i+2)
public:
  StateMap(int n);

  // predict next bit in context cxt
  int p(int cxt)
  {
    assert(cxt>=0 && cxt<N);
    return t[cxt]>>20;
  }

  // update model in context cxt for actual bit y
  void update(int cxt, int y)
  {
    assert(cxt>=0 && cxt<N);
    assert(y==0 || y==1);
    int n=t[cxt]&127, p=t[cxt]>>9;  // count, prediction
    if (n<127) ++t[cxt];
    t[cxt]+=((y<<23)-p)*dt[n]&0xffffff80;
  }
};

int StateMap::dt[128]={0};

StateMap::StateMap(int n): N(n)
{
  alloc(t, N);
  for (int i=0; i<N; ++i)
    t[i]=1<<31;
  if (dt[0]==0)
    for (int i=0; i<128; ++i)
      dt[i]=512/(i+2);
}


// ----------------------------------------------------------------------------
// An Encoder does arithmetic encoding in n contexts.  Methods:
// Encoder(f, n) creates encoder for compression to archive f, which
//     must be open past any header for writing in binary mode.
// code(cxt, y) compresses bit y (0 or 1) to file f
//   modeled in context cxt (0..n-1)
// flush() should be called exactly once after compression is done and
//     before closing f.

class Encoder
{
private:
  const int N;    // number of contexts
  FILE* archive;  // Compressed data file
  U32 x1, x2;     // Range, initially [0, 1), scaled by 2^32
  StateMap sm;    // cxt -> p
public:
  Encoder(FILE* f, int n);
  void code(int cxt, int y);  // compress bit y
  void flush();  // call this when compression is finished
};

// Compress bit y (0..1) in context cxt (0..n-1)
inline void Encoder::code(int cxt, int y)
{
  assert(y==0 || y==1);
  assert(cxt>=0 && cxt<N);
  int p=sm.p(cxt);
  assert(p>=0 && p<4096);
  U32 xmid=x1 + (x2-x1>>12)*p;
  assert(xmid>=x1 && xmid<x2);
  y ? (x2=xmid) : (x1=xmid+1);
  sm.update(cxt, y);
  while (((x1^x2)&0xff000000)==0) {  // pass equal leading bytes of range
    putc(x2>>24, archive);
    x1<<=8;
    x2=(x2<<8)+255;
  }
}

Encoder::Encoder(FILE* f, int n):
  N(n), archive(f), x1(0), x2(0xffffffff), sm(n) {}

void Encoder::flush() {
  putc(x1>>24, archive);  // Flush first unequal byte of range
}


// ----------------------------------------------------------------------------
// Encode a byte c in context cxt to encoder e
void encode(Encoder& e, int cxt, int c) {

  // code high 4 bits in contexts cxt+1..15
  int b=(c>>4)+16;
  e.code(cxt+1     , b>>3&1);
  e.code(cxt+(b>>3), b>>2&1);
  e.code(cxt+(b>>2), b>>1&1);
  e.code(cxt+(b>>1), b   &1);

  // code low 4 bits in one of 16 blocks of 15 cxts (to reduce cache misses)
  cxt+=15*(b-15);
  b=c&15|16;
  e.code(cxt+1     , b>>3&1);
  e.code(cxt+(b>>3), b>>2&1);
  e.code(cxt+(b>>2), b>>1&1);
  e.code(cxt+(b>>1), b   &1);
}


// ----------------------------------------------------------------------------
// Compress from in to out.  out should be positioned past the header.
void compress(FILE *in, FILE *out, int version, int profile)
{
  Encoder e(out, (1024+1024)*258);
  const int cshft = (version == 2)? 24: 20; // Bit shift for context
  const int hmask = (version == 2)? 0xfffff: 0xffffff;  // Hash mask
  const int hmult = GetMult(profile);       // Multiplier for hashes
  const int maxc = GetChannels(profile);       // Number of channels
  int channel = 0;                          // Channel for WAV files
  int c1=0; // previous byte
  U32 *t4;  // context -> last 3 bytes in bits 0..23, count in 24..29
  U32 hc[16];                     // Hash of last 4 bytes by channel

  alloc(t4, 0x1000000);
  memset(hc, 0, sizeof(hc));
  while (1) {
    const U32 h = hc[channel];
    const U32 r=t4[h];  // last byte count, last 3 bytes in this context
    int cxt;  // context
    if (r>=0x4000000) cxt=1024+(r>>cshft);
    else cxt=c1|r>>16&0x3f00;
    cxt*=258;

    int c=getc(in);
    if (c==EOF)
    {  // Mark EOF by coding first match as a literal
      e.code(cxt, 1);
      e.code(cxt+1, 0);
      encode(e, cxt+2, r&0xff);
      break;
    }
    int comp3=c*0x10101^r;  // bytes 0, 1, 2 are 0 if equal
    if (!(comp3&0xff))
    {  // match first?
      e.code(cxt, 0);
      if (r<0x3f000000) t4[h]+=0x1000000;  // increment count
    }
    else if (!(comp3&0xff00)) {  // match second?
      e.code(cxt, 1);
      e.code(cxt+1, 1);
      e.code(cxt+2, 0);
      t4[h]=r&0xff0000|r<<8&0xff00|c|0x1000000;
    }
    else if (!(comp3&0xff0000)) {  // match third?
      e.code(cxt, 1);
      e.code(cxt+1, 1);
      e.code(cxt+2, 1);
      t4[h]=r<<8&0xffff00|c|0x1000000;
    }
    else {  // literal?
      e.code(cxt, 1);
      e.code(cxt+1, 0);
      encode(e, cxt+2, c);
      t4[h]=r<<8&0xffff00|c;
    }
    c1=c;
    hc[channel]=(h*hmult+c+1)&hmask;
    if (++channel>=maxc) channel=0;
  }
  e.flush();
}


// ----------------------------------------------------------------------------
// A Decoder does arithmetic decoding in n contexts.  Methods:
// Decoder(f, n) creates decoder for decompression from archive f,
//     which must be open past any header for reading in binary mode.
// code(cxt) returns the next decompressed bit from file f
//   with context cxt in 0..n-1.

class Decoder {
private:
  const int N;     // number of contexts
  FILE* archive;   // Compressed data file
  U32 x1, x2;      // Range, initially [0, 1), scaled by 2^32
  U32 x;           // Decompress mode: last 4 input bytes of archive
  StateMap sm;     // cxt -> p
public:
  Decoder(FILE* f, int n);
  int code(int cxt);  // decompress a bit
};

// Return decompressed bit (0..1) in context cxt (0..n-1)
inline int Decoder::code(int cxt) {
  assert(cxt>=0 && cxt<N);
  int p=sm.p(cxt);
  assert(p>=0 && p<4096);
  U32 xmid=x1 + (x2-x1>>12)*p;
  assert(xmid>=x1 && xmid<x2);
  int y=x<=xmid;
  y ? (x2=xmid) : (x1=xmid+1);
  sm.update(cxt, y);
  while (((x1^x2)&0xff000000)==0) {  // pass equal leading bytes of range
    x1<<=8;
    x2=(x2<<8)+255;
    x=(x<<8)+(getc(archive)&255);  // EOF is OK
  }
  return y;
}

Decoder::Decoder(FILE* f, int n):
    N(n), archive(f), x1(0), x2(0xffffffff), x(0), sm(n) {
  for (int i=0; i<4; ++i)
    x=(x<<8)+(getc(archive)&255);
}


// ----------------------------------------------------------------------------
// Decode one byte
int decode(Decoder& e, int cxt) {
  int hi=1, lo=1;  // high and low nibbles
  hi+=hi+e.code(cxt+hi);
  hi+=hi+e.code(cxt+hi);
  hi+=hi+e.code(cxt+hi);
  hi+=hi+e.code(cxt+hi);
  cxt+=15*(hi-15);
  lo+=lo+e.code(cxt+lo);
  lo+=lo+e.code(cxt+lo);
  lo+=lo+e.code(cxt+lo);
  lo+=lo+e.code(cxt+lo);
  return hi-16<<4|(lo-16);
}


// ----------------------------------------------------------------------------
// Decompress from in to out.  in should be positioned past the header.
void decompress(FILE *in, FILE *out, int version, int profile) {
  Decoder e(in, (1024+1024)*258);
  const int cshft = (version == 2)? 24: 20; // Bit shift for context
  const int hmask = (version == 2)? 0xfffff: 0xffffff;  // Hash mask
  const int hmult = GetMult(profile);       // Multiplier for hashes
  const int maxc = GetChannels(profile);       // Number of channels
  int channel = 0;                          // Channel for WAV files
  int c1=0; // previous byte
  U32 *t4;  // context -> last 3 bytes in bits 0..23, count in 24..29
  U32 hc[16];                     // Hash of last 4 bytes by channel

  alloc(t4, 0x1000000);
  memset(hc, 0, sizeof(hc));
  while (1) {
    const U32 h = hc[channel];
    const U32 r=t4[h];  // last byte count, last 3 bytes in this context
    int cxt;  // context

    if (r>=0x4000000) cxt=1024+(r>>cshft);
    else cxt=c1|r>>16&0x3f00;
    cxt*=258;

    // Decompress: 0=p[1], 110=p[2], 111=p[3], 10xxxxxxxx=literal.
    // EOF is marked by p[1] coded as a literal.
    if (e.code(cxt)) {
      if (e.code(cxt+1)) {
        if (e.code(cxt+2)) {  // match third?
          c1=r>>16&0xff;
          t4[h]=r<<8&0xffff00|c1|0x1000000;
        }
        else {  // match second?
          c1=r>>8&0xff;
          t4[h]=r&0xff0000|r<<8&0xff00|c1|0x1000000;
        }
      }
      else {  // literal?
        c1=decode(e, cxt+2);
        if (c1==int(r&0xff)) break;  // EOF?
        t4[h]=r<<8&0xffff00|c1;
      }
    }
    else {  // match first?
      c1=r&0xff;
      if (r<0x3f000000) t4[h]+=0x1000000;  // increment count
    }
    putc(c1, out);
    hc[channel]=(h*hmult+c1+1)&hmask;
    if (++channel >= maxc) channel=0;
  }
}


// ----------------------------------------------------------------------------
// Detect type of file to be compressed
int DetectFile(unsigned char *buffer)
{
  int profile=0;
  switch (*buffer) {
    case 77:
      if (memcmp(buffer+1, EXE_HEADER, sizeof(EXE_HEADER)) == 0) profile = 4; // EXE
      break;
    case 37:
      if (memcmp(buffer+1, PDF_HEADER, sizeof(PDF_HEADER)) == 0) profile = 7; // PDF
      break;
    case 255:
      if ((memcmp(buffer+1, JPG_HEADER1, sizeof(JPG_HEADER1)) == 0) &&
          (memcmp(buffer+6, JPG_HEADER2, sizeof(JPG_HEADER2)) == 0)) profile = 8; // JPG
      break;
    case 73:
      if (memcmp(buffer+1, MPG_HEADER, sizeof(MPG_HEADER)) == 0) profile = 13; // MPEG audio
      break;
    case 82:
      if (memcmp(buffer+1, WAV_HEADER, sizeof(WAV_HEADER)) == 0) {
        U16 w22 = Peekw(buffer+22);
        U16 w34 = Peekw(buffer+34);
        profile=18; // wave stereo 16 bit (default)
        if (w22 == 1) {
               if (w34 ==  8) profile=21; // wave mono 8 bit
          else if (w34 == 16) profile=19; // wave mono 16 bit
          else if (w34 == 24) profile=23; // wave stereo 24 bit
          else if (w34 == 32) profile=25; // wave stereo 32 bit
        }
        else if (w22 >= 2) {
               if (w34 ==  8) profile=20; // wave stereo 8 bit
          else if (w34 == 24) profile=22; // wave stereo 24 bit
          else if (w34 == 32) profile=24; // wave stereo 32 bit
        }
      }
      break;
    case 137:
      if (memcmp(buffer+1, PNG_HEADER, sizeof(PNG_HEADER)) == 0) profile = 15; // PNG
      break;
    case 63:
      if (memcmp(buffer+1, HLP_HEADER, sizeof(HLP_HEADER)) == 0) profile = 5; // HLP
      break;
    case 6:
      if (memcmp(buffer+4, DSG_HEADER, sizeof(DSG_HEADER)) == 0) profile = 12; // save doom3
      break;
    case 208:
      if (memcmp(buffer+1, DOC_HEADER, sizeof(DOC_HEADER)) == 0) profile = 14; // DOC
      break;
    case 80:
      if (memcmp(buffer+1, ZIP_HEADER, sizeof(ZIP_HEADER)) == 0) profile = 6;  // ZIP
      else
      if (memcmp(buffer+1, PGM_HEADER, sizeof(PGM_HEADER)) == 0) profile = 11; // PGM image
      break;
    case 66:
      if (memcmp(buffer+1, BMP_HEADER, sizeof(BMP_HEADER)) == 0) profile = 2; // BMP
      else
      if ((memcmp(buffer+1, BZ2_HEADER1, sizeof(BZ2_HEADER1)) == 0) &&
          (memcmp(buffer+4, BZ2_HEADER2, sizeof(BZ2_HEADER2)) == 0)) profile = 17; // BZIP2
      break;
    case 31:
      if (memcmp(buffer+1, GZP_HEADER, sizeof(GZP_HEADER)) == 0) profile = 16; // GZIP
      break;
  }

  return profile;
}


// ----------------------------------------------------------------------------
// Get the profile from a file created by the original sr3 program
int GetSR3Profile(FILE *in)
{
  char sr3profile[4];
  int  profile = 0;
  int  count = 0;

  fread(sr3profile, 1, 4, in);

  // Find non-zero byte if any
  while ((sr3profile[count] == 0) && (++count < 3));
  profile = sr3profile[count];

  // Swap profile 11 and 18 from original sr3 format
  if (profile == 11) profile = 18;
  else if (profile == 18) profile = 11;

  return profile;
}


// ----------------------------------------------------------------------------
// User interface.  Args are input and output file.
int main(int argc, char **argv)
{
  unsigned char buffer[64];
  char *options;
  int profile = 0;
  int version = 3;
  FILE *in;
  FILE *out;

  printf
    (
      "SR3a, copyright Matt Mahoney & contributors. See license.txt\n"
      );
  // Check arguments
  if (argc!=4)
  {
    printf
    (
      "To   compress: sr3 c input output\n"
      "   or for sr2: sr3 c2 input output\n"
      "To decompress: sr3 d input output\n"
      " or for sr2/3: sr3 d3 input output\n"
      );
    return 1;
  }

  // Get start time
  //clock_t start=clock();

  // Compress
  options = argv[1];
  if (options[0] == 'c' )
  {
    if (!options[1] || (options[1] == '3'))
      version = 3;
    else if (options[1] == '2')
      version = 2;
    else
      quit("Can only create sr2 or sr3 format archives");

    in=fopen(argv[2], "rb");
    if (!in) perror(argv[1]), exit(1);
    out=fopen(argv[3], "wb");
    if (!out) perror(argv[2]), exit(1);
    fprintf(out, "sR%c", version);
    if (version == 3) {
      fread(buffer, 1, 64, in);
      rewind(in);
      profile = DetectFile(buffer);
      fputc(profile, out);
    }
    compress(in, out, version, profile);
    
  }
  else
  {
    // Decompress
    in=fopen(argv[2], "rb");
    if (!in) perror(argv[2]), exit(1);
    if (getc(in)!='s' || getc(in)!='R') quit("Not an SR2 or SR3 file");
    version = getc(in);
    if (version == 3)
      profile = getc(in);
    else if (version != 2)
      quit("Not an SR2 or SR3 file");
    else if (options[1] != '3')
      profile = 0; // Use default profile for sr2
    else {
      profile = GetSR3Profile(in);
      version = 3;
    }
    if (profile > MAX_PROFILE) quit("Not an SR3 file");

    out=fopen(argv[3], "wb");
    if (!out) perror(argv[3]), exit(1);
    decompress(in, out, version, profile);

  }
  // Report result
  //printf("%s%s: %ld -> %ld in %1.2f sec.\n",
  //       argv[2], profiles[profile],
  //       ftell(in), ftell(out),
  //       double(clock()-start)/CLOCKS_PER_SEC);
  printf("done.");
  fclose(in);
  fclose(out);
  
  if (remove(argv[2]) != 0)
  {
        printf("Could not remove %s\n", argv[2]);
        perror("Error: ");
  }
    
  return 0;
}
