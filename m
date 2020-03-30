From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:43:34 +0200
Subject: [LTP] [PATCH v2 1/5] lib: Rename tst_run_cmd*() to tst_cmd*()
In-Reply-To: <20200330124338.6764-1-pvorel@suse.cz>
References: <20200330124338.6764-1-pvorel@suse.cz>
Message-ID: <20200330124338.6764-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in function names and also C source file.
This is a preparation for next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt               | 10 ++++-----
 include/tst_cmd.h                             | 22 +++++++++----------
 lib/{tst_run_cmd.c => tst_cmd.c}              |  6 ++---
 lib/tst_kernel.c                              |  2 +-
 lib/tst_mkfs.c                                |  2 +-
 lib/tst_module.c                              |  4 ++--
 lib/tst_virt.c                                |  2 +-
 testcases/cve/stack_clash.c                   |  2 +-
 testcases/kernel/input/input_helper.c         |  4 ++--
 testcases/kernel/syscalls/acct/acct02.c       |  2 +-
 testcases/kernel/syscalls/add_key/add_key05.c |  4 ++--
 .../copy_file_range/copy_file_range02.c       |  2 +-
 .../kernel/syscalls/quotactl/quotactl01.c     |  2 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  2 +-
 .../syscalls/setpriority/setpriority01.c      |  4 ++--
 testcases/kernel/syscalls/swapon/libswapon.c  |  2 +-
 testcases/network/netstress/netstress.c       |  2 +-
 .../network/nfs/nfs_stress/nfs05_make_tree.c  |  6 ++---
 tools/apicmds/ltpapicmd.c                     |  2 +-
 19 files changed, 41 insertions(+), 41 deletions(-)
 rename lib/{tst_run_cmd.c => tst_cmd.c} (96%)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cff42f515..3956e2c4c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1260,20 +1260,20 @@ different once the call returns and should be used only for rough estimates.
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
-int tst_run_cmd(const char *const argv[],
+int tst_cmd(const char *const argv[],
 	        const char *stdout_path,
 	        const char *stderr_path,
 	        int pass_exit_val);
 -------------------------------------------------------------------------------
 
-'tst_run_cmd' is a wrapper for 'vfork() + execvp()' which provides a way
+'tst_cmd' is a wrapper for 'vfork() + execvp()' which provides a way
 to execute an external program.
 
 'argv[]' is a 'NULL' terminated array of strings starting with the program name
 which is followed by optional arguments.
 
-A non-zero 'pass_exit_val' makes 'tst_run_cmd' return the program exit code to
-the caller. A zero for 'pass_exit_val' makes 'tst_run_cmd' exit the tests
+A non-zero 'pass_exit_val' makes 'tst_cmd' return the program exit code to
+the caller. A zero for 'pass_exit_val' makes 'tst_cmd' exit the tests
 on failure.
 
 In case that 'execvp()' has failed and the 'pass_exit_val' flag was set, the
@@ -1291,7 +1291,7 @@ const char *const cmd[] = { "ls", "-l", NULL };
 
 ...
 	/* Store output of 'ls -l' into log.txt */
-	tst_run_cmd(cmd, "log.txt", NULL, 0);
+	tst_cmd(cmd, "log.txt", NULL, 0);
 ...
 -------------------------------------------------------------------------------
 
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index d0a3573f4..b8b86eb28 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -18,13 +18,13 @@
  * exit code, otherwise it will call cleanup_fn() if the program
  * exit code is not zero.
  */
-int tst_run_cmd_fds_(void (cleanup_fn)(void),
+int tst_cmd_fds_(void (cleanup_fn)(void),
 			const char *const argv[],
 			int stdout_fd,
 			int stderr_fd,
 			int pass_exit_val);
 
-/* Executes tst_run_cmd_fds() and redirects its output to a file
+/* Executes tst_cmd_fds() and redirects its output to a file
  * @stdout_path: path where to redirect stdout. Set NULL if redirection is
  * not needed.
  * @stderr_path: path where to redirect stderr. Set NULL if redirection is
@@ -33,48 +33,48 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
  * exit code, otherwise it will call cleanup_fn() if the program
  * exit code is not zero.
  */
-int tst_run_cmd_(void (cleanup_fn)(void),
+int tst_cmd_(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
 		const char *stderr_path,
 		int pass_exit_val);
 
 #ifdef TST_TEST_H__
-static inline int tst_run_cmd_fds(const char *const argv[],
+static inline int tst_cmd_fds(const char *const argv[],
 				  int stdout_fd,
 				  int stderr_fd,
 				  int pass_exit_val)
 {
-	return tst_run_cmd_fds_(NULL, argv,
+	return tst_cmd_fds_(NULL, argv,
 	                        stdout_fd, stderr_fd, pass_exit_val);
 }
 
-static inline int tst_run_cmd(const char *const argv[],
+static inline int tst_cmd(const char *const argv[],
 			      const char *stdout_path,
 			      const char *stderr_path,
 			      int pass_exit_val)
 {
-	return tst_run_cmd_(NULL, argv,
+	return tst_cmd_(NULL, argv,
 	                    stdout_path, stderr_path, pass_exit_val);
 }
 #else
-static inline int tst_run_cmd_fds(void (cleanup_fn)(void),
+static inline int tst_cmd_fds(void (cleanup_fn)(void),
 				  const char *const argv[],
 				  int stdout_fd,
 				  int stderr_fd,
 				  int pass_exit_val)
 {
-	return tst_run_cmd_fds_(cleanup_fn, argv,
+	return tst_cmd_fds_(cleanup_fn, argv,
 	                        stdout_fd, stderr_fd, pass_exit_val);
 }
 
-static inline int tst_run_cmd(void (cleanup_fn)(void),
+static inline int tst_cmd(void (cleanup_fn)(void),
 			      const char *const argv[],
 			      const char *stdout_path,
 			      const char *stderr_path,
 			      int pass_exit_val)
 {
-	return tst_run_cmd_(cleanup_fn, argv,
+	return tst_cmd_(cleanup_fn, argv,
 	                    stdout_path, stderr_path, pass_exit_val);
 }
 #endif
diff --git a/lib/tst_run_cmd.c b/lib/tst_cmd.c
similarity index 96%
rename from lib/tst_run_cmd.c
rename to lib/tst_cmd.c
index 8e4bf6ba3..1964ff784 100644
--- a/lib/tst_run_cmd.c
+++ b/lib/tst_cmd.c
@@ -31,7 +31,7 @@
 #define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
 #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
 
-int tst_run_cmd_fds_(void (cleanup_fn)(void),
+int tst_cmd_fds_(void (cleanup_fn)(void),
 		const char *const argv[],
 		int stdout_fd,
 		int stderr_fd,
@@ -107,7 +107,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
 	return rc;
 }
 
-int tst_run_cmd_(void (cleanup_fn)(void),
+int tst_cmd_(void (cleanup_fn)(void),
 		const char *const argv[],
 		const char *stdout_path,
 		const char *stderr_path,
@@ -137,7 +137,7 @@ int tst_run_cmd_(void (cleanup_fn)(void),
 				stderr_path, __FILE__, __LINE__);
 	}
 
-	rc = tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd,
+	rc = tst_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd,
 			     pass_exit_val);
 
 	if ((stdout_fd != -1) && (close(stdout_fd) == -1))
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 73ab9f1b1..210675b15 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -85,7 +85,7 @@ int tst_check_driver(const char *name)
 {
 #ifndef __ANDROID__
 	const char * const argv[] = { "modprobe", "-n", name, NULL };
-	int res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
+	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
 
 	/* 255 - it looks like modprobe not available */
 	return (res == 255) ? 0 : res;
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5d208eceb..9cdd35472 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -88,7 +88,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
 	         dev, fs_type, fs_opts_str, extra_opts_str);
-	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
+	ret = tst_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
 
 	switch (ret) {
 	case 0:
diff --git a/lib/tst_module.c b/lib/tst_module.c
index ed39952ee..a9ce90e8a 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -97,7 +97,7 @@ void tst_module_load(void (cleanup_fn)(void),
 	for (i = offset; i < size; ++i)
 		mod_argv[i] = argv[i - offset];
 
-	tst_run_cmd(cleanup_fn, mod_argv, NULL, NULL, 0);
+	tst_cmd(cleanup_fn, mod_argv, NULL, NULL, 0);
 	free(mod_path);
 }
 
@@ -109,7 +109,7 @@ void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
 
 	rc = 1;
 	for (i = 0; i < 50; i++) {
-		rc = tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 1);
+		rc = tst_cmd(NULL, argv, "/dev/null", "/dev/null", 1);
 		if (!rc)
 			break;
 
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index e95cf5e70..090e6334c 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -70,7 +70,7 @@ static int try_systemd_detect_virt(void)
 	char virt_type[64];
 	int ret;
 
-	/* See tst_run_cmd.c */
+	/* See tst_cmd.c */
 	void *old_handler = signal(SIGCHLD, SIG_DFL);
 
 	f = popen("systemd-detect-virt", "r");
diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index ecbf5f6da..cd7f148c2 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -119,7 +119,7 @@ void dump_proc_self_maps(void)
 	static char buf[64];
 	static const char *cmd[] = {"cat", buf, NULL};
 	sprintf(buf, "/proc/%d/maps", getpid());
-	tst_run_cmd(cmd, NULL, NULL, 0);
+	tst_cmd(cmd, NULL, NULL, 0);
 }
 
 void __attribute__((noinline)) preallocate_stack(unsigned long required)
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index f6ae9c9b6..bd9c715ed 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -92,7 +92,7 @@ static int try_load_uinput(void)
 
 	tst_resm(TINFO, "Trying to load uinput kernel module");
 
-	ret = tst_run_cmd(NULL, argv, NULL, NULL, 1);
+	ret = tst_cmd(NULL, argv, NULL, NULL, 1);
 	if (ret) {
 		tst_resm(TINFO, "Failed to load the uinput module");
 		return 0;
@@ -108,7 +108,7 @@ static void unload_uinput(void)
 
 	tst_resm(TINFO, "Unloading uinput kernel module");
 
-	ret = tst_run_cmd(NULL, argv, NULL, NULL, 1);
+	ret = tst_cmd(NULL, argv, NULL, NULL, 1);
 	if (ret)
 		tst_resm(TWARN, "Failed to unload uinput module");
 }
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 2f1290fa2..22303dc3f 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -67,7 +67,7 @@ static void run_command(void)
 {
 	const char *const cmd[] = {COMMAND, NULL};
 
-	rc = tst_run_cmd(cmd, NULL, NULL, 1) << 8;
+	rc = tst_cmd(cmd, NULL, NULL, 1) << 8;
 }
 
 static int verify_acct(void *acc, int elap_time)
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 7443a4970..191889a58 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -38,7 +38,7 @@ static void add_user(void)
 	const char *const cmd_useradd[] = {"useradd", username, NULL};
 	int rc;
 
-	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
+	switch ((rc = tst_cmd(cmd_useradd, NULL, NULL, 1))) {
 	case 0:
 		user_added = 1;
 		ltpuser = SAFE_GETPWNAM(username);
@@ -56,7 +56,7 @@ static void clean_user(void)
 
 	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
 
-	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
+	if (tst_cmd(cmd_userdel, NULL, NULL, 1))
 		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
 	else
 		user_added = 0;
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index c09766fe6..52a703b2b 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -87,7 +87,7 @@ static int run_command(char *command, char *option, char *file)
 	const char *const cmd[] = {command, option, file, NULL};
 	int ret;
 
-	ret = tst_run_cmd(cmd, NULL, NULL, 1);
+	ret = tst_cmd(cmd, NULL, NULL, 1);
 	switch (ret) {
 	case 0:
 	return 0;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 6cc1deeb8..d1c4657b3 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -164,7 +164,7 @@ static void setup(void)
 	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
 	int ret;
 
-	ret = tst_run_cmd(cmd, NULL, NULL, 1);
+	ret = tst_cmd(cmd, NULL, NULL, 1);
 	switch (ret) {
 	case 0:
 		break;
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 758bd84cd..b5d59b706 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -149,7 +149,7 @@ static void setup(void)
 	int ret;
 	unsigned int i;
 
-	ret = tst_run_cmd(cmd, NULL, NULL, 1);
+	ret = tst_cmd(cmd, NULL, NULL, 1);
 	switch (ret) {
 	case 0:
 		break;
diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
index ffd7499c4..70c015f18 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority01.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
@@ -112,7 +112,7 @@ static void setup(void)
 	struct passwd *ltpuser;
 	int rc;
 
-	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
+	switch ((rc = tst_cmd(cmd_useradd, NULL, NULL, 1))) {
 	case 0:
 		user_added = 1;
 		ltpuser = SAFE_GETPWNAM(username);
@@ -133,7 +133,7 @@ static void cleanup(void)
 
 	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
 
-	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
+	if (tst_cmd(cmd_userdel, NULL, NULL, 1))
 		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
 }
 
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
index 0a4501bdd..d5bbfa567 100644
--- a/testcases/kernel/syscalls/swapon/libswapon.c
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -47,7 +47,7 @@ int make_swapfile(void (cleanup)(void), const char *swapfile, int safe)
 	argv[1] = swapfile;
 	argv[2] = NULL;
 
-	return tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", safe);
+	return tst_cmd(cleanup, argv, "/dev/null", "/dev/null", safe);
 }
 
 /*
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 76d2fdb04..fca476198 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -967,7 +967,7 @@ static void setup(void)
 		/* dccp* modules can be blacklisted, load them manually */
 		const char * const argv[] = {"modprobe", "dccp_ipv6", NULL};
 
-		if (tst_run_cmd(argv, NULL, NULL, 1))
+		if (tst_cmd(argv, NULL, NULL, 1))
 			tst_brk(TCONF, "Failed to load dccp_ipv6 module");
 
 		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 25809e1a3..12c86799d 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -82,7 +82,7 @@ static void run_targets(const char *dirname, char *cfile, pid_t tid)
 			snprintf(cfile, PATH_MAX, "%s%s/%d.%d.%d",
 				 dirname, subdir, tid, i, k);
 
-			tst_run_cmd(cmd_run, output_file, NULL, 0);
+			tst_cmd(cmd_run, output_file, NULL, 0);
 
 			fd = SAFE_OPEN(output_file, O_RDONLY);
 			SAFE_READ(1, fd, buf, 11);
@@ -179,11 +179,11 @@ static void *thread_fn(LTP_ATTRIBUTE_UNUSED void *args)
 	const char *const cmd_make_clean[] = {
 		"make", "-C", dirname, "-s", "clean", NULL};
 
-	tst_run_cmd(cmd_make, NULL, NULL, 0);
+	tst_cmd(cmd_make, NULL, NULL, 0);
 
 	run_targets(dirname, cfile, tid);
 
-	tst_run_cmd(cmd_make_clean, NULL, NULL, 0);
+	tst_cmd(cmd_make_clean, NULL, NULL, 0);
 
 	free(dirname);
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index c4fab3218..ac58c90cc 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -108,7 +108,7 @@ void tst_cat_file(const char *filename)
 {
 	const char *cmd[] = {"cat", filename, NULL};
 
-	tst_run_cmd(NULL, cmd, NULL, NULL, 0);
+	tst_cmd(NULL, cmd, NULL, NULL, 0);
 }
 
 void apicmd_brk(int argc, char *argv[])
-- 
2.26.0

