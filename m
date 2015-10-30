From: Leonid V. Fedorenchik <Leonid.Fedorenchik@paragon-software.com>
Date: Fri, 30 Oct 2015 12:21:14 +0300
Subject: [LTP]  [PATCH] fs/ftest: Add printing of inode stats
Message-ID: <1446196874-14060-1-git-send-email-Leonid.Fedorenchik@paragon-software.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add printing of inode's size and number. These fields are helpful
during debugging.

In ftest01.c also changed s/TFAIL/TINFO/ to unify output with the
other tests.

Signed-off-by: Leonid V. Fedorenchik <Leonid.Fedorenchik@paragon-software.com>
---
 testcases/kernel/fs/ftest/ftest01.c | 17 +++++++++++++----
 testcases/kernel/fs/ftest/ftest03.c |  9 +++++++++
 testcases/kernel/fs/ftest/ftest04.c |  9 +++++++++
 testcases/kernel/fs/ftest/ftest05.c | 13 +++++++++++--
 testcases/kernel/fs/ftest/ftest07.c | 13 +++++++++++--
 testcases/kernel/fs/ftest/ftest08.c |  9 +++++++++
 6 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index d3390f0..f4fcd60 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -262,6 +262,7 @@ static void dotest(int testers, int me, int fd)
 	char *bits, *hold_bits, *buf, *val_buf, *zero_buf;
 	char val;
 	int count, collide, chunk, whenmisc, xfr, i;
+	struct stat stat;
 
 	nchunks = max_size / csize;
 
@@ -367,9 +368,13 @@ static void dotest(int testers, int me, int fd)
 						 "count %d xfr %d file_max 0x%x, should be %d.",
 						 me, CHUNK(chunk), val, count,
 						 xfr, file_max, zero_buf[0]);
-					tst_resm(TFAIL,
-						 "Test[%d]: last_trunc = 0x%x.",
+					tst_resm(TINFO,
+						 "Test[%d]: last_trunc = 0x%x",
 						 me, last_trunc);
+					fstat(fd, &stat);
+					tst_resm(TINFO,
+						 "\tStat: size=%llx, ino=%x",
+						 stat.st_size, (unsigned)stat.st_ino);
 					sync();
 					ft_dumpbuf(buf, csize);
 					ft_dumpbits(bits, (nchunks + 7) / 8);
@@ -396,9 +401,13 @@ static void dotest(int testers, int me, int fd)
 						 "count %d xfr %d file_max 0x%x.",
 						 me, CHUNK(chunk), val, count,
 						 xfr, file_max);
-					tst_resm(TFAIL,
-						 "Test[%d]: last_trunc = 0x%x.",
+					tst_resm(TINFO,
+						 "Test[%d]: last_trunc = 0x%x",
 						 me, last_trunc);
+					fstat(fd, &stat);
+					tst_resm(TINFO,
+						 "\tStat: size=%llx, ino=%x",
+						 stat.st_size, (unsigned)stat.st_ino);
 					sync();
 					ft_dumpbuf(buf, csize);
 					ft_dumpbits(bits, (nchunks + 7) / 8);
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index 10e2a4a..9dc47c9 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -295,6 +295,7 @@ static void dotest(int testers, int me, int fd)
 	struct iovec val_iovec[MAXIOVCNT];
 	struct iovec zero_iovec[MAXIOVCNT];
 	int w_ioveclen;
+	struct stat stat;
 
 	nchunks = max_size / csize;
 	whenmisc = 0;
@@ -439,6 +440,10 @@ static void dotest(int testers, int me, int fd)
 						tst_resm(TINFO,
 							 "\tTest[%d]: last_trunc = 0x%x.",
 							 me, last_trunc);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						sync();
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
@@ -473,6 +478,10 @@ static void dotest(int testers, int me, int fd)
 						tst_resm(TINFO,
 							 "\tTest[%d]: last_trunc = 0x%x.",
 							 me, last_trunc);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						sync();
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
diff --git a/testcases/kernel/fs/ftest/ftest04.c b/testcases/kernel/fs/ftest/ftest04.c
index c00fdfc..f2b1a61 100644
--- a/testcases/kernel/fs/ftest/ftest04.c
+++ b/testcases/kernel/fs/ftest/ftest04.c
@@ -232,6 +232,7 @@ static void dotest(int testers, int me, int fd)
 	struct iovec val0_iovec[MAXIOVCNT];
 	struct iovec val_iovec[MAXIOVCNT];
 	int w_ioveclen;
+	struct stat stat;
 
 	nchunks = max_size / (testers * csize);
 	whenmisc = 0;
@@ -361,6 +362,10 @@ static void dotest(int testers, int me, int fd)
 							 "\tTest[%d] bad verify @ 0x%x for val %d count %d xfr %d.",
 							 me, CHUNK(chunk), val0,
 							 count, xfr);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
 							    (nchunks + 7) / 8);
@@ -386,6 +391,10 @@ static void dotest(int testers, int me, int fd)
 							 "\tTest[%d] bad verify @ 0x%x for val %d count %d xfr %d.",
 							 me, CHUNK(chunk), val,
 							 count, xfr);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
 							    (nchunks + 7) / 8);
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 13ae676..fe3145c 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -264,6 +264,7 @@ static void dotest(int testers, int me, int fd)
 	int i, count, collide, chunk, whenmisc, xfr;
 	char *bits, *hold_bits, *buf, *val_buf, *zero_buf;
 	char val;
+	struct stat stat;
 
 	nchunks = max_size / csize;
 
@@ -362,8 +363,12 @@ static void dotest(int testers, int me, int fd)
 						 me, CHUNK(chunk), val, count,
 						 xfr, file_max, zero_buf[0]);
 					tst_resm(TINFO,
-						 "\tTest[%d]: last_trunc = 0x%x.",
+						 "\tTest[%d]: last_trunc = 0x%x",
 						 me, last_trunc);
+					fstat(fd, &stat);
+					tst_resm(TINFO,
+						 "\tStat: size=%llx, ino=%x",
+						 stat.st_size, (unsigned)stat.st_ino);
 					sync();
 					ft_dumpbuf(buf, csize);
 					ft_dumpbits(bits, (nchunks + 7) / 8);
@@ -389,8 +394,12 @@ static void dotest(int testers, int me, int fd)
 						 me, CHUNK(chunk), val, count,
 						 xfr, file_max);
 					tst_resm(TINFO,
-						 "\tTest[%d]: last_trunc = 0x%x.",
+						 "\tTest[%d]: last_trunc = 0x%x",
 						 me, last_trunc);
+					fstat(fd, &stat);
+					tst_resm(TINFO,
+						 "\tStat: size=%llx, ino=%x",
+						 stat.st_size, (unsigned)stat.st_ino);
 					sync();
 					ft_dumpbuf(buf, csize);
 					ft_dumpbits(bits, (nchunks + 7) / 8);
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index a6f36ec..ff85202 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -292,6 +292,7 @@ static void dotest(int testers, int me, int fd)
 
 	struct iovec zero_iovec[MAXIOVCNT];
 	int w_ioveclen;
+	struct stat stat;
 
 	nchunks = max_size / csize;
 	whenmisc = 0;
@@ -428,8 +429,12 @@ static void dotest(int testers, int me, int fd)
 							 me, CHUNK(chunk), val,
 							 count, xfr, file_max);
 						tst_resm(TINFO,
-							 "\tTest[%d]: last_trunc = 0x%x.",
+							 "\tTest[%d]: last_trunc = 0x%x",
 							 me, last_trunc);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						sync();
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
@@ -462,8 +467,12 @@ static void dotest(int testers, int me, int fd)
 							 me, CHUNK(chunk), val,
 							 count, xfr, file_max);
 						tst_resm(TINFO,
-							 "\tTest[%d]: last_trunc = 0x%x.",
+							 "\tTest[%d]: last_trunc = 0x%x",
 							 me, last_trunc);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						sync();
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
diff --git a/testcases/kernel/fs/ftest/ftest08.c b/testcases/kernel/fs/ftest/ftest08.c
index 7970ab9..39ba196 100644
--- a/testcases/kernel/fs/ftest/ftest08.c
+++ b/testcases/kernel/fs/ftest/ftest08.c
@@ -239,6 +239,7 @@ static void dotest(int testers, int me, int fd)
 	struct iovec val0_iovec[MAXIOVCNT];
 	struct iovec val_iovec[MAXIOVCNT];
 	int w_ioveclen;
+	struct stat stat;
 
 	nchunks = max_size / (testers * csize);
 	whenmisc = 0;
@@ -370,6 +371,10 @@ static void dotest(int testers, int me, int fd)
 							 " for val %d count %d xfr %d.",
 							 me, CHUNK(chunk), val0,
 							 count, xfr);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
 							    (nchunks + 7) / 8);
@@ -397,6 +402,10 @@ static void dotest(int testers, int me, int fd)
 							 " for val %d count %d xfr %d.",
 							 me, CHUNK(chunk), val,
 							 count, xfr);
+						fstat(fd, &stat);
+						tst_resm(TINFO,
+							 "\tStat: size=%llx, ino=%x",
+							 stat.st_size, (unsigned)stat.st_ino);
 						ft_dumpiov(&r_iovec[i]);
 						ft_dumpbits(bits,
 							    (nchunks + 7) / 8);
-- 
2.5.0.474.g3a9835b

