Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rostedt@goodmis.org>) id 1MWaZt-0007w6-QZ
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:42:09 +0000
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWaZs-0000yP-Rw
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:42:09 +0000
Date: Thu, 30 Jul 2009 14:42:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1248978525.5788.55.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.DEB.2.00.0907301440460.21267@gandalf.stny.rr.com>
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	<1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	<200907102200.12804.sripathik@in.ibm.com>
	<1247244446.5040.0.camel@subratamodak.linux.ibm.com>
	<4A57884C.10401@us.ibm.com>
	<alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
	<4A64A369.8040808@us.ibm.com>
	<1248978525.5788.55.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Gregory Haskins <ghaskins@novell.com>, Clark Williams <clark.williams@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>



On Thu, 30 Jul 2009, Subrata Modak wrote:
> > 
> > Yup.  This is different than prio-wake.  Prio-wake creates some number 
> > of threads of varying priorities and puts them to sleep on 
> > pthread_cond_wait and then wakes them with pthread_cond_broadcast, then 
> > tests that the threads were woken in priority order.  Fails on 
> > kernels/glibc without requeue pi support as a FUTEX_WAKE(all) was used 
> > for PI mutexes.
> > 
> > So to include this in the ltp/restcases/realtime suite, the test should 
> > make use of the librttest.c and libstats.c apis, standardized argument 
> > parsing, buffered logging mechanism, and standardized output formatting. 
> >   I can't get to that for a little while myself, but can assist if you 
> > have any questions.  Alternatively we can wait a little while, and 
> > perhaps someone on my team will be able to help merge it with the 
> > realtime test infrastructure in LTP.
> 
> That should be fine.
> 

Note,

Please take the following code:

 http://rostedt.homelinux.com/code/rt-migrate-test.c

Because I got rid of the old logdev writes (ifdef out) and replaced it 
with ftrace. It tries to write to ftrace if possible, but if ftrace is not 
configured, it should just ignore it.

-- Steve


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
