Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YFghu-0001RP-EA
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:15:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YFghr-0001KL-5l
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:15:44 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t0QAFdk8031539
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:40 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0QAFcMH013739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:39 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t0QAFc8X009195
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 10:15:38 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 26 Jan 2015 13:15:32 +0300
Message-Id: <1422267333-22808-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150120114329.GA11013@rei>
References: <20150120114329.GA11013@rei>
Subject: [LTP] [PATCH 1/2] tst_run_cmd: add an option to pass the program
	exit code
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

Added an option to pass the program exit code to the caller.
This may be needed if we want to run a program with tst_run_cmd(),
but handle failures manually (i.e. not call cleanup).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h                               |   16 ++++++++++---
 lib/tst_mkfs.c                               |    2 +-
 lib/tst_module.c                             |    4 +-
 lib/tst_run_cmd.c                            |   29 ++++++++++++++++++++-----
 testcases/kernel/syscalls/swapon/libswapon.c |    2 +-
 5 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/include/test.h b/include/test.h
index 326b686..9078f37 100644
--- a/include/test.h
+++ b/include/test.h
@@ -283,22 +283,30 @@ long tst_ncpus_max(void);
  * redirection is not needed.
  * @stderr_fd: file descriptor where to redirect stderr. Set -1 if
  * redirection is not needed.
+ * @pass_exit_val: if it's non-zero, this function will return the program
+ * exit code, otherwise it will call cleanup_fn() if the program
+ * exit code is not zero.
  */
-void tst_run_cmd_fds(void (cleanup_fn)(void),
+int tst_run_cmd_fds(void (cleanup_fn)(void),
 			const char *const argv[],
 			int stdout_fd,
-			int stderr_fd);
+			int stderr_fd,
+			int pass_exit_val);
 
 /* Executes tst_run_cmd_fds() and redirects its output to a file
  * @stdout_path: path where to redirect stdout. Set NULL if redirection is
  * not needed.
  * @stderr_path: path where to redirect stderr. Set NULL if redirection is
  * not needed.
+ * @pass_exit_val: if it's non-zero, this function will return the program
+ * exit code, otherwise it will call cleanup_fn() if the program
+ * exit code is not zero.
  */
-void tst_run_cmd(void (cleanup_fn)(void),
+int tst_run_cmd(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
-		const char *stderr_path);
+		const char *stderr_path,
+		int pass_exit_val);
 
 /* Wrapper function for system(3), ignorcing SIGCLD signal.
  * @command: the command to be run.
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 46e924c..c01cdf3 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -72,7 +72,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 
 	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
 		 dev, fs_type, fs_opts_str);
-	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL);
+	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
 }
 
 const char *tst_dev_fs_type(void)
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 028af0e..8104582 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -94,12 +94,12 @@ void tst_module_load(void (cleanup_fn)(void),
 	for (i = offset; i < size; ++i)
 		mod_argv[i] = argv[i - offset];
 
-	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL);
+	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL, 0);
 	free(mod_path);
 }
 
 void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 {
 	const char *const argv[] = { "rmmod", mod_name, NULL };
-	tst_run_cmd(cleanup_fn, argv, NULL, NULL);
+	tst_run_cmd(cleanup_fn, argv, NULL, NULL, 0);
 }
diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
index 5a02db0..c0dd944 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_run_cmd.c
@@ -31,11 +31,14 @@
 #define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
 #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
 
-void tst_run_cmd_fds(void (cleanup_fn)(void),
+int tst_run_cmd_fds(void (cleanup_fn)(void),
 		const char *const argv[],
 		int stdout_fd,
-		int stderr_fd)
+		int stderr_fd,
+		int pass_exit_val)
 {
+	int rc;
+
 	if (argv == NULL || argv[0] == NULL) {
 		tst_brkm(TBROK, cleanup_fn,
 			"argument list is empty at %s:%d", __FILE__, __LINE__);
@@ -79,19 +82,30 @@ void tst_run_cmd_fds(void (cleanup_fn)(void),
 
 	signal(SIGCHLD, old_handler);
 
-	if (!WIFEXITED(ret) || WEXITSTATUS(ret) != 0) {
+	if (!WIFEXITED(ret)) {
 		tst_brkm(TBROK, cleanup_fn, "failed to exec cmd '%s' at %s:%d",
 			argv[0], __FILE__, __LINE__);
 	}
+
+	rc = WEXITSTATUS(ret);
+
+	if ((!pass_exit_val) && rc)
+		tst_brkm(TBROK, cleanup_fn,
+			 "'%s' exited with a non-zero code %d at %s:%d",
+			 argv[0], rc, __FILE__, __LINE__);
+
+	return rc;
 }
 
-void tst_run_cmd(void (cleanup_fn)(void),
+int tst_run_cmd(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
-		const char *stderr_path)
+		const char *stderr_path,
+		int pass_exit_val)
 {
 	int stdout_fd = -1;
 	int stderr_fd = -1;
+	int rc;
 
 	if (stdout_path != NULL) {
 		stdout_fd = open(stdout_path,
@@ -113,7 +127,8 @@ void tst_run_cmd(void (cleanup_fn)(void),
 				stderr_path, __FILE__, __LINE__);
 	}
 
-	tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd);
+	rc = tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd,
+			     pass_exit_val);
 
 	if ((stdout_fd != -1) && (close(stdout_fd) == -1))
 		tst_resm(TWARN | TERRNO,
@@ -124,6 +139,8 @@ void tst_run_cmd(void (cleanup_fn)(void),
 		tst_resm(TWARN | TERRNO,
 			"close() on %s failed at %s:%d",
 			stderr_path, __FILE__, __LINE__);
+
+	return rc;
 }
 
 int tst_system(const char *command)
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index ac0be57..cf6a988 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -45,5 +45,5 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
 	argv[1] = swapfile;
 	argv[2] = NULL;
 
-	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null");
+	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
 }
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
