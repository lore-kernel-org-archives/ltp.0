From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Apr 2020 15:50:48 +0200
Subject: [LTP] [PATCH V4 1/5] syscalls/clock_gettime: Add support for
 time64 tests
In-Reply-To: <2e57919c45e9e9b23bd0e819ffc470a9326ecfb1.1587533697.git.viresh.kumar@linaro.org>
References: <cover.1587533697.git.viresh.kumar@linaro.org>
 <2e57919c45e9e9b23bd0e819ffc470a9326ecfb1.1587533697.git.viresh.kumar@linaro.org>
Message-ID: <20200423135048.GB3632@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

* Changed the nonzero check to check if nanoseconds are valid,
  which covers the 64bit check as well.

* Pushed the bad address handling down to the test, which means that
  we have to convert the struct tst_ts for each syscall, but I think
  that it's cleaner that way and we also map only single bad address per
  test.

-- 
Cyril Hrubis
chrubis@suse.cz
