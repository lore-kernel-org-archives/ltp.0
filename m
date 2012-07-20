Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SsAJK-0006Yj-1m
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 10:19:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SsAJE-000137-F3
	for ltp-list@lists.sourceforge.net; Fri, 20 Jul 2012 10:19:50 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6KAJcRZ027264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jul 2012 06:19:38 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q6KAJZ08009330
	for <ltp-list@lists.sourceforge.net>; Fri, 20 Jul 2012 06:19:38 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 Jul 2012 12:19:32 +0200
Message-Id: <6896d26b1d8405b5dd6f6c86dc6351bf829de3e7.1342777340.git.jstancek@redhat.com>
In-Reply-To: <cover.1342777340.git.jstancek@redhat.com>
References: <cover.1342777340.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH 2/2] update testcases to use flag for
	get_allowed_nodes()
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
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Interface of get_allowed_nodes() now requires a flag,
update all testcases using this interface.

Also fix some checkpatch warnings.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    5 +++--
 testcases/kernel/syscalls/mbind/mbind01.c          |    5 +++--
 .../kernel/syscalls/move_pages/move_pages02.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages03.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages04.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages05.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages06.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages07.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages08.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages09.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages10.c      |    5 +++--
 .../kernel/syscalls/move_pages/move_pages11.c      |    5 +++--
 .../syscalls/move_pages/move_pages_support.c       |    8 +++++---
 13 files changed, 41 insertions(+), 27 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0002-update-testcases-to-use-flag-for-get_allowed_nodes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-update-testcases-to-use-flag-for-get_allowed_nodes.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 9011980..d0e372c 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -234,8 +234,9 @@ static int do_test(struct test_case *tc)
 	unsigned long len = MEM_LENGTH;
 	int test_node = -1;
 
-	if ((ret = get_allowed_nodes(1, &test_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask = malloc(sizeof(nodemask_t));
 	nodemask_zero(nodemask);
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 1148324..2fc6f5a 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -220,8 +220,9 @@ static int do_test(struct test_case *tc)
 	unsigned long *invalid_nodemask;
 	int test_node = -1;
 
-	if ((ret = get_allowed_nodes(1, &test_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 1, &test_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 #if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 	nodemask = malloc(sizeof(nodemask_t));
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index 410e368..903de0c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -87,8 +87,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 77de94d..b216803 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -126,8 +126,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index acb4c78..5a09943 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -93,8 +93,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret	< 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index d2db475..fca97c3 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -127,8 +127,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 6929f8d..e414e4a 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -87,8 +87,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(1, &from_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 1, &from_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 4a1f96a..0027af6 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -87,8 +87,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 9b36a00..cd84d70 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -85,8 +85,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 8190a26..0d30a9e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -84,8 +84,9 @@ int main(int argc, char **argv)
 	unsigned int from_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(1, &from_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 1, &from_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index cec114c..7ea3900 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -87,8 +87,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 3d82c6f..96006cc 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -126,8 +126,9 @@ int main(int argc, char **argv)
 	unsigned int to_node;
 	int ret;
 
-	if ((ret = get_allowed_nodes(2, &from_node, &to_node)) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes: %d", ret);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index f7e3995..5a869ec 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -120,7 +120,8 @@ int alloc_pages_linear(void **pages, unsigned int num)
 	int *allowed_nodes;
 	int ret;
 
-	ret = get_allowed_nodes_arr(&num_allowed_nodes, &allowed_nodes);
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_allowed_nodes,
+		&allowed_nodes);
 	if (ret < 0)
 		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
 
@@ -223,7 +224,8 @@ void verify_pages_linear(void **pages, int *status, unsigned int num)
 	int *allowed_nodes;
 	int ret;
 
-	ret = get_allowed_nodes_arr(&num_allowed_nodes, &allowed_nodes);
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_allowed_nodes,
+		&allowed_nodes);
 	if (ret < 0)
 		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
 
@@ -396,7 +398,7 @@ void check_config(unsigned int min_nodes)
 	int num_allowed_nodes;
 	int ret;
 
-	ret = get_allowed_nodes_arr(&num_allowed_nodes, NULL);
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_allowed_nodes, NULL);
 	if (ret < 0)
 		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
 

--------------1.7.1
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
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



