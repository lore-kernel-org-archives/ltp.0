From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 31 Jul 2019 15:50:51 +0800
Subject: [LTP] [PATCH] scenario_groups/default: remove the timers test
Message-ID: <20190731075051.5830-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The timers tests were merged into syscalls in commit 0051eab2,
remove the no-longer-exists timers from default test plan.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 scenario_groups/default | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scenario_groups/default b/scenario_groups/default
index e5b34782c..093f5f706 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -17,7 +17,6 @@ filecaps
 cap_bounds
 fcntl-locktests
 connectors
-timers
 power_management_tests
 hugetlb
 commands
-- 
2.17.1

