From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Fri, 28 Jun 2019 18:39:00 +0800
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
Message-ID: <20190628103900.10113-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The block_dev test in kernel_misc will taint kernel with a warning flag,
this is an expected behaviour.

However, if you run the cve-2017-17053 after it, as the test is looking
for a warning / died flag for a tainted kernel, it will cause false
alarm with:
  tst_taint.c:88: BROK: Kernel is already tainted: 14849

The kernel_misc test was executed before the cve test in the default
test plan. Move the kernel_misc test to the end of the list to
workaround this issue.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 scenario_groups/default | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index 1f3e5b27f..e5b34782c 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -22,7 +22,6 @@ power_management_tests
 hugetlb
 commands
 hyperthreading
-kernel_misc
 fs_ext4
 can
 cpuhotplug
@@ -30,3 +29,4 @@ net.ipv6_lib
 input
 cve
 crypto
+kernel_misc
-- 
2.17.1

