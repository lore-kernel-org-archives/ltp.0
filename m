Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85292CD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:29:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC8A3CBC10
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:29:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 005B93CBC10
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F393600A25
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:29:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 503305D1C2;
 Thu,  7 May 2026 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778156944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=B6unl9UwcypjwsXSzbwnvmtr/1y28bdkAyqXe834WTDIIvv32nqZvp69btHmkGPIEiDWaY
 uQbOFCdkoRQhvvUeQk2CaEPnBP2TGzprRSz9GZy9IRv7UKV636yEOBTKbfgWGP0KgFtVBY
 Dg7hE7MSi8VdYLKVmIjDhzOJvutHFfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778156944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=sxWQhS2FmyroOWHvRY9p0OXTEADQ2x10dDEnGgtnv3VBPgtBR+sxkIBxbhpukutTbNHx1F
 m41zPVpc0EzbspAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778156944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=B6unl9UwcypjwsXSzbwnvmtr/1y28bdkAyqXe834WTDIIvv32nqZvp69btHmkGPIEiDWaY
 uQbOFCdkoRQhvvUeQk2CaEPnBP2TGzprRSz9GZy9IRv7UKV636yEOBTKbfgWGP0KgFtVBY
 Dg7hE7MSi8VdYLKVmIjDhzOJvutHFfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778156944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JhYHxAcPTHWaYpuKKXNIUXRtK7iE8b8eG+My2X2F53w=;
 b=sxWQhS2FmyroOWHvRY9p0OXTEADQ2x10dDEnGgtnv3VBPgtBR+sxkIBxbhpukutTbNHx1F
 m41zPVpc0EzbspAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 153E2593A7;
 Thu,  7 May 2026 12:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5XnpAZCF/Gk9OgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 12:29:04 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 14:28:53 +0200
Message-ID: <20260507122858.19670-1-rbranco@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] userfaultfd: Add helper for checking UFFD
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
