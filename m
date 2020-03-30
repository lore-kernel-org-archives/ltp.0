From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 13:38:03 +0200
Subject: [LTP] [PATCH 3/6] lib/tst_run_cmd_*(): Turn int pass_exit_val
 into enum
In-Reply-To: <20200327213924.18816-4-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-4-pvorel@suse.cz>
Message-ID: <20200330113802.GE9845@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is a preparation for next commit.
> Now uses the only flag TST_RUN_CMD_PASS_EXIT_VAL.

That is quite long name, I wonder if we can shorten it.

Maybe we can rename the whole tst_run_cmd() just to tst_cmd() and change
this flag to TST_CMD_PASS_RETVAL.

Other that this the patchset looks good.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New commit.
> 
>  doc/test-writing-guidelines.txt               | 10 +++---
>  include/tst_cmd.h                             | 36 ++++++++++---------
>  lib/tst_kernel.c                              |  3 +-
>  lib/tst_mkfs.c                                |  3 +-
>  lib/tst_module.c                              |  3 +-
>  lib/tst_run_cmd.c                             | 12 +++----
>  testcases/kernel/input/input_helper.c         |  4 +--
>  testcases/kernel/syscalls/acct/acct02.c       |  2 +-
>  testcases/kernel/syscalls/add_key/add_key05.c |  5 +--
>  .../copy_file_range/copy_file_range02.c       |  2 +-
>  .../kernel/syscalls/quotactl/quotactl01.c     |  2 +-
>  .../kernel/syscalls/quotactl/quotactl06.c     |  2 +-
>  .../syscalls/setpriority/setpriority01.c      |  5 +--
>  testcases/network/netstress/netstress.c       |  2 +-
>  14 files changed, 50 insertions(+), 41 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index f7206f1bf..31897309d 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1263,18 +1263,18 @@ different once the call returns and should be used only for rough estimates.
>  int tst_run_cmd(const char *const argv[],
>  	        const char *stdout_path,
>  	        const char *stderr_path,
> -	        int pass_exit_val);
> +			enum tst_run_cmd_flags flags);
>  -------------------------------------------------------------------------------
>  
> -'tst_run_cmd' is a wrapper for 'vfork() + execvp()' which provides a way
> +'tst_run_cmd()' is a wrapper for 'vfork() + execvp()' which provides a way
>  to execute an external program.
>  
>  'argv[]' is a 'NULL' terminated array of strings starting with the program name
>  which is followed by optional arguments.
>  
> -A non-zero 'pass_exit_val' makes 'tst_run_cmd' return the program exit code to
> -the caller. A zero for 'pass_exit_val' makes 'tst_run_cmd' exit the tests
> -on failure.
> +'TST_RUN_CMD_PASS_EXIT_VAL' enum 'tst_run_cmd_flags' makes 'tst_run_cmd()'
> +return the program exit code to the caller, otherwise 'tst_run_cmd()' exit the
> +tests on failure.
>  
>  In case that 'execvp()' has failed and the 'pass_exit_val' flag was set, the
>  return value is '255' if 'execvp()' failed with 'ENOENT' and '254' otherwise.
> diff --git a/include/tst_cmd.h b/include/tst_cmd.h
> index d0a3573f4..67dec32f2 100644
> --- a/include/tst_cmd.h
> +++ b/include/tst_cmd.h
> @@ -5,6 +5,14 @@
>  #ifndef TST_CMD_H__
>  #define TST_CMD_H__
>  
> +enum tst_run_cmd_flags {
> +	/*
> +	 * return the program exit code, otherwise it will call cleanup_fn() if the
> +	 * program exit code is not zero.
> +	 */
> +	TST_RUN_CMD_PASS_EXIT_VAL = 1,
> +};
> +
>  /*
>   * vfork() + execvp() specified program.
>   * @argv: a list of two (at least program name + NULL) or more pointers that
> @@ -14,68 +22,64 @@
>   * redirection is not needed.
>   * @stderr_fd: file descriptor where to redirect stderr. Set -1 if
>   * redirection is not needed.
> - * @pass_exit_val: if it's non-zero, this function will return the program
> - * exit code, otherwise it will call cleanup_fn() if the program
> - * exit code is not zero.
> + * @flags: enum tst_run_cmd_flags
>   */
>  int tst_run_cmd_fds_(void (cleanup_fn)(void),
>  			const char *const argv[],
>  			int stdout_fd,
>  			int stderr_fd,
> -			int pass_exit_val);
> +			enum tst_run_cmd_flags flags);
>  
>  /* Executes tst_run_cmd_fds() and redirects its output to a file
>   * @stdout_path: path where to redirect stdout. Set NULL if redirection is
>   * not needed.
>   * @stderr_path: path where to redirect stderr. Set NULL if redirection is
>   * not needed.
> - * @pass_exit_val: if it's non-zero, this function will return the program
> - * exit code, otherwise it will call cleanup_fn() if the program
> - * exit code is not zero.
> + * @flags: enum tst_run_cmd_flags
>   */
>  int tst_run_cmd_(void (cleanup_fn)(void),
>  		const char *const argv[],
>  		const char *stdout_path,
>  		const char *stderr_path,
> -		int pass_exit_val);
> +		enum tst_run_cmd_flags flags);
>  
>  #ifdef TST_TEST_H__
>  static inline int tst_run_cmd_fds(const char *const argv[],
>  				  int stdout_fd,
>  				  int stderr_fd,
> -				  int pass_exit_val)
> +				  enum tst_run_cmd_flags flags)
>  {
>  	return tst_run_cmd_fds_(NULL, argv,
> -	                        stdout_fd, stderr_fd, pass_exit_val);
> +	                        stdout_fd, stderr_fd, flags);
>  }
>  
>  static inline int tst_run_cmd(const char *const argv[],
>  			      const char *stdout_path,
>  			      const char *stderr_path,
> -			      int pass_exit_val)
> +			      enum tst_run_cmd_flags flags)
>  {
>  	return tst_run_cmd_(NULL, argv,
> -	                    stdout_path, stderr_path, pass_exit_val);
> +	                    stdout_path, stderr_path, flags);
>  }
>  #else
>  static inline int tst_run_cmd_fds(void (cleanup_fn)(void),
>  				  const char *const argv[],
>  				  int stdout_fd,
>  				  int stderr_fd,
> -				  int pass_exit_val)
> +				  enum tst_run_cmd_flags flags)
>  {
>  	return tst_run_cmd_fds_(cleanup_fn, argv,
> -	                        stdout_fd, stderr_fd, pass_exit_val);
> +	                        stdout_fd, stderr_fd, flags);
>  }
>  
>  static inline int tst_run_cmd(void (cleanup_fn)(void),
>  			      const char *const argv[],
>  			      const char *stdout_path,
>  			      const char *stderr_path,
> -			      int pass_exit_val)
> +			      enum tst_run_cmd_flags flags)
>  {
>  	return tst_run_cmd_(cleanup_fn, argv,
> -	                    stdout_path, stderr_path, pass_exit_val);
> +	                    stdout_path, stderr_path, flags);
>  }
>  #endif
>  
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index 73ab9f1b1..3ef7c21b8 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -85,7 +85,8 @@ int tst_check_driver(const char *name)
>  {
>  #ifndef __ANDROID__
>  	const char * const argv[] = { "modprobe", "-n", name, NULL };
> -	int res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
> +	int res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null",
> +			       TST_RUN_CMD_PASS_EXIT_VAL);
>  
>  	/* 255 - it looks like modprobe not available */
>  	return (res == 255) ? 0 : res;
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 5d208eceb..0c347e1e2 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -88,7 +88,8 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
>  
>  	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
>  	         dev, fs_type, fs_opts_str, extra_opts_str);
> -	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
> +	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL,
> +			  TST_RUN_CMD_PASS_EXIT_VAL);
>  
>  	switch (ret) {
>  	case 0:
> diff --git a/lib/tst_module.c b/lib/tst_module.c
> index ed39952ee..9344b59d6 100644
> --- a/lib/tst_module.c
> +++ b/lib/tst_module.c
> @@ -109,7 +109,8 @@ void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
>  
>  	rc = 1;
>  	for (i = 0; i < 50; i++) {
> -		rc = tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 1);
> +		rc = tst_run_cmd(NULL, argv, "/dev/null", "/dev/null",
> +				 TST_RUN_CMD_PASS_EXIT_VAL);
>  		if (!rc)
>  			break;
>  
> diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
> index 8e4bf6ba3..3536ec494 100644
> --- a/lib/tst_run_cmd.c
> +++ b/lib/tst_run_cmd.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
> @@ -16,7 +17,6 @@
>   * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
>   * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> - *
>   */
>  
>  #include <errno.h>
> @@ -27,6 +27,7 @@
>  #include <unistd.h>
>  #include <signal.h>
>  #include "test.h"
> +#include "tst_cmd.h"
>  
>  #define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
>  #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
> @@ -35,7 +36,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
>  		const char *const argv[],
>  		int stdout_fd,
>  		int stderr_fd,
> -		int pass_exit_val)
> +		enum tst_run_cmd_flags flags)
>  {
>  	int rc;
>  
> @@ -97,7 +98,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
>  
>  	rc = WEXITSTATUS(ret);
>  
> -	if ((!pass_exit_val) && rc) {
> +	if (!(flags & TST_RUN_CMD_PASS_EXIT_VAL) && rc) {
>  		tst_brkm(TBROK, cleanup_fn,
>  			 "'%s' exited with a non-zero code %d at %s:%d",
>  			 argv[0], rc, __FILE__, __LINE__);
> @@ -111,7 +112,7 @@ int tst_run_cmd_(void (cleanup_fn)(void),
>  		const char *const argv[],
>  		const char *stdout_path,
>  		const char *stderr_path,
> -		int pass_exit_val)
> +		enum tst_run_cmd_flags flags)
>  {
>  	int stdout_fd = -1;
>  	int stderr_fd = -1;
> @@ -137,8 +138,7 @@ int tst_run_cmd_(void (cleanup_fn)(void),
>  				stderr_path, __FILE__, __LINE__);
>  	}
>  
> -	rc = tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd,
> -			     pass_exit_val);
> +	rc = tst_run_cmd_fds(cleanup_fn, argv, stdout_fd, stderr_fd, flags);
>  
>  	if ((stdout_fd != -1) && (close(stdout_fd) == -1))
>  		tst_resm(TWARN | TERRNO,
> diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
> index f6ae9c9b6..41c042aaf 100644
> --- a/testcases/kernel/input/input_helper.c
> +++ b/testcases/kernel/input/input_helper.c
> @@ -92,7 +92,7 @@ static int try_load_uinput(void)
>  
>  	tst_resm(TINFO, "Trying to load uinput kernel module");
>  
> -	ret = tst_run_cmd(NULL, argv, NULL, NULL, 1);
> +	ret = tst_run_cmd(NULL, argv, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
>  	if (ret) {
>  		tst_resm(TINFO, "Failed to load the uinput module");
>  		return 0;
> @@ -108,7 +108,7 @@ static void unload_uinput(void)
>  
>  	tst_resm(TINFO, "Unloading uinput kernel module");
>  
> -	ret = tst_run_cmd(NULL, argv, NULL, NULL, 1);
> +	ret = tst_run_cmd(NULL, argv, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
>  	if (ret)
>  		tst_resm(TWARN, "Failed to unload uinput module");
>  }
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index 2f1290fa2..801c7908d 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -67,7 +67,7 @@ static void run_command(void)
>  {
>  	const char *const cmd[] = {COMMAND, NULL};
>  
> -	rc = tst_run_cmd(cmd, NULL, NULL, 1) << 8;
> +	rc = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL) << 8;
>  }
>  
>  static int verify_acct(void *acc, int elap_time)
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
> index 7443a4970..3da3be9ee 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -38,7 +38,8 @@ static void add_user(void)
>  	const char *const cmd_useradd[] = {"useradd", username, NULL};
>  	int rc;
>  
> -	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> +	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL,
> +				  TST_RUN_CMD_PASS_EXIT_VAL))) {
>  	case 0:
>  		user_added = 1;
>  		ltpuser = SAFE_GETPWNAM(username);
> @@ -56,7 +57,7 @@ static void clean_user(void)
>  
>  	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
>  
> -	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
> +	if (tst_run_cmd(cmd_userdel, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL))
>  		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
>  	else
>  		user_added = 0;
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> index c09766fe6..f47479f16 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -87,7 +87,7 @@ static int run_command(char *command, char *option, char *file)
>  	const char *const cmd[] = {command, option, file, NULL};
>  	int ret;
>  
> -	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +	ret = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
>  	switch (ret) {
>  	case 0:
>  	return 0;
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 6cc1deeb8..e4c2a8939 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -164,7 +164,7 @@ static void setup(void)
>  	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
>  	int ret;
>  
> -	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +	ret = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
>  	switch (ret) {
>  	case 0:
>  		break;
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index 758bd84cd..5d70f340f 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -149,7 +149,7 @@ static void setup(void)
>  	int ret;
>  	unsigned int i;
>  
> -	ret = tst_run_cmd(cmd, NULL, NULL, 1);
> +	ret = tst_run_cmd(cmd, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL);
>  	switch (ret) {
>  	case 0:
>  		break;
> diff --git a/testcases/kernel/syscalls/setpriority/setpriority01.c b/testcases/kernel/syscalls/setpriority/setpriority01.c
> index ffd7499c4..0c6689fd5 100644
> --- a/testcases/kernel/syscalls/setpriority/setpriority01.c
> +++ b/testcases/kernel/syscalls/setpriority/setpriority01.c
> @@ -112,7 +112,8 @@ static void setup(void)
>  	struct passwd *ltpuser;
>  	int rc;
>  
> -	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL, 1))) {
> +	switch ((rc = tst_run_cmd(cmd_useradd, NULL, NULL,
> +				  TST_RUN_CMD_PASS_EXIT_VAL))) {
>  	case 0:
>  		user_added = 1;
>  		ltpuser = SAFE_GETPWNAM(username);
> @@ -133,7 +134,7 @@ static void cleanup(void)
>  
>  	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
>  
> -	if (tst_run_cmd(cmd_userdel, NULL, NULL, 1))
> +	if (tst_run_cmd(cmd_userdel, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL))
>  		tst_res(TWARN | TERRNO, "'userdel -r %s' failed", username);
>  }
>  
> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 76d2fdb04..8d85ad085 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -967,7 +967,7 @@ static void setup(void)
>  		/* dccp* modules can be blacklisted, load them manually */
>  		const char * const argv[] = {"modprobe", "dccp_ipv6", NULL};
>  
> -		if (tst_run_cmd(argv, NULL, NULL, 1))
> +		if (tst_run_cmd(argv, NULL, NULL, TST_RUN_CMD_PASS_EXIT_VAL))
>  			tst_brk(TCONF, "Failed to load dccp_ipv6 module");
>  
>  		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
> -- 
> 2.25.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
