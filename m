Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDF8D3B7ED
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:54:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 533293D0258
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 14:54:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31CB53CFEDF
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:54:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A70EF200ACB
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:54:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E44985BDAB
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765288472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=879PqxwTUZ48rtsDVqa11azgm0eDr5GEsRBHOt5dfso=;
 b=c6a2PhBo8Ey0GecShDX4jzSlSgFfAwNR4wS+JtwhXsjHK/ZCOP9nCdgj8nESm0mjOhHO5V
 +DGCtJM5Z39vz93Ee3Dxjz4w50NESAmcQeker5BDCn73LbJZ1T+Qale4yliYa+PIZwNzoy
 VX3xWRsbTLn+xRpaDfnrAcGkbyDkm+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765288472;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=879PqxwTUZ48rtsDVqa11azgm0eDr5GEsRBHOt5dfso=;
 b=6HwqSz2ypPoQBHNXHNiJnJv4DDcfKmrZ3EAJ3iFMpCVEtqPCcgLjcGR9dcBRTAbvNgajwO
 +GjVpqVBNrETZtAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qx/Bcdc5";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mu8V83ct
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765288470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=879PqxwTUZ48rtsDVqa11azgm0eDr5GEsRBHOt5dfso=;
 b=qx/Bcdc51e9DEH7Pz/Q3QKeY6dk3G2mufKLcbjSaRQmzy71MSmFOW1x1sYAoGrdB/B4xas
 cb4j48zNrOP1OV1ti59tQuxVwI36MWQNN6EgjubLZAEn8p5a3DHUNtaB+Kkm40DDqP2bKu
 Uxa0mqgxMF54zPUkHbhXj1bESm8P4jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765288470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=879PqxwTUZ48rtsDVqa11azgm0eDr5GEsRBHOt5dfso=;
 b=Mu8V83ctP2wTl8LV/WqkZLbblgG5PxOhvMT9yw7e1c1SqLYG/NzI0g8+gnrdVqkmyMkrqu
 HANtswrmro2nV+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9F373EA63
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jmD+NBYqOGkXMwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 13:54:30 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 14:54:25 +0100
Message-ID: <20251209135427.41648-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: E44985BDAB
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_xattr: Remove unused variable
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

The dir variable in mount_cgroup() is uninitialized but it gets
printed into error messages instead of the correct opt->dir. Remove
the variable and fix the error message.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index 0d016b583..2c080933e 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -289,7 +289,6 @@ int mount_cgroup(void)
 
 	int i, any_mounted = 0;
 	for (i = 0; i < cgrp_opt_num; ++i) {
-		char dir[MAX_DIR_NAME];
 		struct cgrp_option *opt = &cgrp_opt[i];
 		tst_resm(TINFO, "mount options %d: %s (hier = %d)",
 			i, opt->str, opt->hier);
@@ -297,7 +296,7 @@ int mount_cgroup(void)
 		SAFE_MKDIR(cleanup, opt->dir, 0755);
 
 		if (mount(opt->dir, opt->dir, "cgroup", 0, opt->str) == -1) {
-			tst_resm(TINFO, "Can't mount: %s", dir);
+			tst_resm(TINFO, "Can't mount: %s", opt->dir);
 			continue;
 		}
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
