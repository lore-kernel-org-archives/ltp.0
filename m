Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrPVQ-0006rw-7V
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:21:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrPVI-0005iM-Sm
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:21:12 +0000
Message-ID: <500671C4.5020609@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 16:20:20 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 1/6] /lib/tst_tmpdir indentation and coding style
 fixes
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

On 07/13/2012 11:51 PM, Marios Makris wrote:
> Identation and coding style fixes as well as moved the function descriptions
> to the header file (/include/test.h)
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>
> ---
>  include/test.h   |   26 +++++++++++++++
>  lib/tst_tmpdir.c |   97 ++++++++++++++++++------------------------------------
>  2 files changed, 58 insertions(+), 65 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index 033fdbc..934585e 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -201,8 +201,34 @@ extern int Tst_count;
>  void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
>  
>  /* lib/tst_tmpdir.c */
> +
> +/* tst_tmpdir()
> + *
> + * Create a unique temporary directory and chdir() to it. It expects the caller

It's better to keep the comments lines within 73 characters.

Thanks,
Wanlong Gao

> + * to have defined/initialized the TCID/TST_TOTAL global variables.
> + * The TESTDIR global variable will be set to the directory that gets used
> + * as the testing directory.
> + *
> + * NOTE: This function must be called BEFORE any activity that would require
> + * CLEANUP.  If tst_tmpdir() fails, it cleans up afer itself and calls
> + * tst_exit() (i.e. does not return).
> + */
>  void tst_tmpdir(void);
> +/* tst_rmdir()
> + *
> + * Recursively remove the temporary directory created by tst_tmpdir().
> + * This function is intended ONLY as a companion to tst_tmpdir().
> + * If the TDIRECTORY environment variable is set, no cleanup will be
> + * attempted.
> + */
>  void tst_rmdir(void);
> +/* get_tst_tmpdir()
> + *
> + * Return a copy of the test temp directory as seen by LTP. This is for
> + * path-oriented tests like chroot, etc, that may munge the path a bit.
> + *
> + * FREE VARIABLE AFTER USE IF IT IS REUSED!
> + */
>  char *get_tst_tmpdir(void);
>  
>  /* lib/get_high_address.c */
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index d112e3e..fa7628d 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -1,4 +1,4 @@
> -/*
> +/**********************************************************
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
> @@ -28,9 +28,7 @@
>   * For further information regarding this notice, see:
>   *
>   * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - */
> -
> -/* $Id: tst_tmpdir.c,v 1.14 2009/07/20 10:59:32 vapier Exp $ */
> + *********************************************************/
>  
>  /**********************************************************
>   *
> @@ -62,7 +60,8 @@
>   *	 RETURN VALUE
>   *		Neither tst_tmpdir() or tst_rmdir() has a return value.
>   *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> + *********************************************************/
> +
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <assert.h>
> @@ -72,6 +71,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +
>  #include "test.h"
>  #include "rmobj.h"
>  
> @@ -99,14 +99,7 @@ static void tmpdir_cleanup(void);
>  extern char *TCID;		/* defined/initialized in main() */
>  static char *TESTDIR = NULL;	/* the directory created */
>  
> -/*
> - * Return a copy of the test temp directory as seen by LTP. This is for
> - * path-oriented tests like chroot, etc, that may munge the path a bit.
> - *
> - * FREE VARIABLE AFTER USE IF IT IS REUSED!
> - */
> -char *
> -get_tst_tmpdir(void)
> +char *get_tst_tmpdir(void)
>  {
>  	/* Smack the user for calling things out of order. */
>  	if (TESTDIR == NULL)
> @@ -114,25 +107,13 @@ get_tst_tmpdir(void)
>  	return strdup(TESTDIR);
>  }
>  
> -/*
> - * tst_tmpdir() - Create a unique temporary directory and chdir() to it.
> - *		It expects the caller to have defined/initialized the
> - *		TCID/TST_TOTAL global variables.  The TESTDIR global
> - *		variable will be set to the directory that gets used
> - *		as the testing directory.
> - *
> - *		NOTE: This function must be called BEFORE any activity
> - *		that would require CLEANUP.  If tst_tmpdir() fails, it
> - *		cleans up afer itself and calls tst_exit() (i.e. does
> - *		not return).
> - */
>  void tst_tmpdir(void)
>  {
>  	char template[PATH_MAX];
>  	int  no_cleanup = 0;	/* !0 means TDIRECTORY env var was set */
>  	char *env_tmpdir;	/* temporary storage for TMPDIR env var */
>  	/* This is an AWFUL hack to figure out if mkdtemp() is available */
> -#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2,2)
> +#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 2)
>  #define HAVE_MKDTEMP
>  #endif
>  
> @@ -146,7 +127,7 @@ void tst_tmpdir(void)
>  		 */
>  		if (mkdir(TESTDIR, DIR_MODE) == -1 && errno != EEXIST) {
>  			tst_brkm(TBROK, NULL, "mkdir(%s, %o) failed",
> -			    TESTDIR, DIR_MODE);
> +				TESTDIR, DIR_MODE);
>  		}
>  		/*
>  		 * Try to create the directory if it does not exist already;
> @@ -162,11 +143,12 @@ void tst_tmpdir(void)
>  		 * environment variable TMPDIR if it is available, otherwise
>  		 * use our default TEMPDIR.
>  		 */
> -		if ((env_tmpdir = getenv("TMPDIR"))) {
> -			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", env_tmpdir, TCID);
> -		} else {
> -			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX", TEMPDIR, TCID);
> -		}
> +		if ((env_tmpdir = getenv("TMPDIR")))
> +			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> +				env_tmpdir, TCID);
> +		else
> +			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> +				TEMPDIR, TCID);
>  
>  #ifdef HAVE_MKDTEMP
>  		/* Make the temporary directory in one shot using mkdtemp. */
> @@ -205,37 +187,37 @@ void tst_tmpdir(void)
>  			 * filesystems should not be done.
>  			 */
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -			    "%s: mkdir(%s, %#o) failed",
> -			    __func__, TESTDIR, DIR_MODE);
> +				"%s: mkdir(%s, %#o) failed",
> +					__func__, TESTDIR, DIR_MODE);
>  		}
>  #endif
>  
>  		if (chown(TESTDIR, -1, getgid()) == -1)
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -			    "chown(%s, -1, %d) failed", TESTDIR, getgid());
> +				"chown(%s, -1, %d) failed", TESTDIR, getgid());
>  		if (chmod(TESTDIR, DIR_MODE) == -1)
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
>  				"chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
> - 	}
> +	}
>  
>  #if UNIT_TEST
>  	printf("TESTDIR = %s\n", TESTDIR);
>  #endif
>  
> - 	/*
> -  	 * Change to the temporary directory.  If the chdir() fails, issue
> +	/*
> +	 * Change to the temporary directory.  If the chdir() fails, issue
>  	 * TBROK messages for all test cases, attempt to remove the
>  	 * directory (if it was created), and exit.  If the removal also
>  	 * fails, also issue a TWARN message.
>  	 */
>  	if (chdir(TESTDIR) == -1) {
>  		tst_brkm(TBROK|TERRNO, NULL, "%s: chdir(%s) failed",
> -		    __func__, TESTDIR);
> +			__func__, TESTDIR);
>  
>  		/* Try to remove the directory */
>  		if (!no_cleanup && rmdir(TESTDIR) == -1) {
>  			tst_resm(TWARN|TERRNO, "%s: rmdir(%s) failed",
> -			    __func__, TESTDIR);
> +				__func__, TESTDIR);
>  		}
>  
>  		tmpdir_cleanup();
> @@ -245,17 +227,8 @@ void tst_tmpdir(void)
>  	printf("CWD is %s\n", getcwd(NULL, PATH_MAX));
>  #endif
>  
> -}  /* tst_tmpdir() */
> -
> +}
>  
> -/*
> - *
> - * tst_rmdir() - Recursively remove the temporary directory created by
> - *			 tst_tmpdir().  This function is intended ONLY as a
> - *			 companion to tst_tmpdir().  If the TDIRECTORY
> - *			 environment variable is set, no cleanup will be
> - *			 attempted.
> - */
>  void tst_rmdir(void)
>  {
>  	struct stat buf1;
> @@ -282,31 +255,26 @@ void tst_rmdir(void)
>  	 */
>  	if (TESTDIR == NULL) {
>  		tst_resm(TWARN,
> -		    "%s: TESTDIR was NULL; no removal attempted", __func__);
> +			"%s: TESTDIR was NULL; no removal attempted", __func__);
>  		return;
>  	}
>  
>  	if ((parent_dir = malloc(PATH_MAX)) == NULL) {
>  		/* Make sure that we exit quickly and noisily. */
>  		tst_brkm(TBROK|TERRNO, NULL,
> -		    "%s: malloc(%d) failed", __func__, PATH_MAX);
> +			"%s: malloc(%d) failed", __func__, PATH_MAX);
>  	}
>  
>  	/*
>  	 * Check that the value of TESTDIR is not "*" or "/".  These could
>  	 * have disastrous effects in a test run by root.
>  	 */
> -	/* XXX: a temp directory that's '/' seems stupid and dangerous anyways. */
>  	if (stat(TESTDIR, &buf1) == 0 && stat("/", &buf2) == 0 &&
> -	    buf1.st_ino == buf2.st_ino) {
> +		buf1.st_ino == buf2.st_ino) {
>  		tst_resm(TWARN, "%s: will not remove /", __func__);
>  		return;
>  	}
>  
> -	/*
> -	 * XXX: this just reeks of bad programming; all shell characters should
> -	 * be escaped in invocations of rm(1)/rmdir(1).
> -	 */
>  	if (strchr(TESTDIR, '*') != NULL) {
>  		tst_resm(TWARN, "%s: will not remove *", __func__);
>  		return;
> @@ -324,6 +292,7 @@ void tst_rmdir(void)
>  	} else {
>  		strcpy(parent_dir, TESTDIR);
>  	}
> +
>  	if ((parent_dir = dirname(parent_dir)) == NULL) {
>  		tst_resm(TWARN|TERRNO, "%s: dirname failed", __func__);
>  		return;
> @@ -334,9 +303,8 @@ void tst_rmdir(void)
>  	 */
>  	if (chdir(parent_dir) != 0) {
>  		tst_resm(TWARN|TERRNO,
> -			 "%s: chdir(%s) failed\nAttempting to remove temp dir "
> -			 "anyway",
> -			 __func__, parent_dir);
> +			"%s: chdir(%s) failed\nAttempting to remove temp dir "
> +				"anyway", __func__, parent_dir);
>  	}
>  
>  	/*
> @@ -344,9 +312,9 @@ void tst_rmdir(void)
>  	 */
>  	if (rmobj(TESTDIR, &errmsg) == -1)
>  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> -			 __func__, TESTDIR, errmsg);
> +			__func__, TESTDIR, errmsg);
>  
> -}  /* tst_rmdir() */
> +}
>  
>  
>  /*
> @@ -355,8 +323,7 @@ void tst_rmdir(void)
>   *			  It prints a warning message via tst_resm(), and
>   *			  then calls tst_exit().
>   */
> -static void
> -tmpdir_cleanup(void)
> +static void tmpdir_cleanup(void)
>  {
>  	tst_brkm(TWARN, NULL,
>  	    "%s: no user cleanup function called before exiting", __func__);
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
