From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 31 May 2017 10:30:45 +0200
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
 <20170530121501.GC24720@rei.lan>
 <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
Message-ID: <20170531083045.GA2276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, we can also fill in the standard tst_test structure in the test
> > then "override" some of the fields in the timer test library.
> > 
> > I.e. test defines tst_test structure and the sampling function, timer
> > library main() stores and replaces setup & cleanup, sets the test
> > function then calls the tst_run_tcases() function. Does that sound
> > better?
> 
> Yes. This would mean we extend tst_test struct and add sampling function.
> As long as rest of fields continue to work (with some exceptions [1]),
> it sounds good.

We can setup the test/sample functions as an union. As we can then
distinguish between them based on .tcnt being non-zero in a case of
standard test and expect sampling function to be set in a case of the
timer test. However this makes the whole interface less type safe and
also much harder to extend. I was thinking of adding support for NULL
terminated array of test funcitons as well since we have some testcases
that use the test() function as dispatcher with a long switch()
statement...

So maybe we should just add a few more function pointers there.

> I see you still want to keep timer library main(), but I'm not sure
> how you are going to select it instead of tst_test main.

Only the tst_timer_test.h should be included in the timer testcases
which includes tst_test.h after defining TST_NO_DEFAULT_MAIN, then we
can define timer specific main that saves cleanup/setup and replaces
these with the timer test cleanup/setup that calls the test specifc
cleanup/setup functions. The timer library main also has to set up the
test function and test options in the tst_test structure since I want to
avoid setting these in each of the testcases to avoid copy & paste
errors.

-- 
Cyril Hrubis
chrubis@suse.cz
