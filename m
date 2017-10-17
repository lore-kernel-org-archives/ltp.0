From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Oct 2017 14:42:42 +0200
Subject: [LTP] [PATCH v4 03/14] m4: Fix libkeyutils detection on 32-bit
 cross build
In-Reply-To: <20171016154205.4814-4-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
 <20171016154205.4814-4-pvorel@suse.cz>
Message-ID: <20171017124242.GA8823@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
> +	AC_CHECK_LIB([keyutils], [add_key],
> +	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.]),
                                                                                         ^
						I've removed this comma
						otherwise it tries to
						execute command ','
						during the configure
						run.

The [] is actually quotation not an array so the macros in [] are not
separated by commas, only the macro parameters are.

> +	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
>  ])

And I've pushed the patchset up to this patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
