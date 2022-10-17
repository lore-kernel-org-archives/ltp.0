Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0906C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 09:43:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBBB33CAFE0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 11:43:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F3813C9F68
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 11:43:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 87A6F1A00780
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 11:43:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D482033960
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665999812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sS1zuBKD01ZvdsJHH+64siwsp9SSGJSeDlL6k6tjEZc=;
 b=Qjzef+2bLnPS7LB0jmWdvZXmMINjcYXuwm9m90hy87EJac4rHNDKZyEusjJn6iNsKmcy6g
 Ae0Efn1tSeOtZ9vb+s+Hb3Wz+ZvVmPCr3zOA/5WsIJSMMB/8uEKsiLTG1aY9OFFeCI2Cb7
 lLOuvaG/dLFJy7SLntDyfibnM6Arf5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665999812;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sS1zuBKD01ZvdsJHH+64siwsp9SSGJSeDlL6k6tjEZc=;
 b=Cu3tNGZ38Npo2phW2v2OOwm41s3IJlev1IhhxnUM1Xj81tWFzJdWXT/6eLlff8V1zdxoRn
 hz+uuMfO8ETPLZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8EF213398
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H4xeKsQjTWNJTQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 09:43:32 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Oct 2022 11:43:32 +0200
Message-Id: <20221017094332.26952-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_core01: Add CVE reference
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
 testcases/kernel/controllers/cgroup/cgroup_core01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
index fc60ae5aa..8b6243f7c 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -102,6 +102,7 @@ static struct tst_test test = {
 	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "e57457641613"},
+		{"CVE", "2021-4197"},
 		{}
 	},
 };
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
