Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1NeXJZ-00032b-Q5
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 17:22:25 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1NeXJZ-0004Xu-G0@sfs-web-1.v29.ch3.sourceforge.com>
Date: Mon, 08 Feb 2010 17:22:25 +0000
Subject: [LTP] [ ltp-Bugs-2936354 ] Problem with --base-directory option for
	folder overview
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

Bugs item #2936354, was opened at 2010-01-21 15:14
Message generated for change (Comment added) made by khmarbaise
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2936354&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: None
>Status: Closed
Resolution: None
Priority: 5
Private: No
Submitted By: Karl Heinz Marbaise (khmarbaise)
Assigned to: Nobody/Anonymous (nobody)
Summary: Problem with --base-directory option for folder overview

Initial Comment:
I have modified the example which is part of the delivery to produce all reports etc. into a separate folder (target)...
But now i have the problem that the HTML report where the unmodified report show simply "example" now i have a folder as part of it.
The link is working well, but it's not look good....
It seemed to be that the --base-directory is not removed from folders.


----------------------------------------------------------------------

>Comment By: Karl Heinz Marbaise (khmarbaise)
Date: 2010-02-08 18:22

Message:
Sorry for the late answer. Your asumtion is correct. And mine was
wrong...cause after investigating the problem i found out the problem was
on my side...
So i close that issue.

----------------------------------------------------------------------

Comment By: Peter Oberparleiter (oberpapr)
Date: 2010-01-22 10:09

Message:
I'm assuming that you're talking about lcov.

It's difficult to comment on your modification without knowing what
exactly it does. If you post a patch to ltp-coverage@lists.sourceforge.net,
I can have a look.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2936354&group_id=3382

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
