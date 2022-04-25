Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC9CC433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 09:21:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133053C60BA
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 11:21:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E9183C1B37
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 11:21:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D2C8C600147
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 11:21:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 176211F74A;
 Mon, 25 Apr 2022 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1650878491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2v91+0lxhgmJa4H9YUFg65CyLAM/blfMOL0EOWbvT1s=;
 b=qs0jrbG9GHjcsy7vbV7GE8i9BiESthr91YevHPSBr+Yt/kB3zzH9yYE4Jqf64jsprQhBkR
 MMKA2KTb8sCBuVDfk7PoV0ZbjxcwqlN1q0xibuU89ivBRkzb0Fz/EPmd0zAtFEFZ8cjewS
 NSv9N6VWD6ZwqPfIS6vGzOy5Xq74bf8=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id D0EF82C141;
 Mon, 25 Apr 2022 09:21:30 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 25 Apr 2022 10:21:18 +0100
Message-Id: <20220425092118.21619-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sighold02: Fix muslc builds by removing __SIGRTMIN
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The minimum real-time signal is always 32 according to
signal(7). Meanwhile __SIGRTMIN is not defined in all lib C
implementations.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/sighold/sighold02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index daa86192e..1cfb7688b 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -33,7 +33,7 @@ static int sigs_map[NUMSIGS];
 
 static int skip_sig(int sig)
 {
-	if (sig >= __SIGRTMIN && sig < SIGRTMIN)
+	if (sig >= 32 && sig < SIGRTMIN)
 		return 1;
 
 	switch (sig) {
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
