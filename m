From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Apr 2020 12:49:45 +0530
Subject: [LTP] [PATCH V4 1/5] syscalls/clock_gettime: Add support for
 time64 tests
In-Reply-To: <20200423135048.GB3632@yuki.lan>
References: <cover.1587533697.git.viresh.kumar@linaro.org>
 <2e57919c45e9e9b23bd0e819ffc470a9326ecfb1.1587533697.git.viresh.kumar@linaro.org>
 <20200423135048.GB3632@yuki.lan>
Message-ID: <20200424071945.yqsxq6m5oelsoh5l@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23-04-20, 15:50, Cyril Hrubis wrote:
> Hi!
> Pushed with a few changes, thanks.
> 
> * Changed the nonzero check to check if nanoseconds are valid,
>   which covers the 64bit check as well.
> 
> * Pushed the bad address handling down to the test, which means that
>   we have to convert the struct tst_ts for each syscall, but I think
>   that it's cleaner that way and we also map only single bad address per
>   test.

Thanks. I have resent the pending patches from this series with
modification based on your changes to this patch, so you won't be
required waste that much time on this :)

-- 
viresh
