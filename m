Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rst7I-000467-Ca
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 09:38:08 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rst7E-0006ZV-MM
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 09:38:08 +0000
Received: by iaby12 with SMTP id y12so3901418iab.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Feb 2012 01:37:59 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  2 Feb 2012 17:37:33 +0800
Message-Id: <1328175453-10106-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1328175453-10106-1-git-send-email-caspar@casparzhang.com>
References: <1328175453-10106-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <4F2A5185.6060008@casparzhang.com>
References: <4F2A5185.6060008@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH v2 2/2] mm/thp02: add runtest entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


adding thp02 entry to runtest/mm

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 runtest/mm |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0002-mm-thp02-add-runtest-entry.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-thp02-add-runtest-entry.patch"

diff --git a/runtest/mm b/runtest/mm
index 73fd13c..26fe534 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -79,6 +79,7 @@ oom03 oom03
 oom04 oom04
 
 thp01 thp01 -I 120
+thp02 thp02
 
 vma01 vma01
 vma02 vma02

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



