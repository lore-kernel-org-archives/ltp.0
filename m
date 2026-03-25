Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C6FEA82F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 07:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DADDD3E26EC
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 08:55:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34B983E1F8D
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 08:55:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABE02100044B
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 08:55:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB2945BD13;
 Wed, 25 Mar 2026 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774425305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fap0lXZQXsuh7UX0Dk0kaEeF/nUMbLvUPEoEEBdrFBo=;
 b=y6gGM0u4CvNFtHzq8zJIyk8NVAPmPfcdUxxQZRIEQrv/3fYyHxEZ1vvhtXZzp0a8HQmbn4
 ZTJAjUZii1g5d1ZrSIXXxxBBQjnZbzFFrQKpyyD9QwP9saOuVhAgWVKN018UiJoeQZLDHg
 9UXzenxFd1ewjIn6KHQk3ijEeo4Aedw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774425305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fap0lXZQXsuh7UX0Dk0kaEeF/nUMbLvUPEoEEBdrFBo=;
 b=eFCpuMaYTJtIJnwI5XZCJQJ+15GM1m+yrOkf+MKTBDVW80Wlxjx0giV4NAbyUkYPDtLEfk
 V08hQAGobD7NUyCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ctf8WasT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jJscV8rw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774425304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fap0lXZQXsuh7UX0Dk0kaEeF/nUMbLvUPEoEEBdrFBo=;
 b=ctf8WasTxrbDCn8dRdQdmDYUG51SlMK6ZC6L5ODfvSr/YeKk/DRd4gXEGjZjhGaGUYNzry
 wmzdKDsF4v+VA4fhzRoNaNIjyUt5gijv8clazOlCUZ7FzCt1/VEkqRJEfJQimYPBU2gNy7
 YJVzycpeQ8kFeSzp+ebsq3PPfBWLoC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774425304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fap0lXZQXsuh7UX0Dk0kaEeF/nUMbLvUPEoEEBdrFBo=;
 b=jJscV8rwHYeGY4NI26sc/1inNy4ibh9+1pebGX4KuFa86II71DrkF4LAgNT9ZOxnzbu++O
 YKlfbcl6+PZQfoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEDA7442BE;
 Wed, 25 Mar 2026 07:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jCTULNiUw2nfLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 07:55:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 08:55:04 +0100
MIME-Version: 1.0
Message-Id: <20260325-compile_flags_gitignore-v1-1-b0de37eeacc8@suse.com>
X-B4-Tracking: v=1; b=H4sIANeUw2kC/x3MQQqAIBBA0avErBNyooiuEhGhow2YxhgRRHdPW
 r7F/w9kEqYMY/WA0MWZUyzQdQVmW6MnxbYYsMG+abFTJu0HB1pcWH1ePJ/sYxJSRqMdXN+RQwu
 lPoQc3/95mt/3A2n6bBFpAAAA
X-Change-ID: 20260325-compile_flags_gitignore-c12d8f65ef2d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774425304; l=852;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=s1ktKV2yr/U1Ou5uHk1H8qO6n64B/Pg2vjtU5jxS03I=;
 b=S+pQTQD/mXypSC7LeDcyITxCybcaVADKrAjec3ye4G7KQt5NRV0LG6TByjE/EkhSEHNNPyCsP
 S6L6SXxBdqjD80BAhlF/2bKowq1XBk44wnm25kwNKJfp9FYIuWkEe5F
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: DB2945BD13
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add compile_flags.txt to gitignore file
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

Add rule to ignore clangd LSP configuration from local repository.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Clangd is extensively used by IDEs and generic LSP wrappers to setup
clangd configuration. This patch removes it from gitignore so we can
safely avoid it gets into the patch-set when it's sent.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 24f4a4ea834e0b919e640e879fe5e5b5d7aec466..6cd409489f266c4805dcf4633957892b10ea032a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,3 +60,4 @@ patches/
 logfile.*
 
 /utils/benchmark/ebizzy-0.3/ebizzy
+/compile_flags.txt

---
base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
change-id: 20260325-compile_flags_gitignore-c12d8f65ef2d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
