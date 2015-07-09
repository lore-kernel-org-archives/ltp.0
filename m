Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1ZD4Sw-0000oB-7g
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 05:33:46 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZD4St-00055i-Tk
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 05:33:46 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NR7029B7GS0VA80@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 14:33:36 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Thu, 09 Jul 2015 11:03:01 +0530
Message-id: <1436419981-15155-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 1/2] open_posix/shm_unlink: Sanity checking of malloc
	added
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

Sanity checking of malloc added

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Yogesh Narayan Gaur <yn.gaur@samsung.com>
---
 .../conformance/interfaces/shm_unlink/10-1.c       |    5 +++++
 .../conformance/interfaces/shm_unlink/10-2.c       |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
index bcfa42c..768863c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
@@ -29,6 +29,11 @@ int main(void)
 	name_max = pathconf("/", _PC_NAME_MAX);
 	shm_name = malloc(name_max + 3);
 
+	if (!shm_name) {
+		perror("malloc() failed");
+		return PTS_UNRESOLVED;
+	}
+
 	shm_name[0] = '/';
 	for (i = 1; i < name_max + 2; i++)
 		shm_name[i] = 'a';
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-2.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-2.c
index 7d478c7..9402e1b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-2.c
@@ -39,6 +39,11 @@ int main(void)
 	}
 	shm_name = malloc(path_max + 1);
 
+	if (!shm_name) {
+		perror("malloc() failed");
+		return PTS_UNRESOLVED;
+	}
+
 	for (i = 0; i < path_max; i++)
 		shm_name[i] = (i + 1) % COMPONENT_SIZE ? 'a' : '/';
 	shm_name[path_max] = 0;
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
