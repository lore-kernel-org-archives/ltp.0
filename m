From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 05 May 2020 16:18:58 +0100
Subject: [LTP] [PATCH v4 2/2] pty04: Add SLCAN ldisc and check for
 CVE-2020-11494
In-Reply-To: <20200505135531.GA30346@dell5510>
References: <20200505101625.25020-1-rpalethorpe@suse.com>
 <20200505101625.25020-2-rpalethorpe@suse.com>
 <20200505133523.GA27810@yuki.lan> <20200505135531.GA30346@dell5510>
Message-ID: <87a72ms93x.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Cyril, Richard,
>
>> Hi!
>> Both pushed, thanks.
>
> This test does not compile on kernel older than v4.2-rc1 (2015),
> because __pad, __res0 and __res1 are missing. They were added in
> a2f11835994e ("can.h: make padding given by gcc explicit").

I suppose I can just drop the header and define it inline as we need the
fallback anyway.

>
> This got propagated on CentOS 6. I'd be for dropping it after release (most of
> the problems are due old gcc 4), but v4.1 is still too new, so I'll send some
> autotools based fix for this.
>
> Kind regards,
> Petr

-- 
Thank you,
Richard.
