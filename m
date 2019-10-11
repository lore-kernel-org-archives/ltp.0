From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 11:07:36 +0200
Subject: [LTP] [PATCH 1/2] shell: Rename s/tst_test_cmds/tst_require_cmds/
In-Reply-To: <20191011090737.17997-1-lkml@jv-coder.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
Message-ID: <20191011090737.17997-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This require describes the function of the command better than test.
"tst_require_root" is also a well established name in ltp api with the
same semantic.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 doc/test-writing-guidelines.txt                        |  2 +-
 testcases/commands/mkfs/mkfs01.sh                      |  2 +-
 testcases/kernel/containers/netns/netns_breakns.sh     |  2 +-
 testcases/kernel/containers/netns/netns_helper.sh      |  4 ++--
 .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh   |  2 +-
 .../kernel/controllers/memcg/functional/memcg_lib.sh   |  4 ++--
 testcases/kernel/device-drivers/zram/zram01.sh         |  2 +-
 testcases/kernel/device-drivers/zram/zram_lib.sh       |  6 +++---
 .../ext4-delalloc-mballoc/ext4-alloc-test.sh           |  2 +-
 .../ext4-journal-checksum/ext4_journal_checksum.sh     |  2 +-
 .../ext4-online-defrag/ext4_online_defrag_test.sh      |  4 ++--
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh      |  2 +-
 testcases/kernel/fs/iso9660/isofs.sh                   |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh     |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh     |  2 +-
 testcases/kernel/io/stress_floppy/stress_floppy        |  2 +-
 testcases/kernel/power_management/runpwtests05.sh      |  2 +-
 .../kernel/power_management/runpwtests_exclusive01.sh  |  2 +-
 .../kernel/power_management/runpwtests_exclusive02.sh  |  2 +-
 .../kernel/power_management/runpwtests_exclusive03.sh  |  2 +-
 .../kernel/power_management/runpwtests_exclusive04.sh  |  2 +-
 .../kernel/power_management/runpwtests_exclusive05.sh  |  2 +-
 testcases/lib/test.sh                                  |  2 +-
 testcases/lib/tst_net.sh                               | 10 +++++-----
 testcases/lib/tst_test.sh                              |  8 ++++----
 testcases/network/multicast/mc_commo/mc_commo.sh       |  2 +-
 testcases/network/multicast/mc_member/mc_member.sh     |  2 +-
 testcases/network/stress/dns/dns-stress.sh             |  2 +-
 testcases/network/stress/ftp/ftp-download-stress.sh    |  2 +-
 .../network/stress/ftp/ftp-download-stress01-rmt.sh    |  2 +-
 .../network/stress/ftp/ftp-download-stress02-rmt.sh    |  2 +-
 testcases/network/stress/ftp/ftp-upload-stress.sh      |  4 ++--
 .../network/stress/ftp/ftp-upload-stress01-rmt.sh      |  2 +-
 .../network/stress/ftp/ftp-upload-stress02-rmt.sh      |  2 +-
 testcases/network/stress/http/http-stress01-rmt.sh     |  2 +-
 testcases/network/stress/http/http-stress02-rmt.sh     |  2 +-
 testcases/network/stress/interface/if-lib.sh           |  2 +-
 testcases/network/stress/ns-tools/tst_net_stress.sh    |  2 +-
 testcases/network/stress/ssh/ssh-stress.sh             |  2 +-
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh        |  2 +-
 testcases/network/tcp_cmds/ping/ping01.sh              |  2 +-
 testcases/network/tcp_cmds/ping/ping02.sh              |  2 +-
 testcases/network/tcp_cmds/rlogin/rlogin01.sh          |  2 +-
 testcases/network/tcp_cmds/sendfile/sendfile01.sh      |  2 +-
 testcases/network/tcp_cmds/tcpdump/tcpdump01.sh        |  2 +-
 testcases/network/tcp_cmds/telnet/telnet01.sh          |  2 +-
 testcases/network/tcp_cmds/tracepath/tracepath01.sh    |  2 +-
 testcases/network/virt/virt_lib.sh                     |  4 ++--
 testcases/network/xinetd/xinetd_tests.sh               |  2 +-
 49 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6da87baa7..176fc2b06 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2150,7 +2150,7 @@ TST_NEEDS_CMDS="modinfo modprobe"
 Setting '$TST_NEEDS_CMDS' to a string listing required commands will check for
 existence each of them and exits the test with 'TCONF' on first missing.
 
-Alternatively the 'tst_test_cmds()' function can be used to do the same on
+Alternatively the 'tst_require_cmds()' function can be used to do the same on
 runtime, since sometimes we need to the check at runtime too.
 
 'tst_check_cmds()' can be used for requirements just for a particular test
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 16b1a8fab..81f1a168c 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -37,7 +37,7 @@ parse_args()
 setup()
 {
 	if [ -n "$TST_FS_TYPE" ]; then
-		tst_test_cmds mkfs.${TST_FS_TYPE}
+		tst_require_cmds mkfs.${TST_FS_TYPE}
 	fi
 
 	ROD_SILENT mkdir -p mntpoint
diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
index 3ef8f9896..c7aa2c34c 100755
--- a/testcases/kernel/containers/netns/netns_breakns.sh
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -61,7 +61,7 @@ fi
 
 
 # TEST CASE #2
-tst_test_cmds ifconfig
+tst_require_cmds ifconfig
 $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK 2>/dev/null
 if [ $? -ne 0 ]; then
 	tst_resm TPASS "controlling device over ioctl"
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a9d045964..c765a0cb9 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -110,7 +110,7 @@ tst_check_iproute()
 netns_setup()
 {
 	tst_require_root
-	tst_test_cmds ip modprobe
+	tst_require_cmds ip modprobe
 
 	modprobe veth > /dev/null 2>&1
 
@@ -139,7 +139,7 @@ netns_setup()
 		;;
 	ioctl)
 		USE_IFCONFIG=1
-		tst_test_cmds ifconfig
+		tst_require_cmds ifconfig
 		;;
 	*)
 		tst_brkm TBROK \
diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index f6083756a..5594fe9de 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -83,7 +83,7 @@ create_subgroup()
 setup()
 {
     tst_require_root
-    tst_test_cmds killall
+    tst_require_cmds killall
 
     if [ ! -f /proc/cgroups ]; then
         tst_brkm TCONF "Kernel does not support for control groups"
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index aadaae4d2..22ef4f5e2 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -35,7 +35,7 @@ if [ $? -ne 0 ]; then
 fi
 
 # Check for dependencies
-tst_test_cmds killall
+tst_require_cmds killall
 
 # Post 4.16 kernel updates stat in batch (> 32 pages) every time
 PAGESIZES=$(( $PAGESIZE * 33 ))
@@ -83,7 +83,7 @@ TST_CLEANUP=cleanup
 
 shmmax_setup()
 {
-	tst_test_cmds bc
+	tst_require_cmds bc
 
 	shmmax=`cat /proc/sys/kernel/shmmax`
 	if [ $(echo "$shmmax < $HUGEPAGESIZE" |bc) -eq 1 ]; then
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 9508211ab..cabe40d0b 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -58,7 +58,7 @@ TST_CLEANUP="zram_cleanup"
 
 zram_fill_fs()
 {
-	tst_test_cmds awk bc dd free
+	tst_require_cmds awk bc dd free
 	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
 
 	for i in $(seq 0 $(($dev_num - 1))); do
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index d0e7704a8..d51b527f6 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -155,7 +155,7 @@ zram_set_memlimit()
 zram_makeswap()
 {
 	tst_resm TINFO "make swap with zram device(s)"
-	tst_test_cmds mkswap swapon swapoff
+	tst_require_cmds mkswap swapon swapoff
 	local i=0
 	for i in $(seq 0 $(($dev_num - 1))); do
 		mkswap /dev/zram$i > err.log 2>&1
@@ -179,7 +179,7 @@ zram_makeswap()
 
 zram_swapoff()
 {
-	tst_test_cmds swapoff
+	tst_require_cmds swapoff
 	local i=
 	for i in $(seq 0 $dev_makeswap); do
 		swapoff /dev/zram$i > err.log 2>&1
@@ -195,7 +195,7 @@ zram_swapoff()
 
 zram_makefs()
 {
-	tst_test_cmds mkfs
+	tst_require_cmds mkfs
 	local i=0
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index 25ebdafc6..4ead8096d 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -117,7 +117,7 @@ ext4_test_delalloc_mballoc()
 # main
 ext4_setup
 
-tst_test_cmds ffsb
+tst_require_cmds ffsb
 
 DELALLOC=( "delalloc" "nodelalloc" )
 DIRECT_IO=( 0 1 )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 9edb89397..7674f78b0 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -94,7 +94,7 @@ ext4_test_journal_checksum()
 # main
 ext4_setup
 
-tst_test_cmds ffsb
+tst_require_cmds ffsb
 
 DATA=( "writeback" "ordered" "journal" )
 COMMIT=( 1 100 )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
index 11261e470..2dee00972 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh
@@ -35,7 +35,7 @@ FILE=1
 DIR=2
 FILESYSTEM=3
 
-tst_test_cmds e4defrag
+tst_require_cmds e4defrag
 E4DEFRAG=`which e4defrag`
 
 age_filesystem()
@@ -161,7 +161,7 @@ ext4_test_online_defrag()
 # main
 ext4_setup
 
-tst_test_cmds ffsb
+tst_require_cmds ffsb
 
 DEFRAG=( $FILE $DIR $FILESYSTEM )
 AGING=( $EMPTY $SMALL $LARGE )
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index d39afae56..8baca7857 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -114,7 +114,7 @@ ext4_test_uninit_groups()
 # main
 ext4_setup
 
-tst_test_cmds ffsb
+tst_require_cmds ffsb
 
 ORLOV=( "orlov" "oldalloc" )
 DELALLOC=( "delalloc" "nodelalloc" )
diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 71eb35b1c..5f90354d9 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -102,7 +102,7 @@ gen_fs_tree "$MAKE_FILE_SYS_DIR" 1
 # Make ISO9660 file system with different options.
 # Mount the ISO9660 file system with different mount options.
 
-tst_test_cmds mkisofs
+tst_require_cmds mkisofs
 
 for mkisofs_opt in \
 	" " \
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
index 9bafcd180..1ba937cc7 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
@@ -109,7 +109,7 @@ done
 
 LOOP_COUNT=1
 
-tst_test_cmds perl
+tst_require_cmds perl
 
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index 2828da578..95a8f4a2d 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -59,7 +59,7 @@ done
 
 LOOP_COUNT=1
 
-tst_test_cmds sar
+tst_require_cmds sar
 
 if [ $(get_present_cpus_num) -lt 2 ]; then
 	tst_brkm TCONF "system doesn't have required CPU hotplug support"
diff --git a/testcases/kernel/io/stress_floppy/stress_floppy b/testcases/kernel/io/stress_floppy/stress_floppy
index deb939000..7510f0888 100755
--- a/testcases/kernel/io/stress_floppy/stress_floppy
+++ b/testcases/kernel/io/stress_floppy/stress_floppy
@@ -40,7 +40,7 @@ setup()
 {
 	tst_tmpdir
 
-	tst_test_cmds fdformat tar dump cpio dd mkfs mkdosfs
+	tst_require_cmds fdformat tar dump cpio dd mkfs mkdosfs
 
 	TCtmp=$(pwd)
 }
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
index 43e234d01..1c87d8d0c 100755
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ b/testcases/kernel/power_management/runpwtests05.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 if ! grep sched_debug -qw /proc/cmdline ; then
 	tst_brkm TCONF "Kernel cmdline parameter 'sched_debug' needed," \
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
index 9fefcbf6e..3a824e5eb 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
index 2cd0ecb05..fa445185e 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
@@ -33,7 +33,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
index ab3a5d11d..0d5724825 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
index 438ef603f..15e031a43 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
@@ -27,7 +27,7 @@ export TST_TOTAL=2
 # Checking test environment
 check_kervel_arch
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
index 3a9afdbf2..9d4e01683 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
@@ -35,7 +35,7 @@ else
 	max_sched_smt=1
 fi
 
-tst_test_cmds python3
+tst_require_cmds python3
 
 hyper_threaded=$(is_hyper_threaded)
 multi_socket=$(is_multi_socket)
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 7cc3bb2fe..a15fb0540 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -151,7 +151,7 @@ tst_rmdir()
 #
 # Checks if commands passed as arguments exists
 #
-tst_test_cmds()
+tst_require_cmds()
 {
 	local cmd
 	for cmd in $*; do
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 6c3ae708d..078b05847 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -108,7 +108,7 @@ tst_require_root_()
 
 init_ltp_netspace()
 {
-	tst_test_cmds ip
+	tst_require_cmds ip
 	tst_require_root_
 
 	local pid=
@@ -318,7 +318,7 @@ tst_get_hwaddrs()
 # LINK: link number starting from 0. Default value is '0'.
 tst_hwaddr()
 {
-	tst_test_cmds awk
+	tst_require_cmds awk
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
@@ -334,7 +334,7 @@ tst_hwaddr()
 # LINK: link number starting from 0. Default value is '0'.
 tst_iface()
 {
-	tst_test_cmds awk
+	tst_require_cmds awk
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
@@ -481,7 +481,7 @@ tst_add_ipaddr()
 # LINK: link number starting from 0. Default value is '0'.
 tst_restore_ipaddr()
 {
-	tst_test_cmds ip
+	tst_require_cmds ip
 	tst_require_root_
 
 	local type="${1:-lhost}"
@@ -651,7 +651,7 @@ tst_ping()
 	local ret=0
 
 	echo "$dst_addr" | grep -q ':' && cmd="ping6"
-	tst_test_cmds $cmd
+	tst_require_cmds $cmd
 
 	# ping cmd use 56 as default message size
 	for size in ${msg_sizes:-"56"}; do
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..125e3a105 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -284,7 +284,7 @@ tst_mkfs()
 		tst_brk TBROK "No device specified"
 	fi
 
-	tst_test_cmds mkfs.$fs_type
+	tst_require_cmds mkfs.$fs_type
 
 	tst_res TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
@@ -306,7 +306,7 @@ tst_cmd_available()
 	fi
 }
 
-tst_test_cmds()
+tst_require_cmds()
 {
 	local cmd
 	for cmd in $*; do
@@ -448,7 +448,7 @@ tst_run()
 	[ "$TST_DISABLE_APPARMOR" = 1 ] && tst_disable_apparmor
 	[ "$TST_DISABLE_SELINUX" = 1 ] && tst_disable_selinux
 
-	tst_test_cmds $TST_NEEDS_CMDS
+	tst_require_cmds $TST_NEEDS_CMDS
 	tst_test_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
@@ -513,7 +513,7 @@ tst_run()
 	#TODO check that test reports some results for each test function call
 	while [ $TST_ITERATIONS -gt 0 ]; do
 		if [ -n "$TST_TEST_DATA" ]; then
-			tst_test_cmds cut tr wc
+			tst_require_cmds cut tr wc
 			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
 			for _tst_i in $(seq $_tst_max); do
 				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
diff --git a/testcases/network/multicast/mc_commo/mc_commo.sh b/testcases/network/multicast/mc_commo/mc_commo.sh
index 6852f17ca..b5370801a 100755
--- a/testcases/network/multicast/mc_commo/mc_commo.sh
+++ b/testcases/network/multicast/mc_commo/mc_commo.sh
@@ -36,7 +36,7 @@ TST_USE_LEGACY_API=1
 
 do_setup()
 {
-	tst_test_cmds netstat pgrep
+	tst_require_cmds netstat pgrep
 
 	OCTET=$(ps -ewf | grep [m]c_commo | wc -l | awk '{print $1}')
 	GROUP_ADDR=224.0.0.$OCTET
diff --git a/testcases/network/multicast/mc_member/mc_member.sh b/testcases/network/multicast/mc_member/mc_member.sh
index 0f41a5f2b..f41b03ace 100755
--- a/testcases/network/multicast/mc_member/mc_member.sh
+++ b/testcases/network/multicast/mc_member/mc_member.sh
@@ -38,7 +38,7 @@ TST_USE_LEGACY_API=1
 
 setup()
 {
-	tst_test_cmds netstat
+	tst_require_cmds netstat
 	tst_tmpdir
 }
 
diff --git a/testcases/network/stress/dns/dns-stress.sh b/testcases/network/stress/dns/dns-stress.sh
index 7689b28bc..dfc2ed5e0 100755
--- a/testcases/network/stress/dns/dns-stress.sh
+++ b/testcases/network/stress/dns/dns-stress.sh
@@ -43,7 +43,7 @@ cleanup()
 common_setup()
 {
 	tst_require_root
-	tst_test_cmds named dig
+	tst_require_cmds named dig
 
 	if [ "$TST_IPV6" ]; then
 		record="AAAA"
diff --git a/testcases/network/stress/ftp/ftp-download-stress.sh b/testcases/network/stress/ftp/ftp-download-stress.sh
index 75babdba0..4320bbd6f 100755
--- a/testcases/network/stress/ftp/ftp-download-stress.sh
+++ b/testcases/network/stress/ftp/ftp-download-stress.sh
@@ -42,7 +42,7 @@ cleanup()
 setup()
 {
 	tst_require_root
-	tst_test_cmds pkill vsftpd
+	tst_require_cmds pkill vsftpd
 	tst_tmpdir
 
 	tst_resm TINFO "run FTP over IPv$TST_IPVER"
diff --git a/testcases/network/stress/ftp/ftp-download-stress01-rmt.sh b/testcases/network/stress/ftp/ftp-download-stress01-rmt.sh
index a87f2ac0a..54f43d02f 100755
--- a/testcases/network/stress/ftp/ftp-download-stress01-rmt.sh
+++ b/testcases/network/stress/ftp/ftp-download-stress01-rmt.sh
@@ -28,7 +28,7 @@ server_ipaddr="$1"
 filename="$2"
 filesize="$3"
 
-tst_test_cmds curl
+tst_require_cmds curl
 
 echo $server_ipaddr | grep ':' > /dev/null
 if [ $? -eq 0 ]; then
diff --git a/testcases/network/stress/ftp/ftp-download-stress02-rmt.sh b/testcases/network/stress/ftp/ftp-download-stress02-rmt.sh
index 95a8a411c..599d21055 100755
--- a/testcases/network/stress/ftp/ftp-download-stress02-rmt.sh
+++ b/testcases/network/stress/ftp/ftp-download-stress02-rmt.sh
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 . test.sh
 
-tst_test_cmds awk killall
+tst_require_cmds awk killall
 
 server_ipaddr="$1"
 filename="$2"
diff --git a/testcases/network/stress/ftp/ftp-upload-stress.sh b/testcases/network/stress/ftp/ftp-upload-stress.sh
index 5b8fb740a..602dc4ed6 100755
--- a/testcases/network/stress/ftp/ftp-upload-stress.sh
+++ b/testcases/network/stress/ftp/ftp-upload-stress.sh
@@ -42,7 +42,7 @@ cleanup()
 setup()
 {
 	tst_require_root
-	tst_test_cmds pkill vsftpd
+	tst_require_cmds pkill vsftpd
 	tst_tmpdir
 
 	tst_resm TINFO "run FTP over IPv$TST_IPVER"
@@ -57,7 +57,7 @@ setup()
 	getenforce 2> /dev/null | grep -q Enforcing
 	if [ $? -eq 0 ]; then
 		tst_resm TINFO "configuring SELinux FTP parameters"
-		tst_test_cmds chcon setsebool
+		tst_require_cmds chcon setsebool
 		setsebool allow_ftpd_anon_write 1 || \
 			tst_brkm TBROK "Failed to allow ftpd anonymous write"
 		chcon -R -t public_content_rw_t $FTP_UPLOAD_DIR || \
diff --git a/testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh b/testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh
index 0042f09b1..d4a9fe903 100755
--- a/testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh
+++ b/testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh
@@ -30,7 +30,7 @@ urldir="$2"
 filename="$3"
 filesize="$4"
 
-tst_test_cmds curl
+tst_require_cmds curl
 
 cleanup()
 {
diff --git a/testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh b/testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh
index d266fb2ca..cba8f32cf 100755
--- a/testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh
+++ b/testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh
@@ -25,7 +25,7 @@ TST_CLEANUP="cleanup"
 
 . test.sh
 
-tst_test_cmds killall
+tst_require_cmds killall
 
 server_ipaddr="$1"
 urldir="$2"
diff --git a/testcases/network/stress/http/http-stress01-rmt.sh b/testcases/network/stress/http/http-stress01-rmt.sh
index 69abcf070..dcea6866b 100755
--- a/testcases/network/stress/http/http-stress01-rmt.sh
+++ b/testcases/network/stress/http/http-stress01-rmt.sh
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 . test.sh
 
-tst_test_cmds awk curl
+tst_require_cmds awk curl
 
 # Check the arguments
 [ $# -ne 3 ] && tst_brkm TBROK "Usage: $0 server_ipaddr filename filesize"
diff --git a/testcases/network/stress/http/http-stress02-rmt.sh b/testcases/network/stress/http/http-stress02-rmt.sh
index 52efc92cc..1734c2bd3 100755
--- a/testcases/network/stress/http/http-stress02-rmt.sh
+++ b/testcases/network/stress/http/http-stress02-rmt.sh
@@ -24,7 +24,7 @@ TST_TOTAL=1
 
 . test.sh
 
-tst_test_cmds awk curl
+tst_require_cmds awk curl
 
 if [ $# -ne 5 ]; then
 	tst_brkm TBROK "Usage: $0 server_addr fname fsize duration connections"
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 90030a146..b398be1ad 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -30,7 +30,7 @@ if_setup()
 		tst_brk TBROK "Missing or wrong -c parameter: '$CMD', use 'ip' or '$IF_CMD'"
 	fi
 
-	tst_test_cmds "$CMD"
+	tst_require_cmds "$CMD"
 	netstress_setup
 	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
 }
diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
index c686ae4b8..ae040bcf1 100644
--- a/testcases/network/stress/ns-tools/tst_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -26,7 +26,7 @@ MCAST_IPV6_ADDR="${MCAST_IPV6_ADDR_PREFIX}:1"
 netstress_setup()
 {
 	TST_NEEDS_ROOT=1
-	tst_test_cmds pgrep pkill
+	tst_require_cmds pgrep pkill
 }
 
 # Cleanup for tests using netstress.
diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index c4299a4a9..516bce765 100755
--- a/testcases/network/stress/ssh/ssh-stress.sh
+++ b/testcases/network/stress/ssh/ssh-stress.sh
@@ -46,7 +46,7 @@ setup()
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
 	tst_require_root
-	tst_test_cmds pkill sshd ssh od
+	tst_require_cmds pkill sshd ssh od
 
 	# Get the sshd command with absolute path
 	SSHD=$(which sshd)
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 852b32f1c..e15dd708c 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -34,7 +34,7 @@ do_setup()
 		;;
 	esac
 
-	tst_test_cmds $CMD ping$TST_IPV6
+	tst_require_cmds $CMD ping$TST_IPV6
 }
 
 usage()
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index 9e5828645..bc9c1f99b 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -23,7 +23,7 @@ do_setup()
 
 	PING_CMD=ping${TST_IPV6}
 
-	tst_test_cmds $PING_CMD
+	tst_require_cmds $PING_CMD
 }
 
 do_test()
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index b245210c5..e0a63c5f6 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -15,7 +15,7 @@ do_setup()
 
 	PING=ping${TST_IPV6}
 
-	tst_test_cmds $PING
+	tst_require_cmds $PING
 }
 
 do_test()
diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01.sh b/testcases/network/tcp_cmds/rlogin/rlogin01.sh
index 260e238f2..c34ab1c4e 100755
--- a/testcases/network/tcp_cmds/rlogin/rlogin01.sh
+++ b/testcases/network/tcp_cmds/rlogin/rlogin01.sh
@@ -25,7 +25,7 @@ TST_USE_LEGACY_API=1
 
 setup()
 {
-	tst_test_cmds rlogin expect
+	tst_require_cmds rlogin expect
 
 	if [ -z $RUSER ]; then
 		RUSER=root
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01.sh b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
index 1677ec305..1e4739ad2 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01.sh
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
@@ -47,7 +47,7 @@ do_setup()
 
 	FILES=${FILES:-"ascii.sm ascii.med ascii.lg ascii.jmb"}
 
-	tst_test_cmds diff stat
+	tst_require_cmds diff stat
 
 	tst_tmpdir
 }
diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh b/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
index e8ecdec98..32953e7e0 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
@@ -29,7 +29,7 @@ TST_CLEANUP=do_cleanup
 do_setup()
 {
 	ping_cmd=ping$TST_IPV6
-	tst_test_cmds tcpdump kill $ping_cmd
+	tst_require_cmds tcpdump kill $ping_cmd
 	outfile="tcpdump_out"
 	numloops=20
 	tst_tmpdir
diff --git a/testcases/network/tcp_cmds/telnet/telnet01.sh b/testcases/network/tcp_cmds/telnet/telnet01.sh
index d87cc8bb6..a6e6024fb 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01.sh
+++ b/testcases/network/tcp_cmds/telnet/telnet01.sh
@@ -25,7 +25,7 @@ TST_USE_LEGACY_API=1
 
 setup()
 {
-	tst_test_cmds telnet expect
+	tst_require_cmds telnet expect
 
 	if [ -z $RUSER ]; then
 		RUSER=root
diff --git a/testcases/network/tcp_cmds/tracepath/tracepath01.sh b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
index 037fca066..2b75c1004 100755
--- a/testcases/network/tcp_cmds/tracepath/tracepath01.sh
+++ b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
@@ -16,7 +16,7 @@ setup()
 		cmd="tracepath$TST_IPVER"
 		tst_cmd_available $cmd || cmd="tracepath -6"
 	fi
-	tst_test_cmds $(echo $cmd | cut -f 1 -d' ')
+	tst_require_cmds $(echo $cmd | cut -f 1 -d' ')
 
 	if $cmd -V >/dev/null 2>&1; then
 		tst_res TINFO "traceroute version:"
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 2be0ffbe1..f488932ff 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -50,7 +50,7 @@ virt_lib_setup()
 	;;
 	esac
 
-	tst_test_cmds "ip"
+	tst_require_cmds "ip"
 
 	virt_add ltp_v0 || \
 		tst_brk TCONF "iproute2 or kernel doesn't support $virt_type"
@@ -256,7 +256,7 @@ vxlan_setup_subnet_uni()
 
 vxlan_setup_subnet_multi()
 {
-	tst_test_cmds "od"
+	tst_require_cmds "od"
 	local b1=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
 	local b2=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
 	local b3=$(($(od -An -d -N1 /dev/urandom) % 254 + 1))
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index f7fa77f74..e2c2dfd8d 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -30,7 +30,7 @@ setup()
 
 	tst_tmpdir
 
-	tst_test_cmds xinetd diff telnet
+	tst_require_cmds xinetd diff telnet
 
 	check_addr="127.0.0.1"
 	ip a | grep -q inet6 && check_addr="$check_addr ::1"
-- 
2.20.1

