From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 26 Mar 2019 11:52:35 +0100
Subject: [LTP] [RESENT][PATCH v2 1/1] lapi: Define TST_ABI{, 32,
	64} to detect target type
Message-ID: <20190326105235.21177-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

and replace __WORDSIZE with them.

Motivation was instead of finding, where all libc define __WORDSIZE,
which is usually used for detecting target type (at least MUSL
defines it in different place than other libc) we define our own
constant.

+ change encoding of the comment in mem01.c to utf8 and use SPDX license
identifier.

Reported-by: Dengke Du <dengke.du@windriver.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

resent as the last version didn't get to patchwork (only to ML).

Kind regards,
Petr
---
 include/lapi/abisize.h                        | 29 +++++++++----------
 include/lapi/sync_file_range.h                |  7 +++--
 testcases/kernel/io/disktest/main.h           |  3 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  3 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  3 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  3 +-
 testcases/kernel/mem/mem/mem01.c              |  9 +++---
 testcases/kernel/mem/mtest01/mtest01.c        |  7 +++--
 testcases/kernel/mem/oom/oom01.c              |  3 +-
 testcases/kernel/mem/oom/oom02.c              |  3 +-
 testcases/kernel/mem/oom/oom03.c              |  3 +-
 testcases/kernel/mem/oom/oom04.c              |  3 +-
 testcases/kernel/mem/oom/oom05.c              |  3 +-
 testcases/kernel/mem/swapping/swapping01.c    |  3 +-
 .../kernel/mem/tunable/min_free_kbytes.c      |  5 ++--
 .../kernel/mem/tunable/overcommit_memory.c    |  3 +-
 testcases/kernel/mem/vma/vma03.c              |  3 +-
 .../kernel/syscalls/fadvise/posix_fadvise03.c |  3 +-
 .../kernel/syscalls/fallocate/fallocate02.c   |  3 +-
 .../kernel/syscalls/fcntl/fcntl_common.h      |  3 +-
 testcases/kernel/syscalls/fork/fork14.c       |  3 +-
 .../kernel/syscalls/ipc/msgrcv/msgrcv08.c     |  3 +-
 testcases/kernel/syscalls/mmap/mmap15.c       |  3 +-
 testcases/kernel/syscalls/profil/profil01.c   |  3 +-
 testcases/kernel/syscalls/sbrk/sbrk03.c       |  3 +-
 .../kernel/syscalls/sendfile/sendfile09.c     |  3 +-
 26 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/include/lapi/abisize.h b/include/lapi/abisize.h
index 897bdfdb6..9e6622ca1 100644
--- a/include/lapi/abisize.h
+++ b/include/lapi/abisize.h
@@ -1,25 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2014 Linux Test Project
+ * Copyright (c) 2014-2019 Linux Test Project
  *  Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *  Petr Vorel <petr.vorel@gmail.com>
  */
 
 #ifndef ABISIZE_H__
 #define ABISIZE_H__
 
+/* __WORDSIZE replacement */
+#if defined(__LP64__) || defined(_LP64)
+# define TST_ABI64
+# define TST_ABI 64
+#else
+# define TST_ABI32
+# define TST_ABI 32
+#endif
+
 /*
  * Determines if we have to split up 64 bit arguments or not
  *
@@ -29,6 +26,6 @@
      (defined(__mips__) && _MIPS_SIM == _ABIN32) || \
      (defined(__x86_64__) && defined(__ILP32__)) || \
      (defined(__aarch64__) && defined(__ILP32__)) || \
-     __WORDSIZE == 64
+     defined(TST_ABI64)
 
 #endif /* ABISIZE_H__ */
diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
index e2d35fcfd..86bfe5d6e 100644
--- a/include/lapi/sync_file_range.h
+++ b/include/lapi/sync_file_range.h
@@ -9,6 +9,7 @@
 #include <sys/types.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "lapi/abisize.h"
 
 #if !defined(HAVE_SYNC_FILE_RANGE)
 
@@ -25,7 +26,7 @@ static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
 				   unsigned int flags)
 {
 #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
-# if (__WORDSIZE == 32)
+# ifdef TST_ABI32
 #  if __BYTE_ORDER == __BIG_ENDIAN
 	return TST_SYSCALL(__NR_sync_file_range2, fd, flags,
 		(int)(offset >> 32), (int)offset, (int)(nbytes >> 32),
@@ -37,10 +38,10 @@ static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
 # else
 	return TST_SYSCALL(__NR_sync_file_range2, fd, flags, offset, nbytes);
 # endif
-#elif (defined(__s390__) || defined(__s390x__)) && __WORDSIZE == 32
+#elif (defined(__s390__) || defined(__s390x__)) && defined(TST_ABI32)
 	return TST_SYSCALL(__NR_sync_file_range, fd, (int)(offset >> 32),
 		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
-#elif defined(__mips__) && __WORDSIZE == 32
+#elif defined(__mips__) && defined(TST_ABI32)
 # if __BYTE_ORDER == __BIG_ENDIAN
 	return TST_SYSCALL(__NR_sync_file_range, fd, 0, (int)(offset >> 32),
 		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
diff --git a/testcases/kernel/io/disktest/main.h b/testcases/kernel/io/disktest/main.h
index 41fcd7315..8cab87c66 100644
--- a/testcases/kernel/io/disktest/main.h
+++ b/testcases/kernel/io/disktest/main.h
@@ -49,6 +49,7 @@
 #include <time.h>
 #include <errno.h>
 #include "defs.h"
+#include "lapi/abisize.h"
 
 #define VER_STR "v1.4.2"
 #define BLKGETSIZE _IO(0x12,96)		/* IOCTL for getting the device size */
@@ -64,7 +65,7 @@
 /* the new way we align */
 #define ALIGN(x, y) (((long long unsigned)x/(long long unsigned)y)*(long long unsigned)y)
 
-#if __WORDSIZE == 64
+#ifdef TST_ABI64
 /* the old way we use to align */
 /* #define ALIGN(x, bs) (((OFF_T)x + ((OFF_T)bs - 1)) & ~((OFF_T)bs - 1)) */
 #define BUFALIGN(x) (void *) (((unsigned long)x + (OFF_T)(ALIGNSIZE - 1)) & (OFF_T)~(ALIGNSIZE - 1))
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 0be753e0d..9b0ab4e37 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -39,6 +39,7 @@
 #include <sys/mount.h>
 #include <limits.h>
 #include <sys/param.h>
+#include "lapi/abisize.h"
 #include "hugetlb.h"
 
 #define LOW_ADDR       0x80000000
@@ -100,7 +101,7 @@ static void test_hugemmap(void)
 	/* Attempt to mmap a huge page into a low memory address */
 	addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | PROT_WRITE,
 			MAP_SHARED, fildes, 0);
-#if __WORDSIZE == 64 /* 64-bit process */
+#ifdef TST_ABI64 /* 64-bit process */
 	if (addr2 == MAP_FAILED) {
 		tst_res(TFAIL | TERRNO, "huge mmap failed unexpectedly"
 				" with %s (64-bit)", TEMPFILE);
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 674d367a4..55a3a24f4 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -38,6 +38,7 @@
 #include <stdio.h>
 #include <limits.h>
 #include <sys/param.h>
+#include "lapi/abisize.h"
 #include "hugetlb.h"
 
 static struct tst_option options[] = {
@@ -70,7 +71,7 @@ static void test_hugemmap(void)
 	huge_pagesize = SAFE_READ_MEMINFO("Hugepagesize:");
 	tst_res(TINFO, "Size of huge pages is %d KB", huge_pagesize);
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_res(TINFO, "Total amount of free huge pages is %d",
 			freepages);
 	tst_res(TINFO, "Max number allowed for 1 mmap file in"
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 1c2c978c8..1cba867e5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -36,9 +36,10 @@
 
 #include <pwd.h>
 #include <limits.h>
+#include "lapi/abisize.h"
 #include "hugetlb.h"
 
-#if __WORDSIZE == 64
+#ifdef TST_ABI64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
 #else
 #define NADDR	0x60000eef	/* a non alligned address value */
diff --git a/testcases/kernel/mem/mem/mem01.c b/testcases/kernel/mem/mem/mem01.c
index f7642ab24..1bace3012 100644
--- a/testcases/kernel/mem/mem/mem01.c
+++ b/testcases/kernel/mem/mem/mem01.c
@@ -2,7 +2,7 @@
  * mem01.c - Basic memory and swapper stress test
  *
  * Copyright (C) 2001 Stephane Fillod <f4cfe@free.fr>
- * 	Original idea from Rene Cougnenc (on t'a pas oubli� mec)
+ * 	Original idea from Rene Cougnenc (on t'a pas oublié mec)
  *
  * Copyright (C) 2012 Cyril Hrubis <chrubis@suse.cz>
  *
@@ -39,6 +39,7 @@
 #include <time.h>
 #include <limits.h>
 
+#include "lapi/abisize.h"
 #include "test.h"
 
 /* in KB */
@@ -114,13 +115,13 @@ size_t get_memsize(void)
 	res = res + freeswap;
 
 	tst_resm(TINFO, "Total Free:\t%llu Mb", res / 1024 / 1024);
-#if defined (__s390__)
+#if defined(__s390__)
 	if (res > 1 * 1024 * 1024 * 1024)
 		res = 500 * 1024 * 1024;	/* s390's unique 31bit architecture needs smaller default */
-#elif __WORDSIZE == 32
+#elif defined(TST_ABI32)
 	if (res > 1 * 1024 * 1024 * 1024)
 		res = 1 * 1024 * 1024 * 1024;
-#elif __WORDSIZE == 64
+#elif defined(TST_ABI64)
 	if (res > (unsigned long long)3 * 1024 * 1024 * 1024)
 		res = (unsigned long long)3 *1024 * 1024 * 1024;
 #endif
diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index df038f50d..eaf102674 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -28,15 +28,16 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include "lapi/abisize.h"
 #include "tst_test.h"
 
 #define FIVE_HUNDRED_MB         (500ULL*1024*1024)
 
-#if defined (_s390_)
+#if defined(_s390_)
 #define ALLOC_THRESHOLD		FIVE_HUNDRED_MB
-#elif __WORDSIZE == 32
+#elif defined(TST_ABI32)
 #define ALLOC_THRESHOLD		(2*FIVE_HUNDRED_MB)
-#elif __WORDSIZE == 64
+#elif defined(TST_ABI64)
 #define ALLOC_THRESHOLD		(6*FIVE_HUNDRED_MB)
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index beb232d45..258bfd89e 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -27,11 +27,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include "lapi/abisize.h"
 #include "mem.h"
 
 static void verify_oom(void)
 {
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 866540def..2b9bcb1b2 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -30,6 +30,7 @@
 #include <numa.h>
 #endif
 
+#include "lapi/abisize.h"
 #include "numa_helper.h"
 #include "mem.h"
 
@@ -37,7 +38,7 @@
 
 static void verify_oom(void)
 {
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index b283b5275..ce0b34c31 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -30,6 +30,7 @@
 #include <numa.h>
 #endif
 
+#include "lapi/abisize.h"
 #include "numa_helper.h"
 #include "mem.h"
 
@@ -39,7 +40,7 @@ static int memcg_mounted;
 
 static void verify_oom(void)
 {
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 98b31c74a..7185ef973 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -30,6 +30,7 @@
 #include <numa.h>
 #endif
 
+#include "lapi/abisize.h"
 #include "numa_helper.h"
 #include "mem.h"
 
@@ -39,7 +40,7 @@ static int cpuset_mounted;
 
 static void verify_oom(void)
 {
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index c5395b0bb..db24df6de 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -30,6 +30,7 @@
 #include <numa.h>
 #endif
 
+#include "lapi/abisize.h"
 #include "numa_helper.h"
 #include "mem.h"
 
@@ -42,7 +43,7 @@ static void verify_oom(void)
 {
 	int swap_acc_on = 1;
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 6ac802b25..ff40c85c0 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -44,6 +44,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include "lapi/abisize.h"
 #include "mem.h"
 
 /* allow swapping 1 * phy_mem in maximum */
@@ -63,7 +64,7 @@ static pid_t pid;
 
 static void test_swapping(void)
 {
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index f114dc493..09741eea3 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -34,6 +34,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "lapi/abisize.h"
 #include "mem.h"
 
 #define MAP_SIZE (1UL<<20)
@@ -126,14 +127,14 @@ static void test_tune(unsigned long overcommit_policy)
 					 status);
 		} else if (overcommit_policy == 1) {
 			if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 			{
 				if (total_mem < 3145728UL)
 #endif
 					tst_res(TFAIL,
 						 "child unexpectedly failed: %d",
 						 status);
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 				/* in 32-bit system, a process allocate about 3Gb memory@most */
 				else
 					tst_res(TINFO, "Child can't allocate "
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 07f824328..555298fbf 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -69,6 +69,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
+#include "lapi/abisize.h"
 #include "mem.h"
 
 #define DEFAULT_OVER_RATIO	50L
@@ -146,7 +147,7 @@ static void cleanup(void)
 static void overcommit_memory_test(void)
 {
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brk(TCONF, "test is not designed for 32-bit system.");
 #endif
 	/* start to test overcommit_memory=2 */
diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 4b34ab0a0..65884d9d9 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -51,6 +51,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "tst_kernel.h"
+#include "lapi/abisize.h"
 
 char *TCID = "vma03";
 int TST_TOTAL = 1;
@@ -72,7 +73,7 @@ int main(int argc, char *argv[])
 	void *map, *remap;
 	off_t pgoff;
 
-	if (__WORDSIZE != 32 || tst_kernel_bits() != 32) {
+	if (TST_ABI != 32 || tst_kernel_bits() != 32) {
 		tst_brkm(TCONF, NULL,
 			 "test is designed for 32-bit system only.");
 	}
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 0127a1b04..5bada5f3d 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -30,6 +30,7 @@
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
+#include "lapi/abisize.h"
 
 char fname[] = "/bin/cat";	/* test executable to open */
 int fd = -1;			/* initialized in open */
@@ -41,7 +42,7 @@ int defined_advise[] = {
 	POSIX_FADV_SEQUENTIAL,
 	POSIX_FADV_RANDOM,
 	POSIX_FADV_WILLNEED,
-#if defined(__s390__) && __WORDSIZE == 32
+#if defined(__s390__) && defined(TST_ABI32)
 	/* POSIX_FADV_DONTNEED and POSIX_FADV_NOREUSE are 6,7 on 31bit s390,
 	 * but the kernel accepts 4,5 as well and rewrites them internally,
 	 * see Linux kernel commit 068e1b94bbd268f375349f68531829c8b7c210bc
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index 4840eaf28..750ef4e49 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -41,6 +41,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fallocate.h"
+#include "lapi/abisize.h"
 
 #define BLOCKS_WRITTEN		12
 #ifdef TEST_DEFAULT
@@ -75,7 +76,7 @@ static struct test_data_t {
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, 0, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, BLOCKS_WRITTEN, -1, EINVAL},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, -(BLOCKS_WRITTEN+OFFSET), 1, EINVAL},
-#if __WORDSIZE == 64 || _FILE_OFFSET_BITS == 64
+#if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, MAX_FILESIZE, 1, EFBIG},
 	{&fdw, FNAMEW, DEFAULT_TEST_MODE, 1, MAX_FILESIZE, EFBIG},
 #endif
diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index 07229a0f8..92beb0c68 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -1,4 +1,5 @@
 #include "lapi/syscalls.h"
+#include "lapi/abisize.h"
 
 /*
  * glibc commit:
@@ -16,7 +17,7 @@
  * So, to support both version, on 32-bit we use fcntl64 syscall
  * directly with struct flock64.
  */
-#if __WORDSIZE == 64 || _FILE_OFFSET_BITS == 64
+#if defined(TST_ABI64) || _FILE_OFFSET_BITS == 64
 static int my_fcntl(int fd, int cmd, void *lck)
 {
 	return SAFE_FCNTL(fd, cmd, lck);
diff --git a/testcases/kernel/syscalls/fork/fork14.c b/testcases/kernel/syscalls/fork/fork14.c
index 6ea92e0c2..a92aa46ad 100644
--- a/testcases/kernel/syscalls/fork/fork14.c
+++ b/testcases/kernel/syscalls/fork/fork14.c
@@ -35,6 +35,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/abisize.h"
 
 char *TCID = "fork14";
 int TST_TOTAL = 1;
@@ -60,7 +61,7 @@ int main(int ac, char **av)
  * Tested on ppc64/x86_64/i386/s390x. And only 64bit has this issue.
  * Since a 32bit program can't mmap so many memory.
  */
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brkm(TCONF, NULL, "This test is only for 64bit.");
 #endif
 	setup();
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
index 1773a1bf4..dbe67e189 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -42,11 +42,12 @@
 #include <sys/ipc.h>
 #include <sys/msg.h>
 #include "test.h"
+#include "lapi/abisize.h"
 
 const char *TCID = "msgrcv08";
 const int TST_TOTAL = 1;
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 
 struct mbuf {
 	long mtype;     /* message type, must be > 0 */
diff --git a/testcases/kernel/syscalls/mmap/mmap15.c b/testcases/kernel/syscalls/mmap/mmap15.c
index c8a77873a..443a37eb8 100644
--- a/testcases/kernel/syscalls/mmap/mmap15.c
+++ b/testcases/kernel/syscalls/mmap/mmap15.c
@@ -36,6 +36,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/abisize.h"
 
 char *TCID = "mmap15";
 int TST_TOTAL = 1;
@@ -56,7 +57,7 @@ int main(int ac, char **av)
 	int lc, fd;
 	void *addr;
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brkm(TCONF, NULL, "This test is only for 64bit");
 #endif
 
diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index f1164021b..404f71517 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -27,6 +27,7 @@
 #include <sys/types.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/abisize.h"
 #include "config.h"
 
 char *TCID = "profil01";
@@ -53,7 +54,7 @@ static void alrm_handler(int sig)
 
 static void __attribute__ ((noinline)) *get_pc(void)
 {
-#if defined(__s390__) && __WORDSIZE == 32
+#if defined(__s390__) && defined(TST_ABI32)
 	/* taken from glibc,
 	 *   sysdeps/unix/sysv/linux/s390/s390-32/profil-counter.h
 	 * 31-bit s390 pointers don't use the 32th bit, however integers do,
diff --git a/testcases/kernel/syscalls/sbrk/sbrk03.c b/testcases/kernel/syscalls/sbrk/sbrk03.c
index 46fb2d111..85686245f 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk03.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk03.c
@@ -46,11 +46,12 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#include "lapi/abisize.h"
 #include "tst_test.h"
 
 static void sbrk_test(void)
 {
-#if defined(__s390__) && __WORDSIZE == 32
+#if defined(__s390__) && defined(TST_ABI32)
 	void *ret1, *ret2;
 
 	/* set bkr to 0x10000000 */
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 0a9d2553e..b9d9c8407 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -51,6 +51,7 @@
 #include <inttypes.h>
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/abisize.h"
 
 #ifndef OFF_T
 #define OFF_T off_t
@@ -170,7 +171,7 @@ int main(int ac, char **av)
 	int i;
 	int lc;
 
-#if __WORDSIZE == 32
+#ifdef TST_ABI32
 	tst_brkm(TCONF, NULL, "This test is only for 64bit");
 #endif
 
-- 
2.21.0

