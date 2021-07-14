From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 12:43:31 +0200
Subject: [LTP] [PATCH v2 1/8] Add Sparse based checker and TST_RET/ERR
 check
In-Reply-To: <20210714071158.15868-2-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-2-rpalethorpe@suse.com>
Message-ID: <YO6/0+gPhMh/mbW7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Vendors in Sparse as a git module. Then uses it to check for stores to
> TST_RET/ERR within the library.

I think submodules are a bit problematic, thus I'd prefer avoiding them.
But whole thing is integrated nicely, thus:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/tools/sparse/README.md b/tools/sparse/README.md
...
> +# Sparse based linting
> +
> +Note that while it is possible to build Sparse with Clang. This may
> +cause some issues. Namely `GCC_BASE` is set to the Clang resource
> +directory. This contains some headers Sparse can not parse.
> +
> +[1]: Many distributions have a Sparse package. This only contains some executables. There is no shared library
nit: missing dot here.

> diff --git a/tools/sparse/main.c b/tools/sparse/main.c
> new file mode 100644
> index 000000000..58f9a549c
> --- /dev/null
> +++ b/tools/sparse/main.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
> + *
> + * Sparse allows us to perform checks on the AST (struct symbol) or on
> + * a linearized representation. In the latter case we are given a set
> + * of entry points (functions) containing basic blocks of
> + * instructions.
> + *
> + * The basic blocks contain byte code in SSA form. This is similar to
> + * the the intermediate representation most compilers use during
nit: repeated the

> + * optimisation.
> + */

The rest LGTM.

Kind regards,
Petr
