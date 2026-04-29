Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B76DFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCDCF3E1904
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:53:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD19A3E2538
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:53:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6050220023C
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:53:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8EF85BD3F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777474399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2z4+DhhRHcm8PRMD4HEL+L+6wQf6kO5iIK37iXBOJMg=;
 b=Jeub3bXZBWPV0mbUUfG4BuSkW1u+gDFHRp8rp+s9GwIqf004aA1NjVEBLpPvy2v3wTT75s
 q8Qo7wK8upMzwPtGtPV08UzpMCvJz6BBo82qeneElNpzx/TTdbHztbyknEBR7m4vBb3ozC
 mhzDUeNWpeXh3ozx7PkaQp64BNZ+UT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777474399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2z4+DhhRHcm8PRMD4HEL+L+6wQf6kO5iIK37iXBOJMg=;
 b=EVZtfbOFatj15X+Xqs/k3xPTctS+QGzMgbCaIMDm4vKznkq2msB6JE2Cm3ybb9RVBPipyZ
 QUQT03nX2ywBMwBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777474395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2z4+DhhRHcm8PRMD4HEL+L+6wQf6kO5iIK37iXBOJMg=;
 b=BKdSYjZ/tzTBLGqiOjcEEDBC/s/uaU5oY3LMjjy/8qYjU1UsWO0XdbqpWK2RM7xuTGidaA
 KFmYtHqgmkMR/FgrzjHqer2Q1f+4XhhbkYsEof+dBgollqqI4B17JsUfj8Svk3Btwkh3+4
 WDZ+LnoKUm9aZjg8OqpjPnS/T17xbZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777474395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2z4+DhhRHcm8PRMD4HEL+L+6wQf6kO5iIK37iXBOJMg=;
 b=TPRFglqzq2+YS7X+TH/E8c2s3WsP1qmanv2pJTa8rL+kWalyus/fpISzYfsNoKPOCnM9he
 9lIyBvE/L/CQmiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0E89593B0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0RjqKlsb8mlPfwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:53:15 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 16:53:11 +0200
Message-ID: <20260429145314.79256-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] aio_cancel: Fix incorrect strerror() usage
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

Also remove strerror() calls on aio_cancel() return value because
the function does not return errno constants directly.

Fixes: 690b37453 ("aio_cancel_5-1: Rewrite test")
Fixes: 220f579cd ("aio_cancel_7-1: Rewrite test")
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Removed strerror() calls on aio_cancel() return value
- Added Fixes: tags

 .../conformance/interfaces/aio_cancel/5-1.c              | 9 +++++----
 .../conformance/interfaces/aio_cancel/7-1.c              | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
index dd5b0bbfb..0220acd7c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/5-1.c
@@ -95,8 +95,8 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 
 	if (ret != AIO_NOTCANCELED) {
-		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
-			strerror(ret));
+		printf(TNAME " Unexpected aio_cancel() return value: %d\n",
+			ret);
 		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
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
index 36ce8bb12..4bb9d8d09 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/7-1.c
@@ -89,8 +89,8 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	}
 
 	if (gret != AIO_NOTCANCELED) {
-		printf(TNAME " Unexpected aio_cancel() return value: %s\n",
-			strerror(gret));
+		printf(TNAME " Unexpected aio_cancel() return value: %d\n",
+			gret);
 		cleanup_aio(fds, aiocb, BUF_NB);
 		return PTS_FAIL;
 	}
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
