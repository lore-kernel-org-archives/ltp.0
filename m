Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SXqZi-0003XK-Ir
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXqZd-0006Bj-2f
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:46 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4P9CZee010921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 May 2012 05:12:35 -0400
Message-ID: <4FBF4D01.3090300@redhat.com>
Date: Fri, 25 May 2012 11:12:33 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000101050502050708040407"
Subject: [LTP] [PATCH 2/2] move_pages: dont use hardcoded node numbers
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
--------------000101050502050708040407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Use get_allowed_nodes() from move_pages_support to
pick first N nodes needed for test.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages02.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages03.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages04.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages05.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages06.c      |   10 ++++++++--
 .../kernel/syscalls/move_pages/move_pages07.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages08.c      |   12 ++++++++++--
 .../kernel/syscalls/move_pages/move_pages09.c      |    8 +++++++-
 .../kernel/syscalls/move_pages/move_pages10.c      |   13 ++++++++++---
 .../kernel/syscalls/move_pages/move_pages11.c      |   13 ++++++++++---
 10 files changed, 95 insertions(+), 26 deletions(-)



--------------000101050502050708040407
Content-Type: text/x-patch;
	name="0002-move_pages-dont-use-hardcoded-node-numbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-move_pages-dont-use-hardcoded-node-numbers.patch"

diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index cd0e914..efcd648 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -83,8 +83,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -156,4 +163,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 791835b..b206dbb 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -122,8 +122,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node ;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -223,4 +230,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 4de116b..0046cbf 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -89,8 +89,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -175,4 +182,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 6b2334b..8ee31a6 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -123,8 +123,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -237,4 +244,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 16e8206..362d6de 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -83,8 +83,14 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
+	unsigned int from_node;
 	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -152,4 +158,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 2d2b1d8..1b65f53 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -83,8 +83,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -163,4 +170,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 44c9acc..63c2a75 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -81,8 +81,16 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
+
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 3a626e8..14c9115 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -81,7 +81,13 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
+	unsigned int from_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 7af861b..9ffc966 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -83,8 +83,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -151,4 +158,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 747b9f0..7395281 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -122,8 +122,15 @@ int main(int argc, char **argv)
 #if HAVE_NUMA_MOVE_PAGES
 	unsigned int i;
 	int lc;			/* loop counter */
-	unsigned int from_node = 0;
-	unsigned int to_node = 1;
+	unsigned int from_node;
+	unsigned int to_node;
+	int num_allowed_nodes;
+	int *allowed_nodes;
+
+	get_allowed_nodes(&num_allowed_nodes, &allowed_nodes);
+	from_node = allowed_nodes[0];
+	to_node = allowed_nodes[1];
+	free(allowed_nodes);
 
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -241,4 +248,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }


--------------000101050502050708040407
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
--------------000101050502050708040407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000101050502050708040407--

