Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2KIO-0002Mu-9R
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 14:14:28 +0000
Date: Tue, 9 Jun 2015 16:13:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609141319.GE27378@rei.suse.de>
References: <1432688360-179350-1-git-send-email-cuibixuan@huawei.com>
	<556517AC.7060406@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <556517AC.7060406@huawei.com>
Subject: Re: [LTP] [PATCH 3/5] iptables/iptables_tests.sh: Add new testcases
 for iptables -o
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
> +        tst_resm TINFO "Pinging 127.0.0.1"
> +        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1

Why -c 2 ?

> +        if [ $? -ne 0 ]; then
> +                grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1

Eh, if ping failed, non-zero is returned, no need to grep the ping
output as well.

> +                if [ $? -ne 0 ]; then
> +                        tst_resm TFAIL \
> +                                 "iptables did not block packets from loopback"
> +                        cat tst_iptables.err
> +                        return
> +                else
> +                        tst_resm TINFO "Ping 127.0.0.1 not successful."
> +                fi
> +        else
> +                tst_resm TFAIL "iptables did not block icmp from 127.0.0.1"
> +                cat tst_iptables.out
> +                return
> +        fi
> +
> +        tst_resm TINFO "Deleting icmp DROP from lo rule."
> +        iptables -D OUTPUT 1 > tst_iptables.out 2>&1
> +        if [ $? -ne 0 ]; then
> +                tst_resm TFAIL "iptables did not remove the rule."

Again TBROK rather than TFAIL

> +                cat tst_iptables.out
> +                return
> +        fi
> +        tst_resm TINFO "Pinging 127.0.0.1 again"
> +        ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
> +        if [ $? -ne 0 ]; then
> +                tst_resm TFAIL "iptables blocking loopback. This is expected" \
> +                               "behaviour on certain distributions where" \
> +                               "enabling firewall drops all packets by default."
> +                cat tst_iptables.out
> +                return
> +        fi

We should save and reset the iptables before the testcase and restore it
after it. Otherwise we will not get consistent results. Also the test
for working ping should be at the start of the testcase and we should
skip it with TCONF if we cannot reach localhost.


before testcase:

iptables-save > saved_iptables
iptables -F

after testcase:

iptables-restore < saved_iptables


> +        tst_resm TINFO "Ping succsess"
> +        tst_resm TPASS "iptables can DROP packets from particular network card."
> +}
> +
>  init
>  TST_CLEANUP=cleanup
> 
> @@ -460,5 +511,6 @@ test04
>  test05
>  test06
>  test07
> +test08
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
