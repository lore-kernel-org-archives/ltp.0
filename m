Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC16ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 13:51:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 057703CA701
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 15:51:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 368EB3CA69D
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A0FB200142
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75F5C1FA9E
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661867408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4A9SwdtbH20fMR/wmugiVz/FgA/KrCP1I+g0ZmDlUQ=;
 b=zCpmUT5YugNyYCLRpE682dryvdKf3P0sAlLnfyWExVDiuScT7mMIcW+I9DezD8pB7LYED9
 0ykkX/wMGfYHidiqmowQdXDEc9GPBnU6a/FmHXOaT7b+12YcCBcOPobbxeF/WLCdJYJr/S
 bs7QfufjAbiMLmiTFLF7bikKPGmAQJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661867408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4A9SwdtbH20fMR/wmugiVz/FgA/KrCP1I+g0ZmDlUQ=;
 b=E1vcwAgmQos5pVTo/svjecTOBVFo7LGEwdeuOYqsBcgqoM5IDki+EqQxVyZ7/yh0K1rLjb
 ZqUKhrvhIo4eLhBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A8B413ACF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4EQlFZAVDmOfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 15:49:59 +0200
Message-Id: <20220830135007.16818-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830135007.16818-1-mdoucha@suse.cz>
References: <20220830135007.16818-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/10] cve-2017-2671: Increase max_runtime
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

The current max_runtime is insufficient to finish the race. Increase it.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/cve-2017-2671.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index e17cd9765..9092481de 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -109,7 +109,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 20,
+	.max_runtime = 40,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "43a6684519ab"},
 		{"CVE", "2017-2671"},
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
