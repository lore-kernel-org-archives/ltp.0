From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Wed, 23 May 2018 12:27:26 +0800
Subject: [LTP] [PATCH] mcast-lib.sh: change the parameter of sysctl
Message-ID: <20180523042726.4476-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Exec the command of sysctl -qw on redhat6.10 will report below error message,
error: Unknown parameter "-qw"
usage:  sysctl [-n] [-e] variable ...
        sysctl [-n] [-e] [-q] -w variable=value ...
        sysctl [-n] [-e] -a
        sysctl [-n] [-e] [-q] -p <file>   (default /etc/sysctl.conf)
        sysctl [-n] [-e] [-q] --system
        sysctl [-n] [-e] -A
change the sysctl -qw xxx to sysctl -q -w xxx the test pass.

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 .../multicast/grp-operation/mcast-lib.sh      | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 13a445f55..6796f59f9 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -37,10 +37,10 @@ mcast_setup4()
 	[ "$igmp_max_memberships" -gt 5459 ] && tst_res TWARN \
 		"\$1 shouldn't be set higher than 5459 as it's used to set /proc/sys/net/ipv4/igmp_max_memberships"
 
-	ROD sysctl -qw net.ipv4.igmp_max_memberships=$igmp_max_memberships
-	ROD sysctl -qw net.ipv4.igmp_max_msf=10
-	ROD sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=0
-	ROD sysctl -qw net.ipv4.conf.all.force_igmp_version=0
+	ROD sysctl -q -w net.ipv4.igmp_max_memberships=$igmp_max_memberships
+	ROD sysctl -q -w net.ipv4.igmp_max_msf=10
+	ROD sysctl -q -w net.ipv4.conf.$(tst_iface).force_igmp_version=0
+	ROD sysctl -q -w net.ipv4.conf.all.force_igmp_version=0
 }
 
 mcast_setup6()
@@ -52,9 +52,9 @@ mcast_setup6()
 	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
 	SYSCTL_MLD_MAX_MSF=$(sysctl -b net.ipv6.mld_max_msf)
 
-	ROD sysctl -qw net.ipv6.conf.all.force_mld_version=0
-	ROD sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=0
-	ROD sysctl -qw net.ipv6.mld_max_msf=$default_mld_max_msf
+	ROD sysctl -q -w net.ipv6.conf.all.force_mld_version=0
+	ROD sysctl -q -w net.ipv6.conf.$(tst_iface).force_mld_version=0
+	ROD sysctl -q -w net.ipv6.mld_max_msf=$default_mld_max_msf
 }
 
 mcast_setup()
@@ -74,17 +74,17 @@ mcast_setup()
 
 mcast_cleanup4()
 {
-	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -qw net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
-	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -qw net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
-	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
-	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -qw net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
+	[ -n "$SYSFS_IGMP_MAX_MEMBERSHIPS" ] && sysctl -q -w net.ipv4.igmp_max_memberships=$SYSFS_IGMP_MAX_MEMBERSHIPS
+	[ -n "$SYSFS_IGMP_MAX_MSF" ] && sysctl -q -w net.ipv4.igmp_max_msf=$SYSFS_IGMP_MAX_MSF
+	[ -n "$SYSFS_FORCE_IGMP_VERSION" ] && sysctl -q -w net.ipv4.conf.$(tst_iface).force_igmp_version=$SYSFS_FORCE_IGMP_VERSION
+	[ -n "$SYSFS_ALL_FORCE_IGMP_VERSION" ] && sysctl -q -w net.ipv4.conf.all.force_igmp_version=$SYSFS_ALL_FORCE_IGMP_VERSION
 }
 
 mcast_cleanup6()
 {
-	[ -n "$SYSCTL_ALL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.all.force_mld_version=$SYSCTL_ALL_FORCE_MLD_VERSION
-	[ -n "$SYSCTL_FORCE_MLD_VERSION" ] && sysctl -qw net.ipv6.conf.$(tst_iface).force_mld_version=$SYSCTL_FORCE_MLD_VERSION
-	[ -n "$SYSCTL_MLD_MAX_MSF" ] && sysctl -qw net.ipv6.mld_max_msf=$SYSCTL_MLD_MAX_MSF
+	[ -n "$SYSCTL_ALL_FORCE_MLD_VERSION" ] && sysctl -q -w net.ipv6.conf.all.force_mld_version=$SYSCTL_ALL_FORCE_MLD_VERSION
+	[ -n "$SYSCTL_FORCE_MLD_VERSION" ] && sysctl -q -w net.ipv6.conf.$(tst_iface).force_mld_version=$SYSCTL_FORCE_MLD_VERSION
+	[ -n "$SYSCTL_MLD_MAX_MSF" ] && sysctl -q -w net.ipv6.mld_max_msf=$SYSCTL_MLD_MAX_MSF
 }
 
 mcast_cleanup()
-- 
2.17.0



