Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS2S-0004a9-B9
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:44 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS2R-0001er-CX
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:44 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7nxLH022098
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:49:59 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB7vb57417862
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:57:37 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB7vZEG012392
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:36 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4CC13BB8.7090003@cn.fujitsu.com>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com>	<4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com> <20101021215212.4a982c85@kryten>
	<4CC13BB8.7090003@cn.fujitsu.com>
Date: Thu, 11 Nov 2010 13:27:16 +0530
Message-Id: <1289462236.5622.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] powerpc: Fix hcall tracepoint recursion
Reply-To: subrata@linux.vnet.ibm.com
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org

I tested and reported back the results. The patch works fine. Can you
please find out if it has been committed to Linus tree and if yes, then
the commit id please ?

Regards--
Subrata

On Fri, 2010-10-22 at 15:22 +0800, Li Zefan wrote: 
> Anton Blanchard wrote:
> > Hi,
> > 
> >> This is a dead loop:
> >>
> >> trace_hcall_entry() -> trace_clock_global() -> trace_hcall_entry() ..
> >>
> >> And this is a PPC specific bug. Hope some ppc guys will fix it?
> >> Or we kill trace_clock_global() if no one actually uses it..
> > 
> > Nasty! How does the patch below look? I had to disable irqs otherwise
> > we would sometimes drop valid events (if we take an interrupt anywhere
> > in the region where depth is elevated, then the entire interrupt will
> > be blocked from calling hcall tracepoints.
> > 
> 
> Thanks!
> 
> Subrata, could you test the patch below?
> 
> > Anton
> > --
> > 
> > Subject: [PATCH] powerpc: Fix hcall tracepoint recursion
> > 
> > Spinlocks on shared processor partitions use H_YIELD to notify the
> > hypervisor we are waiting on another virtual CPU. Unfortunately this means
> > the hcall tracepoints can recurse.
> > 
> > The patch below adds a percpu depth and checks it on both the entry and
> > exit hcall tracepoints.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > ---
> > 
> > Index: powerpc.git/arch/powerpc/platforms/pseries/lpar.c
> > ===================================================================
> > --- powerpc.git.orig/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:32:00.980003644 +1100
> > +++ powerpc.git/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:34:54.942681273 +1100
> > @@ -701,6 +701,13 @@ EXPORT_SYMBOL(arch_free_page);
> >  /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
> >  extern long hcall_tracepoint_refcount;
> >  
> > +/* 
> > + * Since the tracing code might execute hcalls we need to guard against
> > + * recursion. One example of this are spinlocks calling H_YIELD on
> > + * shared processor partitions.
> > + */
> > +static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
> > +
> >  void hcall_tracepoint_regfunc(void)
> >  {
> >  	hcall_tracepoint_refcount++;
> > @@ -713,12 +720,42 @@ void hcall_tracepoint_unregfunc(void)
> >  
> >  void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
> >  {
> > +	unsigned long flags;
> > +	unsigned int *depth;
> > +
> > +	local_irq_save(flags);
> > +
> > +	depth = &__get_cpu_var(hcall_trace_depth);
> > +
> > +	if (*depth)
> > +		goto out;
> > +
> > +	(*depth)++;
> >  	trace_hcall_entry(opcode, args);
> > +	(*depth)--;
> > +
> > +out:
> > +	local_irq_restore(flags);
> >  }
> >  
> >  void __trace_hcall_exit(long opcode, unsigned long retval,
> >  			unsigned long *retbuf)
> >  {
> > +	unsigned long flags;
> > +	unsigned int *depth;
> > +
> > +	local_irq_save(flags);
> > +
> > +	depth = &__get_cpu_var(hcall_trace_depth);
> > +
> > +	if (*depth)
> > +		goto out;
> > +
> > +	(*depth)++;
> >  	trace_hcall_exit(opcode, retval, retbuf);
> > +	(*depth)--;
> > +
> > +out:
> > +	local_irq_restore(flags);
> >  }
> >  #endif
> > 
> > 


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
