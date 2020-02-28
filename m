From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 15:17:52 +0100
Subject: [LTP] [PATCH 2/4] lib: Check also flags for tst_res()
In-Reply-To: <20200228131717.GA15552@dell5510>
References: <20200227163922.317-1-pvorel@suse.cz>
 <20200227163922.317-2-pvorel@suse.cz>
 <CAEemH2fTYf91KP6_Kf343taLmoGeTuOvNJWVr1qf5C-02+CZpQ@mail.gmail.com>
 <20200228121347.GB8324@rei> <20200228131717.GA15552@dell5510>
Message-ID: <20200228141752.GA23217@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I guess that it would be nicer if we had TST_BUILD_BUG_ON() and then
> > both TST_RES_SUPPORTS_... and TST_BRK_SUPPORTS_... would use it.

> > I personally think that TST_BUILD_BUG_ON() itself is not verbose enough
> > though.

> +1. I'll implement it like this and merge (unless somebody objects).
Merged.

Kind regards,
Petr
