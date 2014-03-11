Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rostedt@goodmis.org>) id 1WNW9I-0001Qs-24
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 23:31:52 +0000
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]
	helo=cdptpa-oedge-vip.email.rr.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WNW9F-00058m-Ls
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 23:31:52 +0000
Date: Tue, 11 Mar 2014 19:31:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20140311193142.6f2db96e@gandalf.local.home>
In-Reply-To: <CA+xJJ185QEmdxQD9ptKQA2PxzkSkamO2kRvqXa-hrmDMLx9zKQ@mail.gmail.com>
References: <531DC318.7060504@gmail.com>
	<20140310151744.GA14639@localhost.localdomain>
	<CA+xJJ185QEmdxQD9ptKQA2PxzkSkamO2kRvqXa-hrmDMLx9zKQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] Testing absence of ticks with nohz_full
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
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: Melo <acme@infradead.org>, Discussions <ltp-list@lists.sourceforge.net>, Arnaldo@suse.de, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, Namhyung Kim <namhyung@gmail.com>, Linux@suse.de, Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Tue, 11 Mar 2014 11:34:18 +0100
Mats Liljegren <liljegren.mats2@gmail.com> wrote:


> I have given the "correct" way of counting ticks some thought, but I
> haven't come to a good conclusion. My current best bet is using
> function tracing on scheduler_tick(). It seems to be the most
> configuration and architecture independent way. But I'm not entirely
> sure it really is just one call for each tick. If you have better
> suggestions, I'd love to hear about it.

Try this:

 echo 1 > /sys/kernel/debug/tracing/max_graph_depth
 echo function_graph > /sys/kernel/debug/tracing/current_tracer

If CPU 5 is the one running with nohz, then monitor:

 /sys/kernel/debug/tracing/per_cpu/cpu5/trace_pipe

And see what goes into the kernel.

The "max_graph_depth" is the max depth the function_graph tracer should
trace. By saying "1", you are telling it to give you the first function
it sees, but ignore all the rest. I specifically implemented this
because I thought it would be a great way to see what interrupts user
tasks.

Now if the user task does a syscall, you will only see that and not any
tick that happened when the syscall was running. But you don't care
about that anyway ;-)

> 
> > I believe that trace-cmd unfortunately uses per CPU periodic wake up on live
> > recording CPUs so perhaps it's not a good candidate to test isolation. Too bad
> > because kernelshark is cool for an overview.
> 
> I've invented a "count_ticks" script which hides ftrace complexity on
> other interesting ways than trace_cmd does. It logs calls to
> scheduler_tick during a command execution, and goes through this log
> afterwards counting the calls.
> 
> > Also perf supports some script languages for post processing: python, perl, etc...
> > I think trace-cmd too but rather for custom display of events.
> 
> While debugging is nice too, my first step is to just get something
> that can say PASS/FAIL, with some information about why it failed
> (e.g. because x ticks occurred that was not expected). Nothing more
> fancy than that.

I have scripts that test things like this. Not this exactly. All they
are are bash scripts that read the trace file output and does simple
parsing to see what happened during the test. And at the end, it simply
says "PASS" or "FAIL".

-- Steve


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
