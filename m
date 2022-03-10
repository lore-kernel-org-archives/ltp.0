Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E26C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09D4D3C61C9
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:53:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1038B3C0209
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:53:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AE961A011D9
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:53:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53B0E210EE
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646909595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lXm8dtyWyMzTP9FlYbn/u3n/0UuMR/gOJw9P09vVp1Q=;
 b=mrZ59vOFC6klErIqjFWvASFu9hwHB7Afs/r0bHahsyNkZhLy0ois9H8aNuMpbfsuYER+k/
 6GRF7zO7nWOPtrTxP0XkEH1DR906ijuvN88PMx+3SEzTwPLHyOKS5mEMvobaH9J1L4GfvS
 OJtlVXa1l/dolaMCQcAuaOVtOMdqucM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646909595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lXm8dtyWyMzTP9FlYbn/u3n/0UuMR/gOJw9P09vVp1Q=;
 b=mE4YUW958CSdwxjmJN85Z/jVvZI7kbQDQte9rnqBpXipVbJ4+oIHkUiml2y7uXQugqkOIB
 yojrUKHHqWqUbHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39C8B13A3D
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9IYsDZvYKWL7ewAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:53:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:55:33 +0100
Message-Id: <20220310105533.3012-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/waitid10: Fix on ARM, PPC and possibly others
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

While integer division by zero does trap on x86_64 and causes the SIGFPE
signal to be delivered it's not the case on all architecutes. At least
on ARM and PPC64LE division by zero simply returns undefined result
instead.

This patch adds raise(SIGFPE) at the end of the child as a fallback to
make sure the process is killed with the right signal on all
architectures.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 869ef18bd..8c351d120 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -28,7 +28,10 @@ static void run(void)
 		volatile int a, zero = 0;
 
 		a = 1 / zero;
-		exit(a);
+
+		tst_res(TINFO, "Division by zero didn't trap, raising SIGFPE");
+
+		raise(SIGFPE);
 	}
 
 	TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
