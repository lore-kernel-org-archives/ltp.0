From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 3 Jul 2020 13:21:36 +0530
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Validate the
 timeslice
In-Reply-To: <902db9f8-22d9-b641-746b-6ec61b8eaa21@cn.fujitsu.com>
References: <325a43a851acca8bb242011a1d62063c8154653c.1593152309.git.viresh.kumar@linaro.org>
 <0744cfd7d2f14d8e8c6d8e74420b35ef273a7737.1593761725.git.viresh.kumar@linaro.org>
 <902db9f8-22d9-b641-746b-6ec61b8eaa21@cn.fujitsu.com>
Message-ID: <20200703075136.enu2ovlfo25cwyca@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03-07-20, 15:43, Yang Xu wrote:
> Hi Viresh
> 
> Can we add a linux tag for this case(also a regression test for the before kernel patch).

Right, so this patch must be tested for kernels >= v3.9. I missed
that. This is what you were referring to, right ?

What's the regression test you are suggesting here ?

-- 
viresh
