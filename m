From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  6 May 2020 18:04:07 +0100
Subject: [LTP] [PATCH] pty04: Correct struct member sizes and add to CVE
 runtest file
Message-ID: <20200506170407.5562-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also remove min_kver because it is arbitrary. We know this test works on much
older kernels, but it will probably hit bugs that have been fixed for a long
time.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                  |  1 +
 testcases/kernel/pty/pty04.c | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index c2e9e8c89..b9ab49c3b 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -50,3 +50,4 @@ cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
 cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
+cve-2020-11494 pty04
diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 239d2a870..2b9ff7e45 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -58,11 +58,11 @@ typedef uint32_t canid_t;
 
 struct can_frame {
 	canid_t can_id;
-	uint32_t can_dlc;
-	uint32_t __pad;
-	uint32_t __res0;
-	uint32_t __res1;
-	uint32_t data[CAN_MAX_DLEN] __attribute__((aligned(8)));
+	uint8_t can_dlc;
+	uint8_t __pad;
+	uint8_t __res0;
+	uint8_t __res1;
+	uint8_t data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 
 #include <stddef.h>
@@ -366,7 +366,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.needs_root = 1,
-	.min_kver = "4.10",
 	.tags = (const struct tst_tag[]){
 		{"linux-git", "b9258a2cece4ec1f020715fe3554bc2e360f6264"},
 		{"CVE", "CVE-2020-11494"},
-- 
2.26.1

