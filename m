From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Mar 2016 13:21:07 +0100
Subject: [LTP] [PATCH RFC 3/9] tracing[2]: reorganize ftrace stress
 tests to general tests
In-Reply-To: <CAEemH2duh-a3yw-2y0xx9VBe0Sor8imJJeotcC-Q-t-w8J2fCw@mail.gmail.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <20160317163918.GD31815@rei.lan>
 <CAEemH2duh-a3yw-2y0xx9VBe0Sor8imJJeotcC-Q-t-w8J2fCw@mail.gmail.com>
Message-ID: <20160321122107.GB32294@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Seems like these regression cases are petty and simple. I fear that would
> be too dispersed to read. How about taking use of the cgroup tests
> code-style to organise them?

I do not think so. The problem with running to many testcases as one
test is that we get wrong idea about the overall result. Even if one
regression test fails the test will return failure and instead of 90%
green we end up with 100% red in the results.

And also the cgroup_regression_test.sh does not use the test.sh library
do not take the test as example please.

> which will be like:
> ---------------------
> $ cat ftrace_regression_test.sh
> #! /bin/sh
> ...
> 
> export TCID="ftrace-regression-test"
> export TST_TOTAL=N ( N depends on how many test_$cur)
> export TST_COUNT=1
> 
> . ftrace_lib.sh
> 
> test_success=false
> 
> test_check()
> {
>     if $test_success; then
>         tst_resm TPASS "finished running the test."
>     else
>         tst_resm TFAIL "running the test failed, please check log message."
>     fi
> 
>     test_success=false

Generic failure messages are not a good idea. The test should really
report what exactly went wrong.

> }
> 
> #comments the test_1 info blablabla....
> test_1()
> {
>    ...
>    set test_success 'true' or 'false' base on the test result
>    ...
>    test_check;
> }
> 
> test_2()
> {
>    ...
>    test_check;
> }
> 
> test_3()
> {
>    ...
>    test_check;
> }
> 
> test_regression()
> {
>     for cur in $(seq $TST_TOTAL); do
>         test_$cur
>     done
> }
> 
> #----------------------------------
> echo "Ftrace Regression Test Begin"
> 
> save_old_setting
> 
> test_regression
> 
> clean_up
> 
> echo "Ftrace Regression Test End"

You should use tst_resm TINFO here. And also these messages are quite
meaningless anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
