From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 6 Dec 2018 17:11:45 -0200
Subject: [LTP] [PATCH v2 1/2] syscalls/clock_settime01.c: create syscall
 clock_settime
In-Reply-To: <20181206190710.22471-1-rafael.tinoco@linaro.org>
References: <20181206130309.GA22250@rei>
 <20181206190710.22471-1-rafael.tinoco@linaro.org>
Message-ID: <7cf88d1e-edbf-bbe9-4930-7eccc86d8457@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/6/18 5:07 PM, Rafael David Tinoco wrote:
> Fixes: 343
> 
> clock_settime01 creates a new test, using new API, based on existing and
> older kernel/timers/clock_settime tests. It includes tests from files
> clock_settime02 and clock_settime03, which will be deleted in next
> commits.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---

Cyril,

Please if you accept this patch, amend the description to:

"""
clock_settime01 creates a new test, using new API, based on existing
and older kernel/timers/clock_settime02 test. clock_settime02 creates
another test based on older kernel/timers/clock_settime03 test. Both
will be deleted in the next commits.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
"""

I forgot to change description before sending v2. Sorry.

About the first test, best way to check good results is:

$ date ; time sudo $(find . -name clock_settime01) -I 10 2>&1 >
/dev/null 2>&1 ; date

Thu Dec  6 17:09:24 -02 2018

real	0m10.032s
user	0m2.710s
sys	0m11.911s

Thu Dec  6 17:09:34 -02 2018

Using CLOCK_MONOTONIC_RAW we can make sure to restore a good time to
CLOCK_REALTIME after the test has run (independently of how many seconds
it took or iterations it had).

-- 
Rafael D. Tinoco
Linaro - Kernel Validation
