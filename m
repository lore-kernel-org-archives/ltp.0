Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31BCD132DF
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 15:34:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 955223D0D4B
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 16:34:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B95C73D0D29
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 16:34:07 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D91BB636637
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 16:34:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B48121F7F5
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730734444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QJIJlz+kHp+7jA8J78osNcA2XojS3I+maOf9/RRwNqo=;
 b=Q4Oc7wQbqef+q5QCi/52sE0lxJBACfNqMSy067nT9zQToVRxj2d3WuApVoCmtzbvLsgrg3
 +NBlvyCmvaOi/zAH5jSoLxeOZia8SehYzyHT4higyxvMUVKGjzOi36m3F76fXLi9n35jNL
 ddi2W1XYMeTsSNgB4y0QtTfCsbACvUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730734444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QJIJlz+kHp+7jA8J78osNcA2XojS3I+maOf9/RRwNqo=;
 b=K2KUBDgqnQmWzZ2b+3xIujoA2p/Qv/RH1T2kWocwjUGLuZcZWJu/sCLdP2WbeNFJjOZ4DK
 OZ0D5uwP/hBsvnCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730734444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QJIJlz+kHp+7jA8J78osNcA2XojS3I+maOf9/RRwNqo=;
 b=Q4Oc7wQbqef+q5QCi/52sE0lxJBACfNqMSy067nT9zQToVRxj2d3WuApVoCmtzbvLsgrg3
 +NBlvyCmvaOi/zAH5jSoLxeOZia8SehYzyHT4higyxvMUVKGjzOi36m3F76fXLi9n35jNL
 ddi2W1XYMeTsSNgB4y0QtTfCsbACvUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730734444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QJIJlz+kHp+7jA8J78osNcA2XojS3I+maOf9/RRwNqo=;
 b=K2KUBDgqnQmWzZ2b+3xIujoA2p/Qv/RH1T2kWocwjUGLuZcZWJu/sCLdP2WbeNFJjOZ4DK
 OZ0D5uwP/hBsvnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4EA13503
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 15:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E99NKmzpKGfVFgAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 15:34:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Nov 2024 16:33:59 +0100
Message-ID: <20241104153404.21273-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] crypto/af_alg0[13]: update tests for additional
 possible errno case
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

kernel behaviour wrt checking invalid algorithms has changed [1] [2]
updating the tests to address the additional errno case.
Related discussion on the mailing list [3]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7a4142b35ce489fc8908d75596c51549711ade0
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=795f85fca229a88543a0a706039f901106bf11c1
[3] https://lore.kernel.org/lkml/20240924222839.GC1585@sol.localdomain/

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 lib/tst_af_alg.c                   | 1 +
 testcases/kernel/crypto/af_alg01.c | 5 ++++-
 testcases/kernel/crypto/af_alg03.c | 5 ++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index f5437c5c5..a14f9865c 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -103,6 +103,7 @@ bool tst_have_alg(const char *algtype, const char *algname)
 	case 0:
 		return true;
 	case ENOENT:
+	case EINVAL:
 		tst_res(TCONF, "kernel doesn't have %s algorithm '%s'",
 			algtype, algname);
 		return false;
diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
index 7cefe5946..2100b3698 100644
--- a/testcases/kernel/crypto/af_alg01.c
+++ b/testcases/kernel/crypto/af_alg01.c
@@ -21,6 +21,7 @@ static void test_with_hash_alg(const char *hash_algname)
 {
 	char hmac_algname[64];
 	char key[4096] = { 0 };
+	int ret;
 
 	if (!tst_have_alg("hash", hash_algname))
 		return;
@@ -30,7 +31,9 @@ static void test_with_hash_alg(const char *hash_algname)
 		return;
 
 	sprintf(hmac_algname, "hmac(hmac(%s))", hash_algname);
-	if (tst_try_alg("hash", hmac_algname) != ENOENT) {
+
+	ret = tst_try_alg("hash", hmac_algname);
+	if (ret != ENOENT && ret != EINVAL) {
 		int algfd;
 
 		tst_res(TFAIL, "instantiated nested hmac algorithm ('%s')!",
diff --git a/testcases/kernel/crypto/af_alg03.c b/testcases/kernel/crypto/af_alg03.c
index bb8d480e2..d7d385883 100644
--- a/testcases/kernel/crypto/af_alg03.c
+++ b/testcases/kernel/crypto/af_alg03.c
@@ -15,10 +15,13 @@
 
 static void run(void)
 {
+	int ret;
+
 	tst_require_alg("aead", "rfc7539(chacha20,poly1305)");
 	tst_require_alg("hash", "sha256");
 
-	if (tst_try_alg("aead", "rfc7539(chacha20,sha256)") != ENOENT) {
+	ret = tst_try_alg("aead", "rfc7539(chacha20,sha256)");
+	if ( ret != ENOENT && ret != EINVAL) {
 		tst_res(TFAIL,
 			"instantiated rfc7539 template with wrong digest size");
 	} else {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
