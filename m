Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MWbdm-0004Y8-UC
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 19:50:14 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWbdi-0000j0-Jc
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 19:50:14 +0000
Message-ID: <4A71F964.1060507@us.ibm.com>
Date: Thu, 30 Jul 2009 12:49:56 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	<1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	<200907102200.12804.sripathik@in.ibm.com>
	<1247244446.5040.0.camel@subratamodak.linux.ibm.com>
	<4A57884C.10401@us.ibm.com>
	<alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
	<4A64A369.8040808@us.ibm.com>
	<1248978525.5788.55.camel@subratamodak.linux.ibm.com>
	<alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
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
Cc: ltp-list <ltp-list@lists.sf.net>, Gregory Haskins <ghaskins@novell.com>, Clark Williams <clark.williams@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

Steven Rostedt wrote:
> 
> On Thu, 30 Jul 2009, Subrata Modak wrote:
>>> Yup.  This is different than prio-wake.  Prio-wake creates some number 
>>> of threads of varying priorities and puts them to sleep on 
>>> pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
>>> tests that the threads were woken in priority order.  Fails on 
>>> kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
>>> for PI mutexes.
>>>
>>> So to include this in the ltp/restcases/realtime suite, the test should 
>>> make use of the librttest.c and libstats.c apis, standardized argument 
>>> parsing, buffered logging mechanism, and standardized output formatting. 
>>>   I can't get to that for a little while myself, but can assist if you 
>>> have any questions.  Alternatively we can wait a little while, and 
>>> perhaps someone on my team will be able to help merge it with the 
>>> realtime test infrastructure in LTP.
>> That should be fine.
>>
> 
> Note,
> 
> Please take the following code:
> 
>  http://rostedt.homelinux.com/code/rt-migrate-test.c
> 
> Because I got rid of the old logdev writes (ifdef out) and replaced it 
> with ftrace. It tries to write to ftrace if possible, but if ftrace is not 
> configured, it should just ignore it.

Just to be clear, Steven you want us to modify this test case so that it 
uses the librttest facilities, including those for standardized argument 
parsing, buffered out, and thread creation, then commit this to the 
repository?  I don't feel it should go in without those changes.  We've 
expended a lot of effort making the tests in ltp/realtime be consistent 
in those areas (they all use some common command line arguments and 
coding styles).  This ensures that they can be easily maintained along 
with the other tests in the suite and that users can know what to expect 
from the test in terms of output, etc.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
