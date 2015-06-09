Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2Jkz-0004PZ-GD
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 13:39:57 +0000
Date: Tue, 9 Jun 2015 15:38:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609133853.GC27378@rei.suse.de>
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH 1/5] iptables/iptables_tests.sh: Add test cases
 for iptables -L
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

> +	local cmd="iptables -L -t raw"
> +	tst_resm TINFO "$cmd will list all rules in table raw."
> +	$cmd > tst_iptables.out 2>&1

Why do we do this indirectly via the cmd variable?

> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "$cmd failed to list rules."
> +		cat tst_iptables.out
> +		return
> +	else

You do return before the else so there is no need for the else branch.

> +		chaincnt=$(grep -c Chain tst_iptables.out)
> +		if [ $chaincnt -lt 2 ]; then
> +			tst_resm TFAIL "$cmd failed to list rules."
> +			cat tst_iptables.out
> +		else
> +			tst_resm TINFO "$cmd lists rules."

It would be better to print PASS here.

> +		fi
> +	fi
> +
> +	local cmd="iptables -L -t security"
> +	tst_resm TINFO "$cmd will list all rules in table security."
> +	$cmd > tst_iptables.out 2>&1
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "$cmd failed to list rules."
> +		cat tst_iptables.out
> +		return
> +	else
> +		chaincnt=$(grep -c Chain tst_iptables.out)
> +		if [ $chaincnt -lt 3 ]; then
> +			tst_resm TFAIL "$cmd failed to list rules."
> +			cat tst_iptables.out
> +		else
> +			tst_resm TINFO "$cmd lists rules."

And to print PASS here.

> +		fi
> +	fi
> +
>  	tst_resm TPASS "iptables -L lists rules."

And remove this line.

>  }
>  
> -- 
> 1.6.0.2
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
