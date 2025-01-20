Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A67C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 12:06:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A91223C1A09
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:06:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89D763C05DA
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:06:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A2C9C1A0BEC4
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:06:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9029210F7
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737374774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TWlhV38U4ftcNc3WCIsVRYYP9eKNid3uv1YMA0NNWsg=;
 b=tp6/lIAUrXaZsH1p+rT+Gvrqt4jy6/ZePkCqCCOykRhBa9LuybEjVGVHr3cJL6gKQNZB1Y
 g9URe9s/ppywpV62jZd3Pv+FfusaplaqcnNptHhmfOLLeJBjkaSUqKO/6v9jhQo4r/SESk
 2TQDr1g/lb6Vu/fpF7sci4b4RlIIGlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737374774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TWlhV38U4ftcNc3WCIsVRYYP9eKNid3uv1YMA0NNWsg=;
 b=NGCsj57nhKBBz69qE3F9MOqrFY57/Jzn52Ckai5MYRkEuex1rSaDs1mzcW6Fdl3Evoodgv
 dig8QyAfAT1zgNAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kln4OW/l";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VICcWWlA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737374773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TWlhV38U4ftcNc3WCIsVRYYP9eKNid3uv1YMA0NNWsg=;
 b=kln4OW/lP+ljWwIVn+a8UnT8slTKbHyTcQrGWfmJ81U/uCSroclzas69dKPKjkzNFDfrC4
 Uy/208m46KCY2O27ToOp6re9692XBabWvOTLaKJ9cvJw9GlO4VtdbpY0tj4eyH+iO2p3O9
 OQR6V4PNVYZIhFU8bJKECJkKugOcBcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737374773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TWlhV38U4ftcNc3WCIsVRYYP9eKNid3uv1YMA0NNWsg=;
 b=VICcWWlA3S5uzT6XgiIMZEeI7zrVeQTLo4ymtfNWiN5jzxQz+q0aRwlS375Q4VUTpeRhio
 4ozRJrIH1GvpH0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4A9139CB
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 12:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BNmENDU8jmftSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 12:06:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jan 2025 13:06:06 +0100
Message-ID: <20250120120606.20145-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: E9029210F7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_has_slow_kconfig() cache the result
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

The result from the tst_has_slow_kconfig() is not going to change so we
can cache the result as there are several cases where the function may
end up being called. For instance any test that calls SAFE_CLONE() will
call the function repeatedly. This change makes the tests slightly
faster and also avoids repeated messages in the test output.

For example before:

tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:94: TPASS: find_cinit_pids(pids) returned 5
pidns05.c:112: TPASS: No children left after sending SIGKILL to the first child

And after:

tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.3/build/.config'
tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TPASS: cpid == 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:94: TPASS: find_cinit_pids(pids) returned 5
pidns05.c:112: TPASS: No children left after sending SIGKILL to the first child

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index e83de3dcd..66402e370 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -652,13 +652,23 @@ static struct tst_kconfig_var slow_kconfigs[] = {
 	TST_KCONFIG_INIT("CONFIG_DEBUG_OBJECTS")
 };
 
+static bool slow_kconfig_cached;
+static bool slow_kconfig_result;
+
 int tst_has_slow_kconfig(void)
 {
 	unsigned int i;
 	char path_buf[1024];
 
-	if (!kconfig_path(path_buf, sizeof(path_buf)))
+	if (slow_kconfig_cached)
+		return slow_kconfig_result;
+
+	slow_kconfig_cached = 1;
+
+	if (!kconfig_path(path_buf, sizeof(path_buf))) {
+		slow_kconfig_result = 0;
 		return 0;
+	}
 
 	tst_kconfig_read(slow_kconfigs, ARRAY_SIZE(slow_kconfigs));
 
@@ -667,9 +677,11 @@ int tst_has_slow_kconfig(void)
 			tst_res(TINFO,
 				"%s kernel option detected which might slow the execution",
 				slow_kconfigs[i].id);
+			slow_kconfig_result = 1;
 			return 1;
 		}
 	}
 
+	slow_kconfig_result = 0;
 	return 0;
 }
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
