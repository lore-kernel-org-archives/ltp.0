From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 May 2020 17:27:39 +0200
Subject: [LTP] [PATCH v4 2/2] pty04: Add SLCAN ldisc and check for
 CVE-2020-11494
In-Reply-To: <87a72ms93x.fsf@our.domain.is.not.set>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505101625.25020-2-rpalethorpe@suse.com>
 <20200505133523.GA27810@yuki.lan> <20200505135531.GA30346@dell5510>
 <87a72ms93x.fsf@our.domain.is.not.set>
Message-ID: <20200505152739.GD9949@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> >> Hi!
> >> Both pushed, thanks.

> > This test does not compile on kernel older than v4.2-rc1 (2015),
> > because __pad, __res0 and __res1 are missing. They were added in
> > a2f11835994e ("can.h: make padding given by gcc explicit").

> I suppose I can just drop the header and define it inline as we need the
> fallback anyway.
+1. Thanks!

Kind regards,
Petr
