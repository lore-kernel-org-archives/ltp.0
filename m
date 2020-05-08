From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 8 May 2020 09:00:34 +0530
Subject: [LTP] [PATCH 2/8] syscalls/futex: Add support for time64 tests
In-Reply-To: <20200507145258.GA16940@dell5510>
References: <7e037dacaeb0c7f3bfd73cd11d80f3e1567dc052.1588669892.git.viresh.kumar@linaro.org>
 <379f4d58e86b5249f56ff58e1907dee69d67e451.1588669892.git.viresh.kumar@linaro.org>
 <20200507145258.GA16940@dell5510>
Message-ID: <20200508033034.cyem2olxb7kpvu4s@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07-05-20, 16:52, Petr Vorel wrote:
> Hi,
> 
> FYI, 2nd and 6th patch didn't apply cleanly.
> Trivial fixes, but for anybody who is lazy to repeat the work here it's done:
> https://github.com/pevik/ltp/tree/Viresh_Kumar/futex_wait_bitset.v1

I was wondering on why it won't rebase properly, unless I tried to do
it again the way you have it. I forgot to mention that these patches
were based on the earlier patches I sent and so there was some
dependency in tst_timer.h. If you apply following series first, you
won't get these rebase issues.

[PATCH 1/4] syscalls/timer_gettime: Add support for time64 tests

Will it be easier if I resend all my patches again in a single series
? I can also add the new tests I have converted then.

-- 
viresh
