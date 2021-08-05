From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 14:27:35 +0800
Subject: [LTP] [PATCH] userns/userns08.c: Enable userns in
 max_user_namespaces file
Message-ID: <1628144855-5924-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On old distros ie centos7, the default value of max_user_namespaces is set to 0.
Enable it by increasing this value.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/containers/userns/userns08.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index aedfc6c4e..0910ea7d4 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -120,6 +120,11 @@ static void setup(void)
 
 	SAFE_WRITE(fd, 1, "\n", 1);
 	SAFE_CLOSE(fd);
+
+	/* The default value of max_user_namespaces is set to 0 on some distros,
+	 * We need to change the default value to call clone().
+	 */
+	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 }
 
 static struct tst_test test = {
@@ -133,6 +138,10 @@ static struct tst_test test = {
 		"CONFIG_USER_NS",
 		NULL
 	},
+	.save_restore = (const char * const[]) {
+		"?/proc/sys/user/max_user_namespaces",
+		NULL,
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d2f007dbe7e4"},
 		{"CVE", "CVE-2018-18955"},
-- 
2.23.0

