From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 12:02:53 +0100
Subject: [LTP] [PATCH 4/6] test.sh: Remove tst_{acquire, release}_device,
	tst_mkfs
In-Reply-To: <20170208110255.443-1-chrubis@suse.cz>
References: <20170208110255.443-1-chrubis@suse.cz>
Message-ID: <20170208110255.443-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are not used by any test that uses test.sh library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/test.sh | 72 ---------------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 48172d3..71dd611 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -288,78 +288,6 @@ EXPECT_FAIL()
 	fi
 }
 
-tst_acquire_device()
-{
-	local acq_dev_size=${1:-150}
-
-	if [ -z ${TST_TMPDIR} ]; then
-		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
-	fi
-
-	ltp_dev_size=$((`blockdev --getsize64 $LTP_DEV`/1024/1024))
-
-	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -le ${ltp_dev_size} ]; then
-		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
-		if [ ! -b ${LTP_DEV} ]; then
-			tst_brkm TBROK "${LTP_DEV} is not a block device"
-		fi
-
-		ROD_SILENT dd if=/dev/zero of="${LTP_DEV}" bs=1024 count=512
-
-		TST_DEVICE=${LTP_DEV}
-		TST_DEVICE_FLAG=0
-		return
-	fi
-
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
-
-	TST_DEVICE=$(losetup -f)
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK "Couldn't find free loop device"
-	fi
-
-	tst_resm TINFO "Found free device '${TST_DEVICE}'"
-
-	ROD_SILENT losetup ${TST_DEVICE} test_dev.img
-
-	TST_DEVICE_FLAG=1
-}
-
-tst_release_device()
-{
-	if [ ${TST_DEVICE_FLAG} -eq 0 ]; then
-		return
-	fi
-
-	losetup -a | grep -q ${TST_DEVICE}
-	if [ $? -eq 0 ]; then
-		losetup -d ${TST_DEVICE}
-		if [ $? -ne 0 ];then
-			tst_resm TWARN "'losetup -d ${TST_DEVICE}' failed"
-		fi
-	fi
-}
-
-tst_mkfs()
-{
-	local fs_type=$1
-	local device=$2
-	shift 2
-	local fs_opts="$@"
-
-	if [ -z "$fs_type" ]; then
-		tst_brkm TBROK "No fs_type specified"
-	fi
-
-	if [ -z "$device" ]; then
-		tst_brkm TBROK "No device specified"
-	fi
-
-	tst_resm TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
-
-	ROD_SILENT mkfs.$fs_type $fs_opts $device
-}
-
 tst_umount()
 {
 	local device="$1"
-- 
2.10.2

