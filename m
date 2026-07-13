Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD6AC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 15:57:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDC483E9697
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 17:57:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A7493E2868
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 17:57:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E981600052
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 17:57:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9029F77982
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783958261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tp3tsDH21pwEKYRQ0ATOdzztCoiyejwz45mucsuzVzw=;
 b=3EXCQkZcqikzD2EY99Ym0S9+ZR202TVGaDC9f/uIr0ymNCNLzsPZbMbKy5mZXs4fK3JJsV
 XEej2gnbBD6dbg3Fjtrx0AzdzUJFh+OYhhQLeX1jtjk/B0saO9UBTWmZ79QpLmzF8FnQuC
 hRP/jBdlzUmf2XYPNyDukuXJ1elAuKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783958261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tp3tsDH21pwEKYRQ0ATOdzztCoiyejwz45mucsuzVzw=;
 b=8HUSlS0L2/TMCnt248aVwz+VLmb2W+i+kt4zwjHyQpW5IPR9S1dQDxIuzjtVjxCyy99p9y
 4dDp0Wi8bYlde3Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mO1eQEr4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QX4w6hEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783958260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tp3tsDH21pwEKYRQ0ATOdzztCoiyejwz45mucsuzVzw=;
 b=mO1eQEr46VoDQzu6+UCoyK46QRgw/4yo2CrqLCcxu1d0UNr6QbspaTRPk0lwgpBQZ1Mae0
 2yT+HKAo298Yf1ImGaFqK18nUmGYt3d0tvRCzYyhVJqQ8POUv8zm3+rovUyx0Nt22UBNJT
 kpd+t4Sjpu78cskuSt1cNxHUIKb3qs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783958260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tp3tsDH21pwEKYRQ0ATOdzztCoiyejwz45mucsuzVzw=;
 b=QX4w6hEYGQ6ESg7tSkWPKmO7s1SRnpd9D6UXxUm3T9mRqfIIwc0wZjdhiiOhSZedxXljcZ
 4UyPvMjaVI5tpfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88550779AE
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 15:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m6UMIfQKVWrSCAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 15:57:40 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 13 Jul 2026 17:57:37 +0200
Message-ID: <20260713155739.48823-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9029F77982
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email, suse.cz:mid,
 goodmis.org:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify25: Add CVE reference and include it in CVE
 runfile
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

The kernel bug tested by fanotify25 is assigned CVE 2023-52879. Add
CVE reference and git reference for the kernel fix. Also add the test
to the CVE runfile.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/cve                                     |  1 +
 testcases/kernel/syscalls/fanotify/fanotify25.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/runtest/cve b/runtest/cve
index ca9994868..27e12e0c1 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -87,6 +87,7 @@ cve-2022-23222 bpf_prog07
 cve-2023-1829 tcindex01
 cve-2023-0461 setsockopt10
 cve-2023-31248 nft02
+cve-2023-52879 fanotify25
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
index d2d3f6e6a..6b22f65b3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify25.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
@@ -6,8 +6,17 @@
  */
 
 /*\
+ * CVE-2023-52879
+ *
  * Verify that :manpage:`fanotify(7)` monitoring can be applied to the tracing
- * filesystem and write events will be correctly delivered.
+ * filesystem and write events will be correctly delivered. NULL pointer
+ * dereference fixed in:
+ *
+ * commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4
+ * Author: Steven Rostedt (Google) <rostedt@goodmis.org>
+ * Date:   Tue Oct 31 12:24:53 2023 -0400
+ *
+ * tracing: Have trace_event_file have ref counters
  */
 
 #define _GNU_SOURCE
@@ -118,6 +127,11 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_TRACING",
 		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bb32500fb9b7"},
+		{"CVE", "2023-52879"},
+		{}
 	}
 };
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
