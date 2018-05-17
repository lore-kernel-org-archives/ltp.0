From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 May 2018 16:10:09 +0200
Subject: [LTP] [RFC PATCH v2 2/2] net/{stress,
 virt}: Use TST_TEST_DATA and TST_TEST_DATA_IFS
In-Reply-To: <20180516161820.3077-3-pvorel@suse.cz>
References: <20180516161820.3077-1-pvorel@suse.cz>
 <20180516161820.3077-3-pvorel@suse.cz>
Message-ID: <20180517141009.i5heg36deqgdcen6@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
> deleted file mode 100644
> index afa09373e..000000000
> --- a/lib/newlib_tests/Makefile
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -top_srcdir		?= ../..
> -
> -include $(top_srcdir)/include/mk/env_pre.mk
> -
> -CFLAGS			+= -W -Wall
> -LDLIBS			+= -lltp
> -
> -test08: CFLAGS+=-pthread
> -test09: CFLAGS+=-pthread
> -test15: CFLAGS+=-pthread
> -test16: CFLAGS+=-pthread
> -test16: LDLIBS+=-lrt
> -
> -ifeq ($(ANDROID),1)
> -FILTER_OUT_MAKE_TARGETS	+= test08
> -endif
> -
> -

This part is obviously added by accident, I'm sorry.


Kind regards,
Petr
