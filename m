From: Paul Lawrence <paullawrence@google.com>
Date: Mon,  6 May 2019 08:38:36 -0700
Subject: [LTP] [PATCH] ANDROID: Fix ioctl03 test for Android
Message-ID: <20190506153836.232148-1-paullawrence@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android has tun file at /dev/tun not /dev/net/tun

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index b1b50edb4..cc9a2edaf 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -79,6 +79,11 @@ static void verify_features(void)
 	unsigned int features, i;
 
 	int netfd = open("/dev/net/tun", O_RDWR);
+
+	/* Android has tun at /dev/tun */
+	if (netfd == -1 && (errno == ENODEV || errno == ENOENT))
+		netfd = open("/dev/tun", O_RDWR);
+
 	if (netfd == -1) {
 		if (errno == ENODEV || errno == ENOENT)
 			tst_brk(TCONF, "TUN support is missing?");
-- 
2.21.0.1020.gf2820cf01a-goog

