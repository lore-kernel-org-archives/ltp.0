Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2913EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 14:36:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C58063CAE14
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 16:36:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0654B3C01A5
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:36:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F4811000BD6
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 16:36:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F18A1F74C;
 Fri, 21 Jul 2023 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689950164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kE+uhjl2fF2+O5VwVtsyHJTinfZaGnDBueBI/2XnVXc=;
 b=LlIdmRLVZ1ENwY8/+J4lgNk0w7GQKH4owvU0OtH7RbPz//1dJrd2qNc902ElclO685jkKw
 mcVBPmTgxdL4uA/Jq4T8G58nh4kE9YNN75zEk+UP2nP8DqNX7uvhQtgxM7SlzOgx//4C5Y
 R6goWCliIl+AelC1pnUt4N1DJM0rfTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689950164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kE+uhjl2fF2+O5VwVtsyHJTinfZaGnDBueBI/2XnVXc=;
 b=dYCvJZON6bJXpWXz2L5ujtvXVYfpMSvhrxV7GoN0SShIKgpslsrRpGSdw/SYBLgEh/zuQW
 gBPc5r72OlYeEdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94939134BA;
 Fri, 21 Jul 2023 14:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gHyDINOXumSdEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 14:36:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 16:35:55 +0200
Message-Id: <20230721143555.1433034-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721143555.1433034-1-pvorel@suse.cz>
References: <20230721143555.1433034-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] userns03: Use correct macro
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

TST_EXP_FAIL2() must be used for write(), as not only 0 would be a
failure, but also >= 0 (the number of written bytes).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/containers/userns/userns03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index 4dd3f1a73..a7f12e3d9 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -156,7 +156,7 @@ static void run(void)
 		tst_res(TINFO, "Check if setgroups can be re-enabled");
 
 		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		TST_EXP_FAIL(write(fd, "allow", 5), EPERM);
+		TST_EXP_FAIL2(write(fd, "allow", 5), EPERM);
 		SAFE_CLOSE(fd);
 
 		sprintf(path, "/proc/%d/setgroups", cpid2);
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
