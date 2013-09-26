Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VP9RA-00082w-9P
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 11:08:48 +0000
Date: Thu, 26 Sep 2013 13:09:06 +0200
From: chrubis@suse.cz
Message-ID: <20130926110906.GA14003@rei.suse.cz>
References: <5244016A.4060300@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5244016A.4060300@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] setuid/setuid04.c: Fix a double cleanup() error
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
To: MaShimiao <mashimiao.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, zenglg.jy@cn.fujitsu.com

Hi!
> The cleanup() may be called twice by both the parent and child process
> in this testcase leading to a failure.
> 
> This patch makes sure cleanup() is called only once by parent process.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/setuid/setuid04.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setuid/setuid04.c
> b/testcases/kernel/syscalls/setuid/setuid04.c
> index d8e991e..365859b 100644
> --- a/testcases/kernel/syscalls/setuid/setuid04.c
> +++ b/testcases/kernel/syscalls/setuid/setuid04.c
> @@ -88,7 +88,7 @@ static void do_master_child(void)
>   	int pid;
>   	int status;
> 
> -	if (SETUID(cleanup, ltpuser->pw_uid) == -1) {
> +	if (SETUID(NULL, ltpuser->pw_uid) == -1) {
>   		tst_brkm(TBROK, NULL,
>   			 "setuid failed to set the effective uid to %d",
>   			 ltpuser->pw_uid);

This one is much better. Applied, thanks.

(The patch failed to apply and needed to be redone by hand.)

BTW: It would be better to remove all the tst_* interface from the
     function that runs in the child and use printf() + exit() instead.
     (In order to avoid bugs like this one)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
