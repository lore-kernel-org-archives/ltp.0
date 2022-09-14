Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125D3ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 16:20:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F16B93CAC03
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 18:20:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B00943CABD0
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 18:19:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B9991000F52
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 18:19:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBF5C33B91
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663172371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bmXSaFEG0ZUIEsR1mXGaWvVMZlDDTE7mADi/1hrZc4=;
 b=05BCBfiWF+pnP/hqQFMAbNDW0BxJW2BYkG4f6BjwZzVUBIz9RB7CKwrl/RHoBm+Iy2G7bb
 G174qOMNzgRls1l8menYEQCdUGjXHBKg6bZgUnswkist+dOTzirwmSJACYfWtBs0puULTt
 eqlrM9kIRTdJe6iwwJCPFrRqjOFG1MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663172371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bmXSaFEG0ZUIEsR1mXGaWvVMZlDDTE7mADi/1hrZc4=;
 b=yqZbvIx31VrC0VaFfrectj5vTitolJyikaJB46BU/TAoGR2wSh3GVNEtLz2y3qTr44458B
 k/KSe923kwS6cUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3021134B3
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UPXGKhP/IWMwYgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Sep 2022 18:19:30 +0200
Message-Id: <20220914161930.27681-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914161930.27681-1-mdoucha@suse.cz>
References: <20220914161930.27681-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] sendfile09: Add max_runtime
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

Changes since v1:
- Changed max_runtime from 20 to 120

 testcases/kernel/syscalls/sendfile/sendfile09.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 320649dcd..07c43eb59 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -97,6 +97,7 @@ static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
 	.min_kver = "2.6.33",
+	.max_runtime = 120,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "5d73320a96fcc"},
 		{}
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
