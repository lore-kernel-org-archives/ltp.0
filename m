From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Feb 2018 23:24:20 +0100
Subject: [LTP] [PATCH] configure: Add knob to control tirpc support
In-Reply-To: <20180214120431.27677-1-anders.roxell@linaro.org>
References: <20180214120431.27677-1-anders.roxell@linaro.org>
Message-ID: <20180214222420.3pkscjyb32sdombp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Anders,

> Allow to disable tirpc from the top level.

> Based on patch:
> https://github.com/openembedded/openembedded-core/blob/master/meta/recipes-extended/ltp/ltp/0003-Add-knob-to-control-tirpc-support.patch

> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  configure.ac | 10 ++++++++++
>  1 file changed, 10 insertions(+)

> diff --git a/configure.ac b/configure.ac
> index da3374913..dc0c3d61e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -116,6 +116,14 @@ if test "x$with_python" = xyes; then
>  else
>      AC_SUBST([WITH_PYTHON],["no"])
>  fi
> +
> +# TI RPC
> +AC_ARG_WITH([tirpc],
> +  AC_HELP_STRING([--without-tirpc],
> +    [without libtirpc support (default=no)]),
> +  [with_tirpc=no],
> +  [with_tirpc=yes]
> +)
>  # END tools knobs

>  # Testsuites knobs
> @@ -189,7 +197,9 @@ LTP_CHECK_RENAMEAT2
>  LTP_CHECK_FALLOCATE
>  LTP_CHECK_SYSCALL_FCNTL
>  LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
> +if test "x$with_tirpc" = xyes; then
>  LTP_CHECK_TIRPC
> +fi
>  LTP_CHECK_TEE
>  LTP_CHECK_SPLICE
>  LTP_CHECK_VMSPLICE

Merged, thanks!


Kind regards,
Petr
