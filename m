From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Jul 2020 12:56:09 +0530
Subject: [LTP] [PATCH V7 05/19] syscalls/sched_rr_get_interval: Add
 support for time64 tests
In-Reply-To: <fb2f4706-2739-9ab7-3b1f-a741cf055680@cn.fujitsu.com>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <20200702130654.GC9101@yuki.lan>
 <20200703031532.bjkwhkpfobdsxj4p@vireshk-i7>
 <fb2f4706-2739-9ab7-3b1f-a741cf055680@cn.fujitsu.com>
Message-ID: <20200703072609.st5psivk656ioetv@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03-07-20, 13:52, Yang Xu wrote:
> Hi Viresh
> 
> > On 02-07-20, 15:06, Cyril Hrubis wrote:
> > > Btw, we may as well add a check that the value is consistent with
> > > /proc/sys/kernel/sched_rr_timeslice_ms.
> 
> I guess cyril may want to add a check using TST_ASSERT_INT api like this
> 
> TST_ASSERT_INT("/proc/sys/kernel/sched_rr_timeslice_ms", tst_ts_to_ms(tp));
> 
> It is strange.
> On my machine, the two values are all 100. AFAIK, it has a bug (set in milliseconds but the result is shown in jiffies.) on old kernel whenCONFIG_HZ is not 1000. what kernel version do you test?

I am running an old kernel (4.4) and with 250 CONFIG_HZ.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=975e155ed8732cb81f55c021c441ae662dd040b5

I sent it to get included in stable kernels now.

https://lore.kernel.org/lkml/ffdfb849a11b9cd66e0aded2161869e36aec7fc0.1593757471.git.viresh.kumar@linaro.org/

-- 
viresh
