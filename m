From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 17:06:26 +0200
Subject: [LTP] [RFC PATCH v2 1/7] m4: Fix libkeyutils detection on
 32-bit cross build
In-Reply-To: <20171009110101.3329-2-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <20171009110101.3329-2-pvorel@suse.cz>
Message-ID: <20171009150626.GD25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac       | 1 +
>  m4/ltp-keyutils.m4 | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 458a5b13f..0bae6ce3f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
>      mm.h \
>      pthread.h \
>      sys/xattr.h \
> +    keyutils.h \
>      linux/genetlink.h \
>      linux/mempolicy.h \
>      linux/module.h \
> diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
> index 74b7d3249..1434ca823 100644
> --- a/m4/ltp-keyutils.m4
> +++ b/m4/ltp-keyutils.m4
> @@ -18,7 +18,7 @@ dnl
>  dnl LTP_CHECK_KEYUTILS_SUPPORT
>  dnl ----------------------------
>  dnl
> -AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT],[
> -AC_CHECK_HEADERS([keyutils.h], [keyutils_libs="-lkeyutils"])
> -AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
> +AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> +	AC_CHECK_LIB([keyutils], [add_key], [keyutils_libs="-lkeyutils"])
> +	AC_SUBST([KEYUTILS_LIBS], [$keyutils_libs])
>  ])

Okay, this fixes most of the problems, but the request_key tests are
still broken as far as I can tell. Since these use #ifdef
HAVE_KEYUTILS_H, which will still fail if 64bit library is present but
not the 32bit one, right? I suppose that it fails with missing symbols
for add_key() and request_key().

Afaik these should be converted to make use of the lapi/keyctl.h header
just like the add_key tests, right? Or did I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz
