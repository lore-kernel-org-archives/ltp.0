Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E16C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:20:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D303C8F2C
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:20:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA1C3C091D
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:27 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1E1C100152F
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639552825; i=@fujitsu.com;
 bh=JBmUAe3F5YnPEQD+3assGHIuxnw3qiToeq8pc2EjHNI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=dq5+f14OR1ng6UHth7c22NGDHdFnUSpr3NKheTJTX5msA1uUr9Olqw5RyrGAcRefR
 Y74K+H8OQ2I8+5GSnjFm+Whj4TF3c6WGXWgAhb4VetH04W32+opvlo4cfOaS+Vy9Ab
 vcOi19FRIQ+N9pAV+gAV30rpMuAKDEzH0jhK0F6aB3u+NeBwquUyvSJ54OWw7w+fXT
 8Lg/9zbP/O7EPSnHXdTni2Yh/6cthA11as/3EhiM9Im/7w99ZhYZnESTN0nZcKdTEs
 UlZpYYjZCY1mDK39k214tvkdtBfzQ+5lzGi4xSfQh4F1Nm9BXsJWtKgjs5GUceyuHs
 DKSDkBYUdxLHw==
Received: from [100.115.68.153] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id 1D/E0-31213-93799B16;
 Wed, 15 Dec 2021 07:20:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8MxRddy+s5
 Eg64H4hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0bbdfuC2YYV6zqPsTcw3tHoYuTiEBJoYpI4
 8/0cO4Szh1FixtnPLF2MnBxsApoSzzoXMIPYIgISEh0Nb9lBbGYBdYnlk34xgdjCAjES/xcfA
 4uzCKhKTF/bAWbzCnhI7PiyixXElhBQkJjy8D3YHE4BT4kLULYQUM2PaWvZIOoFJU7OfMICMV
 9C4uCLF8wQvYoSlzq+MULYFRKzZrUxTWDkn4WkZRaSlgWMTKsY7ZKKMtMzSnITM3N0DQ0MdA0
 NTXXNDXUNLQ30Eqt0E/VSS3WTU/NKihKB0nqJ5cV6qcXFesWVuck5KXp5qSWbGIGhmVLsvm8H
 44u+n3qHGCU5mJREed+W70wU4kvKT6nMSCzOiC8qzUktPsQow8GhJMH7ciJQTrAoNT21Ii0zB
 xgnMGkJDh4lEd5jU4HSvMUFibnFmekQqVOMxhw7j85bxMzxuuXnDmYhlrz8vFQpcd6tIKUCIK
 UZpXlwg2Dxe4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK/NJKApPJl5JXD7XgGdwgRySu5
 2kFNKEhFSUg1MPMbtEv+UH3MXH1ALaYwJLWnWTnDm+sMQJbqs+tzLmDzJqRu9N31lqz3Id61l
 h9i86ZYOzQKnp6wvOHtENODsQ7eNS7XDmm3u32lIy3hZVWIqJHrnw95JyXp/9P5p6S07nlDFt
 23xpOL9hv29023j+77VVs+Xmbgkj2eu/G+/b1d+LQgo8Dh7tjhq6RGhxKVaRy7+31TY5f9jZ6
 ZW/oVzc6zkCo4utLjoUOdl8vr7l2MJ99oXGDOe2HLX6fYCpZ3L1u4UNb8SXP/+e+Bxj5mXq+a
 9e35k1/+qg1VJekXBTDtOl7k2LQkTO7V4acWFay7J8+5WzfSMnGe1cX9HpAijlmxHyK2U3HVr
 Jny37mBuUGIpzkg01GIuKk4EAEs3kOpaAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-532.messagelabs.com!1639552825!1006!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13382 invoked from network); 15 Dec 2021 07:20:25 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-9.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Dec 2021 07:20:25 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1BF7KJT5006429
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:24 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 07:20:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 15 Dec 2021 15:20:47 +0800
Message-ID: <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
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

Also, zram01,02 case are adjuested to adapt the situation that CONFIG_ZRAM=y.

1]https://www.kernel.org/doc/html/latest/admin-guide/blockdev/zram.html#add-remove-zram-devices

Fixes: #888
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/device-drivers/zram/zram01.sh      |  6 +-
 .../kernel/device-drivers/zram/zram02.sh      |  4 +-
 .../kernel/device-drivers/zram/zram_lib.sh    | 60 ++++++++++++-------
 3 files changed, 42 insertions(+), 28 deletions(-)

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
index fe9c915c3..db9552501 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -5,6 +5,9 @@
 
 dev_makeswap=-1
 dev_mounted=-1
+dev_start=-1
+dev_end=-1
+module_load=-1
 
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
@@ -17,19 +20,25 @@ zram_cleanup()
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
+	for i in $(seq $dev_start $dev_end); do
+		echo $i > /sys/class/zram-control/hot_remove
+	done
+
+	if [ $module_load -eq 1 ]; then
+		rmmod zram > /dev/null 2>&1
+	fi
 }
 
 zram_load()
@@ -51,16 +60,23 @@ zram_load()
 
 	tst_res TINFO "create '$dev_num' zram device(s)"
 
-	modprobe zram num_devices=$dev_num || \
-		tst_brk TBROK "failed to insert zram module"
+	if [ ! -d "/sys/class/zram-control" ]; then
+		modprobe zram num_devices=$dev_num
+		module_load=1
+		dev_start=0
+		dev_end=$(($dev_num - 1))
+		tst_res TPASS "all zram devices(/dev/zram0~$dev_end) successfully created"
+		return
+	fi
 
-	dev_num_created=$(ls /dev/zram* | wc -w)
+	dev_start=$(ls /dev/zram* | wc -w)
+	dev_end=$(($dev_start + $dev_num - 1))
 
-	if [ "$dev_num_created" -ne "$dev_num" ]; then
-		tst_brk TFAIL "unexpected num of devices: $dev_num_created"
-	fi
+	for i in $(seq  $dev_start $dev_end); do
+		cat /sys/class/zram-control/hot_add > /dev/null
+	done
 
-	tst_res TPASS "all zram devices successfully created"
+	tst_res TPASS "all zram devices(/dev/zram$dev_start~$dev_end) successfully created"
 }
 
 zram_max_streams()
@@ -73,7 +89,7 @@ zram_max_streams()
 
 	tst_res TINFO "set max_comp_streams to zram device(s)"
 
-	local i=0
+	local i=$dev_start
 
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
@@ -85,7 +101,7 @@ zram_max_streams()
 			tst_brk TFAIL "can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		tst_res TINFO "$sys_path = '$max_streams' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$max_streams'"
 	done
 
 	tst_res TPASS "test succeeded"
@@ -100,20 +116,18 @@ zram_compress_alg()
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
 
@@ -122,7 +136,7 @@ zram_compress_alg()
 
 zram_set_disksizes()
 {
-	local i=0
+	local i=$dev_start
 	local ds
 
 	tst_res TINFO "set disk size to zram device(s)"
@@ -132,7 +146,7 @@ zram_set_disksizes()
 			tst_brk TFAIL "can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		tst_res TINFO "$sys_path = '$ds' ($i/$dev_num)"
+		tst_res TINFO "$sys_path = '$ds'"
 	done
 
 	tst_res TPASS "test succeeded"
@@ -147,7 +161,7 @@ zram_set_memlimit()
 		return
 	fi
 
-	local i=0
+	local i=$dev_start
 	local ds
 
 	tst_res TINFO "set memory limit to zram device(s)"
@@ -158,7 +172,7 @@ zram_set_memlimit()
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
