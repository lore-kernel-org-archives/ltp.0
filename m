Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1ZD4Tr-0000qt-D3
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 05:34:43 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZD4Tp-00056w-FZ
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 05:34:43 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NR7004OAGTMJB80@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 14:34:34 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Thu, 09 Jul 2015 11:03:57 +0530
Message-id: <1436420037-18441-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 2/2] open_posix/shm_unlink: sanity checking after
 calling pathconf
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
Cc: pankaj.m@samsung.com

sanity checking after calling pathconf added

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Yogesh Narayan Gaur <yn.gaur@samsung.com>
---
 .../conformance/interfaces/shm_unlink/10-1.c       |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
index 768863c..20e5bef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
@@ -27,6 +27,11 @@ int main(void)
 	char *shm_name;
 
 	name_max = pathconf("/", _PC_NAME_MAX);
+
+	if (name_max == -1) {
+		perror("An error occurs when calling pathconf()");
+		return PTS_UNRESOLVED;
+	}
 	shm_name = malloc(name_max + 3);
 
 	if (!shm_name) {
-- 
1.7.9.5


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
