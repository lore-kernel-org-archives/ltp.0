Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988BEECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 13:50:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C3DF3CA6BA
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 15:50:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 146F63CA64D
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88B75600672
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56EC31FA9C
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661867408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIjAU1/fGTSpvjL9Rzl3hM2SGCqsdl+ZreuIbKA0d7E=;
 b=m6F0zpLNYRHI53ImocxOt+97Um5Ulc8JdWo6FULNy+hupZy4akCCLlb8hy9GwY6CQtQQQ8
 lJXplaBdEmQY+y6mYcZaIikLmpvR740iT/CYcJSNf0D5ZzEAeqJCkB2aywuFWytbiMDkih
 MGl6xMQldcfNLAtiFSzrfk0gLx5Et9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661867408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIjAU1/fGTSpvjL9Rzl3hM2SGCqsdl+ZreuIbKA0d7E=;
 b=gYd3CZbTL6/GXnHfBwMbUp9e+eJUwxoboQU3Y/Nm5+22G3hyHiHkdUi4d4S+5Ncvb9rjt0
 8KqQImpr+fM8+fBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39A9113B21
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SN4IDZAVDmOfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 15:49:58 +0200
Message-Id: <20220830135007.16818-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830135007.16818-1-mdoucha@suse.cz>
References: <20220830135007.16818-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/10] syscalls/pty06: Add CVE reference
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
 testcases/kernel/pty/pty06.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
index 7e0f4233c..cc95eb1a8 100644
--- a/testcases/kernel/pty/pty06.c
+++ b/testcases/kernel/pty/pty06.c
@@ -99,7 +99,8 @@ static struct tst_test test = {
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.max_runtime = 150,
 	.tags = (const struct tst_tag[]) {
-	    { "linux-git", "ca4463bf8438"},
+	    {"CVE", "2020-36557"},
+	    {"linux-git", "ca4463bf8438"},
 	    {}
 	}
 };
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
