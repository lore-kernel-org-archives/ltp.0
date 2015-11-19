From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Nov 2015 17:49:09 +0800
Subject: [LTP] [PATCH] controllers/cpuacct: remove obsolete cpuacct
Message-ID: <1447926549-26676-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove obsolete testcase cpuacct since it has been rewritten.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/cpuacct         | 2 --
 scenario_groups/default | 1 -
 2 files changed, 3 deletions(-)
 delete mode 100644 runtest/cpuacct

diff --git a/runtest/cpuacct b/runtest/cpuacct
deleted file mode 100644
index 11279f9..0000000
--- a/runtest/cpuacct
+++ /dev/null
@@ -1,2 +0,0 @@
-cpuacct01 run_cpuacct_test.sh 1
-cpuacct02 run_cpuacct_test.sh 2
diff --git a/scenario_groups/default b/scenario_groups/default
index 60b1b27..de6bc88 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -29,7 +29,6 @@ modules
 fs_ext4
 pipes
 dma_thread_diotest
-cpuacct
 can
 cpuhotplug
 ipv6_lib
-- 
1.8.3.1

