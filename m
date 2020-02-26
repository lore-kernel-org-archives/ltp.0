From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 Feb 2020 12:37:57 +0100
Subject: [LTP] [PATCH 1/1] request_key04: Use TFAIL instead of TBROK
In-Reply-To: <CAEemH2cXGOh=MX28kYvhFaHspHGXiVdGuNZeyN97+O3+bt1jGg@mail.gmail.com>
References: <20200226084249.29561-1-pvorel@suse.cz>
 <CAEemH2cMBtVV-1_RZb_UHN9rQF3sD2w-H2gS11BD2WHPTPzvgQ@mail.gmail.com>
 <20200226091824.GA2215@dell5510>
 <CAEemH2cXGOh=MX28kYvhFaHspHGXiVdGuNZeyN97+O3+bt1jGg@mail.gmail.com>
Message-ID: <20200226113757.GA24342@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > ...
> > > > obvious fix which I'd normally merge without sending to ML.
> > > > But there are 19 tests which use tst_res(TBROK, and at least some of
> > > > them are affected by this (i.e. don't unconditionally report any result
> > > > before tst_res(TBROK), so we might want to fix it different way.

> > > +1 for this fix.
> > Thanks for your review.

> > > By the way, do you think it makes sense to add build check parameters for
> > > tst_res() too? Just like what we do for tst_brk() in commit 0738e3753c51.

> > IMHO if we agree that tst_res(TBROK) is harmful and should be avoided
> > entirely,

> I agree.

> > I'd be for adding this check.


> In personally, I'd let tst_res() only accept 'TPASS, TFAIL, TINFO, TCONF,
> TWARN'.
+1. Cyril, Jan?

Kind regards,
Petr
