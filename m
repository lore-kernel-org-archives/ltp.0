Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDbsg-00049J-FR
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 15:37:46 +0000
Date: Wed, 12 Feb 2014 16:37:10 +0100
From: chrubis@suse.cz
Message-ID: <20140212153710.GA4905@rei.suse.cz>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2 2/4] lib/test.h: create macro to declare
 init/cleanup functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Use thread-safe versions of tst_res's functions if tests linked
> with pthread library.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/test.h |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index 29824d3..e3de278 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -1,6 +1,7 @@
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   * Copyright (c) 2009-2013 Cyril Hrubis chrubis@suse.cz
> + * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License as
> @@ -114,6 +115,36 @@
>  extern int Forker_pids[];
>  extern int Forker_npids;
>  
> +/*
> + * Macro to use for making functions called only once in
> + * multi-threaded tests such as init or cleanup function.
> + * The first call to @name_fn function by any thread shall
> + * call the @exec_fn. Subsequent calls shall not call @exec_fn.
> + * *_fn functions must not take any arguments.
> + */
> +#define DECLARE_ONCE_FN(name_fn, exec_fn)			\
> +	static pthread_once_t name_fn##_ex = PTHREAD_ONCE_INIT;	\
> +	void name_fn(void)					\
> +	{							\
> +		pthread_once(&name_fn##_ex, exec_fn);		\
> +	}

We can hide the pthread_once vairable from the global namespace by
putting it to the body of the function (because it's static).

> +/*
> + * Will be defined if test is compiled with -pthread.
> + * Then we can use thread-safe versions.
> + */
> +#ifdef _REENTRANT
> +#define tst_res			tst_res_r
> +#define tst_resm		tst_resm_r
> +#define tst_resm_hexd		tst_resm_hexd_r
> +#define tst_brk			tst_brk_r
> +#define tst_brkm		tst_brkm_r
> +#define tst_require_root	tst_require_root_r
> +#define tst_flush		tst_flush_r
> +#define tst_exit		tst_exit_r
> +#define tst_environ		tst_environ_r
> +#endif
> +

I would rather see this done in less hacky way. I'm thinking how, but
know of anything better for now.


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
