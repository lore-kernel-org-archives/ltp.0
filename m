From: yangx.jy <yangx.jy@cn.fujitsu.com>
Date: Tue, 5 Jan 2021 22:39:00 +0800
Subject: [LTP] [RFC PATCH 2/2] include/tst_test_macros.h: Report TINFO
 when TST_EXP_FD() succeeded
In-Reply-To: <X/Rre6xb0cAg1Emw@yuki.lan>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <20210104125423.19183-2-yangx.jy@cn.fujitsu.com> <X/Rre6xb0cAg1Emw@yuki.lan>
Message-ID: <5FF47A04.4030908@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/5 21:36, Cyril Hrubis wrote:
> Hi!
>> In Summary output, avoid counting the double passed for one test:
>> -------------------------------------
>> ./open01
>> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
>> open01.c:48: TPASS: open() with sticky bit returned fd 3
>> open01.c:59: TPASS: sticky bit is set as expected
>> open01.c:48: TPASS: open() with sirectory bit returned fd 3
>> open01.c:59: TPASS: sirectory bit is set as expected
>>
>> Summary:
>> passed   4
>> failed   0
>> broken   0
>> skipped  0
>> warnings 0
>> -------------------------------------
> What exactly is the problem of having TPASS generated for each open()
> that produces a valid file descriptor in the open testcases?
>
> These macros are especially tailored to generate TPASS/TFAIL messages so
> that the caller does not have to. So even if having two TPASS per run()
> function in open01 was a problem, which I do not think is the case, we
> should just use SAFE_OPEN() there instead.
Hi Cyril,

I perfer to report one TPASS message when finishing one subtest instead 
of one step.
     because of two reasons:
    a) It seems clearer for user to know how many subtests were run 
sucessfully.
    b) There are too many TPASS/TFAIL messages when a testcase(e.g. 
open11) contains many subtests or multiple TST_EXP_* macros.
Could we make TST_EXP_* macros do common check and generate only TFAIL 
messages? (Make testcases report TPASS message by themself)

Best Regards,
Xiao Yang



