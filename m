Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE0C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 12:14:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C6103C91D9
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 13:14:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D5693C8EBD
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:13:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC85511F2F87
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 13:13:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8D6D1FD2A;
 Fri, 21 Feb 2025 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740140031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FjTdwyCbysuILB+Q+xlFrJZ/mCui9OBJKv6IXfhSr98=;
 b=xxyQrIZLlbDewO6q8hVeIg3EHCK/ob66MKMPpQqXaf7cETi0kGnw0AHRtfYjDmcBUhcQIE
 G9giFMPKz3R0XheHYGhVS6JKyfsPdYxuwOQKa5RxEd7BsV4pxJ1f1NNIVF8P63nigXGulx
 vVWad81ZN4WhpWmLiTz9/eK8B/v9uc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740140031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FjTdwyCbysuILB+Q+xlFrJZ/mCui9OBJKv6IXfhSr98=;
 b=G4CHGA+vLjPF2CPEk98GFPmeKhPUgUJatyjgiA694+8H0YuHNFLGdRPB0OkoHl3RdHvZ9F
 LIInEwv9JzQpEpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740140031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FjTdwyCbysuILB+Q+xlFrJZ/mCui9OBJKv6IXfhSr98=;
 b=xxyQrIZLlbDewO6q8hVeIg3EHCK/ob66MKMPpQqXaf7cETi0kGnw0AHRtfYjDmcBUhcQIE
 G9giFMPKz3R0XheHYGhVS6JKyfsPdYxuwOQKa5RxEd7BsV4pxJ1f1NNIVF8P63nigXGulx
 vVWad81ZN4WhpWmLiTz9/eK8B/v9uc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740140031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FjTdwyCbysuILB+Q+xlFrJZ/mCui9OBJKv6IXfhSr98=;
 b=G4CHGA+vLjPF2CPEk98GFPmeKhPUgUJatyjgiA694+8H0YuHNFLGdRPB0OkoHl3RdHvZ9F
 LIInEwv9JzQpEpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B98A136AD;
 Fri, 21 Feb 2025 12:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U6BzEP9tuGd0WwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 12:13:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Feb 2025 13:13:44 +0100
Message-ID: <20250221121344.2778278-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:url];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lsmod01.sh: Whitelist zcrypt
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
Cc: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

zcrypt (s390x specific module) has different refcnt:

    lsmod01 1 TINFO: lsmod output different from /proc/modules
    118c118
    < zcrypt 131072 9
    ---
    > zcrypt 131072 8

This is probably due libcrypto update to support hardware acceleration
of some algorithm that kmod is using, which causes increasing refcnt.

Because it's would not be easy to get a generic mechanism to detect
affected modules (ATM probably only zcrypt), whitelist parsing it.

Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1237399
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/lsmod/lsmod01.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 8b7a0a7943..1fe399aa06 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -14,6 +14,9 @@ TST_NEEDS_CMDS="lsmod"
 
 module_inserted=
 
+# zcrypt has higher refcnt
+whitelist_modules='zcrypt'
+
 setup()
 {
 	if [ -z "$(cat /proc/modules)"  ]; then
@@ -55,8 +58,8 @@ lsmod_matches_proc_modules()
 	if [ "$lsmod_output" != "$modules_output" ]; then
 		tst_res TINFO "lsmod output different from /proc/modules"
 
-		echo "$lsmod_output" > temp1
-		echo "$modules_output" > temp2
+		echo "$lsmod_output" | grep -v "^$whitelist_modules" > temp1
+		echo "$modules_output" | grep -v "^$whitelist_modules" > temp2
 		if tst_cmd_available diff; then
 			diff temp1 temp2
 		else
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
