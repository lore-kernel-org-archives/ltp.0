Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B48D232E8
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767944117; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ghE0Dl3iqbm2XFfwlGsHesT1XOUSdqRWh+qmnWH6Srg=;
 b=DnkvzvZeDvqHw5HrJmLra3SqWyV8KZgnbjPXHkLCO3HzOnQQzOes5HLleEFqsBrvo+El/
 DVAPxUylRHk+yf2qFpOa4xUu0j2pDj7paL/mGFjLZrTF3zTahiHxzpyZ+vN1gy6yKU9nOVt
 SRVCa2sYUIF4Vz09OTFqgZSdkNUTY5o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8443C6FC1
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 08:35:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94683C6AA3
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 08:34:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 665E91400BE4
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 08:34:51 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DF4AF3F77B; 
 Fri,  9 Jan 2026 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767944091;
 bh=8wm3HzVTUVuI9KQnY6CaUaFIS5lCO/6dGygWUOPy8Mg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UGjcnOBLjWcHsUBMd5yP1zUPg6Hb1C+7tumk63SjGPq1evgl1uqylwGcFEjH1HEPY
 t/aqZcTGHeK0AyF+z5+p4mk3tyWKv1zBIcK/xJRSrVM2zUhKktdRTkpPXK3mn5dG46
 sjdvtzZ70V34ReR2UaYAWviUb7GnLohHJkMYUMREjA1RjcSh0M0nc62OPKvNXIbpvR
 MNYhoZsWWTZXOe5MjP+BycaMDZSKmL3akedMvmobfvUzcSQAtho1aWWYaBGbvkgV25
 amgv2NO3p8zdHQNjx5TACegLv1VOlpmfg61yalvLve+HxBvQobLDJj1Eeam7jfg3t5
 +kvmKPbAykqZdxhjQ+pJXeIbUR/eUzlc3BEpAlydNAhXVQjHcN1c8S9TOssuoj9GqD
 eKNQ/Gv5PpUkvvaa03F1OPgS6MW6hCi7HwMngwLkmTF09j9EyXY69DaU8fL08rZOgD
 CGePdNQkVlw8iWKDLTdO+Q10kMjgRCAsA4KIC5oSsdW/MVui9nc8Eq4RQ439L73sbh
 4n7oLbmQdue4JFPcyjsh6IUJNtF2KpKIgl5OgSBOHnM/KqRCnPa1lBhyUXHxuCSG0d
 BOEUpLzISN6ENiIwq+SzO4hcnTRPVST3pwMf+Kl9/HnjuJuNuqaJvWlJ+KgrGC/mzH
 er1zJUk7KI5vU7NuL6FLpg7c=
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 15:34:19 +0800
Message-ID: <20260109073419.158752-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tpci.c: Skip on Lockdown/Secure Boot
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following the commit ca9460deef ("fw_load: Skip on Lockdown/Secure Boot")
to take care of:

test_pci    0  TINFO  :  module signature enforcement: off
insmod: ERROR: could not insert module ltp_tpci.ko: Key was rejected by service

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/device-drivers/pci/tpci_user/tpci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 5d241fb42..a2ca62fb7 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -29,6 +29,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "old_module.h"
+#include "tst_security.h"
 
 #include "../tpci_kernel/tpci.h"
 
@@ -52,6 +53,8 @@ void setup(void)
 	tst_require_root();
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_requires_module_signature_disabled();
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");
 }
 
 static void run_pci_testcases(int bus, int slot)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
