From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Aug 2018 09:33:57 -0400 (EDT)
Subject: [LTP] [PATCH RFC v3 2/3] lib: introduce tst_timeout_remaining()
In-Reply-To: <20180829130845.GB30074@rei>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
 <5730db8dee0c566014c99bc0d264326fe1c923cc.1535466715.git.jstancek@redhat.com>
 <20180829130845.GB30074@rei>
Message-ID: <1455249520.43485695.1535549637276.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > +#include <stdlib.h>
> > +#include "tst_test.h"
> > +
> > +static void run(void)
> > +{
> > +	unsigned int remaining = tst_timeout_remaining();
> 
> Maybe we should do something as:
> 
> 	while (tst_timeout_remaining() > 2)
> 		sleep(1);
> 
> 	tst_res(TPASS, ...);

Yeah, I felt guilty adding more sleeps() :-).

> 
> And set timeout in tst_test to something as 10s, to really test the API.
> 
> > +	if (remaining >= 200)
> > +		tst_res(TPASS, "Timeout remaining: %d", remaining);
> > +	else
> > +		tst_res(TFAIL, "Timeout remaining: %d", remaining);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +};
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 2f3d357d2fcc..75619fabffa4 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -47,6 +47,8 @@ static int iterations = 1;
> >  static float duration = -1;
> >  static pid_t main_pid, lib_pid;
> >  static int mntpoint_mounted;
> > +static clockid_t tst_clock;
> > +static struct timespec tst_start_time;
> >  
> >  struct results {
> >  	int passed;
> > @@ -758,6 +760,7 @@ static void do_setup(int argc, char *argv[])
> >  
> >  	if (tst_test->sample)
> >  		tst_test = tst_timer_test_setup(tst_test);
> > +	tst_clock = tst_timer_find_clock();
> 
> I wonder if we really need this, we were running with CLOCK_MONOTONIC
> timer in the testrun() for quite some time now and nobody complained so
> far.

I don't have strong opinion on this. It's fairly cheap to go through that list,
and we can be more courageous to change order later.

> 
> Well I guess that it would be nice to use CLOCK_MONOTONIC_COARSE for the
> tst_timeout_remaining if available, which should save us some CPU since
> it's supposed to be called in a loop.
> 
> >  	parse_opts(argc, argv);
> >  
> > @@ -992,6 +995,21 @@ static void sigint_handler(int sig
> > LTP_ATTRIBUTE_UNUSED)
> >  	}
> >  }
> >  
> > +unsigned int tst_timeout_remaining(void)
> > +{
> > +	static struct timespec now;
> > +	unsigned int elapsed;
> > +
> > +	if (tst_clock_gettime(tst_clock, &now))
> > +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> > +
> > +	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
> > +	if (results->timeout > elapsed)
> > +		return results->timeout - elapsed;
> > +
> > +	return 0;
> > +}
> 
> This is obviously correct.
> 
> >  void tst_set_timeout(int timeout)
> >  {
> >  	char *mul = getenv("LTP_TIMEOUT_MUL");
> > @@ -1012,6 +1030,9 @@ void tst_set_timeout(int timeout)
> >  		results->timeout = results->timeout * m + 0.5;
> >  	}
> >  
> > +	if (tst_clock_gettime(tst_clock, &tst_start_time))
> > +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> 
> Looking into this, this will not work with the -i option, since the
> timeout is restarted after each iteration in heartbeat_handler().
> However clock_gettime() is supposedly signal-safe. So as far as I can
> tell we have to take the timestamp in the heartbeat_handler() instead
> and that should be it.

heartbeat() is called in tst_set_timeout() only for non-lib pids.
And testrun() calls it only after run_tests().

So I think it will have to be at both locations: anytime we call alarm(),
we'll need to re-initialize tst_start_time:

void timeout_restart(void)
{
    alarm(results->timeout);
    if (tst_clock_gettime(tst_clock, &tst_start_time))
        tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
}

and call it in tst_set_timeout() and heartbeat_handler()

---

What is your opinion on API? Absolute numbers vs ratio approach?

Regards,
Jan
