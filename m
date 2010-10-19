Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1P80O5-0001eO-S5
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 00:49:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P80O3-0001HM-PO
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 00:49:09 +0000
Message-ID: <4CBCEB1D.7010101@cn.fujitsu.com>
Date: Tue, 19 Oct 2010 08:49:33 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C85A88D.10700@cn.fujitsu.com>	
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>	
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>	
	<4CB55FE6.6000604@cn.fujitsu.com>
	<4CB5615C.4070406@cn.fujitsu.com>	
	<4CB59825.7060504@cn.fujitsu.com>	
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>	
	<4CBBBCB0.8070406@cn.fujitsu.com>
	<1287411903.16971.275.camel@gandalf.stny.rr.com>
In-Reply-To: <1287411903.16971.275.camel@gandalf.stny.rr.com>
Subject: Re: [LTP] BUG: dead loop in PowerPC hcall tracepoint (Was: [PATCH
 v2] Add ftrace-stress-test to LTP)
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>

Steven Rostedt wrote:
> On Mon, 2010-10-18 at 11:19 +0800, Li Zefan wrote:
> 
>> This is a dead loop:
>>
>> trace_hcall_entry() -> trace_clock_global() -> trace_hcall_entry() ..
>>
>> And this is a PPC specific bug. Hope some ppc guys will fix it?
>> Or we kill trace_clock_global() if no one actually uses it..
> 
> trace_clock_global() is used by many. I use it (and recommend using it)
> on boxes where the TSC is horribly out of sync, and the trace needs
> synchronization between CPUs.
> 
> The trace_hcall_entry and exit has wrappers already. Just add recursion
> protection there.
> 

Right, I thought of this. But as I have no machine to test, I'll leave
this to others.

> Perhaps something like this:
> 
> (Not compiled nor ran)
> 
> +static DEFINE_PER_CPU(hcall_trace_disable);
> +
>  void hcall_tracepoint_regfunc(void)
>  {
>  	hcall_tracepoint_refcount++;
>  }
> 
>  void hcall_tracepoint_unregfunc(void)
>  {
>  	hcall_tracepoint_refcount--;
>  }
> 
> +int __trace_disable_check(void)
> +{
> +	if (!hcall_tracepoint_refcount)
> +		return 1;
> +
> +	if (get_cpu_var(hcall_trace_disable)) {
> +		put_cpu_var(hcall_trace_disable);
> +		return 1;
> +	}
> +
> +	__get_cpu_var(hcall_trace_disable)++;
> +
> +	return 0;
> +}
> +
> +void __trace_disable_put(void)
> +{
> +	__get_cpu_var(hcall_trace_disable)--;
> +	put_cpu_var(hcall_trace_disable);
> +}
> +
>  void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
>  {
> +	int trace_disable;
> +
> +	if (__trace_disable_check())
> +		return;
> +
>  	trace_hcall_entry(opcode, args);
> +	__trace_disable_put();
>  }
> 
>  void __trace_hcall_exit(long opcode, unsigned long retval,
>  			unsigned long *retbuf)
>  {
> +	if (__trace_disable_check())
> +		return;
> +
>  	trace_hcall_exit(opcode, retval, retbuf);
> +	__trace_disable_put();
>  }
> 
> -- Steve
> 
> 
> 
> 

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
