Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeSTW-0007a7-2G
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 16:30:30 +0000
Date: Thu, 7 Nov 2013 17:30:21 +0100
From: chrubis@suse.cz
Message-ID: <20131107163021.GE9653@rei.Home>
References: <1383789115-553-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383789115-553-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] mc_cmds: Multicast ping being disabled should not
 fail the test
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testcases/network/multicast/mc_cmds/mc_cmds | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
> index e9b7bb5..47bd4b9 100755
> --- a/testcases/network/multicast/mc_cmds/mc_cmds
> +++ b/testcases/network/multicast/mc_cmds/mc_cmds
> @@ -127,7 +127,8 @@ for eth in $IFNAME
>     cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null
>     if [ $? -eq 0 ]
>     then
> -       end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
> +       tst_resm TINFO "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
> +       exit 0

This should be TCONF.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
