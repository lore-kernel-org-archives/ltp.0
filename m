From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Apr 2020 16:15:21 +0200
Subject: [LTP] [PATCH V5 5/5] syscalls/clock_adjtime: Add support for
 time64 tests
In-Reply-To: <c4bf1e2c7699a8fe2d05ab498495646f9d41ce44.1587712683.git.viresh.kumar@linaro.org>
References: <a143f48ffeec14739d35c07dfb95f237981a322d.1587712683.git.viresh.kumar@linaro.org>
 <c4bf1e2c7699a8fe2d05ab498495646f9d41ce44.1587712683.git.viresh.kumar@linaro.org>
Message-ID: <20200427141520.GC7661@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've cleaned up the code and pushed, thanks.

Fixed things such as:

* Macros should be uppercase, otherwise it's confusing

* All local variables has to be passed to macros as parameters
  this one is confusing as hell

* No variables and parameters stating with underscore, unless
  we defined fallback for kernel types these are reserved for
  kernel/libc

* The tst_get_bad_addr() allocates a page for each call, so I have moved
  it to setup

* etc...

-- 
chrubis@suse.cz
