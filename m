Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7D0CC6B00
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 07:49:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53F973E2A1C
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 09:49:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 015223E2185
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 09:49:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EFE191000D41
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 09:49:05 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631HeX713127127
 for <ltp@lists.linux.it>; Thu, 2 Apr 2026 07:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vz7XediQrIRoCTWiR4kqYtF8Nim8lpTZE6PhnwzIN
 sE=; b=qwSm3UOZn50D741nnia3G2Qe877wJUXDLMLBjTQjJV96X4zOv/eO+CL2p
 qD88CnCA4GyJjXHFnwvsJJG/byxYns2VyLDQOJbiUEoPydEK9jYEZ+xsosaVIJul
 Im/y2/a9deDlLgPT6SzDyWih9YvkSN4xO2Q9EXCE5amBiXQpE6xWdfs358WQoLXv
 c8nzAPJMkUtsVn8dPpTQn/ksGamL7lrJYTI4dNDt3pYA6VajMVrbMwxNeaxEPpX2
 jlekGQ2p0Zq9Tja2LlT12ywM9sEGxUVStUoVXbl5gXtoHvCFVnMHyzQeSAnXcr2M
 p22l8HrruIDM4wcN4RNNmtZCgfM6g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dck098-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 07:49:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63258D5p005910
 for <ltp@lists.linux.it>; Thu, 2 Apr 2026 07:49:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy99d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 07:49:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6327n1FS27394722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 07:49:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE4FD58059;
 Thu,  2 Apr 2026 07:49:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6302C58065;
 Thu,  2 Apr 2026 07:49:01 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 07:49:01 +0000 (GMT)
From: Soma Das <somadas1@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 08:12:58 +0000
Message-Id: <20260402081258.3239096-1-somadas1@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce1f6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Z9b-flewM4-o50iZjQYA:9
X-Proofpoint-GUID: 8RLiUODZdhkcAf5NFEV0vWO6b6NQzUwu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfX1faYDoN3zW2x
 b8dPe6uTYdM1bvDWxe+O8OJse5obSwcWVWaL9uJmhV8LKCN1wjwoOPVY9jjHTif3+rgdBVr1LOt
 KxwlVHxKRRDSrvtnbyLqh1JP3lUP0dzGDbx7iPJ4Wp6lTqbDq74W2jmD6GjG7ibL3nlo3AxfRLd
 39sdWsd1CF2WUqqgfqILhFd+IiP7BG/h5PtilUZeZF/2OegCE76zBdR6Pb0DbOTYjU143ukOlln
 n5QvZWOw8nU3ffXnuVM1Dw86WmRIWeJU+mvEWQSyPPF7i+hKCzF6cnBQoA4VD/VnbgjQ5Zwc7sf
 4VTS5MyIgP0316zXujrTpVjh+Wpe8ybuuMNhRYtufKYxqhY+LMdjisGHy3IHHyV+TF1owg1bt7R
 nss84WbyWaOa+MM5uY/UR4o3ucfwOGA67lah/inioZgIajrsPca/pMsDiuuen7Wf4uFRJDxMPd3
 +DSDGAUu/6jbJSLgHOA==
X-Proofpoint-ORIG-GUID: 8RLiUODZdhkcAf5NFEV0vWO6b6NQzUwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020068
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] zram: skip exfat on systems with large page size
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
Cc: somadas1@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

exfat requires cluster size >= sector size, but defaults to 4KB.
On systems with large page sizes (e.g., 64KB on POWER),
zram uses page size as sector size, causing mkfs.exfat to fail.

Skip exfat filesystem creation when page size > 4096 to avoid test failure.

Signed-off-by: Soma Das <somadas1@linux.ibm.com>
---
 .../kernel/device-drivers/zram/zram01.sh      | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 793f6603c..6afba21f0 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -11,6 +11,10 @@ TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
 TST_SETUP="setup"
 
+# Track devices that were skipped due to sector size incompatibility
+# Format: space-separated list of device numbers (e.g., "2 5" if zram2 and zram5 were skipped)
+skipped_devices=""
+
 check_space_for_fs()
 {
 	local fs="$1"
@@ -72,15 +76,59 @@ setup()
 	zram_load
 }
 
+check_fs_sector_support()
+{
+	local fs="$1"
+	local dev="$2"
+	local page_size
+	local sector_size
+
+	# Get the system page size - zram uses this as sector size
+	page_size=$(getconf PAGE_SIZE 2>/dev/null)
+	
+	if [ -z "$page_size" ] || [ "$page_size" -lt 4096 ]; then
+		# Default to 4KB if we can't determine page size
+		page_size=4096
+	fi
+
+	tst_res TINFO "check_fs_sector_support: $fs on zram$dev system_page_size=$page_size"
+
+	# CHECK: exfat requires cluster size >= sector size, but defaults to 4KB
+	# On systems with large page sizes (e.g., 64KB on POWER), sector size > 4KB
+	# This causes exfat filesystem creation to fail, so we skip it with TCONF
+	if [ "$fs" = "exfat" ] && [ "$page_size" -gt 4096 ]; then
+		tst_res TINFO "check_fs_sector_support: $fs on zram$dev has page_size=$page_size (> 4096), skipping"
+		return 1  # Return failure (skip this filesystem)
+	fi
+
+	return 0  # All other filesystems pass this check
+}
+
 zram_makefs()
 {
 	local i=$dev_start
 	local fs
+	local sector_size
 
+	# Loop through each filesystem assigned to each zram device
 	for fs in $zram_filesystems; do
+		tst_res TINFO "zram_makefs: checking device zram$i for filesystem $fs"
+		
+		# Check if this filesystem is compatible with the device's sector size
+		if ! check_fs_sector_support "$fs" "$i"; then
+			# Filesystem not supported on this device - mark device as skipped
+			sector_size=$(cat /sys/block/zram${i}/queue/logical_block_size)
+			tst_res TCONF "mkfs.$fs does not support sector size $sector_size"
+			skipped_devices="$skipped_devices $i"  # Add to skipped list
+			i=$(($i + 1))
+			continue  # Skip to next filesystem
+		fi
+
+		# Filesystem is supported - attempt to create it
 		tst_res TINFO "make $fs filesystem on /dev/zram$i"
 		mkfs.$fs /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
+			# Filesystem creation failed
 			cat err.log
 			tst_res TFAIL "Failed to make $fs on /dev/zram$i"
 			tst_brk TBROK "Can't continue with mounting the FS"
@@ -95,8 +143,27 @@ zram_makefs()
 zram_mount()
 {
 	local i
+	local skip
 
+	# Attempt to mount all zram devices
 	for i in $(seq $dev_start $dev_end); do
+		skip=0
+		
+		# Check if this device was marked as skipped during filesystem creation
+		for dev in $skipped_devices; do
+			if [ "$dev" = "$i" ]; then
+				skip=1
+				break
+			fi
+		done
+
+		# Skip mounting devices that don't have filesystems
+		if [ $skip -eq 1 ]; then
+			tst_res TINFO "skipping mount of /dev/zram$i (filesystem not created)"
+			continue
+		fi
+
+		# Mount the filesystem that was created in zram_makefs
 		tst_res TINFO "mount /dev/zram$i"
 		mkdir zram$i
 		ROD mount /dev/zram$i zram$i
@@ -130,8 +197,27 @@ zram_fill_fs()
 {
 	local mem_used_total
 	local b i r v
+	local skip
 
+	# Fill each mounted filesystem with data to test compression
 	for i in $(seq $dev_start $dev_end); do
+		skip=0
+		
+		# Check if this device was marked as skipped (has no filesystem)
+		for dev in $skipped_devices; do
+			if [ "$dev" = "$i" ]; then
+				skip=1
+				break
+			fi
+		done
+
+		# Skip filling devices that don't have filesystems
+		if [ $skip -eq 1 ]; then
+			tst_res TINFO "skipping fill of zram$i (filesystem not created)"
+			continue
+		fi
+
+		# Fill this zram device with zeros to test compression ratio
 		tst_res TINFO "filling zram$i (it can take long time)"
 		b=0
 		while true; do
@@ -140,12 +226,15 @@ zram_fill_fs()
 				>/dev/null 2>err.txt || break
 			b=$(($b + 1))
 		done
+		
+		# Verify that at least some data was written
 		if [ $b -eq 0 ]; then
 			[ -s err.txt ] && tst_res TWARN "dd error: $(cat err.txt)"
 			tst_brk TBROK "cannot fill zram $i"
 		fi
 		tst_res TPASS "zram$i was filled with '$b' KB"
 
+		# Check if compression statistics are available (requires mm_stat)
 		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
 			if [ $i -eq 0 ]; then
 				tst_res TCONF "zram compression ratio test requires zram mm_stat sysfs file"
@@ -154,6 +243,7 @@ zram_fill_fs()
 			continue
 		fi
 
+		# Read and verify the compression ratio
 		TST_RETRY_FN_EXP_BACKOFF "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0 10
 		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
 		tst_res TINFO "mem_used_total: $mem_used_total"
@@ -161,6 +251,7 @@ zram_fill_fs()
 		v=$((100 * 1024 * $b / $mem_used_total))
 		r=$(echo "scale=2; $v / 100 " | bc)
 
+		# Fail if compression ratio is less than 1:1 (data grew instead of compressed)
 		if [ "$v" -lt 100 ]; then
 			tst_res TFAIL "compression ratio: $r:1"
 			break
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
