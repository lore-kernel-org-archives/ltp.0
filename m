Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB2BC3DA6E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 06:56:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EDFF3C62A5
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 07:56:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAE0F3C62A5
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 07:55:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1BFA6002C2
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 07:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704869757; x=1736405757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KyYpyp8FMo5fiA+qP1cyYSJk6fWpEMmEfY6wLt2y/P0=;
 b=FJt5tqyoSavL5EJyoR2PaPuEyJMhui/ny1i8pPOlKACZ7btVaFaak29D
 sZUhNkMvd2VgtbYNrV0J6Xgck+D1n9uBb/1U6PbwBgOLSMM/4G/tz9nyx
 ZwOJOje7JpgLAPa4kzUbLEQorr/bIQ648P4fApJaaeFCdFZRdQloRKgXh
 LP+WF4Kvx2gNbobDGri5YksaCnZfyYcDBX61kILyZPQOzIOFX1pcv/8fc
 S0FKI03f4G8VhAjpbZj1MB95d/kTgauF6NA705T1ClrU2Hy5HWEj8Jkyl
 ZZ+8857kGOQB0AvrNaQJ3eIubatjgUhkIJ1c4AqQc7Sw3MKtkYuSu6lBT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19927161"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="19927161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 22:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872514781"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="872514781"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2024 22:55:45 -0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Wed, 10 Jan 2024 14:50:21 +0800
Message-Id: <f60daf00d0de49e54a5389c73c90994e7711a7d1.1704868967.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1704868967.git.pengfei.xu@intel.com>
References: <cover.1704868967.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] keyctl05: increase dns_res_payload data due to
 kernel code changes
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

keyctl05 was failed in v6.7-rc8 kernel, related discussion link:
https://lore.kernel.org/all/ZZ4vaJMN2w%2FilkR3@xpf.sh.intel.com/

From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
the incoming data for add_key syscall should be larger than 6 bytes, because
struct dns_server_list_v1_header without body after kernel v6.7-rc8 is 6 bytes.

Fixes: 9662d802a0 ("keyctl05: use data that passes dns_resolver_preparse() check")

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/syscalls/keyctl/keyctl05.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 7d7c076c0..90cf1ef06 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -198,8 +198,12 @@ static void do_test(unsigned int i)
 	/*
 	 * We need to pass check in dns_resolver_preparse(),
 	 * give it dummy server list request.
+	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
+	 * the incoming data for add_key syscall should be larger than 6 bytes,
+	 * because struct dns_server_list_v1_header without body is 6 bytes.
 	 */
-	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00 };
+	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, \
+					  0x00, 0x00 };
 
 	switch (i) {
 	case 0:
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
