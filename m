From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 14:59:53 +0200
Subject: [LTP] [PATCH v3 3/4] tst_timer: Create interface for using
 multiple timers
In-Reply-To: <87bma24gek.fsf@rpws.prws.suse.cz>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-3-rpalethorpe@suse.com>
 <20180816122247.GD6547@rei> <87bma24gek.fsf@rpws.prws.suse.cz>
Message-ID: <20180816125953.GA30369@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Well if the clock is not supported and the call fails, then the user
> will have to deal with that at the call site of tst_timer_start which is
> not very convenient for tst_fuzzy_sync. I would rather have a seperate
> initialisation function for the tst_timer struct which can be called in
> the setup function. e.g. tst_timer_init[_st](clock_id, timeout, ...).
> 
> >
> > And lastly but not least, we were also discussion special timer id,
> > something as TST_TIMER_DEFAULT that would select appropriate timer,
> > althoug I guess that CLOCK_MONOTONIC is supporoted on anything that we
> > care for these days.
> 
> Yeah, fuzzy_sync just defines CLOCK_MONOTIC to CLOCK_MONOTONIC_RAW if
> possible and uses that. Not had any reports of CLOCK_MONOTONIC being
> unavailabe.

Maybe we can just do:

#ifdef CLOCK_MONOTONIC_RAW
# define TST_CLOCK_DEFAULT CLOCK_MONOTONIC_RAW
#else
# define TST_CLOCK_DEFAULT CLOCK_MONOTONIC
#endif

And be done with it.

-- 
Cyril Hrubis
chrubis@suse.cz
