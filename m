Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66326CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0DE33CD436
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:43:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB56F3C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:42:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5A0114044A2
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:42:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0D821F74C;
 Thu, 12 Oct 2023 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697103777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9rlr2EIfbuG/sXnJY+AgT0V1Hw8Z9chkKhEGVgsqNA=;
 b=nc5MAZ06Aa8fsC5qDhZ9MZ8e0xCY0k7jEh9DS3s4KrdUVUOgie5lkZr1l0VAdqxqxnWKei
 K9cl6OdbRAbXgXrLon1mjojb+8GrZ0OAfbI10FOwVkJumQ2Wp1a2O2erR18/75zSjyzW3R
 qa3OMc2Vft94BQ1l1B+dK8KwaeTA4q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697103777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J9rlr2EIfbuG/sXnJY+AgT0V1Hw8Z9chkKhEGVgsqNA=;
 b=ckUhJfatffc8fGuWg0u3REVAIZBQ1yRhARMHojzfuo4MnsaAYYrAlkd3yhN1dPfs33SS+Q
 ZRTNPudXIRonQyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90245139ED;
 Thu, 12 Oct 2023 09:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pU0PIqG/J2XgdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 09:42:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 Oct 2023 11:42:54 +0200
Message-ID: <20231012094254.611488-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] README: Document gdb debugging
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 README.md | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/README.md b/README.md
index fa9559398..adeac5fdf 100644
--- a/README.md
+++ b/README.md
@@ -215,6 +215,12 @@ SUSE also publishes a
 [smaller LTP container](https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*)
 that is not based on the Containerfile.
 
+Debugging with gdb
+==================
+
+To get stack trace of a crashing test in gdb it's useful to
+[`set follow-fork-mode child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).
+
 Developers corner
 =================
 
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
