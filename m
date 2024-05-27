Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E0C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:38:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B6F43D038D
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:38:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 305A63D0340
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:59 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 492481400F97
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 420FF1FB65;
 Mon, 27 May 2024 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik5FZ9sJ4GOGCyKDwlMqDI1Mp94G7iZFsxoCRyFYEx0=;
 b=SejhSTTvNarp2Oz+wJP/jnkechU3pSDkXqZDyrEAm4R0sSrcDl7v+9bIqNfHg3wrA02Z6V
 ebiKI40MA+Wd7fk0O6AW+uITGwUe/YEZ9e0sqrbcovggGxT5CNe1R7e9ElflrKxYJD3kjQ
 Jd+topp2UbpNyF9/czLmWGkFWf/ilQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik5FZ9sJ4GOGCyKDwlMqDI1Mp94G7iZFsxoCRyFYEx0=;
 b=jf0F4/QPNK2XWm+TfzLPPPxhfNVLpwR4DNAnXc4tGY6ATyV58b9s5HWLEEJLgGRVHp9QPK
 lv07E+tPwc97r/BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SejhSTTv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="jf0F4/QP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik5FZ9sJ4GOGCyKDwlMqDI1Mp94G7iZFsxoCRyFYEx0=;
 b=SejhSTTvNarp2Oz+wJP/jnkechU3pSDkXqZDyrEAm4R0sSrcDl7v+9bIqNfHg3wrA02Z6V
 ebiKI40MA+Wd7fk0O6AW+uITGwUe/YEZ9e0sqrbcovggGxT5CNe1R7e9ElflrKxYJD3kjQ
 Jd+topp2UbpNyF9/czLmWGkFWf/ilQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik5FZ9sJ4GOGCyKDwlMqDI1Mp94G7iZFsxoCRyFYEx0=;
 b=jf0F4/QPNK2XWm+TfzLPPPxhfNVLpwR4DNAnXc4tGY6ATyV58b9s5HWLEEJLgGRVHp9QPK
 lv07E+tPwc97r/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E2B13A56;
 Mon, 27 May 2024 06:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CP/CCFYpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:46 +0200
Message-ID: <20240527063346.289771-16-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 420FF1FB65
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/15] cgroup_xattr: Remove kernel >= 3.15 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c     | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index a870118f5..0d016b583 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -151,11 +151,8 @@ void setup(int argc, char *argv[])
 		tst_brkm(TCONF, NULL, "Kernel doesn't support cgroups");
 
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
-		if (!strcmp(tkeys[i].name, "security.")) {
-			tkeys[i].good = tst_kvercmp(3, 15, 0) < 0;
-		} else if (!strcmp(tkeys[i].name, "trusted.")) {
+		if (!strcmp(tkeys[i].name, "trusted."))
 			tkeys[i].good = tst_kvercmp(4, 5, 0) < 0;
-		}
 	}
 
 	int value_size = DEFAULT_VALUE_SIZE;
@@ -269,12 +266,7 @@ int mount_cgroup(void)
 		 * additional "xattr" option. In that case, mount will succeed,
 		 * but xattr won't be supported in the new mount anyway.
 		 * Should be removed as soon as a fix committed to upstream.
-		 *
-		 * But not applicable for kernels >= 3.15 where xattr supported
-		 * natively.
 		 */
-		if (hier != 0 && tst_kvercmp(3, 15, 0) < 0)
-			continue;
 
 		int i, found = 0;
 		for (i = 0; i < cgrp_opt_num; ++i) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
