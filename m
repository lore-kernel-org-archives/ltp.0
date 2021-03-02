From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Mar 2021 11:20:26 +0100
Subject: [LTP] [PATCH 6/7] tst_test.sh: Run cleanup also after test
 timeout
In-Reply-To: <CAEemH2c2Bma-xXTcf+1M4CFVjM7ZQS36rV_6i9kJ6Es-19kghA@mail.gmail.com>
References: <20210301220222.22705-1-pvorel@suse.cz>
 <20210301220222.22705-7-pvorel@suse.cz>
 <CAEemH2c2Bma-xXTcf+1M4CFVjM7ZQS36rV_6i9kJ6Es-19kghA@mail.gmail.com>
Message-ID: <YD4RairzgAuyBn7S@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> >  _tst_cleanup_timer()
> >  {
> > @@ -442,6 +442,14 @@ _tst_multiply_timeout()
> >         return 0
> >  }

> > +_tst_run_timer()


> Hmm, this name is not good than before, or rename to _tst_kill_timer_pid(),
> _tst_stop_timer()?

Good point. I slightly prefer _tst_stop_timer, but no hard feeling about it.


Kind regards,
Petr

> > +{
> > +       tst_res TBROK "test killed, timeout! If you are running on slow
> > machine, try exporting LTP_TIMEOUT_MUL > 1"
> > +       kill -INT -$pid
> > +       sleep 5
> > +       kill -KILL -$pid
> > +}
> > +
