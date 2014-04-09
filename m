Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WXmHL-0000hF-Rf
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 06:46:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WXmHK-0005ta-4G
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 06:46:35 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s396kQ5u013872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Apr 2014 06:46:27 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s396kQDA018935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Apr 2014 06:46:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s396kPCB018926
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Apr 2014 06:46:25 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  9 Apr 2014 10:46:20 +0400
Message-Id: <1397025980-26738-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] shm_open_23-1: modified memory protection attributes
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

POSIX doesn't state that if mmap() is given only PROT_WRITE, then
that memory region will have read access too. It's an implementation
issue of the platform.

On a platform which don't imply read access when only PROT_WRITE is given,
such a situation happens:
  1) a child process decrements the semaphore with sem_wait(sem)
  2) then tries to dereference create_cnt via (*create_cnt)++. This
     will result in a SIGSEGV, and the child will be terminated.

Therefore the semaphore will be left in a "decremented" state and this
test case will hang.

To overcome this problem we should explicitly pass PROT_READ to mmap().

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/shm_open/23-1.c         |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c
index 40d7a19..7a82f88 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/23-1.c
@@ -105,7 +105,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	create_cnt = mmap(NULL, sizeof(*create_cnt), PROT_WRITE,
+	create_cnt = mmap(NULL, sizeof(*create_cnt), PROT_WRITE | PROT_READ,
 			  MAP_SHARED, result_fd, 0);
 	if (create_cnt == MAP_FAILED) {
 		perror("An error occurs when calling mmap()");
-- 
1.7.1


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
