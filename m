From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 15:53:31 +0200
Subject: [LTP] [PATCH 1/1] realtime: Fix include for out-of-tree build
In-Reply-To: <20170329145120.1389-1-pvorel@suse.cz>
References: <20170329145120.1389-1-pvorel@suse.cz>
Message-ID: <20170330135331.GJ12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/realtime/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
> index 9a29ee7ce..71d73dd4b 100644
> --- a/testcases/realtime/lib/Makefile
> +++ b/testcases/realtime/lib/Makefile
> @@ -25,7 +25,7 @@ top_srcdir		?= ../../..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> -CFLAGS			+= -D_GNU_SOURCE -I../include/
> +CFLAGS			+= -D_GNU_SOURCE -I$(top_srcdir)/testcases/realtime/include/ -I$(top_builddir)/testcases/realtime/include/

I've fixed this line to be under 80 chars and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
