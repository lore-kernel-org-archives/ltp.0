Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YzOd3-0001Ko-EZ
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 12:15:41 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YzOd0-0000gM-Uj
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 12:15:41 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Mon, 1 Jun 2015 12:07:38 +0000
Message-ID: <1433160458-191547-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] ade/ld: fix compile warning
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
To: ltp-list@lists.sourceforge.net
Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com

Fix the warnings 'old-style function definition' when compile LTP

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/commands/ade/ld/f1.c     |    2 +-
 testcases/commands/ade/ld/ldmain.c |    2 +-
 testcases/commands/ade/ld/rd1.c    |    2 +-
 testcases/commands/ade/ld/rf1.c    |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/ade/ld/f1.c b/testcases/commands/ade/ld/f1.c
index 610fb65..ebb5e10 100644
--- a/testcases/commands/ade/ld/f1.c
+++ b/testcases/commands/ade/ld/f1.c
@@ -1,5 +1,5 @@
 
-void f1()
+void f1(void)
 {
 	int i = 69;
 	i = i;
diff --git a/testcases/commands/ade/ld/ldmain.c b/testcases/commands/ade/ld/ldmain.c
index cac106e..6f9c47a 100644
--- a/testcases/commands/ade/ld/ldmain.c
+++ b/testcases/commands/ade/ld/ldmain.c
@@ -3,7 +3,7 @@
 
 extern void use_s1();
 
-int main()
+int main(void)
 {
 	use_s1();
 	return (0);
diff --git a/testcases/commands/ade/ld/rd1.c b/testcases/commands/ade/ld/rd1.c
index 969132f..d9496bd 100644
--- a/testcases/commands/ade/ld/rd1.c
+++ b/testcases/commands/ade/ld/rd1.c
@@ -2,7 +2,7 @@
 
 extern int d1;
 
-void use_s1()
+void use_s1(void)
 {
 	d1 = d1 + d1;
 }
diff --git a/testcases/commands/ade/ld/rf1.c b/testcases/commands/ade/ld/rf1.c
index 35cb94a..57a23f1 100644
--- a/testcases/commands/ade/ld/rf1.c
+++ b/testcases/commands/ade/ld/rf1.c
@@ -3,7 +3,7 @@
 
 extern void f1();
 
-void use_s1()
+void use_s1(void)
 {
 //      printf("calling function f1");
 	f1();
-- 
1.6.0.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
