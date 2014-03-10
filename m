Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fweisbec@gmail.com>) id 1WN1xr-0006c3-BA
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:18:03 +0000
Received: from mail-ee0-f42.google.com ([74.125.83.42])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WN1xq-0000RQ-8w
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:18:03 +0000
Received: by mail-ee0-f42.google.com with SMTP id d17so3178607eek.29
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Mar 2014 08:17:56 -0700 (PDT)
Date: Mon, 10 Mar 2014 16:17:48 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
Message-ID: <20140310151744.GA14639@localhost.localdomain>
References: <531DC318.7060504@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <531DC318.7060504@gmail.com>
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
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>, Kevin Hilman <khilman@linaro.org>, Namhyung Kim <namhyung@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Mar 10, 2014 at 02:50:16PM +0100, Mats Liljegren wrote:
> My company (Enea) wants to create test case(s) that verifies that
> you can run an application without having ticks going on the CPU
> that the application runs on. This would utilize the new nohz_full
> feature available from kernel version 3.10.

Ah nice!

> 
> I cannot find any existing test case in LTP in this area, so I
> assume I have to create the test case myself.
> 
> One catch is that the current nohz_full implementation actually
> generates 1Hz. So part of the test could be to verify that we
> actually get 1Hz rather than full tick speed. It would also be
> possible to support the experimental patch from Kevin Hilman to
> actually turn ticks off for real. The test code code check whether
> the patch is applied and based on it expect 0Hz or 1Hz ticks.
> 
> Would LTP be a good place for such tests?

If that can be of any help, you can have a look at this:
https://git.kernel.org/cgit/linux/kernel/git/frederic/dynticks-testing.git/

It's selftest that setup some isolation configuration, run a userspace loop for
a few seconds and records various trace events like timers, workqueue, etc...

So it's not automatically telling if a CPU runs full dynticks, some analysis from
a user on the traces is required.

Now it's fairly possible to write a small test that tells if the CPU noise
is reduced to strict 1 Hz timer and nothing else. But that alone wouldn't
provide safe guarantees because workqueues of whatever timer may happen
anytime.

In really depends on your usecase. Do you want your CPU not be disturbed in
order to maximize its throughput? That's the HPC case. There you can cope with a few
noise from time to time. Then such a test would be relevant.

Now if you have latency requirement, which means having a tick or workqueue or
anything disturbing you CPU would screw up everything then you're rather
on the side of real time and then you need guarantee. For such a case
I'd rather suggest live monitoring of trace events.

So there is two possibilities:

1) Show that the CPU runs in full dynticks for a given timeslice.

2) Monitoring events through the whole timeslices.

On both cases you want to use trace events. So I'd rather suggest you to use perf tools
or trace-cmd.

I believe that trace-cmd unfortunately uses per CPU periodic wake up on live
recording CPUs so perhaps it's not a good candidate to test isolation. Too bad
because kernelshark is cool for an overview.

Also perf supports some script languages for post processing: python, perl, etc...
I think trace-cmd too but rather for custom display of events.

Adding a few more people in Cc.

> 
> Regards
> Mats Liljegren

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
