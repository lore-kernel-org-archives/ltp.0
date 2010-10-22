Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1P9Cff-00047A-G7
	for ltp-list@lists.sourceforge.net; Fri, 22 Oct 2010 08:08:15 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1P9Cff-0005SL-8v@sfs-web-6.v29.ch3.sourceforge.com>
Date: Fri, 22 Oct 2010 08:08:15 +0000
Subject: [LTP] [ ltp-Patches-3092794 ] genpow: array index overrun
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

Patches item #3092794, was opened at 2010-10-22 12:08
Message generated for change (Tracker Item Submitted) made by yustasswamp
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=3092794&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Miscellaneous
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Alexey Makhalov (yustasswamp)
Assigned to: Nobody/Anonymous (nobody)
Summary: genpow: array index overrun

Initial Comment:
genpow.c:110 
create_Data_file function

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=3092794&group_id=3382

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
