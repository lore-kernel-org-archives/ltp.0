From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2016 18:42:17 +0800
Subject: [LTP] [PATCH RFC 3/9] tracing[2]: reorganize ftrace stress
 tests to general tests
In-Reply-To: <20160317163918.GD31815@rei.lan>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <20160317163918.GD31815@rei.lan>
Message-ID: <CAEemH2duh-a3yw-2y0xx9VBe0Sor8imJJeotcC-Q-t-w8J2fCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Fri, Mar 18, 2016 at 12:39 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> ...
>
> Adding a script that runs all testcases is frowned upon in LTP. What you
> should do instead is to make it possible to run individual testcases and
> add the tests one test per line to a runtest file.
>
>
Seems like these regression cases are petty and simple. I fear that would
be too dispersed to read. How about taking use of the cgroup tests
code-style to organise them?

which will be like:
---------------------
$ cat ftrace_regression_test.sh
#! /bin/sh
...

export TCID="ftrace-regression-test"
export TST_TOTAL=N ( N depends on how many test_$cur)
export TST_COUNT=1

. ftrace_lib.sh

test_success=false

test_check()
{
    if $test_success; then
        tst_resm TPASS "finished running the test."
    else
        tst_resm TFAIL "running the test failed, please check log message."
    fi

    test_success=false
}

#comments the test_1 info blablabla....
test_1()
{
   ...
   set test_success 'true' or 'false' base on the test result
   ...
   test_check;
}

test_2()
{
   ...
   test_check;
}

test_3()
{
   ...
   test_check;
}

test_regression()
{
    for cur in $(seq $TST_TOTAL); do
        test_$cur
    done
}

#----------------------------------
echo "Ftrace Regression Test Begin"

save_old_setting

test_regression

clean_up

echo "Ftrace Regression Test End"



> Also newly added test should use test.sh library.
>

sure, this no problem!

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160318/1bbe9eee/attachment-0001.html>
