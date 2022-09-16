Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A623ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 16:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2F9E3CAC7A
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 18:07:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0373CA7AF
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 18:07:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2D68914044CD
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 18:07:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF5C020905
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663344447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Hnr7rAi7Y2IZySmX5Igk1FhGLQ1UKDItw/UsDESMec=;
 b=h9PGEstzNUr5LWMBML/TDRDROYtTy74gNv7rZ8as1D5uVlbv5ULvcZaBDgyiEcVsNv8c40
 vCQclrSxfZcrh3HdcvPECHpbVQbHOmPagTLCz3T419a4HqfbRMnKdUV8TEhUMWu1uS25Py
 yx1tq+STSXT94bTgeucIsgZHf4Mu4Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663344447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Hnr7rAi7Y2IZySmX5Igk1FhGLQ1UKDItw/UsDESMec=;
 b=ocgi8qnWhKJWTVjWM/5bZTePQnKIqtLeFMmHbnlH9aFr/B1OiDza9ICQv/gKPqjXErjnXl
 YsN+tXFNZ/XanDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDB891346B
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kEhBMT+fJGNGfQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:07:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 Sep 2022 18:07:26 +0200
Message-Id: <20220916160726.12797-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916160726.12797-1-mdoucha@suse.cz>
References: <20220916160726.12797-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] request_key03: Add max_runtime and make children
 runtime-aware
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/request_key/request_key03.c      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index cb256f41e..464fcd8a4 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -100,6 +100,11 @@ static void run_child_add(const char *type, const char *payload, int effort)
 
 		if (TST_RET < 0)
 			tst_brk(TBROK | TTERRNO, "unable to clear keyring");
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "add_key() process runtime exceeded");
+			break;
+		}
 	}
 }
 
@@ -116,6 +121,12 @@ static void run_child_request(const char *type, int effort)
 				"unexpected error requesting key of type '%s'",
 				type);
 		}
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO,
+				"request_key() process runtime exceeded");
+			break;
+		}
 	}
 }
 
@@ -201,6 +212,7 @@ static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.forks_child = 1,
+	.max_runtime = 20,
 	.options = (struct tst_option[]) {
 		{"b:", &opt_bug,  "Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
 		{}
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
