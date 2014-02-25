Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIHtR-0005iT-4P
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 13:17:53 +0000
Date: Tue, 25 Feb 2014 14:17:39 +0100
From: chrubis@suse.cz
Message-ID: <20140225131738.GA13201@rei>
References: <1392732510-25892-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392732510-25892-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] lib/test.h: add macro to declare init/cleanup
 functions
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
> Macro to use for making functions called only once in multi-threaded
> tests such as init or cleanup function.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/test.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index d46fdbf..78f13c2 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -111,6 +111,21 @@ pid_t tst_vfork(void);
>  #endif
>  
>  /*
> + * Macro to use for making functions called only once in
> + * multi-threaded tests such as init or cleanup function.
> + * The first call to @name_fn function by any thread shall
> + * call the @exec_fn. Subsequent calls shall not call @exec_fn.
> + * *_fn functions must not take any arguments.
> + */
> +#define DECLARE_ONCE_FN(name_fn, exec_fn)				\
> +	void name_fn(void)						\
> +	{								\
> +		static pthread_once_t name_fn##_ex = PTHREAD_ONCE_INIT;	\
> +		pthread_once(&name_fn##_ex, exec_fn);			\
> +	}
> +
> +
> +/*
>   * lib/forker.c
>   */
>  extern int Forker_pids[];

This is fine, although I would rather prefix the macro name with TST_ or
LTP_ and once the pthread_once_t variable is hidden from the global
namespace we don't have to prefix it with name_fn.

If you are OK with these changes, I can commit modified version right
away ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
