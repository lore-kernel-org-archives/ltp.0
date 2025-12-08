Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B80D3B7F2
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 14:13:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411FA3CF104
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 15:13:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477EB3C5480
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 15:13:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7234600145
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 15:13:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E1F53391B;
 Mon,  8 Dec 2025 14:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765203205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
 b=i5Q2bgKpMu8ShKvEGoMUTPNvQ7dSxXz7bC7QZ6ZiyeC/TknrmW/WF3wSYijl7F+F67ErbH
 Bz9yEhn/sybOyvUQz0N0rEuu0JC4BB93c7UinBr6HX38JCVsn+tGlEG9ZbETGoKHLLjHrv
 Vx6EnSoL4LXVE5ud8sbH+wZUXnTZ3po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765203205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
 b=fvbiiu4+LeZvl/j224LVBDfvhPEwEutkN61uaphSe90VTTu1NWPYq3p1j9mrKn8m8qm2tH
 n6Inb1Gk90PbXIDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L2MGOa9P;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6D27nCMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765203204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
 b=L2MGOa9PINGGsNw4W6vvVw89/A0dUejiyFUMDGGgRkWGbxCXlyNIRzOGfsgtCjZ0k3OdSg
 u470Lwkb2RWb/2ATzR7EhbVm1AJ7BP+bCajzPAYWACEMgGsuiXtcTHSRBujYYf2gp6DVeV
 IPeVZKT98rrk1uTy/6Ik/72he3qp3vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765203204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
 b=6D27nCMG+phdksc5THYFexNtPCHNxm0RUCkkLBH0GkvI/CwES9xjw7XS05lqGyvHN22dLh
 Ha4mlsv+5OsrwhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AD063EA63;
 Mon,  8 Dec 2025 14:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5rkOGQTdNml8KAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 14:13:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Dec 2025 15:13:21 +0100
Message-ID: <20251208141321.696537-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ima_selinux.sh:url,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E1F53391B
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_selinux: Fix requirements
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

"measure func=CRITICAL_DATA label=selinux" in selinux.policy LTP example
policy is a subset of "measure func=CRITICAL_DATA" loaded by
ima_policy=critical_data kernel command line option.

Therefore ima_selinux.sh require only one of them, not both.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Thanks Mimi!

Kind regards,
Petr

 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 1a0de21efd..e64a7739f9 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -18,13 +18,12 @@ TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
 REQUIRED_POLICY_CONTENT='selinux.policy'
+REQUIRED_BUILTIN_POLICY='critical_data'
 
 setup()
 {
 	SELINUX_DIR=$(tst_get_selinux_dir)
 	[ "$SELINUX_DIR" ] || tst_brk TCONF "SELinux is not enabled"
-
-	require_ima_policy_cmdline "critical_data"
 }
 
 # Format of the measured SELinux state data.
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
