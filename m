From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 23:18:39 +0200
Subject: [LTP] [PATCH v3 2/2] capability: library tests
In-Reply-To: <20190823094621.21747-2-rpalethorpe@suse.com>
References: <20190823094621.21747-1-rpalethorpe@suse.com>
 <20190823094621.21747-2-rpalethorpe@suse.com>
Message-ID: <20190829211839.GD5711@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +++ b/lib/newlib_tests/tst_capability01.c
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * The user or file requires CAP_NET_RAW for this test to work.
> + * e.g use "$ setcap cap_net_raw=pei tst_capability"

It'd be nice if our build system supported setting capabilities during make
install. It's probably not worth of doing just for single LTP library test,
but I still plan to implement 'make check' for lib/newlib_tests/ content,
so this will have to be handled manually.

Kind regards,
Petr
