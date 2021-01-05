From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2021 14:36:59 +0100
Subject: [LTP] [RFC PATCH 2/2] include/tst_test_macros.h: Report TINFO
 when TST_EXP_FD() succeeded
In-Reply-To: <20210104125423.19183-2-yangx.jy@cn.fujitsu.com>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <20210104125423.19183-2-yangx.jy@cn.fujitsu.com>
Message-ID: <X/Rre6xb0cAg1Emw@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In Summary output, avoid counting the double passed for one test:
> -------------------------------------
> ./open01
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
> open01.c:48: TPASS: open() with sticky bit returned fd 3
> open01.c:59: TPASS: sticky bit is set as expected
> open01.c:48: TPASS: open() with sirectory bit returned fd 3
> open01.c:59: TPASS: sirectory bit is set as expected
> 
> Summary:
> passed   4
> failed   0
> broken   0
> skipped  0
> warnings 0
> -------------------------------------

What exactly is the problem of having TPASS generated for each open()
that produces a valid file descriptor in the open testcases?

These macros are especially tailored to generate TPASS/TFAIL messages so
that the caller does not have to. So even if having two TPASS per run()
function in open01 was a problem, which I do not think is the case, we
should just use SAFE_OPEN() there instead.

-- 
Cyril Hrubis
chrubis@suse.cz
