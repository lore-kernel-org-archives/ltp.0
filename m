Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01279C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 06:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 554633CD22D
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 07:21:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B8373C9378
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 07:21:47 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C79AF20039E
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 07:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668406906; x=1699942906;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iT4XSX+v3/wlTllModspCS/+Bu9TquiHGcQECObxFQA=;
 b=Hbftm/75oC3bTT/XfGTnoQ2g+S8ufYayjT/jauBWKPkhJoTHqNsnOHs9
 u/T4kKzuWudWdLZlVBvuwXvkjGZiHM1qjZbrsZZH5b+Gn5NZO8Hgeut5h
 2mRf9RI0ExIxeY4E8mxS9KAjeRGPPxHonVxZpLuJ2xheoXjtDXW0W2ysN
 17r3yNOAQ8+CvXor2Db+j37dbioRSyCRx/IFNBHOMxYM4JvQEVY3L+G93
 ykB5KQTwLKv9C1e3j7LtSfCi1sSTRQqGhUCQt++KsUEb6DWZl5IqEtrIC
 EboAkSbdellTLUZzMtl4+LKAv5w0manbXV+jnxcarB4GvELWFBP7urqxl g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="338676886"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="338676886"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2022 22:21:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="967443467"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; d="scan'208";a="967443467"
Received: from wenjiaoy-mobl.ccr.corp.intel.com (HELO
 jiezho4x-mobl1.ccr.corp.intel.com) ([10.254.211.215])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2022 22:21:39 -0800
From: Jie2x Zhou <jie2x.zhou@intel.com>
To: jie2x.zhou@intel.com,
	ltp@lists.linux.it
Date: Mon, 14 Nov 2022 14:20:08 +0800
Message-Id: <20221114062008.999566-1-jie2x.zhou@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] test_robind.sh: fix BROK: mkfs.f2fs /dev/sdb1 failed
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
Cc: Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Error output:
test_robind 1 TINFO: Formatting /dev/sda1 with f2fs extra opts=''

        F2FS-tools: mkfs.f2fs Ver: 1.14.0 (2020-08-24)

Info: Disable heap-based policy
Info: Debug level = 0
Info: Trim is enabled
        /dev/sda1 appears to contain an existing filesystem (f2fs).
        Use the -f option to force overwrite.
test_robind 1 TBROK: mkfs.f2fs /dev/sda1 failed

Reason:
Test error is caused by miss "-f" option when do mkfs.f2fs.

Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
---
 testcases/kernel/fs/fs_readonly/test_robind.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index bab2648f4..2d9a87b7e 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -200,6 +200,8 @@ for fstype in $FSTYPES; do
 		opts="-F"
 	elif [ "$fstype" = "xfs" ]; then
 		opts="-f"
+	elif [ "$fstype" = "f2fs" ]; then
+		opts="-f"
 	elif [ "$fstype" = "btrfs" ]; then
 		opts="-f"
 	fi
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
