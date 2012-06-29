Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SkWoX-0003B3-65
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 08:44:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkWoW-0003EZ-7X
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 08:44:29 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5T8iMi2016074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Jun 2012 04:44:22 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q5T8iL3b001432
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Jun 2012 04:44:21 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Jun 2012 10:44:11 +0200
Message-Id: <1c21689296e79eb48004e2f9eb879d717481cf73.1340959271.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH/RFC] style-guide: sending patch series
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Add paragraph about sending patch series,
what is the preferred format and sample git config.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 doc/style-guide.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-style-guide-sending-patch-series.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-style-guide-sending-patch-series.patch"

diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index 414e70e..b3bfd8c 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -440,3 +440,28 @@ blah blah blah blah blah.
 
 Signed-off-by: John Smith <dev@null>
 -------------------------------------------------------------------
+
+Sending patch series
+
+Preferred format is shallow thread:
+[PATCH 0/X] XXXXXX
+  |_ [PATCH 1/X] YYYYYYYY
+  |_ [PATCH 2/X] ZZZZZZZZ
+
+Configure your git:
+cd <local copy of ltp repo>
+git config sendemail.thread false
+git config format.thread shallow
+git config format.numbered auto
+git config sendemail.signoffbycc false
+git config sendemail.suppresscc all
+git config sendemail.suppressfrom true
+git config sendemail.smtpserver "your.smtp.server"
+git config sendemail.confirm always
+
+Example, sending series consisting of 2 patches with git send-email:
+1. git format-patch --attach -2 --cover-letter
+2. edit subject and body of cover letter: 0000-cover-letter.patch
+3. git send-email --to ltp-list@lists.sourceforge.net \
+   0000-cover-letter.patch 0001-part1.patch 0002-part2.patch
+

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



