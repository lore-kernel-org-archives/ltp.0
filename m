From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Apr 2016 15:04:45 +0200
Subject: [LTP] [PATCH] testcases/kernel/include/lib.mk: re-order library
 link order
In-Reply-To: <0d998706a0a9c4c353f3aa31f2c1544007611714.1459758277.git.jstancek@redhat.com>
References: <0d998706a0a9c4c353f3aa31f2c1544007611714.1459758277.git.jstancek@redhat.com>
Message-ID: <20160406130445.GA10599@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
> index f79a1c0197e3..5c97ae2c9edf 100644
> --- a/testcases/kernel/include/lib.mk
> +++ b/testcases/kernel/include/lib.mk
> @@ -23,7 +23,7 @@ KERNEL_DIR		:= $(abs_top_builddir)/testcases/kernel
>  LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
>  LIBKERNTEST		:= $(LIBKERNTEST_DIR)/libkerntest.a
>  CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
> -LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
> +LDLIBS			+= -lkerntest -lltp $(NUMA_LIBS)

Looking at the libkerntest.a it uses numa library as well as ltp library
so it should passed be before them, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
