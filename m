From: j.nixdorf@avm.de <j.nixdorf@avm.de>
Date: Fri, 20 Nov 2020 12:56:56 +0100
Subject: [LTP] [PATCH v3] getdents: update to the new api,
 don't mix libc and kernel types
In-Reply-To: <20201119130046.GA12628@yuki.lan>
References: <20201119130046.GA12628@yuki.lan>,
 <20201118135852.GA13912@yuki.lan>
 <OFFFCF0315.CB01D2B7-ONC125861F.003C7A03-C1258622.0045EF86@avm.de>
 <OFFDAAA0B7.3C11EE41-ONC1258625.002F2EA3-C1258625.002FFCAE@avm.de>
Message-ID: <OF2A463655.07C868E8-ONC1258626.00412BF5-C1258626.0041A363@avm.de>
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

v2:
  - Converted to the new test API, using test_variants for all libc and
    syscall variants.

v3:
  - Added SPDX indentifers.
  - Removed superflous calls to test_brk(TCONF, ...) after
    getdents_info from getdents.h.
  - Removed tst_dirp_alloc from getdents.h.
  - Removed useless forward declarations from getdents01.c.
  - Allocate the buffer for getdents01.c through the field bufs on the
    test description object.
  - Rewrite getdents02.c in a data-driven way.

 runtest/syscalls                              |   3 -
 testcases/kernel/syscalls/getdents/getdents.h | 136 ++++++++++--
 .../kernel/syscalls/getdents/getdents01.c     | 202 +++++++-----------
 .../kernel/syscalls/getdents/getdents02.c     | 187 +++++-----------
 travis/alpine.sh                              |   2 -
 5 files changed, 247 insertions(+), 283 deletions(-)

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
index a20b1811a..560df4126 100644
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
@@ -21,9 +22,13 @@
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
@@ -34,17 +39,12 @@ struct linux_dirent {
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
@@ -53,14 +53,120 @@ struct linux_dirent64 {
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
+#if HAVE_GETDENTS
+	case 2:
+		return sizeof(struct dirent);
+#endif
 #if HAVE_GETDENTS64
-#include <dirent.h>
-#include <unistd.h>
-#else
+	case 3:
+		return sizeof(struct dirent64);
+#endif
+	}
+	return 0;
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
+#if HAVE_GETDENTS
+	case 2:
+		return ((struct dirent *)dirp)->d_name;
+#endif
+#if HAVE_GETDENTS64
+	case 3:
+		return ((struct dirent64 *)dirp)->d_name;
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
+#if HAVE_GETDENTS
+	case 2:
+		return ((struct dirent *)dirp)->d_reclen;
+#endif
+#if HAVE_GETDENTS64
+	case 3:
+		return ((struct dirent64 *)dirp)->d_reclen;
+#endif
+
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
+#if HAVE_GETDENTS
+	case 2:
+		return getdents(fd, dirp, size);
+#endif
+#if HAVE_GETDENTS64
+	case 3:
+		return getdents64(fd, dirp, size);
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
index eca572d42..81cebf76c 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	         written by Wayne Boyer
@@ -20,38 +21,17 @@
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
 
-static void cleanup(void);
-static void setup(void);
+#include <stdlib.h>
 
 static void reset_flags(void);
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
@@ -80,95 +60,48 @@ struct testcase testcases[] = {
  */
 #define BUFSIZE 512
 
-int main(int ac, char **av)
-{
-	int lc;
-	int rval, fd;
-	struct linux_dirent64 *dirp64;
-	struct linux_dirent *dirp;
-	void *buf;
-
-	tst_parse_opts(ac, av, options, &help);
-
-	/* The buffer is allocated to make sure it's suitably aligned */
-	buf = malloc(BUFSIZE);
-
-	if (buf == NULL)
-		tst_brkm(TBROK, NULL, "malloc failed");
-
-	dirp64 = buf;
-	dirp = buf;
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		const char *d_name;
-
-		tst_count = 0;
-
-		if ((fd = open(".", O_RDONLY)) == -1)
-			tst_brkm(TBROK, cleanup, "open of directory failed");
+static void *dirp;
 
-		if (longsyscall)
-			rval = getdents64(fd, dirp64, BUFSIZE);
-		else
-			rval = getdents(fd, dirp, BUFSIZE);
+static void run(void)
+{
+	int rval;
 
-		if (rval < 0) {
-			if (errno == ENOSYS)
-				tst_resm(TCONF, "syscall not implemented");
-			else
-				tst_resm(TFAIL | TERRNO,
-				         "getdents failed unexpectedly");
-			continue;
-		}
+	rval = tst_getdents(fd, dirp, BUFSIZE);
 
-		if (rval == 0) {
-			tst_resm(TFAIL,
-				 "getdents failed - returned end of directory");
-			continue;
+	if (rval < 0) {
+		if (errno == ENOSYS)
+			tst_brk(TCONF, "syscall not implemented");
+		else {
+			tst_res(TFAIL | TERRNO, "getdents failed unexpectedly");
+			return;
 		}
+	}
 
-		reset_flags();
-
-		do {
-			size_t d_reclen;
-
-			if (longsyscall) {
-				d_reclen = dirp64->d_reclen;
-				d_name = dirp64->d_name;
-			} else {
-				d_reclen = dirp->d_reclen;
-				d_name = dirp->d_name;
-			}
+	if (rval == 0) {
+		tst_res(TFAIL, "getdents failed - returned end of directory");
+		return;
+	}
 
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
@@ -176,24 +109,25 @@ static void reset_flags(void)
 
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
@@ -202,39 +136,51 @@ static void set_flag(const char *name)
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
+	.bufs = (struct tst_buffers []) {
+		{&dirp, .size = BUFSIZE},
+		{},
+	},
+	.test_variants = TEST_VARIANTS,
+};
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 4cf54aea3..42691f5f0 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *	         written by Wayne Boyer
@@ -34,164 +35,80 @@
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
-static void print_test_result(int err, int exp_errno);
-
 char *TCID = "getdents02";
 
-static void test_ebadf(void);
-static void test_einval(void);
-static void test_enotdir(void);
-static void test_enoent(void);
-
-static void (*testfunc[])(void) = { test_ebadf, test_einval,
-				    test_enotdir, test_enoent };
-
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-static int longsyscall;
-
-option_t options[] = {
-		/* -l long option. Tests getdents64 */
-		{"l", &longsyscall, NULL},
-		{NULL, NULL, NULL}
+static char *dirp;
+static size_t size;
+
+static char dirp1_arr[1];
+static char *dirp1 = dirp1_arr;
+static size_t size1 = 1;
+
+static int fd_inv = -5;
+static int fd;
+static int fd_file;
+static int fd_unlinked;
+
+static struct tcase {
+	int *fd;
+	char **dirp;
+	size_t *size;
+	int exp_errno;
+} tcases[] = {
+	{ &fd_inv, &dirp, &size, EBADF },
+	{ &fd, &dirp1, &size1, EINVAL },
+	{ &fd_file, &dirp, &size, ENOTDIR },
+	{ &fd_unlinked, &dirp, &size, ENOENT },
 };
 
-static void help(void)
-{
-	printf("  -l      Test the getdents64 system call\n");
-}
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc, i;
+	getdents_info();
 
-	tst_parse_opts(ac, av, options, &help);
+	size = tst_dirp_size();
+	dirp = tst_alloc(size);
 
-	setup();
+	fd = SAFE_OPEN(".", O_RDONLY);
+	fd_file = SAFE_OPEN("test", O_CREAT | O_RDWR, 0644);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+	SAFE_MKDIR(TEST_DIR, DIR_MODE);
+	fd_unlinked = SAFE_OPEN(TEST_DIR, O_DIRECTORY);
+	SAFE_RMDIR(TEST_DIR);
 
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
 }
 
-static void setup(void)
+static void run(unsigned int i)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct tcase *tc = tcases + i;
 
-	tst_tmpdir();
+	tst_getdents(*tc->fd, *tc->dirp, *tc->size);
 
-	TEST_PAUSE;
-}
-
-static void print_test_result(int err, int exp_errno)
-{
-	if (err == 0) {
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	} else if  (err == exp_errno) {
-		tst_resm(TPASS, "getdents failed as expected: %s",
-			 strerror(err));
-	} else if (err == ENOSYS) {
-		tst_resm(TCONF, "syscall not implemented");
+	if (errno == 0) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+	} else if (errno == tc->exp_errno) {
+		tst_res(TPASS, "getdents failed as expected: %s",
+			 strerror(errno));
+	} else if (errno == ENOSYS) {
+		tst_res(TCONF, "syscall not implemented");
 	} else {
-		tst_resm(TFAIL, "getdents failed unexpectedly: %s",
-			 strerror(err));
+		tst_res(TFAIL, "getdents failed unexpectedly: %s",
+			 strerror(errno));
 	}
 }
 
-static void test_ebadf(void)
-{
-	int fd = -5;
-	struct linux_dirent64 dirp64;
-	struct linux_dirent dirp;
-
-	if (longsyscall)
-		getdents64(fd, &dirp64, sizeof(dirp64));
-	else
-		getdents(fd, &dirp, sizeof(dirp));
-
-	print_test_result(errno, EBADF);
-}
-
-static void test_einval(void)
-{
-	int fd;
-	char buf[1];
-
-	fd = SAFE_OPEN(cleanup, ".", O_RDONLY);
-
-	/* Pass one byte long buffer. The result should be EINVAL */
-	if (longsyscall)
-		getdents64(fd, (void *)buf, sizeof(buf));
-	else
-		getdents(fd, (void *)buf, sizeof(buf));
-
-	print_test_result(errno, EINVAL);
-
-	SAFE_CLOSE(cleanup, fd);
-}
-
-static void test_enotdir(void)
-{
-	int fd;
-	struct linux_dirent64 dir64;
-	struct linux_dirent dir;
-
-	fd = SAFE_OPEN(cleanup, "test", O_CREAT | O_RDWR, 0644);
-
-	if (longsyscall)
-		getdents64(fd, &dir64, sizeof(dir64));
-	else
-		getdents(fd, &dir, sizeof(dir));
-
-	print_test_result(errno, ENOTDIR);
-
-	SAFE_CLOSE(cleanup, fd);
-}
-
-static void test_enoent(void)
-{
-	int fd;
-	struct linux_dirent64 dir64;
-	struct linux_dirent dir;
-
-	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
-
-	fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	SAFE_RMDIR(cleanup, TEST_DIR);
-
-	if (longsyscall)
-		getdents64(fd, &dir64, sizeof(dir64));
-	else
-		getdents(fd, &dir, sizeof(dir));
-
-	print_test_result(errno, ENOENT);
-
-	SAFE_CLOSE(cleanup, fd);
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
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

