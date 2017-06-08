From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 8 Jun 2017 14:41:14 +0800
Subject: [LTP] [PATCH 2/2] syscalls/splice05: check if splice supports
	stream af_unix sockets
In-Reply-To: <1496904074-25394-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1496904074-25394-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1496904074-25394-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On some older kernel(e.g, 3.10.0), test result should be TCONF instead
of TFAIL when splice does not support stream af_unix sockets as input.

This implement is introduced in kernel:
'2b514574f7e8(net: af_unix: implement splice for stream af_unix sockets)'

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/splice/splice05.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index d7edf8d..b65df4b 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -24,6 +24,7 @@
  */
 
 #define _GNU_SOURCE
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
@@ -90,6 +91,11 @@ static void pipe_socket(void)
 	for (i = num_len_data; i > 0; i = i - ret) {
 		ret = splice(sv[1], 0, pp2[1], NULL, i, 0);
 		if (ret == -1) {
+			if (errno == EINVAL) {
+				tst_res(TCONF | TERRNO, "splice doesn't "
+					"support stream af_unix sockets");
+				goto exit;
+			}
 			tst_res(TFAIL | TERRNO, "splice error");
 			goto exit;
 		}
-- 
1.8.3.1



