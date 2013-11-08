Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vebqo-0006mS-F4
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:31:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vebqn-00072q-FI
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 02:31:10 +0000
Message-ID: <527C4CDA.6000202@oracle.com>
Date: Fri, 08 Nov 2013 10:30:50 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-8-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-8-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 7/9] ltp-networking/iptables: "iptables -L -t
 nat" lists 4 chains not 3 chains on Ubuntu 12.04
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
https://github.com/linux-test-project/ltp/commit/792fcce8ae68436c8963c6a51f1f98c66c575494

Thanks
Simon

On 2013/10/30 6:20, Vincent Hsu wrote:
> ---
>   testcases/network/iptables/iptables_tests.sh |   22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
> index 028d54e..641f327 100755
> --- a/testcases/network/iptables/iptables_tests.sh
> +++ b/testcases/network/iptables/iptables_tests.sh
> @@ -165,13 +165,21 @@ test01()
>   		return $RC
>   	else
>   		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
> -		if [ $chaincnt -ne 3 ]; then
> -			tst_res TFAIL $LTPTMP/tst_iptables.out \
> -				"$TCID: $cmd failed to list rules. Reason:"
> -			return $chaincnt
> -		else
> -			tst_resm TINFO "$TCID: $cmd lists rules."
> -		fi
> +            # for debian or ubuntu
> +            if [ -f /etc/debian_version ]; then
> +                if [ $chaincnt -ne 4 ]; then
> +                    tst_res TFAIL $LTPTMP/tst_iptables.out \
> +                        "$TCID: $cmd failed to list rules. Reason:"
> +                        return $chaincnt
> +                fi
> +            else
> +                if [ $chaincnt -ne 3 ]; then
> +                    tst_res TFAIL $LTPTMP/tst_iptables.out \
> +                        "$TCID: $cmd failed to list rules. Reason:"
> +                        return $chaincnt
> +                fi
> +            fi
> +            tst_resm TINFO "$TCID: $cmd lists rules."
>   	fi
>
>   	local cmd="iptables -L -t mangle"
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
