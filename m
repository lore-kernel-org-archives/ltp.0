Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1PE5ZY-0008OU-QY
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 19:34:08 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1PE5ZY-0000Xw-Mf@sfs-web-10.v29.ch3.sourceforge.com>
Date: Thu, 04 Nov 2010 19:34:08 +0000
Subject: [LTP] [ ltp-Bugs-3103118 ] ftest01 fails if executed more than once
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
To: noreply@sourceforge.net

Bugs item #3103118, was opened at 2010-11-04 12:34
Message generated for change (Tracker Item Submitted) made by timw
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3103118&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Filesystems
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Tim Wright (timw)
Assigned to: Nobody/Anonymous (nobody)
Summary: ftest01 fails if executed more than once

Initial Comment:
Attempts to run ftest01 with '-i N' for N >=2 fail for the second and subsequent tests.
This is because nwait is declared static, but never assigned and so is not reset to zero at the start of each test run.
The fix is trivial. nwait should be zeroed at the head of runtest().


----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3103118&group_id=3382

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
