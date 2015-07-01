Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1ZAD5W-0005JD-CI
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 08:09:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZAD5V-0006RI-Gh
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 08:09:46 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t61880eP010401
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2015 16:08:00 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 1 Jul 2015 16:09:02 +0800
Message-ID: <1435738142-19725-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1435738142-19725-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1435738142-19725-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] sem_open/1-2.c: fix wrong comparison
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

The comparison will always evaluate as 'true' for the address
of 'mysemp' will never be NULL.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
index 23240b2..06965ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_open/1-2.c
@@ -34,7 +34,7 @@ int main(void)
 
 	/* Checking if mysemp has a value returned. From sem_open */
 
-	if (&mysemp != NULL) {
+	if (mysemp != NULL) {
 		puts("TEST PASSED");
 		sem_close(mysemp);
 		sem_unlink(semname);
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
