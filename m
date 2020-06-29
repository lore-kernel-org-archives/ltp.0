From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 29 Jun 2020 17:13:33 +0530
Subject: [LTP] [PATCH V7 03/19] syscalls/timer_settime: Add support for
 time64 tests
In-Reply-To: <20200629093938.GB2552@yuki.lan>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <ff846fd931de19b2bbb44b2bc0631f4883a8e8bf.1593152309.git.viresh.kumar@linaro.org>
 <20200629093938.GB2552@yuki.lan>
Message-ID: <20200629114333.akzbp4bjz6lx6vgm@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29-06-20, 11:39, Cyril Hrubis wrote:
> Hi!
> Pushed with a minor change, thanks.
> 
> Added cast to (timer_t) to the -1 to avoid warnings.
> 
> Also if you are not burned out writing timer testcases and still willing
> to spend a bit of time none of the timer tests actually check that the
> timer fires. I guess that it would be easy to add the check that reads
> back the itmierspec, checks that the value is sane and also waits for
> singnal or two to the timer_settime01.

Done and sent.

-- 
viresh
