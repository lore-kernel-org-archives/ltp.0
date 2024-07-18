Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858EBC3DA49
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 09:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DC103D1AFD
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 11:03:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ACB53CFDCC
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 11:03:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 30F1F1B61067
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 11:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721293392; x=1752829392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/1+HRL5Hq75dFgt4/r+Ae8n4Yvr7grI09TyA9AfRa9Y=;
 b=fqQLXSSD1VY05pobiXxXZmWfWqRjtjO2B9hKRF4Mz1RoGvfeMtSG7TOk
 QTisW9aWuJ3awV70hTagC+SxTIdBs9h/gfQafLI2dlNntQN+ishkVNa1x
 WibNmPDmX0fBEO59RtVVoV3e/E1tagGJ456db8KU6+DIeNTPSZguavjVh
 YmakQ3/0wRf6INHiTukZvgnt2cYZ1OK4WWfH2+5egeFMRcOn/6kb9oCJZ
 WwD7HYPFg5qkKRfK9ixgom3A2I7/7xqUetoz+fYS3vCjZaDgWbMjdsbhb
 tGSMV3HyuBKx4QrEFpKpO9GfsB/b2xyB9uzU/t/W/Q8WoONOjJ7x/li4g A==;
X-CSE-ConnectionGUID: p3AD8PnnT7CyMSHcLn3FIw==
X-CSE-MsgGUID: xP6eOWt4Qu62WoD7gWTClw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30002459"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="30002459"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 02:03:07 -0700
X-CSE-ConnectionGUID: E53d8319Q3+BzVRK5M+Umg==
X-CSE-MsgGUID: L3/BOyydTW2Nwph/dO9Zhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="73930300"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by fmviesa002.fm.intel.com with ESMTP; 18 Jul 2024 02:03:06 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Thu, 18 Jul 2024 17:03:57 +0800
Message-ID: <554f6a9949dae600e880dad306819afdf8aaf914.1721293231.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721293231.git.pengfei.xu@intel.com>
References: <cover.1721293231.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] migrate_pages03: remove wait_ksmd_full_scan()
 check because it's not necessary
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
Cc: feij.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Remove wait_ksmd_full_scan() check because it's not a necessary step for
migrate_pages03 syscall test:
1. KSM(kernel samepage merging) could be enabled and it is optional for
migrate_pages syscall testing.
2. When server launched any qemu guest, wait_ksmd_full_scan() will in
infinite loop due to /sys/kernel/mm/ksm/full_scans number would not
increase anymore, and migrate_pages03 will failed with timeout reason.
After removed wait_ksmd_full_scan(), migrate_pages03 could pass without
issue.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index 4d3299b61..f514ed10c 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -95,7 +95,6 @@ static void setup(void)
 
 	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &orig_ksm_run);
 	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", 1);
-	wait_ksmd_full_scan();
 }
 
 static void cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
