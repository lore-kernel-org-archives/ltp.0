Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F95C55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F733E7155
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:15:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945C33CF2A2
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A374E1400E0E
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B7353DF8;
 Wed,  5 Aug 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E47779F1;
 Wed,  5 Aug 2026 15:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Mq/NnZTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:49 +0200
Message-ID: <20260805151451.648990-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1B7353DF8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/9] tst_kvercmp: Factor out 2 kernels integer
 comparison
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

Factor out 2 kernels integer comparison into tst_kver_cmp().

This will be heavily used in metaparse.c (speedup of metadata
generation) in the next commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 include/tst_kvercmp.h | 12 ++++++++++++
 lib/tst_kvercmp.c     | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 26e8f8e3c1..73353e82a5 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -7,6 +7,18 @@
 #ifndef TST_KVERCMP_H__
 #define TST_KVERCMP_H__
 
+/**
+ * tst_kver_cmp() - Compare two kernel versions, versions passed by 3 integers.
+ *
+ * @a1: First kernel major version.
+ * @a2: First kernel minor version.
+ * @a3: First kernel patch level.
+ * @b1: Second kernel major version.
+ * @b2: Second kernel minor  version.
+ * @b3: Second kernel patch level.
+ */
+int tst_kver_cmp(int a1, int a2, int a3, int b1, int b2, int b3);
+
 /**
  * tst_kvcmp() - Compare given kernel version with kernel in string.
  *
diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index c0714073d4..11b06189a9 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -96,17 +96,23 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 	return rc;
 }
 
+int tst_kver_cmp(int a1, int a2, int a3, int b1, int b2, int b3)
+{
+	int aver, bver;
+
+	aver = (a1 << 20) + (a2 << 10) + a3;
+	bver = (b1 << 20) + (b2 << 10) + b3;
+
+	return aver - bver;
+}
+
 int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
 {
 	int a1, a2, a3;
-	int testver, currver;
 
 	tst_parse_kver(cur_kver, &a1, &a2, &a3);
 
-	testver = (r1 << 20) + (r2 << 10) + r3;
-	currver = (a1 << 20) + (a2 << 10) + a3;
-
-	return currver - testver;
+	return tst_kver_cmp(a1, a2, a3, r1, r2, r3);
 }
 
 int tst_kvercmp(int r1, int r2, int r3)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
