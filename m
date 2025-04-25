Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284AEC369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 12:51:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871B53CB887
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 14:51:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BADD3C9E96
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:51:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 894BE1000410
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:51:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F208421166;
 Fri, 25 Apr 2025 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745585470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
 b=boZMPiaAVWLLQJzkxOMscuUgVy3S5rEhpUjEX4w8731r8RaFYxdMAjkEH7vB4ASGkiKx05
 LRUxmLFtHB8sPAnPPkf/BZfHRP7t5k0TjLJdbPvS4I2JwG2HM/qvtgaPDHNJOJbCVAqvrV
 nPGyTZ6O7418QwD99G7TPXvV7iOO+Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745585470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
 b=wV1wWgS27FHLxlV5xXpQwFihJLo5AHtHxtc4p4YnVLnGBZLkYrjb0n2X8P/WPX7ye3KIHw
 QfyQQ/cmb+pY0oBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GrCk+eQG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rTlNnZIH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745585469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
 b=GrCk+eQGuVX2berEZ+AQwds2LMUZPH5INeUfLLkmPaqbqTHXKJijPC7Iw2SamxbjS6g/P9
 nQuu5I6Gal48Q5ebfjaG8jZS+rlfOpsTUZdOA1zmVbr7/KvDw3f38YXnvrGJulds9lz1iW
 tooBFMr6OztAqKPz1PqmyH1M4ci5Cdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745585469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
 b=rTlNnZIHvGfDm3bni670CmTBIARaaemnmnJUCG8hNTZG05ixd5YCTRXoD4fhSF1+HjCnU5
 1YAk8QkL8p8oRQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9B391388F;
 Fri, 25 Apr 2025 12:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nNuXJzyFC2gISgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 12:51:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Apr 2025 14:50:57 +0200
Message-ID: <20250425125057.38992-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: F208421166
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.cz,linux.ibm.com,paul-moore.com,vger.kernel.org,linux.microsoft.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_security.sh: Use the same value for checkreqprot
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
Cc: Paul Moore <paul@paul-moore.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

kernel commit e9c38f9fc2cc ("Documentation,selinux: deprecate setting
checkreqprot to 1") from v5.10-rc1 deprecated checkreqprot value 1
(emit warning in dmesg). Code is used only in ima_selinux.sh
which requires 5.12. Touching /sys/fs/selinux/checkreqprot is required
to trigger the measurement via selinux_ima_measure_state().

Using the same value (0 by default) works on recent 6.14, it should be
safe changing to use the same value. This way misleading warning is
avoided and hopefully kept working in the future.

Also, this way it does not modify SUT setting (don't influence other
tests), which is always better.

Fixes: 36c695e497 ("tst_security.sh: Add helper tst_update_selinux_state()")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@SELinux developers: FYI tst_security.sh is used in LTP test in
ima_selinux.sh [1] test.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh

 testcases/lib/tst_security.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 4e2d34ca98..820736c723 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -142,11 +142,10 @@ tst_get_enforce()
 
 tst_update_selinux_state()
 {
-	local cur_val new_val
+	local val
 	local dir=$(tst_get_selinux_dir)
 	[ -n "$dir" ] || return 1
 
-	cur_val=$(cat $dir/checkreqprot)
-	[ $cur_val = 1 ] && new_val=0 || new_val=1
-	echo $new_val > $dir/checkreqprot
+	val=$(cat $dir/checkreqprot)
+	echo $val > $dir/checkreqprot
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
