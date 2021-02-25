From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Feb 2021 10:36:00 +0100
Subject: [LTP] [PATCH] syscalss/timer_settime03.c: Add kconfig
 requirement info in file header.
In-Reply-To: <20210225085805.5146-1-zhaogongyi@huawei.com>
References: <20210225085805.5146-1-zhaogongyi@huawei.com>
Message-ID: <YDdvgKyt1XakAkYY@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Test will fail when CONFIG_HIGH_RES_TIMERS is not set to y, because the return value of
> timer_getoverrun is equal to expiry_time_values/interval. When CONFIG_HIGH_RES_TIMERS is set to y,
> interval is equal to 1.
> When CONFIG_HIGH_RES_TIMERS is not set to y, interval is equal to HZ*1000000, and the
> return value of timer_getoverrun will not be greater than or equal to {DELAYTIMER_MAX} in this
> testcase. See https://nvd.nist.gov/vuln/detail/CVE-2018-12896.

If the test causes false possitives without high resolution timers
enabled then the requirement should be added to the needs_kconfigs
arrary in the tst_test structure instead.

-- 
Cyril Hrubis
chrubis@suse.cz
