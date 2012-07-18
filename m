Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrPNY-0000KI-Ee
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:13:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrPNX-0005MG-Ib
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:13:04 +0000
Message-ID: <50066FE3.4@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 16:12:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<1342194676-15275-3-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1342194676-15275-3-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 3/6] /lib/tst_tmpdir.c removed mkstemp method
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
> Removed the mkstemp method keeping only the mkdtemp since it was added in
> glibc in 2000, therefore it should be available in every linux distro.
> 
> Signed-off-by: Marios Makris <marios.makris@gmail.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  lib/tst_tmpdir.c |   37 -------------------------------------
>  1 file changed, 37 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index fa7628d..b6f4d2e 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -112,10 +112,6 @@ void tst_tmpdir(void)
>  	char template[PATH_MAX];
>  	int  no_cleanup = 0;	/* !0 means TDIRECTORY env var was set */
>  	char *env_tmpdir;	/* temporary storage for TMPDIR env var */
> -	/* This is an AWFUL hack to figure out if mkdtemp() is available */
> -#if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 2)
> -#define HAVE_MKDTEMP
> -#endif
>  
>  	/*
>  	 * If the TDIRECTORY env variable is not set, a temp dir will be
> @@ -150,7 +146,6 @@ void tst_tmpdir(void)
>  			snprintf(template, PATH_MAX, "%s/%.3sXXXXXX",
>  				TEMPDIR, TCID);
>  
> -#ifdef HAVE_MKDTEMP
>  		/* Make the temporary directory in one shot using mkdtemp. */
>  		if (mkdtemp(template) == NULL)
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> @@ -159,38 +154,6 @@ void tst_tmpdir(void)
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
>  				"%s: strdup(%s) failed", __func__, template);
>  		}
> -#else
> -		int tfd;
> -
> -		/* Make the template name, then the directory */
> -		if ((tfd = mkstemp(template)) == -1)
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: mkstemp(%s) failed", __func__, template);
> -		if (close(tfd) == -1) {
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: close() failed", __func__);
> -		}
> -		if (unlink(template) == -1) {
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: unlink(%s) failed", __func__, template);
> -		}
> -		if ((TESTDIR = strdup(template)) == NULL) {
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: strdup(%s) failed", __func__, template);
> -		}
> -		if (mkdir(TESTDIR, DIR_MODE)) {
> -			/*
> -			 * If we start failing with EEXIST, wrap this section in
> -			 * a loop so we can try again.
> -			 *
> -			 * XXX (garrcoop): why? Hacking around broken
> -			 * filesystems should not be done.
> -			 */
> -			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
> -				"%s: mkdir(%s, %#o) failed",
> -					__func__, TESTDIR, DIR_MODE);
> -		}
> -#endif
>  
>  		if (chown(TESTDIR, -1, getgid()) == -1)
>  			tst_brkm(TBROK|TERRNO, tmpdir_cleanup,
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
