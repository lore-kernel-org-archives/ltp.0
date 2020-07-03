From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Jul 2020 13:48:52 +0530
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <2ced43d0-4bf0-982a-fd7e-3628716890c4@cn.fujitsu.com>
References: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
 <902db9f8-22d9-b641-746b-6ec61b8eaa21@cn.fujitsu.com>
 <20200703075136.enu2ovlfo25cwyca@vireshk-i7>
 <2ced43d0-4bf0-982a-fd7e-3628716890c4@cn.fujitsu.com>
Message-ID: <20200703081852.7mxbhkfz6vgjfwak@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03-07-20, 16:00, Yang Xu wrote:
> We only need to check /proc/sys/kernel/sched_rr_timeslice_ms whether existed in setup phase and
> then check proc value in run like prctl08.c[1].
> 
> [1]https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/prctl/prctl08.c

This is certainly better, thanks.

> > What's the regression test you are suggesting here ?
> 
> The following kernel patch.
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=975e155ed8732cb81f55c021c441ae662dd040b5

Yeah I got that you were talking about this, but I am not sure of what
regression test you are asking for and if we should be adding a test
towards it at all as this is a kernel bug and we should keep showing
the error for such kernels, isn't it ?

-- 
viresh
