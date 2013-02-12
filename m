Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <noreply@sourceforge.net>) id 1U5BNu-0002co-TP
	for ltp-list@lists.sourceforge.net; Tue, 12 Feb 2013 08:38:38 +0000
From: SourceForge.net <noreply@sourceforge.net>
Date: Tue, 12 Feb 2013 00:38:38 -0800
Content-Disposition: inline
MIME-Version: 1.0
Subject: [LTP] [ ltp-Patches-2976171 ] Incorrect testing if 'at' command is
	installed
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
Message-Id: <E1UC6IC-0000ya-3X@sfs-ml-2.v29.ch3.sourceforge.com>
To: "SourceForge.net" <noreply@sourceforge.net>

Patches item #2976171, was opened at 2010-03-24 15:13
Message generated for change (Comment added) made by nobody
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=2976171&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Commands
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: tstanisl (tstanisl)
Assigned to: Nobody/Anonymous (nobody)
Summary: Incorrect testing if 'at' command is installed

Initial Comment:
Scripts at_allow01 and at_deny01 contain incorrect usage of 'if' command. Command 'type at' returns 0 (true) if 'at' command is installed. Therefore conditional command:
if type at > /dev/null; then
         tst_resm TCONF "at command not found on system"
elif...
generated communicate  "at command not found on system" when 'at' is actually installed. The attachment contains patch that fixes overmentioned problem.


----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2013-02-12 00:38

Message:
gdEgsL  <a href="http://qnwwhexobrjm.com/">qnwwhexobrjm</a>,
[url=http://jtnpysagzgvi.com/]jtnpysagzgvi[/url],
[link=http://zjmekyfrgeag.com/]zjmekyfrgeag[/link],
http://nnqrdmctqvrm.com/

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=2976171&group_id=3382

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
