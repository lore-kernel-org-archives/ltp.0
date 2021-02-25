From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 25 Feb 2021 11:40:13 +0000
Subject: [LTP] [PATCH] syscalss/timer_settime03.c: Add kconfig
 requirement info in file header.
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387A3EC@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have resubmit the patch.

Thanks very much!


> 
> Hi!
> > Test will fail when CONFIG_HIGH_RES_TIMERS is not set to y, because
> > the return value of timer_getoverrun is equal to
> > expiry_time_values/interval. When CONFIG_HIGH_RES_TIMERS is set to
> y, interval is equal to 1.
> > When CONFIG_HIGH_RES_TIMERS is not set to y, interval is equal to
> > HZ*1000000, and the return value of timer_getoverrun will not be
> > greater than or equal to {DELAYTIMER_MAX} in this testcase. See
> https://nvd.nist.gov/vuln/detail/CVE-2018-12896.
> 
> If the test causes false possitives without high resolution timers enabled
> then the requirement should be added to the needs_kconfigs arrary in
> the tst_test structure instead.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
