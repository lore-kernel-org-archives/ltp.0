Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseNY-0003m1-8q
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:08 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseNT-0004xq-7y
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:08 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o86G4tBC021019
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 10:04:55 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o86GGvZk212642
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 10:16:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o86GGu1T003230
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Sep 2010 10:16:57 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTi=+8rsbAtHg=N+RCBqDH2W6xD+NVWdXScyJH2Mc@mail.gmail.com>
References: <4C73452A.3020006@cn.fujitsu.com>
	<1282647771.4833.10.camel@subratamodak.linux.ibm.com>
	<4C7470FC.4090800@cn.fujitsu.com>
	<AANLkTi=+8rsbAtHg=N+RCBqDH2W6xD+NVWdXScyJH2Mc@mail.gmail.com>
Date: Mon, 06 Sep 2010 21:46:40 +0530
Message-Id: <1283789802.4947.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add ftrace-stress-test to LTP
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

Garret,

Did you get a chance to review these tests further ?

Regards--
Subrata

On Tue, 2010-08-24 at 19:41 -0700, Garrett Cooper wrote: 
> On Tue, Aug 24, 2010 at 6:25 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
> > Subrata Modak wrote:
> >> Thanks. I need to test this on a suitable kernel. But doubtful if i can
> >> add in the default run.
> >>
> >
> > Why? Because it costs 90 secs? This is configurable, and some other
> > test suites like cpuctl cost more time.
> >
> > If a test suite is not run by default, I guess people won't know its
> > existence, probably.
> 
> I think that more of the concern stems from the fact that it's a
> performance test, and a lot of people complain if and when their test
> machines slow down to a halt (take hackbench, proc01, for example).
> 
> There are issues with the code, but it's dealing with the fact that
> it's not really written in a portable way. Give me a bit of time and
> I'll comment on what needs to be changed.
> 
> Thanks,
> -Garrett


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
