From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jun 2018 14:35:20 +0200
Subject: [LTP] [RFC PATCH 9/9] syscalls/ipc: Fix Makefile
In-Reply-To: <20180612154631.435-10-chrubis@suse.cz>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-10-chrubis@suse.cz>
Message-ID: <20180613123519.2t6upag4kmcfvfwq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Switch to new ipc library now that all testcases are rewritten.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---

I've noticed, that some commits from this patchset aren't bisectable, due
dependency on new library (libnewipc.h).
IMHO it's worth of fixing it.


Kind regards,
Petr

>  testcases/kernel/syscalls/ipc/msgctl/Makefile | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

> diff --git a/testcases/kernel/syscalls/ipc/msgctl/Makefile b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> index 4472eeb1c..f9ee8d2c2 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/Makefile
> +++ b/testcases/kernel/syscalls/ipc/msgctl/Makefile
> @@ -19,11 +19,5 @@
>  top_srcdir              ?= ../../../../..

>  include $(top_srcdir)/include/mk/testcases.mk
> -
> -LIBMSGCTL               := $(LIBDIR)/libmsgctl.a
> -LDLIBS                  += -lmsgctl
> -
> -MAKE_DEPS               := $(LIBMSGCTL)
> -
> -include $(abs_srcdir)/../Makefile.inc
> +include $(abs_srcdir)/../Makefile2.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
