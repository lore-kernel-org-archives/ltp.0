Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56727C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:05:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCD6F3E2D90
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:05:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DDC3E93B1
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DEC81400C40
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0571F7FD;
 Wed,  2 Sep 2026 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQvScvKfdqpbQqm82LdnyL/c6qLLeydLGiA8UubvbQE=;
 b=NrEASxynYIZb4B94UXR+Q3Mxa+1hEjVZb2RncwgeSBMDbo7lSVEHesDda13CunX6tPv+sV
 jfy+hOP0knnsuohqw22QN4AA+qeEPU21HXILzgVv/uPTuDjerA6ZQcX34dNqF+P7gBnG/l
 ARsACBOGdYN7PmayIJRKEmJvyf6evxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQvScvKfdqpbQqm82LdnyL/c6qLLeydLGiA8UubvbQE=;
 b=MMHfiQmx+Mys3vIYnSOGvMznXUMi0KD1zSJY7R+H1pQ3PD4+GeBBQS954vIUMfydmCbp4K
 FuABbQgp0hsYqSCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RW648iFJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RJtbHV2O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQvScvKfdqpbQqm82LdnyL/c6qLLeydLGiA8UubvbQE=;
 b=RW648iFJ2FaF78E6E1oyRCZ2NCWtDQljMHCLfizMYbvJnJQsfYihvwbBJt08mHkqSarB0Z
 uRen4G/6HoBRQOiNl8B4LOeBPPiuwzheIJcNARfr6xBCSYfNHycFGBcwab+g+B9611sr0X
 tvsOoHCz4slFjfOviDb8QgsawkWB+oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQvScvKfdqpbQqm82LdnyL/c6qLLeydLGiA8UubvbQE=;
 b=RJtbHV2Odku2nMELMySIwUDsq5t6lgHNW51nemFMe2ZYDoEmVjYdSEIPg06p6wWFYaszzi
 A1RCo3PDhgHvAWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BAB5136E6;
 Wed,  2 Sep 2026 11:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6LSLGLYCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:16 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-1-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=1813;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=syYeoVhMKhGC30JJ4lfyWqMGiR0XgDaKJhkXIfnrlXI=;
 b=qS14kqXwGBvWNP24WoKv+7WVKqmJG1FntpdYsf+pSks9nDeSwERG0kjUPVlP21IS4tSBOmIM4
 wFciC+ng31CBkomDymlGWQ13xrbJ8Df7EGj9WEuqcrsoocIbVojMxe4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E0571F7FD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/33] lapi/keyctl.h: Add fallback definitions for
 extended ops
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

Add fallback definitions for KEYCTL_LINK, KEYCTL_RESTRICT_KEYRING,
KEYCTL_MOVE, and KEYCTL_MOVE_EXCL, as well as fallback definitions
for struct keyctl_dh_params and struct keyctl_kdf_params when built
without keyutils.h or linux/keyctl.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/keyctl.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index 83fa09303..a056ddaad 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -20,6 +20,21 @@
 # include "lapi/syscalls.h"
 typedef int32_t key_serial_t;
 
+#if !defined(HAVE_KEYUTILS_H) && !defined(HAVE_LINUX_KEYCTL_H)
+struct keyctl_dh_params {
+	int32_t priv;
+	int32_t prime;
+	int32_t base;
+};
+
+struct keyctl_kdf_params {
+	char *hashname;
+	char *otherinfo;
+	uint32_t otherinfolen;
+	uint32_t __spare[8];
+};
+#endif
+
 static inline key_serial_t add_key(const char *type,
 				   const char *description,
 				   const void *payload,
@@ -124,6 +139,10 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_CLEAR 7
 #endif
 
+#ifndef KEYCTL_LINK
+# define KEYCTL_LINK 8
+#endif
+
 #ifndef KEYCTL_UNLINK
 # define KEYCTL_UNLINK 9
 #endif
@@ -168,6 +187,18 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEYCTL_WATCH_KEY 32
 #endif
 
+#ifndef KEYCTL_RESTRICT_KEYRING
+# define KEYCTL_RESTRICT_KEYRING 29
+#endif
+
+#ifndef KEYCTL_MOVE
+# define KEYCTL_MOVE 30
+#endif
+
+#ifndef KEYCTL_MOVE_EXCL
+# define KEYCTL_MOVE_EXCL 0x00000001 /* do not displace from the to-keyring */
+#endif
+
 /* key permissions */
 #ifndef KEY_POS_VIEW
 # define KEY_POS_VIEW    0x01000000

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
