Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA487C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:12:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62F983E7D54
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:12:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EAFE3E8C50
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8AA9D10009B6
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5641D21C2C;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U+UyUQpZZd2ZijI435j6TddEcoomJ9Z3ehloe3BFus=;
 b=FrUwQl5sEXclySrWCQnNmrYOwoEgpF4TpgARuksZxXInTWTtHOUB6RyHNJvFq7C4LdmABi
 8RUcWrJoe7X4viSAcZkCgyNfXdB9LhFPkutL7AKg/7xPxlubNZ8yJn3h078HAHSmfvo/5n
 vnk58foQzVYRkbbUuXLTf1tersR0Q7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U+UyUQpZZd2ZijI435j6TddEcoomJ9Z3ehloe3BFus=;
 b=6Ups6UV6RhEEJFA7CsJDg4wqB3CslaJSxL0Z3wCX7iQjPxLxYDlbxZzRp53pb+ikOSdHct
 vDbPXJqrzLRtDIDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U+UyUQpZZd2ZijI435j6TddEcoomJ9Z3ehloe3BFus=;
 b=IwQ/dKgk3XV77Jq6ITbJ/pQ9ZNHZmzG0noO7lWuIWgroWmDXUzcvtw07L8yNfJ6uG++27v
 QbDOiysCpj2MAfX7NYnvFqTcBH0No8TOFXH8AhoeKc7r0gbd0jbwPkEmVJgZUu9YHxKW4B
 jbXwlbr7CyYWddfJjQr+4Bzoz6VtMdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7U+UyUQpZZd2ZijI435j6TddEcoomJ9Z3ehloe3BFus=;
 b=McpjFSjEPUEfrAE7kN3/1h1sH9qMcKU0EcR0dL2hp+u7Yszhc4R0Wu06xLVS8v9pi4E7Fz
 /y5F2gc++NwRMWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 805CD139BD;
 Wed, 16 Sep 2026 14:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T25
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:50 +0200
Message-ID: <20260916140402.1797325-25-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 24/36] lapi/keyctl.h: Add fallback definitions for
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
and keyctl_pkey_params when built without linux/keyctl.h.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 4ba797bf9c..fdb68d1725 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -78,6 +78,30 @@ struct keyctl_kdf_params {
 };
 #endif
 
+#ifndef HAVE_STRUCT_KEYCTL_PKEY_QUERY
+struct keyctl_pkey_query {
+	uint32_t	supported_ops;
+	uint32_t	key_size;
+	uint16_t	max_data_size;
+	uint16_t	max_sig_size;
+	uint16_t	max_enc_size;
+	uint16_t	max_dec_size;
+	uint32_t	__spare[10];
+};
+#endif
+
+#ifndef HAVE_STRUCT_KEYCTL_PKEY_PARAMS
+struct keyctl_pkey_params {
+	int32_t		key_id;
+	uint32_t	in_len;
+	union {
+		uint32_t	out_len;
+		uint32_t	in2_len;
+	};
+	uint32_t	__spare[7];
+};
+#endif
+
 /* special process keyring shortcut IDs */
 #ifndef KEY_SPEC_THREAD_KEYRING
 # define KEY_SPEC_THREAD_KEYRING -1
@@ -202,6 +226,33 @@ struct keyctl_kdf_params {
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
@@ -262,6 +313,11 @@ static inline long safe_keyctl(const char *file, const int lineno,
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
