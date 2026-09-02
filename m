Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37723C624D5
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7B0A3E5888
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:12:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C88A3E93AA
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84E68200BD6
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E34321DE8;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG5rYwXAF3e2ucr/BRu88B8+T3A8cDKKC+bCeNSJgDo=;
 b=F2EAf6xwQE7ZHu5s4HXRRF3kRfZCaVqiSNNF3Pax/1tHej/LwqpKVp1soWARtqBHnxv4s7
 x/+sQ/APNUUkPEyo1gn/d5matkXKAF942vZ2g4QOwGc99refH7Ch9qVzyJxLcELTxe6GdQ
 qdjyLkDMR6B5FZSHoYEnvf3rM4dB3bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG5rYwXAF3e2ucr/BRu88B8+T3A8cDKKC+bCeNSJgDo=;
 b=EM0twK1/SSEYNSIq3UKt1cm+FkB3NxroPQiiI2ySFykax4parzesB928BiBAUYb98776Ru
 6LGqz1uGzY44jYDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ghc4BtYk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WUnVVZNK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG5rYwXAF3e2ucr/BRu88B8+T3A8cDKKC+bCeNSJgDo=;
 b=Ghc4BtYkKcl6vfif5t41EJ+HWLE+qojEsT1d4MlpQ5qOsQ4tBJ6F75DHNIdARPkGl4mghc
 ASuftqRwzU3Ok1zlwX88MQP5SCwDovW6HUQnh7y5MRyjAKKrIEkw6MhXoU4TYtaaxgGsFz
 GSK5KPOijlojFEfpLYZpmCDJ7qDASbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gG5rYwXAF3e2ucr/BRu88B8+T3A8cDKKC+bCeNSJgDo=;
 b=WUnVVZNKSspaXXT7m0DVc0avy3QLHK+Lu7iyAvjs2SER0OyEazr0nrCRl08r/VB5anJovz
 37AyzZ8TMr25thBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61216139A3;
 Wed,  2 Sep 2026 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ELHiFboCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:42 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-27-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=1811;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bbCEmUys1TnVZ67TrAAU+q0NyS87mxQxzKs8ZtLLjmo=;
 b=ohspWaDyTKG84i22u2l7Rp61H/le0458aySPPLJS8b6gvYqVyCsxbR6jsVGSViTM/yMXn3FpQ
 OWb/r0i8LFfBmrWDJnCSjUQmqOZHhwxPkR6wXSjrWzIjdLRsAXvGpjI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 2E34321DE8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 27/33] lapi/keyctl.h: Add capability fallback defines
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
 include/lapi/keyctl.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 8820c3ddb..27b0f8dd2 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -219,6 +219,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
 #endif
 
+#ifndef KEYCTL_CAPABILITIES
+# define KEYCTL_CAPABILITIES 31
+#endif
+
 #ifndef KEYCTL_PKEY_QUERY
 # define KEYCTL_PKEY_QUERY 24
 #endif
@@ -246,6 +250,20 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_SUPPORTS_VERIFY  0x08
 #endif
 
+#ifndef KEYCTL_CAPS0_CAPABILITIES
+# define KEYCTL_CAPS0_CAPABILITIES		0x01
+# define KEYCTL_CAPS0_PERSISTENT_KEYRINGS	0x02
+# define KEYCTL_CAPS0_DIFFIE_HELLMAN		0x04
+# define KEYCTL_CAPS0_PUBLIC_KEY		0x08
+# define KEYCTL_CAPS0_BIG_KEY			0x10
+# define KEYCTL_CAPS0_INVALIDATE		0x20
+# define KEYCTL_CAPS0_RESTRICT_KEYRING		0x40
+# define KEYCTL_CAPS0_MOVE			0x80
+# define KEYCTL_CAPS1_NS_KEYRING_NAME		0x01
+# define KEYCTL_CAPS1_NS_KEY_TAG		0x02
+# define KEYCTL_CAPS1_NOTIFICATIONS		0x04
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000
@@ -311,6 +329,7 @@ static inline long safe_keyctl(const char *file, const int lineno,
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
