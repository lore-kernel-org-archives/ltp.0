From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Jun 2021 15:03:33 +0200
Subject: [LTP] [PATCH 1/1] newlib_tests: Fix build dependency on lib
In-Reply-To: <20210610125229.24140-1-pvorel@suse.cz>
References: <20210610125229.24140-1-pvorel@suse.cz>
Message-ID: <YMINpZkS4j3bhN9O@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> this fixes build error:
> 
> $ cd lib && make clean && cd newlib_tests && make
> ld: cannot find -lltp
> 
> Fixes: bbdb9f783 ("lib: Add new test library API")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/newlib_tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
> index 30ca6810c..a263d7db5 100644
> --- a/lib/newlib_tests/Makefile
> +++ b/lib/newlib_tests/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  top_srcdir		?= ../..
>  
> -include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/testcases.mk

Ah right, this adds dependency on the library and builds it if needed.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Btw the lib/tests/ subdirectory has the same problem, but I'm not sure
if we care enough to fix that...

-- 
Cyril Hrubis
chrubis@suse.cz
