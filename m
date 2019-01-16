From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 16 Jan 2019 17:04:33 +0800
Subject: [LTP] [PATCH] openposix/20-1-buildonly,
 signal_h_23-1: Fix compiler errors on newer glibc
In-Reply-To: <1545304294-31111-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1545304294-31111-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <5C3EF3A1.30503@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

Ping.  :-)

I also fix the wrong version of _POSIX_C_SOURCE in bsd_signal(3) manpage, as below:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=8eb09b1283be57333e7c6223080e7449479b7677

Best Regards,
Xiao Yang

On 2018/12/20 19:11, Xiao Yang wrote:
> Since glibc 2.26, the __USE_XOPEN2K8 macro defined by _POSIX_C_SOURCE = 200809L&&
> _XOPEN_SOURCE = 700 resulted in the following compiler errors, because both sigstack
> structure and bsd_signal function are only declared if __USE_XOPEN_EXTENDED is
> defined and __USE_XOPEN2K8 is not defined:
> -------------------------------------------------------------------------------
> 20-1-buildonly.c:13:8: error: invalid use of undefined type ‘struct sigstack’
>    sp = t.ss_sp;
> ...
> signal_h/23-1.c:15:13: error: ‘bsd_signal’ undeclared (first use in this function); did you mean ‘psignal’?
>    dummyvar = bsd_signal;
> -------------------------------------------------------------------------------
>
> We just use _POSIX_C_SOURCE = 200112L&&  _XOPEN_SOURCE = 600 to run these tests.
>
> References:
> https://sourceware.org/git/?p=glibc.git;a=commit;h=666c0c5efa6db73632a6894bf028fef9f3b60d71
> https://sourceware.org/git/?p=glibc.git;a=commit;h=4c3992fc459322a7c712700ba3244fcb125163d7
>
> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> ---
>   .../conformance/definitions/signal_h/20-1-buildonly.c              | 7 +++++++
>   .../open_posix_testsuite/conformance/definitions/signal_h/23-1.c   | 7 +++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c b/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c
> index 21d8cb4..fdb2fb8 100644
> --- a/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c
> +++ b/testcases/open_posix_testsuite/conformance/definitions/signal_h/20-1-buildonly.c
> @@ -2,6 +2,13 @@
>        Test the definition of sigstack.
>      */
>
> +#if _POSIX_C_SOURCE>= 200809L
> +# undef _POSIX_C_SOURCE
> +# undef _XOPEN_SOURCE
> +# define _POSIX_C_SOURCE	200112L
> +# define _XOPEN_SOURCE		600
> +#endif
> +
>   #include<signal.h>
>
>   struct sigstack this_type_should_exist, t;
> diff --git a/testcases/open_posix_testsuite/conformance/definitions/signal_h/23-1.c b/testcases/open_posix_testsuite/conformance/definitions/signal_h/23-1.c
> index 9a4d200..4f22e07 100644
> --- a/testcases/open_posix_testsuite/conformance/definitions/signal_h/23-1.c
> +++ b/testcases/open_posix_testsuite/conformance/definitions/signal_h/23-1.c
> @@ -5,6 +5,13 @@
>        is declared.
>      */
>
> +#if _POSIX_C_SOURCE>= 200809L
> +# undef _POSIX_C_SOURCE
> +# undef _XOPEN_SOURCE
> +# define _POSIX_C_SOURCE	200112L
> +# define _XOPEN_SOURCE		600
> +#endif
> +
>   #include<signal.h>
>
>   typedef void (*(*bsd_signal_test) (int, void (*)(int))) (int);



