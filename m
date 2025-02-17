Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F69C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:10:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98A563C9C8E
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:10:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89D0E3C9C06
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:09:21 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F8191C70550
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:08:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B77981F396;
 Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
 b=qaoVWmK6zCW742FpD3fnQrSSZZH19Mni6CVAUBZ5txWrlgq0/Sv2Cd53EaiotWqeq/A9U3
 pN7ASEWAneUqG0AiOUuXbgE08s8lIqYfznhAN2lY+rleX/Zo/hF0rOsyow9uAvCnrpBYv+
 k0pJj9KKz47dx0/t1PYckzi5AioJmdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739797730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
 b=5v58MuGDTP4x24Hdp5PPcN2bfOs8Jm0tID2x+e0GvMXFJVWoz6Jff8oGz0ymqRIAPmH/Nl
 1CMo9IfXF6KfPyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
 b=qaoVWmK6zCW742FpD3fnQrSSZZH19Mni6CVAUBZ5txWrlgq0/Sv2Cd53EaiotWqeq/A9U3
 pN7ASEWAneUqG0AiOUuXbgE08s8lIqYfznhAN2lY+rleX/Zo/hF0rOsyow9uAvCnrpBYv+
 k0pJj9KKz47dx0/t1PYckzi5AioJmdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739797730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
 b=5v58MuGDTP4x24Hdp5PPcN2bfOs8Jm0tID2x+e0GvMXFJVWoz6Jff8oGz0ymqRIAPmH/Nl
 1CMo9IfXF6KfPyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80AC413AC1;
 Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHU3HuI0s2fvBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 13:08:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 14:08:39 +0100
Message-ID: <20250217130839.2392666-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217130839.2392666-1-pvorel@suse.cz>
References: <20250217130839.2392666-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading
 policy
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

Adding TST_SETUP_EARLY to run test specific setup before loading policy.
That allows to avoid loading IMA policy (which usually request reboot)
if the test would be skipped anyway.

Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 97c5d64ec5..577f7c2aca 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -13,9 +13,10 @@
 
 TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
-TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
+TST_SETUP_EARLY="setup"
+
 REQUIRED_POLICY_CONTENT='selinux.policy'
 
 setup()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f1c267c4b..2a9f64978e 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -265,6 +265,8 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
+
 	if ! verify_ima_policy; then
 		load_ima_policy
 	fi
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
