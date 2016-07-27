From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 12:22:18 +0200
Subject: [LTP] [PATCH V3 11/23] lapi: Use sig_t instead of sighandler_t
In-Reply-To: <20160722042656.22346-11-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-11-raj.khem@gmail.com>
Message-ID: <20160727102218.GC10903@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/rt_sigsuspend/Makefile
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
> @@ -19,4 +19,5 @@
>  top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

Again this added newline is unintended change that should not have been
part of this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
