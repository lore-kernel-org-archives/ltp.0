Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7EW3-0001c5-BW
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:55 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7EW2-0006ly-Gq
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 21:09:55 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SL7awq006927
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 17:07:36 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3SL9m602130164
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 17:09:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3SL9lgB032133
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 17:09:48 -0400
Date: Wed, 28 Apr 2010 16:09:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428210947.GB20642@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100428210906.GA20572@us.ibm.com>
Subject: [LTP] [PATCH 3/4] mqns2: fix some error checking and reporting
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/containers/mqns/mqns_02.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_02.c b/testcases/kernel/containers/mqns/mqns_02.c
index 8f783ba..07ab042 100644
--- a/testcases/kernel/containers/mqns/mqns_02.c
+++ b/testcases/kernel/containers/mqns/mqns_02.c
@@ -76,7 +76,7 @@ int check_mqueue(void *vtest)
 
 			else {
 
-				if (read(p1[0], buf, 5))
+				if (read(p1[0], buf, 5) < 0)
 					tst_resm(TBROK | TERRNO,
 						"read(p1[0], ..) failed");
 				else {
@@ -142,7 +142,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (read(p2[0], buf, 7) < 0) {
-		tst_resm(TBROK, "read(p1[0], ..) failed");
+		tst_resm(TBROK, "read(p2[0], ..) failed");
 	} else if (!strcmp(buf, "mqfail")) {
 		tst_resm(TFAIL, "child process could not create mqueue\n");
 		umount(DEV_MQUEUE);
@@ -160,8 +160,8 @@ int main(int argc, char *argv[])
 			tst_resm(TFAIL, "Parent process found mqueue\n");
 			mq_close(mqd);
 		}
-		if (write(p1[1], "cont", 5)) {
-			tst_resm(TBROK, "read(p1[0], ..) failed");
+		if (write(p1[1], "cont", 5) < 0) {
+			tst_resm(TBROK, "write(p1[1], ..) failed");
 
 		}
 	}
-- 
1.7.0


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
