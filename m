From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 15:52:00 +0200
Subject: [LTP] [PATCH] Makefile: Use SPDX in Makefile
In-Reply-To: <20210512084904.35159-1-xieziyao@huawei.com>
References: <20210512084904.35159-1-xieziyao@huawei.com>
Message-ID: <YJvdgJCg2ZWq8lWM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ziyao,

> For the testsuite that has used SPDX, also modify its Makefile to use SPDX.
Nice cleanup. Good, you included only GPLv2+ Makefiles.

Unfortunately patch cannot be applied with 'git am' and even with patch:

$ patch -p1 <Makefile-Use-SPDX-in-Makefile.patch
patching file doc/Makefile
patch: **** malformed patch@line 244: diff --git a/include/Makefile b/include/Makefile

Line 244 is top_srcdir:
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 top_srcdir			?= ..

I suppose you generate patch correctly with 'git format-patch' and send with
'git send-email'. I wonder if your mailserver breaks the patch. Could you check
it and optionally use different mailserver? (you can send mail to ML from e.g.
gmail and still have Signed-off-by: with huawei.com mail address).

...
> +++ b/testcases/open_posix_testsuite/Makefile
> @@ -1,35 +1,23 @@
> -#
> -# Read COPYING for licensing details.
> -#
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  # Ngie Cooper, June 2010
> -#
>  # Makefiles that are considered critical to execution; if they don't exist
>  # all of the Makefiles will be rebuilt by default.
>  CRITICAL_MAKEFILE=	conformance/interfaces/timer_settime/Makefile
> -
>  # The default logfile for the tests.
>  LOGFILE?=		logfile
>  # Subdirectories to traverse down.
>  SUBDIRS=		conformance functional stress
> -
>  MAKE_ENV=		LOGFILE=`if echo "$(LOGFILE)" | grep -q '^/'; then echo "$(LOGFILE)"; else echo "\`pwd\`/$(LOGFILE)"; fi`.$@
> -
>  BUILD_MAKE_ENV=		"CFLAGS=$(CFLAGS)" "LDFLAGS=$(LDFLAGS)"
>  BUILD_MAKE_ENV+=	"LDLIBS=$(LDLIBS)" $(MAKE_ENV)
> -
>  TEST_MAKE_ENV=		$(MAKE_ENV)
> -
>  BUILD_MAKE=		env $(BUILD_MAKE_ENV) $(MAKE)
> -
>  TEST_MAKE=		env $(TEST_MAKE_ENV) $(MAKE) -k
>  top_srcdir?=		.
> -
>  prefix?=		`$(top_srcdir)/scripts/print_prefix.sh`
> -
>  datadir?=		$(prefix)/share
> -
>  exec_prefix?=		$(prefix)
>  all: conformance-all functional-all stress-all tools-all
> @@ -41,7 +29,7 @@ endif
>  clean: $(CRITICAL_MAKEFILE)
>  	@rm -f $(LOGFILE)*
>  	@for dir in $(SUBDIRS) tools; do \
> -	    $(MAKE) -C $$dir clean >/dev/null; \
> +		$(MAKE) -C $$dir clean >/dev/null; \
>  	done
>  distclean: distclean-makefiles
> @@ -54,7 +42,7 @@ distclean-makefiles:
>  generate-makefiles: distclean-makefiles
>  	@env top_srcdir=$(top_srcdir) \
> -	    $(top_srcdir)/scripts/generate-makefiles.sh
> +		$(top_srcdir)/scripts/generate-makefiles.sh
>  install: bin-install conformance-install functional-install stress-install
> @@ -102,8 +90,8 @@ tools-all:
>  	@$(MAKE) -C tools all
>  $(CRITICAL_MAKEFILE): \
> -    $(top_srcdir)/scripts/generate-makefiles.sh	\
> -    $(top_srcdir)/CFLAGS			\
> -    $(top_srcdir)/LDFLAGS			\
> -    $(top_srcdir)/LDLIBS
> +	$(top_srcdir)/scripts/generate-makefiles.sh	\
> +	$(top_srcdir)/CFLAGS			\
> +	$(top_srcdir)/LDFLAGS			\
> +	$(top_srcdir)/LDLIBS
>  	@$(MAKE) generate-makefiles

Unrelated change: you fix also indent here. It'd be better to add it into
separate patch.

Kind regards,
Petr
