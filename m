Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VRh8p-0000Eu-94
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VRh8o-00088Q-L3
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:23 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r93BWGm8021867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:16 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r93BWAKM025510
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:16 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  3 Oct 2013 13:32:06 +0200
Message-Id: <ac99f1c859b7e69d93ed09bc9223f2aabf325a5a.1380794505.git.jstancek@redhat.com>
In-Reply-To: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 3/3] pthread_attr_setschedpolicy/2-1.c: give threads a
	moment to block on mutex
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

Use small sleep for lack of better way to check that all threads
are blocked on mutex "mutex".

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 80ce906..1f8825a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -161,6 +161,9 @@ int main(void)
 	if (rc)
 		FAIL_AND_EXIT("create_thread HIGH", rc);
 
+	/* give threads a moment so they can block on mutex "mutex" */
+	sleep(2);
+
 	rc = pthread_mutex_unlock(&mutex);
 	if (rc)
 		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
