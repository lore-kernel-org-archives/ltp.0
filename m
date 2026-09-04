Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3B4C79F85
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718983E935B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:17:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7183E978F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 872BE100113E
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE1071FE88;
 Fri,  4 Sep 2026 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O03HI6NdFud6YXCgTztjtcyDojzTMx+tAucdnI6+dZk=;
 b=XB8+hFakTHNaoiOYJOhMm1mc5b+FjEHtRq/t01YUsjB2Ht9iKhHFMQgP4laby9rZgfAr0x
 01D6qJuHrqBqXjGGYuejnTv51tv0RXKWwk2tOrMCpDNQOglsb8jYV+ueZPMkDtViX9uwsy
 qfaO/QR2fRKMtN0ReTqYSi0g/NpEqhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O03HI6NdFud6YXCgTztjtcyDojzTMx+tAucdnI6+dZk=;
 b=4CkglcSUu/6med1HxedyZyz5pWasFLazqDPrQg1goi/2VQJu9it/3owJfveV8jFZF7b2fZ
 0DNjbyNa3ycGTYAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uTrwC5xk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bZJaNgbY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O03HI6NdFud6YXCgTztjtcyDojzTMx+tAucdnI6+dZk=;
 b=uTrwC5xk/FA8QjNIERC5FMg/wwXABwgl2sPB3CcyVvXFelMNk4wkpXNDgLY1FJU/O4rJ52
 BF90KIozdOWX8rMNo+wwHw5ReoYrXBL7+YE/5gIdP7TnIinDb0CmuGfr/oeRVrNsC34djm
 u2DZ/1eXh4at4IX0IC5RaV0ounDqmLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O03HI6NdFud6YXCgTztjtcyDojzTMx+tAucdnI6+dZk=;
 b=bZJaNgbYfFi+Lf8lAnmsnfvbeD4CSQ/of6qbFsGzNS4J9CjYk82vb7mbiMrFGQmBsdiknX
 6sEWJZsQotcv1cAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 174EA139EF;
 Fri,  4 Sep 2026 12:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AC/7Atq0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:16 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-27-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2225;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=TWbrA6+7G+Y9x6T8cQitSYTVNWQC1CwuzfuHBAj1NxI=;
 b=JtINYkE+fisLW/hj/NZltPSweJFI3Pze4ezJbo+lyVEfp2wXp9mspPsJ3RlpjbLIMBWJi370U
 VfBU8tb9ZimAlqapHPrLaHFWYPzn+FlqazQUfM7KM/U7yC4hRxsF6/r
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CE1071FE88
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 27/33] lapi/keyctl.h: Add capability fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 2574c3168..6feca63be 100644
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
