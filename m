Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzM2W-00008R-BU
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:12 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzM2V-00008d-1O
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:12 +0000
Received: by pbcwy7 with SMTP id wy7so334179pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 23:16:05 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Aug 2012 14:15:38 +0800
Message-Id: <c72d6c4c98600ecb26fb3dd55d70518fd3bdacfe.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH resend 2/6] update testcases to use flag for
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
To: LTP List <ltp-list@lists.sourceforge.net>

From: Jan Stancek <jstancek@redhat.com>

This is a multi-part message in MIME format.
--------------1.7.8.6
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


--------------1.7.8.6
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
 

--------------1.7.8.6
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
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



