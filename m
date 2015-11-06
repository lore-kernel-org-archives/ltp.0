From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Fri,  6 Nov 2015 18:34:28 +0800
Subject: [LTP] [PATCH v2] containers/netns/netns_sysfs.sh:load dummy module
	before collecting sysfs interface
Message-ID: <1446806068-5388-1-git-send-email-shuang.qiu@oracle.com>
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
 testcases/kernel/containers/netns/netns_sysfs.sh |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 7dea52b..5e3ad7c 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -47,6 +47,9 @@ if [ $? -eq 1 ]; then
 	tst_brkm TBROK "unable to create a new network namespace"
 fi
 TST_CLEANUP=cleanup
+
+#Load dummy module before collecting sysfs interface
+lsmod | grep dummy || modprobe dummy 2>/dev/null
 ls /sys/class/net >sysfs_before
 
 ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
-- 
1.7.9.5

