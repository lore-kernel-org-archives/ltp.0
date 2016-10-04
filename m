From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Oct 2016 05:54:35 -0400 (EDT)
Subject: [LTP] new shell library
In-Reply-To: <20161004093549.GC29418@rei.lan>
References: <20161003145835.GD7583@rei.suse.cz>
 <2007222752.190298.1475569383933.JavaMail.zimbra@redhat.com>
 <20161004084532.GA29418@rei.lan>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
Message-ID: <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 4 October, 2016 11:35:49 AM
> Subject: Re: new shell library
> 
> Hi!
> > > What about we do it as:
> > > 
> > > TST_ID="du01"
> > > TST_CNT=23
> > > TST_SETUP=setup
> > > TST_CLEANUP=cleanup
> > > TST_TESTFUNC=du_test
> > > TST_NEEDS_TMPDIR=1
> > > TST_NEEDS_CMDS="dd du stat"
> > > . tst_test.sh
> > > 
> > > # the actuall test code
> > > 
> > > tst_run
> > 
> > OK, giving all uniform names (TST_) and adding setup/cleanup/testfunc
> > makes it more clear.
> > 
> > What role does ". tst_test.sh" have in example above? Does it
> > have to come after you define all variables? If so, what does
> > it do?
> > 
> > If we have tst_run, then it seems that could do all necessary
> > checks and setup and we could include tst_test.sh at any point.
> 
> I somehow find it more clear to define all the variables that the
> library script uses before we source it. IMHO that is better than having
> them scattered all around the script, at this point both the old test.sh
> and tst_test.sh scripts enforce that by doing sanity checks on the
> variables when the library script is sourced.
> 
> Are any advantages for doing the sanity checks in the tst_run function?

Can't think of any. You (and old test.sh) convinced me to go with your
example. Let's give it couple days, if anyone else wants to weigh in.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
