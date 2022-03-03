Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ACAC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 15:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD5553CA33A
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 16:31:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE983CA323
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 16:31:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D91C600D75
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 16:31:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F2722199B;
 Thu,  3 Mar 2022 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646321492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKjfK6AGsoyy7CINqW7RcS+DJDN2WQk0cEG9Hi4+bK4=;
 b=ZB5NkxEBlh2H1iD8wn331NLNUrcWiK1WusP35dektmzAjLGL65VvvEWLjbPJ1vAP95joZm
 bz9373NfPRaOapx0YVSFJ3G540/9f2R8jpZB0iRbTHAbihZrGkrpORdczyzYCkjpAJLIHo
 WSIJrXLtL7b0QXXvFprQZ4a4BLuiV/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646321492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKjfK6AGsoyy7CINqW7RcS+DJDN2WQk0cEG9Hi4+bK4=;
 b=OeeENUroyS7tH4kWlDPN4X+vfWfkXTBGrTVAzj2yVzqx2ci3owiMO7Bg61J0T6pcWaG2Po
 3ygs9OGFcnHZ7dAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85EBA13C23;
 Thu,  3 Mar 2022 15:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8J2xH1TfIGJtFwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 03 Mar 2022 15:31:32 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>,
	ltp@lists.linux.it
Date: Thu,  3 Mar 2022 16:31:31 +0100
Message-Id: <20220303153131.3372-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303153131.3372-1-mdoucha@suse.cz>
References: <20220303153131.3372-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup() exits
 early
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

When setup() exits with TCONF before TESTDIR1 gets created, cleanup() will
trigger TWARN when it tries to delete it. Check whether the directory exists
before calling SAFE_RMDIR().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl06.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 8e9a17393..d470486d5 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -207,7 +207,9 @@ static void setup(void)
 static void cleanup(void)
 {
 	SAFE_UNLINK(USRPATH);
-	SAFE_RMDIR(TESTDIR1);
+
+	if (!access(TESTDIR1, F_OK))
+		SAFE_RMDIR(TESTDIR1);
 }
 
 static struct tst_test test = {
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
