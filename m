Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VePge-00054U-4v
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 13:31:52 +0000
Date: Thu, 7 Nov 2013 14:31:36 +0100
From: chrubis@suse.cz
Message-ID: <20131107133136.GG28961@rei.suse.cz>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-8-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> ---
>  testcases/network/iptables/iptables_tests.sh |   22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
> index 028d54e..641f327 100755
> --- a/testcases/network/iptables/iptables_tests.sh
> +++ b/testcases/network/iptables/iptables_tests.sh
> @@ -165,13 +165,21 @@ test01()
>  		return $RC
>  	else
>  		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
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
>  	fi

It has four Chain lines on basically every new enough Linux. So let's
accept either 3 or 4 in the general case.

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
