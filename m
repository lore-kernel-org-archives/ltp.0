Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1324C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 06:53:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C51773C915D
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 07:53:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7A6F3C8FDB
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:48 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89B3D600BDE
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639983166; i=@fujitsu.com;
 bh=GKAhAxqxjr1WPnNH5waw1V+sQHdmcZp/9KvkNKNk7Ko=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=rY/1DDSoh4o8XW2hZvheEtBR1ElN3kfQ3cEqb6WtKhJcpMZAsXTgjVyOyeQHIrzsK
 uNMKSIjymuDO2lOnSBOPWteO8S3WqFU07RdbrhbXujayPgWiahzgP5ZD+95dWDfAyr
 n+SMrayqDBhgq3cjJ5JSSxQx87Le/LjGQKBJa3vY9tCHhwvUwrxcpFaffBCjQcgNJk
 WKeh62aOqVf/KQ9EyMH4vM6B80x29g+UaWXzWyEqAMHqz1FGtkvh+MqdftFzgQaOlz
 RxffLkznxIde1vIInByPw+Yb+w6431JwL5le0Spdn9ZBWmr82+gey9JEiTFt7tB1PY
 wYM8QDkDdGExw==
Received: from [100.115.34.181] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 41/6E-16537-E3820C16;
 Mon, 20 Dec 2021 06:52:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRWlGSWpSXmKPExsViZ8ORqGuncSD
 R4PReJosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWNhz3/WgmnWFZNWn2JvYGw27GLk4hASOMso
 cXD3DUYIZyeTxInVL1m7GDmBnD2MEr8f54DYbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+M
 XUxcnAIC8RIzOgpAAmzCKhKrP+7gAXE5hXwkPjw+SYTiC0hoCAx5eF7ZpByTgFPiQlfLCA2eU
 h0zDzFDFEuKHFy5hMWiOkSEgdfvGCGaFWUuNTxjRHCrpCYNasNaqSaxNVzm5gnMArOQtI+C0n
 7AkamVYzWSUWZ6RkluYmZObqGBga6hoamusYWukaGRnqJVbqJeqmluuWpxSW6QG55sV5qcbFe
 cWVuck6KXl5qySZGYAinFKtd2cG4Z9VPvUOMkhxMSqK8At17E4X4kvJTKjMSizPii0pzUosPM
 cpwcChJ8MqrH0gUEixKTU+tSMvMAcYTTFqCg0dJhNdTDSjNW1yQmFucmQ6ROsVozLHz6LxFzB
 yvW37uYBZiycvPS5US5/UAmSQAUppRmgc3CBbnlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCo
 J8/KDTOHJzCuB2/cK6BQmoFOUwveDnFKSiJCSamBKOL5BasZdroaF9bV7Z3B4SB3ayVCYuX/Z
 I4PPXUmpPz6y8q4XvvnjmaPEn8X/jFK4ON2jmxb255SVLZjLIaOzNjCu+cbT1UtcQpMPfkhYa
 iS+oSOwo3pWhyr7mc3ZyeWzDba3eS6Uto0NvZUgpsS9oer9pTchvpaFCXFvZ9xcr1UquPb11s
 XHqgWdet0k1p/c7vy41bbiybnCg/crlq9Kzvgx+Ujjs6A83ji/idbNjBPaTVo7xNNy1Zx8Am9
 81j9vrvrd+HbVtCltS458Kk7vrGzRmS187e8Sk3X8c87OujejueYKd9CxPJWA5m8v9Zf8fXOj
 7fMiXZuD0/bc7/J5farvoG9oaIB0TKAKd6QSS3FGoqEWc1FxIgBKemzLbgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-25.tower-571.messagelabs.com!1639983165!200699!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6483 invoked from network); 20 Dec 2021 06:52:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-25.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Dec 2021 06:52:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AA61E1009F5
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9E687100232
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 06:52:30 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Dec 2021 14:52:20 +0800
Message-ID: <1639983142-2247-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If zram-generator package is installed and works, then we can not remove zram module
because zram swap is being used. This case needs a clean zram environment, change this
test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
still can add zram device and remove them in cleanup.

The two interface was introduced since kernel commit 6566d1a32("zram: add dynamic
device add/remove functionality")[2] in 2015.6. If kernel supports these two interface,
we use hot_add/hot_remove to slove this problem, if not, just check whether zram is
being used or built in, then skip it on old kernel.

Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y and can
run zram01,02 simultaneously on new kernel.

[1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices
[2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6566d1a32bf7

Fixes: #888
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/device-drivers/zram/zram01.sh      |  6 +-
 .../kernel/device-drivers/zram/zram02.sh      |  4 +-
 .../kernel/device-drivers/zram/zram_lib.sh    | 78 +++++++++++++------
 3 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index ad9a9a2be..5e13f387c 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -69,7 +69,7 @@ setup()
 
 zram_makefs()
 {
-	local i=0
+	local i=$dev_start
 	local fs
 
 	for fs in $zram_filesystems; do
@@ -90,7 +90,7 @@ zram_mount()
 {
 	local i=0
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		tst_res TINFO "mount /dev/zram$i"
 		mkdir zram$i
 		ROD mount /dev/zram$i zram$i
@@ -102,7 +102,7 @@ zram_mount()
 
 zram_fill_fs()
 {
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		tst_res TINFO "filling zram$i (it can take long time)"
 		local b=0
 		while true; do
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index f0421ce7f..c980fce76 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -29,7 +29,7 @@ zram_makeswap()
 	tst_require_cmds mkswap swapon swapoff
 	local i=0
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		ROD mkswap /dev/zram$i
 		ROD swapon /dev/zram$i
 		tst_res TINFO "done with /dev/zram$i"
@@ -44,7 +44,7 @@ zram_swapoff()
 	tst_require_cmds swapoff
 	local i
 
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_end); do
 		ROD swapoff /dev/zram$i
 	done
 	dev_makeswap=-1
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index fe9c915c3..84a9a4378 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -5,6 +5,10 @@
 
 dev_makeswap=-1
 dev_mounted=-1
+dev_start=0
+dev_end=-1
+module_load=-1
+sys_control=-1
 
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
@@ -17,19 +21,27 @@ zram_cleanup()
 {
 	local i
 
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
 
-	for i in $(seq 0 $dev_mounted); do
+	for i in $(seq $dev_start $dev_mounted); do
 		umount /dev/zram$i
 	done
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo 1 > /sys/block/zram${i}/reset
 	done
 
-	rmmod zram > /dev/null 2>&1
+	if [ $sys_control -eq 1 ]; then
+		for i in $(seq $dev_start $dev_end); do
+			echo $i > /sys/class/zram-control/hot_remove
+		done
+	fi
+
+	if [ $module_load -eq 1 ]; then
+		rmmod zram > /dev/null 2>&1
+	fi
 }
 
 zram_load()
@@ -51,16 +63,38 @@ zram_load()
 
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
-	modprobe zram num_devices=$dev_num || \
-		tst_brk TBROK "failed to insert zram module"
+# On kernel that supports /sys/class/zram-control interface but doesn't load zram,
+# we dont' need to use hot_add/hot_remove interface. If system has loaded zram
+# or buitin, we need to use hot_add/hot_remove interface.
+# On old kernel that doesn't support /sys/class/zram-control interface, we just
+# check whether zram module is being used or it is built in kernel(we can't create
+# number of devices required). If so, skip it.
+	if [ ! -d "/sys/class/zram-control" ]; then
+		modprobe zram num_devices=$dev_num
+		if [ ! -d "/sys/class/zram-control" ]; then
+			if grep -q '^zram' /proc/modules; then
+				rmmod zram > /dev/null 2>&1 || \
+					tst_brk TCONF "zram module is being used"
+			else
+				tst_brk TCONF "test needs CONFIG_ZRAM=m"
+			fi
+			modprobe zram num_devices=$dev_num
+		fi
+		module_load=1
+		dev_end=$(($dev_num - 1))
+		tst_res TPASS "all zram devices (/dev/zram0~$dev_end) successfully created"
+		return
+	fi
 
-	dev_num_created=$(ls /dev/zram* | wc -w)
+	dev_start=$(ls /dev/zram* | wc -w)
+	dev_end=$(($dev_start + $dev_num - 1))
+	sys_control=1
 
-	if [ "$dev_num_created" -ne "$dev_num" ]; then
-		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
-	fi
+	for i in $(seq  $dev_start $dev_end); do
+		cat /sys/class/zram-control/hot_add > /dev/null
+	done
 
-	tst_res TPASS "all zram devices successfully created"
+	tst_res TPASS "all zram devices (/dev/zram$dev_start~$dev_end) successfully created"
 }
 
 zram_max_streams()
@@ -73,7 +107,7 @@ zram_max_streams()
 
 	tst_res TINFO "set max_comp_streams to zram device(s)"
 
-	local i=0
+	local i=$dev_start
 
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
@@ -85,7 +119,7 @@ zram_max_streams()
 			tst_brk TFAIL "can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		tst_res TINFO "$sys_path = '$max_streams' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$max_streams'"
 	done
 
 	tst_res TPASS "test succeeded"
@@ -100,20 +134,18 @@ zram_compress_alg()
 		return
 	fi
 
-	local i=0
+	local i=$dev_start
 
 	tst_res TINFO "test that we can set compression algorithm"
-	local algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"
+	local algs="$(sed 's/[][]//g' /sys/block/zram${i}/comp_algorithm)"
 	tst_res TINFO "supported algs: $algs"
 
-	local dev_max=$(($dev_num - 1))
-
-	for i in $(seq 0 $dev_max); do
+	for i in $(seq $dev_start $dev_end); do
 		for alg in $algs; do
 			local sys_path="/sys/block/zram${i}/comp_algorithm"
 			echo "$alg" >  $sys_path || \
 				tst_brk TFAIL "can't set '$alg' to $sys_path"
-			tst_res TINFO "$sys_path = '$alg' ($i/$dev_max)"
+			tst_res TINFO "$sys_path = '$alg'"
 		done
 	done
 
@@ -122,7 +154,7 @@ zram_compress_alg()
 
 zram_set_disksizes()
 {
-	local i=0
+	local i=$dev_start
 	local ds
 
 	tst_res TINFO "set disk size to zram device(s)"
@@ -132,7 +164,7 @@ zram_set_disksizes()
 			tst_brk TFAIL "can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$ds'"
 	done
 
 	tst_res TPASS "test succeeded"
@@ -147,7 +179,7 @@ zram_set_memlimit()
 		return
 	fi
 
-	local i=0
+	local i=$dev_start
 	local ds
 
 	tst_res TINFO "set memory limit to zram device(s)"
@@ -158,7 +190,7 @@ zram_set_memlimit()
 			tst_brk TFAIL "can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$ds'"
 	done
 
 	tst_res TPASS "test succeeded"
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
