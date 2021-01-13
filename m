From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 17:30:52 +0800
Subject: [LTP] [PATCH 1/1] autoconf: Use pkg-config for keyutils
 detection
In-Reply-To: <20210111123626.28932-1-pvorel@suse.cz>
References: <20210111123626.28932-1-pvorel@suse.cz>
Message-ID: <5FFEBDCC.6020102@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/11 20:36, Petr Vorel wrote:
> Using pkg-config is less error prone during cross compilation.
Hi Petr,

Is there any detailed example about the above point?

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> if you agree with this, I'll replace (probably after release) ACL_LIBS,
> CAP_LIBS, CRYPTO_LIBS, SELINUX_LIBS (to follow libmnl and libtirpc).
It is OK for me.

Best Regards,
Xiao Yang
> libaio and libnuma does not support pkg-config.
>
> Tested: https://travis-ci.org/github/pevik/ltp/builds/753925166
>
> Kind regards,
> Petr
>
>  configure.ac                                   |  2 +-
>  include/mk/config.mk.in                        |  6 +++---
>  m4/ltp-keyutils.m4                             | 10 ----------
>  m4/ltp-libkeyutils.m4                          |  8 ++++++++
>  testcases/cve/Makefile                         |  2 +-
>  testcases/kernel/syscalls/add_key/Makefile     |  2 +-
>  testcases/kernel/syscalls/keyctl/Makefile      |  2 +-
>  testcases/kernel/syscalls/request_key/Makefile |  2 +-
>  8 files changed, 16 insertions(+), 18 deletions(-)
>  delete mode 100644 m4/ltp-keyutils.m4
>  create mode 100644 m4/ltp-libkeyutils.m4
>
> diff --git a/configure.ac b/configure.ac
> index 06be1c094..8d667eb1e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -328,7 +328,7 @@ LTP_CHECK_CLONE_SUPPORTS_7_ARGS
>  LTP_CHECK_CRYPTO
>  LTP_CHECK_FORTIFY_SOURCE
>  LTP_CHECK_KERNEL_DEVEL
> -LTP_CHECK_KEYUTILS_SUPPORT
> +LTP_CHECK_LIBKEYUTILS
>  LTP_CHECK_LIBMNL
>  LTP_CHECK_LINUX_PTRACE
>  LTP_CHECK_LINUXRANDOM
> diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
> index 218447ef3..382b7fda2 100644
> --- a/include/mk/config.mk.in
> +++ b/include/mk/config.mk.in
> @@ -52,12 +52,12 @@ LEXLIB			:= @LEXLIB@
>  NUMA_LIBS		:= @NUMA_LIBS@
>  SELINUX_LIBS		:= @SELINUX_LIBS@
>  HAVE_RPC		:= @HAVE_RPC@
> -LIBTIRPC_CFLAGS		:= @LIBTIRPC_CFLAGS@
> -LIBTIRPC_LIBS		:= @LIBTIRPC_LIBS@
> -KEYUTILS_LIBS		:= @KEYUTILS_LIBS@
>  HAVE_FTS_H		:= @HAVE_FTS_H@
> +LIBKEYUTILS_LIBS	:= @LIBKEYUTILS_LIBS@
>  LIBMNL_LIBS		:= @LIBMNL_LIBS@
>  LIBMNL_CFLAGS		:= @LIBMNL_CFLAGS@
> +LIBTIRPC_CFLAGS		:= @LIBTIRPC_CFLAGS@
> +LIBTIRPC_LIBS		:= @LIBTIRPC_LIBS@
>  
>  prefix			:= @prefix@
>  
> diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
> deleted file mode 100644
> index 451c549f3..000000000
> --- a/m4/ltp-keyutils.m4
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2016 Fujitsu Ltd.
> -dnl Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> -dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -
> -AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> -	AC_CHECK_LIB([keyutils], [add_key],
> -	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
> -	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
> -])
> diff --git a/m4/ltp-libkeyutils.m4 b/m4/ltp-libkeyutils.m4
> new file mode 100644
> index 000000000..f5d128969
> --- /dev/null
> +++ b/m4/ltp-libkeyutils.m4
> @@ -0,0 +1,8 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +AC_DEFUN([LTP_CHECK_LIBKEYUTILS], [
> +    PKG_CHECK_MODULES([LIBKEYUTILS], [libkeyutils], [
> +        AC_DEFINE([HAVE_LIBKEYUTILS], [1], [Define to 1 if you have libkeyutils library and headers])
> +	], [have_libkeyutils=no])
> +])
> diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
> index da44fff60..90921dd85 100644
> --- a/testcases/cve/Makefile
> +++ b/testcases/cve/Makefile
> @@ -21,7 +21,7 @@ CFLAGS			+= -D_GNU_SOURCE
>  
>  stack_clash:	CFLAGS += -fno-optimize-sibling-calls
>  
> -cve-2016-7042:	LDLIBS += $(KEYUTILS_LIBS)
> +cve-2016-7042:	LDLIBS += $(LIBKEYUTILS_LIBS)
>  
>  cve-2016-7117:	CFLAGS += -pthread
>  cve-2016-7117:	LDLIBS += -lrt
> diff --git a/testcases/kernel/syscalls/add_key/Makefile b/testcases/kernel/syscalls/add_key/Makefile
> index 0f51e0bc2..6c2102247 100644
> --- a/testcases/kernel/syscalls/add_key/Makefile
> +++ b/testcases/kernel/syscalls/add_key/Makefile
> @@ -5,6 +5,6 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -LDLIBS  += $(KEYUTILS_LIBS)
> +LDLIBS  += $(LIBKEYUTILS_LIBS)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/keyctl/Makefile b/testcases/kernel/syscalls/keyctl/Makefile
> index 180ece25a..343c5e359 100644
> --- a/testcases/kernel/syscalls/keyctl/Makefile
> +++ b/testcases/kernel/syscalls/keyctl/Makefile
> @@ -5,7 +5,7 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -LDLIBS	+= $(KEYUTILS_LIBS)
> +LDLIBS	+= $(LIBKEYUTILS_LIBS)
>  keyctl02: LDLIBS	+= -lpthread
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
> index 58a99875e..e69774b96 100644
> --- a/testcases/kernel/syscalls/request_key/Makefile
> +++ b/testcases/kernel/syscalls/request_key/Makefile
> @@ -6,6 +6,6 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -LDLIBS		+= $(KEYUTILS_LIBS)
> +LDLIBS		+= $(LIBKEYUTILS_LIBS)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk



