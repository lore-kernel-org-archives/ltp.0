Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5978C4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 18:32:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A3253CDB4D
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:32:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D577D3CB385
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BD321A0C25B
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 737C61F846;
 Fri, 15 Dec 2023 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eNWGVgDbhA84fJj8mV9nSZ5j4rB1cUapbBz5jnsyfk=;
 b=Sj5bkjmL0klO9BiyzOqmNgll5LKV8/b76tlpnwO3YO70WR+2SXEjDnJw1WQrlLJUismrf+
 YvbYA/yVZPrly7JPp3xvQ91vOMIwrp9LEYWmTiw96KMUSOiPYN6WnnPO2x/0qBp+NAzOft
 b4K+tpLvrqm87uKrTo05WOT5nQ3J2WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eNWGVgDbhA84fJj8mV9nSZ5j4rB1cUapbBz5jnsyfk=;
 b=QvcQVUMN3v0uvRVw27T3+oTe7LLgYmNGZLPqvvcV4RFO4qvBhc2sMG9HSG87iJbCn2kz02
 H4bEFAs6bT2MOkAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eNWGVgDbhA84fJj8mV9nSZ5j4rB1cUapbBz5jnsyfk=;
 b=Sj5bkjmL0klO9BiyzOqmNgll5LKV8/b76tlpnwO3YO70WR+2SXEjDnJw1WQrlLJUismrf+
 YvbYA/yVZPrly7JPp3xvQ91vOMIwrp9LEYWmTiw96KMUSOiPYN6WnnPO2x/0qBp+NAzOft
 b4K+tpLvrqm87uKrTo05WOT5nQ3J2WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eNWGVgDbhA84fJj8mV9nSZ5j4rB1cUapbBz5jnsyfk=;
 b=QvcQVUMN3v0uvRVw27T3+oTe7LLgYmNGZLPqvvcV4RFO4qvBhc2sMG9HSG87iJbCn2kz02
 H4bEFAs6bT2MOkAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3927913A08;
 Fri, 15 Dec 2023 18:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kH+EDHybfGW2LwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 18:31:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Dec 2023 19:31:20 +0100
Message-ID: <20231215183121.57632-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215183121.57632-1-pvorel@suse.cz>
References: <20231215183121.57632-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] runtest/ltp-aiodio.part3: Keep only unique records
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

When ltp-aiodio.part3 was added in f5fb66199, it contained & to run
some of the tests in paralel. It might never worked as expected (it was
removed in 7df75e26a, added again in 01bca9a82 and finally removed in
2a61af975).

But now, after fsx-linux rewrite in 134b08362 there is no
reason to repeat tests (tests in runtests run sequentially),
thus do a final cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ltp-aiodio.part3 | 45 ++++++++--------------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/runtest/ltp-aiodio.part3 b/runtest/ltp-aiodio.part3
index 65931ddf4..2389e7d64 100644
--- a/runtest/ltp-aiodio.part3
+++ b/runtest/ltp-aiodio.part3
@@ -2,10 +2,6 @@ FSX032 fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -N 10000
 FSX033 fsx-linux -l 500000 -r 4096 -t 2048 -w 2048 -N 10000
 FSX034 fsx-linux -l 500000 -r 4096 -N 10000
 FSX035 fsx-linux -N 10000
-FSX036 fsx-linux -N 10000
-FSX037 fsx-linux -N 10000
-FSX038 fsx-linux -N 10000
-FSX039 fsx-linux -N 10000
 FSX040 fsx-linux -N 10000 -o 1024
 FSX041 fsx-linux -N 10000 -o 2048
 FSX042 fsx-linux -N 10000 -o 4096
@@ -13,36 +9,13 @@ FSX043 fsx-linux -N 10000 -o 8192
 FSX044 fsx-linux -N 10000 -o 16384
 FSX045 fsx-linux -N 10000 -o 32768
 FSX046 fsx-linux -N 10000 -o 128000
-FSX047 fsx-linux -N 10000 -o 1024
-FSX048 fsx-linux -N 10000 -o 2048
-FSX049 fsx-linux -N 10000 -o 4096
-FSX050 fsx-linux -N 10000 -o 8192
-FSX051 fsx-linux -N 10000 -o 16384
-FSX052 fsx-linux -N 10000 -o 32768
-FSX053 fsx-linux -N 10000 -o 128000
-FSX054 fsx-linux -N 10000  -o 1024 -l 500000 -r 4096 -t 4096 -w 4096
-FSX055 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048
-FSX056 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096
-FSX057 fsx-linux -N 10000  -o 8192 -l 500000 -r 4096 -t 2048 -w 2048
-FSX058 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
-FSX059 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
-FSX060 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
-FSX061 fsx-linux -N 10000 -o 32768
-FSX062 fsx-linux -N 10000 -o 128000
-FSX063 fsx-linux -N 10000  -o 1024  -l 500000 -r 4096 -t 4096 -w 4096
-FSX064 fsx-linux -N 10000  -o 2048 -l 500000 -r 4096 -t 2048 -w 2048
-FSX065 fsx-linux -N 10000  -o 4096 -l 500000 -r 4096 -t 4096 -w 4096
-FSX066 fsx-linux -N 10000  -o 8192  -l 500000 -r 4096 -t 2048 -w 2048
-FSX067 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
-FSX068 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
-FSX069 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
-FSX070 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
-FSX071 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
-FSX072 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
-FSX073 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 40963
-FSX074 fsx-linux -N 10000  -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
-FSX075 fsx-linux -N 10000  -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
-FSX076 fsx-linux -N 10000  -o 128000 -l 500000 -r 4096 -t 4096 -w 40966
-FSX077 fsx-linux -N 10000
+FSX054 fsx-linux -N 10000 -o 1024 -l 500000 -r 4096 -t 4096 -w 4096
+FSX055 fsx-linux -N 10000 -o 2048 -l 500000 -r 4096 -t 2048 -w 2048
+FSX056 fsx-linux -N 10000 -o 4096 -l 500000 -r 4096 -t 4096 -w 4096
+FSX057 fsx-linux -N 10000 -o 8192 -l 500000 -r 4096 -t 2048 -w 2048
+FSX058 fsx-linux -N 10000 -o 16384 -l 500000 -r 4096 -t 4096 -w 4096
+FSX059 fsx-linux -N 10000 -o 32768 -l 500000 -r 4096 -t 2048 -w 2048
+FSX060 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 4096
+FSX073 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40963
+FSX076 fsx-linux -N 10000 -o 128000 -l 500000 -r 4096 -t 4096 -w 40966
 FSX078 fsx-linux -N 100000
-FSX079 fsx-linux -N 100000
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
