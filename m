Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rostedt@goodmis.org>) id 1P9IO4-0004zA-8i
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 14:14:28 +0000
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P9IO0-00084R-Ut
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 14:14:26 +0000
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20101021215212.4a982c85@kryten>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com> <4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com>  <20101021215212.4a982c85@kryten>
Date: Fri, 22 Oct 2010 10:14:16 -0400
Message-ID: <1287756856.16971.637.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] powerpc: Fix hcall tracepoint recursion
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
To: Anton Blanchard <anton@samba.org>
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>

On Thu, 2010-10-21 at 21:52 +1100, Anton Blanchard wrote:

> Anton
> --
> 
> Subject: [PATCH] powerpc: Fix hcall tracepoint recursion
> 
> Spinlocks on shared processor partitions use H_YIELD to notify the
> hypervisor we are waiting on another virtual CPU. Unfortunately this means
> the hcall tracepoints can recurse.
> 
> The patch below adds a percpu depth and checks it on both the entry and
> exit hcall tracepoints.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: powerpc.git/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:32:00.980003644 +1100
> +++ powerpc.git/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:34:54.942681273 +1100
> @@ -701,6 +701,13 @@ EXPORT_SYMBOL(arch_free_page);
>  /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
>  extern long hcall_tracepoint_refcount;
>  
> +/* 
> + * Since the tracing code might execute hcalls we need to guard against
> + * recursion. One example of this are spinlocks calling H_YIELD on
> + * shared processor partitions.
> + */
> +static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
> +
>  void hcall_tracepoint_regfunc(void)
>  {
>  	hcall_tracepoint_refcount++;
> @@ -713,12 +720,42 @@ void hcall_tracepoint_unregfunc(void)
>  
>  void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
>  {
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(hcall_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
>  	trace_hcall_entry(opcode, args);
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
>  }
>  
>  void __trace_hcall_exit(long opcode, unsigned long retval,
>  			unsigned long *retbuf)
>  {
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(hcall_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
>  	trace_hcall_exit(opcode, retval, retbuf);
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
>  }
>  #endif

That's similar to the example that I wrote, but without the encapsulated
code and with disabling interrupts for the reasons you gave.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
