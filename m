Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rostedt@goodmis.org>) id 1WN2MQ-00075r-KX
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:43:26 +0000
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]
	helo=cdptpa-oedge-vip.email.rr.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WN2MP-00033P-N4
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 15:43:26 +0000
Date: Mon, 10 Mar 2014 11:27:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20140310112756.22f8a872@gandalf.local.home>
In-Reply-To: <20140310151744.GA14639@localhost.localdomain>
References: <531DC318.7060504@gmail.com>
	<20140310151744.GA14639@localhost.localdomain>
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
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Melo <acme@infradead.org>, Discussions <ltp-list@lists.sourceforge.net>, Arnaldo@suse.de, Kevin Hilman <khilman@linaro.org>, Namhyung Kim <namhyung@gmail.com>, Linux@suse.de, Darren Hart <darren@dvhart.com>, Johannes Berg <johannes@sipsolutions.net>, Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Mon, 10 Mar 2014 16:17:48 +0100
Frederic Weisbecker <fweisbec@gmail.com> wrote:


> On both cases you want to use trace events. So I'd rather suggest you to use perf tools
> or trace-cmd.
> 
> I believe that trace-cmd unfortunately uses per CPU periodic wake up on live
> recording CPUs so perhaps it's not a good candidate to test isolation. Too bad
> because kernelshark is cool for an overview.

Actually, it's not per-cpu. There's a thread per-cpu, but they do not
need to run on the CPU they monitor. Heck, you can have all threads on
just one CPU. Actually, they are not threads, they are forked children,
but you get the idea.

Now that I have wakeup working (with help of irq_work), I should also
be able to have them only wake if there's something to trace.


> 
> Also perf supports some script languages for post processing: python, perl, etc...
> I think trace-cmd too but rather for custom display of events.

Yeah, you can write python plugins that will change the display of the
output. I'm not sure about full integrating with python though.

> 
> Adding a few more people in Cc.

Me too.

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
