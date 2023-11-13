Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EC1C4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 15:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0406D3CE5C4
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:07:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74C033C2A65
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:06:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACCE36008C7
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:06:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A13EA1F7AB;
 Mon, 13 Nov 2023 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699887998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xT9yIpOLsh5ceoUn03NnoDBguj4zTcaRX7Jkj206v+o=;
 b=DnwpmbU9f7N34/TajQp96b3OBumOvjhSpjksiRpCGhOFEvBkCNVt+Lh1ntD4AoaMv/u1wj
 drAJBPHO2WIhMvx8clMFOEn4qpYxrQME39uqjh8+8AGa75TSF4TnN4opQUoDWS6bpBkrPl
 qLf4Yt4bU7qObNhciQXe92g90FptbYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699887998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xT9yIpOLsh5ceoUn03NnoDBguj4zTcaRX7Jkj206v+o=;
 b=PC+c3KCBNvq56rs8SlKI0hms/OqxFG/aHPJJeV63W43aO2JDoLTVAwwBOF+a073bLfEbRH
 lPaERJUHVF8O4JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F56E1358C;
 Mon, 13 Nov 2023 15:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id whqmIX47UmVHPwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Nov 2023 15:06:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Mon, 13 Nov 2023 16:06:31 +0100
Message-ID: <20231113150636.3476-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Add TST_KCONFIG_INIT() helper macro
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

Add helper macro for initializing the tst_kconfig_var structure
to simplify kernel config checks during test runtime.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 include/tst_kconfig.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index cc0908ea8..8b24a8380 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -6,6 +6,14 @@
 #ifndef TST_KCONFIG_H__
 #define TST_KCONFIG_H__
 
+/**
+ * Initialization helper macro for struct tst_kconfig_var. Requires <string.h>
+ */
+#define TST_KCONFIG_INIT(confname) { \
+	.id = confname, \
+	.id_len = strlen(confname) \
+}
+
 struct tst_kconfig_var {
 	char id[64];
 	unsigned int id_len;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
