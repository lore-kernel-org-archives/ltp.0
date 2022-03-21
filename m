Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E26AC433EF
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 13:36:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09B483C7969
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 14:36:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79D063C07B5
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 14:36:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D222D6008AF
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 14:36:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB7011F37C
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647869792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3XIRuY1NoLCkvVriaBEmeq2mjmDHX/UbCV5bhmcekgo=;
 b=S16pC44oFCashLoDyShMAfDoz8vEBPyz0Ogtx+g/wSklvVLA6Qy9cQ76PPjRJ6guLv8JId
 yNWRfz+h7nfqdtnAOGpt78S8lp8W9ckyFKzBVen4hayhfxDS7trzauVbSYI5T834QT+cyl
 dgO0RrorvoJzn51PHjFWKcZt/SnAXho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647869792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3XIRuY1NoLCkvVriaBEmeq2mjmDHX/UbCV5bhmcekgo=;
 b=cGvFydbFI9R3ov1pbYEXMYiJVAtTXuUnMcmvjLtU/zAVGzg6jzBrV0dp9uvX+omo5sRZWK
 RatCS9RrOuKglpBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A893013AD5
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 13:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eABGKGB/OGLPWgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 13:36:32 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 21 Mar 2022 14:38:49 +0100
Message-Id: <20220321133849.14924-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] waitid10: Fix when coredumps are piped
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

When coredumps are piped into a stdin of a program (the core_pattern
starts with '|') the RLIMIT_CORE limits are not enforced.

This fixes the test expectation in the corner case that rlim_cur and
rlim_max for RLIMIT_CORE are both set to 0 but the core pattern is set
to dump core into a pipe where we previously assumed the core wouldn't
be dumped.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 869ef18bd..e75edd07e 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -45,14 +45,17 @@ static void run(void)
 static void setup(void)
 {
 	struct rlimit rlim;
+	char c;
 
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
+	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
 
 	if (rlim.rlim_cur)
 		return;
 
 	if (!rlim.rlim_max) {
-		core_dumps = 0;
+		if (c != '|')
+			core_dumps = 0;
 		return;
 	}
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
