From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jul 2017 15:01:13 +0800
Subject: [LTP] [PATCH V2 03/14] mem/oom: fix the timeout issue
In-Reply-To: <20170707151137.GF28534@rei.lan>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-4-liwang@redhat.com>
 <20170707151137.GF28534@rei.lan>
Message-ID: <CAEemH2fbJmvYQapOJ1A-1BqeGa5QuY_03ncNY_3qbk7by3XufA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 7, 2017 at 11:11 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> OOM spend time is depend on amount of RAM+Swap, it's hard to get a standard
>> to measure how long it takes, so that we cann't set tst_test->timeout easily.
>>
>> In this patch, we divide the tests into two part:
>>
>> 1. OOM takes original way on small(mem_total <= 100G) RAM, and with setting
>>    the .timeout according to the worst spending on 100G system. Here gives
>>    double(.timeout = 1200) cost in order to make sure time is long enough.
>>
>> 2. If system RAM is larger than 100G, OOM goes to the cgroup limited way.
>
> I wonder if it's really OK to limit these tests to 100G of RAM. Since as
> it is these tests can really stress the system on low memory conditions,
> if we limit them to run inside of a cgroup we are testing cgroup
> implementation instead, which is we should probably do as well.

Sounds reasonable.

>
> I'm starting to think that OOM tests are special enough so that we can
> add functionality to disable timeouts for these, i.e. set the .timeout
> to -1 and change the test library so that the alarm() is not set in such
> case.

Have to say this idea is better. it keeps the tests original and simple enough.

I draft a patch for it:
-------------------------

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 16ea64f..94d951b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -917,10 +917,12 @@ void tst_run_tcases(int argc, char *argv[],
struct tst_test *self)
        SAFE_SIGNAL(SIGALRM, alarm_handler);
        SAFE_SIGNAL(SIGUSR1, heartbeat_handler);

-       if (tst_test->timeout)
-               tst_set_timeout(tst_test->timeout);
-       else
+       if (tst_test->timeout) {
+               if (tst_test->timeout > 0)
+                       tst_set_timeout(tst_test->timeout);
+       } else {
                tst_set_timeout(300);
+       }

        SAFE_SIGNAL(SIGINT, sigint_handler);

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 64a368e..9bc5e57 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -62,6 +62,7 @@ static struct tst_test test = {
        .tid = "oom01",
        .needs_root = 1,
        .forks_child = 1,
+       .timeout = -1,
        .setup = setup,
        .cleanup = cleanup,
        .test_all = verify_oom,


>
> Jan do you have anything to add?



-- 
Li Wang
liwang@redhat.com
