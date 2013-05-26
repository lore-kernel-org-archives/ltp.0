Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1UgUwA-0008Tc-9O
	for ltp-list@lists.sourceforge.net; Sun, 26 May 2013 07:00:14 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UgUw8-0000aA-UU
	for ltp-list@lists.sourceforge.net; Sun, 26 May 2013 07:00:14 +0000
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r4Q2vjqZ008147
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Sat, 25 May 2013 19:58:35 -0700 (PDT)
From: <jin.li@windriver.com>
Date: Sun, 26 May 2013 10:57:42 +0800
Message-ID: <1369537062-26852-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1369537062-26852-1-git-send-email-jin.li@windriver.com>
References: <1369537062-26852-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Add test groups into POSIX execution script
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

Add the following test groups into execution script run-posix-option-group-test.sh

fsync, fork, getpid

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 .../bin/run-posix-option-group-test.sh             |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
index 17f6e49..977d805 100755
--- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
+++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
@@ -33,6 +33,7 @@ AIO)
 	echo "Executing asynchronous I/O tests"
 	run_option_group_tests "$BASEDIR/aio_*"
 	run_option_group_tests "$BASEDIR/lio_listio"
+	run_option_group_tests "$BASEDIR/fsync"
 	;;
 SIG)
 	echo "Executing signals tests"
@@ -65,6 +66,8 @@ MSG)
 TPS)
 	echo "Executing process and thread scheduling tests"
 	run_option_group_tests "$BASEDIR/*sched*"
+	run_option_group_tests "$BASEDIR/fork"
+	run_option_group_tests "$BASEDIR/getpid"
 	;;
 MEM)
 	echo "Executing mapped, process and shared memory tests"
-- 
1.7.4.1


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
