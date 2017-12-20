From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Dec 2017 21:11:00 +0800
Subject: [LTP] [PATCH v3 2/2] ioctl: convert ioctl03 to new API
In-Reply-To: <20171220131100.29348-1-liwang@redhat.com>
References: <20171220131100.29348-1-liwang@redhat.com>
Message-ID: <20171220131100.29348-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl03.c | 101 ++++++++++++------------------
 1 file changed, 41 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl03.c b/testcases/kernel/syscalls/ioctl/ioctl03.c
index 8c3d446..d4931b9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl03.c
@@ -1,41 +1,35 @@
 /*
- *
- * Copyright (c) Rusty Russell <rusty@rustcorp.com.au>
  * Copyright (c) International Business Machines  Corp., 2008
+ * Copyright (c) Linux Test Project, 2017
  *
- * This program is free software;  you can redistribute it and/or modify
+ * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
+ * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 /*
- *
- *
  * File:        ioctl03.c
  *
  * Description: This program tests whether all the valid IFF flags are
  *              returned properly by implementation of TUNGETFEATURES ioctl
  *              on kernel 2.6.27
  *
- * Total Tests: 1
- *
  * Test Name:   ioctl03
  *
  * Author:      Rusty Russell <rusty@rustcorp.com.au>
  *
- * History:     Created - Nov 28 2008 - Rusty Russell <rusty@rustcorp.com.au>
- *              Ported to LTP
- *                      - Nov 28 2008 - Subrata <subrata@linux.vnet.ibm.com>
+ * history:     created - nov 28 2008 - rusty russell <rusty@rustcorp.com.au>
+ *              ported to ltp
+ *                      - nov 28 2008 - subrata <subrata@linux.vnet.ibm.com>
  */
 
 #include <sys/types.h>
@@ -43,10 +37,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <stdio.h>
 #include <linux/if_tun.h>
-
-#include "test.h"
+#include "tst_test.h"
 
 #ifndef TUNGETFEATURES
 #define TUNGETFEATURES _IOR('T', 207, unsigned int)
@@ -61,67 +53,56 @@
 #endif
 
 #ifndef IFF_NAPI
-#define IFF_NAPI       0x0010
+#define IFF_NAPI	0x0010
 #endif
 
 #ifndef IFF_NAPI_FRAGS
-#define IFF_NAPI_FRAGS 0x0020
+#define IFF_NAPI_FRAGS	0x0020
 #endif
 
-char *TCID = "ioctl03";
-int TST_TOTAL = 1;
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
 static struct {
 	unsigned int flag;
 	const char *name;
 } known_flags[] = {
-	{
-	IFF_TUN, "TUN"}, {
-	IFF_TAP, "TAP"}, {
-	IFF_NO_PI, "NO_PI"}, {
-	IFF_ONE_QUEUE, "ONE_QUEUE"}, {
-	IFF_VNET_HDR, "VNET_HDR"}, {
-	IFF_MULTI_QUEUE, "MULTI_QUEUE"}, {
-	IFF_NAPI, "IFF_NAPI"}, {
-	IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
+	{IFF_TUN, "TUN"},
+	{IFF_TAP, "TAP"},
+	{IFF_NO_PI, "NO_PI"},
+	{IFF_ONE_QUEUE, "ONE_QUEUE"},
+	{IFF_VNET_HDR, "VNET_HDR"},
+	{IFF_MULTI_QUEUE, "MULTI_QUEUE"},
+	{IFF_NAPI, "IFF_NAPI"},
+	{IFF_NAPI_FRAGS, "IFF_NAPI_FRAGS"}
 };
 
-int main(void)
+static void verify_features(void)
 {
 	unsigned int features, i;
 
-	setup();
-	tst_require_root();
-
 	int netfd = open("/dev/net/tun", O_RDWR);
-	if (netfd < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "opening /dev/net/tun failed");
+	if (netfd == -1) {
+		if (errno == ENODEV)
+			tst_brk(TCONF, "Kernel does not load TUN module");
+
+		tst_brk(TBROK | TERRNO, "opening /dev/net/tun failed");
+	}
 
-	if (ioctl(netfd, TUNGETFEATURES, &features) != 0)
-		tst_brkm(TCONF, cleanup,
-			 "Kernel does not support TUNGETFEATURES");
-	tst_resm(TINFO, "Available features are: %#x", features);
-	for (i = 0; i < sizeof(known_flags) / sizeof(known_flags[0]); i++) {
+	SAFE_IOCTL(netfd, TUNGETFEATURES, &features);
+
+	tst_res(TINFO, "Available features are: %#x", features);
+	for (i = 0; i < ARRAY_SIZE(known_flags); i++) {
 		if (features & known_flags[i].flag) {
 			features &= ~known_flags[i].flag;
-			tst_resm(TINFO, "%s %#x", known_flags[i].name,
+			tst_res(TPASS, "%s %#x", known_flags[i].name,
 				 known_flags[i].flag);
 		}
 	}
 	if (features)
-		tst_resm(TFAIL, "(UNKNOWN %#x)", features);
-	cleanup();
-	tst_exit();
+		tst_res(TFAIL, "(UNKNOWN %#x)", features);
+
+	SAFE_CLOSE(netfd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_features,
+	.needs_root = 1,
+};
-- 
2.9.3

