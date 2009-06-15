Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1MGAre-0007xr-0a
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 12:00:38 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1MGAq5-0003LX-In@b55xhf1.ch3.sourceforge.com>
Date: Mon, 15 Jun 2009 11:59:01 +0000
Subject: [LTP] [ ltp-Patches-2806554 ] build failure
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

Patches item #2806554, was opened at 2009-06-15 11:59
Message generated for change (Tracker Item Submitted) made by nobody
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=2806554&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: System Calls
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Nobody/Anonymous (nobody)
Assigned to: Nobody/Anonymous (nobody)
Summary: build failure

Initial Comment:
I am new to LTP. 
I am unable to make ltp-full-20090531. I had applied the patch ltp-full-20090531.patch as well.
While building sgnalfd01.c , the error is thrown:
error: sys/signalfd.h: No such file or directory

Pls help. 
Did I download the correct sofwtare? Are there any more patches to apply?
Without the patch, I got error while building another syscall file.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=2806554&group_id=3382

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
