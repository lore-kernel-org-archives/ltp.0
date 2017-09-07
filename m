From: Sandeep Patil <sspatil@google.com>
Date: Thu,  7 Sep 2017 16:54:49 -0700
Subject: [LTP] [PATCH] android: libltp: add new variant for loopback block
	device paths
Message-ID: <20170907235449.112545-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android systems put loopback devices at "/dev/block/loopX", add that
variant in libltp so they can be found by the tests that need them.

E.g. of test getting fixed by this on Android, syscalls.ioctol05

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 lib/tst_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 936bbfd03..67432caf6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -48,7 +48,8 @@ static int device_acquired;
 
 static const char *dev_variants[] = {
 	"/dev/loop%i",
-	"/dev/loop/%i"
+	"/dev/loop/%i",
+	"/dev/block/loop%i"
 };
 
 static int set_dev_path(int dev)
-- 
2.14.1.581.gf28d330327-goog

