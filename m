Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B846C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:11:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C2953E8C4B
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:11:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44963E8C48
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2842E10009C3
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1AD21FEE9;
 Wed, 16 Sep 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6spclHHx3R9Q23LwPIXmVYVEZw0Y4OwXun8isMhmAq0=;
 b=PtrrRuURkipOx06OOJHRTwlJQ7NA1E/tVLiZYfczrWueKxCh41VALOwL/HVseEqmwsj5ca
 Jps2+V2mcFX8yIFTBxWX8YMDxRMaOa4PmhJHVIKIrNwx+gBRDJg3Qx57LLa3vZhkm6ZYZm
 kUwZGVJtM+ycXaZpMoml8dJ9JYFacz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6spclHHx3R9Q23LwPIXmVYVEZw0Y4OwXun8isMhmAq0=;
 b=3eSZuWorFATdymsGV5HHByH8dFprkCV6wkwR2pBk12N44wwcfyeZ8t2m/c2EuKHNWnPQAS
 zYaK+CcnH7HZZqAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6spclHHx3R9Q23LwPIXmVYVEZw0Y4OwXun8isMhmAq0=;
 b=J8ZoVWMiAegdxRpQvcjBNxAgJ944P6rC5b5IwyMBbbtTDKckJpdt2+Yia/Awhsqye2yi8H
 eV3ZOpqEwjiDvTPCEtDanBGmkFGH1ojabKfFEANCtaHifF4LTV1jjZeKL8GvTZeMkcax/T
 GcpIGuJsUHRSjLP5tYVpnPd2FkJryj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6spclHHx3R9Q23LwPIXmVYVEZw0Y4OwXun8isMhmAq0=;
 b=zYF0jeC+lEgTSzkXpCuow0c9yvvfab0ht5sjadf6dEk1fPZlqhvOFNvU20c9ZFnLayBtsc
 lC+EHrKYRyx+ehCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09FCA139BF;
 Wed, 16 Sep 2026 14:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T31
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:56 +0200
Message-ID: <20260916140402.1797325-31-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLtzdurrd6usbijy4f5nozqpqy)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:mid];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 30/36] lapi/keyctl.h: Add capability fallback
 defines
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

Add fallback definitions for KEYCTL_CAPABILITIES, KEYCTL_CAPS0_*,
and KEYCTL_CAPS1_* constants, and update safe_keyctl to handle
KEYCTL_CAPABILITIES.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/keyctl.h | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index fdb68d1725..473616bd51 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -226,6 +226,10 @@ struct keyctl_pkey_params {
 # define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
 #endif
 
+#ifndef KEYCTL_CAPABILITIES
+# define KEYCTL_CAPABILITIES 31
+#endif
+
 #ifndef KEYCTL_PKEY_QUERY
 # define KEYCTL_PKEY_QUERY 24
 #endif
@@ -253,6 +257,50 @@ struct keyctl_pkey_params {
 # define KEYCTL_SUPPORTS_VERIFY  0x08
 #endif
 
+#ifndef KEYCTL_CAPS0_CAPABILITIES
+# define KEYCTL_CAPS0_CAPABILITIES		0x01
+#endif
+
+#ifndef KEYCTL_CAPS0_PERSISTENT_KEYRINGS
+# define KEYCTL_CAPS0_PERSISTENT_KEYRINGS	0x02
+#endif
+
+#ifndef KEYCTL_CAPS0_DIFFIE_HELLMAN
+# define KEYCTL_CAPS0_DIFFIE_HELLMAN		0x04
+#endif
+
+#ifndef KEYCTL_CAPS0_PUBLIC_KEY
+# define KEYCTL_CAPS0_PUBLIC_KEY		0x08
+#endif
+
+#ifndef KEYCTL_CAPS0_BIG_KEY
+# define KEYCTL_CAPS0_BIG_KEY			0x10
+#endif
+
+#ifndef KEYCTL_CAPS0_INVALIDATE
+# define KEYCTL_CAPS0_INVALIDATE		0x20
+#endif
+
+#ifndef KEYCTL_CAPS0_RESTRICT_KEYRING
+# define KEYCTL_CAPS0_RESTRICT_KEYRING		0x40
+#endif
+
+#ifndef KEYCTL_CAPS0_MOVE
+# define KEYCTL_CAPS0_MOVE			0x80
+#endif
+
+#ifndef KEYCTL_CAPS1_NS_KEYRING_NAME
+# define KEYCTL_CAPS1_NS_KEYRING_NAME		0x01
+#endif
+
+#ifndef KEYCTL_CAPS1_NS_KEY_TAG
+# define KEYCTL_CAPS1_NS_KEY_TAG		0x02
+#endif
+
+#ifndef KEYCTL_CAPS1_NOTIFICATIONS
+# define KEYCTL_CAPS1_NOTIFICATIONS		0x04
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
@@ -318,6 +366,7 @@ static inline long safe_keyctl(const char *file, const int lineno,
 	case KEYCTL_PKEY_DECRYPT:
 	case KEYCTL_PKEY_SIGN:
 	case KEYCTL_PKEY_VERIFY:
+	case KEYCTL_CAPABILITIES:
 		if (rval < 0)
 			failure = 1;
 		break;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
