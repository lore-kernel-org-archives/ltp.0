From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Mar 2021 11:26:10 +0100
Subject: [LTP] [PATCH 5/7] tst_test.sh: Introduce
 tst_set_timeout(timeout)
In-Reply-To: <YD4Ny76lh0+ydBqQ@yuki.lan>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-6-pvorel@suse.cz>
 <CAEemH2cr0TFvFiis_05Fh4bEe1ZUmFtMO5ysYFped5ZQYucvAg@mail.gmail.com>
 <YD4Ny76lh0+ydBqQ@yuki.lan>
Message-ID: <YD4SwkQYyBxMWaay@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > > +tst_set_timeout()
> > > +{
> > > +       TST_TIMEOUT="$1"


> > Not sure if we should check "$1" is valid again before using it.

> > I guess in most scenarios, the function is invoked by tests, so
> > just needs to guarantee $1 > $TST_TIMEOUT, otherwise, it
> > looks meaningless to reset TST_TIMEOUT?
> > (especially to avoid people set a smaller value by a typo)

> I can image where it may make sense to set the timeout smaller than
> default dynamically. If we had a test that consists of many iterations
> whose number depends on the actuall system we run on (the same as the
> supported filesystem) but if the iterations are rather quick we may end
> up in a situation where we run only one iteration and we will attempt to
> set a timeout smaller than default in the setup() which wouldn't be
> wrong.
+1, I couldn't agree more.

> Hence I would check that the value is greater than zero here instead.
I'd allow also to disable timeout with -1. And the rest of the checks
(i.e. int -1 or > 0) is in _tst_setup_timer().

Kind regards,
Petr
