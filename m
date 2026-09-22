Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0FC982F1
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 10:59:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E3C53E6C90
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 12:59:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCA73E1CC9
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:59:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C70160012A
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:59:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B73A321BDB;
 Tue, 22 Sep 2026 10:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790074742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k7DTR1krR4GidqLwH9kPPNmFLa95AH1pAnTKB+RPBUo=;
 b=OPrS5gOZ823QpuK0+iP8ha4A6AfeJlgCAUvOaxgZ5EW/M+vjGYlfqhWxZoBHw29hEzBDcO
 NkYD5QO3pumQqkrY1OqUcvhrokgVTZxLxxqHIyUU9MCru/Nowa3Q8Gjooq0mHEgMDRbNcn
 jE1XNegP8m4EEPYW/mclDPGVj6ESt/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790074742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k7DTR1krR4GidqLwH9kPPNmFLa95AH1pAnTKB+RPBUo=;
 b=fjD/EZGBLZk7fs9nDZkXr7NVazhkT46dIbcgS4N7y93uaUxNRcGfJ0I4klN1NvsbM+L21+
 fmEH3IEPqlSh9wCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Jd9Gj/Uh";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=He8tJRqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790074738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k7DTR1krR4GidqLwH9kPPNmFLa95AH1pAnTKB+RPBUo=;
 b=Jd9Gj/UhdqsD48oiEBKQotV4khOt46qZtcWEa483+KDvD2Czv1BWESLIfQ0LbbRrHDdErW
 20XjhgPxbyL49MwXG54Jn4PdUgS+rCuMzNJ00XWWwo6PpTBx508HA/EUGgDfRvh2mzta+c
 Ao4XCLYZUenbEy65/QhOTcNCGaQFUNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790074738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=k7DTR1krR4GidqLwH9kPPNmFLa95AH1pAnTKB+RPBUo=;
 b=He8tJRqJs6ridhAsKLsFhLooZxGrGVrZejW28XvwjgP3ieg/CS5pzcULsnokGLMQSG5+od
 xTeObFnq+8ZQGVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D4B132D3;
 Tue, 22 Sep 2026 10:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2nZkOnFfsmrhSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 10:58:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 12:58:40 +0200
Message-ID: <20260922105840.2193537-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: B73A321BDB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] keyctl30: Check module is presented before loading
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

This fixes test on the system without module:

    modprobe: FATAL: Module pkcs8_key_parser not found in directory /usr/lib/modules/6.12.0-160100.5-azure
    tst_cmd.c:112: TBROK: 'modprobe' exited with a non-zero code 1 at tst_cmd.c:112

With the fix it TCONF as expected:

    tst_module.c:72: TCONF: Failed to find module 'pkcs8_key_parser'

Fixes: 1bb448ed9e ("keyctl30: Test KEYCTL_PKEY_QUERY on private key")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
FYI Cyril suggested to add into struct config_module_map:

 	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
 	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
 	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
+	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},

Although it does not harm this is IMHO just wrong function being used.

 testcases/kernel/syscalls/keyctl/keyctl30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl30.c b/testcases/kernel/syscalls/keyctl/keyctl30.c
index ef51bba338..5f98d2a7d4 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl30.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl30.c
@@ -29,7 +29,7 @@ static void setup(void)
 {
 	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
 
-	tst_modprobe("pkcs8_key_parser", NULL);
+	tst_module_load("pkcs8_key_parser", NULL);
 
 	priv_key = add_asymmetric_key_or_tconf("priv", rsa2048_pkcs8,
 					       sizeof(rsa2048_pkcs8),
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
