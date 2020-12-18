From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Dec 2020 09:06:31 +0200
Subject: [LTP] [PATCH 3/3] syscalls/inotify10: Test two inotify groups with
 parent and child watches
In-Reply-To: <20201218070631.1182292-1-amir73il@gmail.com>
References: <20201218070631.1182292-1-amir73il@gmail.com>
Message-ID: <20201218070631.1182292-4-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a test case for commit fecc4559780d that fixes a bug introduced in
kernel v5.9:

     fsnotify: fix events reported to watching parent and child

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify10.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 17aafc773..eb2322090 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -8,6 +8,10 @@
  *     Check that event is reported to watching parent and watching child
  *     based on their interest
  *
+ * Test case #3 is a regression test for commit fecc4559780d that fixes
+ * a bug introduced in kernel v5.9:
+ *
+ *     fsnotify: fix events reported to watching parent and child
  */
 
 #include "config.h"
@@ -63,6 +67,11 @@ static struct tcase {
 		IN_ATTRIB, 0, 0,
 		0, IN_ATTRIB, IN_ATTRIB,
 	},
+	{
+		"Two Groups with parent and child watches for different events",
+		IN_ATTRIB, IN_OPEN, IN_OPEN,
+		IN_OPEN, IN_ATTRIB, IN_ATTRIB,
+	},
 };
 
 struct event_t event_set[EVENT_MAX];
@@ -199,6 +208,10 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_inotify,
 	.tcnt = ARRAY_SIZE(tcases),
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fecc4559780d"},
+		{}
+	}
 };
 
 #else
-- 
2.25.1

