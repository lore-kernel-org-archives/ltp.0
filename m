Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S5J9q-0004qe-PK
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 15:52:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S5J9l-0001oG-1Q
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 15:52:06 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q27Fpt9b025911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 7 Mar 2012 10:51:55 -0500
Message-ID: <4F578418.2060100@redhat.com>
Date: Wed, 07 Mar 2012 16:51:52 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040008040001070609050109"
Subject: [LTP] [PATCH] getrusage04: initialise [us]last to current values
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------040008040001070609050109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On slower machines, startup can take some time,
set last values to current [us]time before actual test.

This caused test to fail, because first delta contained
time spent by test starting up:
getrusage04    0  TINFO  :  utime:         999us; stime:        6998us
getrusage04    0  TINFO  :  utime:         999us; stime:        6998us
getrusage04    1  TFAIL  :  stime increased > 1000us: delta = 6998us

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/getrusage/getrusage04.c |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)



--------------040008040001070609050109
Content-Type: text/x-patch;
	name="0001-getrusage04-initialise-us-last-to-current-values.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-getrusage04-initialise-us-last-to-current-values.patch"

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index e142d22..9801192 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -100,10 +100,12 @@ int main(int argc, char *argv[])
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0; i = 0;
-		ulast = 0, slast = 0;
 		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
 		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
 			usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
+		ulast = usage.ru_utime.tv_usec;
+		slast = usage.ru_stime.tv_usec;
+
 		while (i < RECORD_MAX) {
 			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
 			udelta = usage.ru_utime.tv_usec - ulast;


--------------040008040001070609050109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------040008040001070609050109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040008040001070609050109--

