Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9E7CAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:48:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19C33CE33B
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:48:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ACBE3CE2E7
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35E2D20096B
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 395CF22B6D;
 Tue,  7 Oct 2025 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDVfx1Nz9ffD0KmyvFLMLzfrftPffljoVllUFu3AYwU=;
 b=gxutHOsnfAheThs9lrIvnMxhqHzj1BTkSz23RzbrfNAy1/v7EzB2KGlO8gSpC+BXDRCN4P
 SrCFMvP5sJ/VhuYijlOsRMhIo3bCKRUEMvC7mP/9JXG6TajXKo5h4pvelWEgxpws1aeZY6
 J5u04nqkH5cVOlZkGSRP38FEleGBKqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDVfx1Nz9ffD0KmyvFLMLzfrftPffljoVllUFu3AYwU=;
 b=irSH241BLtvoEHOdAiEcSvjKr638mvMHEvC3eM7NhWHC74BcuHgOg6WMcAb04QbAiffMaC
 wVbzH3UCVTtGdXCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gxutHOsn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=irSH241B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDVfx1Nz9ffD0KmyvFLMLzfrftPffljoVllUFu3AYwU=;
 b=gxutHOsnfAheThs9lrIvnMxhqHzj1BTkSz23RzbrfNAy1/v7EzB2KGlO8gSpC+BXDRCN4P
 SrCFMvP5sJ/VhuYijlOsRMhIo3bCKRUEMvC7mP/9JXG6TajXKo5h4pvelWEgxpws1aeZY6
 J5u04nqkH5cVOlZkGSRP38FEleGBKqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDVfx1Nz9ffD0KmyvFLMLzfrftPffljoVllUFu3AYwU=;
 b=irSH241BLtvoEHOdAiEcSvjKr638mvMHEvC3eM7NhWHC74BcuHgOg6WMcAb04QbAiffMaC
 wVbzH3UCVTtGdXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9289413AAC;
 Tue,  7 Oct 2025 06:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDt0FXK35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:59 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-7-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=994;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=VEf0ux4UfsGrjQty0n0CmD2w8oV39zusnz25HxhCeQs=;
 b=jd92tzId8+o3JRWKYWxB8lbo1GNWQtOi3MrlG0iV8Kh/XY2/27ItUma7ynuHx9RozsmrFo5pd
 kONht2FGWntDdn1tebDDiVQyzMrYl7qZX0H0F/qOmPRkSKsc5HGpjWt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 395CF22B6D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 07/10] lapi: add removexattrat() fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         | 1 +
 include/lapi/xattr.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index e43e631ab..e77377a60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -153,6 +153,7 @@ AC_CHECK_FUNCS_ONCE([ \
     quotactl_fd \
     rand_r \
     recvmmsg \
+    removexattrat \
     renameat2 \
     sched_getcpu \
     sendmmsg \
diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
index 3b664e4e6..2ca05c787 100644
--- a/include/lapi/xattr.h
+++ b/include/lapi/xattr.h
@@ -51,4 +51,12 @@ static inline int getxattrat(int dfd, const char *pathname,
 }
 #endif
 
+#ifndef HAVE_FUNC_REMOVEXATTRAT
+static inline int removexattrat(int dfd, const char *pathname,
+			     unsigned int at_flags, const char *name)
+{
+	return tst_syscall(__NR_removexattrat, dfd, pathname, at_flags, name);
+}
+#endif
+
 #endif /* LAPI_XATTR_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
