From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Mar 2018 11:39:34 +0100
Subject: [LTP] [RFC PATCH 1/1] rpc: Use libtirpc instead of Sun RPC from
 glib
In-Reply-To: <20180305205804.20720-1-pvorel@suse.cz>
References: <20180305205804.20720-1-pvorel@suse.cz>
Message-ID: <20180306103933.GB16934@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/network/Makefile b/testcases/network/Makefile
> index 69901a718..f7097e164 100644
> --- a/testcases/network/Makefile
> +++ b/testcases/network/Makefile
> @@ -39,6 +39,10 @@ ifeq ($(ANDROID),1)
>  FILTER_OUT_DIRS		+= lib6 rpc sockets
>  endif
>  
> +ifeq ($(TIRPC_LIBS),)
> +FILTER_OUT_DIRS		+= rpc
> +endif

I do not get why we are moving the FILTER_OUT_DIRS one level up here.
I'm not saying it's wrong but changes like that should be at least
explained in the commit message.

>  $(INSTALL_TARGETS): | generate
>  
>  .PHONY: generate
> diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
> index e6c377736..ea36f8ad3 100644
> --- a/testcases/network/rpc/Makefile
> +++ b/testcases/network/rpc/Makefile
> @@ -25,9 +25,6 @@ top_srcdir		?= ../../..
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
>  INSTALL_TARGETS		:= *.sh
> -
> -ifeq ($(TIRPC_LIBS),)
> -FILTER_OUT_DIRS		+= rpc-tirpc
> -endif
> +LDLIBS		+= $(TIRPC_LIBS)

Isn't this added in the Makefile.inc?


The rest of the patchset looks obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
