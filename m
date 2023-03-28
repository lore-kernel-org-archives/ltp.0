Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419DC6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FA033CCB36
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01C283CA2F9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB3E61A0119D
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:18:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35B371FDCF
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680009505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GOGUpvCCIgzJmtv15aP/IzfEgxbyqsJDAP/lXf6yRo=;
 b=19wDWaFrYdy2FZ/SSrgVR410TI5O012/i7d6P5OC4KDdt3bZ/oRYfLNMT2hT77u31TFgHO
 /UlpzAg8LPHkle+qyaacizdtE5D4eboDNUGiH2yFj/u6JSyfN6uYDe6hT+rsa6Jh3icuZE
 yFppeGnsMUpK7SKmwjaGjpLnoG5AYPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680009505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GOGUpvCCIgzJmtv15aP/IzfEgxbyqsJDAP/lXf6yRo=;
 b=ce1V7GTVLY/ai6mJ/icEA5qmCukkkzsJ/Q2za/7AF/BXwZv+P4A61v7XQ+eZ8dReG1bBZD
 haSraiJ37t5RoUCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2060C1390D
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ytaXBiHpImQWUQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:18:25 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 15:19:33 +0200
Message-Id: <20230328131935.21945-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328131935.21945-1-chrubis@suse.cz>
References: <20230328131935.21945-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] lib: tst_device: Make find_stat_file() static
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

tst_device.c:486:5: warning: LTP-003: Symbol 'find_stat_file' is a public library function, but is missing the 'tst_' prefix

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 0cdd8985e..1f5a95eb9 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -483,7 +483,7 @@ int tst_is_mounted_at_tmpdir(const char *path)
 	return tst_is_mounted(mpath);
 }
 
-int find_stat_file(const char *dev, char *path, size_t path_len)
+static int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
 
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
