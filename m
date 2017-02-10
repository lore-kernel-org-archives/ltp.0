From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Feb 2017 03:27:07 -0500 (EST)
Subject: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
In-Reply-To: <20170209161120.GA23109@rei>
References: <20170209144445.22737-1-chrubis@suse.cz>
 <1235532957.2260942.1486655806975.JavaMail.zimbra@redhat.com>
 <20170209161120.GA23109@rei>
Message-ID: <1865245988.2484651.1486715227566.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 9 February, 2017 5:11:20 PM
> Subject: Re: [LTP] [PATCH 1/2] SAFE_MACROS: Redirect to tst_brk_() early
> 
> Hi!
> > > +#ifndef BRKM_REDIRECT_H__
> > > +#define BRKM_REDIRECT_H__
> > > +
> > > +#include "ltp_priv.h"
> > > +
> > > +#ifdef tst_brkm
> > > +# undef tst_brkm
> > > +#endif
> > > +
> > > +#define tst_brkm(flags, cleanup, fmt, ...) do { \
> > > +	if (tst_test) \
> > > +		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
> > > +	else \
> > > +                tst_brkm_(__FILE__, __LINE__, flags, cleanup, fmt,
> > > ##__VA_ARGS__); \
> > > +	} while (0)
> > 
> > Stil trying to wrap my head around all this, but after first look,..
> > How does this related to "tst_brkm_" from lib/tst_res.c?
> > Can it be simplified? It doesn't look like we can reach newlib branch
> > now, because tst_test condition is now in tst_brkm macro.
> 
> Well there more library code shared between oldlib and newlib than
> SAFE_MACROS. So we can still reach tst_brkm_() from newlib, for instance
> tst_device, tst_brkm, ... Hence the redirection has to stay.

Can't we use macro above directly in include/old.test.h and avoid all
redefinitions later? We would move some common stuff from ltp_priv.h
to include/ header, like forward declaration of tst_test and tst_brk_,
but you get the idea: no macro redefinitions would be needed.
