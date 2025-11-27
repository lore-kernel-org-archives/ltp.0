Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D53CFD2F6
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 08:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6643B3CB812
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 09:27:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BE7A3CC11A
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 03DDA600850
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 09:26:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E16055BCCC;
 Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
 b=VktAw7xURAmKP2EjFTaTCCWYwAKtggoQ+31sh0BQv16A6f6+oWabLuAI56wTyJwpEiFER4
 Vxzas99NcfeRg/0oOP0YQknKlrfp/0jU7gM6GZ07Q4OMEWfLLvMxWQQEDHXZhUyZbz4abh
 qqi0inD4R4pt9c64828ZEeHd5+hxWcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
 b=R/Yn4sCq2Y/Kqg3qjA2b2Sf4nbyJ75tWkSUGa2vsP6z5gIR/bUlWA66UauovvcnHi6HxJj
 hSPXX+4b/BdDjjDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ldIeNu+C;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xel3wyNO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764232004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
 b=ldIeNu+CyWoKJqRavSt6buq9Qhcy9A5E5vc/JUUPGpBa1qO3Qv5PGgpA7Uf7D1g5Rt95OV
 FU4CY7nwWid+FN1lANUtLPzelNKA11fH2QH6sCTUXL2GAbhZrlP+LwA7h/N9sXyeG5sHyo
 r6KIIpECnW+WjVCvC6IIyZSp4iBLH34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764232004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+Q4h01pOwT/SuGvCKHCL7aml1Q5v7LKgKOgHkDeg4o=;
 b=xel3wyNOIk+MMXJ6todwq9VEJYdBstty+d3wq6J5BJiPBh2DMkMqSFbgGPOF5VO5MEzXpR
 Ij9ngLYl/0ztzZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B52573EA66;
 Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFJzK0QLKGmNJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Nov 2025 09:26:36 +0100
Message-ID: <20251127082638.224110-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127082638.224110-1-pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E16055BCCC
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] tst_test.sh: Add TST_USR_{G,U}ID variables
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

Add TST_USR_{G,U}ID variables with the default values from tst_sudo.c.

These can be used as a default values for tests which use tst_sudo and
need to know UID/GID for other commands.

It will be used in LTP IMA tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_sudo.c  | 1 +
 testcases/lib/tst_test.sh | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_sudo.c b/testcases/lib/tst_sudo.c
index e8d5d8dd9d..e937828273 100644
--- a/testcases/lib/tst_sudo.c
+++ b/testcases/lib/tst_sudo.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
  */
 
+/* update also tst_test.sh */
 #define LTP_USR_UID 65534
 #define LTP_USR_GID 65534
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 4be10a4f94..49f282d7c8 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,10 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+# see testcases/lib/tst_sudo.c
+export TST_USR_UID="${LTP_USR_UID:-65534}"
+export TST_USR_GID="${LTP_USR_GID:-65534}"
+
 . tst_ansi_color.sh
 . tst_security.sh
 
@@ -689,7 +693,7 @@ tst_run()
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
 			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
-			DEVICE_SIZE);;
+			DEVICE_SIZE|USR_UID|USR_GID);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
