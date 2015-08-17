Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZRJrO-0006uB-6F
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 12:49:54 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRJrL-0005pu-8X
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 12:49:54 +0000
Date: Mon, 17 Aug 2015 08:49:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <980148897.10916298.1439815783172.JavaMail.zimbra@redhat.com>
In-Reply-To: <1439813598-11524-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1439813598-11524-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] ltp_rt_sigaction: SPARC fixes for -O0
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
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Monday, 17 August, 2015 2:13:17 PM
> Subject: [LTP] [PATCH 1/2] ltp_rt_sigaction: SPARC fixes for -O0
> 
> The *sigreturn_stub functions are copied from glibc, and they
> work only if optimization > 0, since they expect that the compiler
> does not add an epilogue.

Isn't that prologue?
Other than that it looks good to me, ACK.

Regards,
Jan

> 
> For example, with -O > 0:
> 
> 0000000000102140 <__rt_sigreturn_stub>:
>   102140:       82 10 20 65     mov  0x65, %g1  ! 65 <_init-0x101f23>
>   102144:       91 d0 20 6d     ta  0x6d
>   102148:       81 c3 e0 08     retl
>   10214c:       01 00 00 00     nop
> 
> but without -O:
> 
> 000000000010212c <__rt_sigreturn_stub>:
>   10212c:       9d e3 bf 50     save  %sp, -176, %sp  <--- this
>   102130:       82 10 20 65     mov  0x65, %g1
>   102134:       91 d0 20 6d     ta  0x6d
>   102138:       81 cf e0 08     rett  %i7 + 8
>   10213c:       01 00 00 00     nop
> 
> Therefore, if we build LTP with OPT_CFLAGS="", ltp_rt_sigaction() will
> malfunction.
> 
> To avoid this, let's declare a new symbol pointing to the instruction we
> need ('mov ...').
> 
> The trick was proposed by Jose E. Marchesi <jose.marchesi@oracle.com>.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/lapi/rt_sigaction.h |   20 ++++++++++++--------
>  1 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
> index 46f6a50..f99c372 100644
> --- a/include/lapi/rt_sigaction.h
> +++ b/include/lapi/rt_sigaction.h
> @@ -105,12 +105,14 @@ static inline int sig_initial(int sig)
>  # if defined __arch64__ || defined __sparcv9
>  
>  /*
> - * From glibc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
> + * Based on glibc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
>   */
>  
> +extern char *__rt_sig_stub;
> +
>  static void __rt_sigreturn_stub(void)
>  {
> -	__asm__ ("mov %0, %%g1\n\t"
> +	__asm__ ("__rt_sig_stub: mov %0, %%g1\n\t"
>  		"ta  0x6d\n\t"
>  		: /* no outputs */
>  		: "i" (__NR_rt_sigreturn));
> @@ -119,12 +121,14 @@ static void __rt_sigreturn_stub(void)
>  # else /* sparc32 */
>  
>  /*
> - * From glibc/sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
> + * Based on glibc/sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
>   */
>  
> +extern char *__rt_sig_stub, *__sig_stub;
> +
>  static void __rt_sigreturn_stub(void)
>  {
> -	__asm__ ("mov %0, %%g1\n\t"
> +	__asm__ ("__rt_sig_stub: mov %0, %%g1\n\t"
>  		"ta  0x10\n\t"
>  		: /* no outputs */
>  		: "i" (__NR_rt_sigreturn));
> @@ -132,7 +136,7 @@ static void __rt_sigreturn_stub(void)
>  
>  static void __sigreturn_stub(void)
>  {
> -	__asm__ ("mov %0, %%g1\n\t"
> +	__asm__ ("__sig_stub: mov %0, %%g1\n\t"
>  		"ta  0x10\n\t"
>  		: /* no outputs */
>  		: "i" (__NR_sigreturn));
> @@ -181,12 +185,12 @@ static int ltp_rt_sigaction(int signum, const struct
> sigaction *act,
>  #ifdef __sparc__
>  	unsigned long stub = 0;
>  # if defined __arch64__ || defined __sparcv9
> -	stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
> +	stub = ((unsigned long) &__rt_sig_stub) - 8;
>  # else /* sparc32 */
>  	if ((kact.sa_flags & SA_SIGINFO) != 0)
> -		stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
> +		stub = ((unsigned long) &__rt_sig_stub) - 8;
>  	else
> -		stub = ((unsigned long) &__sigreturn_stub) - 8;
> +		stub = ((unsigned long) &__sig_stub) - 8;
>  # endif
>  #endif
>  
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
