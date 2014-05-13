Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Wk99M-0003jN-6z
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 09:37:28 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wk99L-0001Pd-EG
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 09:37:28 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4D9bK0V007279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 09:37:21 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4D9bKpg013839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 09:37:20 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4D9bKn8016510
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 09:37:20 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 13 May 2014 13:37:48 +0400
Message-Id: <1399973868-26408-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2] docs: add a paragraph about access() to Common
	Problems section
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 doc/test-writing-guidelines.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 91edbf0..aaf6b4a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -883,6 +883,13 @@ settings which may clear some of the bits. If your test depends on specific
 file permissions you need to 'chmod()' the file afterwards or use SAFE_TOUCH()
 that does the 'chmod()' for you.
 
+3.2 access()
+~~~~~~~~~~~
+
+If access(some_file, W_OK) is executed by root it will return success even
+if the file has read-only permission. As a workaround you can use 'open()' to
+test sysfs file for write permission. It might not work for other filesystems,
+but you have stat, lstat and fstat functions.
 
 4. Test Contribution Checklist
 ------------------------------
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
