From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Nov 2019 11:24:46 +0800
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <20191113104149.42407-1-lkml@jv-coder.de>
References: <20191113104149.42407-1-lkml@jv-coder.de>
Message-ID: <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 13, 2019 at 6:42 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> The usage of AC_ARG_WITH was wrong. This resulted in unexpected
> configuration.
> E.g --without-bash set with_bash=yes and --with-nume set with_numa=no.
> This is fixed by using "$withval" in the action-if-given. Also all
> AC_ARG_WITH
> are unified now (all use alos action-if-not-given)
>
> The "default=" help text did not make sense for same options.
> e.g. for --with expect was "default=yes", but it defaults to no.
> The "default=" strings are dropped, because defaultness is indicated by
> either "--with-<option>" or "--without-<option>" as done by other projects,
> that use autoconf.
>
> Defining AC_ARG_WITH within an if to express dependencies does not work.
> ./configure --with-realtime-testsuite set with_realtime_testsuite=yes,
> even if with_bash=no or with_python=no. The check is removed completely.
>

I think this patch makes sense. It follows the AC_ARG_WITH official usage,
and make use of the shell variable 'withval' is also a wise choice.

Just a few queries below:


>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>  configure.ac | 46 ++++++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 62c5a0bb4..4b7c6d57c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -108,8 +108,9 @@ AC_CHECK_FUNCS([ \
>  # Expect
>  AC_ARG_WITH([bash],
>    [AC_HELP_STRING([--with-bash],
> -    [have the Bourne Again SHell interpreter (default=no)])],
> -  [with_bash=yes],
> +    [have the Bourne Again Shell interpreter])],
> +  [with_bash=$withval],
> +  [with_bash=no]
>  )
>  if test "x$with_bash" = xyes; then
>      AC_SUBST([WITH_BASH],["yes"])
> @@ -119,8 +120,8 @@ fi
>
>  AC_ARG_WITH([expect],
>    [AC_HELP_STRING([--with-expect],
> -    [have the Tcl/expect library (default=yes)])],
> -  [with_expect=yes],
> +    [have the Tcl/expect library])],
> +  [with_expect=$withval],
>    [with_expect=no]
>

From the original intention, it likely to set yes as the default, so maybe
the [action-if-not-given] should as  [with_expect=yes]?


>  )
>  if test "x$with_expect" = xyes; then
> @@ -132,16 +133,16 @@ fi
>  # Numa
>  AC_ARG_WITH([numa],
>    AC_HELP_STRING([--without-numa],
> -    [without numa support (default=no)]),
> -  [with_numa=no],
> +    [without numa support]),
> +  [with_numa=$withval],
>    [with_numa=yes]
>  )
>
>  # Perl
>  AC_ARG_WITH([perl],
>    [AC_HELP_STRING([--with-perl],
> -    [have a perl interpreter (default=yes)])],
> -  [with_perl=yes],
> +    [have a perl interpreter])],
> +  [with_perl=$withval],
>    [with_perl=no]
>

[with_perl=yes] ?


>  )
>  if test "x$with_perl" = xyes; then
> @@ -153,8 +154,8 @@ fi
>  # Python
>  AC_ARG_WITH([python],
>    [AC_HELP_STRING([--with-python],
> -    [have a python interpreter (default=yes)])],
> -  [with_python=yes],
> +    [have a python interpreter])],
> +  [with_python=$withval],
>    [with_python=no]
>

[with_python=yes] ?


>  )
>  if test "x$with_python" = xyes; then
> @@ -166,8 +167,8 @@ fi
>  # TI RPC
>  AC_ARG_WITH([tirpc],
>    AC_HELP_STRING([--without-tirpc],
> -    [without libtirpc support (default=no)]),
> -  [with_tirpc=no],
> +    [without libtirpc support]),
> +  [with_tirpc=$withval],
>    [with_tirpc=yes]
>  )
>  # END tools knobs
> @@ -176,8 +177,9 @@ AC_ARG_WITH([tirpc],
>
>  AC_ARG_WITH([open-posix-testsuite],
>    [AC_HELP_STRING([--with-open-posix-testsuite],
> -    [compile and install the open posix testsuite (default=no)])],
> -  [with_open_posix_testsuite=$withval]
> +    [compile and install the open posix testsuite])],
> +  [with_open_posix_testsuite=$withval],
> +  [with_open_posix_testsuite=no]
>  )
>  if test "x$with_open_posix_testsuite" = xyes; then
>      AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["yes"])
> @@ -185,14 +187,14 @@ else
>      AC_SUBST([WITH_OPEN_POSIX_TESTSUITE],["no"])
>  fi
>
> -# testcases/realtime requires bash and python.
> -if test "x$with_bash" = xyes && test "x$with_python" = xyes; then
> -    AC_ARG_WITH([realtime-testsuite],
> -      [AC_HELP_STRING([--with-realtime-testsuite],
> -        [compile and install the realtime testsuite (default=no)])],
> -      [with_realtime_testsuite=yes]
> -    )
> -fi
> +# TODO: testcases/realtime requires bash and python.
>

Why remove the judgment of bash/python here?


> +AC_ARG_WITH([realtime-testsuite],
> +  [AC_HELP_STRING([--with-realtime-testsuite],
> +    [compile and install the realtime testsuite])],
> +  [with_realtime_testsuite=$withval],
> +  [with_realtime_testsuite=no]
> +)
> +
>  if test "x$with_realtime_testsuite" = xyes; then
>      AC_SUBST([WITH_REALTIME_TESTSUITE],["yes"])
>      # Run configure on testcases/realtime as well.
> --
> 2.20.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191114/25ab7b46/attachment-0001.htm>
