From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 7 Jun 2021 11:18:55 +0200
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <20210604111434.21422-2-rpalethorpe@suse.com>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com>
Message-ID: <e6efb099-1c51-9f68-4996-7ce917107929@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 6/4/2021 1:14 PM, Richard Palethorpe via ltp wrote:
> diff --git a/tools/clang-check/Makefile b/tools/clang-check/Makefile
> new file mode 100644
> index 000000000..4650d6057
> --- /dev/null
> +++ b/tools/clang-check/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
> +# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +top_srcdir		?= ../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/functions.mk
> +
> +HOST_MAKE_TARGETS	:= main
> +HOST_LDFLAGS 		+= -lclang
If anyone else trying this has problems linking the tool, at least for 
me, this must be
HOST_LDLIBS ??? ??? += -lclang

Otherwise the link order is wrong (main.c after -lclang) and all symbols 
from libclang are undefined.

J?rg
