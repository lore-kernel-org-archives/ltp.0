Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC7CE7AE3
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FF433C264F
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 09:25:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F8923C0780
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 09:25:19 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6F66B1A0147B
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 09:25:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44F241F896;
 Fri,  6 Sep 2024 07:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725607518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jDJGiF/BX8nXw+Fc53UMd3LJkqVNqCU65h+mrHdLVfk=;
 b=Il62bsvsUGTUBSa/bfUXedcan4hCcrkO34MFPNeWR6thWrl4EFat+3vYJ3FcvkDrFcUENh
 Q4tg1O2mfgCi8uS460gkFZg4gCw37pHFMVMk4DZHHD+G4VyUafEWkP+6DTLxuwLf571QkD
 DNcFe85/WJwKSgaMux8aX8vDCRlnTck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725607518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jDJGiF/BX8nXw+Fc53UMd3LJkqVNqCU65h+mrHdLVfk=;
 b=Nrm2gPzx0Stc8Ap/RqOP4/EJUel9YxvAGwkVSlV8DdsOWJdzDnr8V7T+jy5d2EyiaRDWa0
 e1/A/mTqpFZ7vIAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725607518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jDJGiF/BX8nXw+Fc53UMd3LJkqVNqCU65h+mrHdLVfk=;
 b=Il62bsvsUGTUBSa/bfUXedcan4hCcrkO34MFPNeWR6thWrl4EFat+3vYJ3FcvkDrFcUENh
 Q4tg1O2mfgCi8uS460gkFZg4gCw37pHFMVMk4DZHHD+G4VyUafEWkP+6DTLxuwLf571QkD
 DNcFe85/WJwKSgaMux8aX8vDCRlnTck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725607518;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jDJGiF/BX8nXw+Fc53UMd3LJkqVNqCU65h+mrHdLVfk=;
 b=Nrm2gPzx0Stc8Ap/RqOP4/EJUel9YxvAGwkVSlV8DdsOWJdzDnr8V7T+jy5d2EyiaRDWa0
 e1/A/mTqpFZ7vIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0335A1395F;
 Fri,  6 Sep 2024 07:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S/7POV2u2mbVMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Sep 2024 07:25:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Sep 2024 09:25:00 +0200
Message-ID: <20240906072500.982132-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fanotify09: Skip testing e730558adffb on SLE <
 5.19 kernel
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kernel commit e730558adffb ("fsnotify: consistent behavior for parent
not watching children") will not be backported to SLE15-SP[45] v5.14
based kernel, therefore skip it for kernel < 5.19 (the original mainline
kernel which brought the functionality.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify09.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 48b198b941..72e9239897 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -379,7 +379,12 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
-	if (tc->ignore && tst_kvercmp(5, 10, 0) < 0) {
+	static struct tst_kern_exv kvers[] = {
+		{"SLES", "5.19"},
+		{NULL, NULL}
+	};
+
+	if (tc->ignore && tst_kvercmp2(5, 10, 0, kvers) < 0) {
 		tst_res(TCONF, "ignored mask on parent dir has undefined "
 				"behavior on kernel < 5.10");
 		return;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
