From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 3 Jul 2020 16:00:57 +0800
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <20200703075136.enu2ovlfo25cwyca@vireshk-i7>
References: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
 <902db9f8-22d9-b641-746b-6ec61b8eaa21@cn.fujitsu.com>
 <20200703075136.enu2ovlfo25cwyca@vireshk-i7>
Message-ID: <2ced43d0-4bf0-982a-fd7e-3628716890c4@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh

> On 03-07-20, 15:43, Yang Xu wrote:
>> Hi Viresh
>>
>> Can we add a linux tag for this case(also a regression test for the before kernel patch).
> Right, so this patch must be tested for kernels >= v3.9. I missed
> that. This is what you were referring to, right ?

We only need to check /proc/sys/kernel/sched_rr_timeslice_ms whether existed in setup phase and
then check proc value in run like prctl08.c[1].

[1]https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/prctl/prctl08.c

>
> What's the regression test you are suggesting here ?

The following kernel patch.

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=975e155ed8732cb81f55c021c441ae662dd040b5

>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/42e2b934/attachment-0001.htm>
