Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1NSwwp-0007Z8-4Q
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 18:19:03 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1NSwwm-0005r7-6q@665xhf1.ch3.sourceforge.com>
Date: Thu, 07 Jan 2010 18:19:00 +0000
Subject: [LTP] [ ltp-Bugs-2927723 ] geninfo fails on paths starting with ..
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

Bugs item #2927723, was opened at 2010-01-07 13:19
Message generated for change (Tracker Item Submitted) made by drobilla
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2927723&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: None
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: David Robillard (drobilla)
Assigned to: Nobody/Anonymous (nobody)
Summary: geninfo fails on paths starting with ..

Initial Comment:
geninfo fails to find gcov files when the path (and thus gcov filename) begins with ..

The gcov manpage suggests .. should be munged to ^ but that doesn't seem to be happening.  I can't figure out any workaround for this problem, though identical scripts used to work.

The failure is because the perl glob fails to find the files since they are hidden (begin with .).  The attached patch fixes this.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2927723&group_id=3382

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
