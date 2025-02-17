Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637DDC021A4
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADD143C9BA2
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 09:49:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06D8A3C9BD0
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:48:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AFAFF140E951
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:48:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD2051F443;
 Mon, 17 Feb 2025 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739782115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BY/gDJUS20cCeEgWYqcTeE1BJCjshifLwyfm8fDAZjI=;
 b=hngXlo3rHPsxgJPwKiGpXzDOEtvqw0iZ2Mx+zBg637vuMaG74yw1HMK8K+lm3KrHxBrLxu
 qw5ZPcB3OFspPHdFOZbHv8Zr+BL2ejXl7Wg5oZ3uSpu6K8k5lPTz2zm1Wn6yXMFjICDvyt
 SkMgzULiOwjbZrck5V8L6m4XPmVxTqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739782115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BY/gDJUS20cCeEgWYqcTeE1BJCjshifLwyfm8fDAZjI=;
 b=9xtzrDsbAmA0XDZrNOTNwRlXdRBS7IiWWAEh/wSh6h9QfDB7u2ruue/Ood60XHYZn9JlsU
 XaUJ0b0GPwU2j+DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hngXlo3r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9xtzrDsb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739782115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BY/gDJUS20cCeEgWYqcTeE1BJCjshifLwyfm8fDAZjI=;
 b=hngXlo3rHPsxgJPwKiGpXzDOEtvqw0iZ2Mx+zBg637vuMaG74yw1HMK8K+lm3KrHxBrLxu
 qw5ZPcB3OFspPHdFOZbHv8Zr+BL2ejXl7Wg5oZ3uSpu6K8k5lPTz2zm1Wn6yXMFjICDvyt
 SkMgzULiOwjbZrck5V8L6m4XPmVxTqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739782115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BY/gDJUS20cCeEgWYqcTeE1BJCjshifLwyfm8fDAZjI=;
 b=9xtzrDsbAmA0XDZrNOTNwRlXdRBS7IiWWAEh/wSh6h9QfDB7u2ruue/Ood60XHYZn9JlsU
 XaUJ0b0GPwU2j+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E191379D;
 Mon, 17 Feb 2025 08:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eafRJuP3smcCLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 08:48:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 09:48:33 +0100
Message-ID: <20250217084833.2365977-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: BD2051F443
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Remove [Description] title from shell API
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

for i in $(git grep -l '# \[Description\]'); do sed -Ezr 's:(#\n)*# \[Description\]\n(#\n)*::g' -i $i; done

Fixes: a3e27df34d ("doc: Remove [Description] title")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Preparation for Cyril's shell test parser
https://patchwork.ozlabs.org/project/ltp/patch/20250212131618.6810-2-chrubis@suse.cz/

Kind regards,
Petr

 testcases/kernel/mem/vma/vma05.sh                 | 3 ---
 testcases/lib/tests/shell_loader.sh               | 3 ---
 testcases/lib/tests/shell_loader_c_child.sh       | 3 ---
 testcases/lib/tests/shell_loader_invalid_block.sh | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index 17e262f167..f4c76b7034 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -5,9 +5,6 @@
 #
 # ---
 # doc
-#
-# [Description]
-#
 # Regression test if the vsyscall and vdso VMA regions are reported correctly.
 #
 # While [vsyscall] is mostly deprecated with newer systems, there is
diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
index f5d74ee639..a7c5848ff5 100755
--- a/testcases/lib/tests/shell_loader.sh
+++ b/testcases/lib/tests/shell_loader.sh
@@ -4,9 +4,6 @@
 #
 # ---
 # doc
-#
-# [Description]
-#
 # This is a simple shell test loader example.
 # ---
 #
diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
index 61f138ad57..34629e6d26 100755
--- a/testcases/lib/tests/shell_loader_c_child.sh
+++ b/testcases/lib/tests/shell_loader_c_child.sh
@@ -4,9 +4,6 @@
 #
 # ---
 # doc
-#
-# [Description]
-#
 # This is an example how to run C child from shell.
 # ---
 #
diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
index a98f1c1522..01811c971d 100755
--- a/testcases/lib/tests/shell_loader_invalid_block.sh
+++ b/testcases/lib/tests/shell_loader_invalid_block.sh
@@ -4,9 +4,6 @@
 #
 # ---
 # doc
-#
-# [Description]
-#
 # This is a simple shell test loader example.
 # ---
 #
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
