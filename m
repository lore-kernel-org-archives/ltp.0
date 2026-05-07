Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74BACD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:31:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19FD43E614C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:31:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75D173E2C33
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:31:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F1AD1400544
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:31:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20C4D5D3D2;
 Thu,  7 May 2026 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=r06/j0DDFy1E6LchAN/7F+OW9eGamNt31bNAmDV08QxiD/3nodwxXjwZHucrkpNHYOd8+t
 fp/MKVeN173r3GGaTolmUZaipnv8U3hU0A3zBR9EqClQPXOdqDFJPNvnJqRXxKK0NxvFRq
 bHOzvLHzamQZBLgePBfHzrNMP0C/BlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=PAwM+ucIwFIsCH9gb08k1ZZrTDJuS5ku0D/DzAGeUzc5jLEkHJrxQOumVjTKtoTlTGz7AR
 1ztLm0nGqW6VwRCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r06/j0DD";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PAwM+ucI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=r06/j0DDFy1E6LchAN/7F+OW9eGamNt31bNAmDV08QxiD/3nodwxXjwZHucrkpNHYOd8+t
 fp/MKVeN173r3GGaTolmUZaipnv8U3hU0A3zBR9EqClQPXOdqDFJPNvnJqRXxKK0NxvFRq
 bHOzvLHzamQZBLgePBfHzrNMP0C/BlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=PAwM+ucIwFIsCH9gb08k1ZZrTDJuS5ku0D/DzAGeUzc5jLEkHJrxQOumVjTKtoTlTGz7AR
 1ztLm0nGqW6VwRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D14D7593A7;
 Thu,  7 May 2026 08:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KoVxL+ZN/GnVRwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 08:31:34 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 10:31:23 +0200
Message-ID: <20260507083131.28197-1-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 20C4D5D3D2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] userfaultfd: Add helper for checking UFFD
 feature support
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

Add CHECK_UFFD_FEATURE() to perform the initial UFFDIO_API handshake
without requesting optional features and verify that the kernel reports
the requested feature bit.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 include/lapi/userfaultfd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index aab3890b7..170dfadd4 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -277,4 +277,24 @@ retry:
 	return ret;
 }
 
+#define CHECK_UFFD_FEATURE(feature)	check_uffd_feature(feature, #feature)
+
+static inline void check_uffd_feature(uint64_t feature, const char *name)
+{
+	struct uffdio_api uffdio_api = {};
+	int uffd;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	if (!(uffdio_api.features & feature)) {
+		SAFE_CLOSE(uffd);
+		tst_brk(TCONF, "%s not supported", name);
+	}
+
+	SAFE_CLOSE(uffd);
+}
+
 #endif /* LAPI_USERFAULTFD_H__ */
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
