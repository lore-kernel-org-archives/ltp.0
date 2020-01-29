From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Jan 2020 19:15:03 +0100
Subject: [LTP] [PATCH v2 1/1] ioctl,
 pty Add: fallback definition of struct termio
In-Reply-To: <20200129163127.GH22477@rei.lan>
References: <20200129132759.5265-1-pvorel@suse.cz>
 <20200129145314.GE22477@rei.lan> <20200129153613.GA13790@dell5510>
 <20200129163127.GH22477@rei.lan>
Message-ID: <20200129181503.GA6603@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Thanks! I wonder if I should move new LTP_CHECK_TERMIO function from newly
> > created ltp-termio.m4 into already existing ltp-ioctl.m4. If we want to bother.

> > BTW we might want do consider moving simple uses of AC_CHECK_TYPES (e.g.
> > ltp-quota.m4) or AC_CHECK_MEMBERS (e.g. ltp-signal.m4, ltp-perf_event.m4)
> > into configure.ac, similarly we did for AC_CHECK_HEADERS and AC_CHECK_FUNCS
> > (to cut number of files in m4/, which just contain single line).
> > But maybe this way it's easier to track why check was done.

> I would say that either way is fine, but if you prefer having the simple
> ones in configure.ac then go for it.
OK, I kept it as it is and I'll prepare some autotools cleanup patch.
Thanks for your review.

Kind regards,
Petr
