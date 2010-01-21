Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1NXxo0-0001My-BT
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 14:14:40 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1NXxnz-00025Q-Ll@g45xhf1.ch3.sourceforge.com>
Date: Thu, 21 Jan 2010 14:14:39 +0000
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
Message generated for change (Tracker Item Submitted) made by khmarbaise
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2936354&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: None
Status: Open
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

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2936354&group_id=3382

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
