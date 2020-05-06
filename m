From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 May 2020 06:49:55 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] pty04: Use guarded buffers for transmission
In-Reply-To: <877dxpsb4n.fsf@our.domain.is.not.set>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505133746.GB21884@dell5510> <87d07isaka.fsf@our.domain.is.not.set>
 <877dxpsb4n.fsf@our.domain.is.not.set>
Message-ID: <1106041841.11477901.1588762195733.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> 
> Richard Palethorpe <rpalethorpe@suse.de> writes:
> 
> > Hello,
> >
> > Petr Vorel <pvorel@suse.cz> writes:
> >
> >> Hi Richard,
> >>
> >>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> >>> ---
> >>
> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >>
> >> BTW Every second run with this patch it blocks after pty04.c:214: PASS:
> >> Read netdev 1
> >> and then:
> >> tst_checkpoint.c:147: BROK: pty04.c:249: tst_checkpoint_wait(0, 10000):
> >> ETIMEDOUT (110)
> >> tst_test.c:373: BROK: Reported by child (26650)
> >> safe_macros.c:258: BROK: pty04.c:215: read(5,0x7efebc306001,8191) failed,
> >> returned -1: ENETDOWN (100)
> >> pty04.c:139: PASS: Writing to PTY interrupted by hangup
> >> tst_test.c:373: WARN: Reported by child (26648)
> >>
> >> Tested on 5.7.0-rc3 in Tumbleweed.
> >> But it looks this is not caused by this change, but was here before,
> >> because the
> >> same behavior I see when testing pty04 *without* this patch on various
> >> kernels
> >> (5.3.7, 5.6.0-rc5) and some of the never SLES (4.12 based).
> >>
> >> Kind regards,
> >> Petr
> >
> > This looks similar to the issue reported by Jan:
> >
> > https://github.com/linux-test-project/ltp/issues/674
> >
> > Is this the full output?
> >
> > Thinking aloud: the following (probably) happens when writing to the PTY
> >
> > write() -> PTY -> SLIP/SLCAN -> netdev -> read()
> >
> > Writing to the PTY causes the PTY to write to the line discipline. What
> > I found was that when the line discipline receive buffer got full and the
> > PTY
> > send buffer got full. The write would go to sleep and never wake up
> > because the line discipline drained the receive buffer, but doesn't
> > signal it is ready for more data (with tty_unthrottle). So I used
> > nonblocking writes which just retry writing.
> >
> > From Jan's errors it looks like it might just be reading that is failing
> > in one case and that writing is also failing in the other until we
> > cancel the read. I doubt this is anything to do with the netdev code
> > because it is generic networking code AFAICT and should work correctly
> > with blocking reads...
> 
> Probably the best thing todo for now is to remove the test before the
> release as this requires some more investigation.

We can keep it in tree, I'd just disable it in runtest file(s), so it's not
run by default.

