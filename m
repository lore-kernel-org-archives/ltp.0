Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liljegren.mats2@gmail.com>) id 1WNK0w-0004jj-9X
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 10:34:26 +0000
Received: from mail-ea0-f173.google.com ([209.85.215.173])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WNK0v-0000OO-6e
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 10:34:26 +0000
Received: by mail-ea0-f173.google.com with SMTP id r15so4251659ead.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Mar 2014 03:34:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140310151744.GA14639@localhost.localdomain>
References: <531DC318.7060504@gmail.com>
	<20140310151744.GA14639@localhost.localdomain>
Date: Tue, 11 Mar 2014 11:34:18 +0100
Message-ID: <CA+xJJ185QEmdxQD9ptKQA2PxzkSkamO2kRvqXa-hrmDMLx9zKQ@mail.gmail.com>
From: Mats Liljegren <liljegren.mats2@gmail.com>
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
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>, Kevin Hilman <khilman@linaro.org>, Namhyung Kim <namhyung@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Mar 10, 2014 at 4:17 PM, Frederic Weisbecker <fweisbec@gmail.com> wrote:
> On Mon, Mar 10, 2014 at 02:50:16PM +0100, Mats Liljegren wrote:
>> My company (Enea) wants to create test case(s) that verifies that
>> you can run an application without having ticks going on the CPU
>> that the application runs on. This would utilize the new nohz_full
>> feature available from kernel version 3.10.
>
> Ah nice!
>
>>
>> I cannot find any existing test case in LTP in this area, so I
>> assume I have to create the test case myself.
>>
>> One catch is that the current nohz_full implementation actually
>> generates 1Hz. So part of the test could be to verify that we
>> actually get 1Hz rather than full tick speed. It would also be
>> possible to support the experimental patch from Kevin Hilman to
>> actually turn ticks off for real. The test code code check whether
>> the patch is applied and based on it expect 0Hz or 1Hz ticks.
>>
>> Would LTP be a good place for such tests?
>
> If that can be of any help, you can have a look at this:
> https://git.kernel.org/cgit/linux/kernel/git/frederic/dynticks-testing.git/

I'll check that and see if I get some inspiration. Thanks!

> It's selftest that setup some isolation configuration, run a userspace loop for
> a few seconds and records various trace events like timers, workqueue, etc...
>
> So it's not automatically telling if a CPU runs full dynticks, some analysis from
> a user on the traces is required.
>
> Now it's fairly possible to write a small test that tells if the CPU noise
> is reduced to strict 1 Hz timer and nothing else. But that alone wouldn't
> provide safe guarantees because workqueues of whatever timer may happen
> anytime.

My naive first attempt would be something in this area. Count the
ticks that occurred, compare with the expected number of ticks for the
duration of the test, and report PASS/FAIL.

Not sure how to handle queued up work though. Running long enough
might be running for longer than anybody wants to wait for the
result...

> In really depends on your usecase. Do you want your CPU not be disturbed in
> order to maximize its throughput? That's the HPC case. There you can cope with a few
> noise from time to time. Then such a test would be relevant.

Working for a company doing RTOS products, I'd say we're more for the
real-time aspects. What kind of real-time is another, but very
interesting, question.

> Now if you have latency requirement, which means having a tick or workqueue or
> anything disturbing you CPU would screw up everything then you're rather
> on the side of real time and then you need guarantee. For such a case
> I'd rather suggest live monitoring of trace events.
>
> So there is two possibilities:
>
> 1) Show that the CPU runs in full dynticks for a given timeslice.
>
> 2) Monitoring events through the whole timeslices.
>
> On both cases you want to use trace events. So I'd rather suggest you to use perf tools
> or trace-cmd.

I have given the "correct" way of counting ticks some thought, but I
haven't come to a good conclusion. My current best bet is using
function tracing on scheduler_tick(). It seems to be the most
configuration and architecture independent way. But I'm not entirely
sure it really is just one call for each tick. If you have better
suggestions, I'd love to hear about it.

> I believe that trace-cmd unfortunately uses per CPU periodic wake up on live
> recording CPUs so perhaps it's not a good candidate to test isolation. Too bad
> because kernelshark is cool for an overview.

I've invented a "count_ticks" script which hides ftrace complexity on
other interesting ways than trace_cmd does. It logs calls to
scheduler_tick during a command execution, and goes through this log
afterwards counting the calls.

> Also perf supports some script languages for post processing: python, perl, etc...
> I think trace-cmd too but rather for custom display of events.

While debugging is nice too, my first step is to just get something
that can say PASS/FAIL, with some information about why it failed
(e.g. because x ticks occurred that was not expected). Nothing more
fancy than that.

Regards
Mats Liljegren

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
