Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A638BC5DF88
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 06:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787294001; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qgU3gXhMVrXLLiuSeFtaKukYmsoW681NRQqx15GqDwE=;
 b=g9Prve9StgV/F/RXeQlelBVuDoGBZyKhdETZYN10iaFhrAyQAVtDxTCXWfYJAafH2RoCo
 6r+aT0tdZsgegTNHS3NxSc6eehZMG11L//h197t7Q6icLyUoW3gqAKM+lxr3wGTmL1j84sL
 1/jl1pYDs1IenXc/S7ECPjFORHpuk/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAE253CF417
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 08:33:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 995753C5DED
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:33:00 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6111C1400335
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:32:57 +0200 (CEST)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 67L6Wqgj051563
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 14:32:52 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Fri, 21 Aug
 2026 14:32:52 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Aug
 2026 14:32:52 +0800
To: <ltp@lists.linux.it>
Date: Fri, 21 Aug 2026 14:32:48 +0800
Message-ID: <20260821063248.2208776-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67L6Wqgj051563
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readahead02: Fall back to the parent disk's BDI for
 partitions
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

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index b65213ad0..6707a1c63 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -399,8 +399,14 @@ static void setup_readahead_length(void)
 	backing_dev = basename(tmp);
 	sprintf(sys_bdi_ra_path, "/sys/class/block/%s/bdi/read_ahead_kb",
 		backing_dev);
-	if (access(sys_bdi_ra_path, F_OK))
-		return;
+
+	if (access(sys_bdi_ra_path, F_OK)) {
+		/* Partitions use the parent disk's BDI sysfs entry */
+		snprintf(sys_bdi_ra_path, sizeof(sys_bdi_ra_path),
+			"/sys/class/block/%s/../bdi/read_ahead_kb", backing_dev);
+		if (access(sys_bdi_ra_path, F_OK))
+			return;
+	}
 
 	SAFE_FILE_SCANF(sys_bdi_ra_path, "%d", &orig_bdi_limit);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
