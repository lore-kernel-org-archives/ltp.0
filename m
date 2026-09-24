Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E75DC98311
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 09:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3833E3E64A7
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:59:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127203E62D0
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 11:59:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57CC11001150
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 11:59:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6846F20051
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790243964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qUWbWa0GaqvR84Frn0Lpem95Ur+nQb1bL4+1bdtK9ko=;
 b=hfkloGkFbK6KuEJF95lD9OQJ0eP7etRG9rdznKS+u0QNivh/VHM+KjbZcMSFrL987Q//uz
 NRxBBWav0HjtRA8hQdpRii4KjePklkrVqgmVwI12pvdMxXZSxeuhPRDCYOWTlXsYsHYLpK
 nRP2od6rYEY8xWz9+Ir+AHOk9uITRcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790243964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qUWbWa0GaqvR84Frn0Lpem95Ur+nQb1bL4+1bdtK9ko=;
 b=sBLivl4G32DLWsBPQIgi4YfwggAjo+2/EPzjfMYFGEP/LLF2oQ5qJsBw9DTbhyFsGbM0MM
 t59iaVQpsuc1jABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790243960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qUWbWa0GaqvR84Frn0Lpem95Ur+nQb1bL4+1bdtK9ko=;
 b=Ex5BPSpNXg3+uSNhNMnCfl1RYFCnZdfYvtrK1MgeYIX5JETS+mM8FJi4OWlkerDRXmwEnl
 Y9kACbJFRASQT78gg+uTjcy31MwNhTGqIXbzfyTUT+R0T9XkWEYb/3SGrOjXHO6DU/YehH
 nLVsf5h2rMgvsJjUkSaTeWx8CVtldtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790243960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qUWbWa0GaqvR84Frn0Lpem95Ur+nQb1bL4+1bdtK9ko=;
 b=hLHfkTSwDOv5KqgSW5VHwHssrzTRhucEiGODoNr3npRfoGnwwZcB/A+Itn+cpM9iZJu7P2
 uTpI2XcyqGjtbVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 394AF136ED
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 09:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4ojlBnj0tGqRQQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 09:59:20 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Sep 2026 11:59:33 +0200
Message-ID: <20260924095933.4183470-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_test: Clarify the .needs_abi_bit TCONF
 message
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

The previous message was confusing. On 32bit machine sendfile09 tests
that has .needs_abi_bits = 64 produced this message:

tst_test.c:1493: TCONF: 64bit ABI is not supported

This message is a bit confusing, since on 32bit x86 machine 64bit ABI
is, of course, not supported, so why do we skip the test?

After this patch the message is:

tst_test.c:1493: Test needs 64bit ABI

Which is, as far as I can tell, more clear.

Fixes: 56f63e54e5a3 ("lib: Add .needs_abi_bits")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index ed3d26cad..e27a24c24 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1490,7 +1490,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Not supported in 32-bit compat mode");
 
 	if (tst_test->needs_abi_bits && !tst_abi_bits(tst_test->needs_abi_bits))
-		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
+		tst_brk(TCONF, "Test needs %dbit ABI", tst_test->needs_abi_bits);
 
 	if (tst_test->needs_cmds) {
 		struct tst_cmd *pcmd = tst_test->needs_cmds;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
