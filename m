Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <noreply@sourceforge.net>) id 1SX6JM-00034U-2D
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 07:48:48 +0000
From: SourceForge.net <noreply@sourceforge.net>
Date: Wed, 23 May 2012 00:48:47 -0700
Content-Disposition: inline
MIME-Version: 1.0
Subject: [LTP] [ ltp-Patches-1908313 ] Fix broken POSIX shell compliance
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
Message-Id: <E1SfHSQ-0006EV-4d@sfs-ml-1.v29.ch3.sourceforge.com>
To: "SourceForge.net" <noreply@sourceforge.net>

Patches item #1908313, was opened at 2008-03-05 13:13
Message generated for change (Comment added) made by nobody
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=1908313&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testscripts
Group: Miscellaneous
Status: Closed
Resolution: Accepted
Priority: 5
Private: No
Submitted By: Dustin Kirkland (dustin_kirkland)
Assigned to: Nobody/Anonymous (nobody)
Summary: Fix broken POSIX shell compliance

Initial Comment:
runltp will not execute on a POSIX-compliant shell (dash).

I found this thread, and a patch that to fixes my issues:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg00510.html

In the last message in the thread, it's claimed that the changes were
committed to CVS.
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg00521.html

This patch is an adaptation of the original by Matthew Wilcox.  I changed '= "0"' to '-eq 0', at the request of George Kraft.  I also dropped the sh -> bash change in generate.sh, as Mike Frysinger seemed to object to that part.

:-Dustin

Dustin Kirkland
Ubuntu Server Team
Canonical, LTD

----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2012-05-23 00:48

Message:
LQZJik  <a href="http://lxdmsauluqdo.com/">lxdmsauluqdo</a>,
[url=http://lawtkxucdvbv.com/]lawtkxucdvbv[/url],
[link=http://wipjuoxaevou.com/]wipjuoxaevou[/link],
http://lkegsnjqyprp.com/

----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2011-07-30 21:13

Message:
A5gsqS  <a href="http://igckxqylcmlj.com/">igckxqylcmlj</a>,
[url=http://gfabihntgbag.com/]gfabihntgbag[/url],
[link=http://yoohvvzjvdlj.com/]yoohvvzjvdlj[/link],
http://ehkcgrjiwkzg.com/

----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2011-06-06 06:44

Message:
iuyPHW  <a href="http://uesqnepdqnzj.com/">uesqnepdqnzj</a>,
[url=http://ovubwqmrymqg.com/]ovubwqmrymqg[/url],
[link=http://wdfgmvlplodt.com/]wdfgmvlplodt[/link],
http://dwcioccqmbsr.com/

----------------------------------------------------------------------

Comment By: Nobody/Anonymous (nobody)
Date: 2008-11-27 19:01

Message:
X7Rcs9  <a href="http://xeapefuszrpn.com/">xeapefuszrpn</a>,
[url=http://hhpzcgzhequk.com/]hhpzcgzhequk[/url],
[link=http://dpzcpkpkqyqp.com/]dpzcpkpkqyqp[/link],
http://tizfxaqpgenv.com/

----------------------------------------------------------------------

Comment By: Subrata Modak (subrata_modak)
Date: 2008-03-27 04:16

Message:
Logged In: YES 
user_id=1737361
Originator: NO

Mike already implemented this.

Regards--
Subrata

----------------------------------------------------------------------

Comment By: Mike Frysinger (vapier)
Date: 2008-03-08 04:50

Message:
Logged In: YES 
user_id=114429
Originator: NO

i used = in IDcheck.sh as it meshes better with the rest of the code in
that file ... if one gets converted to -eq, they all should

i added your -a => -e changes to runltp and runltplite.sh

cheers

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=303382&aid=1908313&group_id=3382

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
