Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlIjz-0005i0-Ql
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 13:31:47 +0000
Date: Tue, 26 Nov 2013 14:31:18 +0100
From: chrubis@suse.cz
Message-ID: <20131126133118.GA13496@rei>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
	<1384400319-30776-8-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384400319-30776-8-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 8/8] ltp-networking/iproute: fix iproute test
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> ip02: set original mtu size back. this test will set mtu to 300.
> ip05: if there is not only one route, using "head" command will get
>       wrong result.
> 
> Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
> ---
>  testcases/network/iproute/ip_tests.sh |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index ce4cabc..e16f6c4 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -187,6 +187,7 @@ test01()
> 
>  	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."
> 
> +	MTUSZ_BAK=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
>  	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
>  	if [ $RC -ne 0 ]
>  	then
> @@ -198,6 +199,7 @@ test01()
>  		if [ $MTUSZ -eq 300 ]
>  		then
>  			tst_resm TPASS "Test #1: changing mtu size success"
> +			ip link set eth0:1 mtu $MTUSZ_BAK >$LTPTMP/tst_ip.err 2>&1
>  		else
>  			tst_resm FAIL NULL \
>  				"Test #1: MTU value not set to 300: ifconfig returned: $MTUSZ"
> @@ -453,7 +455,8 @@ test05()
>  		10.6.6.6 via 127.0.0.1 dev lo
>  		EOF
> 
> -		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +		ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" \
> +		>$LTPTMP/tst_ip.out 2>&1 || RC=$?
>  		if [ $RC -ne 0 ]
>  		then
>  			tst_res TFAIL $LTPTMP/tst_ip.err \

Can you please fix the two over 80 chars lines that your patch adds?

Otherwise this is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
