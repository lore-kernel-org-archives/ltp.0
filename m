Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1F8CD3423
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 08:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 589723E2CA1
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:12:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 809FA3D2280
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:11:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C47F21A004E5
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:11:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A6635C05B;
 Mon,  4 May 2026 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=itXkkeahZ5vQwe3TtXph8gTVZcqYFLyakToevXkU9YA=;
 b=VcUks06di6Pwm3/gtiQU3heeQamzUBA7ChCm3uOOwOjNnFauB8CcsnNn487BNwyTwHU8UC
 ENNFXI0dYux95JO+4tPazhMKnlP7uAoT8cSpo3U6OuSQyhiZ1NwDjBghZbn8xgutoarQX5
 4CWJmU12pKdLhTboVMkFYNx8/SyvSo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=itXkkeahZ5vQwe3TtXph8gTVZcqYFLyakToevXkU9YA=;
 b=dJc4yyD2cKtnwqyQ9U+40vHnwfjeJjD8TBi/+MyAeEEj/jTuhWUM5+GAbCZLDSkQXlruok
 jz/FQQzHI9gU0GCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VcUks06d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dJc4yyD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=itXkkeahZ5vQwe3TtXph8gTVZcqYFLyakToevXkU9YA=;
 b=VcUks06di6Pwm3/gtiQU3heeQamzUBA7ChCm3uOOwOjNnFauB8CcsnNn487BNwyTwHU8UC
 ENNFXI0dYux95JO+4tPazhMKnlP7uAoT8cSpo3U6OuSQyhiZ1NwDjBghZbn8xgutoarQX5
 4CWJmU12pKdLhTboVMkFYNx8/SyvSo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=itXkkeahZ5vQwe3TtXph8gTVZcqYFLyakToevXkU9YA=;
 b=dJc4yyD2cKtnwqyQ9U+40vHnwfjeJjD8TBi/+MyAeEEj/jTuhWUM5+GAbCZLDSkQXlruok
 jz/FQQzHI9gU0GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223F1593A3;
 Mon,  4 May 2026 08:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7bbIBsRU+GmXUgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 08:11:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 10:11:47 +0200
MIME-Version: 1.0
Message-Id: <20260504-fix_b4_check-v1-1-8673c1083319@suse.com>
X-B4-Tracking: v=1; b=H4sIAMJU+GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMT3bTMivgkk/jkjNTkbF0TY0tDY5Mki8Q0S2MloJaColSgPNi46Nj
 aWgD8abxvXgAAAA==
X-Change-ID: 20260504-fix_b4_check-439134b8af93
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777882308; l=929;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=YlxM24VGOsEw198F3fuauzNP+s6OPVBsdmxTyyj+g5U=;
 b=EW4PqtHEQrVeSXBqSBth1kFF9NC+7sk9869yUKvz4EY4El/+f3OxREh90RsQtYivv737qF9YU
 KeZxXi/kih+D1J9gvyc2fsVvhG9ABXNpE1PE6ko2xQp9uYAN2kHS39o
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,checkpatch.pl:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3A6635C05B
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] b4: fix errors in b4 prep --check command
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

Set non-file mode for `b4 prep --check` command, so checkpatch won't
threat commits as files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .b4-config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.b4-config b/.b4-config
index ff3199624cb250239c7e62c3b1939085a7e4e2c2..aea68ad8f622ea701c90037ee7a1968a7d4a209e 100644
--- a/.b4-config
+++ b/.b4-config
@@ -6,5 +6,5 @@
     pw-project = ltp
 
     # other checkpatch.pl options from .checkpatch.conf are used
-    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --mailback --showfile
+    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --mailback --showfile --no-f
     am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --mailback

---
base-commit: 72ca484cca53710b956ba2fcc1ff203fe9c9b73b
change-id: 20260504-fix_b4_check-439134b8af93

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
