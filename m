From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Aug 2018 07:54:16 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] lib: introduce tst_timeout_remaining()
In-Reply-To: <20180830113034.GC6363@rei.lan>
References: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
 <20180830104219.GA6363@rei.lan>
 <706273620.43655984.1535626905479.JavaMail.zimbra@redhat.com>
 <20180830112246.GB6363@rei.lan> <20180830113034.GC6363@rei.lan>
Message-ID: <1443598375.43662526.1535630056840.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > I didn't want to do that, because a test might want calculate something
> > > based on timeout in setup(), for example to find current overall timeout
> > > value with LTP_TIMEOUT_MUL taken into account.
> > > 
> > > For that to work, we have to initialize tst_start_time prior to
> > > tst_test->setup().
> > 
> > Fair enough, also the alarm() in the test library pid is set before we
> > run the test setup, so if the test setup would take a few seconds we
> > will be off with the calculation. Although that could be fixed by
> > calling heartbeat before we run the loop in testrun(), which I guess
> > should be done anyway. That in turn would allow for your patch to have
> > the clock_gettime only in the heartbeat function, right?

Correct. We could replace it with call to hearbeat():

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -929,9 +929,7 @@ static void testrun(void)
        unsigned long long stop_time = 0;
        int cont = 1;
 
-       if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
-               tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
-
+       heartbeat();
        add_paths();
        do_test_setup();
 
but then we should get rid of extra alarm() call in tst_set_timeout(),
because new hearbeat() call will do it anyway (it will send signal,
and handler in lib will call alarm()):

@@ -1038,9 +1036,7 @@ void tst_set_timeout(int timeout)
                results->timeout/3600, (results->timeout%3600)/60,
                results->timeout % 60);
 
-       if (getpid() == lib_pid)
-               alarm(results->timeout);
-       else
+       if (getpid() != lib_pid)
                heartbeat();
 }

> 
> Actually we would have to do the heartbeat before and after the setup.

Why after setup? Doesn't the time spent in setup count towards test time?

> So we should go with your version unless we add a tst_get_timeout()
> function that would return the test timeout, which, given that the
> timeout is stored in tst_test structure would just do:
> 
> static inline int tst_get_timeout(void)
> {
> 	return test.timeout;
> }
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
