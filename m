Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrQkg-0003nj-4I
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:41:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrQke-0004Rt-MX
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 09:41:02 +0000
Message-ID: <50068480.1060602@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 17:40:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<1342194676-15275-5-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1342194676-15275-5-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 5/6] /lib/tst_tmpdir.c removed the TDIRECTORY part
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
> After recent question to the list, it seems that the TDIRECTORY PART is not
> used by anyone, therefore it is removed.

OK, we can also use "-d TMPDIR" option, so no objection with removing this.
 
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Thanks,
Wanlong Gao

> ---
>  lib/tst_tmpdir.c |   93 ++++++++++++++++--------------------------------------
>  1 file changed, 28 insertions(+), 65 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index a9dd78c..080e09a 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -110,58 +110,35 @@ char *get_tst_tmpdir(void)
>  void tst_tmpdir(void)
>  {
>  	char template[PATH_MAX];
> -	int  no_cleanup = 0;	/* !0 means TDIRECTORY env var was set */
>  	char *env_tmpdir;	/* temporary storage for TMPDIR env var */
> +	char *errmsg;
>  
>  	/*
> -	 * If the TDIRECTORY env variable is not set, a temp dir will be
> -	 * created.
> +	 * Create a template for the temporary directory.  Use the
> +	 * environment variable TMPDIR if it is available, otherwise
> +	 * use our default TEMPDIR.
>  	 */
> -	if ((TESTDIR = getenv(TDIRECTORY)) != NULL) {
> -		/*
> -		 * The TDIRECTORY env. variable is set, so no temp dir is created.
> -		 */
> -		if (mkdir(TESTDIR, DIR_MODE) == -1 && errno != EEXIST) {
> -			tst_brkm(TBROK, NULL, "mkdir(%s, %o) failed",
> -				TESTDIR, DIR_MODE);
> -		}
> -		/*
> -		 * Try to create the directory if it does not exist already;
> -		 * user might forget to create one before exporting TDIRECTORY.
> -		 */
> -		no_cleanup++;
> -#if UNIT_TEST
> -		printf("TDIRECTORY env var is set\n");
> -#endif
> -	} else {
> -		/*
> -		 * Create a template for the temporary directory.  Use the
> -		 * environment variable TMPDIR if it is available, otherwise
> -		 * use our default TEMPDIR.
> -		 */
> -		if ((env_tmpdir = getenv("TMPDIR")))
> -			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> -				env_tmpdir, TCID);
> -		else
> -			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> -				TEMPDIR, TCID);
> -
> -		/* Make the temporary directory in one shot using mkdtemp. */
> -		if (mkdtemp(template) == NULL)
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: mkdtemp(%s) failed", __func__, template);
> -		if ((TESTDIR = strdup(template)) == NULL) {
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: strdup(%s) failed", __func__, template);
> -		}
> -
> -		if (chown(TESTDIR, -1, getgid()) == -1)
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"chown(%s, -1, %d) failed", TESTDIR, getgid());
> -		if (chmod(TESTDIR, DIR_MODE) == -1)
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
> -	}
> +	if ((env_tmpdir = getenv("TMPDIR")))
> +		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> +			env_tmpdir, TCID);
> +	else
> +		snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
> +			TEMPDIR, TCID);
> +
> +	/* Make the temporary directory in one shot using mkdtemp. */
> +	if (mkdtemp(template) == NULL)
> +		tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> +			"%s: mkdtemp(%s) failed", __func__, template);
> +	if ((TESTDIR = strdup(template)) == NULL)
> +		tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> +			"%s: strdup(%s) failed", __func__, template);
> +
> +	if (chown(TESTDIR, -1, getgid()) == -1)
> +		tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> +			"chown(%s, -1, %d) failed", TESTDIR, getgid());
> +	if (chmod(TESTDIR, DIR_MODE) == -1)
> +		tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> +			"chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
>  
>  #if UNIT_TEST
>  	printf("TESTDIR = %s\n", TESTDIR);
> @@ -178,10 +155,9 @@ void tst_tmpdir(void)
>  			__func__, TESTDIR);
>  
>  		/* Try to remove the directory */
> -		if (!no_cleanup && rmdir(TESTDIR) == -1) {
> -			tst_resm(TWARN|TERRNO, "%s: rmdir(%s) failed",
> -				__func__, TESTDIR);
> -		}
> +		if (rmobj(TESTDIR, &errmsg) == -1)
> +			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> +			__func__, TESTDIR, errmsg);
>  
>  		tmpdir_cleanup();
>  	}
> @@ -197,19 +173,6 @@ void tst_rmdir(void)
>  	char current_dir[PATH_MAX];
>  	char *errmsg;
>  	char *parent_dir;
> -	char *tdirectory;
> -
> -	/*
> -	 * If the TDIRECTORY env variable is set, this indicates that no
> -	 * temp dir was created by tst_tmpdir().  Thus no cleanup will be
> -	 * necessary.
> -	 */
> -	if ((tdirectory = getenv(TDIRECTORY)) != NULL) {
> -#if UNIT_TEST
> -		printf("\"TDIRECORY\" env variable is set; no cleanup was performed\n");
> -#endif
> -		return;
> -	}
>  
>  	/*
>  	 * Check that TESTDIR is not NULL.
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
