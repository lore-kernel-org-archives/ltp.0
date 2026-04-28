Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B4FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:33:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC96C3E49F7
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 15:33:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 297433DEFF3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:32:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AEE5814004EE
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 15:32:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C2F15BCFE
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777383158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z5wQ2/r1uRm2fKOp9YwEbUVk059hmYE3cd1uOckcQuU=;
 b=0RuuPPzmysOJAcx46vY5Bo9knHXQNlYLeKhAwgGENrdxKjagJWKfgyoA9Sfo9duvVb6smZ
 irL+h5ZOjuNDheUHxG5cWvRHsLeEw5XuRGauJP2GmecrWsJpDgrVUzath3j/MvJxL+pGpU
 93h+eanSNVe2ejD5vM/LBn1OxWCNh44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777383158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z5wQ2/r1uRm2fKOp9YwEbUVk059hmYE3cd1uOckcQuU=;
 b=eZcqXTY0OKF3Of3ZrgbJaGASvZAbZXp48zPY9ovAyt9mJ86pyDPyzcqoiG3jg6IyEKRDEs
 JGzNQ+9w5vYLduCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0RuuPPzm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eZcqXTY0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777383158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z5wQ2/r1uRm2fKOp9YwEbUVk059hmYE3cd1uOckcQuU=;
 b=0RuuPPzmysOJAcx46vY5Bo9knHXQNlYLeKhAwgGENrdxKjagJWKfgyoA9Sfo9duvVb6smZ
 irL+h5ZOjuNDheUHxG5cWvRHsLeEw5XuRGauJP2GmecrWsJpDgrVUzath3j/MvJxL+pGpU
 93h+eanSNVe2ejD5vM/LBn1OxWCNh44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777383158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=z5wQ2/r1uRm2fKOp9YwEbUVk059hmYE3cd1uOckcQuU=;
 b=eZcqXTY0OKF3Of3ZrgbJaGASvZAbZXp48zPY9ovAyt9mJ86pyDPyzcqoiG3jg6IyEKRDEs
 JGzNQ+9w5vYLduCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A852593B0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TxjOGfa28GlLbwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:32:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Apr 2026 15:32:11 +0200
Message-ID: <20260428133233.28050-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Queue-Id: 7C2F15BCFE
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] aio_cancel: Fix incorrect strerror() usage
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

Each call of strerror() invalidates the previous return value. Split
print calls to avoid calling strerror() twice in the argument list.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../conformance/interfaces/aio_cancel/5-1.c                  | 5 +++--
 .../conformance/interfaces/aio_cancel/7-1.c                  | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index dd5b0bbfb..04306417e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -131,8 +131,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		}
 
 		if (ret != exp_ret) {
-			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
-				i, strerror(ret), strerror(exp_ret));
+			printf(TNAME " Bad task #%d result: %s",
+				i, strerror(ret));
+			printf(" (expected %s)\n", strerror(exp_ret));
 			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
index 36ce8bb12..0fdc1bef8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -118,8 +118,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		}
 
 		if (ret != exp_ret) {
-			printf(TNAME " Bad task #%d result: %s (expected %s)\n",
-				i, strerror(ret), strerror(exp_ret));
+			printf(TNAME " Bad task #%d result: %s",
+				i, strerror(ret));
+			printf(" (expected %s)\n", strerror(exp_ret));
 			cleanup_aio(fds, aiocb, BUF_NB);
 			return PTS_FAIL;
 		}
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
