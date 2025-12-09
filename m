Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DA1D3B98A
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:56:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267D03CFF97
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:56:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC5E63C8FFC
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8B29600663
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 153EE337E9;
 Tue,  9 Dec 2025 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1MsDDaHTEDKQgJtvSgS5o09gX9+VZooNXw/5aFt+aQ=;
 b=d9j2bn3mDtpv+VcfKj1glUb/tXJsWvP66kyxh50a23H051DkMo+KiNa3O9Gp13+BFlajgQ
 cysQqS01tN3mWnfA54t5yi8z/+xSiQTlrZyngZr7VCm2wAh7tXJkCoQkFhU71/mug0VJIr
 J0c+9PlQhp/227p2x9WttI+rjMEUkXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1MsDDaHTEDKQgJtvSgS5o09gX9+VZooNXw/5aFt+aQ=;
 b=hI3k+TmUBkMaYCNooXV5YCNPXQqLo7pcp9AdhBhD6aeyyiXfPhIgfQs8hBU3DYB/ZfQ35I
 IO0xkZZuxyGqI+DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1MsDDaHTEDKQgJtvSgS5o09gX9+VZooNXw/5aFt+aQ=;
 b=d9j2bn3mDtpv+VcfKj1glUb/tXJsWvP66kyxh50a23H051DkMo+KiNa3O9Gp13+BFlajgQ
 cysQqS01tN3mWnfA54t5yi8z/+xSiQTlrZyngZr7VCm2wAh7tXJkCoQkFhU71/mug0VJIr
 J0c+9PlQhp/227p2x9WttI+rjMEUkXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1MsDDaHTEDKQgJtvSgS5o09gX9+VZooNXw/5aFt+aQ=;
 b=hI3k+TmUBkMaYCNooXV5YCNPXQqLo7pcp9AdhBhD6aeyyiXfPhIgfQs8hBU3DYB/ZfQ35I
 IO0xkZZuxyGqI+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C78443EA66;
 Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CPJsL8FwOGnSSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 19:55:55 +0100
Message-ID: <20251209185557.20598-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] tst_test.sh: Add TST_USR_{G,U}ID variables
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

Add TST_USR_{G,U}ID variables with the default values from tst_runas.c.

These can be used as a default values for tests which use tst_runas and
need to know UID/GID for other commands.

It will be used in LTP IMA tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_runas.c | 1 +
 testcases/lib/tst_test.sh | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_runas.c b/testcases/lib/tst_runas.c
index e8d5d8dd9d..e937828273 100644
--- a/testcases/lib/tst_runas.c
+++ b/testcases/lib/tst_runas.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
  */
 
+/* update also tst_test.sh */
 #define LTP_USR_UID 65534
 #define LTP_USR_GID 65534
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 4be10a4f94..26e6a86dcb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,10 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+# see testcases/lib/tst_runas.c
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
