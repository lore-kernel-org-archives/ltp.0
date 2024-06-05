Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB4FC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717585313; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=N7mvl3G8WtIpEjbCZ714mczVU6F9DBS9DcbXKttcgew=;
 b=oJu82fjmaXiBqw0d8VQPnsVGmd6Pl5+yLDHKg/CRgFqmCTV3L/h+xD42tJ1fe+WIrrLK6
 quy1aUYJbh7Yv/VMAN7OFX4aLHpTSxqJCyR8uSwyiqF914H6DI4y/ZwLAL0Bbb/qJP6Bm49
 ja/WYwCkkWtkO2vzpadi89dKwpOJmqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8123D098D
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:01:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58C7F3CFFBF
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:01:31 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FDBB14098BD
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:01:30 +0200 (CEST)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so61212441fa.0
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717585289; x=1718190089; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FJQrood3IZNlyAFQMXJifz0LDqbsRlyb5xVf1jSta0g=;
 b=TSsYEEeX36gu8IayqdWlL/0Hzjpeexrz+LJRRioEZlr45UoV15DVLIoAIuMoQ+ob2L
 Eyp5aGAySs0L3oXIlsQ+ypx2KyBuZjUKtBW4oLw5+ZhFRGkNz8NFNHaXggNtvS3y8Faa
 IHlT6n5S4E2lqga8gJq8i1BsjH5+4nhVt8EE5VXg4Ggsu29RcsAKwFs6Kp99bOZaWggK
 LMuVBTVQ3ffAWYM6rEWJF0LMdehANwV9sl9ZEYR3JwOzwkpm0kWlk8JpQRbTs+/BrxH7
 Hvb3uYDjA2dQVX8aqnldWpBO3RXS0uRidA0fvbyeVVs1/t+Z9gJhYHJ6oJdcL2ManpYW
 GU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717585289; x=1718190089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJQrood3IZNlyAFQMXJifz0LDqbsRlyb5xVf1jSta0g=;
 b=lSfKW9Lx/bwO57wfgTiO1oOBjS5odZXRVPOebjuJ7nX7SHPEUdfqBE8NXkhnQhTN+A
 k8X3onR7Q5bvVLhAD7XpdcUNvi4GLprg+CD39U/Kc5DWEJ7yr6KWBjpESJ5z2oBEcCJ1
 5VGsAU9+Q//7g6fhQPXwbux/wFXqNNa9BfzSQFerlRnC1tEDRfyk7P6qgAwu+tumMrym
 4K16ZhQzIVLmz7pG4IUmD5M/cYELNAB8bvyxV9N69kmsV3QK8+N7ZHw7G9pyGgbRg4lO
 lhnt641OWhY1ThUJ9Dc8jkFscyIs/5kmltZAPT8t9c0+e/4mxEg4NzA0xhYetaTV5b/U
 qdLA==
X-Gm-Message-State: AOJu0YyMuBaQb5UVqqFiO6m/uP0oJ46NesR1GmC7O9takzpumoWpWaTM
 ghESxMpLCqm7jlhy8u2FQ4rhBPcgFGBvNMmdL6wmOBHyVpqv2WQGzvjkN0NQlkINjM7Wk1Eglva
 z6uY=
X-Google-Smtp-Source: AGHT+IGH6ARTgNQZGxEtI3uGd3tm9abfuDPCheuVjrxHNUP8FKZZjmqn2deGVgoB7OMr54zemHtdWw==
X-Received: by 2002:a05:651c:a11:b0:2df:b0e3:b548 with SMTP id
 38308e7fff4ca-2eac7a52b32mr13810611fa.42.1717585289187; 
 Wed, 05 Jun 2024 04:01:29 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.36.118])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c7b73sm8401964b3a.31.2024.06.05.04.01.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:01:28 -0700 (PDT)
Message-ID: <7c0c90ca-bdc0-4693-80e9-75c13f2fe6ba@suse.com>
Date: Wed, 5 Jun 2024 13:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240605104512.18296-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240605104512.18296-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] testcases: realtime: Get rid of autotools
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

LGTM. Thanks for cleaning up autotools

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 6/5/24 12:45, Cyril Hrubis wrote:
> The autotools checks are outdated and not needed anymore.
>
> CC: John Stultz <jstultz@google.com>
> CC: Darren Hart <darren@os.amperecomputing.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>
> Changes in v2:
>
> Removed realtime from mk/automake.mk as well.
>
> CI run https://github.com/metan-ucw/ltp/actions/runs/9382597033
>
>   include/mk/automake.mk                 |  5 --
>   testcases/realtime/Makefile            | 64 +-------------------------
>   testcases/realtime/configure.ac        | 42 -----------------
>   testcases/realtime/include/librttest.h |  9 +---
>   testcases/realtime/lib/libstats.c      |  6 ---
>   testcases/realtime/m4/.gitignore       |  1 -
>   testcases/realtime/m4/GNUmakefile      | 37 ---------------
>   testcases/realtime/m4/Makefile.am      |  1 -
>   testcases/realtime/m4/check.m4         | 14 ------
>   9 files changed, 2 insertions(+), 177 deletions(-)
>   delete mode 100644 testcases/realtime/configure.ac
>   delete mode 100644 testcases/realtime/m4/.gitignore
>   delete mode 100644 testcases/realtime/m4/GNUmakefile
>   delete mode 100644 testcases/realtime/m4/Makefile.am
>   delete mode 100644 testcases/realtime/m4/check.m4
>
> diff --git a/include/mk/automake.mk b/include/mk/automake.mk
> index 3ecdd3144..0fa059f11 100644
> --- a/include/mk/automake.mk
> +++ b/include/mk/automake.mk
> @@ -27,15 +27,10 @@ AUTOHEADER	?= autoheader
>   AUTOMAKE	?= automake
>   
>   AUTOCONFED_SUBDIRS	= \
> -			testcases/realtime \
>   			testcases/open_posix_testsuite
>   
>   # We want to run this every single time to ensure that all of the prereq files
>   # are there.
> -.PHONY: testcases/realtime/configure
> -testcases/realtime/configure:
> -	$(MAKE) -C $(@D) autotools
> -
>   .PHONY: testcases/open_posix_testsuite/configure
>   testcases/open_posix_testsuite/configure:
>   	$(MAKE) -C $(@D) autotools
> diff --git a/testcases/realtime/Makefile b/testcases/realtime/Makefile
> index 61663bfd9..b90ecf8c4 100644
> --- a/testcases/realtime/Makefile
> +++ b/testcases/realtime/Makefile
> @@ -22,74 +22,12 @@
>   
>   top_srcdir		?= ../..
>   
> -# Override these variables to use non-system available tools.
> -ACLOCAL			?= aclocal
> -AUTOCONF		?= autoconf
> -AUTOHEADER		?= autoheader
> -AUTOMAKE		?= automake
> -
>   include $(top_srcdir)/include/mk/env_pre.mk
> -# Ensure that this error / warning only applies for build targets.
> -#
> -# NOTE (garrcoop): this criterium should be in-sync with include/mk/env_pre.mk
> -# (minus help as that's only invoked in the top-level Makefile).
> -ifeq ($(filter autotools %clean .gitignore gitignore.%,$(MAKECMDGOALS)),)
> -include $(abs_srcdir)/config.mk
> -endif
>   
>   LIBDIR			:= lib
> -FILTER_OUT_DIRS		:= $(LIBDIR) m4
> +FILTER_OUT_DIRS		:= $(LIBDIR)
>   LIB			:= $(LIBDIR)/librealtime.a
>   
> -# START autotools junk
> -AUTOGENERATED_FILES	= \
> -			m4/Makefile
> -
> -AUTOMAKE_FILES := config.guess config.sub install-sh missing stamp-h1
> -
> -.PHONY: autotools aclocal autoconf autoheader automake
> -autotools: aclocal autoconf autoheader automake
> -
> -.PHONY: ac-clean ac-distclean ac-maintainer-clean
> -ac-clean::
> -	$(RM) -rf autom4te.cache
> -	$(RM) -f aclocal.m4 config.log config.status
> -	$(RM) -f include/realtime_config.h include/stamp-h1
> -
> -ac-distclean:: ac-clean
> -ac-maintainer-clean:: ac-distclean
> -	$(RM) -f aclocal.m4 configure $(AUTOMAKE_FILES) m4/Makefile.in
> -	$(RM) -f include/realtime_config.h.in
> -
> -aclocal.m4:
> -	$(ACLOCAL) -I $(abs_srcdir)/m4
> -
> -autoconf: configure
> -
> -include/realtime_config.h.in: configure.ac $(wildcard m4/*.m4) aclocal.m4
> -	$(AUTOHEADER)
> -
> -configure: configure.ac aclocal.m4
> -	$(AUTOCONF)
> -automake: $(AUTOMAKE_FILES)
> -$(AUTOMAKE_FILES): m4/Makefile.in
> -m4/Makefile.in: m4/Makefile.am aclocal.m4
> -	$(AUTOMAKE) -c -a
> -
> -.PHONY: autoheader
> -autoheader: include/realtime_config.h.in
> -	$(AUTOHEADER)
> -
> -distclean:: %: clean ac-distclean
> -	$(RM) -f $(AUTOGENERATED_FILES)
> -
> -maintainer-clean:: distclean ac-maintainer-clean
> -
> -$(AUTOGENERATED_FILES): $(top_builddir)/config.status
> -	$(SHELL) $^
> -
> -# END autotools junk
> -
>   $(LIBDIR):
>   	mkdir -p "$@"
>   
> diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
> deleted file mode 100644
> index 6f50f1490..000000000
> --- a/testcases/realtime/configure.ac
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -AC_PREREQ(2.61)
> -AC_INIT([realtime],[realtime-20090930],[ltp-results@lists.sourceforge.net])
> -AC_CONFIG_AUX_DIR([.])
> -AM_INIT_AUTOMAKE
> -AC_CONFIG_HEADERS([include/realtime_config.h])
> -AC_CONFIG_FILES([   \
> -	m4/Makefile \
> -])
> -AC_CHECK_HEADERS_ONCE([ \
> -	pthread.h \
> -])
> -AC_CANONICAL_HOST
> -
> -AC_PROG_CC
> -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
> -# 2.62.
> -AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
> -AC_PROG_AR
> -AC_PROG_RANLIB
> -
> -AC_MSG_CHECKING([for __sync_add_and_fetch gcc builtin function])
> -AC_LINK_IFELSE([AC_LANG_SOURCE([
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -#include <stdlib.h>
> -int main(void) {
> -	char *c;
> -	return __sync_add_and_fetch(c, 1);
> -}])],[has___sync_add_and_fetch=yes])
> -if test "x$has___sync_add_and_fetch" = xyes; then
> -	AC_DEFINE(HAVE___SYNC_ADD_AND_FETCH,1,[Define to 1 if you have the __sync_add_and_fetch gcc builtin function])
> -	AC_MSG_RESULT(yes)
> -else
> -	AC_MSG_RESULT(no)
> -fi
> -
> -AC_CHECK_LIB([m], [exp10], [AC_DEFINE([HAVE_EXP10], 1, [Define to 1 if you have exp10 function])])
> -
> -REALTIME_CHECK_PRIO_INHERIT
> -
> -AC_OUTPUT
> diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
> index 8e3421869..8733479e7 100644
> --- a/testcases/realtime/include/librttest.h
> +++ b/testcases/realtime/include/librttest.h
> @@ -56,7 +56,6 @@
>   #include <time.h>
>   #include <unistd.h>
>   #include "list.h"
> -#include "realtime_config.h"
>   
>   extern void setup(void);
>   extern void cleanup(int i);
> @@ -113,15 +112,9 @@ extern double pass_criteria;
>    */
>   static inline int atomic_add(int i, atomic_t *v)
>   {
> -	/* XXX (garrcoop): only available in later versions of gcc */
> -#if HAVE___SYNC_ADD_AND_FETCH
>   	return __sync_add_and_fetch(&v->counter, i);
> -#else
> -	printf("%s: %s\n", __func__, strerror(ENOSYS));
> -	exit(1);
> -	return -1;
> -#endif
>   }
> +
>   /* atomic_inc: atomically increment the integer passed by reference
>    */
>   static inline int atomic_inc(atomic_t *v)
> diff --git a/testcases/realtime/lib/libstats.c b/testcases/realtime/lib/libstats.c
> index f12d618f4..96090bd15 100644
> --- a/testcases/realtime/lib/libstats.c
> +++ b/testcases/realtime/lib/libstats.c
> @@ -46,12 +46,6 @@
>   #include <libstats.h>
>   #include <librttest.h>
>   
> -#include "../include/realtime_config.h"
> -
> -#ifndef HAVE_EXP10
> -# define exp10(x) (exp((x) * log(10)))
> -#endif
> -
>   int save_stats = 0;
>   
>   /* static helper functions */
> diff --git a/testcases/realtime/m4/.gitignore b/testcases/realtime/m4/.gitignore
> deleted file mode 100644
> index 5fc607b9e..000000000
> --- a/testcases/realtime/m4/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -/Makefile
> diff --git a/testcases/realtime/m4/GNUmakefile b/testcases/realtime/m4/GNUmakefile
> deleted file mode 100644
> index 2a5b4c613..000000000
> --- a/testcases/realtime/m4/GNUmakefile
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -#
> -#    m4 Makefile.
> -#
> -#    Copyright (C) 2009, Cisco Systems Inc.
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -# Ngie Cooper, July 2009
> -#
> -
> -top_srcdir		?= ../../..
> -
> -include $(top_srcdir)/include/mk/env_pre.mk
> -
> -M4MACROS		:= $(notdir $(wildcard *.m4))
> -
> -INSTALL_DIR		:= $(datarootdir)/aclocal
> -
> -INSTALL_MODE		:= 00644
> -
> -INSTALL_TARGETS		:= $(M4_MACROS)
> -
> -MAKE_TARGETS		:=
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/realtime/m4/Makefile.am b/testcases/realtime/m4/Makefile.am
> deleted file mode 100644
> index 87c304b42..000000000
> --- a/testcases/realtime/m4/Makefile.am
> +++ /dev/null
> @@ -1 +0,0 @@
> -# bogus makefile to appease automake
> diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
> deleted file mode 100644
> index d04a2cc73..000000000
> --- a/testcases/realtime/m4/check.m4
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
> -AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
> -AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> -#include <pthread.h>]], [[int main(void) {
> -	pthread_mutexattr_t attr;
> -	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
> -}]])],[has_priority_inherit="yes"],[])
> -if test "x$has_priority_inherit" = "xyes" ; then
> -	AC_DEFINE(HAS_PRIORITY_INHERIT,1,[Define to 1 if you have PTHREAD_PRIO_INHERIT])
> -	AC_MSG_RESULT(yes)
> -else
> -	AC_MSG_RESULT(no)
> -fi
> -])



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
