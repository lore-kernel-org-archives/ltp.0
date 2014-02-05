Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WB1o8-0007E8-4W
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 12:42:24 +0000
Date: Wed, 5 Feb 2014 13:41:52 +0100
From: chrubis@suse.cz
Message-ID: <20140205124152.GA25594@rei.suse.cz>
References: <1386935787.1665.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386935787.1665.2.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] getpeername/getpeername01.c: add EINVAL error
 number test
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Add EINVAL error number test.
> 
> Signed-off-by: Zuo Faqi <zuofq.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/getpeername/getpeername01.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
> index 7aa72cb..7ed90f2 100644
> --- a/testcases/kernel/syscalls/getpeername/getpeername01.c
> +++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
> @@ -39,6 +39,7 @@
>  static struct sockaddr_in server_addr;
>  static struct sockaddr_in fsin1;
>  static socklen_t sinlen;
> +static socklen_t invalid_sinlen;
>  static int sv[2];
>  
>  static void setup(void);
> @@ -72,12 +73,14 @@ struct test_case_t {
>  	 cleanup4, "EFAULT"},
>  	{-1, (struct sockaddr *)&fsin1, (socklen_t *)1, -1, EFAULT, setup4,
>  	 cleanup4, "EFAULT"},
> +	{-1, (struct sockaddr *)&fsin1, &invalid_sinlen, -1, EINVAL, setup4,
> +	 cleanup4, "EINVAL"},
>  #endif
>  };

I've moved the new test before the UCLINUX ifdef because the test should
work on uClinux.

Pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
