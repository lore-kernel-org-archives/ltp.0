From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 08:05:06 +0100
Subject: [LTP] [PATCH 2/4] lib: Check also flags for tst_res()
In-Reply-To: <CAEemH2fTYf91KP6_Kf343taLmoGeTuOvNJWVr1qf5C-02+CZpQ@mail.gmail.com>
References: <20200227163922.317-1-pvorel@suse.cz>
 <20200227163922.317-2-pvorel@suse.cz>
 <CAEemH2fTYf91KP6_Kf343taLmoGeTuOvNJWVr1qf5C-02+CZpQ@mail.gmail.com>
Message-ID: <20200228070506.GA23156@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Thanks for your work on this!
Thanks for your review!

...
> > +++ b/include/tst_common.h
> > @@ -77,4 +77,7 @@
> >  #define TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition) \
> >         do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)

> > +#define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
> > +       TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(condition)


> To be honest, this looks verbose and confusing a little. I'm thinking can
> we just add a prefix TST_ to the kernel macro and use it directly?

> e.g

> #define TST_BUILD_BUG_ON(condition) \
>         do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
Yep, I was also thinking to get back to the original name BUILD_BUG_ON().
TST_BUILD_BUG_ON() is even better (although I considered TST_ as part of public
API, this is internal implementation).

Kind regards,
Petr
