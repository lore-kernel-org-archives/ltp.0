Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1ZAD5U-0001jw-QK
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 08:09:44 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZAD5T-0006RI-PW
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 08:09:44 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6187uPD010398
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2015 16:07:56 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 1 Jul 2015 16:09:01 +0800
Message-ID: <1435738142-19725-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] interfaces/sem_open: remove unused define(s)
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-1.c | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/4-1.c | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/5-1.c | 1 -
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/6-1.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-1.c
index b77b23f..a083244 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-1.c
@@ -22,7 +22,6 @@
 
 #define TEST "1-1"
 #define FUNCTION "sem_open"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
index c8b9297..23240b2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
@@ -22,7 +22,6 @@
 
 #define TEST "1-2"
 #define FUNCTION "sem_open"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/4-1.c
index a190efc..d10c295 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/4-1.c
@@ -23,7 +23,6 @@
 
 #define TEST "4-1"
 #define FUNCTION "sem_open"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/5-1.c
index e316056..56c8a93 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/5-1.c
@@ -22,7 +22,6 @@
 
 #define TEST "5-1"
 #define FUNCTION "sem_open"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 int main(void)
 {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/6-1.c
index 25eab96..f057656 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/6-1.c
@@ -20,7 +20,6 @@
 
 #define TEST "6-1"
 #define FUNCTION "sem_open"
-#define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "
 
 int main(void)
 {
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
