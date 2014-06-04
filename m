Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WsDRv-0005lZ-SE
	for ltp-list@lists.sourceforge.net; Wed, 04 Jun 2014 15:49:59 +0000
Date: Wed, 4 Jun 2014 17:49:39 +0200
From: chrubis@suse.cz
Message-ID: <20140604154939.GA7913@rei>
References: <20140520144246.GA30023@rei.suse.cz>
	<1400667887-5188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400667887-5188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 3/3] ltp_rt_sigaction: added SPARC support
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Based on patches by Jose E. Marchesi <jose.marchesi@oracle.com>.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/ltp_signal.h |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/include/ltp_signal.h b/include/ltp_signal.h
> index 31bb0b0..a60ee7c 100644
> --- a/include/ltp_signal.h
> +++ b/include/ltp_signal.h
> @@ -122,6 +122,46 @@ static inline int sig_initial(int sig)
>  
>  #endif /* __x86_64__ */
>  
> +#ifdef __sparc__
> +#if defined __arch64__ || defined __sparcv9

It's a bit more readable if we indent the innter ifdefs as:

#ifdef __sparc__
# if defined __arch64__ || defined __sparcv9

# endif
#endif /* __sparc__ */

> +/*
> + * From glibc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
> + */
> +
> +static void __rt_sigreturn_stub(void)
> +{
> +	__asm__ ("mov %0, %%g1\n\t"
> +		"ta  0x6d\n\t"
> +		: /* no outputs */
> +		: "i" (__NR_rt_sigreturn));
> +}
> +
> +#else /* sparc32 */
> +
> +/*
> + * From glibc/sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
> + */
> +
> +static void __rt_sigreturn_stub(void)
> +{
> +	__asm__ ("mov %0, %%g1\n\t"
> +		"ta  0x10\n\t"
> +		: /* no outputs */
> +		: "i" (__NR_rt_sigreturn));
> +}
> +
> +static void __sigreturn_stub(void)
> +{
> +	__asm__ ("mov %0, %%g1\n\t"
> +		"ta  0x10\n\t"
> +		: /* no outputs */
> +		: "i" (__NR_sigreturn));
> +}
> +
> +#endif
> +#endif /* __sparc__ */
> +
>  /* This is a wrapper for __NR_rt_sigaction syscall.
>   * act/oact values of INVAL_SA_PTR is used to pass
>   * an invalid pointer to syscall(__NR_rt_sigaction)
> @@ -159,9 +199,28 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
>  	kact.sa_restorer = restore_rt;
>  #endif
>  
> +#ifdef __sparc__
> +	unsigned long stub = 0;
> +# if defined __arch64__ || defined __sparcv9
> +	stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
> +# else /* sparc32 */
> +	if ((kact.sa_flags & SA_SIGINFO) != 0)
> +		stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
> +	else
> +		stub = ((unsigned long) &__sigreturn_stub) - 8;
> +# endif
> +#endif

Here they are intended correctly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
