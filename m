From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Feb 2016 15:14:40 +0100
Subject: [LTP] [PATCH V2 03/32] Add knob to control tirpc support
In-Reply-To: <1452302060-103643-3-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-3-git-send-email-raj.khem@gmail.com>
Message-ID: <20160203141440.GG30788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/configure.ac b/configure.ac
> index cc50397..9e2936b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -98,6 +98,13 @@ if test "x$with_python" = xyes; then
>  else
>      AC_SUBST([WITH_PYTHON],["no"])
>  fi
> +
> +# TI RPC
> +AC_ARG_WITH([tirpc],
> +  AC_HELP_STRING([--without-tirpc],
> +    [without libtirpc support]),
> +  [],[with_tirpc=yes],
> +)
>  # END tools knobs

This should be done in the corresponding m4 file as well.

-- 
Cyril Hrubis
chrubis@suse.cz
