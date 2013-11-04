Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VdKf2-00084U-Vg
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 13:57:45 +0000
Date: Mon, 4 Nov 2013 14:57:21 +0100
From: chrubis@suse.cz
Message-ID: <20131104135721.GB8505@rei>
References: <028e01ced946$bdc140a0$3943c1e0$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <028e01ced946$bdc140a0$3943c1e0$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH] acct01: fix cleanup function
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
To: Honggyu Kim <hong.gyu.kim@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Currently, additional test for acct is done in cleanup.
> This was not originally intended because TCONF case will also invoke cleanup
> function to finish and it will finally goes to TBROK, not TCONF.
> This patch removes the additional acct execution in cleanup.
> 
> Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index 0fe973b..53376ae 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -165,8 +165,5 @@ static void cleanup(void)
>  {
>  	TEST_CLEANUP;
>  
> -	if (acct(NULL) == -1)
> -		tst_resm(TBROK | TERRNO, "acct(NULL) failed");
> -
>  	tst_rmdir();
>  }

This does not seem to be right. The acct(NULL) should turn off the
process accounting so this is not a test for acct() but rather an
attempt to restore the system to the previous state.

So the correct solution would be to call acct(NULL) first in the setup
and if that failed with ENOSYS, exit the test with TCONF without calling
the cleanup (if we do this check before the tst_tmpdir() we don't have
to do any cleanup). Then we can also remove all checks for ENOSYS from
the rest of the code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
