From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Jun 2021 16:16:06 +0200
Subject: [LTP] [RFC PATCH v3 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <20210614115638.25467-2-rpalethorpe@suse.com>
References: <20210614115638.25467-1-rpalethorpe@suse.com>
 <20210614115638.25467-2-rpalethorpe@suse.com>
Message-ID: <YMi2JhW+QvTgOzE0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/mk/clang-check.mk b/include/mk/clang-check.mk
> new file mode 100644
> index 000000000..2ab7b67a1
> --- /dev/null
> +++ b/include/mk/clang-check.mk
> @@ -0,0 +1,9 @@
> +# Rules to make clang-check tool(s) for inclusion in lib and testcases Makefiles
> +
> +CLANG_CHECK_DIR:= $(abs_top_builddir)/tools/clang-check
> +
> +$(CLANG_CHECK_DIR)/main: $(CLANG_CHECK_DIR)
> +	$(MAKE) -C "$^" -f "$(CLANG_CHECK_DIR)/Makefile" all
> +
> +$(CLANG_CHECK_DIR): %:
> +	mkdir -p "$@"
> diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
> index 218447ef3..e1561a989 100644
> --- a/include/mk/config.mk.in
> +++ b/include/mk/config.mk.in
> @@ -44,6 +44,11 @@ HOSTCC := cc
>  endif
>  endif
>  
> +LLVM_CONFIG ?= @LLVM_CONFIG@
> +CLANG 	    ?= @CLANG@
> +CLANG_LIBS  ?= @CLANG_LIBS@
> +HAVE_CLANG_C_INDEX_H := @HAVE_CLANG_C_INDEX_H@
> +
>  AIO_LIBS		:= @AIO_LIBS@
>  CAP_LIBS		:= @CAP_LIBS@
>  ACL_LIBS		:= @ACL_LIBS@
> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> index 1d22f9c53..74f53e038 100644
> --- a/include/mk/env_post.mk
> +++ b/include/mk/env_post.mk
> @@ -89,6 +89,17 @@ $(error You must define $$(prefix) before executing install)
>  endif # END $(filter-out install,$(MAKECMDGOALS)),$(MAKECMDGOALS)
>  endif
>  
> +CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcard $(abs_srcdir)/*.c)))))
> +CHECK				?= $(abs_top_srcdir)/tools/clang-check/main
> +ifneq ($(strip $(CLANG)),":")
> +CHECK_FLAGS			?= -resource-dir $(shell $(CLANG) -print-resource-dir)
> +endif
> +
> +
> +ifeq ($(dir $(CHECK)),$(abs_top_srcdir)/tools/clang-check/)
> +CHECK_DEPS			+= $(CHECK)
> +endif
> +
>  include $(top_srcdir)/include/mk/rules.mk
>  
>  endif
> diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
> index 64953f89a..aa092a5a3 100644
> --- a/include/mk/generic_leaf_target.inc
> +++ b/include/mk/generic_leaf_target.inc
> @@ -92,7 +92,7 @@
>  # INSTALL_DIR			:= $(libdir)
>  #
>  
> -.PHONY: all clean install
> +.PHONY: all clean install check
>  
>  ifneq ($(strip $(MAKE_TARGETS)),)
>  $(MAKE_TARGETS) += $(HOST_MAKE_TARGETS)
> @@ -109,4 +109,7 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
>  
>  install: $(INSTALL_FILES)
>  
> +$(CHECK_TARGETS): | $(CHECK_DEPS)
> +check: $(CHECK_TARGETS)
> +
>  # vim: syntax=make
> diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> index fc59f944f..32a108fbf 100644
> --- a/include/mk/generic_trunk_target.inc
> +++ b/include/mk/generic_trunk_target.inc
> @@ -48,7 +48,7 @@
>  
>  include $(top_srcdir)/include/mk/functions.mk
>  
> -RECURSIVE_TARGETS		?= all install
> +RECURSIVE_TARGETS		?= all install check
>  
>  $(eval $(get_make_dirs))
>  
> @@ -68,6 +68,9 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
>  
>  trunk-install: $(INSTALL_FILES)
>  
> +$(CHECK_TARGETS): | $(CHECK_DEPS)
> +trunk-check: $(CHECK_TARGETS)
> +
>  # Avoid creating duplicate .PHONY references to all, clean, and install. IIRC,
>  # I've seen some indeterministic behavior when one does this in the past with
>  # GNU Make...
> @@ -108,4 +111,6 @@ else
>  endif
>  endif
>  
> +check: trunk-check
> +
>  # vim: syntax=make
> diff --git a/include/mk/lib.mk b/include/mk/lib.mk
> index f9b6c0aff..a3961bce5 100644
> --- a/include/mk/lib.mk
> +++ b/include/mk/lib.mk
> @@ -26,6 +26,7 @@
>  # Makefile to include for libraries.
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/clang-check.mk
>  
>  INSTALL_DIR	:= $(libdir)
>  
> @@ -57,6 +58,8 @@ LIBSRCS		:= $(filter-out $(FILTER_OUT_LIBSRCS),$(LIBSRCS))
>  
>  LIBOBJS		:= $(LIBSRCS:.c=.o)
>  
> +CHECK_TARGETS	:= $(addprefix check-,$(notdir $(LIBSRCS:.c=)))
> +
>  $(LIB): $(notdir $(LIBOBJS))
>  	@if [ -z "$(strip $^)" ] ; then \
>  		echo "Cowardly refusing to create empty archive"; \
> diff --git a/include/mk/rules.mk b/include/mk/rules.mk
> index c8f4bbbbe..2a04b2b67 100644
> --- a/include/mk/rules.mk
> +++ b/include/mk/rules.mk
> @@ -37,3 +37,12 @@ else
>  	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
>  	@echo CC $(target_rel_dir)$@
>  endif
> +
> +.PHONY: $(CHECK_TARGETS)
> +$(CHECK_TARGETS): check-%: %.c
> +ifdef VERBOSE
> +	$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
> +else
> +	@$(CHECK) $(CHECK_FLAGS) $(CPPFLAGS) $(CFLAGS) $<
> +	@echo CHECK $(target_rel_dir)$<
> +endif
> diff --git a/include/mk/testcases.mk b/include/mk/testcases.mk
> index 1c81773d0..e59899898 100644
> --- a/include/mk/testcases.mk
> +++ b/include/mk/testcases.mk
> @@ -22,6 +22,7 @@
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  include $(top_srcdir)/include/mk/functions.mk
> +include $(top_srcdir)/include/mk/clang-check.mk
>  
>  APICMDS_DIR	:= $(abs_top_builddir)/tools/apicmds
>  
> diff --git a/m4/ltp-clang.m4 b/m4/ltp-clang.m4
> new file mode 100644
> index 000000000..08314036b
> --- /dev/null
> +++ b/m4/ltp-clang.m4
> @@ -0,0 +1,29 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2021 SUSE LLC
> +
> +dnl Find the libraries and tools necessary to build tools/clang-check
> +
> +dnl Note that it is possible to use libclang without the clang
> +dnl executable or llvm-config. However it then means we have to start
> +dnl searching the system for various Clang resources.
> +
> +AC_DEFUN([LTP_CHECK_CLANG],
> +	[AC_CHECK_TOOL(LLVM_CONFIG, llvm-config, :)
> +	 AC_CHECK_TOOL(CLANG, clang, :)
> +	 ltp_save_CFLAGS=$CFLAGS
> +    	 ltp_save_LDFLAGS=$LDFLAGS
> +	 if test $LLVM_CONFIG != ":"; then
> +    	    CFLAGS=$($LLVM_CONFIG --cflags)
> +    	    LDFLAGS=$($LLVM_CONFIG --ldflags)
> +	 fi
> +	 AC_CHECK_LIB([clang], [clang_createIndex], [have_libclang=yes])
> +	 AC_CHECK_HEADERS([clang-c/Index.h], [have_clang_h=1])

Actually SUSE seems to be minority along distributions when it install
the llvm and clang headers into /usr/include/. It seems to be quite
common that the distribution allows to have more than one version of
clang installed at the same time which obviously breaks this detection.

We have to pass the output of llvm-config --includedir as the last
parameter to the AC_CHECK_HEADERS() so that the right path is searched.
I've seen at least /usr/lib/llvm/$VERSION/include and
/usr/lib/llvm-$VERSION/include but there may be more.

Also debian based derivatives also explicitly version the llvm-config,
so the binary is called llvm-config-6 or llvm-config-7 and there is no
default that would link llvm-config to the latest one, so we will have
to deal with this as well.

> +	 if test x$have_libclang != xyes -o x$have_clang_h != x1 -o "x$CLANG" = "x:"; then
> +	    AC_MSG_WARN(Libclang and Clang are needed for test development)
> +	 else
> +	    AC_SUBST(HAVE_CLANG_C_INDEX_H, $have_clang_h)
> +	    AC_SUBST(CLANG_LIBS, -lclang)
> +	 fi
> +	 CFLAGS=$ltp_save_CFLAGS
> +	 LDFLAGS=$ltp_save_LDFLAGS
> +])
> diff --git a/tools/clang-check/.gitignore b/tools/clang-check/.gitignore
> new file mode 100644
> index 000000000..ba2906d06
> --- /dev/null
> +++ b/tools/clang-check/.gitignore
> @@ -0,0 +1 @@
> +main
> diff --git a/tools/clang-check/Makefile b/tools/clang-check/Makefile
> new file mode 100644
> index 000000000..f5c4a9a78
> --- /dev/null
> +++ b/tools/clang-check/Makefile
> @@ -0,0 +1,35 @@
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
> +ifneq ($(strip $(LLVM_CONFIG)),":")
> +HOST_CFLAGS		+= $(shell $(LLVM_CONFIG) --cflags)
> +HOST_LDFLAGS		+= $(shell $(LLVM_CONFIG) --ldflags)
> +endif
> +HOST_LDLIBS 		+= $(CLANG_LIBS)
> +
> +.PHONY: check-clang-deps
> +check-clang-deps:
> +ifeq ($(strip $(CLANG)),":")
> +	$(warning clang-check: clang executable is missing which we use to find the Clang resource directory; install clang package)
> +endif
> +ifeq ($(strip $(LLVM_CONFIG)),":")
> +	$(warning clang-check: llvm-config is missing which we use to find the libclang location; install the clang/LLVM devel packages)
> +endif
> +ifeq ($(strip $(CLANG_LIBS)),)
> +	$(warning clang-check: libclang missing)
> +endif
> +ifneq ($(strip $(HAVE_CLANG_C_INDEX_H)),1)
> +	$(warning clang-check: clang development headers are missing; install the clang devel package)
> +endif
> +
> +MAKE_DEPS += check-clang-deps
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
