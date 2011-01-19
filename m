Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfQtM-0002Sc-TW
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 05:47:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfQtL-0007nK-6q
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 05:47:36 +0000
Message-ID: <4D367AF5.5070905@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 13:47:33 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] creat07: "-F $LTPROOT/testcases/bin/test1" should be
 removed
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

"-F $LTPROOT/testcases/bin/test1" should be removed when execute creat07.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 runtest/ltplite      |    2 +-
 runtest/stress.part3 |    2 +-
 runtest/syscalls     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runtest/ltplite b/runtest/ltplite
index a650482..ee573a9 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -141,7 +141,7 @@ creat03 creat03
 creat04 creat04
 creat05 creat05
 creat06 creat06
-creat07 creat07 -F $LTPROOT/testcases/bin/test1
+creat07 creat07
 creat08 creat08
 creat09 creat09
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 8d63e9c..0f33a48 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -82,7 +82,7 @@ creat03 creat03
 creat04 creat04
 creat05 creat05
 creat06 creat06
-creat07 creat07 -F $LTPROOT/testcases/bin/test1
+creat07 creat07
 creat08 creat08
 creat09 creat09
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 7683e39..dbfc16b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -99,7 +99,7 @@ creat03 creat03
 creat04 creat04
 creat05 creat05
 creat06 creat06
-creat07 creat07 -F $LTPROOT/testcases/bin/test1
+creat07 creat07
 creat08 creat08
 creat09 creat09
 
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
