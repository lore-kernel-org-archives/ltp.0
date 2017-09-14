From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Sep 2017 11:01:03 +0200
Subject: [LTP] [PATCH] [COMMITTED] Smash size_t and off_t printf()
	formatting mistakes
Message-ID: <20170914090103.21218-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes bunch of warnings when LTP is compiled for 32bit where size_t
and ssize_t are 32bit but off_t is 64 bit.

Here is a simple guide how to print size_t and off_t:

* size_t -> %zu
* ssize_t -> %zi or %zd
* off_t -> %li + cast to (long)

Common mistake is to print the st_size from struct stat with %zu but
st_size is defined as off_t. Also don't forget that sizeof(foo) returns
size_t.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_safe_sysv_ipc.c                            |  2 +-
 testcases/cve/stack_clash.c                        |  2 +-
 testcases/kernel/hotplug/memory_hotplug/segment.c  |  6 ++---
 testcases/kernel/io/direct_io/diotest6.c           |  4 ++--
 testcases/kernel/syscalls/fstat/fstat02.c          |  4 ++--
 testcases/kernel/syscalls/ftruncate/ftruncate04.c  |  4 ++--
 .../syscalls/memfd_create/memfd_create_common.c    | 28 +++++++++++-----------
 .../syscalls/mq_timedreceive/mq_timedreceive01.c   |  4 ++--
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |  2 +-
 testcases/kernel/syscalls/open/open14.c            |  6 ++---
 testcases/kernel/syscalls/openat/openat03.c        |  6 ++---
 testcases/kernel/syscalls/preadv/preadv01.c        |  4 ++--
 testcases/kernel/syscalls/pwritev/pwritev01.c      |  4 ++--
 testcases/kernel/syscalls/stat/stat01.c            |  4 ++--
 14 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
index b2b132b53..ff53a2420 100644
--- a/lib/tst_safe_sysv_ipc.c
+++ b/lib/tst_safe_sysv_ipc.c
@@ -87,7 +87,7 @@ int safe_shmget(const char *file, const int lineno, key_t key, size_t size,
 
 	rval = shmget(key, size, shmflg);
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: shmget(%i, %li, %x) failed",
+		tst_brk(TBROK | TERRNO, "%s:%d: shmget(%i, %zu, %x) failed",
 			file, lineno, (int)key, size, shmflg);
 	}
 
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 2d2984824..49c45ef74 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -84,7 +84,7 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
 		diff = mapped_addr - fault_addr;
 
 	tst_res(TINFO,
-		"mmap = [%lx, %lx), addr = %lx, diff = %lx, THRESHOLD = %lx",
+		"mmap = [%lx, %lx), addr = %lx, diff = %zx, THRESHOLD = %lx",
 		mapped_addr, mmap_end, fault_addr, diff, THRESHOLD);
 	if (diff < 0 || (unsigned long)diff < THRESHOLD)
 		_exit(EXIT_FAILURE);
diff --git a/testcases/kernel/hotplug/memory_hotplug/segment.c b/testcases/kernel/hotplug/memory_hotplug/segment.c
index c79cf433e..62ccd81f9 100644
--- a/testcases/kernel/hotplug/memory_hotplug/segment.c
+++ b/testcases/kernel/hotplug/memory_hotplug/segment.c
@@ -588,13 +588,13 @@ static int show_one_segment(segment_t * segp, bool header)
 		puts(segment_header);
 
 	if (segp->seg_start != MAP_FAILED) {
-		printf("%c 0x%p 0x%012lx 0x%012lx  %s  %s %s\n",
+		printf("%c 0x%p 0x%012zx 0x%012lx  %s  %s %s\n",
 		       seg_type[segp->seg_type],
 		       segp->seg_start,
 		       segp->seg_length,
 		       segp->seg_offset, protection, share, name);
 	} else {
-		printf("%c *** not-mapped *** 0x%012lx 0x%012lx  %s  %s %s\n",
+		printf("%c *** not-mapped *** 0x%012zx 0x%012lx  %s  %s %s\n",
 		       seg_type[segp->seg_type],
 		       segp->seg_length,
 		       segp->seg_offset, protection, share, name);
@@ -943,7 +943,7 @@ int segment_location(char *name, range_t * range)
 		node = get_node(apage);
 		if (node < 0) {
 			fprintf(stderr, "\n%s:  "
-				"failed to get node for segment %s, offset 0x%lx\n",
+				"failed to get node for segment %s, offset 0x%x\n",
 				gcp->program_name, name, SEG_OFFSET(segp,
 								    apage));
 			return SEG_ERR;
diff --git a/testcases/kernel/io/direct_io/diotest6.c b/testcases/kernel/io/direct_io/diotest6.c
index 00c2bab59..a06e6b82b 100644
--- a/testcases/kernel/io/direct_io/diotest6.c
+++ b/testcases/kernel/io/direct_io/diotest6.c
@@ -129,7 +129,7 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 		}
 		n = writev(fd_w, iov_w, nvector);
 		if (n < (bufsize * nvector)) {
-			tst_resm(TFAIL | TERRNO, "writev failed, ret = %ld", n);
+			tst_resm(TFAIL | TERRNO, "writev failed, ret = %zd", n);
 			goto err;
 		}
 		if (action == READ_DIRECT) {
@@ -147,7 +147,7 @@ int runtest(int fd_r, int fd_w, int childnum, int action)
 		}
 		n = readv(fd_r, iov_r, nvector);
 		if (n < (bufsize * nvector)) {
-			tst_resm(TFAIL | TERRNO, "readv failed, ret = %ld", n);
+			tst_resm(TFAIL | TERRNO, "readv failed, ret = %zd", n);
 			goto err;
 		}
 		if (vbufcmp(iov_w, iov_r, nvector) != 0) {
diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 03d29a27a..21ef16617 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -72,8 +72,8 @@ static void verify(void)
 	}
 
 	if (stat_buf.st_size != FILE_SIZE) {
-		tst_resm(TINFO, "stat_buf.st_size = %zu expected %i",
-		         stat_buf.st_size, FILE_SIZE);
+		tst_resm(TINFO, "stat_buf.st_size = %li expected %i",
+		         (long)stat_buf.st_size, FILE_SIZE);
 		fail++;
 	}
 
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index d4fe691e5..a1080be4a 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -154,8 +154,8 @@ static void ftruncate_expect_success(int fd, off_t offset, const char *msg)
 
 	if (sb.st_size != offset) {
 		tst_resm(TFAIL,
-			 "ftruncate() to %zu bytes succeded but fstat() reports size %zu",
-			 offset, sb.st_size);
+			 "ftruncate() to %li bytes succeded but fstat() reports size %li",
+			 (long)offset, (long)sb.st_size);
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
index 8f959e270..f22e3d345 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
@@ -187,8 +187,8 @@ void *check_mmap(const char *file, const int lineno, void *addr, size_t length,
 	p = safe_mmap(file, lineno, addr, length, prot, flags, fd, offset);
 
 	tst_res_(file, lineno, TPASS,
-		"mmap(%p, %zu, %i, %i, %i, %zi) succeeded", addr,
-		length, prot, flags, fd, offset);
+		"mmap(%p, %zu, %i, %i, %i, %li) succeeded", addr,
+		length, prot, flags, fd, (long)offset);
 
 	return p;
 }
@@ -199,22 +199,22 @@ void check_mmap_fail(const char *file, const int lineno, void *addr,
 	if (mmap(addr, length, prot, flags, fd, offset) != MAP_FAILED) {
 		safe_munmap(file, lineno, NULL, addr, length);
 		tst_res_(file, lineno, TFAIL,
-			"mmap(%p, %zu, %i, %i, %i, %zi) succeeded unexpectedly",
-			addr, length, prot, flags, fd, offset);
+			"mmap(%p, %zu, %i, %i, %i, %li) succeeded unexpectedly",
+			addr, length, prot, flags, fd, (long)offset);
 
 		return;
 	}
 
 	tst_res_(file, lineno, TPASS | TERRNO,
-		"mmap(%p, %zu, %i, %i, %i, %zi) failed as expected",
-		addr, length, prot, flags, fd, offset);
+		"mmap(%p, %zu, %i, %i, %i, %li) failed as expected",
+		addr, length, prot, flags, fd, (long)offset);
 }
 
 void check_munmap(const char *file, const int lineno, void *p, size_t length)
 {
 	safe_munmap(file, lineno, NULL, p, length);
 
-	tst_res_(file, lineno, TPASS, "munmap(%p, %ld) succeeded", p, length);
+	tst_res_(file, lineno, TPASS, "munmap(%p, %zu) succeeded", p, length);
 }
 
 void check_mfd_has_seals(const char *file, const int lineno, int fd, int seals)
@@ -235,10 +235,10 @@ void check_mprotect(const char *file, const int lineno, void *addr,
 {
 	if (mprotect(addr, length, prot) < 0) {
 		tst_brk_(file, lineno, TFAIL | TERRNO,
-			"mprotect(%p, %ld, %d) failed", addr, length, prot);
+			"mprotect(%p, %zu, %d) failed", addr, length, prot);
 	}
 
-	tst_res_(file, lineno, TPASS, "mprotect(%p, %ld, %d) succeeded", addr,
+	tst_res_(file, lineno, TPASS, "mprotect(%p, %zu, %d) succeeded", addr,
 		length, prot);
 }
 
@@ -313,7 +313,7 @@ void check_mfd_readable(const char *filename, const int lineno, int fd)
 	void *p;
 
 	safe_read(filename, lineno, NULL, 1, fd, buf, sizeof(buf));
-	tst_res_(filename, lineno, TPASS, "read(%d, %s, %ld) succeeded", fd,
+	tst_res_(filename, lineno, TPASS, "read(%d, %s, %zu) succeeded", fd,
 		buf, sizeof(buf));
 
 	/* verify PROT_READ *is* allowed */
@@ -455,13 +455,13 @@ void check_mfd_growable_by_write(const char *filename, const int lineno, int fd)
 
 	if (pwrite(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
 		tst_res_(filename, lineno, TFAIL | TERRNO,
-			"pwrite(%d, %s, %ld, %d) failed",
+			"pwrite(%d, %s, %zu, %d) failed",
 			fd, buf, sizeof(buf), 0);
 
 		return;
 	}
 
-	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %ld, %d) succeeded",
+	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %zu, %d) succeeded",
 		fd, buf, sizeof(buf), 0);
 
 	check_mfd_size(filename, lineno, fd, MFD_DEF_SIZE * 8);
@@ -474,12 +474,12 @@ void check_mfd_non_growable_by_write(const char *filename, const int lineno,
 
 	if (pwrite(fd, buf, sizeof(buf), 0) == sizeof(buf)) {
 		tst_res_(filename, lineno, TFAIL,
-			"pwrite(%d, %s, %ld, %d) didn't fail as expected",
+			"pwrite(%d, %s, %zu, %d) didn't fail as expected",
 			fd, buf, sizeof(buf), 0);
 
 		return;
 	}
 
-	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %ld, %d) succeeded",
+	tst_res_(filename, lineno, TPASS, "pwrite(%d, %s, %zu, %d) succeeded",
 		fd, buf, sizeof(buf), 0);
 }
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index c051a59f6..f3f5295c1 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -172,7 +172,7 @@ static void do_test(unsigned int i)
 	}
 
 	if (tc->len != TEST_RETURN) {
-		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %d",
+		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %zu",
 			TEST_RETURN, tc->len);
 		return;
 	}
@@ -192,7 +192,7 @@ static void do_test(unsigned int i)
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %lu",
+	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %zu",
 			TEST_RETURN, prio, len);
 }
 
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 741dea24e..d54de1d65 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -216,7 +216,7 @@ static void do_test(unsigned int i)
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %lu",
+	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %zu",
 			TEST_RETURN, prio, len);
 }
 
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index d56792b13..0d832cb59 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -81,11 +81,11 @@ void test01(void)
 	write_file(fd);
 
 	SAFE_FSTAT(cleanup, fd, &st);
-	tst_resm(TINFO, "file size is '%zu'", st.st_size);
+	tst_resm(TINFO, "file size is '%li'", (long)st.st_size);
 
 	if (st.st_size != blocks_num * size) {
-		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
-			 st.st_size, blocks_num * size);
+		tst_resm(TFAIL, "not expected size: '%li' != '%zu'",
+			 (long)st.st_size, blocks_num * size);
 		SAFE_CLOSE(cleanup, fd);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 7857a2e45..7e816f26b 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -92,11 +92,11 @@ void test01(void)
 	write_file(fd);
 
 	SAFE_FSTAT(cleanup, fd, &st);
-	tst_resm(TINFO, "file size is '%zu'", st.st_size);
+	tst_resm(TINFO, "file size is '%li'", (long)st.st_size);
 
 	if (st.st_size != blocks_num * size) {
-		tst_resm(TFAIL, "not expected size: '%zu' != '%zu'",
-			 st.st_size, blocks_num * size);
+		tst_resm(TFAIL, "not expected size: '%li' != '%zu'",
+			 (long)st.st_size, blocks_num * size);
 		SAFE_CLOSE(cleanup, fd);
 		return;
 	}
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 87233cdaa..5ee27fbdb 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -68,7 +68,7 @@ void verify_preadv(unsigned int n)
 	}
 
 	if (TEST_RETURN != tc->size) {
-		tst_res(TFAIL, "Preadv(2) read %li bytes, expected %li",
+		tst_res(TFAIL, "Preadv(2) read %li bytes, expected %zi",
 			 TEST_RETURN, tc->size);
 		return;
 	}
@@ -89,7 +89,7 @@ void verify_preadv(unsigned int n)
 		return;
 	}
 
-	tst_res(TPASS, "Preadv(2) read %li bytes successfully "
+	tst_res(TPASS, "Preadv(2) read %zi bytes successfully "
 		 "with content '%c' expectedly", tc->size, tc->content);
 }
 
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 67c9f2194..7c97f7227 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -68,7 +68,7 @@ static void verify_pwritev(unsigned int n)
 	}
 
 	if (TEST_RETURN != tc->size) {
-		tst_res(TFAIL, "pwritev() wrote %li bytes, expected %li",
+		tst_res(TFAIL, "pwritev() wrote %li bytes, expected %zi",
 			 TEST_RETURN, tc->size);
 		return;
 	}
@@ -91,7 +91,7 @@ static void verify_pwritev(unsigned int n)
 		return;
 	}
 
-	tst_res(TPASS, "writev() wrote %li bytes successfully "
+	tst_res(TPASS, "writev() wrote %zi bytes successfully "
 		 "with content 'a' expectedly ", tc->size);
 }
 
diff --git a/testcases/kernel/syscalls/stat/stat01.c b/testcases/kernel/syscalls/stat/stat01.c
index ee71c560a..e041311f5 100644
--- a/testcases/kernel/syscalls/stat/stat01.c
+++ b/testcases/kernel/syscalls/stat/stat01.c
@@ -72,8 +72,8 @@ static void verify(void)
 	}
 
 	if (stat_buf.st_size != FILE_SIZE) {
-		tst_resm(TINFO, "stat_buf.st_size = %zu expected %i",
-		         stat_buf.st_size, FILE_SIZE);
+		tst_resm(TINFO, "stat_buf.st_size = %li expected %i",
+		         (long)stat_buf.st_size, FILE_SIZE);
 		fail++;
 	}
 
-- 
2.13.0

