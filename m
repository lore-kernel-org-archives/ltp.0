Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AD4C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D0AE3D0347
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:37:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0357E3D0333
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:59 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5EE22600A49
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFBAA1FB63;
 Mon, 27 May 2024 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4zuGbIl1F2N/oRP07ZljLDUY83aboPmtnehxi+fW/w=;
 b=AGAdeqVUEyR+saKGxKE6D5PhZtk9BKzEa9TJPdCvhLqE9ieFdf8aZze/1H1Ade9Zco0AkV
 LSZw2uDRNn1nbq2kuu8cCOn6/fW9rGEvWu+EG+lacPTLIccrkyJNohbZI5wy6eAzxUq+Wd
 2xWNp4BMX3yvPdfpMc5caVU+eg+pTzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4zuGbIl1F2N/oRP07ZljLDUY83aboPmtnehxi+fW/w=;
 b=OfM+VulU4tsbWvFPhhhtoWreunTIRClwKDwEHKyx7qH/8B2dMMibIvw29nvTCLHyw2mzW+
 KKf448rhm15az0Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q98zSLoD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=edazltlQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4zuGbIl1F2N/oRP07ZljLDUY83aboPmtnehxi+fW/w=;
 b=q98zSLoDKm7SNMTNPbQv2j6WqeuHybMgusEvDlHMKtey6eq4plNlsJrJ2fJzbJhjgs92l6
 TF92tJK2FjPc+JEinrXGuUNtdpQ7/yljZan83ZMwY14Rx5ZMbdZ6M7Oopy3kU7lIccjPDQ
 AiOElyDzw8Iy5xUzUkFTKj7xLH7LL/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4zuGbIl1F2N/oRP07ZljLDUY83aboPmtnehxi+fW/w=;
 b=edazltlQME9JdLOCtv89/5KisVUX7WvVbWkD+N40Ew1WBcOoFuf7I3MtQO4XjOTNDHfQSU
 i2NbCaEv0znu1TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF4E013A56;
 Mon, 27 May 2024 06:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mGL3MFUpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:44 +0200
Message-ID: <20240527063346.289771-14-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EFBAA1FB63
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/15] bpf: Remove kernel >= 3.18 or 3.19 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/bpf/bpf_map01.c  | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog03.c | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog04.c | 1 -
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
index b01402dc4..7f2264bf5 100644
--- a/testcases/kernel/syscalls/bpf/bpf_map01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -147,7 +147,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(map_types),
 	.test = run,
 	.setup = setup,
-	.min_kver = "3.19",
 	.bufs = (struct tst_buffers []) {
 		{&key4, .size = 4},
 		{&key8, .size = 8},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index 6c149f661..b3846cb62 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -107,7 +107,6 @@ void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.min_kver = "3.19",
 	.bufs = (struct tst_buffers []) {
 		{&log, .size = BUFSIZ},
 		{&attr, .size = sizeof(*attr)},
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index c96a2fb76..69314aea7 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -115,7 +115,6 @@ static void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.min_kver = "3.18",
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{}
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index 531fc5743..bb93183d5 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -152,7 +152,6 @@ exit:
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.min_kver = "3.18",
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
 		{}
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
index 1d74e418e..5c61d34b4 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog04.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -105,7 +105,6 @@ static void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.min_kver = "3.18",
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 742beab0b..08254ba89 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -192,7 +192,6 @@ static void run(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
-	.min_kver = "3.18",
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.caps = (struct tst_cap []) {
 		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
