Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YCAte-0000DV-Is
	for ltp-list@lists.sourceforge.net; Fri, 16 Jan 2015 17:41:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YC9zf-00079O-S5
	for ltp-list@lists.sourceforge.net; Fri, 16 Jan 2015 16:43:33 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0GGhPTo005025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Jan 2015 16:43:26 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t0GGhOIl018965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Jan 2015 16:43:25 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0GGhOb3022698
	for <ltp-list@lists.sourceforge.net>; Fri, 16 Jan 2015 16:43:24 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 16 Jan 2015 19:43:19 +0300
Message-Id: <1421426599-17413-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH] Asynchronous module unloading and tst_run_cmd
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
Cc: vasily.isaenko@oracle.com

There is one more issue with tbio. :(

Sometimes it may fail with:

ltp_tbio    0  TINFO  :  Device opened successfully
ltp_tbio    1  TPASS  :  success on LTP_TBIO_ALLOC test
ltp_tbio    2  TPASS  :  success on LTP_TBIO_CLONE test
ltp_tbio    3  TPASS  :  success on LTP_TBIO_GET_NR_VECS test
ltp_tbio    4  TPASS  :  success on LTP_TBIO_ADD_PAGE test
ltp_tbio    5  TPASS  :  success on LTP_TBIO_SPLIT:write to dev
ltp_tbio    6  TPASS  :  success on LTP_TBIO_DO_IO:write to dev
ltp_tbio    7  TPASS  :  success on LTP_TBIO_DO_IO:read from dev
ltp_tbio    8  TPASS  :  success on LTP_TBIO_PUT test
ERROR: Module ltp_tbio is in use
ltp_tbio    9  TBROK  :  tst_run_cmd.c:84: failed to exec cmd 'rmmod' at tst_run_cmd.c:84
ltp_tbio   10  TBROK  :  tst_run_cmd.c:84: Remaining cases broken

This is a rfc patch which fixes this problem.

The main idea is to execute rmmod up to a timeout, and check if the module
has been unloaded after each execution of rmmod.

Summary of changes:
 * introduce tst_module_is_loaded() - checks if the module is in /proc/modules
 * change a bit interfaces of tst_run_cmd and cmd_run_cmd_fds (to conditionally
   check the program exit code to be able to continue the test if the program failed)
 * introducing a loop into tst_module_unload

I would like somebody to review the general idea. If it's ok, I'll split this patch
into several logically coupled ones and resend them.

I'm really unsure if the changes to tst_run_cmd and cmd_run_cmd_fds are acceptable.

Thanks!

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h                               |    8 ++-
 include/tst_module.h                         |   11 ++++
 lib/tst_mkfs.c                               |    2 +-
 lib/tst_module.c                             |   73 +++++++++++++++++++++++++-
 lib/tst_run_cmd.c                            |   15 ++++--
 testcases/kernel/syscalls/swapon/libswapon.c |    2 +-
 6 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/include/test.h b/include/test.h
index 326b686..5234aa5 100644
--- a/include/test.h
+++ b/include/test.h
@@ -283,22 +283,26 @@ long tst_ncpus_max(void);
  * redirection is not needed.
  * @stderr_fd: file descriptor where to redirect stderr. Set -1 if
  * redirection is not needed.
+ * @check_code: set to a non-zero value to check the program exit code.
  */
 void tst_run_cmd_fds(void (cleanup_fn)(void),
 			const char *const argv[],
 			int stdout_fd,
-			int stderr_fd);
+			int stderr_fd,
+			int check_code);
 
 /* Executes tst_run_cmd_fds() and redirects its output to a file
  * @stdout_path: path where to redirect stdout. Set NULL if redirection is
  * not needed.
  * @stderr_path: path where to redirect stderr. Set NULL if redirection is
  * not needed.
+ * @check_code: set to a non-zero value to check the program exit code.
  */
 void tst_run_cmd(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
-		const char *stderr_path);
+		const char *stderr_path,
+		int check_code);
 
 /* Wrapper function for system(3), ignorcing SIGCLD signal.
  * @command: the command to be run.
diff --git a/include/tst_module.h b/include/tst_module.h
index c50efec..d9b7e80 100644
--- a/include/tst_module.h
+++ b/include/tst_module.h
@@ -48,6 +48,17 @@ void tst_module_exist(void (cleanup_fn)(void), const char *mod_name,
 	char **mod_path);
 
 /*
+ * Check if the module is loaded.
+ *
+ * @mod_name: the module's name or file name.
+ *
+ * Returns 1 if the module is loaded 0 - if it's not.
+ *
+ * In case of failure calls cleanup_fn and exits with TBROK.
+ */
+int tst_module_is_loaded(void (cleanup_fn)(void), const char *mod_name);
+
+/*
  * Load a module using insmod program.
  *
  * @mod_name: module's file name.
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 46e924c..a0261c7 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -72,7 +72,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 
 	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
 		 dev, fs_type, fs_opts_str);
-	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL);
+	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
 }
 
 const char *tst_dev_fs_type(void)
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 028af0e..d71b62b 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -20,9 +20,12 @@
  */
 
 #define _GNU_SOURCE
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 #include "test.h"
 #include "ltp_priv.h"
@@ -74,6 +77,57 @@ void tst_module_exists(void (cleanup_fn)(void),
 		free(buf);
 }
 
+int tst_module_is_loaded(void (cleanup_fn)(void),
+			 const char *mod_name)
+{
+	FILE *f;
+	char *pos;
+	char mod_name_can[64];
+	char mod_name_read[64];
+	char buf[128];
+	int ret = 0;
+
+	if (strlen(mod_name) + 1 > sizeof(mod_name_can))
+		tst_brkm(TBROK, cleanup_fn, "Too long module name: %s",
+			 mod_name);
+
+	/*
+	 * modify the module name to compare with names in /proc/modules
+	 */
+	strcpy(mod_name_can, mod_name);
+
+	pos = strstr(mod_name_can, ".ko");
+	if (pos != NULL)
+		*pos = '\0';
+
+	pos = mod_name_can;
+	while (*pos) {
+		if (*pos == '-')
+			*pos = '_';
+		pos++;
+	}
+
+	f = fopen("/proc/modules", "r");
+	if (f == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup_fn,
+			"fopen(\"/proc/modules\") failed");
+
+	while (fgets(buf, sizeof(buf), f) != NULL) {
+		if (sscanf(buf, "%63s", mod_name_read) != 1) {
+			fclose(f);
+			tst_brkm(TBROK, cleanup_fn,
+				 "Failed to parse /proc/modules");
+		}
+
+		if (!strcmp(mod_name_can, mod_name_read)) {
+			ret = 1;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 void tst_module_load(void (cleanup_fn)(void),
 	const char *mod_name, char *const argv[])
 {
@@ -94,12 +148,27 @@ void tst_module_load(void (cleanup_fn)(void),
 	for (i = offset; i < size; ++i)
 		mod_argv[i] = argv[i - offset];
 
-	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL);
+	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL, 1);
 	free(mod_path);
 }
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
+	int i;
+	int loaded;
+
 	const char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv, NULL, NULL);
+
+	loaded = 1;
+	for (i = 0; i < 50; i++) {
+		tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 0);
+/*		tst_system("rmmod ltp_tbio &> /dev/null"); */
+		loaded = tst_module_is_loaded(cleanup_fn, mod_name);
+		if (!loaded)
+			break;
+	}
+
+	if (loaded)
+		tst_brkm(TBROK, cleanup_fn,
+			 "Could not unload %s module", mod_name);
 }
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 5a02db0..bbee729 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -34,7 +34,8 @@
 void tst_run_cmd_fds(void (cleanup_fn)(void),
 		const char *const argv[],
 		int stdout_fd,
-		int stderr_fd)
+		int stderr_fd,
+		int check_code)
 {
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
@@ -79,16 +80,22 @@ void tst_run_cmd_fds(void (cleanup_fn)(void),
 
 	signal(SIGCHLD, old_handler);
 
-	if (!WIFEXITED(ret) || WEXITSTATUS(ret) != 0) {
+	if (!WIFEXITED(ret)) {
 		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
 			argv[0], __FILE__, __LINE__);
 	}
+
+	if (check_code && (WEXITSTATUS(ret) != 0))
+		tst_brkm(TBROK, cleanup_fn,
+			"'%s' exited with a non-zero code at %s:%d",
+			argv[0], __FILE__, __LINE__);
 }
 
 void tst_run_cmd(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
-		const char *stderr_path)
+		const char *stderr_path,
+		int check_code)
 {
 	int stdout_fd = -1;
 	int stderr_fd = -1;
@@ -113,7 +120,7 @@ void tst_run_cmd(void (cleanup_fn)(void),
 				stderr_path, __FILE__, __LINE__);
 	}
 
-	tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd);
+	tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd, check_code);
 
 	if ((stdout_fd != -1) && (close(stdout_fd) == -1))
 		tst_resm(TWARN | TERRNO,
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index ac0be57..a17e623 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -45,5 +45,5 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
 	argv[1] = swapfile;
 	argv[2] = NULL;
 
-	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null");
+	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 1);
 }
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
