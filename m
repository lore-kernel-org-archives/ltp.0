From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Jun 2017 08:23:08 +0800
Subject: [LTP] [PATCH v2] syscalls/splice05: check if splice supports stream
	af_unix sockets
In-Reply-To: <1496904074-25394-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1496904074-25394-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1497399788-3331-1-git-send-email-yangx.jy@cn.fujitsu.com>
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
 testcases/kernel/syscalls/splice/splice05.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index d7edf8d..01e2145 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -24,6 +24,7 @@
  */
 
 #define _GNU_SOURCE
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
@@ -90,7 +91,12 @@ static void pipe_socket(void)
 	for (i = num_len_data; i > 0; i = i - ret) {
 		ret = splice(sv[1], 0, pp2[1], NULL, i, 0);
 		if (ret == -1) {
-			tst_res(TFAIL | TERRNO, "splice error");
+			if (errno == EINVAL) {
+				tst_res(TCONF, "splice doesn't support "
+					"stream af_unix sockets as input");
+			} else {
+				tst_res(TFAIL | TERRNO, "splice error");
+			}
 			goto exit;
 		}
 		SAFE_READ(1, pp2[0], arr_out + num_len_data - i, ret);
-- 
1.8.3.1



