Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C2C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 13:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573FE3CA9CC
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 15:08:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9E43CA9A2
 for <ltp@lists.linux.it>; Thu, 12 May 2022 15:07:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 940671000B54
 for <ltp@lists.linux.it>; Thu, 12 May 2022 15:07:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95C011F460
 for <ltp@lists.linux.it>; Thu, 12 May 2022 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652360868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7x6VmZZMlJFHSN33THTWZaLi8bH/8IzbTYK4HNDA/4=;
 b=pr1oVBfmO5yD3lYXDa35BiBlYhi8XR/f3epciy6sjyVBDnUW/OUWIsiBRhrT3MyQp479r2
 w2D2tFlrS3CJLKREeOzro5x9ionC8jZJwGB6PfJvJWBwSjUdKxJTAcFdHo430WPbllj/oa
 MOMUgkrHQQJWIhjBfsPvghvVGL9oW+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652360868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7x6VmZZMlJFHSN33THTWZaLi8bH/8IzbTYK4HNDA/4=;
 b=iEXXhAPaVCXPpjcPH5ftrgkmiaRcIbpGf07NmArMy0zB2UiqdQNgC142n0yaUzAMgPXgaa
 hdFbHTg97ip6PTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AB5313ABE
 for <ltp@lists.linux.it>; Thu, 12 May 2022 13:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5C+FHKQGfWITKwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 12 May 2022 13:07:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 15:10:02 +0200
Message-Id: <20220512131002.26093-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] waitid10: raise SIGFPE directly
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

The SIGFPE for division by zero is actually not send for quite a few
architectures (ARM for instance) and even on x86 and x86_64 we need to
work around compiler to make it generate code that actually triggers the
condition.

So this patch fixes the test in the simplest way possible. the child
just directly raises SIGFPE instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitid/waitid10.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index e75edd07e..388b31cc9 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -24,12 +24,8 @@ static void run(void)
 	pid_t pidchild;
 
 	pidchild = SAFE_FORK();
-	if (!pidchild) {
-		volatile int a, zero = 0;
-
-		a = 1 / zero;
-		exit(a);
-	}
+	if (!pidchild)
+		raise(SIGFPE);
 
 	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
 	TST_EXP_EQ_LI(infop->si_pid, pidchild);
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
