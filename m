Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WkAyM-0004kE-RR
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 11:34:14 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WkAyM-0006po-16
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 11:34:14 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4DBY7Op006946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 11:34:08 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4DBY74s007148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 11:34:07 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s4DBXx4l013944
	for <ltp-list@lists.sourceforge.net>; Tue, 13 May 2014 11:34:00 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 13 May 2014 15:34:32 +0400
Message-Id: <1399980872-27547-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH v2 2/2] docs: add a paragraph about access() to Common
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
 doc/test-writing-guidelines.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 91edbf0..b228c80 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -883,6 +883,14 @@ settings which may clear some of the bits. If your test depends on specific
 file permissions you need to 'chmod()' the file afterwards or use SAFE_TOUCH()
 that does the 'chmod()' for you.
 
+3.2 access()
+~~~~~~~~~~~
+
+If access(some_file, W_OK) is executed by root it will return success even
+if the file doesn't have write permission bits set (the same for R_OK for
+privileged user). As a workaround you can use 'open()' to check sysfs file's
+read/write permission bits. It might not work for other filesystems, but you
+have stat, lstat and fstat functions.
 
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
