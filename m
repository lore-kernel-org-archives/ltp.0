From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 17:43:23 +0200
Subject: [LTP] [RFC PATCH v2 5/7] m4: Fix libcrypto detection on 32-bit
 cross build
In-Reply-To: <20171009110101.3329-6-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <20171009110101.3329-6-pvorel@suse.cz>
Message-ID: <20171009154322.GG25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/configure.ac b/configure.ac
> index 4eb61e070..89647ba17 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,22 +32,23 @@ AC_PREFIX_DEFAULT(/opt/ltp)
>  
>  AC_CHECK_HEADERS([ \
>      ifaddrs.h \
> -    libaio.h \
> -    mm.h \
> -    pthread.h \
> -    sys/xattr.h \
>      keyutils.h \
> +    libaio.h \
>      linux/can.h \
>      linux/genetlink.h \
>      linux/keyctl.h \
>      linux/mempolicy.h \
>      linux/module.h \
>      linux/netlink.h \
> +    mm.h \
> +    openssl/sha.h \
> +    pthread.h \
>      sys/acl.h \
>      sys/epoll.h \
> -    sys/inotify.h \
>      sys/fanotify.h \
> +    sys/inotify.h \
>      sys/prctl.h \
> +    sys/xattr.h \
>  ])

Can we sort these in a separate patch please?

>  # Tools knobs
> diff --git a/m4/ltp-crypto.m4 b/m4/ltp-crypto.m4
> index 3dfc51266..d066ab7e0 100644
> --- a/m4/ltp-crypto.m4
> +++ b/m4/ltp-crypto.m4
> @@ -2,8 +2,10 @@ dnl
>  dnl LTP_CHECK_CRYPTO
>  dnl ----------------------------
>  dnl
> -AC_DEFUN([LTP_CHECK_CRYPTO],
> -[dnl
> -AC_CHECK_HEADERS(openssl/sha.h,[CRYPTO_LIBS=-lcrypto],[CRYPTO_LIBS=])
> -AC_SUBST(CRYPTO_LIBS)
> +AC_DEFUN([LTP_CHECK_CRYPTO], [
> +	AC_CHECK_LIB([crypto], [SHA1_Init], [crypto_libs="-lcrypto"])
> +	AC_SUBST([CRYPTO_LIBS], [$crypto_libs])
> +	if test "x$have_libnuma" != "x"; then
                   ^
		   Typo?
> +		AC_DEFINE(HAVE_LIBCRYPTO,1,[define whether libcrypto is installed])
> +	fi
>  ])
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index f67eb684b..9f500553c 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -29,6 +29,8 @@
>  #include <openssl/sha.h>
>  #endif
>  
> +#if HAVE_LIBCRYPTO && HAVE_OPENSSL_SHA_H

I wonder if we have to use both here, I guess that it's safer that way.
But it would be cleaner if we changed the m4 checks not to set
HAVE_LIBCRYPTO if either of the AC_CHECK_LIB() or AC_CHECK_HEADER() have
failed.

-- 
Cyril Hrubis
chrubis@suse.cz
