Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B772AC433FE
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 17:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970023CDD73
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 18:53:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 664FD3CDA7A
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 18:52:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1566010005B4
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 18:52:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 054F11FA98;
 Thu, 10 Nov 2022 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668102763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baLdQRoRc3sHwrjh0eFb2TMYrf7uQKqTJjs46N5GiQU=;
 b=pE2E4wzLxJQpYDQSSZvTYJIkkv2Nu11/8zSQpJY1Drb8C+sCRyRMOApruC5YO97tTjZyQV
 akUtrSsVE+G9OF4RZldF5EdNF5IIng4SLYOnRTOeFvY1jqXSg1flKipkmvyMMjwu22UDxC
 dcxlDsijLWFJ8wzXgyKhzdZJ3ZJjkHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668102763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baLdQRoRc3sHwrjh0eFb2TMYrf7uQKqTJjs46N5GiQU=;
 b=fzqIMeWpADi8/a6crzM8VMB89/VD0r26chuNovC6L4UYpiqkHhDXZXR/reNPUybHXnuxXd
 tsEe6UxmMlYU1tBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5324413B58;
 Thu, 10 Nov 2022 17:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kCxlEGo6bWM0GgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Nov 2022 17:52:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 18:52:36 +0100
Message-Id: <20221110175236.32094-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221110175236.32094-1-pvorel@suse.cz>
References: <20221110175236.32094-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc/c-test-api.txt: Improve
 tst_find_backing_dev() doc
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>,
 Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Doc added in 606903cf8 was too complicated. Also there was repeating
sentence, typo 'unevent'.

While at it, fix also 'voud' typo from 9343d0486.

Fixes: 606903cf8 ("c-test-api: Documentation updated")
Fixes: 9343d0486 ("tst_device: Add new api tst_find_backing_dev(path, dev)")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 8844d9f2f..834a342fd 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1075,12 +1075,9 @@ is created for that intention.
 void tst_find_backing_dev(const char *path, char *dev);
 -------------------------------------------------------------------------------
 
-This function finds the block dev that this path belongs to, it uses stat function
-to get the major/minor number of the path.
-This function finds the block dev that this path belongs to, it uses the unevent
-file in sysfs to find the device name. It needs to discriminate between btrfs
-and not btrfs. For non btrfs filesystems it uses the minor, major numbers. For
-btrfs it uses the fs uuid.
+This function finds the block dev that this path belongs to, using uevent in sysfs.
+For Btrfs it uses '/sys/fs/btrfs/UUID/devices/DEV_NAME/uevent'; for other
+filesystems it uses '/sys/dev/block/MAJOR:MINOR/uevent'.
 
 [source,c]
 -------------------------------------------------------------------------------
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
