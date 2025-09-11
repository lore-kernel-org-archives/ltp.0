Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2038ECA1016
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 08:56:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A49753CD810
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 10:56:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 995333CA59B
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 10:56:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2EB661400332
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 10:56:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D51FF37F2C
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757580984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TNLZS3Lirvs5GsUQY5X/iGwSSJt5z3cikSUnpT2kTg=;
 b=GKa2HZAl0KpDVBv/i6OnM0mjFHecjHPRq14z3pwAjtkv/Nl+o6qlncyz2J3+WTJA+njvWE
 x4wWWI+O8FDrTjlLKA/S6cLlrAxJs9MFBD/MfMrhaSoA2VAEcajsBTUdrAXWjoWOa4ElFw
 iVSbTjeaV+4qp/jvNHkq4hC5qvIz/ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757580984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TNLZS3Lirvs5GsUQY5X/iGwSSJt5z3cikSUnpT2kTg=;
 b=wyXey+nRi4vz2AqLFbWIU/ccv4EhLD2KLOmx3Ft8vNQxc2GFZ37aBUs2MlHUSIG0ycmhKd
 of6d/s9IlErI1UAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757580984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TNLZS3Lirvs5GsUQY5X/iGwSSJt5z3cikSUnpT2kTg=;
 b=GKa2HZAl0KpDVBv/i6OnM0mjFHecjHPRq14z3pwAjtkv/Nl+o6qlncyz2J3+WTJA+njvWE
 x4wWWI+O8FDrTjlLKA/S6cLlrAxJs9MFBD/MfMrhaSoA2VAEcajsBTUdrAXWjoWOa4ElFw
 iVSbTjeaV+4qp/jvNHkq4hC5qvIz/ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757580984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TNLZS3Lirvs5GsUQY5X/iGwSSJt5z3cikSUnpT2kTg=;
 b=wyXey+nRi4vz2AqLFbWIU/ccv4EhLD2KLOmx3Ft8vNQxc2GFZ37aBUs2MlHUSIG0ycmhKd
 of6d/s9IlErI1UAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C528613301
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 08:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SWIrL7iOwmgbeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 08:56:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Sep 2025 10:57:00 +0200
Message-ID: <20250911085700.27540-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/cachestat01: Fix num_shift calculation
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

The calculation added in commit 8422d46 works only for 64k page size.
This commit fixes the calculation so that it properly detects maximal
num_shift regardless the page_size.

Closes #1258

Fixes: 8422d4680b21 ("cachestat01: Reduce required space on 64kb page size")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index e218747d9..aa6f21d41 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -72,7 +72,14 @@ static void run(unsigned int use_sync)
 static void setup(void)
 {
 	page_size = (int)sysconf(_SC_PAGESIZE);
-	num_shift = MIN(tst_device->size*1024*2.5/page_size, 15);
+
+	for (num_shift = 0; num_shift <= 15; num_shift++) {
+		if ((1lu<<num_shift) * page_size / 1024 >= tst_device->size) {
+			tst_res(TINFO, "Limiting num_shift to %i\n", num_shift);
+			break;
+		}
+	}
+
 	page_data = SAFE_MALLOC(page_size);
 	memset(page_data, 'a', page_size);
 }
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
