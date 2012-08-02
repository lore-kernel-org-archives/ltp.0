Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Swyf7-0000bi-9G
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 16:54:13 +0000
Received: from rcsinet15.oracle.com ([148.87.113.117])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Swyf6-0000FA-Hj
	for ltp-list@lists.sourceforge.net; Thu, 02 Aug 2012 16:54:13 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by rcsinet15.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id q72Gs453025541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 16:54:04 GMT
Received: from acsmt358.oracle.com (acsmt358.oracle.com [141.146.40.158])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	q72Gs3fF001562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 16:54:03 GMT
Received: from abhmt115.oracle.com (abhmt115.oracle.com [141.146.116.67])
	by acsmt358.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	q72Gs3Dj021793
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Aug 2012 11:54:03 -0500
From: Simon Xu <xu.simon@oracle.com>
Date: Fri,  3 Aug 2012 00:53:57 +0800
Message-Id: <1343926437-2099-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH 1/1] madvise03: let the system select an address for
	shmat()
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

In certain occasions, 0x22000000 is invalid for shmat() and madvise03 fails:

madvise03 1 TBROK : shmat error
madvise03 2 TBROK : Remaining cases broken

Use `NULL' for shmat() to let the system attach the shared memory segment
at the first available address.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/kernel/syscalls/madvise/madvise03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise03.c b/testcases/kernel/syscalls/madvise/madvise03.c
index 2e696e8..fd0bd97 100644
--- a/testcases/kernel/syscalls/madvise/madvise03.c
+++ b/testcases/kernel/syscalls/madvise/madvise03.c
@@ -154,13 +154,13 @@ int main(int argc, char *argv[])
 		if (shmid1 == -1)
 			tst_brkm(TBROK, cleanup, "shmget failed");
 
-		/* Attach shared memory segment to 0x22000000 address */
-		addr1 = shmat(shmid1, (void *)0x22000000, 0);
+		/* Attach shared memory segment to an address selected by the system */
+		addr1 = shmat(shmid1, NULL, 0);
 		if (addr1 == (void *) -1)
 			tst_brkm(TBROK, cleanup, "shmat error");
 
 		/* (1) Test case for MADV_REMOVE */
-		TEST(madvise((void *)0x22000000, 4096, MADV_REMOVE));
+		TEST(madvise((void *)addr1, 4096, MADV_REMOVE));
 		check_and_print("MADV_REMOVE");
 
 		/* (2) Test case for MADV_DONTFORK */
-- 
1.7.11.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
