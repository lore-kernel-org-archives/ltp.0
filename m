From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2019 11:19:36 -0400 (EDT)
Subject: [LTP] [RFC PATCH] tst_taint: TCONF when kernel is alreay tainted
In-Reply-To: <20191015143852.GA8454@rei.lan>
References: <20190918053519.26244-1-liwang@redhat.com>
 <20190919100205.GA26642@rei>
 <679691068.6290837.1571148027820.JavaMail.zimbra@redhat.com>
 <20191015143852.GA8454@rei.lan>
Message-ID: <701658846.6304240.1571152776451.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > > As the tst_taint_init comments described, If the tainted-flags are
> > > > already
> > > > set
> > > > by the kernel, there is no reason to continue and TCONF is generated.
> > > > But
> > > > in
> > > > the function achieve, it uses TBROK.
> > > > 
> > > >   cmdline="cve-2017-17053"
> > > >   tst_test.c:1096: INFO: Timeout per run is 0h 10m 00s
> > > >   tst_taint.c:88: BROK: Kernel is already tainted: 536871424
> > > 
> > > There is a reason for generating TBROK, we do not want the test to be
> > > skipped silently in this case.
> > 
> > It can still run and maybe trigger worse problem. IMO if test wants
> > to report taint flags it should only report _new_ taint flags.
> 
> IMHO this is more complex than this, we look for a specific subset of
> taint flags. One is the warn flag, that is not well defined and may be
> harmless and the second is the died flag, which is set on OOPS or BUG. I
> I would say that in case of the died flag any subseqent testing is
> pointless since the machine is in inconsistent state and has to be
> rebooted anyways. Hence we may weaken the check for a warning flag, i.e.
> ignore it if it was set at the start of the test, but certainly not for
> the died flag, which would solve this problem as well.

OK, I'd vote for getting rid of warn flag then or ignore it on test start.
Upstream devel trees tend to trigger lot of random warnings during boot,
e.g. a random driver warning from device that isn't even used by LTP.

> 
> > We could add a dummy test to end of runtest file, which would check
> > selected taint flags and report WARN/FAIL, so they are guaranteed
> > to appear on report.
> 
> Actually the new testrunner runltp-ng checks the taint flags after each
> test and reboots the machine if needed, which is, as far as I can tell,
> the right place for such checks.

It is right place, but I think it (reboot) should be configurable behavior.
Some harnesses might want to handle it themselves or just stop testing.
For example on 1TB box that takes 45min to boot, I'd probably turn it off.
