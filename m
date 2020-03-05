From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Mar 2020 18:53:25 +0100
Subject: [LTP] [PATCH v2 1/2] Add TST_ASSERT_SYSCALL*() macros
In-Reply-To: <20200305174205.GA29517@dell5510>
References: <20200305151459.30341-1-mdoucha@suse.cz>
 <20200305174205.GA29517@dell5510>
Message-ID: <20200305175325.GA16171@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What I like on these macros (besides DRY) is that it really shows the test, not
> the library, see
> before:
> tst_safe_timerfd.c:21: BROK: timerfd01.c:89 timerfd_create(CLOCK_MONOTONIC) failed: EINVAL (22)
> after:
> timerfd01.c:89: BROK: timerfd_create(CLOCK_MONOTONIC) failed: EINVAL (22)

That's because it calls tst_brk_() correctly instead of tst_brk(). I
should have caught that during the review.

Also given the way it's structured now we can pass these parameters to a
shell script as well and generate the end result easily. With a bit more
work we can generate both header and C source as well and would still
prefer that over these macros.

-- 
Cyril Hrubis
chrubis@suse.cz
