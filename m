From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Jul 2020 11:15:10 +0200
Subject: [LTP] [PATCH V7 06/19] syscalls/futex: Merge futex_wait_bitset
 tests
In-Reply-To: <681915c7fbb224ffdd9acb5dba012cc7aadfbd46.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <681915c7fbb224ffdd9acb5dba012cc7aadfbd46.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200703091510.GA2308@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We can handle them easily in a single test, lets do it.

I guess that the original reason to keep them separate was due to
tst_timer_check() function that exits the test if particular timer is
not present.

However these days we expect that CLOCK_MONOTONIC is present in many
testcases so we can as well remove the function from the test, which I
did before applying, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
