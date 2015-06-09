Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2KMl-0004Lm-MN
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 14:18:59 +0000
Date: Tue, 9 Jun 2015 16:17:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609141752.GF27378@rei.suse.de>
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
> +	iptables -A OUTPUT -o lo -p icmp -j DROP > tst_iptables.out 2>&1
> +        if [ $? -ne 0 ]; then
> +                tst_resm TFAIL "iptables command failed to append new rule."
> +                cat tst_iptables.out
> +                return
> +        fi

Also the indentation is inconsitent, it mixes tabs and spaces. Choose
one and use them exclusively, if there were spaces in the original file
use spaces if there were tabs use tabs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
