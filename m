From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:07 +0200
Subject: [LTP] [RFC] [PATCH 04/15] lib/tst_test: Add .all_filesystems flag
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a support for re-runing a test on all available
filesystems simply by turning on .all_filesystems flag in the tst_test
structure.

The .all_filesystems flag implies .needs_device, the .format_filesystem and
.mount_filesystem works as usuall but the device is formatted and mounted for
each filesystem before we run the test function. The .setup and .cleanup
functions are executed for each filesystem. The currently tested filesystem
type is stored in the tst_device->fs_type.

This allows us to easily run a test that tests filesystem specific
syscall for all supported filesystems without a need to hardcode all fs
types into a runtest file and with a minimal changes to the test code.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h |   9 +++++
 lib/tst_test.c     | 113 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 96 insertions(+), 26 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index e90312ae3..910c9b254 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -124,6 +124,15 @@ struct tst_test {
 	int needs_checkpoints:1;
 	int format_device:1;
 	int mount_device:1;
+	/*
+	 * If set the test function will be executed for all available
+	 * filesystems and the current filesytem type would be set in the
+	 * tst_device->fs_type.
+	 *
+	 * The test setup and cleanup are executed before/after __EACH__ call
+	 * to the test function.
+	 */
+	int all_filesystems:1;
 
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4c30edab5..88b7f95be 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -664,6 +664,20 @@ static void assert_test_fn(void)
 		tst_brk(TBROK, "You can define tcnt only for test()");
 }
 
+static void prepare_device(void)
+{
+	if (tst_test->format_device) {
+		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
+			  tst_test->dev_extra_opt);
+	}
+
+	if (tst_test->mount_device) {
+		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
+			   tst_test->mnt_flags, tst_test->mnt_data);
+		device_mounted = 1;
+	}
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -696,6 +710,9 @@ static void do_setup(int argc, char *argv[])
 		tst_test->format_device = 1;
 	}
 
+	if (tst_test->all_filesystems)
+		tst_test->needs_device = 1;
+
 	setup_ipc();
 
 	if (needs_tmpdir() && !tst_tmpdir_created())
@@ -714,24 +731,17 @@ static void do_setup(int argc, char *argv[])
 		else
 			tdev.fs_type = tst_dev_fs_type();
 
-		if (tst_test->format_device) {
-			SAFE_MKFS(tdev.dev, tdev.fs_type,
-			          tst_test->dev_fs_opts,
-				  tst_test->dev_extra_opt);
-		}
-
 		if (tst_test->mount_device) {
-
 			if (!tst_test->mntpoint) {
 				tst_brk(TBROK,
 					"tst_test->mntpoint must be set!");
 			}
 
 			SAFE_MKDIR(tst_test->mntpoint, 0777);
-			SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
-				   tst_test->mnt_flags, tst_test->mnt_data);
-			device_mounted = 1;
 		}
+
+		if (!tst_test->all_filesystems)
+			prepare_device();
 	}
 
 	if (tst_test->resource_files)
@@ -810,6 +820,11 @@ static unsigned long long get_time_ms(void)
 	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
 }
 
+static void heartbeat(void)
+{
+	kill(getppid(), SIGUSR1);
+}
+
 static void testrun(void)
 {
 	unsigned int i = 0;
@@ -836,8 +851,7 @@ static void testrun(void)
 			break;
 
 		run_tests();
-
-		kill(getppid(), SIGUSR1);
+		heartbeat();
 	}
 
 	do_test_cleanup();
@@ -910,23 +924,13 @@ void tst_set_timeout(int timeout)
 	if (getpid() == lib_pid)
 		alarm(results->timeout);
 	else
-		kill(getppid(), SIGUSR1);
+		heartbeat();
 }
 
-void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+static int fork_testrun(void)
 {
 	int status;
 
-	lib_pid = getpid();
-	tst_test = self;
-
-	do_setup(argc, argv);
-
-	TCID = tst_test->tid;
-
-	SAFE_SIGNAL(SIGALRM, alarm_handler);
-	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
-
 	if (tst_test->timeout)
 		tst_set_timeout(tst_test->timeout);
 	else
@@ -951,7 +955,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGINT, SIG_DFL);
 
 	if (WIFEXITED(status) && WEXITSTATUS(status))
-		do_exit(WEXITSTATUS(status));
+		return WEXITSTATUS(status);
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "
@@ -962,5 +966,62 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	if (WIFSIGNALED(status))
 		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
 
-	do_exit(0);
+	return 0;
+}
+
+static int run_tcases_per_fs(void)
+{
+	int ret = 0;
+	unsigned int i;
+	const char *const *filesystems = tst_get_supported_fs_types();
+
+	if (!filesystems[0])
+		tst_brk(TCONF, "There are no supported filesystems");
+
+	for (i = 0; filesystems[i]; i++) {
+		tdev.fs_type = filesystems[i];
+
+		prepare_device();
+
+		ret = fork_testrun();
+
+		if (device_mounted) {
+			tst_umount(tst_test->mntpoint);
+			device_mounted = 0;
+		}
+
+		if (ret == TCONF) {
+			update_results(ret);
+			continue;
+		}
+
+		if (ret == 0)
+			continue;
+
+		do_exit(ret);
+	}
+
+	return ret;
+}
+
+void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
+{
+	int ret;
+
+	lib_pid = getpid();
+	tst_test = self;
+
+	do_setup(argc, argv);
+
+	TCID = tst_test->tid;
+
+	SAFE_SIGNAL(SIGALRM, alarm_handler);
+	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
+
+	if (tst_test->all_filesystems)
+		ret = run_tcases_per_fs();
+	else
+		ret = fork_testrun();
+
+	do_exit(ret);
 }
-- 
2.13.0

