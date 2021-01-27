From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Jan 2021 20:01:24 +0100
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
In-Reply-To: <e573f919-8205-40e2-5187-49bff0983872@jv-coder.de>
References: <20210125131746.74630-1-lkml@jv-coder.de>
 <e573f919-8205-40e2-5187-49bff0983872@jv-coder.de>
Message-ID: <YBG4hFVo5wdaFnPa@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> --- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
> > @@ -1,58 +1,39 @@
> >   #!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2009 FUJITSU LIMITED
> > +# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
> This is bad copy-and-paste for all files, where I mentioned arm, sorry...
That's not a big deal.

On a first look good cleanup, thank you!

I hope these tests aren't planned to be rewritten to C (like NUMA tests).
I suppose not, but better to ask earlier.

Kind regards,
Petr
