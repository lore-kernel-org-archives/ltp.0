Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2K6n-0001nK-Ke
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 14:02:29 +0000
Date: Tue, 9 Jun 2015 16:01:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609140121.GD27378@rei.suse.de>
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
	<5565177B.7080308@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5565177B.7080308@huawei.com>
Subject: Re: [LTP] [PATCH 2/5] iptables/iptables_tests.sh: Add new testcases
 for iptables -c
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

Hi!
> +test07()
> +{
> +	local logcnt=0
> +	tst_resm TINFO "iptables -c test."
> +
> +	iptables -A INPUT -s 127.0.0.1 -j DROP -c 10 500 \
> +		> tst_iptables.out 2>&1
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "iptables command failed to append new rule."
> +		cat tst_iptables.out
> +		return
> +	fi
> +
> +	logcnt=`iptables -L -v |grep localhost |awk '{print $2}'` \
> +		> tst_iptables.out 2>&1

                   grep can do regular expressions as well, why can't we
		   match this with single grep command?

i.e.
	if iptables -L -v |grep -q ".*10.*500.*localhost.*"; then
		PASSED
	else
		FAILED
	fi


> +	if [ $logcnt -ne 500 ]; then
> +		tst_resm TFAIL "iptables -c 10 500 failed."
> +		cat tst_iptables.err
                    ^
		    Where is this file created?

> +		return
> +	fi
> +
> +	logcnt=`iptables -L -v |grep localhost |awk '{print $1}'` \
> +		> tst_iptables.out 2>&1
> +		if [ $logcnt -ne 10 ]; then
> +		tst_resm TFAIL "iptables -c 10 500 failed."
> +		cat tst_iptables.err
> +		return
> +	fi
> +
> +	tst_resm TINFO "Deleting rule."
> +	iptables -D INPUT 1 > tst_iptables.out 2>&1
> +	if [ $? -ne 0 ]; then
> +		tst_resm TFAIL "iptables did not remove the rule."


This should rather be TBROK, but that is minor.

> +		cat tst_iptables.out
> +		return
> +	fi
> +
> +	tst_resm TPASS "iptables -c test succeed."
> +}
> +
>  init
>  TST_CLEANUP=cleanup
> 
> @@ -419,5 +459,6 @@ test03
>  test04
>  test05
>  test06
> +test07
> 
>  tst_exit
> -- 
> 1.6.0.2 .
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
