Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaNO-0006IJ-5y
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:14 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNJ-0001hO-Eh
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:14 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A64A369.8040808@us.ibm.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	<1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	<200907102200.12804.sripathik@in.ibm.com>
	<1247244446.5040.0.camel@subratamodak.linux.ibm.com>
	<4A57884C.10401@us.ibm.com>
	<alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
	<4A64A369.8040808@us.ibm.com>
Date: Thu, 30 Jul 2009 23:58:45 +0530
Message-Id: <1248978525.5788.55.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
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
To: Darren Hart <dvhltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Steven Rostedt <rostedt@goodmis.org>, Gregory Haskins <ghaskins@novell.com>, Clark Williams <clark.williams@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

On Mon, 2009-07-20 at 10:03 -0700, Darren Hart wrote: 
> Steven Rostedt wrote:
> > On Fri, 10 Jul 2009, Darren Hart wrote:
> > 
> >> Subrata Modak wrote:
> >>> On Fri, 2009-07-10 at 22:00 +0530, Sripathi Kodi wrote:
> >>>> On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
> >>>>> Darren/Sri/Gowri,
> >>>>>
> >>>>> Where do you want me to put this exactly inside the RT tree ?
> >>>> Hi Subrata,
> >>>>
> >>>> Going by how the tests are organized currently, I think this should go
> >>>> into it's own directory under testcases/realtime/func. We will need to
> >>>> add a makefile to it. Are you looking at us to help you with this?
> >>> Correct. Please send me a patch which integrates it into RT tests build,
> >>> install & run.
> >> Just got back from a week vacation and am burning through mail as fast as I
> >> can :-) Haven't had a look yet, but does this test use librttest.h?  I suspect
> >> not.  We'll need to adapt it to run within the existing ltp real-time testing
> >> framework, which includes things like buffered output as well as mlocking
> >> support.
> >>
> >> Lastly, I'm not sure this test does anything effectively different than
> >> prio-wake, already in the tree.  My other concerns with the test are its
> >> explicit 1ms preemption criteria (as Steven described it anyway).  We are
> >> trying to move away from criteria being inherent in measurement tests, and 1
> >> ms seems like an awfully long priority inversion to be an acceptable criteria
> >> to many users.
> >>
> >> Steven, am I missing something conceptually here?
> > 
> > Hmm, I missed this email, sorry for the late reply.
> > 
> > What does prio-wake do?
> > 
> > This test is what I used to develop the rt scheduler in mainline (as well 
> > as in -rt).  It wakes up N+1 tasks with lowering real time priorities. 
> > Where N is the number of CPUs in the system. Then it makes sure that the 
> > these tasks spread out across the CPUs. Most tests just test the highest 
> > priority task in the system. But those tests usually miss the second 
> > highest prio task in the system. If you have a second highest prio task in 
> > the system and a CPU is available to run, then it should run on that CPU. 
> > But what happens is that it can wait to be migrated and can take millisecs 
> > to wake up.
> > 
> > This test makes sure that all the high prio tasks that are in the running 
> > state are actually running on a CPU if it can.
> > 
> > Make sense?
> 
> Yup.  This is different than prio-wake.  Prio-wake creates some number 
> of threads of varying priorities and puts them to sleep on 
> pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
> tests that the threads were woken in priority order.  Fails on 
> kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
> for PI mutexes.
> 
> So to include this in the ltp/restcases/realtime suite, the test should 
> make use of the librttest.c and libstats.c apis, standardized argument 
> parsing, buffered logging mechanism, and standardized output formatting. 
>   I can't get to that for a little while myself, but can assist if you 
> have any questions.  Alternatively we can wait a little while, and 
> perhaps someone on my team will be able to help merge it with the 
> realtime test infrastructure in LTP.

That should be fine.

Regards--
Subrata

> 
> > 
> > (BTW, current -rt and mainline now fail this test :-? )
> 
> Hrm, uh oh.  Adding it to my lengthy list of things to try and look at :/
> 
> Thanks Steve,
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
