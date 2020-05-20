From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 20 May 2020 13:01:51 +0530
Subject: [LTP] [PATCH 4/5] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <20200519122155.GB16008@yuki.lan>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
 <a6c2c59a9cffb86d751b911384a560803e723623.1589877853.git.viresh.kumar@linaro.org>
 <20200519122155.GB16008@yuki.lan>
Message-ID: <20200520073151.y5xttqnqeqe4jmka@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-05-20, 14:21, Cyril Hrubis wrote:
> So we can as well so that they take the tst_ts structure, then we are
> also free to change the way the timestamp is acquired without the need
> to change all the callers.

I am not sure I understood it all. What do you mean by "also free to change the
way the timestamp is acquired"?

Also, even if these routines take a struct tst_ts, the callers will all need to
have the changes which are currently done, as they can't pass struct timespec
anymore. Over that, few of the callers (cve-2016-7117.c and tst_timer_test.c)
would be required to have more changes as right now they only needed to move
from timespec to __kernel_old_timespec and nothing else.

Another reason why I didn't pass tst_ts to them is because you suggested me
earlier, to not pass that to the tst_syscall() definitions I added earlier for
all the syscalls, where I was doing tst_get_ts() inside the tst_clock_gettime()
calls for example. And you asked me to let the caller do that and pass only the
actual timespec in a void *.

-- 
viresh
