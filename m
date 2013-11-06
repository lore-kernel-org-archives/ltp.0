Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jlayton@redhat.com>) id 1Ve68X-0007k3-HV
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 16:39:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ve68T-0008Hi-RK
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 16:39:21 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rA6GdBIj002656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 11:39:11 -0500
Received: from sikun.lab.eng.rdu2.redhat.com (sikun.lab.eng.rdu2.redhat.com
	[10.8.0.43])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rA6GdB4t016905
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Nov 2013 11:39:11 -0500
From: Jeff Layton <jlayton@redhat.com>
Date: Wed,  6 Nov 2013 11:39:11 -0500
Message-Id: <1383755951-21231-1-git-send-email-jlayton@redhat.com>
Subject: [LTP] [PATCH] diotest3: fix -f argument
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

The '-f' argument to diotest3 is currently ignored. During options
processing it's copied to the buffer, then subsequently overwritten
by the default in a later sprintf() call.

Move the setting of the default prior to the options processing.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 testcases/kernel/io/direct_io/diotest3.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest3.c b/testcases/kernel/io/direct_io/diotest3.c
index ac460ed..002a6d0 100644
--- a/testcases/kernel/io/direct_io/diotest3.c
+++ b/testcases/kernel/io/direct_io/diotest3.c
@@ -238,6 +238,8 @@ int main(int argc, char *argv[])
 	int numchild = 1;	/* Number of children. Default 5 */
 	int i, fail_count = 0, failed = 0, total = 0;
 
+	sprintf(filename, "testdata-3.%ld", syscall(__NR_gettid));
+
 	/* Options */
 	while ((i = getopt(argc, argv, "b:o:i:n:f:")) != -1) {
 		switch (i) {
@@ -277,7 +279,6 @@ int main(int argc, char *argv[])
 			prg_usage();
 		}
 	}
-	sprintf(filename, "testdata-3.%ld", syscall(__NR_gettid));
 
 	setup();
 
-- 
1.7.1


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
