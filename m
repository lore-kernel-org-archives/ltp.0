From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 16:04:45 +0200
Subject: [LTP] [PATCH 2/2] syscalls/mbind0{2, 3,
	4}: Add basic mbind tests
In-Reply-To: <20190228153425.10286-3-chrubis@suse.cz>
References: <20190228153425.10286-1-chrubis@suse.cz>
 <20190228153425.10286-3-chrubis@suse.cz>
Message-ID: <20190603140445.GB13662@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This test is similar to the set_mempolicy() tests, but with mbind we are
> actually binding memory to nodes after it was mapped.

> mbind02: We are trying to get EIO with MPOL_MF_STRICT and page that was already
>          faulted on wrong node.

> mbind03: We are moving pages with MPOL_MF_MOVE and MPOL_MF_MOVE_ALL and
>          checking the result.

> mbind04: We are applying memory policy before we fault the pages and check
>          that the pages were faulted accordingly.

Generally LGTM, just Makefile needs updating after adding libltpnuma:
LDFLAGS += -L$(top_builddir)/libs/libltpnuma
LDLIBS  += $(NUMA_LIBS) -lltpnuma
(mbind01 does not need that, I'd ignore that).

...
> +++ b/testcases/kernel/syscalls/mbind/mbind.h
...
> +static inline const char *mbind_flag_name(unsigned flag)
> +{
> +	switch (flag) {
> +	case 0:
> +		return "0";
> +	case MPOL_MF_STRICT:
> +		return "MPOL_MF_STRICT";
> +	case MPOL_MF_MOVE:
> +		return "MPOL_MF_MOVE";
> +	case MPOL_MF_MOVE_ALL:
> +		return "MPOL_MF_MOVE_ALL";
> +	default:
> +		return "???";
I guess "???" is important for us. Otherwise I'd use macro:
#define MBIND_FLAG_NAME(x) #x

..
> +++ b/testcases/kernel/syscalls/mbind/mbind02.c
...
> +static void setup(void)
> +{
> +	page_size = getpagesize();
> +
> +	nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
> +	if (nodes->cnt <= 1)
> +		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_nodemap_free(nodes);
> +}
Maybe setup and cleanup can be put as static inline into mbind.h? As it's
repeated. PAGES_ALLOCATED would have to be defined for all.

...
> +++ b/testcases/kernel/syscalls/mbind/mbind03.c
> @@ -0,0 +1,123 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*
> + * We are testing mbind() EIO error.
> + *
> + * We first fault a allocated page, then attempt to mbind it to a different node.
Here is a copy paste error. But commit message is correct:
    mbind03: We are moving pages with MPOL_MF_MOVE and MPOL_MF_MOVE_ALL and
             checking the result.

Kind regards,
Petr
