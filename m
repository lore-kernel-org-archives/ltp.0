Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UhddA-0004Jt-Le
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 10:29:20 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uhdd7-0008V8-CH
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 10:29:20 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4TATBmK026128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 May 2013 10:29:11 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4TATAVo017159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 29 May 2013 10:29:10 GMT
Received: from abhmt118.oracle.com (abhmt118.oracle.com [141.146.116.70])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4TAT93Q021313
	for <ltp-list@lists.sourceforge.net>; Wed, 29 May 2013 10:29:09 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 29 May 2013 14:28:29 +0400
Message-Id: <1369823309-29965-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] New core test of cgroups and extended attributes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, Alexey Kodanev <alexey.kodanev@oracle.com>

Support of extended attributes in cgroups was added in Linux 3.7.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/controllers                                |    1 +
 .../kernel/controllers/cgroup_xattr/.gitignore     |    1 +
 testcases/kernel/controllers/cgroup_xattr/Makefile |   19 +
 testcases/kernel/controllers/cgroup_xattr/README   |   25 ++
 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |  435 ++++++++++++++++++++
 5 files changed, 481 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/controllers/cgroup_xattr/.gitignore
 create mode 100644 testcases/kernel/controllers/cgroup_xattr/Makefile
 create mode 100644 testcases/kernel/controllers/cgroup_xattr/README
 create mode 100644 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c

diff --git a/runtest/controllers b/runtest/controllers
index b78d828..94fc185 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -12,3 +12,4 @@ memcg_stress		memcg_stress_test.sh
 memcg_control		PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
 cgroup_fj	run_cgroup_test_fj.sh
 controllers	test_controllers.sh
+cgroup_xattr	cgroup_xattr
diff --git a/testcases/kernel/controllers/cgroup_xattr/.gitignore b/testcases/kernel/controllers/cgroup_xattr/.gitignore
new file mode 100644
index 0000000..3664cc9
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_xattr/.gitignore
@@ -0,0 +1 @@
+/cgroup_xattr
diff --git a/testcases/kernel/controllers/cgroup_xattr/Makefile b/testcases/kernel/controllers/cgroup_xattr/Makefile
new file mode 100644
index 0000000..cd49588
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_xattr/Makefile
@@ -0,0 +1,19 @@
+# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA 
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/cgroup_xattr/README b/testcases/kernel/controllers/cgroup_xattr/README
new file mode 100644
index 0000000..5aff0a8
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_xattr/README
@@ -0,0 +1,25 @@
+TEST SUITE:
+
+The directory cgroup_xattr contains the tests related to extended
+attributes in cgroup filesystem.
+
+WARNING:
+
+This test can cause a kernel panic due to a bug in kernels prior to 3.8.
+It was fixed by kernel upstream commit
+712317ad97f41e738e1a19aa0a6392a78a84094e:
+
+"We should store file xattrs in struct cfent instead of struct cftype,
+because cftype is a type while cfent is object instance of cftype."
+
+TESTS AIM:
+
+The aim of the tests is to check the extended attributes in cgroup
+filesystem. This feature was added in Linux 3.7 to allow attaching runtime
+meta information to cgroups and everything they model (services, apps, vms)
+and can easily be shared among applications.
+
+Test mounts as many subsystems as possible (cpu, cpuset, ...) in the
+cgroup tmp directory and creates one more hierarchy. Then sets extended
+attributes to all files in cgroup fs and subsequently reads the file's
+extended attributes back, checking values during the process.
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
new file mode 100644
index 0000000..20473d4
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -0,0 +1,435 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author:
+ * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *
+ * Test checks following preconditions:
+ * since Linux kernel 3.7 it is possible to set extended attributes
+ * to cgroup files.
+ */
+
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "cgroup_xattr";
+
+static const char subdir_name[]	= "test";
+
+#define MAX_SUBSYS		16
+#define MAX_OPTIONS_LEN		256
+#define MAX_DIR_NAME		64
+
+/* struct to store available mount options */
+struct cgrp_option {
+	char str[MAX_OPTIONS_LEN];
+	char dir[MAX_DIR_NAME];
+	int hier;
+	int mounted;
+	int subdir;
+};
+static struct cgrp_option cgrp_opt[MAX_SUBSYS];
+static int cgrp_opt_num;
+
+struct tst_key {
+	const char *name;
+	int good;
+};
+
+/* only security.* & trusted.* are valid key names */
+static const struct tst_key tkeys[] = {
+	{ .name = "trusted.test",	.good = 1,	},
+	{ .name = "security.",		.good = 1,	},
+	{ .name = "user.",		.good = 0,	},
+	{ .name = "system.",		.good = 0,	},
+};
+
+#define DEFAULT_VALUE_SIZE	8
+
+/* struct to store key's value */
+struct tst_val {
+	char *buf;
+	size_t size;
+};
+static struct tst_val val;
+
+/* it fills value's buffer */
+static char id;
+
+/*
+ * When test breaks, all open dirs should be closed
+ * otherwise umount won't succeed
+ */
+#define MAX_OPEN_DIR		32
+static DIR *odir[MAX_OPEN_DIR];
+static int odir_num;
+
+/* test options */
+static char *narg;
+static int nflag;
+static int skip_cleanup;
+static int verbose;
+static const option_t options[] = {
+	{"n:", &nflag, &narg},
+	{"s", &skip_cleanup, NULL},
+	{"v", &verbose, NULL},
+	{NULL, NULL, NULL}
+};
+
+static void help(void);
+static void setup(int argc, char *argv[]);
+static void test_run(void);
+static void cleanup(void);
+
+static int mount_cgroup(void);
+static int set_xattrs(const char *file);
+static int get_xattrs(const char *file);
+/*
+ * set or get xattr recursively
+ *
+ * @path: start directory
+ * @xattr_operation: can be set_xattrs() or get_xattrs()
+ */
+static int cgrp_files_walking(const char *path,
+	int (*xattr_operation)(const char *));
+
+int main(int argc, char *argv[])
+{
+	setup(argc, argv);
+
+	test_run();
+
+	cleanup();
+
+	tst_exit();
+}
+
+static void help(void)
+{
+	printf("  -n x    Write x bytes to xattr value, default is %d\n",
+		DEFAULT_VALUE_SIZE);
+	printf("  -s      Skip cleanup\n");
+	printf("  -v      Verbose\n");
+}
+
+void setup(int argc, char *argv[])
+{
+	char *msg;
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	tst_require_root(NULL);
+
+	if (access("/proc/cgroups", F_OK) == -1)
+		tst_brkm(TCONF, NULL, "Kernel doesn't support cgroups");
+
+	if (tst_kvercmp(3, 7, 0) < 0) {
+		tst_brkm(TCONF, NULL,
+			"Test must be run with kernel 3.7 or newer");
+	}
+
+	int value_size = DEFAULT_VALUE_SIZE;
+	if (nflag) {
+		if (sscanf(narg, "%i", &value_size) != 1)
+			tst_brkm(TBROK, NULL, "-n option arg is not a number");
+		if (value_size <= 0)
+			tst_brkm(TBROK, NULL, "-n option arg is less than 1");
+	}
+
+	/* initialize test value */
+	val.size = value_size;
+	val.buf = SAFE_MALLOC(NULL, value_size);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
+	if (!mount_cgroup())
+		tst_brkm(TCONF, cleanup, "Nothing  mounted");
+}
+
+static void test_run(void)
+{
+	int i, set_res = 0, get_res = 0;
+
+	for (i = 0; i < cgrp_opt_num; ++i) {
+		if (!cgrp_opt[i].mounted)
+			continue;
+
+		SAFE_CHDIR(cleanup, cgrp_opt[i].dir);
+		/* reset value */
+		id = 0;
+		/* set xattr to each file in cgroup fs */
+		set_res |= cgrp_files_walking(".", set_xattrs);
+
+		id = 0;
+		/* get & check xattr */
+		get_res |= cgrp_files_walking(".", get_xattrs);
+		SAFE_CHDIR(cleanup, "..");
+	}
+
+	/* final results */
+	tst_resm(TINFO, "All test-cases have been completed, summary:");
+	tst_resm(TINFO, "Set tests result: %s", (set_res) ? "FAIL" : "PASS");
+	tst_resm(TINFO, "Get tests result: %s", (get_res) ? "FAIL" : "PASS");
+}
+
+static void cleanup(void)
+{
+	if (val.buf != NULL)
+		free(val.buf);
+
+	if (skip_cleanup)
+		return;
+
+	/*
+	 * Kernels 3.7 can crash while unmounting cgroups with xattr,
+	 * call tst_flush() to make sure all buffered data written
+	 * before it happens
+	 */
+	tst_flush();
+
+	int i;
+	for (i = 0; i < odir_num; ++i) {
+		if (closedir(odir[i]) == -1)
+			tst_brkm(TBROK, NULL, "Failed to close dir\n");
+	}
+
+	char *cwd = get_tst_tmpdir();
+	SAFE_CHDIR(NULL, cwd);
+	free(cwd);
+
+	for (i = 0; i < cgrp_opt_num; ++i) {
+		if (cgrp_opt[i].subdir) {
+			SAFE_CHDIR(NULL, cgrp_opt[i].dir);
+			if (rmdir(subdir_name) == -1) {
+				tst_brkm(TBROK | TERRNO, NULL,
+					"Can't remove dir");
+			}
+			SAFE_CHDIR(NULL, "..");
+		}
+		if (cgrp_opt[i].mounted) {
+			if (umount(cgrp_opt[i].dir) == -1) {
+				tst_brkm(TBROK | TERRNO, NULL,
+					"Can't unmount: %s", cgrp_opt[i].dir);
+			}
+		}
+	}
+
+	tst_rmdir();
+	TEST_CLEANUP;
+}
+
+int mount_cgroup(void)
+{
+	FILE *fd = fopen("/proc/cgroups", "r");
+	if (fd == NULL)
+		tst_brkm(TBROK, cleanup, "Failed to read /proc/cgroups");
+	char str[MAX_DIR_NAME], name[MAX_DIR_NAME];
+	int hier = 0, num = 0, enabled = 0, first = 1;
+	/* make mount options */
+	while ((fgets(str, MAX_DIR_NAME, fd)) != NULL) {
+		/* skip first line */
+		if (first) {
+			first = 0;
+			continue;
+		}
+		if (sscanf(str, "%s\t%d\t%d\t%d",
+			name, &hier, &num, &enabled) != 4)
+			tst_brkm(TBROK, cleanup, "Can't parse /proc/cgroups");
+		if (!enabled)
+			continue;
+
+		/* BUG WORKAROUND
+		 * Only mount those subsystems, which are not mounted yet.
+		 * It's a workaround to a bug when mount doesn't return any err
+		 * code while mounting already mounted subsystems, but with
+		 * additional "xattr" option. In that case, mount will succeed,
+		 * but xattr won't be supported in the new mount anyway.
+		 * Should be removed as soon as a fix committed to upstream.
+		 */
+		if (hier != 0)
+			continue;
+
+		int i, found = 0;
+		for (i = 0; i < cgrp_opt_num; ++i) {
+			if (cgrp_opt[i].hier == hier) {
+				found = 1;
+				break;
+			}
+		}
+		if (!found) {
+			i = cgrp_opt_num++;
+			cgrp_opt[i].hier = hier;
+		}
+		char *str = cgrp_opt[i].str;
+		if (str[0] == '\0')
+			strcpy(str, "xattr");
+		snprintf(str + strlen(str), MAX_OPTIONS_LEN - strlen(str),
+			",%s", name);
+	}
+	fclose(fd);
+
+	int i, any_mounted = 0;
+	for (i = 0; i < cgrp_opt_num; ++i) {
+		char dir[MAX_DIR_NAME];
+		struct cgrp_option *opt = &cgrp_opt[i];
+		tst_resm(TINFO, "mount options %d: %s (hier = %d)",
+			i, opt->str, opt->hier);
+		snprintf(opt->dir, MAX_DIR_NAME, "cgx_%d", opt->hier);
+		SAFE_MKDIR(cleanup, opt->dir, 0755);
+
+		if (mount(opt->dir, opt->dir, "cgroup", 0, opt->str) == -1) {
+			tst_resm(TINFO, "Can't mount: %s", dir);
+			continue;
+		}
+
+		any_mounted = 1;
+		opt->mounted = 1;
+
+		/* create new hierarchy */
+		SAFE_CHDIR(cleanup, opt->dir);
+		SAFE_MKDIR(cleanup, subdir_name, 0755);
+		opt->subdir = 1;
+		SAFE_CHDIR(cleanup, "..");
+	}
+	return any_mounted;
+}
+
+static int set_xattrs(const char *file)
+{
+	int i, err, fail, res = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
+		err = setxattr(file, tkeys[i].name,
+			(const void *)val.buf, val.size, 0) == -1;
+
+		fail = err && tkeys[i].good;
+		res |= fail;
+
+		tst_resm((fail) ? TFAIL : TPASS,
+			"Expect: %s set xattr key '%s' to file '%s'",
+			(tkeys[i].good) ? "can" : "can't",
+			tkeys[i].name, file);
+
+		if (verbose && tkeys[i].good)
+			tst_resm_hexd(TINFO, val.buf, val.size, "value:");
+	}
+	return res;
+}
+
+static int get_xattrs(const char *file)
+{
+	int i, fail, res = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
+		/* get value size */
+		ssize_t size = getxattr(file, tkeys[i].name, NULL, 0);
+		fail = (size == -1 && tkeys[i].good);
+		res |= fail;
+
+		tst_resm((fail) ? TFAIL : TPASS,
+			"Expect: %s read xattr %s of file '%s'",
+			(tkeys[i].good) ? "can" : "can't",
+			tkeys[i].name, file);
+
+		if (fail || size == -1)
+			continue;
+
+		/* get xattr value */
+		char xval[size];
+		if (getxattr(file, tkeys[i].name, xval, size) == -1) {
+			tst_brkm(TBROK, cleanup,
+				"Can't get buffer of key %s",
+				tkeys[i].name);
+		}
+		fail = val.size != size ||
+			strncmp(val.buf, xval, val.size) != 0;
+		res |= fail;
+
+		tst_resm((fail) ? TFAIL : TPASS, "Expect: values equal");
+
+		if (verbose && fail) {
+			tst_resm_hexd(TINFO, xval, size,
+				"Read  xattr  value:");
+			tst_resm_hexd(TINFO, val.buf, val.size,
+				"Expect xattr value:");
+		}
+	}
+	return res;
+}
+
+static int cgrp_files_walking(const char *path,
+	int (*xattr_operation)(const char *))
+{
+	int res = 0;
+	struct dirent *entry;
+	DIR *dir = opendir(path);
+
+	odir[odir_num] = dir;
+	if (++odir_num >= MAX_OPEN_DIR) {
+		tst_brkm(TBROK, cleanup,
+			"Unexpected num of open dirs, max: %d", MAX_OPEN_DIR);
+	}
+
+	SAFE_CHDIR(cleanup, path);
+
+	tst_resm(TINFO, "In dir %s", path);
+
+	errno = 0;
+	while ((entry = readdir(dir)) != NULL) {
+		const char *file = entry->d_name;
+		/* skip current and up directories */
+		if (!strcmp(file, "..") || !strcmp(file, "."))
+			continue;
+		struct stat stat_buf;
+		TEST(lstat(file, &stat_buf));
+		if (TEST_RETURN != -1 && S_ISDIR(stat_buf.st_mode)) {
+			/* proceed to subdir */
+			res |= cgrp_files_walking(file, xattr_operation);
+			tst_resm(TINFO, "In dir %s", path);
+		}
+		memset(val.buf, id++, val.size);
+		res |= xattr_operation(file);
+		errno = 0;
+	}
+	if (errno && !entry) {
+		tst_brkm(TWARN | TERRNO, cleanup,
+			"Error while reading dir '%s'", path);
+	}
+	if (closedir(dir) == -1)
+		tst_brkm(TWARN, cleanup, "Failed to close dir '%s'", path);
+	else
+		odir[--odir_num] = NULL;
+
+	if (strcmp(path, "."))
+		SAFE_CHDIR(cleanup, "..");
+	return res;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
