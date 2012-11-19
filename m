Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <noreply@sourceforge.net>) id 1TaXeD-0007sq-P4
	for ltp-list@lists.sourceforge.net; Mon, 19 Nov 2012 20:08:49 +0000
From: SourceForge.net <noreply@sourceforge.net>
Date: Mon, 19 Nov 2012 12:08:49 -0800
Content-Disposition: inline
MIME-Version: 1.0
Subject: [LTP] [ ltp-Patches-3588583 ] Gcov-Kernel on 2.6.32-(44-60)
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
Message-Id: <E1TkTx8-0000SR-DN@sfs-ml-2.v29.ch3.sourceforge.com>
To: "SourceForge.net" <noreply@sourceforge.net>

Patches item #3588583, was opened at 2012-11-19 12:07
Message generated for change (Settings changed) made by shayanb
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=3588583&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: None
Group: None
Status: Open
Resolution: None
>Priority: 9
Private: No
Submitted By: Shayan Es (shayanb)
Assigned to: Nobody/Anonymous (nobody)
Summary: Gcov-Kernel on 2.6.32-(44-60)

Initial Comment:
I can't get the gcov module to be in the kernel on Ubuntu 10.04 2.6.32

I used the appropriate flags to build the kernel and it seems that gcov is working good with the applications sources but as I need to trace and find the coverage of the kernel sources I can't get the gcov module to work, actually there is no module named gcov*.o
(* means anything that has gcov in it and is a module.)

I don't have anything related to gcov in /proc
everything else seems to be ok, I have all .gcov .gnco kernel source files

but no modules, Lcov -c would give me this error:

Loading required gcov kernel module.
lcov: ERROR: cannot load required gcov kernel module!

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=3588583&group_id=3382

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
