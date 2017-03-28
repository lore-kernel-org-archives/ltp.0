From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 28 Mar 2017 16:55:36 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170328100114.29730-1-chrubis@suse.cz>
References: <20170328100114.29730-1-chrubis@suse.cz>
Message-ID: <20170328165536.741d14e5@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Metan!

On Tue, 28 Mar 2017 12:01:14 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> This is proof of concept for building 32bit testcases on 64bit platform.

Great thanks! I have tried running it and have a couple of minor issues.

> 
> What we do is:
> 
> * Configure test if compiler supports -m32
>   TODO: Does 32bit compiler accept -m32?
>         If so, we should fail the test on 32bit
> 	platforms by default.
> 
> * The directory lib32 contains symlinks of minimal set of sources
>   needed to link newlib testcase + Makefile.

Apparently missing safe_socket which is required for cve-2016-4997.c, but that
is easy to fix I suppose.

> 
> * The testcases.mk builds 32bit library as well if
>   32bit compiler was installed (-m32 configure test was succesful)
> 
> * And finally the env_post.mk switches between lib and lib32 depeding
>   on if -m32 was passed in the CFLAGS

I added "cve-2016-4997: CFLAGS += -m32" and it still tried to look in
"../../lib"

> +ifeq ($(filter -m32,$(CFLAGS)),)
>  LDFLAGS				+= -L$(top_builddir)/lib
> +else
> +LDFLAGS				+= -L$(top_builddir)/lib32
> +endif

I was able to remove the if statement (i.e. put both dirs on the search path)
and the 64-bit tests still compiled fine and so did the 32-bit test, although
maybe not all linkers can be trusted to ignore libs with the wrong number of
bits.

Thank you,
Richard.
