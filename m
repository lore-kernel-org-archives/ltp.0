Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <noreply@sourceforge.net>) id 1Q7VnW-0006Ny-Ro
	for ltp-list@lists.sourceforge.net; Wed, 06 Apr 2011 16:41:38 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1Q7VnW-0004OP-J2@sfs-web-2.v29.ch3.sourceforge.com>
Date: Wed, 06 Apr 2011 16:41:38 +0000
Subject: [LTP] [ ltp-Bugs-3103118 ] ftest01, 03,
	04 fail if executed more than once
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

Bugs item #3103118, was opened at 2010-11-04 20:34
Message generated for change (Comment added) made by metan
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3103118&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Filesystems
>Status: Closed
Resolution: None
Priority: 5
Private: No
Submitted By: Tim Wright (timw)
Assigned to: Nobody/Anonymous (nobody)
Summary: ftest01, 03, 04 fail if executed more than once

Initial Comment:
Attempts to run ftest01 with '-i N' for N >=2 fail for the second and subsequent tests.
This is because nwait is declared static, but never assigned and so is not reset to zero at the start of each test run.
The fix is trivial. nwait should be zeroed at the head of runtest().


----------------------------------------------------------------------

>Comment By: Cyril Hrubis (metan)
Date: 2011-04-06 18:41

Message:
This was fixed by Garrett in commit
7a73eab97ffec8b44079586a2cc74b28b52f9959.

----------------------------------------------------------------------

Comment By: Garrett Cooper (yaberauneya)
Date: 2010-11-10 08:17

Message:
Please try git HEAD and let me know how things go for you.

I'll be making some minor adjustments from here on out, but the changes
should be relatively transparent.

----------------------------------------------------------------------

Comment By: Tim Wright (timw)
Date: 2010-11-04 20:56

Message:
Same issue applies to ftests 05, 07 and 08.

----------------------------------------------------------------------

Comment By: Tim Wright (timw)
Date: 2010-11-04 20:51

Message:
applies to multiple of these tests.

----------------------------------------------------------------------

Comment By: Tim Wright (timw)
Date: 2010-11-04 20:46

Message:
Same problem in ftest03.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3103118&group_id=3382

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
