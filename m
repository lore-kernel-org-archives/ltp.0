Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYg0h-0002rx-Gm
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 17:44:51 +0000
Date: Tue, 22 Oct 2013 19:44:33 +0200
From: chrubis@suse.cz
Message-ID: <20131022174433.GB7753@rei>
References: <002501cecbfd$3478cee0$9d6a6ca0$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <002501cecbfd$3478cee0$9d6a6ca0$@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] acct/acct01.c: clean up
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Using loops to the test.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c | 186 ++++++++++++++++++--------------
>  1 file changed, 106 insertions(+), 80 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index 462fd5a..062cc2b 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -1,23 +1,23 @@
>  /*
>   *
> - *   Copyright (c) International Business Machines  Corp., 2002
> + *  Copyright (c) International Business Machines  Corp., 2002
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + *  This program is free software;  you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *  the GNU General Public License for more details.
>   *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program;  if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
>  
> -/* 12/03/2002   Port to LTP     robbiew@us.ibm.com */
> +/* 12/03/2002	Port to LTP     robbiew@us.ibm.com */
>  /* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
>  
>  /*
> @@ -33,7 +33,7 @@
>   *
>   * RESTRICTIONS
>   *	This must run root since the acct call may only be done
> - *	by root.   Use the TERM flag, to clean up files.
> + *	by root. Use the TERM flag, to clean up files.
>   */

Looking at the comment only the ALGORITHM part is somehow usefull, what
about removing rthe rest of it (i.e. NAME, CALLS, RESTRICTIONS).

>  #include <sys/types.h>
> @@ -41,7 +41,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <pwd.h>
> -#include <stdio.h>		/* needed by testhead.h         */
> +#include <stdio.h>		/* needed by testhead.h */

Please remove this comment.

>  #include <stdlib.h>
>  #include <unistd.h>
>  
> @@ -49,100 +49,126 @@
>  #include "usctest.h"
>  #include "safe_macros.h"
>  
> -char *TCID = "acct01";
> -int TST_TOTAL = 6;
> +#define TEST_FILE1	"/"
> +#define TEST_FILE2	"/dev/null"
> +#define TEST_FILE3	"/tmp/does/not/exist"
> +#define TEST_FILE4	"/etc/fstab/"
> +#define TEST_FILE5	"./tmpfile"
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void setup2(void);
> +static void cleanup2(void);
> +static void acct_verify(int);
> +
> +static struct test_case_t {
> +	char *filename;
> +	char *exp_errval;
> +	int exp_errno;
> +	void (*setupfunc) ();
> +	void (*cleanfunc) ();
> +} test_cases[] = {
> +	{TEST_FILE1, "EISDIR",  EISDIR,  NULL,   NULL},
> +	{TEST_FILE2, "EACCES",  EACCES,  NULL,   NULL},
> +	{TEST_FILE3, "ENOENT",  ENOENT,  NULL,   NULL},
> +	{TEST_FILE4, "ENOTDIR", ENOTDIR, NULL,   NULL},
> +	{TEST_FILE5, "EPERM",   EPERM,   setup2, cleanup2},
> +};
>  
> -char tmpbuf[80];
> -int fd;
> +char *TCID = "acct01";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +struct passwd *ltpuser;
> +static int exp_enos[] = { EISDIR, EACCES, ENOENT, ENOTDIR, EPERM, 0 };
>  
> -static void cleanup(void)
> +int main(int argc, char *argv[])
>  {
> +	int lc;
> +	int i;
>  
> -	if (acct(NULL) == -1)
> -		tst_resm(TBROK | TERRNO, "acct(NULL) failed");
> +	setup();
>  
> -	tst_rmdir();
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +		for (i = 0; i < TST_TOTAL; i++)
> +			acct_verify(i);
> +	}
> +
> +	cleanup();
> +	tst_exit();
>  }
>  
>  static void setup(void)
>  {
> -
> -	/*
> -	 * XXX: FreeBSD says you must always be superuser, but Linux says you
> -	 * need to have CAP_SYS_PACCT capability.
> -	 *
> -	 * Either way, it's better to do this to test out the EPERM
> -	 * requirement.
> -	 */
>  	tst_require_root(NULL);
>  
>  	tst_tmpdir();
>  
>  	/* turn off acct, so we are in a known state */
>  	if (acct(NULL) == -1) {
> -		if (errno == ENOSYS)
> +		if (errno == ENOSYS) {
>  			tst_brkm(TCONF, cleanup,
> -				 "BSD process accounting is not configured in this "
> -				 "kernel");
> +				 "BSD process accounting is not configured in "
> +				 "this kernel");
> +		}
>  		else
>  			tst_brkm(TBROK | TERRNO, cleanup, "acct(NULL) failed");
>  	}
>  }

The correct coding style is:

		} else {
			tst_brkm(...);
		}

The else should start on the line with the closing bracket and as the
first block is enclosed in {} the second should be as well.

You can use checkpatch.pl script that is a part of Linux kernel sources
to check your patches before you send them.

> -int main(int argc, char *argv[])
> +static void acct_verify(int i)
>  {
> -	struct passwd *pwent;
>  
> -	setup();
> +	if (test_cases[i].setupfunc)
> +		test_cases[i].setupfunc();
> +
> +	TEST(acct(test_cases[i].filename));
>  
> -	/* EISDIR */
> -	if (acct("/") == -1 && errno == EISDIR)
> -		tst_resm(TPASS, "Failed with EISDIR as expected");
> -	else
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "didn't fail as expected; expected EISDIR");
> -
> -	/* EACCES */
> -	if (acct("/dev/null") == -1 && errno == EACCES)
> -		tst_resm(TPASS, "Failed with EACCES as expected");
> -	else
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "didn't fail as expected; expected EACCES");
> -
> -	/* ENOENT */
> -	if (acct("/tmp/does/not/exist") == -1 && errno == ENOENT)
> -		tst_resm(TPASS, "Failed with ENOENT as expected");
> -	else
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "didn't fail as expected; expected ENOENT");
> -
> -	/* ENOTDIR */
> -	if (acct("/etc/fstab/") == -1 && errno == ENOTDIR)
> -		tst_resm(TPASS, "Failed with ENOTDIR as expected");
> -	else
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "didn't fail as expected; expected ENOTDIR");
> -
> -	/* EPERM */
> -	sprintf(tmpbuf, "./%s.%d", TCID, getpid());
> -	fd = SAFE_CREAT(cleanup, tmpbuf, 0777);
> +	if (test_cases[i].cleanfunc)
> +		test_cases[i].cleanfunc();
> +
> +	if (TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "acct(%s) succeeded unexpectedly",
> +			 test_cases[i].filename);
> +		return;
> +	}
> +	if (TEST_ERRNO == test_cases[i].exp_errno) {
> +		tst_resm(TPASS | TTERRNO, "acct failed as expected");
> +	} else {
> +		tst_resm(TFAIL | TTERRNO,
> +			 "acct failed unexpectedly; expected: %d - %s",
> +			 test_cases[i].exp_errno,
> +			 strerror(test_cases[i].exp_errno));
> +	}
> +}
> +
> +static void setup2(void)
> +{
> +	int fd;
> +
> +	fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
>  	SAFE_CLOSE(cleanup, fd);
>  
> -	if (acct(tmpbuf) == -1)
> +	if (acct(TEST_FILE5) == -1)
>  		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
>  
> -	pwent = SAFE_GETPWNAM(cleanup, "nobody");
> -	SAFE_SETEUID(cleanup, pwent->pw_uid);
> -
> -	if (acct(tmpbuf) == -1 && errno == EPERM)
> -		tst_resm(TPASS, "Failed with EPERM as expected");
> -	else
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "didn't fail as expected; expected EPERM");
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> +}
>  
> +static void cleanup2(void)
> +{
>  	SAFE_SETEUID(cleanup, 0);
> -	SAFE_UNLINK(cleanup, tmpbuf);
> +	SAFE_UNLINK(cleanup, TEST_FILE5);
> +}

You can create the TEST_FILE5 once in global setup and use the
setup/cleanup to set reset the effective UID.

> -	cleanup();
> -	tst_exit();
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	if (acct(NULL) == -1)
> +		tst_resm(TBROK | TERRNO, "acct(NULL) failed");
> +
> +	tst_rmdir();
> }

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
