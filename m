From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 Jul 2020 16:52:31 +0800
Subject: [LTP] [PATCH] Convert chdir01 to the new API
In-Reply-To: <20200717152450.10787-1-mdoucha@suse.cz>
References: <20200717152450.10787-1-mdoucha@suse.cz>
Message-ID: <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin

Honestly speak, I don't like merge chdir02 into chdir01 and we should 
cleanup chdir02 case individually.

I prefer to merge chdir03 and chdir04 into chdir01 because they are all 
error test.

Also, when tesing EACCES error,it succeeded.
tst_test.c:1245: INFO: Timeout per run is 0h 05m 00s
chdir01.c:68: PASS: chdir("testfile") returns correct value: ENOTDIR (20)
chdir01.c:68: PASS: chdir("symloop") returns correct value: ELOOP (40)
chdir01.c:61: FAIL: chdir("keep_out") returned unexpected value 0: 
SUCCESS (0)
chdir01.c:68: PASS: chdir("subdir") returns correct value: SUCCESS (0)
chdir01.c:68: PASS: chdir(".") returns correct value: SUCCESS (0)
chdir01.c:68: PASS: chdir("..") returns correct value: SUCCESS (0)
chdir01.c:68: PASS: chdir("missing") returns correct value: ENOENT (2)

Best regards
Yang Xu
> chdir02 and chdir03 were removed because the updated chdir01 makes them
> redundant.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>   runtest/quickhit                           |   2 +-
>   runtest/syscalls                           |   2 -
>   testcases/kernel/syscalls/chdir/.gitignore |   2 -
>   testcases/kernel/syscalls/chdir/chdir01.c  | 229 ++++++---------------
>   testcases/kernel/syscalls/chdir/chdir02.c  | 163 ---------------
>   testcases/kernel/syscalls/chdir/chdir03.c  |  68 ------
>   6 files changed, 67 insertions(+), 399 deletions(-)
>   delete mode 100644 testcases/kernel/syscalls/chdir/chdir02.c
>   delete mode 100644 testcases/kernel/syscalls/chdir/chdir03.c
> 
> diff --git a/runtest/quickhit b/runtest/quickhit
> index e01b838fb..b17318b65 100644
> --- a/runtest/quickhit
> +++ b/runtest/quickhit
> @@ -24,7 +24,7 @@ brk01 brk01
>   # Basic test for brk()
>   #    TEST CASES
>   # 	1.) brk(2) returns...
> -chdir02 chdir02
> +chdir01 chdir01
>   # Basic test for chdir(2)
>   #    TEST CASES
>   # 	1.) chdir(2) returns...
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 819e8d8ee..6e45f72a9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -55,8 +55,6 @@ cacheflush01 cacheflush01
>   
>   chdir01 chdir01
>   chdir01A symlink01 -T chdir01
> -chdir02 chdir02
> -chdir03 chdir03
>   chdir04 chdir04
>   
>   chmod01 chmod01
> diff --git a/testcases/kernel/syscalls/chdir/.gitignore b/testcases/kernel/syscalls/chdir/.gitignore
> index c1e4b9d07..1b15eb6b9 100644
> --- a/testcases/kernel/syscalls/chdir/.gitignore
> +++ b/testcases/kernel/syscalls/chdir/.gitignore
> @@ -1,4 +1,2 @@
>   /chdir01
> -/chdir02
> -/chdir03
>   /chdir04
> diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
> index 81cf7c564..8f874ff6d 100644
> --- a/testcases/kernel/syscalls/chdir/chdir01.c
> +++ b/testcases/kernel/syscalls/chdir/chdir01.c
> @@ -1,181 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *
>    *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *	07/2001 Ported by Wayne Boyer
>    */
>   
>   /*
> - * NAME
> - * 	chdir01.c
> - *
> - * DESCRIPTION
> - *	Check proper operation of chdir(): tests whether the
> - *	system call can it change the current, working directory, and find a
> - *	file there? Will it fail on a non-directory entry ?
> - *
> - * ALGORITHM
> - * 	Make a directory "Testdirectory", and create a file in it. cd into
> - * 	the directory and read the entry. It should be the file just
> - * 	created.
> - *
> - * USAGE:  <for command-line>
> - *  chdir01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - * 	None
> + * Check that the chdir() syscall returns correct value and error code
> + * in various situations
>    */
>   
> -#include <stdio.h>
> -#include <sys/types.h>
> -#include <dirent.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <fcntl.h>
> -#include<sys/stat.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "chdir01";
> -int TST_TOTAL = 2;
> -
> -void setup(void);
> -void cleanup(void);
> -static void checknames(char **, int, DIR *);
> -
> -char testdir[40] = "";
> -
> -int main(int ac, char **av)
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +
> +#define FILE_NAME "testfile"
> +#define DIR_NAME "subdir"
> +#define BLOCKED_NAME "keep_out"
> +#define LINK_NAME1 "symloop"
> +#define LINK_NAME2 "symloop2"
> +
> +static char *workdir;
> +
> +static struct test_case {
> +	char name[32];
> +	int retval, experr;
> +} testcase_list[] = {
> +	{FILE_NAME, -1, ENOTDIR},
> +	{LINK_NAME1, -1, ELOOP},
> +	{BLOCKED_NAME, -1, EACCES},
> +	{DIR_NAME, 0, 0},
> +	{".", 0, 0},
> +	{"..", 0, 0},
> +	{"missing", -1, ENOENT},
> +};
> +
> +static void setup(void)
>   {
> -	DIR *ddir, *opendir();
>   	int fd;
> -	char *filname = "chdirtest";
> -	char *filenames[3];
> -
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		SAFE_CHDIR(cleanup, testdir);
> -
> -		fd = SAFE_CREAT(cleanup, filname, 0000);
> -		SAFE_CLOSE(cleanup, fd);
> -		if ((ddir = opendir(".")) == NULL)
> -			tst_brkm(TBROK | TERRNO, cleanup, "opendir(.) failed");
> -
> -		filenames[0] = ".";
> -		filenames[1] = "..";
> -		filenames[2] = filname;
> -		checknames(filenames, sizeof(filenames) / sizeof(filenames[0]),
> -			   ddir);
> -		closedir(ddir);
> -
> -		TEST(chdir(filname));
> -
> -		if (TEST_RETURN != -1)
> -			tst_resm(TFAIL, "call succeeded unexpectedly");
> -		else if (TEST_ERRNO != ENOTDIR)
> -			tst_resm(TFAIL | TTERRNO,
> -				 "failed unexpectedly; wanted ENOTDIR");
> -		else
> -			tst_resm(TPASS, "failed as expected with ENOTDIR");
> -
> -		SAFE_UNLINK(cleanup, filname);
> -
> -		SAFE_CHDIR(cleanup, "..");
> -
> -		/* ELOOP */
> -		SAFE_SYMLINK(cleanup, "test_eloop1", "test_eloop2");
> -		SAFE_SYMLINK(cleanup, "test_eloop2", "test_eloop1");
> -
> -		TEST(chdir("test_eloop1"));
> -
> -		if (TEST_RETURN != -1) {
> -			tst_resm(TFAIL, "call succeeded unexpectedly");
> -		} else if (TEST_ERRNO != ELOOP) {
> -			tst_resm(TFAIL | TTERRNO,
> -				 "failed unexpectedly; wanted ELOOP");
> -		} else {
> -			tst_resm(TPASS, "failed as expected with ELOOP");
> -		}
> -
> -		SAFE_UNLINK(cleanup, "test_eloop1");
> -		SAFE_UNLINK(cleanup, "test_eloop2");
> -	}
> -	cleanup();
> -
> -	tst_exit();
>   
> +	workdir = tst_get_tmpdir();
> +	SAFE_MKDIR(DIR_NAME, 0755);
> +	SAFE_MKDIR(BLOCKED_NAME, 0644);
> +	SAFE_SYMLINK(LINK_NAME1, LINK_NAME2);
> +	SAFE_SYMLINK(LINK_NAME2, LINK_NAME1);
> +	fd = SAFE_CREAT(FILE_NAME, 0644);
> +	SAFE_CLOSE(fd);
>   }
>   
> -void setup(void)
> +static void run(unsigned int n)
>   {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	umask(0);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	sprintf(testdir, "Testdir.%d", getpid());
> -
> -	SAFE_MKDIR(cleanup, testdir, 0700);
> +	struct test_case *tc = testcase_list + n;
> +
> +	/* Just in case chdir(".."); somehow fails */
> +	SAFE_CHDIR(workdir);
> +
> +	TEST(chdir(tc->name));
> +
> +	if (TST_RET != tc->retval) {
> +		tst_res(TFAIL | TTERRNO,
> +			"chdir(\"%s\") returned unexpected value %ld",
> +			tc->name, TST_RET);
> +	} else if (TST_ERR == -1 && TST_ERR != tc->experr) {
> +		tst_res(TFAIL | TTERRNO,
> +			"chdir(\"%s\") returned unexpected error", tc->name);
> +	} else {
> +		tst_res(TPASS | TTERRNO, "chdir(\"%s\") returns correct value",
> +			tc->name);
> +	}
>   }
>   
> -void cleanup(void)
> +static void cleanup(void)
>   {
> -	tst_rmdir();
> +	free(workdir);
>   }
>   
> -void checknames(char **pfilnames, int fnamecount, DIR * ddir)
> -{
> -	struct dirent *dir;
> -	int i, found;
> -
> -	found = 0;
> -	while ((dir = readdir(ddir)) != NULL) {
> -		for (i = 0; i < fnamecount; i++) {
> -			/*
> -			 * if dir->d_name is not null terminated it is a bug
> -			 * anyway
> -			 */
> -			if (strcmp(pfilnames[i], dir->d_name) == 0) {
> -				tst_resm(TINFO, "Found file %s", dir->d_name);
> -				found++;
> -			}
> -		}
> -	}
> -	if (found < fnamecount) {
> -		tst_brkm(TFAIL, cleanup,
> -			 "Some files do not exist, but they must exist");
> -	}
> -}
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(testcase_list),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> diff --git a/testcases/kernel/syscalls/chdir/chdir02.c b/testcases/kernel/syscalls/chdir/chdir02.c
> deleted file mode 100644
> index 6fc251c5f..000000000
> --- a/testcases/kernel/syscalls/chdir/chdir02.c
> +++ /dev/null
> @@ -1,163 +0,0 @@
> -/*
> - * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
> - */
> -/* $Id: chdir02.c,v 1.6 2009/08/28 11:32:19 vapier Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: chdir02
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for chdir(2)
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: William Roske
> - *
> - *    CO-PILOT		: Dave Fenner
> - *
> - *    DATE STARTED	: 03/30/92
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - *	1.) chdir(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - *	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    OUTPUT SPECIFICATIONS
> - *
> - *    DURATION
> - *	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - *	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - *	None
> - *
> - *    INTERCASE DEPENDENCIES
> - *	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the chdir(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	chdir(2).
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	 Loop if the proper options are given.
> - *	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *
> - *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> -
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "chdir02";
> -int TST_TOTAL = 1;
> -
> -char *dirs[2] = { "/", "/tmp" };
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(chdir(dirs[lc % 2]));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "chdir(%s) failed",
> -				 dirs[lc % 2]);
> -		} else {
> -			tst_resm(TPASS, "chdir(%s) returned %ld",
> -				 dirs[lc % 2], TEST_RETURN);
> -		}
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -void cleanup(void)
> -{
> -}
> diff --git a/testcases/kernel/syscalls/chdir/chdir03.c b/testcases/kernel/syscalls/chdir/chdir03.c
> deleted file mode 100644
> index 5beabdb1c..000000000
> --- a/testcases/kernel/syscalls/chdir/chdir03.c
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) International Business Machines Corp., 2001
> - * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
> - */
> -
> -/*
> - * DESCRIPTION
> - *	Testcase for testing that chdir(2) sets EACCES errno
> - *
> - * ALGORITHM
> - *	1.	running as root, create a directory with perm 700
> - *	2.	create a child process, sets its uid to nobody
> - *	3.	this child attempts to chdir(2) to the directory created in 1
> - *		and expects to get an EACCES.
> - */
> -
> -#include <pwd.h>
> -#include <errno.h>
> -#include <stdlib.h>
> -#include "tst_test.h"
> -
> -#define DIRNAME "chdir03_dir"
> -
> -static uid_t nobody_uid;
> -
> -void verify_chdir(void)
> -{
> -	pid_t pid;
> -
> -	pid = SAFE_FORK();
> -	if (!pid) {
> -		SAFE_SETUID(nobody_uid);
> -
> -		TEST(chdir(DIRNAME));
> -
> -		if (TST_RET != -1) {
> -			tst_res(TFAIL, "chdir() succeeded unexpectedly");
> -			return;
> -		}
> -
> -		if (TST_ERR != EACCES) {
> -			tst_res(TFAIL | TTERRNO,
> -				"chdir() should fail with EACCES");
> -			return;
> -		}
> -
> -		tst_res(TPASS | TTERRNO, "chdir() failed expectedly");
> -	}
> -}
> -
> -void setup(void)
> -{
> -	struct passwd *pw;
> -
> -	pw = SAFE_GETPWNAM("nobody");
> -	nobody_uid = pw->pw_uid;
> -
> -	SAFE_MKDIR(DIRNAME, 0700);
> -}
> -
> -static struct tst_test test = {
> -	.setup = setup,
> -	.test_all = verify_chdir,
> -	.needs_tmpdir = 1,
> -	.needs_root = 1,
> -	.forks_child = 1,
> -};
> 


