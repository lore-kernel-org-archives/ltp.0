From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 30 Aug 2018 11:46:11 +0200
Subject: [LTP] [PATCH RFC v3 2/3] lib: introduce tst_timeout_remaining()
In-Reply-To: <20180829143507.GD30074@rei>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
 <5730db8dee0c566014c99bc0d264326fe1c923cc.1535466715.git.jstancek@redhat.com>
 <20180829130845.GB30074@rei>
 <1455249520.43485695.1535549637276.JavaMail.zimbra@redhat.com>
 <20180829143507.GD30074@rei>
Message-ID: <87sh2wrxuk.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Maybe we should do something as:
>> >
>> > 	while (tst_timeout_remaining() > 2)
>> > 		sleep(1);
>> >
>> > 	tst_res(TPASS, ...);
>>
>> Yeah, I felt guilty adding more sleeps() :-).
>
> Well in this case it's reasonable use... ;-)
>
>> > And set timeout in tst_test to something as 10s, to really test the API.
>> >
>> > > +	if (remaining >= 200)
>> > > +		tst_res(TPASS, "Timeout remaining: %d", remaining);
>> > > +	else
>> > > +		tst_res(TFAIL, "Timeout remaining: %d", remaining);
>> > > +}
>> > > +
>> > > +static struct tst_test test = {
>> > > +	.test_all = run,
>> > > +};
>> > > diff --git a/lib/tst_test.c b/lib/tst_test.c
>> > > index 2f3d357d2fcc..75619fabffa4 100644
>> > > --- a/lib/tst_test.c
>> > > +++ b/lib/tst_test.c
>> > > @@ -47,6 +47,8 @@ static int iterations = 1;
>> > >  static float duration = -1;
>> > >  static pid_t main_pid, lib_pid;
>> > >  static int mntpoint_mounted;
>> > > +static clockid_t tst_clock;
>> > > +static struct timespec tst_start_time;
>> > >
>> > >  struct results {
>> > >  	int passed;
>> > > @@ -758,6 +760,7 @@ static void do_setup(int argc, char *argv[])
>> > >
>> > >  	if (tst_test->sample)
>> > >  		tst_test = tst_timer_test_setup(tst_test);
>> > > +	tst_clock = tst_timer_find_clock();
>> >
>> > I wonder if we really need this, we were running with CLOCK_MONOTONIC
>> > timer in the testrun() for quite some time now and nobody complained so
>> > far.
>>
>> I don't have strong opinion on this. It's fairly cheap to go through that list,
>> and we can be more courageous to change order later.
>
> We do use CLOCK_MONOTONIC in the tst_test.c unconditionally anyways, so
> I wouldn't bother with this unless somebody complains.
>
>> > Well I guess that it would be nice to use CLOCK_MONOTONIC_COARSE for the
>> > tst_timeout_remaining if available, which should save us some CPU since
>> > it's supposed to be called in a loop.

I doubt we will notice the difference in speed, if there is any on a
modern CPU. On all the implementations I found in glibc
CLOCK_MONOTONIC(_RAW) appears to just read a register value and scale it
to the CPU frequency. It doesn't look like an expensive operation in LTP
terms. However in some scenarious we definitely need a high resolution
clock.

I think defining TST_DEFAULT_CLOCK as CLOCK_MONOTONIC(_RAW) and using it
everywhere should be fine, although I don't have anything against
returning it from an inline function either.

--
Thank you,
Richard.
