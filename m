Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A1FC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDA433CA313
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 11:19:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 920DF3C30BB
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 11:19:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34A2F6009E5
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 11:19:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CFFE1F37D;
 Tue,  1 Mar 2022 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646129947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hTJ7ULrOq6IgUSKV/4H0wYlsR0a6bG3lW6Zyf6P0j5M=;
 b=1ASYLzZDrTudeSDSWuMUeaZBFYJ9TY/7Z/ybzL4fHG3PwMob1CZLW1EXZ+Uzb7hTfBKZ8h
 3uzll9aHuAh25wPYQJ4xB/m6F7h6FdoeFnJi2MSTqxR3hDqyZd++MdHCwS0L0oqCr9JclH
 /GJFYeU38vHZ8FHOjB98UGQ18gMxlrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646129947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hTJ7ULrOq6IgUSKV/4H0wYlsR0a6bG3lW6Zyf6P0j5M=;
 b=GM4L8KcJgxb5/X/7KkwfyVLKPp/C4kLQPXC9ICXKwHVGahbsWr7ScDFGZJYM3JrczMg3hR
 8u92qyfU+UNNX/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4318B139F9;
 Tue,  1 Mar 2022 10:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m2/SDhvzHWJedQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Mar 2022 10:19:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  1 Mar 2022 11:19:03 +0100
Message-Id: <20220301101903.22649-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] TESTING PATCH
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

From: Cyril Hrubis <chrubis@suse.cz>

Testing only
---
 testcases/kernel/mem/lib/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 39e3f1791c..ee9fc85b69 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -565,6 +565,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 #endif
 
 		memset(memory[i], 10, length);
+
+		if (mlock(memory[i], length))
+			tst_res(TWARN | TERRNO, "mlock() failed");
 	}
 
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
