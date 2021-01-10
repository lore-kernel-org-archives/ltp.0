From: yangx.jy <yangx.jy@cn.fujitsu.com>
Date: Sun, 10 Jan 2021 21:48:39 +0800
Subject: [LTP] [RFC PATCH 2/2] include/tst_test_macros.h: Report TINFO
 when TST_EXP_FD() succeeded
In-Reply-To: <X/R/2VVe1dJxGhHN@yuki.lan>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <20210104125423.19183-2-yangx.jy@cn.fujitsu.com> <X/Rre6xb0cAg1Emw@yuki.lan>
 <5FF47A04.4030908@cn.fujitsu.com> <X/R/2VVe1dJxGhHN@yuki.lan>
Message-ID: <5FFB05B7.1080107@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Sorry for the late reply because I am busy with other things recently.

On 2021/1/5 23:03, Cyril Hrubis wrote:
> Hi!
>>> What exactly is the problem of having TPASS generated for each open()
>>> that produces a valid file descriptor in the open testcases?
>>>
>>> These macros are especially tailored to generate TPASS/TFAIL messages so
>>> that the caller does not have to. So even if having two TPASS per run()
>>> function in open01 was a problem, which I do not think is the case, we
>>> should just use SAFE_OPEN() there instead.
>> Hi Cyril,
>>
>> I perfer to report one TPASS message when finishing one subtest instead
>> of one step.
>>       because of two reasons:
>>      a) It seems clearer for user to know how many subtests were run
>> sucessfully.
> This depends on a definition of subtest which, as far as I can tell, is
> not that well defined.
>
> If you want to make the output easier to read in the case of a test
> function that is called more than once we should change the test library
> to insert empty lines between the iterations or something along these
> lines, so that the output would look like:
>
> ./open01
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
>
> open01.c:48: TPASS: open() with sticky bit returned fd 3
> open01.c:56: TPASS: sticky bit is set as expected
>
> open01.c:48: TPASS: open() with sirectory bit returned fd 3
> open01.c:56: TPASS: sirectory bit is set as expected
>
> Summary:
> passed   4
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> Which is way better than imposing any rules on how many TPASS/TFAIL
> messages should be printed per iteration.
>
>>      b) There are too many TPASS/TFAIL messages when a testcase(e.g.
>> open11) contains many subtests or multiple TST_EXP_* macros.
> There are 28 testcases in open11 and we print 28 messages TPASS/TFAIL
> messages, we just use different EXP macro for different testcases. I do
> not think that silencing the output would make things any better.
I gave a wrong example.  access02 may be the correct one:
-----------------------------------------------------------------
# ./access02
tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
access02.c:62: TPASS: access(file_f, F_OK) as root passed
access02.c:141: TPASS: access(file_f, F_OK) as root behaviour is correct.
access02.c:62: TPASS: access(file_f, F_OK) as nobody passed
access02.c:141: TPASS: access(file_f, F_OK) as nobody behaviour is correct.
access02.c:62: TPASS: access(file_r, R_OK) as root passed
access02.c:141: TPASS: access(file_r, R_OK) as root behaviour is correct.
access02.c:62: TPASS: access(file_r, R_OK) as nobody passed
access02.c:141: TPASS: access(file_r, R_OK) as nobody behaviour is correct.
...

Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0
-----------------------------------------------------------------
>> Could we make TST_EXP_* macros do common check and generate only TFAIL
>> messages? (Make testcases report TPASS message by themself)
> The whole idea of having the TST_EXP_* macros is that they replace code
> that looks like:
>
> 	if (condition)
> 		tst_res(TPASS, "...");
> 	else
> 		tst_res(TFAIL, "...");
>
> And that they actually unify how these messages are formatted.
>
> If you think that there are places where we use these macros where
> SAFE_MACRO() would be better we can talk about changing these.
I thought about it again yesterday and wanted to introduce new TST_EXP_ 
SILENT_{FD,PASS} macros.
1) TST_EXP_SILENT_{PASS,FD} do common checks and don't report TPASS when 
SCALL succeeds.
2) TST_EXP_{PASS,FD} take use of TST_EXP_SILENT_{PASS,FD} and report 
TPASS when SCALL succeeds.
BTW: Make testcase use which macros by themselves.

Please see my v2 patch set for detailed implement:
http://lists.linux.it/pipermail/ltp/2021-January/020472.html
http://lists.linux.it/pipermail/ltp/2021-January/020473.html

Best Regards,
Xiao Yang


