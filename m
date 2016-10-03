From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Oct 2016 13:56:31 +0200
Subject: [LTP] [PATCH] Fix typos in assignments to the field tid
In-Reply-To: <1475493391-9643-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1475493391-9643-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161003115631.GB7583@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#ifdef HAVE_ATTR_XATTR_H
> -# include <attr/xattr.h>
> +#ifdef HAVE_SYS_XATTR_H
> +#include <sys/xattr.h>
> +#elif HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
>  #endif
>  
>  #include "tst_test.h"
>  
> -#ifdef HAVE_ATTR_XATTR_H
> +#if defined(HAVE_SYS_XATTR_H) || defined(HAVE_ATTR_XATTR_H)
>  
>  #define SECURITY_KEY	"security.ltptest"
>  #define VALUE	"test"
> @@ -89,7 +91,7 @@ static void setup(void)
>  }
>  
>  static struct tst_test test = {
> -	.tid = "llistxattr02",
> +	.tid = "llistxattr03",
>  	.needs_tmpdir = 1,
>  	.needs_root = 1,
>  	.test = verify_llistxattr,
> @@ -97,6 +99,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  };
>  
> -#else /* HAVE_ATTR_XATTR_H */
> -	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
> +#else /* HAVE_SYS_XATTR_H or HAVE_ATTR_XATTR_H */
> +	TST_TEST_TCONF("neither <sys/xattr.h> nor <attr/xattr.h> does not exist.");
>  #endif

I guess that this part took the changes from your xattr patch by
accident. Otherwise the patch is obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
