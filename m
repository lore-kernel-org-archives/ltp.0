Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8DECDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B50203E4D45
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:21:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22EEB3E61FB
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 456916008F9
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D676176125
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDXClUXpCekZubVgdPZUAaC7DVWcBlHcDsO6fCDygEs=;
 b=wKvuWGwatVXftq21JNTeCXC3TOSaeGXCtW9LRnQkLyMdC9AM5IuTpDq0W2EbbwL8LICKvh
 9MlHJlMxOPeIgjbMXDgJx5GKBFHABWjVmoUJlvAlpaJ06nH98L3IRmj1b9oRTm5YxjNEb6
 HHGa0lBjLQmEg6mES0tQ1fM44fAesoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDXClUXpCekZubVgdPZUAaC7DVWcBlHcDsO6fCDygEs=;
 b=RbMSwowcOMtE0xUsnauxNgd31DOZeaLM2ln9DJ8HutOW6CPZVLJ57OoLh/1ooXuQpAAecT
 idXVAFQEblkQ//Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDXClUXpCekZubVgdPZUAaC7DVWcBlHcDsO6fCDygEs=;
 b=wKvuWGwatVXftq21JNTeCXC3TOSaeGXCtW9LRnQkLyMdC9AM5IuTpDq0W2EbbwL8LICKvh
 9MlHJlMxOPeIgjbMXDgJx5GKBFHABWjVmoUJlvAlpaJ06nH98L3IRmj1b9oRTm5YxjNEb6
 HHGa0lBjLQmEg6mES0tQ1fM44fAesoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDXClUXpCekZubVgdPZUAaC7DVWcBlHcDsO6fCDygEs=;
 b=RbMSwowcOMtE0xUsnauxNgd31DOZeaLM2ln9DJ8HutOW6CPZVLJ57OoLh/1ooXuQpAAecT
 idXVAFQEblkQ//Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75953779B1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bSeMGwehO2pUAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:54 +0200
Message-ID: <20260624091900.4107041-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/13]  mem/thp01: Add proper runtime support
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

The test was executed with -I 120 in all instances. It's cleaner to
define the min_runtime in the test and loop the test function until it's
exhausted.

One of the bonuses we get from this conversion is that the TPASS message
is printed once at the end of the test and we do not flood the logs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/cve                      |  2 +-
 runtest/mm                       |  2 +-
 testcases/kernel/mem/thp/thp01.c | 11 +++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/runtest/cve b/runtest/cve
index 789e16aac..ca9994868 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -1,5 +1,5 @@
 # Tests which check for vulnerabilities by CVE number
-cve-2011-0999 thp01 -I 120
+cve-2011-0999 thp01
 cve-2011-2183 ksm05
 cve-2011-2496 vma03
 cve-2012-0957 uname04
diff --git a/runtest/mm b/runtest/mm
index 98ec0a4c4..c9d460c41 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -77,7 +77,7 @@ oom05 oom05
 
 swapping01 swapping01 -i 5
 
-thp01 thp01 -I 120
+thp01 thp01
 thp02 thp02
 thp03 thp03
 thp04 thp04
diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index 91c08cb1b..ab34a15fe 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -93,8 +93,14 @@ static void thp_test(void)
 		exit(0);
 	}
 	tst_reap_children();
+}
+
+static void run(void)
+{
+	while (tst_remaining_runtime())
+		thp_test();
 
-	tst_res(TPASS, "system didn't crash.");
+	tst_res(TPASS, "System didn't crash");
 }
 
 static void setup(void)
@@ -134,9 +140,10 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
+	.min_runtime = 120,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = thp_test,
+	.test_all = run,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a7d6e4ecdb76"},
 		{"CVE", "2011-0999"},
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
