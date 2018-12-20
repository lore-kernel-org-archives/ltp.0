From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Dec 2018 15:22:43 +0100
Subject: [LTP] [PATCH] controllers/cpuacct.sh: Fix timeout for cpuacct.sh
In-Reply-To: <1544087108-5717-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1544087108-5717-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181220142243.GA30787@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> With commit fbea02a, cpuacct.sh always gets timeout because wait
> command tries to wait all background processes including the timeout
> process.  We should just wait the processes created for test.

> e.g. running cpuacct_1_1 gets the following timeout:
> -----------------------------------------------------------
> cpuacct 1 TINFO: timeout per run is 0h 5m 0s
> cpuacct 1 TINFO: cpuacct:
> cpuacct 1 TINFO: Creating 1 subgroups each with 1 processes
> cpuacct 1 TBROK: test killed, timeout!
> -----------------------------------------------------------

> Fixes: fbea02a("lib/tst_test.sh: setup timeout per test run for the shell tests")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks for your fix, merged.

I look for other plain wait usage, this was the only one using new shell API.

Kind regards,
Petr
