From: Li Wang <liwang@redhat.com>
Date: Wed, 25 May 2016 14:29:38 +0800
Subject: [LTP] [PATCH V3 2/3] syscalls/madvise01: reconstruct and convert to
	new API
In-Reply-To: <1464157779-6883-1-git-send-email-liwang@redhat.com>
References: <1464157779-6883-1-git-send-email-liwang@redhat.com>
Message-ID: <1464157779-6883-2-git-send-email-liwang@redhat.com>
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
 testcases/kernel/syscalls/madvise/madvise01.c | 194 ++++++++++++--------------
 testcases/kernel/syscalls/madvise/madvise03.c | 182 ------------------------
 testcases/kernel/syscalls/madvise/madvise04.c | 138 ------------------
 4 files changed, 92 insertions(+), 424 deletions(-)
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
index 4b1286d..dc08bcd 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -1,20 +1,16 @@
 /*
  *  Copyright (c) International Business Machines  Corp., 2004
- *  Copyright (c) Linux Test Project, 2013
+ *  Copyright (c) Linux Test Project, 2013-2016
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU Library General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -26,113 +22,107 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_kvercmp.h"
+#include "lapi/mmap.h"
+
+#define TMP_DIR "tmp_madvise"
+#define TEST_FILE TMP_DIR"/testfile"
+#define KSM_SYS_DIR "/sys/kernel/mm/ksm"
+#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
+
+static char *sfile;
+static char *pfile;
+static struct stat st;
+
+static struct tcase {
+	int advice;
+	char *name;
+	char **addr;
+} tcases[] = {
+	{MADV_NORMAL,      "MADV_NORMAL",      &sfile},
+	{MADV_RANDOM,      "MADV_RANDOM",      &sfile},
+	{MADV_SEQUENTIAL,  "MADV_SEQUENTIAL",  &sfile},
+	{MADV_WILLNEED,    "MADV_WILLNEED",    &sfile},
+	{MADV_DONTNEED,    "MADV_DONTNEED",    &sfile},
+	{MADV_REMOVE,      "MADV_REMOVE",      &sfile}, /* since Linux 2.6.16 */
+	{MADV_DONTFORK,    "MADV_DONTFORK",    &sfile}, /* since Linux 2.6.16 */
+	{MADV_DOFORK,      "MADV_DOFORK",      &sfile}, /* since Linux 2.6.16 */
+	{MADV_HWPOISON,    "MADV_HWPOISON",    &sfile}, /* since Linux 2.6.32 */
+	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &sfile}, /* since Linux 2.6.32 */
+	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &sfile}, /* since Linux 2.6.32 */
+	{MADV_HUGEPAGE,    "MADV_HUGEPAGE",    &pfile}, /* since Linux 2.6.38 */
+	{MADV_NOHUGEPAGE,  "MADV_NOHUGEPAGE",  &pfile}, /* since Linux 2.6.38 */
+	{MADV_DONTDUMP,    "MADV_DONTDUMP",    &sfile}, /* since Linux 3.4 */
+	{MADV_DODUMP,      "MADV_DODUMP",      &sfile}  /* since Linux 3.4 */
+};
 
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
+static void setup(void)
+{
+	unsigned int i;
+	int fd;
 
-char *TCID = "madvise01";
-int TST_TOTAL = 5;
+	SAFE_MKDIR(TMP_DIR, 0664);
+	SAFE_MOUNT(TMP_DIR, TMP_DIR, "tmpfs", 0, NULL);
 
-int main(int argc, char *argv[])
-{
-	int lc, fd;
-	int i = 0;
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
-
-		/* Map the input file into memory */
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK, cleanup, "mmap failed");
-
-		/* (1) Test case for MADV_NORMAL */
-		TEST(madvise(file, stat.st_size, MADV_NORMAL));
-		check_and_print("MADV_NORMAL");
-
-		/* (2) Test case for MADV_RANDOM */
-		TEST(madvise(file, stat.st_size, MADV_RANDOM));
-		check_and_print("MADV_RANDOM");
-
-		/* (3) Test case for MADV_SEQUENTIAL */
-		TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
-		check_and_print("MADV_SEQUENTIAL");
-
-		/* (4) Test case for MADV_WILLNEED */
-		TEST(madvise(file, stat.st_size, MADV_WILLNEED));
-		check_and_print("MADV_WILLNEED");
-
-		/* (5) Test case for MADV_DONTNEED */
-		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
-		check_and_print("MADV_DONTNEED");
-
-		if (munmap(file, stat.st_size) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
-
-		close(fd);
-	}
-
-	cleanup();
-	tst_exit();
-}
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 
-static void setup(void)
-{
+	/* Writing 40 KB of random data into this file [32 * 1280 = 40960] */
+	for (i = 0; i < 1280; i++)
+		SAFE_WRITE(1, fd, STR, strlen(STR));
+
+	SAFE_FSTAT(fd, &st);
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	/* Map the input file into shared memory */
+	sfile = SAFE_MMAP(NULL, st.st_size,
+			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
-	TEST_PAUSE;
+	/* Map the input file into private memory. MADV_HUGEPAGE only works
+	 * with private anonymous pages */
+	pfile = SAFE_MMAP(NULL, st.st_size,
+			PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, fd, 0);
 
-	tst_tmpdir();
+	SAFE_CLOSE(fd);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
-
+	munmap(sfile, st.st_size);
+	munmap(pfile, st.st_size);
+	umount(TMP_DIR);
+	rmdir(TMP_DIR);
 }
 
-static void check_and_print(char *advice)
+static void verify_madvise(unsigned int i)
 {
-	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "madvise test for %s failed", advice);
-	else
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
+	struct tcase *tc = &tcases[i];
+
+	TEST(madvise(*(tc->addr), st.st_size, tc->advice));
+
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL)
+			tst_res(TCONF, "%s is not supported", tc->name);
+		else
+			tst_res(TFAIL, "madvise test for %s failed with "
+					"return = %ld, errno = %d : %s",
+					tc->name, TEST_RETURN, TEST_ERRNO,
+					tst_strerrno(TFAIL | TTERRNO));
+	} else
+		tst_res(TPASS, "madvise test for %s PASSED", tc->name);
 }
+
+static struct tst_test test = {
+	.tid = "madvise01",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_madvise,
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

