Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE0C3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 09:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 649A83D21D4
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 11:47:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE9B83D2190
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 11:47:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=schwab@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1847E200926
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 11:47:22 +0200 (CEST)
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id A753A22085
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723715241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=s5+eTgLmMttvD7mWgBZYiECledzjIBMk0gZTthdftMw=;
 b=Ywz0fnSyCNVhEFZFM/5jsbI934hiJRbCfJFADIDpDOqbsgAFxrFU8RmlgZPhyIeXwDFiB8
 5Ge5J7hPvVSY+PqZZTJGRDaBu5DRSZE7OQiz//W6zQy6tpnQRC0mHre/m2M/yZiE/NCJzi
 BZlwkZf20EovX6+Xf3KUC1i8KX05Sx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723715241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=s5+eTgLmMttvD7mWgBZYiECledzjIBMk0gZTthdftMw=;
 b=foeZwjEd9lcUnwITtY04v3Zb4c+gXi9lk3ngYfq38yqYTu1NGsP7KQXUAiSxkOmkwjkwuh
 pE484q4k5+3dZSDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723715241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=s5+eTgLmMttvD7mWgBZYiECledzjIBMk0gZTthdftMw=;
 b=Ywz0fnSyCNVhEFZFM/5jsbI934hiJRbCfJFADIDpDOqbsgAFxrFU8RmlgZPhyIeXwDFiB8
 5Ge5J7hPvVSY+PqZZTJGRDaBu5DRSZE7OQiz//W6zQy6tpnQRC0mHre/m2M/yZiE/NCJzi
 BZlwkZf20EovX6+Xf3KUC1i8KX05Sx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723715241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=s5+eTgLmMttvD7mWgBZYiECledzjIBMk0gZTthdftMw=;
 b=foeZwjEd9lcUnwITtY04v3Zb4c+gXi9lk3ngYfq38yqYTu1NGsP7KQXUAiSxkOmkwjkwuh
 pE484q4k5+3dZSDA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 98C4A4A04EA; Thu, 15 Aug 2024 11:47:21 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: ltp@lists.linux.it
X-Yow: Am I in GRADUATE SCHOOL yet?
Date: Thu, 15 Aug 2024 11:47:21 +0200
Message-ID: <mvm34n6aziu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.18 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.18)[-0.904]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/perf_event_open01: Allow EINVAL
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

A request for an unsupported perf event can also result in EINVAL.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 30c0d7594..86a134b51 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -148,7 +148,7 @@ static void verify(struct test_case_t *tc)
 	TEST(perf_event_open(&pe, 0, -1, -1, 0));
 	if (TEST_RETURN == -1) {
 		if (TEST_ERRNO == ENOENT || TEST_ERRNO == EOPNOTSUPP ||
-		    TEST_ERRNO == ENODEV) {
+		    TEST_ERRNO == ENODEV || TEST_ERRNO == EINVAL) {
 			tst_resm(TCONF | TTERRNO,
 			         "perf_event_open for %s not supported",
 			         tc->config_name);
-- 
2.46.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
