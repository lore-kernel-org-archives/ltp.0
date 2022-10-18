Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB8C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:11:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC5CF3CB06D
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:11:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0883D3C2CAE
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:40 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B851860071A
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666095039; x=1697631039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jHg9bfLS2Ujfr/fl1BSKtuN1T0axxth+i7Lsfd1lius=;
 b=k640FRwnQeEDn4DDSj/EH81xrnnmJr14MRzh05k7IWmXltch/70uc0gz
 wRM5qNRDVrOHXc4njwI8mlACD3oYWdYFF8395kMv5QOcH4N5Sm/iUDGKi
 7mXkeUTsSsmDtclvaXOIIHJnMhSKjz5Wg3Vr26KTqfbz/KUM9tm5OpjYI
 Ieqwh5NXRyYjkMGmgq95z+cBCbj0chLjk4ufSnvGSvG9WRiB8wE6rj2G4
 QIUoPnVnuy2KK1jvd/5WORQzDwroA5MQ0JFtMnco3qMsiiAYF1Cz22xhu
 8jW1M2jhwhHP3+HtvjJX1BJCqjHnV52FOfafjp/UZgn98U9WXh5yqsJjB w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368113357"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="368113357"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2022 05:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="771172075"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; d="scan'208";a="771172075"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 05:10:34 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Tue, 18 Oct 2022 20:10:46 +0800
Message-Id: <6dbde04c0202c3ad37b976c7638bdb18932bb046.1666094709.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666094709.git.pengfei.xu@intel.com>
References: <cover.1666094709.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] cpuid.h: Provide the macro definition
 __cpuid_count()
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
Cc: chang.seok.bae@intel.com, eric.devolder@oracle.com,
 Heng Su <heng.su@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some ltp tests rely on information provided by the cpuid function.
The old cpuid function in the ltp/include/old/ltp_cpuid.h does not work
correctly.

Provide the macro definition __cpuid_count() in ltp.
It references below link:
https://github.com/gcc-mirror/gcc/blob/master/gcc/config/i386/cpuid.h#L233

Makes a little improvement to eliminate the "ERROR: Macros with complex values
should be enclosed in parentheses" warning from kernel/scripts/checkpatch.pl.

Reported-by: Richard Palethorpe <rpalethorpe@suse.de>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 include/lapi/cpuid.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/lapi/cpuid.h

diff --git a/include/lapi/cpuid.h b/include/lapi/cpuid.h
new file mode 100644
index 000000000..c58203509
--- /dev/null
+++ b/include/lapi/cpuid.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <cpuid.h>
+
+#ifndef LAPI_CPUID_H__
+#define LAPI_CPUID_H__
+
+/*
+ * gcc cpuid.h provides __cpuid_count() since v4.4.
+ * Clang/LLVM cpuid.h provides __cpuid_count() since v3.4.0.
+ *
+ * Provide local define for tests needing __cpuid_count() because
+ * ltp needs to work in older environments that do not yet
+ * have __cpuid_count().
+ */
+#ifndef __cpuid_count
+#define __cpuid_count(level, count, a, b, c, d) ({			\
+	__asm__ __volatile__ ("cpuid\n\t"				\
+			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
+			      : "0" (level), "2" (count));		\
+})
+#endif
+
+#endif /* LAPI_CPUID_H__ */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
