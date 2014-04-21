Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WcC4s-0006En-57
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:07:58 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WcC4q-0003hx-DM
	for ltp-list@lists.sourceforge.net; Mon, 21 Apr 2014 11:07:58 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3LB7oZi030121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:50 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3LB7nCA027104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:49 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3LB7n8Z008130
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Apr 2014 11:07:49 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Apr 2014 15:07:40 +0400
Message-Id: <1398078461-23926-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1398078461-23926-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/2] pitest-2, pitest-3: increased the timeout
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

On some platforms do_work_dummy() (if compiled without any optimizations,
and it's by default) executes longer than the specified timeout of 100 ms.

Therefore there is a very small chance that TL may lock the mutex during
sleep() in the main thread, and most of the time the tests will fail with:
../../../functional/threads/pi_test/pitest-2.c: 222: FAIL: Thread TB1: lock returned 0 Success, slept 0.000008

To overcome this I increased the timeout value for TBs. It doesn't break the logic.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/pi_test/pitest-2.c          |    4 ++--
 .../functional/threads/pi_test/pitest-3.c          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index ee810eb..dda51c3 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -67,8 +67,8 @@ struct thread_param {
 } tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
-	1, 0, 100, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
-	2, 0, 100, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
+	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
+	2, 0, 500, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
 	3, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
 	4, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
 	5, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index e0438d6..5e925a5 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -68,8 +68,8 @@ struct thread_param {
 } tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
-	1, 0, 100, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
-	1, 0, 100, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
+	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
+	1, 0, 500, 5, SCHED_FIFO, "TP2", 0, 0, 0, 0}, {
 	2, 0, 0, 3, SCHED_FIFO, "TF", 1, 0, 0, 0}, {
 	3, 0, 0, 3, SCHED_FIFO, "TF", 2, 0, 0, 0}, {
 	4, 0, 0, 3, SCHED_FIFO, "TF", 3, 0, 0, 0}, {
-- 
1.7.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
