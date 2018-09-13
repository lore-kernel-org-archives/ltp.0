From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Sep 2018 14:35:01 +0200
Subject: [LTP] [PATCH v2 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
 parameter
In-Reply-To: <1534764229-26993-2-git-send-email-alexey.kodanev@oracle.com>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
 <1534764229-26993-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180913123501.GC18036@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +tst_test_drivers()
> +{
> +	[ $# -eq 0 ] && return 0
> +
> +	local drv="$(tst_check_drivers $@ 2>&1)"

Wouldn't it be easier to just redirect the stderr into /dev/null here
and check the $? instead of [ -n "$drv" ] ?

-- 
Cyril Hrubis
chrubis@suse.cz
