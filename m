Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XEyKU-0000zy-Qs
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 10:20:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XEyKT-0003Is-S0
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 10:20:22 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s76AKC2u032264
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Aug 2014 18:20:12 +0800
Message-ID: <1407320367.2223.16.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 6 Aug 2014 18:19:27 +0800
In-Reply-To: <1404116297.3148.7.camel@G08JYZSD130126>
References: <1404116297.3148.7.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] waitid/waitid02.c: Add new ECHILD errno test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Ping. :)

Best regards,
Zeng
On Mon, 2014-06-30 at 16:18 +0800, Zeng Linggang wrote:
> * Add new ECHILD errno test for waitid(2)
> 	idtype and id (waitid()) is not a child of the calling process.
> 
> * Cleanup: remove an useless tst_exit()
> 
> * Add tst_count = 0
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/waitid/waitid02.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
> index 3806655..6259fa3 100644
> --- a/testcases/kernel/syscalls/waitid/waitid02.c
> +++ b/testcases/kernel/syscalls/waitid/waitid02.c
> @@ -130,6 +130,16 @@ struct testcase_t tdat[] = {
>  		.setup = setup6,
>  		.cleanup = cleanup6
>  	},
> +	{
> +		.msg = "P_PID, WEXITED not a child of the calling process",
> +		.idtype = P_PID,
> +		.id = 1,
> +		.options = WEXITED,
> +		.exp_ret = -1,
> +		.exp_errno = ECHILD,
> +		.setup = setup2,
> +		.cleanup = cleanup2
> +	},
>  
>  };
>  
> @@ -281,13 +291,12 @@ int main(int ac, char **av)
>  	const char *msg;
>  
>  	msg = parse_opts(ac, av, NULL, NULL);
> -	if (msg != NULL) {
> +	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
>  
>  	setup();
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; testno++)
>  			test_waitid(&tdat[testno]);
>  	}



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
