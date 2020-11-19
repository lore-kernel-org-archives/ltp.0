From: j.nixdorf@avm.de <j.nixdorf@avm.de>
Date: Thu, 19 Nov 2020 09:44:08 +0100
Subject: [LTP] [PATCH v2] getdents: update to new api,
 don't mix libc and kernel types
In-Reply-To: <20201118135852.GA13912@yuki.lan>
References: <20201118135852.GA13912@yuki.lan>,
 <OFFFCF0315.CB01D2B7-ONC125861F.003C7A03-C1258622.0045EF86@avm.de>
Message-ID: <OFFDAAA0B7.3C11EE41-ONC1258625.002F2EA3-C1258625.002FFCAE@avm.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Before this commit the tests called libc's getdents(64) with the kernel
types struct linux_dirent(64) as arguments, mixing libc functions and
kernel types.

This breaks on musl libc, as it provides getdents and struct dirent as
an alias to getdents64 and struct dirent64.

To not lose coverage we now test both supported configurations: the
syscall with the kernel types and the libc wrappers with the libc types.

To take advantage of support for multiple test_variants the tests were
converted to the new test API at the same time.

Signed-off-by: Johannes Nixdorf <j.nixdorf@avm.de>

---

v2: Converted to the new test API, using test_variants for all libc and
    syscall variants.

 runtest/syscalls                              |   3 -
 testcases/kernel/syscalls/getdents/getdents.h | 162 +++++++++++++--
 .../kernel/syscalls/getdents/getdents01.c     | 191 +++++++-----------
 .../kernel/syscalls/getdents/getdents02.c     | 111 +++-------
 travis/alpine.sh                              |   2 -
 5 files changed, 248 insertions(+), 221 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 0443f9f3d..8f2fe0db2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -410,9 +410,6 @@ getcwd04 getcwd04
 getdents01 getdents01
 getdents02 getdents02
 
-getdents01_64 getdents01 -l
-getdents02_64 getdents02 -l
-
 getdomainname01 getdomainname01
 
 getdtablesize01 getdtablesize01
diff --git a/testcases/kernel/syscalls/getdents/getdents.h b/testcases/kernel/syscalls/getdents/getdents.h
index a20b1811a..9a4f88d7d 100644
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -21,9 +21,13 @@
 #define GETDENTS_H
 
 #include <stdint.h>
-#include "test.h"
-#include "lapi/syscalls.h"
 #include "config.h"
+#include "lapi/syscalls.h"
+
+#if HAVE_GETDENTS || HAVE_GETDENTS64
+#include <unistd.h>
+#endif
+
 /*
  * See fs/compat.c struct compat_linux_dirent
  */
@@ -34,17 +38,12 @@ struct linux_dirent {
 	char            d_name[];
 };
 
-#if HAVE_GETDENTS
-#include <unistd.h>
-#else
 static inline int
-getdents(unsigned int fd, struct linux_dirent *dirp, unsigned int size)
+linux_getdents(unsigned int fd, struct linux_dirent *dirp, unsigned int size)
 {
-	return ltp_syscall(__NR_getdents, fd, dirp, size);
+	return tst_syscall(__NR_getdents, fd, dirp, size);
 }
 
-#endif /* HAVE_GETDENTS */
-
 struct linux_dirent64 {
 	uint64_t	d_ino;
 	int64_t		d_off;
@@ -53,14 +52,149 @@ struct linux_dirent64 {
 	char		d_name[];
 };
 
+static inline int
+linux_getdents64(unsigned int fd, struct linux_dirent64 *dirp64, unsigned int size)
+{
+	return tst_syscall(__NR_getdents64, fd, dirp64, size);
+}
+
+static inline size_t
+tst_dirp_size(void)
+{
+	switch (tst_variant) {
+	case 0:
+		return sizeof(struct linux_dirent);
+	case 1:
+		return sizeof(struct linux_dirent64);
+	case 2:
+#if HAVE_GETDENTS
+		return sizeof(struct dirent);
+#else
+		tst_brk(TCONF, "libc getdents() is not implemented");
+		break;
+#endif
+	case 3:
 #if HAVE_GETDENTS64
-#include <dirent.h>
-#include <unistd.h>
+		return sizeof(struct dirent64);
+#else
+		tst_brk(TCONF, "libc getdents64() is not implemented");
+		break;
+#endif
+	}
+	return 0;
+}
+
+static inline void *
+tst_dirp_alloc(void)
+{
+	return tst_alloc(tst_dirp_size());
+}
+
+static inline const char *
+tst_dirp_name(void *dirp)
+{
+	switch (tst_variant) {
+	case 0:
+		return ((struct linux_dirent *)dirp)->d_name;
+	case 1:
+		return ((struct linux_dirent64 *)dirp)->d_name;
+	case 2:
+#if HAVE_GETDENTS
+		return ((struct dirent *)dirp)->d_name;
 #else
+		tst_brk(TCONF, "libc getdents() is not implemented");
+		break;
+#endif
+	case 3:
+#if HAVE_GETDENTS64
+		return ((struct dirent64 *)dirp)->d_name;
+#else
+		tst_brk(TCONF, "libc getdents64() is not implemented");
+		break;
+#endif
+	}
+	return NULL;
+}
+
+static inline size_t
+tst_dirp_reclen(void *dirp)
+{
+	switch (tst_variant) {
+	case 0:
+		return ((struct linux_dirent *)dirp)->d_reclen;
+	case 1:
+		return ((struct linux_dirent64 *)dirp)->d_reclen;
+	case 2:
+#if HAVE_GETDENTS
+		return ((struct dirent *)dirp)->d_reclen;
+#else
+		tst_brk(TCONF, "libc getdents() is not implemented");
+		break;
+#endif
+	case 3:
+#if HAVE_GETDENTS64
+		return ((struct dirent64 *)dirp)->d_reclen;
+#else
+		tst_brk(TCONF, "libc getdents64() is not implemented");
+		break;
+#endif
+	}
+	return 0;
+}
+
 static inline int
-getdents64(unsigned int fd, struct linux_dirent64 *dirp64, unsigned int size)
+tst_getdents(int fd, void *dirp, unsigned int size)
+{
+	switch (tst_variant) {
+	case 0:
+		return linux_getdents(fd, dirp, size);
+	case 1:
+		return linux_getdents64(fd, dirp, size);
+	case 2:
+#if HAVE_GETDENTS
+		return getdents(fd, dirp, size);
+#else
+		tst_brk(TCONF, "libc getdents() is not implemented");
+		break;
+#endif
+	case 3:
+#if HAVE_GETDENTS64
+		return getdents64(fd, dirp, size);
+#else
+		tst_brk(TCONF, "libc getdents64() is not implemented");
+		break;
+#endif
+	}
+	return -1;
+}
+
+static inline void
+getdents_info(void)
 {
-	return ltp_syscall(__NR_getdents64, fd, dirp64, size);
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing the SYS_getdents syscall");
+		break;
+	case 1:
+		tst_res(TINFO, "Testing the SYS_getdents64 syscall");
+		break;
+	case 2:
+#if HAVE_GETDENTS
+		tst_res(TINFO, "Testing libc getdents()");
+#else
+		tst_brk(TCONF, "libc getdents() is not implemented");
+#endif
+		break;
+	case 3:
+#if HAVE_GETDENTS64
+		tst_res(TINFO, "Testing libc getdents64()");
+#else
+		tst_brk(TCONF, "libc getdents64() is not implemented");
+#endif
+		break;
+	}
 }
-#endif /* HAVE_GETDENTS64 */
+
+#define TEST_VARIANTS 4
+
 #endif /* GETDENTS_H */
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index eca572d42..bdf939ab0 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -20,16 +20,12 @@
  */
 
 #define _GNU_SOURCE
-#include <stdio.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "test.h"
-#include "safe_macros.h"
+
+#include "tst_test.h"
 #include "getdents.h"
 
+#include <stdlib.h>
+
 static void cleanup(void);
 static void setup(void);
 
@@ -37,21 +33,7 @@ static void reset_flags(void);
 static void check_flags(void);
 static void set_flag(const char *name);
 
-char *TCID = "getdents01";
-int TST_TOTAL = 1;
-
-static int longsyscall;
-
-static option_t options[] = {
-		/* -l long option. Tests getdents64 */
-		{"l", &longsyscall, NULL},
-		{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("  -l      Test the getdents64 system call\n");
-}
+static int fd;
 
 enum entry_type {
 	ENTRY_DIR,
@@ -80,95 +62,49 @@ struct testcase testcases[] = {
  */
 #define BUFSIZE 512
 
-int main(int ac, char **av)
+void run(void)
 {
-	int lc;
-	int rval, fd;
-	struct linux_dirent64 *dirp64;
-	struct linux_dirent *dirp;
-	void *buf;
-
-	tst_parse_opts(ac, av, options, &help);
+	int rval;
+	void *dirp;
 
 	/* The buffer is allocated to make sure it's suitably aligned */
-	buf = malloc(BUFSIZE);
-
-	if (buf == NULL)
-		tst_brkm(TBROK, NULL, "malloc failed");
-
-	dirp64 = buf;
-	dirp = buf;
+	dirp = tst_alloc(BUFSIZE);
 
-	setup();
+	if (dirp == NULL)
+		tst_brk(TBROK, "malloc failed");
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		const char *d_name;
+	rval = tst_getdents(fd, dirp, BUFSIZE);
 
-		tst_count = 0;
-
-		if ((fd = open(".", O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open of directory failed");
-
-		if (longsyscall)
-			rval = getdents64(fd, dirp64, BUFSIZE);
+	if (rval < 0) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "syscall not implemented");
 		else
-			rval = getdents(fd, dirp, BUFSIZE);
-
-		if (rval < 0) {
-			if (errno == ENOSYS)
-				tst_resm(TCONF, "syscall not implemented");
-			else
-				tst_resm(TFAIL | TERRNO,
-				         "getdents failed unexpectedly");
-			continue;
-		}
-
-		if (rval == 0) {
-			tst_resm(TFAIL,
-				 "getdents failed - returned end of directory");
-			continue;
-		}
-
-		reset_flags();
-
-		do {
-			size_t d_reclen;
+			tst_brk(TFAIL | TERRNO, "getdents failed unexpectedly");
+	}
 
-			if (longsyscall) {
-				d_reclen = dirp64->d_reclen;
-				d_name = dirp64->d_name;
-			} else {
-				d_reclen = dirp->d_reclen;
-				d_name = dirp->d_name;
-			}
+	if (rval == 0)
+		tst_brk(TFAIL, "getdents failed - returned end of directory");
 
-			set_flag(d_name);
+	reset_flags();
 
-			tst_resm(TINFO, "Found '%s'", d_name);
-			
-			rval -= d_reclen;
-			
-			if (longsyscall)
-				dirp64 = (void*)dirp64 + d_reclen;
-			else
-				dirp = (void*)dirp + d_reclen;
+	do {
+		size_t d_reclen = tst_dirp_reclen(dirp);
+		const char *d_name = tst_dirp_name(dirp);
 
-		} while (rval > 0);
+		set_flag(d_name);
 
-		SAFE_CLOSE(cleanup, fd);
-	
-		check_flags();
-	}
+		tst_res(TINFO, "Found '%s'", d_name);
 
-	free(buf);
+		rval -= d_reclen;
+		dirp += d_reclen;
+	} while (rval > 0);
 
-	cleanup();
-	tst_exit();
+	check_flags();
 }
 
 static void reset_flags(void)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++)
 		testcases[i].found = 0;
@@ -176,24 +112,25 @@ static void reset_flags(void)
 
 static void check_flags(void)
 {
-	int i, err = 0;
+	size_t i;
+	int err = 0;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		if (!testcases[i].found) {
-			tst_resm(TINFO, "Entry '%s' not found", testcases[i].name);
+			tst_res(TINFO, "Entry '%s' not found", testcases[i].name);
 			err++;
 		}
 	}
 
 	if (err)
-		tst_resm(TFAIL, "Some entires not found");
+		tst_res(TFAIL, "Some entries not found");
 	else
-		tst_resm(TPASS, "All entires found");
+		tst_res(TPASS, "All entries found");
 }
 
 static void set_flag(const char *name)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
 		if (!strcmp(name, testcases[i].name)) {
@@ -202,39 +139,47 @@ static void set_flag(const char *name)
 		}
 	}
 
-	tst_resm(TFAIL, "Unexpected entry '%s' found", name);
+	tst_res(TFAIL, "Unexpected entry '%s' found", name);
 }
 
 static void setup(void)
 {
-	int i;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
-		
-		if (!testcases[i].create)
-			continue;
-	
-		switch (testcases[i].type) {
-		case ENTRY_DIR:
-			SAFE_MKDIR(cleanup, testcases[i].name, 0777);
-		break;
-		case ENTRY_FILE:
-			SAFE_FILE_PRINTF(cleanup, testcases[i].name, " ");
-		break;
-		case ENTRY_SYMLINK:
-			SAFE_SYMLINK(cleanup, "nonexistent", testcases[i].name);
-		break;
+	size_t i;
+
+	getdents_info();
+
+	if (!tst_variant) {
+		for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+			if (!testcases[i].create)
+				continue;
+
+			switch (testcases[i].type) {
+			case ENTRY_DIR:
+				SAFE_MKDIR(testcases[i].name, 0777);
+			break;
+			case ENTRY_FILE:
+				SAFE_FILE_PRINTF(testcases[i].name, " ");
+			break;
+			case ENTRY_SYMLINK:
+				SAFE_SYMLINK("nonexistent", testcases[i].name);
+			break;
+			}
 		}
 	}
 
-	TEST_PAUSE;
+	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
 }
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	if (fd != 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 4cf54aea3..82932b7b1 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -34,22 +34,15 @@
  */
 
 #define _GNU_SOURCE
-#include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "getdents.h"
-#include "safe_macros.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define TEST_DIR	"test_dir"
 
-static void cleanup(void);
-static void setup(void);
 static void print_test_result(int err, int exp_errno);
 
 char *TCID = "getdents02";
@@ -64,58 +57,33 @@ static void (*testfunc[])(void) = { test_ebadf, test_einval,
 
 int TST_TOTAL = ARRAY_SIZE(testfunc);
 
-static int longsyscall;
+static void *dirp;
+static size_t size;
 
-option_t options[] = {
-		/* -l long option. Tests getdents64 */
-		{"l", &longsyscall, NULL},
-		{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("  -l      Test the getdents64 system call\n");
-}
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, options, &help);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	getdents_info();
 
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
+	dirp = tst_dirp_alloc();
+	size = tst_dirp_size();
 }
 
-static void setup(void)
+static void run(unsigned int i)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	TEST_PAUSE;
+	testfunc[i]();
 }
 
 static void print_test_result(int err, int exp_errno)
 {
 	if (err == 0) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
+		tst_res(TFAIL, "call succeeded unexpectedly");
 	} else if  (err == exp_errno) {
-		tst_resm(TPASS, "getdents failed as expected: %s",
+		tst_res(TPASS, "getdents failed as expected: %s",
 			 strerror(err));
 	} else if (err == ENOSYS) {
-		tst_resm(TCONF, "syscall not implemented");
+		tst_res(TCONF, "syscall not implemented");
 	} else {
-		tst_resm(TFAIL, "getdents failed unexpectedly: %s",
+		tst_res(TFAIL, "getdents failed unexpectedly: %s",
 			 strerror(err));
 	}
 }
@@ -123,13 +91,8 @@ static void print_test_result(int err, int exp_errno)
 static void test_ebadf(void)
 {
 	int fd = -5;
-	struct linux_dirent64 dirp64;
-	struct linux_dirent dirp;
 
-	if (longsyscall)
-		getdents64(fd, &dirp64, sizeof(dirp64));
-	else
-		getdents(fd, &dirp, sizeof(dirp));
+	tst_getdents(fd, dirp, size);
 
 	print_test_result(errno, EBADF);
 }
@@ -139,59 +102,49 @@ static void test_einval(void)
 	int fd;
 	char buf[1];
 
-	fd = SAFE_OPEN(cleanup, ".", O_RDONLY);
+	fd = SAFE_OPEN(".", O_RDONLY);
 
 	/* Pass one byte long buffer. The result should be EINVAL */
-	if (longsyscall)
-		getdents64(fd, (void *)buf, sizeof(buf));
-	else
-		getdents(fd, (void *)buf, sizeof(buf));
+	tst_getdents(fd, (void *)buf, sizeof(buf));
 
 	print_test_result(errno, EINVAL);
 
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
 static void test_enotdir(void)
 {
 	int fd;
-	struct linux_dirent64 dir64;
-	struct linux_dirent dir;
 
-	fd = SAFE_OPEN(cleanup, "test", O_CREAT | O_RDWR, 0644);
+	fd = SAFE_OPEN("test", O_CREAT | O_RDWR, 0644);
 
-	if (longsyscall)
-		getdents64(fd, &dir64, sizeof(dir64));
-	else
-		getdents(fd, &dir, sizeof(dir));
+	tst_getdents(fd, dirp, size);
 
 	print_test_result(errno, ENOTDIR);
 
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
 static void test_enoent(void)
 {
 	int fd;
-	struct linux_dirent64 dir64;
-	struct linux_dirent dir;
 
-	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
+	SAFE_MKDIR(TEST_DIR, DIR_MODE);
 
-	fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	SAFE_RMDIR(cleanup, TEST_DIR);
+	fd = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	SAFE_RMDIR(TEST_DIR);
 
-	if (longsyscall)
-		getdents64(fd, &dir64, sizeof(dir64));
-	else
-		getdents(fd, &dir, sizeof(dir));
+	tst_getdents(fd, dirp, size);
 
 	print_test_result(errno, ENOENT);
 
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(testfunc),
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/travis/alpine.sh b/travis/alpine.sh
index 61ef144a8..ffd5a8ebc 100755
--- a/travis/alpine.sh
+++ b/travis/alpine.sh
@@ -33,8 +33,6 @@ rm -rfv \
 	testcases/kernel/syscalls/confstr/confstr01.c \
 	testcases/kernel/syscalls/fmtmsg/fmtmsg01.c \
 	testcases/kernel/syscalls/getcontext/getcontext01.c \
-	testcases/kernel/syscalls/getdents/getdents01.c \
-	testcases/kernel/syscalls/getdents/getdents02.c \
 	testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c \
 	testcases/kernel/syscalls/timer_create/timer_create01.c \
 	testcases/kernel/syscalls/timer_create/timer_create03.c \
-- 
2.17.1

