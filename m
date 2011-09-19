Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5Xy2-00066M-NW
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:08:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5Xy1-00006s-Ko
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:08:38 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J78V3k009529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:08:31 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p8J78Uno023913
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:08:31 -0400
Message-ID: <4E76EA6E.40004@redhat.com>
Date: Mon, 19 Sep 2011 09:08:30 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090403040400040306060202"
Subject: [LTP] [PATCH] cpuset_base_ops_testset.sh: drop
 sched_relax_domain_level test
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
--------------090403040400040306060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


At the moment we don't have reliable way to enumerate
all possible values, which can be used. They are dependent
on both kernel version and kernel config.

Based on previous discussion here:
http://article.gmane.org/gmane.linux.ltp/14146/match=sched_relax_domain_level
it seems better to get rid of this testcase, rather than testing
internal knobs, which can change at anytime.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  .../cpuset_base_ops_testset.sh                     |   27 
+-------------------
  1 files changed, 1 insertions(+), 26 deletions(-)



--------------090403040400040306060202
Content-Type: text/x-patch;
	name="0001-cpuset_base_ops_testset.sh-drop-sched_relax_domain_l.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cpuset_base_ops_testset.sh-drop-sched_relax_domain_l.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 2b1016e..1b84996 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -176,28 +176,6 @@ test_flags()
 	done # for filename in flagfiles
 }
 
-test_domain()
-{
-	cfile_name="sched_relax_domain_level"
-	while read domain_level result
-	do
-		base_op_test "$CPUSET/sched_relax_domain_level" "$domain_level" "$result"
-	done <<- EOF
-		NULL	0
-		0	0
-		1	1
-		2	2
-		3	3
-		4	4
-		5	5
-		6	WRITE_ERROR
-		-1	-1
-		-2	WRITE_ERROR
-		A	WRITE_ERROR
-	EOF
-	# while read domain_level result
-}
-
 # attach_task_test <cpus> <mems> <expect>
 attach_task_test()
 {
@@ -288,10 +266,7 @@ test_mems
 # Case 36-83
 test_flags
 
-# Case 84-94
-test_domain
-
-# Case 95-97
+# Case 84-86
 test_attach_task
 
 exit $exit_status


--------------090403040400040306060202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
Learn about the latest advances in developing for the 
BlackBerry&reg; mobile platform with sessions, labs & more.
See new tools and technologies. Register for BlackBerry&reg; DevCon today!
http://p.sf.net/sfu/rim-devcon-copy1 
--------------090403040400040306060202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090403040400040306060202--

