Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9355AC6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B643CCB1B
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 15:19:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D70A3CCB07
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABF66600AD1
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67C941FD68
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680009506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2TYLaVZnTAqTsMW/tTKdR+fBQGVrgWBOB97GaQH/KU=;
 b=NnAw8XL2XCS6RgrK+SGIOQbOAkrpI+WP5wRizYokoKVmn6HQv5hVQPkMLplb1djW7Vanx7
 Bo7J5cP7RFJY3c+1Vt9zaf3ROYuH/zzMVs9fi17bN0qXSYirC3waQBJAm+n4RNNCvwYNi6
 2Mv+B4U8raLzNnpZkGEoF+2zStLHjdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680009506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2TYLaVZnTAqTsMW/tTKdR+fBQGVrgWBOB97GaQH/KU=;
 b=N8Wtn2U1YT5DS+uk8OpUVMuBnrMBLSQqPVvCKArvWykZMYJ1zSW8yJJ3kodB/7EPJrnpJF
 pNXazM9cu6XNgWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5886E1390D
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YgU9FCLpImQdUQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:26 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 15:19:35 +0200
Message-Id: <20230328131935.21945-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328131935.21945-1-chrubis@suse.cz>
References: <20230328131935.21945-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] lib: tst_device: Constify array members
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

tst_device.c:40: WARNING: static const char * array should probably be static const char * const
tst_device.c:46: WARNING: static const char * array should probably be static const char * const

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index a4dfda5ba..d659b54cf 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -37,13 +37,13 @@ static char dev_path[PATH_MAX];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
 
-static const char *dev_loop_variants[] = {
+static const char * const dev_loop_variants[] = {
 	"/dev/loop%i",
 	"/dev/loop/%i",
 	"/dev/block/loop%i"
 };
 
-static const char *dev_variants[] = {
+static const char * const dev_variants[] = {
 	"/dev/%s",
 	"/dev/block/%s"
 };
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
