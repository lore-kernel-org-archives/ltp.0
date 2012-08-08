Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SyxwA-000661-W2
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 04:32:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Syxw9-0004OW-PT
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 04:32:02 +0000
Message-ID: <5021EB6D.1090502@cn.fujitsu.com>
Date: Wed, 08 Aug 2012 12:30:37 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1343318084-23375-1-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1343318084-23375-1-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH] V2 /lib/tst_tmpdir Implemented a simple testcase.
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Marios Makris <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 07/26/2012 11:54 PM, Marios Makris wrote:
> Simple testcase to check the correct functionality of the tst_tmpdir.c file.
> Also removed the Unit test blocks from the tst_tmdir.c.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>

Can you send out your tmpdir cleanup series again? I mean together
with other patches I have reviewed before. It'll be easy to pick up.

Thanks,
Wanlong Gao

> ---
>  lib/tests/tst_tmpdir_test.c |   77 +++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_tmpdir.c            |   50 ----------------------------
>  2 files changed, 77 insertions(+), 50 deletions(-)
>  create mode 100644 lib/tests/tst_tmpdir_test.c
> 
> diff --git a/lib/tests/tst_tmpdir_test.c b/lib/tests/tst_tmpdir_test.c
> new file mode 100644
> index 0000000..a99fac9
> --- /dev/null
> +++ b/lib/tests/tst_tmpdir_test.c
> @@ -0,0 +1,77 @@
> +/*
> + * Copyright (C) 2012 Marios Makris <marios.makris@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc., 59
> + */
> +
> +/*
> + * Test program for the tst_tmpdir program in /lib
> + *
> + * This program creates and deletes a temporary file in order to test
> + * the functionality of the tst_tmpdir functionality.
> + * On successfull completion it prints the message:
> + * "Test completed successfully!"
> + */
> +
> +#include <stdio.h>
> +
> +#include "test.h"
> +
> +#ifndef PATH_MAX
> +#ifdef MAXPATHLEN
> +#define PATH_MAX	MAXPATHLEN
> +#else
> +#define PATH_MAX	1024
> +#endif
> +#endif
> +
> +char *TCID = "tst_tmpdir_test";
> +int TST_TOTAL = 1;
> +
> +int main(void)
> +{
> +	char *tmp_dir;
> +	int fail_counter = 0;
> +
> +	tst_tmpdir();
> +	tmp_dir = get_tst_tmpdir();
> +
> +	if (strcmp(tmp_dir, getcwd(NULL, PATH_MAX)) == 0) {
> +		printf("Temp directory successfully created and switched to\n");
> +	} else {
> +		printf("Temp directory is wrong!\n");
> +		fail_counter++;
> +	}
> +
> +	tst_rmdir();
> +
> +	if (chdir(tmp_dir) == -1) {
> +		printf("The temp directory was removed successfully\n");
> +	} else {
> +		printf("Failed to remove the temp directory!\n");
> +		fail_counter++;
> +	}
> +
> +	if (fail_counter > 0)
> +		printf("Something failed please review!!\n");
> +	else
> +		printf("Test completed successfully!\n");
> +
> +	return 0;
> +}
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 080e09a..aea7f1c 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -140,10 +140,6 @@ void tst_tmpdir(void)
>  		tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
>  			"chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
>  
> -#if UNIT_TEST
> -	printf("TESTDIR = %s\n", TESTDIR);
> -#endif
> -
>  	/*
>  	 * Change to the temporary directory.  If the chdir() fails, issue
>  	 * TBROK messages for all test cases, attempt to remove the
> @@ -162,10 +158,6 @@ void tst_tmpdir(void)
>  		tmpdir_cleanup();
>  	}
>  
> -#if UNIT_TEST
> -	printf("CWD is %s\n", getcwd(NULL, PATH_MAX));
> -#endif
> -
>  }
>  
>  void tst_rmdir(void)
> @@ -222,7 +214,6 @@ void tst_rmdir(void)
>  	if (rmobj(TESTDIR, &errmsg) == -1)
>  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
>  			__func__, TESTDIR, errmsg);
> -
>  }
>  
>  
> @@ -238,44 +229,3 @@ static void tmpdir_cleanup(void)
>  	    "%s: no user cleanup function called before exiting", __func__);
>  }
>  
> -
> -#ifdef UNIT_TEST
> -/****************************************************************************
> - * Unit test code: Takes input from stdin and can make the following
> - *		 calls: tst_tmpdir(), tst_rmdir().
> - ****************************************************************************/
> -extern int  TST_TOTAL;		/* defined/initialized in main() */
> -
> -int  TST_TOTAL = 10;
> -char *TCID = "TESTTCID";
> -
> -main()
> -{
> -	int  option;
> -	char *chrptr;
> -
> -	printf("UNIT TEST of tst_tmpdir.c.  Options to try:\n\
> -		-1 : call tst_exit()\n\
> -		0 : call tst_tmpdir()\n\
> -		1 : call tst_rmdir()\n\n");
> -
> -	while (1) {
> -		printf("Enter options (-1, 0, 1): ");
> -		(void)scanf("%d%c", &option, &chrptr);
> -
> -		switch (option) {
> -		case -1:
> -			tst_exit();
> -			break;
> -
> -		case 0:
> -			tst_tmpdir();
> -			break;
> -
> -		case 1:
> -			tst_rmdir();
> -			break;
> -		}  /* switch() */
> -	}  /* while () */
> -}
> -#endif  /* UNIT_TEST */
> 


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
