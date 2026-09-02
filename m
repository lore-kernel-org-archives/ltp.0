Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2186C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:10:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 583163C198F
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:10:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E62163E93B0
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6114A100023C
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA1A71FAB4;
 Wed,  2 Sep 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxjZhvtbVFs4Bx4UnRsmMeW3w2R0qb4NdYT+7AFmaQE=;
 b=N0qyBWpOcEIG/510cPwJMMKSOK7VajT438o2u4IQy+IhHSy7OnId6b2n/AOHdTnlROdiJx
 bQWRvtfr2GjUv6uG39VcbFjMbrTTq3lrjCPtKIWlg1f4sTL1xfq0kmY9zVjmBYsAxu8TmU
 z+T5E0SFWCwk49akiIWWDcWXaw8RN5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxjZhvtbVFs4Bx4UnRsmMeW3w2R0qb4NdYT+7AFmaQE=;
 b=Y5xoK3miVx8wG4uhJ/7TE2Mk1/8m6Xg2jOsdFAbYBEsAhObisTl0gzgHYKLhPCv4sSYAKt
 2eQka/KCFeJyKxDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxjZhvtbVFs4Bx4UnRsmMeW3w2R0qb4NdYT+7AFmaQE=;
 b=CAiWgs/4WC8CAPhPdtvApJOFIcAcxfJerehQIC8A4pYMANA6qjz+BnBBtFQWBbdwXefe/l
 xFnwGmWVvA4yW/7xJJG+8w7A6T88SiXF8iRslidvfpyrvkJ5fXPjwfG+YK8NCPTzkIZJyV
 ZoUvXkLcKQYovkHxwwsTntq2V7Bjh3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxjZhvtbVFs4Bx4UnRsmMeW3w2R0qb4NdYT+7AFmaQE=;
 b=GZUWQhtTnz2wrDD+uGBgHbetzNigbwI/y56K7E9fSbOdgC9qnc1mRahFAQiXNoSZaX/fY4
 tF2j1VwY3BwDqHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7816E13994;
 Wed,  2 Sep 2026 11:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8HaRG7kCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:36 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-21-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2386;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rbVxeqFvsi1htV0CNApzFqCRuu44LxpJCOqFWNrbtZY=;
 b=4X5/3KvDfe4OGGHFwliL4zh/iA02b+Z7a6kAwFWeKbgy47hGkuJIOZYoerjpcagNPvGGyNKUd
 5gpsw5Hu2naAerur/fpVd+t2nlbmT0WO+V2qEI1Gr8q3NzfGen4yE0J
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 21/33] lapi/keyctl.h: Add fallback definitions for
 public key ops
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add fallback definitions for KEYCTL_PKEY_QUERY, KEYCTL_PKEY_ENCRYPT,
KEYCTL_PKEY_DECRYPT, KEYCTL_PKEY_SIGN, KEYCTL_PKEY_VERIFY, and
KEYCTL_SUPPORTS_*, as well as fallback structs keyctl_pkey_query
and keyctl_pkey_params when built without keyutils.h or linux/keyctl.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index a056ddaad..8820c3ddb 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -33,6 +33,26 @@ struct keyctl_kdf_params {
 	uint32_t otherinfolen;
 	uint32_t __spare[8];
 };
+
+struct keyctl_pkey_query {
+	uint32_t	supported_ops;
+	uint32_t	key_size;
+	uint16_t	max_data_size;
+	uint16_t	max_sig_size;
+	uint16_t	max_enc_size;
+	uint16_t	max_dec_size;
+	uint32_t	__spare[10];
+};
+
+struct keyctl_pkey_params {
+	int32_t		key_id;
+	uint32_t	in_len;
+	union {
+		uint32_t	out_len;
+		uint32_t	in2_len;
+	};
+	uint32_t	__spare[7];
+};
 #endif
 
 static inline key_serial_t add_key(const char *type,
@@ -199,6 +219,33 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
 #endif
 
+#ifndef KEYCTL_PKEY_QUERY
+# define KEYCTL_PKEY_QUERY 24
+#endif
+
+#ifndef KEYCTL_PKEY_ENCRYPT
+# define KEYCTL_PKEY_ENCRYPT 25
+#endif
+
+#ifndef KEYCTL_PKEY_DECRYPT
+# define KEYCTL_PKEY_DECRYPT 26
+#endif
+
+#ifndef KEYCTL_PKEY_SIGN
+# define KEYCTL_PKEY_SIGN 27
+#endif
+
+#ifndef KEYCTL_PKEY_VERIFY
+# define KEYCTL_PKEY_VERIFY 28
+#endif
+
+#ifndef KEYCTL_SUPPORTS_ENCRYPT
+# define KEYCTL_SUPPORTS_ENCRYPT 0x01
+# define KEYCTL_SUPPORTS_DECRYPT 0x02
+# define KEYCTL_SUPPORTS_SIGN    0x04
+# define KEYCTL_SUPPORTS_VERIFY  0x08
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
@@ -259,6 +306,11 @@ static inline long safe_keyctl(const char *file, const int lineno,
 	case KEYCTL_GET_SECURITY:
 	case KEYCTL_GET_PERSISTENT:
 	case KEYCTL_DH_COMPUTE:
+	case KEYCTL_PKEY_QUERY:
+	case KEYCTL_PKEY_ENCRYPT:
+	case KEYCTL_PKEY_DECRYPT:
+	case KEYCTL_PKEY_SIGN:
+	case KEYCTL_PKEY_VERIFY:
 		if (rval < 0)
 			failure = 1;
 		break;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
