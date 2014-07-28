Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XBlKV-0000TR-Q7
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 13:51:07 +0000
Date: Mon, 28 Jul 2014 15:50:18 +0200
From: chrubis@suse.cz
Message-ID: <20140728135017.GA12993@rei.suse.cz>
References: <53CF585E.5010602@cn.fujitsu.com>
	<1406098189-26377-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406098189-26377-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_tmpdir.c: fix bug when TESTDIR is not a
 absolute pathname
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> ---
>  lib/tst_tmpdir.c | 42 ++++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 600d178..cd4b39a 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -148,8 +148,8 @@ void tst_tmpdir(void)
>  			 "chmod(%s, %#o) failed", TESTDIR, DIR_MODE);
>  
>  	if (getcwd(test_start_work_dir, sizeof(test_start_work_dir)) == NULL) {
> -		tst_resm(TINFO, "Failed to record test working dir");
> -		test_start_work_dir[0] = '\0';
> +		tst_brkm(TBROK | TERRNO, tmpdir_cleanup,
> +			 "Failed to record test working dir");
>  	}
>  
>  	/*
> @@ -173,7 +173,6 @@ void tst_tmpdir(void)
>  
>  void tst_rmdir(void)
>  {
> -	char current_dir[PATH_MAX];
>  	char *errmsg;
>  	char *parent_dir;
>  
> @@ -198,26 +197,29 @@ void tst_rmdir(void)
>  	 * get full path.
>  	 */
>  	if (TESTDIR[0] != '/') {
> -		if (getcwd(current_dir, PATH_MAX) == NULL)
> -			strncpy(parent_dir, TESTDIR, PATH_MAX);
> -		else
> -			sprintf(parent_dir, "%s/%s", current_dir, TESTDIR);
> +		if (chdir(test_start_work_dir) != 0) {
> +			tst_resm(TWARN | TERRNO, "%s: chdir(%s) failed\n"
> +				 "Attempting to remove temp dir anyway",
> +				 __func__, test_start_work_dir);
> +		}
>  	} else {
>  		strcpy(parent_dir, TESTDIR);
> -	}
>  
> -	if ((parent_dir = dirname(parent_dir)) == NULL) {
> -		tst_resm(TWARN | TERRNO, "%s: dirname failed", __func__);
> -		return;
> -	}
> -
> -	/*
> -	 * Change directory to parent_dir (The dir above TESTDIR).
> -	 */
> -	if (chdir(parent_dir) != 0) {
> -		tst_resm(TWARN | TERRNO,
> -			 "%s: chdir(%s) failed\nAttempting to remove temp dir "
> -			 "anyway", __func__, parent_dir);
> +		parent_dir = dirname(parent_dir);
> +		if (parent_dir == NULL) {
> +			tst_resm(TWARN | TERRNO,
> +				 "%s: dirname failed", __func__);
> +			return;
> +		}
> +
> +		/*
> +		 * Change directory to parent_dir (The dir above TESTDIR).
> +		 */
> +		if (chdir(parent_dir) != 0) {
> +			tst_resm(TWARN | TERRNO, "%s: chdir(%s) failed\n"
> +				 "Attempting to remove temp dir anyway",
> +				 __func__, parent_dir);
> +		}
>  	}

Good catch.

Can't we just do chdir(test_start_work_dir) in both cases and then the
rmobj(TESTDIR, &errmsg)? That would really simplify the code for
tst_rmdir().

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
