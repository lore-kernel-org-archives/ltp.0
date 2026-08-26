Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AEEC61DB9
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787709866; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=hDNnikEcg5Quwp5rDVWgmbFDsC7jDvpfEPK3UGVxdJ8=;
 b=dgoXv05u01DV+0gL0uYgh2BNxsaAZ1JNL0Db9d7nnJZzExFIjdo0nx74uyx3cFTMNvKHI
 ip2566/XuX/+wZ/HxXgg+KNc3ozUlqUK1DmxzK3iUsPfN8x1PvTZbKdLxKDl1aziMKqbQOn
 Cvq1dOCnecswEbIIVZpPJtOwTOeSS/c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 659033C9EB4
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 04:04:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FA3D3C2CE3
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 04:04:04 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89688600ADE
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 04:03:59 +0200 (CEST)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 67Q23pKt036197
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 10:03:51 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 26 Aug
 2026 10:03:51 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Aug
 2026 10:03:50 +0800
To: <ltp@lists.linux.it>
Date: Wed, 26 Aug 2026 10:03:37 +0800
Message-ID: <20260826020337.3685452-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67Q23pKt036197
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] readahead02: Fall back to the parent disk's BDI
 for partitions
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Partitions (e.g. mmcblk0p3) do not have their own BDI sysfs entry;
the BDI belongs to the parent disk.

In sysfs a partition is a subdirectory of its disk, so retry one
level up. That resolves for every partition naming scheme without
parsing the device name.

Without this fix, setup_readahead_length() silently returns the
default readahead_length, causing lots of readahead() calls per
test case and a multi-hour runtime on MMC-backed FPGA boards.

Also use tst_sys_conf_save() instead of manually save/restore
orig_bdi_limit. It only worked when orig_bdi_limit was non-zero.
A parent BDI starting at 0 would be left at the raised limit after
the test, along with every sibling partition sharing that BDI.

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
Changes in v2:
- Use tst_sys_conf_save to handle orig_bdi_limit save and restore.
- Amend the commit message.

 .../kernel/syscalls/readahead/readahead02.c   | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index b65213ad0..4f201d65d 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -47,7 +47,6 @@ static unsigned long cached_max;
 static int ovl_mounted;
 static int readahead_length  = 4096;
 static char sys_bdi_ra_path[PATH_MAX];
-static int orig_bdi_limit;
 
 static const char mntpoint[] = OVL_BASE_MNTPOINT;
 
@@ -388,6 +387,11 @@ static void setup_readahead_length(void)
 	struct stat sbuf;
 	char tmp[PATH_MAX], *backing_dev;
 	int ra_new_limit, ra_limit;
+	struct tst_path_val bdi_ra = {
+		.path = sys_bdi_ra_path,
+		.val = NULL,
+		.flags = TST_SR_TBROK
+	};
 
 	/* Find out backing device name */
 	SAFE_LSTAT(tst_device->dev, &sbuf);
@@ -399,10 +403,16 @@ static void setup_readahead_length(void)
 	backing_dev = basename(tmp);
 	sprintf(sys_bdi_ra_path, "/sys/class/block/%s/bdi/read_ahead_kb",
 		backing_dev);
-	if (access(sys_bdi_ra_path, F_OK))
-		return;
 
-	SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &orig_bdi_limit);
+	if (access(sys_bdi_ra_path, F_OK)) {
+		/* Partitions use the parent disk's BDI sysfs entry */
+		snprintf(sys_bdi_ra_path, sizeof(sys_bdi_ra_path),
+			"/sys/class/block/%s/../bdi/read_ahead_kb", backing_dev);
+		if (access(sys_bdi_ra_path, F_OK))
+			return;
+	}
+
+	tst_sys_conf_save(&bdi_ra);
 
 	/* raise bdi limit as much as kernel allows */
 	ra_new_limit = testfile_size / 1024;
@@ -446,9 +456,6 @@ static void cleanup(void)
 {
 	if (ovl_mounted)
 		SAFE_UMOUNT(OVL_MNT);
-
-	if (orig_bdi_limit)
-		SAFE_FILE_PRINTF(sys_bdi_ra_path, "%d", orig_bdi_limit);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
