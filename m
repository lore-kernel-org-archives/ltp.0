From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Mar 2019 23:37:33 +0100
Subject: [LTP] [PATCH v2] autodetect fts support and tests depending on
	it
In-Reply-To: <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
References: <20190318181940.GA5494@dell5510>
 <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20190320223733.GA5619@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vineet,

> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  configure.ac                          | 1 +
>  testcases/kernel/controllers/Makefile | 6 ++++++
>  2 files changed, 7 insertions(+)

> diff --git a/configure.ac b/configure.ac
> index e002c248eab2..10b2f6b1e43b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -33,6 +33,7 @@ AC_PROG_YACC
>  AC_PREFIX_DEFAULT(/opt/ltp)

>  AC_CHECK_HEADERS([ \
> +    fts.h \
>      ifaddrs.h \
>      keyutils.h \
>      linux/can.h \
> diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
> index 404073947904..a1626ae03695 100644
> --- a/testcases/kernel/controllers/Makefile
> +++ b/testcases/kernel/controllers/Makefile
> @@ -29,6 +29,12 @@ LIBDIR			:= libcontrollers
>  LIB			:= $(LIBDIR)/libcontrollers.a
>  FILTER_OUT_DIRS		:= $(LIBDIR)

> +# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
> +# which may not be available/configured in the libc build
> +ifndef HAVE_FTS_H
> +FILTER_OUT_DIRS	+= cpuset
> +endif
Have you tested it? This will not work as HAVE_LIBAIO_H is in include/config.h,
thus only for C. For Makefile it must be done via autotools (search for AC_SUBST
in m4/). I thought TST_TEST_TCONF usage, but you're right, that problematic
source is part of libcontrollers.a (i.e. part of a library, not normal C
binary).


Kind regards,
Petr
