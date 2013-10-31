Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VbuVG-0002IZ-QF
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 15:49:46 +0000
Date: Thu, 31 Oct 2013 16:49:25 +0100
From: chrubis@suse.cz
Message-ID: <20131031154925.GC20620@rei.Home>
References: <527210BF.3040803@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527210BF.3040803@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] clock_getres/clock_getres01.c: Add
 CLOCK_MONOTONIC_RAW test
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
> Add CLOCK_MONOTONIC_RAW test in clock_getres01.c for clock_getres(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/clock_getres/clock_getres01.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> index 0fb5df4..c73b0ce 100644
> --- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> +++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
> @@ -188,6 +188,12 @@ static struct test_case tcase[] = {
>  	 .ret = 0,
>  	 .err = 0,
>  	 },
> +	{
> +	 .clk_id = CLOCK_MONOTONIC_RAW,
> +	 .ttype = NORMAL,
> +	 .ret = 0,
> +	 .err = 0,
> +	 },
>  };

This will fail the testcase on systems where CLOCK_MONOTONIC_RAW is not
implemented (older than 2.6.28). The kernel will return EINVAL in this
case because the clock id is not known.

Also the testcase is messy and not ported to the LTP API. Can you please
fix that? (in separate patch)


And when you are at it there more timers to add (CLOCK_REALTIME_COARSE,
CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME) see latest man page for
clock_getres.

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
