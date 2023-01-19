Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2836FC004D4
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 11:20:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D26613CD834
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 12:20:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4313CC825
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 12:20:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0294F1000F29
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 12:20:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBF40378D8;
 Thu, 19 Jan 2023 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674127245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZZR3DLD2UB3G9DEKJdvh/ftjhVBh+nC6tYtKWW0yArc=;
 b=c1kWlQIoJSU3bfgXUvWAoUJJmVy9tlAtPqZ0AdBERV0y57GQu/waDnN2VWjnZ7lb10ehgb
 7QON4VP0PBQ4IJsq7leaL8o+ku++5qATKM99TaGSLKXJKf+oTyaBCNnvd1/NNwsvpfjGYe
 ZXxzk47fo+fhyT86CwxZ/1rILrdheRs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FDB7134F5;
 Thu, 19 Jan 2023 11:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xmBZHI0nyWMPOgAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 19 Jan 2023 11:20:45 +0000
To: ltp@lists.linux.it
Date: Thu, 19 Jan 2023 12:18:54 +0100
Message-Id: <20230119111854.13844-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] tools/runltp-ng: Updated to increase stability
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update submodule to e842511 (Cleanup session module).
Include commits:

e842511 ("Cleanup session module")
75c97e8 ("Inject env variables inside SUT via option")
4ad85fb ("Kill qemu properly if communication fails")
99f7e92 ("Stabilize SUT reboot during tests execution")

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/runltp-ng | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/runltp-ng b/tools/runltp-ng
index 99f7e92a6..e842511ed 160000
--- a/tools/runltp-ng
+++ b/tools/runltp-ng
@@ -1 +1 @@
-Subproject commit 99f7e92a6c617223039c7aa2f07f4bef9f1e4486
+Subproject commit e842511ed2c680e3b2ea6dec790913a41d5ed937
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
