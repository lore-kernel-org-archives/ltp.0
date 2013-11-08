Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VebsO-00086Q-5f
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:32:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VebsN-00035x-64
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:32:48 +0000
Message-ID: <527C4D3D.4090200@oracle.com>
Date: Fri, 08 Nov 2013 10:32:29 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-6-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-6-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 5/9] ltp-networking/tcp_cmds/tcpdump: 1.
 RHOST IP won't appear in network interfaces. It should be LHOST. 2. Host
 commad can't fetch IP in no DNS enviroment. use ping intead of it
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
To: Vincent Hsu <vincent.hsu@linaro.org>, ltp-list@lists.sourceforge.net
Cc: linaro-networking@linaro.org

Hi,

Please see 
https://github.com/linux-test-project/ltp/commit/87f593c16f80c3f204c87de276c426aeb65c3527

Thanks
Simon

On 2013/10/30 6:20, Vincent Hsu wrote:
> ---
>   testcases/network/tcp_cmds/tcpdump/tcpdump01 |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> index 4866720..6d99398 100755
> --- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
> +++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> @@ -47,8 +47,8 @@ do_setup()
>       tst_setup
>
>       exists awk grep host hostname ifconfig netstat ping tail tcpdump
> -    RHOST=${RHOST:-`hostname`}
> -    IP=`host ${RHOST} 2>/dev/null | awk '{print $4}'`
> +    LHOST=${LHOST:-`hostname`}
> +    IP=`ping ${LHOST} -c 1 | awk '{print $3}' | head -n1 | cut -f2 -d'(' | cut -f1 -d')'`
>       IFNUMS=`netstat -i|wc -l`
>       IFNUMS=$(( $IFNUMS - 2 ))
>       IFNAME=${IFNAME:-$(netstat -i | awk '{print $1}' | tail -n ${IFNUMS})}
> --
> 1.7.9.5
>
>
> ------------------------------------------------------------------------------
> Android is increasing in popularity, but the open development platform that
> developers love is also attractive to malware creators. Download this white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
