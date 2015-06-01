Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1YzGMt-00056c-G8
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 03:26:27 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YzGMn-0008QP-7U
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 03:26:27 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Mon, 1 Jun 2015 05:30:30 -0600
Message-ID: <1433158230-3452-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix the return value error of read_shares_file.
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
To: ltp-list@lists.sourceforge.net

See the following in the read_file function.
*value = read_shares_file(filepath);
if (*value == -1)
	return -1;
Since the return value of read_shares_file and the variable value are
unsigned int, it is impossible that *value == -1.

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/controllers/libcontrollers/libcontrollers.c | 6 ++++--
 testcases/kernel/controllers/libcontrollers/libcontrollers.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.c b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
index b01e1b8..80a90b9 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.c
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.c
@@ -115,11 +115,14 @@ int read_file(char *filepath, int action, unsigned int *value)
 {
 	int num_line = 0;
 	FILE *fp;
+	int tmp;
 	switch (action) {
 	case GET_SHARES:
-		*value = read_shares_file(filepath);
+		tmp = read_shares_file(filepath);
 		if (*value == -1)
 			return -1;
+		else
+			*value = (unsigned int)tmp;
 		break;
 
 	case GET_TASKS:
@@ -159,7 +162,6 @@ inline int error_function(char *msg1, char *msg2)
  * the given pointer location. Returns 0 if success
  */
 
-unsigned
 int read_shares_file(char *filepath)
 {
 	FILE *fp;
diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
index 4001555..78a7fed 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
@@ -72,7 +72,7 @@ enum{
 
 inline int error_function(char *msg1, char *msg2);
 
-unsigned int read_shares_file (char *filepath);
+int read_shares_file(char *filepath);
 
 int read_file(char *filepath, int action, unsigned int *value);
 
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
