From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 17:11:20 +0100
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
In-Reply-To: <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
References: <20170209144445.22737-1-chrubis@suse.cz>
 <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
Message-ID: <20170209161120.GA23109@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#ifndef BRKM_REDIRECT_H__
> > +#define BRKM_REDIRECT_H__
> > +
> > +#include "ltp_priv.h"
> > +
> > +#ifdef tst_brkm
> > +# undef tst_brkm
> > +#endif
> > +
> > +#define tst_brkm(flags, cleanup, fmt, ...) do { \
> > +	if (tst_test) \
> > +		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
> > +	else \
> > +                tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt,
> > ##__VA_ARGS__); \
> > +	} while (0)
> 
> Stil trying to wrap my head around all this, but after first look,..
> How does this related to "tst_brkm_" from lib/tst_res.c?
> Can it be simplified? It doesn't look like we can reach newlib branch
> now, because tst_test condition is now in tst_brkm macro.

Well there more library code shared between oldlib and newlib than
SAFE_MACROS. So we can still reach tst_brkm_() from newlib, for instance
tst_device, tst_brkm, ... Hence the redirection has to stay.

Only change after this patch is that it cannot be reached from
SAFE_MACROS().

> Did we loose the check for "Non-NULL cleanup in newlib"?

Not really, since there is no way SAFE_MACRO would pass non-NULL cleanup
callback, since that is hardcoded in the tst_safe_macros.h header.

> > +#define tst_brkr(rval, flags, cleanup, fmt, ...) do { \
> > +		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
> > +		return rval; \
> > +	} while (0)
> > +
> > +#define tst_brkv(flags, cleanup, fmt, ...) do { \
> > +		tst_brkm(flags, cleanup, fmt, ##__VA_ARGS__); \
> > +		return; \
> > +	} while (0)
> 
> All variants of tst_brk_ are more and more tricky to remember.
> Would it be too much to ask people "when writing new safe function,
> take into account that tst_brkm can return" and leave it up to
> them how they do it. Maybe they'll see goto more fitting.

I wanted to keep the changes minimal, but yes, we can as well
do explicit return instead of tst_brkr() and tst_brkv().

-- 
Cyril Hrubis
chrubis@suse.cz
