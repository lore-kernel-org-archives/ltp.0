Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <noreply@sourceforge.net>) id 1UNxOw-0004Oq-Mw
	for ltp-list@lists.sourceforge.net; Fri, 05 Apr 2013 03:33:18 +0000
From: SourceForge.net <noreply@sourceforge.net>
Date: Thu, 04 Apr 2013 20:33:18 -0700
Content-Disposition: inline
MIME-Version: 1.0
Subject: [LTP] [ ltp-Bugs-3609873 ] lcov fails when removing lines from a
	file
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
Message-Id: <E1UWlea-0002xI-Qx@sfs-ml-2.v29.ch3.sourceforge.com>
To: "SourceForge.net" <noreply@sourceforge.net>

Bugs item #3609873, was opened at 2013-04-03 02:03
Message generated for change (Comment added) made by melonstorm
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3609873&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: None
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Jookia ()
Assigned to: Nobody/Anonymous (nobody)
Summary: lcov fails when removing lines from a file

Initial Comment:
When compiling a file with GCC, then removing a line and compiling it again, lcov will be unable to read the generated coverage files. I've attached a shell script that does this behaviour.

I'm on Arch Linux x86_64 with GCC 4.7.2 and lcov 1.10 (although I have tested it with the trunk version and gotten the same results.)

----------------------------------------------------------------------

Comment By: Melvin Kicchi (melonstorm)
Date: 2013-04-04 20:33

Message:
Confirmed on Linux Mint x86_64 with gcc 4.7.2 and lcov 1.9.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3609873&group_id=3382

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
