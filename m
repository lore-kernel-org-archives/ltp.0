From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 15:03:17 +0200
Subject: [LTP] [PATCH 6/6] execve: rewrite to newlib
In-Reply-To: <20180808055434.26293-7-liwang@redhat.com>
References: <20180808055434.26293-1-liwang@redhat.com>
 <20180808055434.26293-7-liwang@redhat.com>
Message-ID: <20180808130316.GC19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		execve(path, args, envp);
> +		tst_brk(TFAIL | TERRNO, "Failed to execute execl01_child");
>  	}
>  
> -	tst_exit();
> +	SAFE_WAITPID(pid, NULL, 0);

As in the rest of the testcases the SAFE_WAITPID() should be removed.

>  }
>  
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, NULL);
> -
> -	TEST_PAUSE;
> -}
> +static struct tst_test test = {
> +	.needs_root = 1,

As well as this needs_root flag.

> +	.forks_child = 1,
> +	.child_needs_reinit = 1,
> +	.test_all = verify_execve,
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve02.c b/testcases/kernel/syscalls/execve/execve02.c
> index dddbfbc..f24e518 100644
> --- a/testcases/kernel/syscalls/execve/execve02.c
> +++ b/testcases/kernel/syscalls/execve/execve02.c
> @@ -1,23 +1,23 @@
>  /*
> - * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) 2018 Linux Test Project
>   * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
>   *  07/2001 Ported by Wayne Boyer
>   *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>   *
> - * This program is free software;  you can redistribute it and/or modify
> + * This program is free software: you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> + * the Free Software Foundation, either version 2 of the License, or
>   * (at your option) any later version.
>   *
>   * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  /*
> @@ -31,70 +31,52 @@
>  #endif
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <sys/wait.h>
>  #include <errno.h>
> -#include <libgen.h>
>  #include <pwd.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "execve02";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
>  #define TEST_APP "execve_child"
>  #define USER_NAME "nobody"
>  
> -static void setup(void);
> -static void cleanup(void);
> -
>  static uid_t nobody_uid;
>  
>  static void do_child(void)
>  {
>  	char *argv[2] = {TEST_APP, NULL};
>  
> -	SAFE_SETEUID(NULL, nobody_uid);
> +	SAFE_SETEUID(nobody_uid);
>  
> -	TEST(execve(TEST_APP, argv, NULL));
> +	/* Use environ:
> +	 *     Inherit a copy of parent's environment
> +	 *     for tst_reinit() in execve_child.c
> +	 */
> +	TEST(execve(TEST_APP, argv, environ));
>  
> -	if (!TEST_RETURN)
> -		tst_brkm(TFAIL, NULL, "execve() passed unexpectedly");
> +	if (!TST_RET)
> +		tst_brk(TFAIL, "execve() passed unexpectedly");
>  
> -	if (TEST_ERRNO != EACCES) {
> -		tst_brkm(TFAIL | TTERRNO, NULL,
> -		         "execve() failed unexpectedly");
> +	if (TST_ERR != EACCES) {
> +		tst_brk(TFAIL | TERRNO, "execve() failed unexpectedly");
>  	}
>  
> -	tst_resm(TPASS | TTERRNO, "execve() failed expectedly");
> -	tst_exit();
> +	tst_res(TPASS | TERRNO, "execve() failed expectedly");
> +
> +	exit(0);
>  }
>  
> -int main(int ac, char **av)
> +static void verify_execve(void)
>  {
> -	int lc;
> -	pid_t pid;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	pid_t pid = SAFE_FORK();
>  
> -		if ((pid = FORK_OR_VFORK()) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> +	if (pid == 0)
> +		do_child();
>  
> -		if (pid == 0)
> -			do_child();
> -
> -		tst_record_childstatus(cleanup, pid);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	SAFE_WAITPID(pid, NULL, 0);

Here as well the SAFE_WAITPID() is wrong.

>  }
>  
>  static void setup(void)
> @@ -102,23 +84,22 @@ static void setup(void)
>  	char path[PATH_MAX];
>  	struct passwd *pwd;
>  
> -	tst_require_root();
> -
>  	if (tst_get_path(TEST_APP, path, sizeof(path))) {
> -		tst_brkm(TBROK, NULL,
> -		         "Couldn't found "TEST_APP" binary in $PATH");
> +		tst_brk(TBROK, "Couldn't found "TEST_APP" binary in $PATH");
>  	}

Can we use the resource_files[] array as we do in creat07.c?

> -	tst_tmpdir();
> +	SAFE_CP(path, ".");
> +	SAFE_CHMOD(TEST_APP, 0700);
>  
> -	SAFE_CP(tst_rmdir, path, ".");
> -	SAFE_CHMOD(cleanup, TEST_APP, 0700);
> -
> -	pwd = SAFE_GETPWNAM(tst_rmdir, USER_NAME);
> +	pwd = SAFE_GETPWNAM(USER_NAME);
>  	nobody_uid = pwd->pw_uid;
>  }
>  
> -void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +	.child_needs_reinit = 1,
> +	.setup = setup,
> +	.test_all = verify_execve,
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve03.c b/testcases/kernel/syscalls/execve/execve03.c
> index 15b575d..45657de 100644
> --- a/testcases/kernel/syscalls/execve/execve03.c
> +++ b/testcases/kernel/syscalls/execve/execve03.c
> @@ -1,20 +1,22 @@
>  /*
> + * Copyright (c) 2018 Linux Test Project
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + *  07/2001 Ported by Wayne Boyer
> + *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  /*
> @@ -65,6 +67,9 @@
>   *	test #5 will fail with ETXTBSY not EACCES if the test is run as root
>   */

Can you please also remove the USAGE and RESTRICTIONS from here please?

> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <sys/types.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> @@ -72,141 +77,92 @@
>  #include <fcntl.h>
>  #include <pwd.h>
>  #include <stdio.h>
> +#include <unistd.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "execve03";
> -int fileHandle = 0;
> -
> -char nobody_uid[] = "nobody";
> -struct passwd *ltpuser;
> -
> -#ifndef UCLINUX
> -void *bad_addr = NULL;
> -#endif
> -
> -void setup(void);
> -void cleanup(void);
> +#include "tst_test.h"
>  
> -char long_file[] =
> -    "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> -char no_dir[] = "testdir";
> -char test_name3[1000];
> -char test_name5[1000];
> -char test_name6[1000];
> +static char nobody_uid[] = "nobody";
> +static struct passwd *ltpuser;
> +static char long_fname[] = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
> +static char no_dir[] = "testdir";
> +static char test_name3[1024];
> +static char test_name5[1024];
> +static char test_name6[1024];
>  
> -struct test_case_t {
> -	char *tname;		/* the command name to pass to execve() */
> +static struct tcase {
> +	char *tname;	/* the command name to pass to execve() */
>  	int error;
> -} TC[] = {
> +} tcases[] = {
>  	/* the file name is greater than VFS_MAXNAMELEN - ENAMTOOLONG */
> -	{
> -	long_file, ENAMETOOLONG},
> -	    /* the filename does not exist - ENOENT */
> -	{
> -	no_dir, ENOENT},
> -	    /* the path contains a directory name which doesn't exist - ENOTDIR */
> -	{
> -	test_name3, ENOTDIR},
> -#if !defined(UCLINUX)
> -	    /* the filename isn't part of the process address space - EFAULT */
> -	{
> -	(char *)-1, EFAULT},
> -#endif
> -	    /* the filename does not have execute permission - EACCES */
> -	{
> -	test_name5, EACCES},
> -	    /* the file is zero length with execute permissions - ENOEXEC */
> -	{
> -	test_name6, ENOEXEC}
> +	{long_fname, ENAMETOOLONG},
> +	/* the filename does not exist - ENOENT */
> +	{no_dir, ENOENT},
> +	/* the path contains a directory name which doesn't exist - ENOTDIR */
> +	{test_name3, ENOTDIR},
> +	/* the filename isn't part of the process address space - EFAULT */
> +	{NULL, EFAULT},
> +	/* the filename does not have execute permission - EACCES */
> +	{test_name5, EACCES},
> +	/* the file is zero length with execute permissions - ENOEXEC */
> +	{test_name6, ENOEXEC}
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(TC);
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -
> -			TEST(execve(TC[i].tname, av, NULL));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error)
> -				tst_resm(TPASS | TTERRNO,
> -					 "execve failed as expected");
> -			else
> -				tst_resm(TFAIL | TTERRNO,
> -					 "execve failed unexpectedly; expected "
> -					 "%d - %s",
> -					 TC[i].error, strerror(TC[i].error));
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -void setup(void)
> +static void setup(void)
>  {
>  	char *cwdname = NULL;
>  	int fd;
>  
> -	tst_require_root();
> -
>  	umask(0);
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	ltpuser = SAFE_GETPWNAM(NULL, nobody_uid);
> +	ltpuser = SAFE_GETPWNAM(nobody_uid);
>  
> -	SAFE_SETGID(NULL, ltpuser->pw_gid);
> +	SAFE_SETGID(ltpuser->pw_gid);
>  
> -	tst_tmpdir();
> -
> -	cwdname = SAFE_GETCWD(cleanup, cwdname, 0);
> +	cwdname = SAFE_GETCWD(cwdname, 0);
>  
>  	sprintf(test_name5, "%s/fake.%d", cwdname, getpid());
>  
> -	fileHandle = SAFE_CREAT(cleanup, test_name5, 0444);
> +	fd = SAFE_CREAT(test_name5, 0444);
> +	SAFE_CLOSE(fd);
>  
>  	sprintf(test_name3, "%s/fake.%d", test_name5, getpid());

Since the test is executed in unique test temporary directory we may as
well drop the getpid parts here.

>  	/* creat() and close a zero length file with executeable permission */
>  	sprintf(test_name6, "%s/execve03.%d", cwdname, getpid());
>  
> -	fd = SAFE_CREAT(cleanup, test_name6, 0755);
> -	fd = SAFE_CLOSE(cleanup, fd);
> -#ifndef UCLINUX
> -	bad_addr = SAFE_MMAP(cleanup, NULL, 1, PROT_NONE,
> -			     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	TC[3].tname = bad_addr;
> -#endif
> +	fd = SAFE_CREAT(test_name6, 0755);
> +	SAFE_CLOSE(fd);
> +
> +	tcases[3].tname = tst_get_bad_addr(NULL);

Also hardcoding offsets to the test structure is frowned upon. We tend
to do instead:

	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
		if (!tcases[i].tname)
			tcases[i].tname = tst_get_bad_addr(NULL);
	}

>  }
>  
> -void cleanup(void)
> +static void verify_execve(unsigned int i)
>  {
> -#ifndef UCLINUX
> -	SAFE_MUNMAP(NULL, bad_addr, 1);
> -#endif
> -	SAFE_CLOSE(NULL, fileHandle);
> +	struct tcase *tc = &tcases[i];
> +	char *argv[2] = {tc->tname, NULL};
>  
> -	tst_rmdir();
> +	TEST(execve(tc->tname, argv, NULL));
>  
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (TST_ERR == tc->error)
> +		tst_res(TPASS | TTERRNO,
> +				"execve failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO,
> +				"execve failed unexpectedly; expected "
> +				"%d - %s",
> +				tc->error, strerror(tc->error));
>  }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_execve,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.child_needs_reinit = 1,
> +	.setup = setup,
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve04.c b/testcases/kernel/syscalls/execve/execve04.c
> index 7847470..5421e32 100644
> --- a/testcases/kernel/syscalls/execve/execve04.c
> +++ b/testcases/kernel/syscalls/execve/execve04.c
> @@ -1,23 +1,23 @@
>  /*
> - * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) 2018 Linux Test Project
>   * Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
>   *  07/2001 Ported by Wayne Boyer
>   *  04/2008 Roy Lee <roylee@andestech.com>
>   *
> - * This program is free software;  you can redistribute it and/or modify
> + * This program is free software: you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> + * the Free Software Foundation, either version 2 of the License, or
>   * (at your option) any later version.
>   *
>   * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundation,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  /*
> @@ -34,98 +34,74 @@
>  #include <fcntl.h>
>  #include <libgen.h>
>  #include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  
>  #define TEST_APP "execve_child"
>  
> -char *TCID = "execve04";
> -int TST_TOTAL = 1;
> -
> -static void setup(void);
> -static void cleanup(void);
>  static void do_child(void);
>  
> -int main(int ac, char **av)
> +static void verify_execve(void)
>  {
> -	int lc;
>  	pid_t pid;
>  	char *argv[2] = {TEST_APP, NULL};
> -	char *env[1] = {NULL};
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
>  
>  #ifdef UCLINUX
>  	maybe_run_child(&do_child, "");
>  #endif

UCLINUX is not suppored by new library, can you please remove it?

> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		if ((pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "fork failed");
> -		} else if (pid == 0) {
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
>  #ifdef UCLINUX
> -			if (self_exec(av[0], "") < 0)
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> +		if (self_exec(TCID, "") < 0)
> +			tst_brk(TBROK, "self_exec failed");
>  #else
> -			do_child();
> +		do_child();
>  #endif
> -		}
> +	}
>  
> -		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> +	TST_CHECKPOINT_WAIT(0);
>  
> -		TEST(execve(TEST_APP, argv, env));
> +	TEST(execve(TEST_APP, argv, environ));
>  
> -		if (TEST_ERRNO != ETXTBSY)
> -			tst_resm(TFAIL | TTERRNO, "execve succeeded, expected failure");
> -		else
> -			tst_resm(TPASS | TTERRNO, "execve failed as expected");
> +	if (TST_ERR != ETXTBSY)
> +		tst_res(TFAIL | TTERRNO, "execve succeeded, expected failure");
> +	else
> +		tst_res(TPASS | TTERRNO, "execve failed as expected");
>  
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> -		SAFE_WAIT(cleanup, NULL);
> -	}
> +	TST_CHECKPOINT_WAKE(0);
>  
> -	cleanup();
> -	tst_exit();
> +	SAFE_WAITPID(pid, NULL, 0);

The waitpid() here is wrong as well.

>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
>  	char path[PATH_MAX];
>  
> -	if (tst_get_path(TEST_APP, path, sizeof(path))) {
> -		tst_brkm(TBROK, NULL,
> -		         "Couldn't found "TEST_APP" binary in $PATH");
> -	}
> -
> -	tst_tmpdir();
> -
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> +	if (tst_get_path(TEST_APP, path, sizeof(path)))
> +		tst_brk(TBROK, "Couldn't found "TEST_APP" binary in $PATH");
>  
> -	SAFE_CP(tst_rmdir, path, ".");
> -}

We can replace the setup here by using the resource_files[] array.

> -static void cleanup(void)
> -{
> -	tst_rmdir();
> +	SAFE_CP(path, ".");
>  }
>  
>  static void do_child(void)
>  {
> -	int fd;
> +	int fd = SAFE_OPEN(TEST_APP, O_WRONLY);
> +	TST_CHECKPOINT_WAKE(0);
>  
> -#ifdef UCLINUX
> -	TST_CHECKPOINT_INIT(NULL);
> -#endif
> -
> -	if ((fd = open(TEST_APP, O_WRONLY)) == -1) {
> -		perror("open failed");
> -		exit(1);
> -	}
> -
> -	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
> +	TST_CHECKPOINT_WAIT(0);
> +	SAFE_CLOSE(fd);
>  
>  	exit(0);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_execve,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.child_needs_reinit = 1,
> +	.needs_checkpoints = 1,
> +	.setup = setup,
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
> index 66290f6..5c2d045 100644
> --- a/testcases/kernel/syscalls/execve/execve05.c
> +++ b/testcases/kernel/syscalls/execve/execve05.c
> @@ -1,20 +1,22 @@
>  /*
> + * Copyright (c) 2018 Linux Test Project
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + *  07/2001 Ported by Wayne Boyer
> + *  21/04/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  /*
> @@ -26,174 +28,109 @@
>   *	call.
>   *
>   * ALGORITHM
> - *	This program also gets the names "test1", and "test2". This tests
> - *	the functionality of the execve(2) system call by spawning a few
> - *	children, each of which would execute "test1/test2" executables, and
> - *	finally the parent ensures that they terminated correctly.
> + *	This tests the functionality of the execve(2) system call by spawning
> + *	a few children, each of which would execute "execve_child" simultaneously,
> + *	and finally the parent ensures that they terminated correctly.
>   *
>   * USAGE
> - *	execve05 20 test1 test2 4
> - *
> - * RESTRICTIONS
> - * 	This program does not follow the LTP format - *PLEASE FIX*
> + *	execve05 -i 5 -n 20
>   */
>  
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <errno.h>
> +#include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <pwd.h>
>  
> -#undef DEBUG			/* change this to #define if needed */
> +#include "tst_test.h"
>  
> -void setup(void);
> -void cleanup(void);
> +#define TEST_APP "execve_child"
> +#define TEST_FILE "mmapfile"
> +#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
>  
> -char *TCID = "execve05";
> -int TST_TOTAL = 1;
> +static int fd;
> +static size_t size;
> +static int nchild = 8;
> +static char *start;
>  
> -int iterations;
> -char *fname1;
> -char *fname2;
> -char *prog;
> -char *av[6];
> -char *ev[1];
> +static char *opt_nchild;
> +static struct tst_option exe_options[] = {
> +	{"n:", &opt_nchild, "-n    numbers of children"},
> +	{NULL, NULL, NULL}
> +};
>  
> -void usage(void)
> +static void parse_exe_options(char *str_nchild, int *nchild)
>  {
> -	tst_brkm(TBROK, NULL, "usage: %s <iters> <fname1> <fname2> <count>",
> -		 TCID);
> +	if(tst_parse_int(str_nchild, nchild, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid children numbers '%s'", str_nchild);
>  }

Why do we have a separate function for option parsing and why is it
called from verify_execve()?

The option parsing is supposed to be called in test setup btw.

> -int main(int ac, char **av)
> +static void do_child(int i)
>  {
> -	char iter[20];
> -	int count, i, nchild, status;
> -	pid_t pid;
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	char *argv[3] = {TEST_APP, "canary", NULL};
>  
> -	setup();
> +	tst_res(TINFO, "process %d(pid) is child %d", getpid(), ++i);
>  
> -	if (ac != 5)
> -		usage();
> +	while (strcmp(start, "start")) {
> +		if (i == nchild)
> +			strcpy(start, "start");
>  
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> +		usleep(10000);
> +	}

This is a poor reimplementation of checkpoints, we can easily replace it
with each child calling TST_CHECKPOINT_WAIT(0) and parent calling
TST_CHECKPOINT_WAKE2(0, nchild).

> -		prog = av[0];
> -		iterations = atoi(av[1]);
> -		fname1 = av[2];
> -		fname2 = av[3];
> -		count = atoi(av[4]);
> -#ifdef DEBUG
> -		tst_resm(TINFO, "Entered %s %d %s %s %d -- pid = %d", prog,
> -			 iterations, fname1, fname2, count, getpid());
> -#endif
> +	TEST(execve(TEST_APP, argv, environ));
> +	tst_res(TFAIL | TERRNO, "execve() returned unexpected errno");
> +}
>  
> -		if (iterations == 0) {
> -			tst_resm(TPASS, "Test DONE, pid %d, -- %s %d %s %s",
> -				 getpid(), prog, iterations, fname1, fname2);
> -			tst_exit();
> -		}
> -
> -		if (!count) {
> -			sprintf(iter, "%d", iterations - 1);
> -			av[0] = fname1;
> -			av[1] = iter;
> -			av[2] = fname1;
> -			av[3] = fname2;
> -			av[4] = "0";
> -			av[5] = 0;
> -			ev[0] = 0;
> -#ifdef DEBUG
> -			tst_resm(TINFO, "doing execve(%s, av, ev)", fname1);
> -			tst_resm(TINFO, "av[0,1,2,3,4] = %s, %s, %s, %s, %s",
> -				 av[0], av[1], av[2], av[3], av[4]);
> -#endif
> -			(void)execve(fname1, av, ev);
> -			tst_resm(TFAIL, "Execve fail, %s, errno=%d", fname1,
> -				 errno);
> -		}
> -
> -		nchild = count * 2;
> -
> -		sprintf(iter, "%d", iterations);
> -		for (i = 0; i < count; i++) {
> -
> -			pid = FORK_OR_VFORK();
> -			if (pid == -1) {
> -				perror("fork failed");
> -				exit(1);
> -			} else if (pid == 0) {
> -				av[0] = fname1;
> -				av[1] = iter;
> -				av[2] = fname1;
> -				av[3] = fname2;
> -				av[4] = "0";
> -				av[5] = 0;
> -				ev[0] = 0;
> -				(void)execve(fname1, av, ev);
> -				perror("execve failed");
> -				exit(2);
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Main - started pid %d", pid);
> -#endif
> -			SAFE_WAIT(cleanup, &status);
> -			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -				tst_resm(TFAIL, "child exited abnormally");
> -
> -			pid = FORK_OR_VFORK();
> -			if (pid == -1) {
> -				perror("Fork failed");
> -				exit(1);
> -			} else if (pid == 0) {
> -				av[0] = fname2;
> -				av[1] = iter;
> -				av[2] = fname2;
> -				av[3] = fname1;
> -				av[4] = "0";
> -				av[5] = 0;
> -				ev[0] = 0;
> -				execve(fname2, av, ev);
> -				perror("execve failed");
> -				exit(2);
> -			}
> -#ifdef DEBUG
> -			tst_resm(TINFO, "Main - started pid %d", pid);
> -#endif
> -			SAFE_WAIT(cleanup, &status);
> -			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -				tst_resm(TFAIL, "child exited abnormally");
> +static void verify_execve(void)
> +{
> +	int i;
>  
> -		}
> +	parse_exe_options(opt_nchild, &nchild);
>  
> -		if (wait(&status) != -1)
> -			tst_brkm(TBROK, cleanup,
> -				 "leftover children haven't exited yet");
> +	memset(start, '0', size);
>  
> +	for (i = 0; i < nchild; i++) {
> +		if (SAFE_FORK() == 0)
> +			do_child(i);
>  	}
> -	cleanup();
>  
> -	tst_exit();
> +	tst_reap_children();
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> +	char path[PATH_MAX];
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	if (tst_get_path(TEST_APP, path, sizeof(path)))
> +		tst_brk(TBROK, "Couldn't found "TEST_APP" binary in $PATH");
> +	SAFE_CP(path, ".");

This could be replaced by resource_files[] array as well.

> -	umask(0);
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0755);
> +	SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
> +	size = getpagesize();
> +	start = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> +	SAFE_CLOSE(fd);
> +	SAFE_MUNMAP(start, size);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_execve,
> +	.options = exe_options,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +	.child_needs_reinit = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> diff --git a/testcases/kernel/syscalls/execve/execve_child.c b/testcases/kernel/syscalls/execve/execve_child.c
> index 2ec8496..30e0d41 100644
> --- a/testcases/kernel/syscalls/execve/execve_child.c
> +++ b/testcases/kernel/syscalls/execve/execve_child.c
> @@ -1,32 +1,41 @@
>  /*
> + * Copyright (c) 2018 Linux Test Project
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  /*
>   * test3.c
> - *	dummy program which is used by execve03.c testcase
> + *	dummy program which is used by execve02/4/5.c testcase
>   */
>  
> +#define TST_NO_DEFAULT_MAIN
>  #include <stdlib.h>
> -#include <stdio.h>
> +#include "tst_test.h"
>  
> -int main(void)
> +int main(int argc, char *argv[])
>  {
> -	printf("Hello World\n");
> -	exit(0);
> +	tst_reinit();
> +
> +	/* For execve05 test, it should be returned here*/
> +	if (!strcmp(argv[1], "canary")) {
> +		tst_res(TPASS, "argv[1] is %s, expected 'canary'", argv[1]);
> +		return 0;
> +	}
> +
> +	/* For execve02/4 test, it shouldn't be executed */
> +	tst_res(TFAIL, "%s shouldn't be executed", argv[0]);
> +	return 0;
>  }
> -- 
> 2.9.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
