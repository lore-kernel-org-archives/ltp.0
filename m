Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AE2ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8442B3C17CE
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 14:28:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 136B43C068A
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 14:28:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 58479200C76
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 14:28:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 882DB1F7BB
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725884921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kal1dwia7yx+G8pwSnxZDfVxw5eYwAi+q4lzon2Md4c=;
 b=w7O3m/NyDQ7rdHmt1LUVLtoOIUhTWBFBRQc0onO3VQDZ0GOW5M6gbCWZZbTW5PcWqZfhqR
 /k1Rbl1C3u1SKQv+5pY/r2Terjt7xDrglj3VmcGndw8U7OyEXwVRAcho5eIDe7S/kuvYVr
 huPpFwWpJm1UwJQKawi/1CZLwE0EkpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725884921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kal1dwia7yx+G8pwSnxZDfVxw5eYwAi+q4lzon2Md4c=;
 b=4J5zS0vOT0qIogz/JojDBN8O9Lj3/NYrw+7Ya+tQU5xjXj8A3hzugHd8sbx0bahB2HK1WE
 M0vkkhQ2jalrMFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725884921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kal1dwia7yx+G8pwSnxZDfVxw5eYwAi+q4lzon2Md4c=;
 b=w7O3m/NyDQ7rdHmt1LUVLtoOIUhTWBFBRQc0onO3VQDZ0GOW5M6gbCWZZbTW5PcWqZfhqR
 /k1Rbl1C3u1SKQv+5pY/r2Terjt7xDrglj3VmcGndw8U7OyEXwVRAcho5eIDe7S/kuvYVr
 huPpFwWpJm1UwJQKawi/1CZLwE0EkpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725884921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kal1dwia7yx+G8pwSnxZDfVxw5eYwAi+q4lzon2Md4c=;
 b=4J5zS0vOT0qIogz/JojDBN8O9Lj3/NYrw+7Ya+tQU5xjXj8A3hzugHd8sbx0bahB2HK1WE
 M0vkkhQ2jalrMFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01A1113312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pzx2Mvjp3mYHTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 12:28:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 14:28:29 +0200
MIME-Version: 1.0
Message-Id: <20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com>
X-B4-Tracking: v=1; b=H4sIAOzp3mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNL3aLU9NS8+OKM0pLSgvic4gLdRGNTMwOzRAsL8yQzJaC2gqLUtMw
 KsJHRsbW1AEx+DrNiAAAA
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725884920; l=1472;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=JvPEywGdQHNudwG7xfqLTNchdaA979JZ5oMqHlvJd4s=;
 b=kq2sGakuD16bqjOZHjhulRAyZUwpDRu7/xrOvIn5Zf4ZnKmyBTHhiiQHyvhpCovUK7T+gWMAA
 tHxYEz/lMEyDucoIj4KkXJNT0DTutQW642lXfnYSUUv1wKanKFaPpBN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Remove cleanup.c inclusion from syscalls generation
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Remove cleanup.c from syscalls.h as it is part of the old library and
its usage is discouraged. LSP(s) supporting C language correctly flag
this file as problematic. This patch ensures that the lapi/syscalls/regen.sh
script will no longer include cleanup.c, preventing unnecessary usage in
generated headers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/regen.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 97027e2f3..0dd3269bb 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -33,7 +33,6 @@ cat << EOF > "${output_pid}"
 #include <errno.h>
 #include <sys/syscall.h>
 #include <asm/unistd.h>
-#include "cleanup.c"
 
 #ifdef TST_TEST_H__
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
@@ -41,8 +40,11 @@ cat << EOF > "${output_pid}"
 		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #else
+static void dummy_cleanup(void) __attribute__ ((unused));
+static void dummy_cleanup(void) {}
+
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
-	tst_brkm(TCONF, CLEANUP, \\
+	tst_brkm(TCONF, dummy_cleanup, \\
 		"syscall(%d) " SNR " not supported on your arch", NR); \\
 })
 #endif

---
base-commit: d3f1f93eda69905932bde4f66b44d72f9211909a
change-id: 20240909-regen_shutup_lsp-a35606a887b6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
