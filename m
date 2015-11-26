From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu, 26 Nov 2015 12:32:58 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh: removed invalid
	excess line
Message-ID: <1448537578-21310-1-git-send-email-mmarhefk@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/netns/netns_sysfs.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index b951f32..4c6e7e4 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -52,8 +52,6 @@ TST_CLEANUP=cleanup
 # by the dummy device driver upon insmod/modprobe (during ip link add)
 ls /sys/class/net | grep -v 'dummy[0-9]\+' >sysfs_before
 
-ls /sys/class/net >sysfs_before
-
 ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
 ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
 	tst_brkm TBROK "failed to add a new dummy device"
-- 
2.4.3

