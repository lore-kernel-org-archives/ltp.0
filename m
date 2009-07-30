Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MWbxo-0007Qu-3M
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 20:10:56 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWbxe-0001Vr-G6
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 20:10:51 +0000
Message-ID: <4A71FE38.20501@us.ibm.com>
Date: Thu, 30 Jul 2009 13:10:32 -0700
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
	<4A71F964.1060507@us.ibm.com>
	<alpine.DEB.2.00.0907301600560.21267@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.2.00.0907301600560.21267@gandalf.stny.rr.com>
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
> On Thu, 30 Jul 2009, Darren Hart wrote:
>> Just to be clear, Steven you want us to modify this test case so that it uses
>> the librttest facilities, including those for standardized argument parsing,
>> buffered out, and thread creation, then commit this to the repository?  I
>> don't feel it should go in without those changes.  We've expended a lot of
>> effort making the tests in ltp/realtime be consistent in those areas (they all
>> use some common command line arguments and coding styles).  This ensures that
>> they can be easily maintained along with the other tests in the suite and that
>> users can know what to expect from the test in terms of output, etc.
> 
> The test is GPL, do what you want ;-)
> 
> I have my own version that I may play with, but I have no qualms about 
> changing the interface. Especially if it is to be consistent with the rest 
> of LTP. But please CC me on any changes. I can tell if the changes modify 
> the the way the test works, or I may want to incorporate the changes into 
> my local copy.

OK, will do.

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
