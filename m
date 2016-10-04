From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Oct 2016 05:02:13 -0400 (EDT)
Subject: [LTP] new shell library
In-Reply-To: <20161004084532.GA29418@rei.lan>
References: <20161003145835.GD7583@rei.suse.cz>
 <2007222752.190298.1475569383933.JavaMail.zimbra@redhat.com>
 <20161004084532.GA29418@rei.lan>
Message-ID: <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 4 October, 2016 10:45:32 AM
> Subject: Re: new shell library
> 
> Hi!
> > As a person who sees this first time, my immediate concern was,
> > how do I know what variables functions names are reserved
> > (without need to read entire tst_test.sh) and what happens if
> > I make a typo?
> >
> > It also forces me to use specific names as the names
> > of my functions (e.g. "test", which presumably shadows test(1)).
> 
> That is a valid concern. I guess that passing everyting
> (setup/cleanup/test/etc.) via TST_FOO variables would be much better.
> 
> I was trying to reduce the number of lines per test as much as possible
> but this is perhaps too agressive and the end result is complicated
> automagic that is hard to understand.
> 
> > And there's now requirement on when you can include new library,
> > it has to be at the end of file, because there are side-effects
> > (it starts the test on inclusion).
> > 
> > So, I was thinking:
> > 
> > . tst_test.sh
> > 
> > ...
> > 
> > tst_def TID="du01"
> > tst_def TCNT=23
> > tst_def TST_SETUP mysetup
> > tst_def TST_CLEANUP mycleanup
> > tst_def TST_TESTFUNC mytest
> > tst_def TST_NEEDS_TMPDIR=1
> > tst_def TST_NEEDS_CMDS="dd du stat"
> > tst_start
> > 
> > tst_def - makes it clear that this variable defines something for tst_test,
> >           checks for potential typos, doesn't allow non-existent ones,
> >           is a single place in tst_test.sh where I can see all possible
> >           variables together
> 
> Hmm, I do not like this indirection too much. This obscures what is
> happening in similar manner to my automagic.
> 
> What about we do it as:
> 
> TST_ID="du01"
> TST_CNT=23
> TST_SETUP=setup
> TST_CLEANUP=cleanup
> TST_TESTFUNC=du_test
> TST_NEEDS_TMPDIR=1
> TST_NEEDS_CMDS="dd du stat"
> . tst_test.sh
> 
> # the actuall test code
> 
> tst_run

OK, giving all uniform names (TST_) and adding setup/cleanup/testfunc
makes it more clear.

What role does ". tst_test.sh" have in example above? Does it
have to come after you define all variables? If so, what does
it do?

If we have tst_run, then it seems that could do all necessary
checks and setup and we could include tst_test.sh at any point.

Regards,
Jan
