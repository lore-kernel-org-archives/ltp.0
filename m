From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 17:29:50 +0200
Subject: [LTP] [RFC PATCH v2 2/7] m4: Fix libacl detection on 32-bit
 cross build
In-Reply-To: <20171009110101.3329-3-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <20171009110101.3329-3-pvorel@suse.cz>
Message-ID: <20171009152950.GE25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  configure.ac  | 1 +
>  m4/ltp-acl.m4 | 7 +++----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 0bae6ce3f..e9c61ef78 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -41,6 +41,7 @@ AC_CHECK_HEADERS([ \
>      linux/mempolicy.h \
>      linux/module.h \
>      linux/netlink.h \
> +    sys/acl.h \
>      sys/epoll.h \
>      sys/inotify.h \
>      sys/fanotify.h \
> diff --git a/m4/ltp-acl.m4 b/m4/ltp-acl.m4
> index 6b739346b..789fabe0b 100644
> --- a/m4/ltp-acl.m4
> +++ b/m4/ltp-acl.m4
> @@ -23,8 +23,7 @@ dnl LTP_CHECK_ACL_SUPPORT
>  dnl ----------------------------
>  dnl
>  AC_DEFUN([LTP_CHECK_ACL_SUPPORT],[
> -AH_TEMPLATE(HAVE_LIBACL,
> -[Define to 1 if you have libacl installed.])
> -AC_CHECK_HEADERS([sys/acl.h], [acl_libs="-lacl"])
> -AC_SUBST([ACL_LIBS], [$acl_libs])
> +	AH_TEMPLATE(HAVE_LIBACL, [Define to 1 if you have libacl installed.])
> +	AC_CHECK_LIB([acl], [acl_init], [acl_libs="-lacl"])
> +	AC_SUBST([ACL_LIBS], [$acl_libs])
>  ])

The acl1.c ifdefs around HAVE_SYS_ACL_H, we should make use of
HAVE_LIBACL there instead otherwise it's still broken, right?

Also we should do something as AC_DEFINE(HAVE_LIBACL, ...) in the
AC_CHECK_LIB() and we may also drop the header check.

I guess that we should do something as:

AC_CHECK_LIB([acl], [acl_init],
             [AC_DEFINE(HAVE_LIBACL, 1, "Define to 1 if you have libacl installed"),
	      AC_SUBST(ACL_LIBS, "-lacl)])

Per all libraries, so that we would end up with HAVE_LIBACL to be used
in #ifdefs in C code and with ACL_LIBS to be used in Makefiles. We have
to do both to avoid compilation failures.

We would have to keep a few check for headers though, since we do have a
few checks for HAVE_FOO_H in the include/lapi/ headers that turn on/off
fallback definitions.

-- 
Cyril Hrubis
chrubis@suse.cz
