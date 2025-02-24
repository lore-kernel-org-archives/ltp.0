Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C5AC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CBED3C98CF
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:59:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 921DC3C090A
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:59:34 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D13D62E92B
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:59:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7088421172;
 Mon, 24 Feb 2025 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740394772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4IDP5Qa4fHg0jOSo/lcZ+hHU/2+DC++btki4r8VUc0Y=;
 b=Ooby2wpDwvxqHtPbN+bKfVbPxW8hDJGrTlZkvGfN57SiK/DdSQTqmWFpDi980SeHLI+yE2
 UwTk+qYrZXlzyfqqx6V2fBYYHPlLpd3dct+tcWWzH5YO2Mxx6C6JA779TEjDxXCH4+ScBg
 UwtyMn2y8VlBAOY930pAvlbkSRvProM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740394772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4IDP5Qa4fHg0jOSo/lcZ+hHU/2+DC++btki4r8VUc0Y=;
 b=nka6XfJHPTslCgCkdb2lKNthUBi/WM8qjlaL+udnJwV9mn9jvnDLo29vOnKSYobXNi+KxC
 0wZiHZ46Rl71AEBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ooby2wpD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nka6XfJH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740394772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4IDP5Qa4fHg0jOSo/lcZ+hHU/2+DC++btki4r8VUc0Y=;
 b=Ooby2wpDwvxqHtPbN+bKfVbPxW8hDJGrTlZkvGfN57SiK/DdSQTqmWFpDi980SeHLI+yE2
 UwTk+qYrZXlzyfqqx6V2fBYYHPlLpd3dct+tcWWzH5YO2Mxx6C6JA779TEjDxXCH4+ScBg
 UwtyMn2y8VlBAOY930pAvlbkSRvProM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740394772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4IDP5Qa4fHg0jOSo/lcZ+hHU/2+DC++btki4r8VUc0Y=;
 b=nka6XfJHPTslCgCkdb2lKNthUBi/WM8qjlaL+udnJwV9mn9jvnDLo29vOnKSYobXNi+KxC
 0wZiHZ46Rl71AEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D40613332;
 Mon, 24 Feb 2025 10:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rF2dERRRvGf8AQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Feb 2025 10:59:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Feb 2025 11:59:25 +0100
Message-ID: <20250224105925.2865777-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7088421172
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_selinux.sh: Require ima_policy=critical_data
 kernel cmdline
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test requires not only func=CRITICAL_DATA IMA policy content but also
ima_policy=critical_data kernel cmdline. Without cmdline no measures are
done.

https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-policy-critical-data
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdd1ffe8a812

Fixes: 4944a63ed9 ("IMA: Add test for SELinux measurement")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
FYI this is supposed to be applied on the top of "ima_setup.sh: Postpone
loading policy after test setup" patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=445166&state=*
https://lore.kernel.org/ltp/20250219181926.2620960-1-pvorel@suse.cz/t/#u

 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 97c5d64ec5..1a0de21efd 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -5,7 +5,8 @@
 # Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
 #
 # Verify measurement of SELinux policy hash and state.
-# Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
+# Test requires ima_policy=critical_data kernel command line and example IMA
+# policy loadable with LTP_IMA_LOAD_POLICY=1.
 #
 # Relevant kernel commits:
 # * fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook")
@@ -22,6 +23,8 @@ setup()
 {
 	SELINUX_DIR=$(tst_get_selinux_dir)
 	[ "$SELINUX_DIR" ] || tst_brk TCONF "SELinux is not enabled"
+
+	require_ima_policy_cmdline "critical_data"
 }
 
 # Format of the measured SELinux state data.
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
