Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UIzg0-0007eX-CW
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 10:58:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIzfz-0004S7-1V
	for ltp-list@lists.sourceforge.net; Fri, 22 Mar 2013 10:58:24 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2MAwHGO006817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Mar 2013 06:58:17 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Mar 2013 11:58:12 +0100
Message-Id: <e7c2f015e6e46d1eb1aad28001b8794fe7a91a44.1363949441.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] sched_stress: fix matrix inversion routine
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

Fix code to not go out of bounds of "matrix_1" array
and to do what it's supposed to - calculate inversion matrix.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/sched/sched_stress/sched_tc5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/sched/sched_stress/sched_tc5.c b/testcases/kernel/sched/sched_stress/sched_tc5.c
index d242c9e..db5ce96 100644
--- a/testcases/kernel/sched/sched_stress/sched_tc5.c
+++ b/testcases/kernel/sched/sched_stress/sched_tc5.c
@@ -210,7 +210,7 @@ void invert_matrix()
 	 * Form an identity matrix in the random matrix
 	 */
 	for (i = 0; i < MATRIX_SIZE; i++) {
-		t1 = matrix_1[i][j];
+		t1 = matrix_1[i][i];
 		for (j = 0; j < MATRIX_SIZE; j++) {
 			matrix_1[i][j] /= t1;
 			matrix_2[i][j] /= t1;
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
