From: Li Wang <liwang@redhat.com>
Date: Mon, 23 May 2016 12:59:08 +0800
Subject: [LTP] [PATCH v2 2/3] syscalls/madvise01: reconstruct and convert to
	new API
Message-ID: <1463979548-21374-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* take use of some SAFE Marcos
* move the intialization operations to setup()
* merge madvise0[3|4] into madvise01
* create the test file on tmpfs
* create new array madvise_opt[]
* add "MADV_HWPOISON, MADV_HUGEPAGE, MADV_NOHUGEPAGE
  MADV_MERGEABLE, MADV_UNMERGEABLE" in test option

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                              |   2 -
 testcases/kernel/syscalls/madvise/madvise01.c | 214 ++++++++++++++++----------
 testcases/kernel/syscalls/madvise/madvise03.c | 182 ----------------------
 testcases/kernel/syscalls/madvise/madvise04.c | 138 -----------------
 4 files changed, 130 insertions(+), 406 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/madvise/madvise03.c
 delete mode 100644 testcases/kernel/syscalls/madvise/madvise04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6af3dad..96f398d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -741,8 +741,6 @@ mincore02 mincore02
 
 madvise01 madvise01
 madvise02 madvise02
-madvise03 madvise03
-madvise04 madvise04
 madvise05 madvise05
 madvise06 madvise06
 
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 4b1286d..07a8e24 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -32,107 +32,153 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
-
-char *TCID = "madvise01";
-int TST_TOTAL = 5;
+#include "tst_test.h"
+#include "tst_kvercmp.h"
+#include "lapi/mmap.h"
+
+#define KSM_SYS_DIR "/sys/kernel/mm/ksm"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
+
+static struct stat st;
+static char *sfile;
+static char *pfile;
+static char  filename[64];
+
+static struct {
+	int advice;
+	char *name;
+	char *addr;
+	int   flag;
+} advice_opt[] = {
+	{MADV_NORMAL,      "MADV_NORMAL",      NULL, 1},
+	{MADV_RANDOM,      "MADV_RANDOM",      NULL, 1},
+	{MADV_SEQUENTIAL,  "MADV_SEQUENTIAL",  NULL, 1},
+	{MADV_WILLNEED,    "MADV_WILLNEED",    NULL, 1},
+	{MADV_DONTNEED,    "MADV_DONTNEED",    NULL, 1},
+	{MADV_REMOVE,      "MADV_REMOVE",      NULL, 1}, /* since Linux 2.6.16 */
+	{MADV_DONTFORK,    "MADV_DONTFORK",    NULL, 1}, /* since Linux 2.6.16 */
+	{MADV_DOFORK,      "MADV_DOFORK",      NULL, 1}, /* since Linux 2.6.16 */
+	{MADV_HWPOISON,    "MADV_HWPOISON",    NULL, 1}, /* since Linux 2.6.32 */
+	{MADV_MERGEABLE,   "MADV_MERGEABLE",   NULL, 1}, /* since Linux 2.6.32 */
+	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", NULL, 1}, /* since Linux 2.6.32 */
+	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    NULL, 1}, /* since Linux 2.6.38 */
+	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  NULL, 1}, /* since Linux 2.6.38 */
+	{MADV_DONTDUMP,    "MADV_DONTDUMP",    NULL, 1}, /* since Linux 3.4 */
+	{MADV_DODUMP,      "MADV_DODUMP",      NULL, 1}  /* since Linux 3.4 */
+};
+
+static void advice_filter(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(advice_opt); i++) {
+		advice_opt[i].addr = sfile;
+
+		switch (advice_opt[i].advice) {
+		case MADV_REMOVE:
+		case MADV_DONTFORK:
+		case MADV_DOFORK:
+			if ((tst_kvercmp(2, 6, 16)) < 0)
+				advice_opt[i].flag = 0;
+			break;
+
+		case MADV_HWPOISON:
+			if ((tst_kvercmp(2, 6, 32)) < 0)
+				advice_opt[i].flag = 0;
+			break;
+
+		case MADV_MERGEABLE:
+		case MADV_UNMERGEABLE:
+			if ((tst_kvercmp(2, 6, 32)) < 0)
+				advice_opt[i].flag = 0;
+			/* kernel not configured with CONFIG_KSM, skip
+			 * test for MADV_MERGEABLE, MADV_UNMERGEABLE */
+			if (access(KSM_SYS_DIR, F_OK) != 0)
+				advice_opt[i].flag = 0;
+			break;
+
+		case MADV_HUGEPAGE:
+		case MADV_NOHUGEPAGE:
+			/* MADV_HUGEPAGE only works with private
+			 * anonymous pages */
+			advice_opt[i].addr = pfile;
+			if ((tst_kvercmp(2, 6, 38)) < 0)
+				advice_opt[i].flag = 0;
+			break;
+
+		case MADV_DONTDUMP:
+		case MADV_DODUMP:
+			if ((tst_kvercmp(3, 4, 0)) < 0)
+				advice_opt[i].flag = 0;
+			break;
+
+		default:
+			break;
+		}
+	}
+}
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc, fd;
 	int i = 0;
-	char *file = NULL;
-	struct stat stat;
-	char filename[64];
-	char *progname = NULL;
-	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	progname = *argv;
-	sprintf(filename, "%s-out.%d", progname, getpid());
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0664);
-		if (fd < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "open failed");
-#ifdef DEBUG
-		tst_resm(TINFO, "filename = %s opened successfully", filename);
-#endif
-
-		/* Writing 40 KB of random data into this file
-		   [32 * 1280 = 40960] */
-		for (i = 0; i < 1280; i++)
-			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "write failed");
-
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
+	int fd;
 
-		/* Map the input file into memory */
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK, cleanup, "mmap failed");
+	SAFE_MKDIR("/mnt/tmp_madvise", 0664);
+	SAFE_MOUNT("tmp_madvise", "/mnt/tmp_madvise", "tmpfs", 0, NULL);
 
-		/* (1) Test case for MADV_NORMAL */
-		TEST(madvise(file, stat.st_size, MADV_NORMAL));
-		check_and_print("MADV_NORMAL");
+	sprintf(filename, "/mnt/tmp_madvise/madvise01.%d", getpid());
+	fd = SAFE_OPEN(filename, O_RDWR | O_CREAT, 0664);
 
-		/* (2) Test case for MADV_RANDOM */
-		TEST(madvise(file, stat.st_size, MADV_RANDOM));
-		check_and_print("MADV_RANDOM");
+	/* Writing 40 KB of random data into this file [32 * 1280 = 40960] */
+	for (i = 0; i < 1280; i++)
+		SAFE_WRITE(1, fd, STR, strlen(STR));
 
-		/* (3) Test case for MADV_SEQUENTIAL */
-		TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
-		check_and_print("MADV_SEQUENTIAL");
+	SAFE_FSTAT(fd, &st);
 
-		/* (4) Test case for MADV_WILLNEED */
-		TEST(madvise(file, stat.st_size, MADV_WILLNEED));
-		check_and_print("MADV_WILLNEED");
+	/* Map the input file into shared memory */
+	sfile = SAFE_MMAP(NULL, st.st_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
-		/* (5) Test case for MADV_DONTNEED */
-		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
-		check_and_print("MADV_DONTNEED");
+	/* Map the input file into private memory */
+	pfile = SAFE_MMAP(NULL, st.st_size,
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, fd, 0);
+	close(fd);
 
-		if (munmap(file, stat.st_size) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
-
-		close(fd);
-	}
-
-	cleanup();
-	tst_exit();
+	advice_filter();
 }
 
-static void setup(void)
+static void cleanup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	SAFE_MUNMAP(sfile, st.st_size);
+	SAFE_MUNMAP(pfile, st.st_size);
+	SAFE_UMOUNT("/mnt/tmp_madvise");
+	SAFE_RMDIR("/mnt/tmp_madvise");
 }
 
-static void cleanup(void)
+static void check_and_print(char *advice)
 {
-	tst_rmdir();
-
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL, "madvise test for %s failed with "
+				"return = %ld, errno = %d : %s",
+				advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+	} else
+		tst_res(TPASS, "madvise test for %s PASSED", advice);
 }
 
-static void check_and_print(char *advice)
+static void madvise_test(unsigned int nr)
 {
-	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "madvise test for %s failed", advice);
-	else
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
+	if (advice_opt[nr].flag == 1) {
+		TEST(madvise(advice_opt[nr].addr, st.st_size, advice_opt[nr].advice));
+		check_and_print(advice_opt[nr].name);
+	} else
+		tst_res(TCONF, "%s is not supported", advice_opt[nr].name);
 }
+
+static struct tst_test test = {
+	.tid = "madvise01",
+	.tcnt = ARRAY_SIZE(advice_opt),
+	.test = madvise_test,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
deleted file mode 100644
index 3da2bb2..0000000
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- *  Copyright (c) International Business Machines  Corp., 2004
- *  Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU Library General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-/*
- * This is a test case for madvise(2) system call. No error should be returned.
- */
-
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <sys/shm.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "test.h"
-
-char *TCID = "madvise03";
-
-#ifdef MADV_REMOVE
-
-int TST_TOTAL = 3;
-
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
-static long get_shmmax(void);
-
-static int shmid1;
-
-int main(int argc, char *argv[])
-{
-	int lc, fd;
-	int i;
-	char *file = NULL;
-	struct stat stat;
-	void *addr1;
-	long shm_size = 0;
-	char filename[64];
-	char *progname = NULL;
-	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	progname = *argv;
-	sprintf(filename, "%s-out.%d", progname, getpid());
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0664);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef DEBUG
-		tst_resm(TINFO, "filename = %s opened successfully", filename);
-#endif
-
-		/* Writing 40 KB of random data into this file
-		   [32 * 1280 = 40960] */
-		for (i = 0; i < 1280; i++)
-			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "write failed");
-
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
-
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-
-		/* Allocate shared memory segment */
-		shm_size = get_shmmax();
-
-#define min(a, b) ((a) < (b) ? @ : (b))
-		shmid1 = shmget(IPC_PRIVATE, min(1024 * 1024, shm_size),
-				IPC_CREAT | IPC_EXCL | 0701);
-		if (shmid1 == -1)
-			tst_brkm(TBROK, cleanup, "shmget failed");
-
-		/* Attach shared memory segment to an address selected by the system */
-		addr1 = shmat(shmid1, NULL, 0);
-		if (addr1 == (void *)-1)
-			tst_brkm(TBROK, cleanup, "shmat error");
-
-		/* (1) Test case for MADV_REMOVE */
-		TEST(madvise(addr1, 4096, MADV_REMOVE));
-		check_and_print("MADV_REMOVE");
-
-		/* (2) Test case for MADV_DONTFORK */
-		TEST(madvise(file, (stat.st_size / 2), MADV_DONTFORK));
-		check_and_print("MADV_DONTFORK");
-
-		/* (3) Test case for MADV_DOFORK */
-		TEST(madvise(file, (stat.st_size / 2), MADV_DOFORK));
-		check_and_print("MADV_DOFORK");
-
-		/* Finally Unmapping the whole file */
-		if (munmap(file, stat.st_size) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
-
-		close(fd);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-}
-
-static void cleanup(void)
-{
-	if (shmid1 != -1)
-		if (shmctl(shmid1, IPC_RMID, 0) < 0)
-			tst_resm(TBROK | TERRNO,
-				 "shmctl(.., IPC_RMID, ..) failed");
-
-	tst_rmdir();
-}
-
-static void check_and_print(char *advice)
-{
-	if (TEST_RETURN == -1) {
-		if (TEST_ERRNO == ENOTSUP && !strcmp(advice, "MADV_REMOVE")) {
-			tst_resm(TCONF, "madvise MADV_REMOVE returned ENOTSUP"
-				 " CONFIG_TMPFS=y not in kernel .config?");
-			return;
-		}
-		tst_resm(TFAIL,
-			 "madvise test for %s failed with "
-			 "return = %ld, errno = %d : %s",
-			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
-	}
-}
-
-static long get_shmmax(void)
-{
-	long maxsize;
-
-	SAFE_FILE_SCANF(cleanup, "/proc/sys/kernel/shmmax", "%ld", &maxsize);
-
-	return maxsize;
-}
-#else
-int main(void)
-{
-	/* "Requires 2.6.16+" were the original comments */
-	tst_brkm(TCONF, NULL,
-		 "this system doesn't have required madvise support");
-}
-#endif
diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
deleted file mode 100644
index e89babc..0000000
--- a/testcases/kernel/syscalls/madvise/madvise04.c
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- *  Copyright (C) 2012 FUJITSU LIMITED.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU Library General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-
-#include "test.h"
-
-char *TCID = "madvise04";
-
-#ifdef MADV_DONTDUMP
-
-int TST_TOTAL = 2;
-
-#define BUFFER_SIZE  256
-
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
-
-int main(int argc, char *argv[])
-{
-	int lc, fd;
-	int i;
-	char *file = NULL;
-	struct stat stat;
-	char filename[64];
-	char *progname = NULL;
-	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	progname = *argv;
-	sprintf(filename, "%s-out.%d", progname, getpid());
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0664);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open failed");
-#ifdef DEBUG
-		tst_resm(TINFO, "filename = %s opened successfully", filename);
-#endif
-
-		/* Writing 40 KB of random data into this file
-		   [32 * 1280 = 40960] */
-		for (i = 0; i < 1280; i++)
-			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "write failed");
-
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
-
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
-
-		/* (1) Test case for MADV_DONTDUMP */
-		TEST(madvise(file, stat.st_size, MADV_DONTDUMP));
-		check_and_print("MADV_DONTDUMP");
-
-		/* (2) Test case for MADV_DODUMP */
-		TEST(madvise(file, stat.st_size, MADV_DODUMP));
-		check_and_print("MADV_DODUMP");
-
-		/* Finally Unmapping the whole file */
-		if (munmap(file, stat.st_size) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
-
-		close(fd);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void check_and_print(char *advice)
-{
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL,
-			 "madvise test for %s failed with "
-			 "return = %ld, errno = %d : %s",
-			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
-	}
-}
-
-#else
-int main(void)
-{
-	/* Requires kernel version >= 3.4 */
-	tst_brkm(TCONF, NULL,
-		 "This system doesn't have required madvise support, "
-		 "MADV_DONTDUMP and MADV_DODUMP were added from 3.4. "
-		 "If your kernel version >= 3.4, maybe you need updating "
-		 "your glibc-headers");
-}
-#endif
-- 
1.8.3.1

