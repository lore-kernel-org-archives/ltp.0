From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 31 May 2017 06:51:32 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <20170531083045.GA2276@rei.lan>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
 <20170530121501.GC24720@rei.lan>
 <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
 <20170531083045.GA2276@rei.lan>
Message-ID: <1567856045.24503314.1496227892308.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > Hmm, we can also fill in the standard tst_test structure in the test
> > > then "override" some of the fields in the timer test library.
> > > 
> > > I.e. test defines tst_test structure and the sampling function, timer
> > > library main() stores and replaces setup & cleanup, sets the test
> > > function then calls the tst_run_tcases() function. Does that sound
> > > better?
> > 
> > Yes. This would mean we extend tst_test struct and add sampling function.
> > As long as rest of fields continue to work (with some exceptions [1]),
> > it sounds good.
> 
> We can setup the test/sample functions as an union. As we can then
> distinguish between them based on .tcnt being non-zero in a case of
> standard test and expect sampling function to be set in a case of the
> timer test.

tcnt can be also zero if you use test_all()

> However this makes the whole interface less type safe and
> also much harder to extend.

Agreed, I'd avoid union.

> I was thinking of adding support for NULL
> terminated array of test funcitons as well since we have some testcases
> that use the test() function as dispatcher with a long switch()
> statement...
> 
> So maybe we should just add a few more function pointers there.
> 
> > I see you still want to keep timer library main(), but I'm not sure
> > how you are going to select it instead of tst_test main.
> 
> Only the tst_timer_test.h should be included in the timer testcases
> which includes tst_test.h after defining TST_NO_DEFAULT_MAIN, then we
> can define timer specific main that saves cleanup/setup and replaces
> these with the timer test cleanup/setup that calls the test specifc
> cleanup/setup functions. The timer library main also has to set up the
> test function and test options in the tst_test structure since I want to
> avoid setting these in each of the testcases to avoid copy & paste
> errors.

What if we modified lib/tst_test.c to make calls to timerlib where needed?
User would just include tst_test.h as before, but instead of test_all
he sets sampling_func in tst_test struct.

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 794aa8555b3a..a0ddb674e2b9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -669,6 +669,9 @@ static void do_setup(int argc, char *argv[])
                tst_test->format_device = 1;
        }

+       if (tst_test->sampling_func)
+               timerlib_add_opts(tst_test);
+
        parse_opts(argc, argv);

        setup_ipc();
@@ -746,7 +749,23 @@ static void run_tests(void)
        unsigned int i;
        struct results saved_results;

-       if (!tst_test->test) {
+       if (tst_test->sampling_func) {
+
+               timerlib_runtest(tst_test->sampling_func);
+
+               if (getpid() != main_pid) {
+                       exit(0);
+               }
+
+               tst_reap_children();
+
+               if (results_equal(&saved_results, results))
+                       tst_brk(TBROK, "Test haven't reported results!");
+               return;
+
+       }
+
+       if (tst_test->test_all) {
                saved_results = *results;
                tst_test->test_all();
@@ -761,6 +780,7 @@ static void run_tests(void)
                return;
        }

+       if (tst_test->test) {
        for (i = 0; i < tst_test->tcnt; i++) {
                saved_results = *results;
                tst_test->test(i);
@@ -774,6 +794,7 @@ static void run_tests(void)
                if (results_equal(&saved_results, results))
                        tst_brk(TBROK, "Test %i haven't reported results!", i);
        }
+       }
 }

 static unsigned long long get_time_ms(void)
@@ -791,6 +812,8 @@ static void testrun(void)
        unsigned long long stop_time = 0;
        int cont = 1;

+       if (tst_test->sampling_func)
+               timerlib_setup();
        do_test_setup();

        if (duration > 0)
@@ -816,6 +839,9 @@ static void testrun(void)
        }

        do_test_cleanup();
+
+       if (tst_test->sampling_func)
+               timerlib_cleanup();
        exit(0);
 }


