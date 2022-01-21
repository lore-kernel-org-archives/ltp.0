Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D0AC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:41:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D7FF3C96FA
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:41:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1564A3C96DE
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:40:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D718260032D
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:40:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 770AD1F3B4;
 Fri, 21 Jan 2022 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642772457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTGJTrq8qAR3HxlU3CIjgzW2CMwRylaVL1t0u5JBiuo=;
 b=pYbzuWlMDJVGpYAf3jsAr6x9/lm+BZt8178P0o1q4jGT5/uZEnFwkv7VHEGwisNkn8ooKS
 zOI9voH3hr7ktlVfqh0c37r2lqIU9lZ9DU1KWV1M38wYTLDhyQQc/xV8W5ZLwOaE/0PP+A
 PleXbbG9+5P4W1ruTn2ZWT3O3ykXadw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642772457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTGJTrq8qAR3HxlU3CIjgzW2CMwRylaVL1t0u5JBiuo=;
 b=36hfQYV7XYxOZwdrCqAuhJnG1JrbOefCRZCjyFyjj6PXBsj7xt55h9q/pKhizs1bTh26za
 5k3rhkAYXalPnmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AF8813D22;
 Fri, 21 Jan 2022 13:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YDnBBOm36mF6UAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 13:40:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jan 2022 14:40:52 +0100
Message-Id: <20220121134052.30048-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121134052.30048-1-pvorel@suse.cz>
References: <20220121134052.30048-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [v2 PATCH 2/2] dio_sparse: Set timeout 30 min
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

Originally only ADSP075 failed (dio_sparse  -w 518192k -s 518192k -n 1000)
but just in case increase timeout for all newly rewritten tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
Prolong the timeout only for dio_sparse (Martin)

Kind regards,
Petr

 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 39fc895d65..0039daa8d1 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -135,4 +135,5 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
+	.timeout = 1800,
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
