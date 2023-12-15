Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6922FC4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 18:31:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC9093CF449
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:31:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446CB3CB473
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78A631401103
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0B26220BF;
 Fri, 15 Dec 2023 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfWiNuCYmGQyJW9tesmhXttcux3IC7hm8MArfogJPHI=;
 b=gKx5LCoXX43pYigI7sxChBxwwB650yOnzPwCYCXVN6fRsuvYCftOh36aipPgufqhr8I2KY
 +ullWaNeXOZkfNpQzFOPpLLug9wwgICom43ZsjjrpmGcMCg9QkBV1NQ+0Dpj9xVowKv8Fn
 EuV2BL2p/KtsNan0EcVSMxvftpCj5lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfWiNuCYmGQyJW9tesmhXttcux3IC7hm8MArfogJPHI=;
 b=amE/fN+LfSXiXXABJDg8Nw0AYNy+JMguY4TCG30OvKvIsWwBRgKulKYy4J3ec1/XqlP3xk
 MKebr93UStH3tsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfWiNuCYmGQyJW9tesmhXttcux3IC7hm8MArfogJPHI=;
 b=gKx5LCoXX43pYigI7sxChBxwwB650yOnzPwCYCXVN6fRsuvYCftOh36aipPgufqhr8I2KY
 +ullWaNeXOZkfNpQzFOPpLLug9wwgICom43ZsjjrpmGcMCg9QkBV1NQ+0Dpj9xVowKv8Fn
 EuV2BL2p/KtsNan0EcVSMxvftpCj5lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfWiNuCYmGQyJW9tesmhXttcux3IC7hm8MArfogJPHI=;
 b=amE/fN+LfSXiXXABJDg8Nw0AYNy+JMguY4TCG30OvKvIsWwBRgKulKYy4J3ec1/XqlP3xk
 MKebr93UStH3tsCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D02F13BA0;
 Fri, 15 Dec 2023 18:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id CPPJHHybfGW2LwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 18:31:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Dec 2023 19:31:21 +0100
Message-ID: <20231215183121.57632-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215183121.57632-1-pvorel@suse.cz>
References: <20231215183121.57632-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] runtest/ltp-aiodio.part3: Renumber tests
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

Renumber tests to remove gabs. Use lower case to make it obvious it's a
different test from the old scheme.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ltp-aiodio.part3 | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/runtest/ltp-aiodio.part3 b/runtest/ltp-aiodio.part3
index 2389e7d64..decf2f6ea 100644
--- a/runtest/ltp-aiodio.part3
+++ b/runtest/ltp-aiodio.part3
@@ -1,21 +1,21 @@
-FSX032 fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000
-FSX033 fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -N 10000
-FSX034 fsx-linux -l 500000 -r 4096 -N 10000
-FSX035 fsx-linux -N 10000
-FSX040 fsx-linux -N 10000 -o 1024
-FSX041 fsx-linux -N 10000 -o 2048
-FSX042 fsx-linux -N 10000 -o 4096
-FSX043 fsx-linux -N 10000 -o 8192
-FSX044 fsx-linux -N 10000 -o 16384
-FSX045 fsx-linux -N 10000 -o 32768
-FSX046 fsx-linux -N 10000 -o 128000
-FSX054 fsx-linux -N 10000 -o 1024 -l 500000 -r 4096 -t 4096 -w 4096
-FSX055 fsx-linux -N 10000 -o 2048 -l 500000 -r 4096 -t 2048 -w 2048
-FSX056 fsx-linux -N 10000 -o 4096 -l 500000 -r 4096 -t 4096 -w 4096
-FSX057 fsx-linux -N 10000 -o 8192 -l 500000 -r 4096 -t 2048 -w 2048
-FSX058 fsx-linux -N 10000 -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
-FSX059 fsx-linux -N 10000 -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
-FSX060 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
-FSX073 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40963
-FSX076 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40966
-FSX078 fsx-linux -N 100000
+fsx01 fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000
+fsx02 fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -N 10000
+fsx03 fsx-linux -l 500000 -r 4096 -N 10000
+fsx04 fsx-linux -N 10000
+fsx05 fsx-linux -N 10000 -o 1024
+fsx06 fsx-linux -N 10000 -o 2048
+fsx07 fsx-linux -N 10000 -o 4096
+fsx08 fsx-linux -N 10000 -o 8192
+fsx09 fsx-linux -N 10000 -o 16384
+fsx10 fsx-linux -N 10000 -o 32768
+fsx12 fsx-linux -N 10000 -o 128000
+fsx13 fsx-linux -N 10000 -o 1024 -l 500000 -r 4096 -t 4096 -w 4096
+fsx14 fsx-linux -N 10000 -o 2048 -l 500000 -r 4096 -t 2048 -w 2048
+fsx15 fsx-linux -N 10000 -o 4096 -l 500000 -r 4096 -t 4096 -w 4096
+fsx16 fsx-linux -N 10000 -o 8192 -l 500000 -r 4096 -t 2048 -w 2048
+fsx17 fsx-linux -N 10000 -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
+fsx18 fsx-linux -N 10000 -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
+fsx19 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
+fsx20 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40963
+fsx21 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40966
+fsx22 fsx-linux -N 100000
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
