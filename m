From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Fri, 30 Oct 2015 16:57:50 +0800
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
	before collecting sysfs interface
Message-ID: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

If dummy is compiled as module in kernel,it is loaded dynamically when
adding dummy device.And it will also create a default dummy interface.So
the sysfs_after will have one more interface than sysfs_before which
makes testcase #3 failed.Loading dummy module before collecting sysfs
interface to workaround such issue.
Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/containers/netns/netns_sysfs.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 7dea52b..b5791bd 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -47,6 +47,10 @@ if [ $? -eq 1 ]; then
 	tst_brkm TBROK "unable to create a new network namespace"
 fi
 TST_CLEANUP=cleanup
+
+#Load dummy module before collecting sysfs interface
+lsmod | grep dummy || modprobe dummy
+[ $? -eq 0 ] || tst_brkm TBROK "failed to load dummy module"
 ls /sys/class/net >sysfs_before
 
 ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
-- 
1.7.7

