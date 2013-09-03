Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGpAi-0006ph-Rd
	for ltp-list@lists.sourceforge.net; Tue, 03 Sep 2013 11:53:24 +0000
Date: Tue, 3 Sep 2013 13:53:33 +0200
From: chrubis@suse.cz
Message-ID: <20130903115333.GB8672@rei>
References: <521EAA6B.8090308@cn.fujitsu.com> <20130902121939.GB3269@rei>
	<52254E29.6050806@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52254E29.6050806@cn.fujitsu.com>
Subject: Re: [LTP] Wanna execute the ltp and the openposix test suite
 together by one command
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> >>
> >> Or does anbody have a better idea?
> >>
> > 
> > What I'm about to do is complete rewrite of the system that executes LTP
> > testcases and integrating open posix testsuite is one of the key points.
> > 
> > Hopefully I will start to work on this soon enough (It's quite high
> > priority on my TODO now) but even if I start working on it today, it
> > will not be ready at least for a few months.
> > 
> 
> Very glad to hear that and is there anything we can do to shorten the
> development cycle?

You can't rush good cooking, you can't rush babies out, and you can't
rush software development. :)

But help would be very much appreciated. I will setup a git repo once I
have initial code ready then we can start testing it/hacking together.
I do not think that there is work for more than one person until at
least the basic interface is defined.

The current desing for the tool is:

Frontend
 - Parses configuration, schedulles tests to be executed by core

Core
 - Runs tests
 - Watches for timeouts
 - Kills childrens that outlive parent (main test executable)
 - Collects test output and results

Backend
 - Produces logs
 - Handles user input

I'm not yet sure whether user input should be handled by core or
backend, but generally splitting the tool into more logical parts would
allow us to use different formats of "runtest" files and all that would
be needed for that is to hook different input parser. The very same goes
for the backend and logs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
