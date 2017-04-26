From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Apr 2017 12:19:29 +0200
Subject: [LTP] [PATCH] mmapstress04: rewrite to fix heap overwrite
Message-ID: <ed1531bad36a25628f7737b9975ed5b4a92922f1.1493201294.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test was using sbrk() to position MAP_FIXED mappings, which
creates problems when something extends heap prior to test.
For example:

sbrk(0) is 0x13d8000
heap is extended in call to tst_tmpdir()
  mkdir("/tmp/mmaXIz1uo", 0700) = 0
  brk(0)                  = 0x13d8000
  brk(0x13f9000)          = 0x13f9000
  brk(0)                  = 0x13f9000
test starts mapping/writing to areas it shouldn't:
  mmap(0x13de000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED, 3, 0x8000) = 0x13de000
  mmap(0x13e5000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED, 3, 0xa000) = 0x13e5000
  mmap(0x13ea000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED, 3, 0xa000) = 0x13ea000
which results in crash:
  Program received signal SIGSEGV, Segmentation fault.
  0x00007ffff7aa57a0 in __memset_sse2 () from /lib64/libc.so.6
  Missing separate debuginfos, use: debuginfo-install glibc-2.17-161.el7.x86_64
  (gdb) bt
  #0  0x00007ffff7aa57a0 in __memset_sse2 () from /lib64/libc.so.6
  #1  0x00007ffff7a99ba2 in _int_malloc () from /lib64/libc.so.6
  #2  0x00007ffff7a9bfbc in malloc () from /lib64/libc.so.6
  #3  0x00007ffff7ad65c1 in __alloc_dir () from /lib64/libc.so.6
  #4  0x00000000004031d8 in rmobj (obj=0x61e010 "/tmp/mmaLheQvJ", errmsg=errmsg@entry=0x7fffffffe0f8) at tst_tmpdir.c:145
  #5  0x00000000004038cd in tst_rmdir () at tst_tmpdir.c:335
  #6  0x0000000000402cf6 in main (argc=<optimized out>, argv=0x7fffffffe328) at mmapstress04.c:278

This patch rewrites test in newlib style. It also drops initial
offset parameter as it isn't used by any runtest. LARGE_FILE
ifdefs have been dropped as we can easily enable _64 build
if needed.

Mapping file as MAP_FIXED doesn't seem to be necessary, but I decided
to adhere to original.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mmapstress/mmapstress04.c | 420 ++++++++-----------------
 1 file changed, 130 insertions(+), 290 deletions(-)
 rewrite testcases/kernel/mem/mmapstress/mmapstress04.c (91%)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress04.c b/testcases/kernel/mem/mmapstress/mmapstress04.c
dissimilarity index 91%
index d7641f96541e..1752ef5e9236 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress04.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress04.c
@@ -1,290 +1,130 @@
-/* IBM Corporation */
-/* 01/02/2003	Port to LTP avenkat@us.ibm.com	*/
-/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
-
-/*
- *   Copyright (c) International Business Machines  Corp., 2003
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * weave:
- *	Mmap parts of a file, and then write to the file causing single
- *	write requests to jump back and forth between mmaped io and regular io.
- *
- *	Usage: weave filename startoffset. pageoffset = 4096.
- *
- *	startoffset specifies a byte count in the file at which to begin
- *	the test.  When this value is non-zero, a sparse file is created.
- *	This is useful for testing with large files.
- *
- *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
- */
-
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-/*****	LTP Port	*****/
-#include "test.h"
-#define FAILED 0
-#define PASSED 1
-/*****	**	**	*****/
-
-#define CLEAN	(void)close(rofd); \
-		(void)close(rwfd); \
-		(void)unlink(filename);
-#define ERROR(M)	(void)fprintf(stderr, "%s:  errno = %d; " M "\n", \
-				argv[0], errno)
-#define CLEANERROR(M)	CLEAN; ERROR(M)
-#define CATCH_SIG(SIG) \
-        if (sigaction(SIG, &sa, 0) == -1) { \
-                ERROR("couldn't catch signal " #SIG); \
-                exit(1); \
-        }
-
-static char *filename;
-
-/*****	LTP Port	*****/
-char *TCID = "mmapstress04";	//weave
-int local_flag = PASSED;
-int block_number;
-FILE *temp;
-int TST_TOTAL = 1;
-
-int anyfail();
-int blenter();
-int blexit();
-int instress();
-void setup();
-void terror();
-void fail_exit();
-void ok_exit();
-/*****	**	**	*****/
-
-extern time_t time(time_t *);
-extern char *ctime(const time_t *);
-extern void exit(int);
-static int rofd, rwfd;
-
- /*ARGSUSED*/ static
-void cleanup(int sig)
-{
-	/*
-	 * Don't check error codes - we could be signaled before the file is
-	 * created.
-	 */
-	(void)close(rofd);
-	(void)close(rwfd);
-	(void)unlink(filename);
-	exit(1);
-}
-
-int main(int argc, char *argv[])
-{
-	char *buf;
-	size_t pagesize = (size_t) sysconf(_SC_PAGE_SIZE);
-	caddr_t mmapaddr;
-	time_t t;
-	int i, j;
-	struct sigaction sa;
-#ifdef LARGE_FILE
-	off64_t startoffset;
-	off64_t seekoff;
-	off64_t mapoff;
-#else /* LARGE_FILE */
-	off_t startoffset;
-	off_t seekoff;
-	off_t mapoff;
-#endif /* LARGE_FILE */
-
-	if (argc < 2 || argc > 3) {
-		(void)fprintf(stderr, "Usage: %s filename startoffset\n",
-			      argv[0]);
-		return 1;
-	}
-	filename = argv[1];
-
-	if (argc >= 3) {
-#ifdef LARGE_FILE
-		startoffset = atoll(argv[2]);
-#else /* LARGE_FILE */
-		startoffset = atoi(argv[2]);
-#endif /* LARGE_FILE */
-	} else
-		startoffset = pagesize;
-
-	if (startoffset % pagesize != 0) {
-		fprintf(stderr, "pagesize=%ld\n", (long)pagesize);
-		fprintf(stderr, "startoffset must be a pagesize multiple\n");
-		anyfail();	//LTP Port
-	}
-	(void)time(&t);
-//      (void)printf("%s: Started %s", argv[0], ctime(&t));
-	if ((buf = sbrk(6 * pagesize)) == (char *)-1) {
-		ERROR("couldn't allocate buf");
-		anyfail();	//LTP Port
-	}
-	if (sbrk(pagesize - ((ulong) sbrk(0) & (pagesize - 1))) == (char *)-1) {
-		ERROR("couldn't round up brk");
-		anyfail();	//LTP Port
-	}
-	if ((mmapaddr = (caddr_t) sbrk(0)) == (caddr_t) - 1) {
-		ERROR("couldn't find top of brk");
-		anyfail();	//LTP Port
-	}
-	sa.sa_handler = cleanup;
-	sa.sa_flags = 0;
-	if (sigemptyset(&sa.sa_mask)) {
-		ERROR("sigemptyset failed");
-		anyfail();	//LTP Port
-	}
-	CATCH_SIG(SIGINT);
-	CATCH_SIG(SIGQUIT);
-	CATCH_SIG(SIGTERM);
-	tst_tmpdir();
-#ifdef LARGE_FILE
-	if ((rofd = open64(filename, O_RDONLY | O_CREAT, 0777)) == -1) {
-#else /* LARGE_FILE */
-	if ((rofd = open(filename, O_RDONLY | O_CREAT, 0777)) == -1) {
-#endif /* LARGE_FILE */
-		ERROR("read only open failed");
-		anyfail();	//LTP Port
-	}
-#ifdef LARGE_FILE
-	if ((rwfd = open64(filename, O_RDWR)) == -1) {
-#else /* LARGE_FILE */
-	if ((rwfd = open(filename, O_RDWR)) == -1) {
-#endif /* LARGE_FILE */
-		(void)close(rofd);
-		(void)unlink(filename);
-		ERROR("read/write open failed");
-		anyfail();	//LTP Port
-	}
-#ifdef LARGE_FILE
-	seekoff = startoffset + (off64_t) 64 *(off64_t) 6 *(off64_t) pagesize;
-	if (lseek64(rwfd, seekoff, SEEK_SET) != seekoff) {
-#else /* LARGE_FILE */
-	seekoff = startoffset + (off_t) 64 *(off_t) 6 *(off_t) pagesize;
-	if (lseek(rwfd, seekoff, SEEK_SET) != seekoff) {
-#endif /* LARGE_FILE */
-		CLEANERROR("first lseek failed");
-		anyfail();	//LTP Port
-	}
-	i = 0;
-	while (i < pagesize && write(rwfd, "b", 1) == 1)
-		i++;
-	if (i != pagesize) {
-		CLEANERROR("write to extend file failed");
-		anyfail();	//LTP Port
-	}
-	/* The file is now really big, and empty.
-	 * Assuming disk blocks are 8k, and logical pages are 4k, there are
-	 * two maps per page.  In order to test mapping at the beginning and
-	 * ends of the block, mapping the whole block, or none of the block
-	 * with different mappings on preceding and following blocks, each
-	 * 3 blocks with 6 pages can be thought of as a binary number from 0 to
-	 * 64 with a bit set for mapped or cleared for unmapped.  This number
-	 * is represented by i.  The value j is used to look at the bits of i
-	 * and decided to map the page or not.
-	 * NOTE: None of the above assumptions are critical.
-	 */
-	for (i = 0; i < 64; i++) {
-		for (j = 0; j < 6; j++) {
-			if (i & (1 << j)) {
-#ifdef LARGE_FILE
-				mapoff = startoffset +
-				    (off64_t) pagesize *(off64_t) (6 + i + j);
-				if (mmap64(mmapaddr + pagesize * (6 * i + j),
-					   pagesize, PROT_READ,
-					   MAP_FILE | MAP_PRIVATE | MAP_FIXED,
-					   rofd, mapoff)
-				    == (caddr_t) - 1) {
-#else /* LARGE_FILE */
-				mapoff = startoffset +
-				    (off_t) pagesize *(off_t) (6 + i + j);
-				if (mmap(mmapaddr + pagesize * (6 * i + j),
-					 pagesize, PROT_READ,
-					 MAP_FILE | MAP_PRIVATE | MAP_FIXED,
-					 rofd, mapoff)
-				    == (caddr_t) - 1) {
-#endif /* LARGE_FILE */
-					CLEANERROR("mmap failed");
-					anyfail();	//LTP Port
-				}
-			}
-		}
-	}
-	/* done mapping */
-	for (i = 0; i < 6 * pagesize; i++)
-		buf[i] = 'a';
-	/* write out 6 pages of stuff into each of the 64 six page sections */
-#ifdef LARGE_FILE
-	if (lseek64(rwfd, startoffset, SEEK_SET) != startoffset) {
-#else /* LARGE_FILE */
-	if (lseek(rwfd, startoffset, SEEK_SET) != startoffset) {
-#endif /* LARGE_FILE */
-		CLEANERROR("second lseek failed");
-		anyfail();	//LTP Port
-	}
-	for (i = 0; i < 64; i++) {
-		if (write(rwfd, buf, 6 * pagesize) != 6 * pagesize) {
-			CLEANERROR("write failed");
-			anyfail();	//LTP Port
-		}
-	}
-	/* Just finished scribbling all over interwoven mmapped and unmapped
-	 * regions.
-	 */
-	for (i = 0; i < 64; i++) {
-		for (j = 0; j < 6; j++) {
-			/* if mmaped && not updated */
-			if ((i & (1 << j))
-			    && *(mmapaddr + pagesize * (6 * i + j)) != 'a') {
-				CLEANERROR("'a' missing from mmap");
-				(void)fprintf(stderr, "i=%d\nj=%d\n"
-					      "val=0x%x\n", i, j,
-					      (int)(*
-						    (mmapaddr +
-						     pagesize * (6 * i + j))));
-				anyfail();	//LTP Port
-			}
-		}
-	}
-	/* Just checked to see that each mmapped page@least had an 'a' at
-	 * the beginning.
-	 */
-	CLEAN;
-	(void)time(&t);
-//      (void)printf("%s: Finished %s", argv[0], ctime(&t)); LTP Port
-	(local_flag == FAILED) ? tst_resm(TFAIL, "Test failed\n") : tst_resm(TPASS, "Test passed\n");	//LTP Port
-	tst_rmdir();
-	tst_exit();		//LTP Port
-
-	tst_exit();
-}
-
-/*****	LTP Port	*****/
-int anyfail(void)
-{
-	tst_brkm(TFAIL, tst_rmdir, "Test failed\n");
-}
-
-/*****	**	**	*****/
+/*
+ * Copyright (c) 2017 Red Hat, Inc.
+ * 01/02/2003	Port to LTP avenkat@us.ibm.com
+ * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Mmap parts of a file, and then write to the file causing single
+ * write requests to jump back and forth between mmaped io and regular io.
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+#define NUM_PAGES (64*8)
+#define TEST_FILE "mmapstress04-testfile"
+
+static int page_size;
+static unsigned char *mmap_area;
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	/*
+	 * Pick large enough area, PROT_NONE doesn't matter,
+	 * because we remap it later.
+	 */
+	mmap_area = SAFE_MMAP(NULL, page_size * NUM_PAGES, PROT_NONE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+}
+
+static void write_fully(int fd, void *buf, int len)
+{
+	do {
+		len -= SAFE_WRITE(0, fd, buf, len);
+	} while (len > 0);
+}
+
+static void mmapstress04(void)
+{
+	int i, j, rofd, rwfd, ret = 0;
+	char *buf;
+
+	if (tst_fill_file(TEST_FILE, 'b', page_size, 1))
+		tst_brk(TBROK | TERRNO, "fill_file");
+
+	rofd = SAFE_OPEN(TEST_FILE, O_RDONLY | O_CREAT, 0777);
+	/*
+	 * Assuming disk blocks are 8k, and logical pages are 4k, there are
+	 * two maps per page. In order to test mapping at the beginning and
+	 * ends of the block, mapping the whole block, or none of the block
+	 * with different mappings on preceding and following blocks, each
+	 * 3 blocks with 6 pages can be thought of as a binary number from 0 to
+	 * 64 with a bit set for mapped or cleared for unmapped. This number
+	 * is represented by i. The value j is used to look at the bits of i
+	 * and decided to map the page or not.
+	 * NOTE: None of the above assumptions are critical.
+	 */
+	for (i = 0; i < 64; i++) {
+		for (j = 0; j < 6; j++) {
+			off_t mapoff;
+
+			if (!(i & (1 << j)))
+				continue;
+
+			mapoff = page_size * (off_t)(6 + i + j);
+			SAFE_MMAP(mmap_area + page_size * (6 * i + j),
+				 page_size, PROT_READ,
+				 MAP_FILE | MAP_PRIVATE | MAP_FIXED,
+				 rofd, mapoff);
+		}
+	}
+	SAFE_CLOSE(rofd);
+
+	/* write out 6 pages of stuff into each of the 64 six page sections */
+	rwfd = SAFE_OPEN(TEST_FILE, O_RDWR);
+	buf = SAFE_MALLOC(page_size);
+	memset(buf, 'a', page_size);
+	for (i = 0; i < 6 * 64; i++)
+		write_fully(rwfd, buf, page_size);
+	free(buf);
+	SAFE_CLOSE(rwfd);
+
+	/*
+	 * Just finished scribbling all over interwoven mmapped and unmapped
+	 * regions. Check the data.
+	 */
+	for (i = 0; i < 64; i++) {
+		for (j = 0; j < 6; j++) {
+			unsigned char val;
+
+			if (!(i & (1 << j)))
+				continue;
+
+			val = *(mmap_area + page_size * (6 * i + j));
+			if (val != 'a') {
+				tst_res(TFAIL, "unexpected value in map, "
+					"i=%d,j=%d,val=0x%x", i, j, val);
+				ret = 1;
+				goto done;
+			}
+		}
+	}
+done:
+	tst_res(ret ? TFAIL : TPASS, "blocks have expected data");
+
+	SAFE_UNLINK(TEST_FILE);
+}
+
+static struct tst_test test = {
+	.tid = "mmapstress04",
+	.needs_tmpdir = 1,
+	.test_all = mmapstress04,
+	.setup = setup,
+};
-- 
1.8.3.1

