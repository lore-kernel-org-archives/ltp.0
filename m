From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2019 10:00:27 -0400 (EDT)
Subject: [LTP] [RFC PATCH] tst_taint: TCONF when kernel is alreay tainted
In-Reply-To: <20190919100205.GA26642@rei>
References: <20190918053519.26244-1-liwang@redhat.com>
 <20190919100205.GA26642@rei>
Message-ID: <679691068.6290837.1571148027820.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > As the tst_taint_init comments described, If the tainted-flags are already
> > set
> > by the kernel, there is no reason to continue and TCONF is generated. But
> > in
> > the function achieve, it uses TBROK.
> > 
> >   cmdline="cve-2017-17053"
> >   tst_test.c:1096: INFO: Timeout per run is 0h 10m 00s
> >   tst_taint.c:88: BROK: Kernel is already tainted: 536871424
> 
> There is a reason for generating TBROK, we do not want the test to be
> skipped silently in this case.

It can still run and maybe trigger worse problem. IMO if test wants
to report taint flags it should only report _new_ taint flags.

We could add a dummy test to end of runtest file, which would check
selected taint flags and report WARN/FAIL, so they are guaranteed
to appear on report.

Regards,
Jan
