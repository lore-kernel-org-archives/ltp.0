From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 14:17:17 +0100
Subject: [LTP] [PATCH 2/4] lib: Check also flags for tst_res()
In-Reply-To: <20200228121347.GB8324@rei>
References: <20200227163922.317-1-pvorel@suse.cz>
 <20200227163922.317-2-pvorel@suse.cz>
 <CAEemH2fTYf91KP6_Kf343taLmoGeTuOvNJWVr1qf5C-02+CZpQ@mail.gmail.com>
 <20200228121347.GB8324@rei>
Message-ID: <20200228131717.GA15552@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > >  #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
> > >         do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)

> > > +#define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
> > > +       TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition)


> > To be honest, this looks verbose and confusing a little. I'm thinking can
> > we just add a prefix TST_ to the kernel macro and use it directly?

> > e.g

> > #define TST_BUILD_BUG_ON(condition) \
> >         do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)

> I guess that the confusing part is that TST_RES_SUPPORTS_... uses
> TST_BRK_SUPPORTS_...

> I guess that it would be nicer if we had TST_BUILD_BUG_ON() and then
> both TST_RES_SUPPORTS_... and TST_BRK_SUPPORTS_... would use it.

> I personally think that TST_BUILD_BUG_ON() itself is not verbose enough
> though.

+1. I'll implement it like this and merge (unless somebody objects).

Kind regards,
Petr
