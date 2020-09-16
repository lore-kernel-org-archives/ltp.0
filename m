From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Sep 2020 09:11:06 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200916071106.GB1433@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Tim,

> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>

> ...
> > > P.P.S How come some tests produce TPASS and some produce just PASS?
> > Legacy C API and shell API (both legacy and new) add T (i.e. TPASS), new C API
> > don't add it (i.e. PASS). It's a minor detail we could fix that.

> Well, Fuego's parser only checks for PASS (probably due to the inconsistency),
> but personally I'd prefer if it was consistent. The string "TPASS" is much less
> likely to appear in unrelated output than "PASS" is.

> It looks like it comes from print_result() in ltp/lib/tst_test.c.

> Here's a patch, in case there's interest in changing it:
Please next time use git format-patch and add comments which are not supposed to
be part of the commit message below ---.

> From 151168bf384135d7c79b0c09bb95267ba1293205 Mon Sep 17 00:00:00 2001
> From: Tim Bird <tim.bird@sony.com>
> Date: Tue, 15 Sep 2020 14:18:37 -0600
> Subject: [PATCH] tst_test: Change result strings to use T prefix

> Change PASS to TPASS in the new C library.
> Change other results strings to also include the "T" prefix.
> This makes the new library consistent with previous LTP
> output, and with the shell output.


Reviewed-by: Petr Vorel <pvorel@suse.cz>

Although leaving this to Cyril (although having T prefix or not is quite
cosmetic, he had a reason to omit it).  Also there is ongoing rewrite of tests
still using legacy API to use new API, thus the inconsistency will disappear in
the long term.

IMHO: don't care that much about legacy API, but synchronize new C and shell
API.

Kind regards,
Petr
