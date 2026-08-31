Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C6C624A5
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:00:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D863E59C9
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:00:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E2033C98E4
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 61F0F60045C
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:00:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9891022440;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=aJlM4PRU8f6tsQNeuVgZ/765kMe/2UcmRAYnRuogROBFtwgpN6y3/BkcTQP4TmmMxtkWgm
 NPZrUE4sP5jNb/OnATys/bEkAr+JJJRaQGDCEAYY+zeQZ1faOUIKcYdsu4oO4h9bVW4ar/
 Zf2Kh32EF2OpeJ5SqNAKSSj8g5lJT1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=QFYH2batBokRbpYDzTkDrdJ7DulOkRA1c8x4G+Y5ZwkTTbiOt2SgBXzeauc/1PJZdG8A+r
 /YKxErogcA68ryDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tsC0S/yc";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pMgn7N8U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788163206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=tsC0S/ycolLt1BmTJQid3mlfgSAvQXkbbtE8U39BxPm3HG2PKpSrJBVOAbF/V/9Ye765BO
 dqMvVW7PEWlEUqwJbIHY8fTU4CFhctS9XJPIzUIAZRgVR1418PqCMYTftTzRwe4sodHFQU
 J6NHsl2Efl0G4NYzpiaUUMQv86doNCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788163206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=pMgn7N8USL65OTAN8qivLzSSF+ci8/jFjXzURypSt8Pv9TfZRI4BO2ltVWtPQK90AWlW8f
 K7KxDiDIIHZwuRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8BD136B2;
 Mon, 31 Aug 2026 08:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uK+0FYY0lWo9dQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Aug 2026 08:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 10:00:04 +0200
MIME-Version: 1.0
Message-Id: <20260831-fchroot-v4-3-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
In-Reply-To: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788163205; l=801;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EHGosZsiUsvPbtWv+YgPdQhXcWeCKJec/0bk4ipppw=;
 b=5mPs92ROn3v2N3OhW1z9GjvUVIBCTbn402DpWI4AYLA4YHlX7QmPS6LMCIGl4jyh7sO7fwSgk
 egvrzU8qIT+CvbMXXbur8GkT9ELzBSXL5l+sdJH+Bs5YzCrqtjl0PsW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9891022440
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH STAGING v4 03/16] lapi: fallback fchroot() parameters
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

Add to fcntl.h fallback definitions:

- FD_PIDFS_ROOT
- FD_NSFS_ROOT
- FD_FAILFS_ROOT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/fcntl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 6a9ef11ce..d70954ea7 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -144,6 +144,19 @@
 # endif
 #endif
 
+/* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
+#ifndef FD_PIDFS_ROOT
+# define FD_PIDFS_ROOT		-10002
+#endif
+
+#ifndef FD_NSFS_ROOT
+# define FD_NSFS_ROOT		-10003
+#endif
+
+#ifndef FD_FAILFS_ROOT
+# define FD_FAILFS_ROOT		-10004
+#endif
+
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 1
 #endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
