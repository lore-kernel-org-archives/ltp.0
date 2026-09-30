Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63FBCA5FBE
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:52:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA9953E55D7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 11:52:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ECEA3E1456
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:51:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6570614004EE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:51:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8138421C33;
 Wed, 30 Sep 2026 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790761901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY4G+Y1oXrgHrbaa27qM7NOGE6w1Y/icCKImppALfxQ=;
 b=r73GlOVFtjKvIfPUadLzVo6eTOqKPGAUTU6e9jppCvLCewAw7YmAZtiiKDHvtkW1Hmh9mM
 K1OdDtOhD+KL3O+SXIQw/m391XwuqHetruDKVm4Uq1yyWFup+iTiXceJq+OQIILimIwGfE
 JZNsSt1jIBU7eODJtLdz7QhGt/fCeJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790761901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY4G+Y1oXrgHrbaa27qM7NOGE6w1Y/icCKImppALfxQ=;
 b=roxGeiFW9Y4v/1Eu7pE20JROnjax5ua6yv5xanwI5mrHI6nX6OMJNKYO9+iDETtYQPubYI
 IJ4mKoWRTn47YYAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QWGWIHBi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xCyt5gHI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790761897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY4G+Y1oXrgHrbaa27qM7NOGE6w1Y/icCKImppALfxQ=;
 b=QWGWIHBiI3c8OcaaOiK0T5XhfFP6coB3Y17nJ9wTXs8+XR4y4diPyM2Pm848BK59z3ahDK
 8uxfnnQyvpZU+w2Xf+wsJiqgH8KxsnXpraiOMAwV+fESU0a7k78VDQEHIilPbeB2FiZmMe
 0G9Xo6/P01MJD/EJBjNDmVzMraF5QR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790761897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY4G+Y1oXrgHrbaa27qM7NOGE6w1Y/icCKImppALfxQ=;
 b=xCyt5gHI5C0c38SLRFGpWv2uVr9aq7leiKPw69Y2WtvqCh/d0+jTnF9xbCofyGGfQfBXXx
 t6u5OlKlSWAarUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2421C136AD;
 Wed, 30 Sep 2026 09:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VvEkO6jbvGp0UgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 09:51:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Sep 2026 11:51:16 +0200
Message-ID: <20260930095116.2631336-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8138421C33
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Print version and kernel early enough
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

Print LTP version and tested kernel before calling do_setup()
which can quit testing due various reasons, e.g.:

    # ./fw_load02
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
    tst_security.c:115: TINFO: SecureBoot sysfs file not available
    tst_security.c:94: TINFO: Unable to determine system lockdown state
    tst_security.c:115: TINFO: SecureBoot sysfs file not available
    tst_tmpdir.c:309: TINFO: Using /tmp/LTP_fw_ZRzLML as tmpdir (btrfs filesystem)
    tst_sys_conf.c:103: TBROK: Failed to read anything from
	'/sys/module/firmware_class/parameters/path': SUCCESS (0)

It's always good to know this info.

Fixes: eb0a5367fa ("lib: Print tested kernel and arch")
Fixes: 546beb5340 ("lib/C-API: Print LTP version at test start")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
It should be merged *after* the release.

 lib/tst_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e27a24c246..10ff733971 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -2058,17 +2058,17 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_test = self;
 
+	tst_res(TINFO, "LTP version: "LTP_VERSION);
+
+	uname(&uval);
+	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
+
 	do_setup(argc, argv);
 	tst_enable_oom_protection(context->lib_pid);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
-	tst_res(TINFO, "LTP version: "LTP_VERSION);
-
-	uname(&uval);
-	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
-
 	if (tst_test->min_runtime && !tst_test->runtime)
 		tst_test->runtime = tst_test->min_runtime;
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
