Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ScFM6-00008z-TR
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 12:28:54 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ScFM2-0006Sb-Vh
	for ltp-list@lists.sourceforge.net; Wed, 06 Jun 2012 12:28:54 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q56CSj5v025752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jun 2012 08:28:45 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q56CSiuo020825
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jun 2012 08:28:44 -0400
Message-ID: <4FCF4CFC.2010100@redhat.com>
Date: Wed, 06 Jun 2012 14:28:44 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010304050400040806070703"
Subject: [LTP] [PATCH v2] dio_sparse: prevent race between kill and signal
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

This is a multi-part message in MIME format.
--------------010304050400040806070703
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


This is same change as in:
  commit d8f1292181b486b2073cc6fe1ec226f5cedea342
  Author: Cyril Hrubis <chrubis@suse.cz>
  Date:   Fri Mar 2 13:37:47 2012 +0100
      ltp-aiodio: aiodio_sparse fix race condition

but for dio_sparse.c, which is also prone to race
between kill() and signal().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)



--------------010304050400040806070703
Content-Type: text/x-patch;
	name="0001-dio_sparse-prevent-race-between-kill-and-signal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-dio_sparse-prevent-race-between-kill-and-signal.patch"

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index e93dcd9..97dbef8 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -149,10 +149,10 @@ int main(int argc, char **argv)
 	dirty_freeblocks(filesize);
 
 	tst_resm(TINFO, "Starting I/O tests");
+	signal(SIGTERM, SIG_DFL);
 	for (i = 0; i < num_children; i++) {
 		switch (pid[i] = fork()) {
 		case 0:
-			signal(SIGTERM, SIG_DFL);
 			read_sparse(filename, filesize);
 		break;
 		case -1:
@@ -164,6 +164,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 	
 	ret = dio_sparse(filename, alignment, writesize, filesize);
 


--------------010304050400040806070703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------010304050400040806070703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010304050400040806070703--

