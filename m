Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB25CC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 10:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC28B3CAC76
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 12:29:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8934A3C075E
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 12:29:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E25CB1001362
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 12:29:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A0C7219B7;
 Thu,  6 Oct 2022 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665052145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dCxZAzrWiTziPlQ05zGXPr67VriNqUjx+fx/aUuIfdc=;
 b=pfeOR3NvhmagUoGWOB31/6NDm1RymL+ECRrHD8365YHmHmGS1semXmySW2ubYG0Iw4A+ct
 2z4FmovNzmwQGttXjfHjI4fuEd2WpTtTHYvBBIhCv+8vrwTIAT7twxPu8a0uik/4CZNQQV
 Zdc41lVBryXvk6Vlt/Bz+I4Vrogt0wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665052145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dCxZAzrWiTziPlQ05zGXPr67VriNqUjx+fx/aUuIfdc=;
 b=27/2heuCr563wG16pab/NxAEoFMs55fTV0STbifg1VkLOR2DItmpgVjCkq6viwEnEJHGY+
 M50CxGSgwHcN8jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4382313AC8;
 Thu,  6 Oct 2022 10:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EV97DvGtPmMAcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Oct 2022 10:29:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Oct 2022 12:29:00 +0200
Message-Id: <20221006102900.3246-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Improve .skip_filesystems documentation
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64ee3397f..2865160cc 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -894,6 +894,15 @@ If test needs to adjust expectations based on filesystem type it's also
 possible to detect filesystem type at the runtime. This is preferably used
 when only subset of the test is not applicable for a given filesystem.
 
+NOTE: ext2, ext3 or ext4 in '.skip_filesystems' on tests which does *not* use
+      '.all_filesystems' needs to be defined as 'ext2/ext3/ext4'. The reason
+      is that is hard to detect used filesystem due overlapping the functionality.
+      OTOH tests which use '.skip_filesystems' *with* '.all_filesystems' can skip
+      only filesystems which are actually used in '.all_filesystems': ext2, ext3,
+      ext4, xfs, btrfs, vfat, exfat, ntfs, tmpfs (defined in 'fs_type_whitelist[]').
+      It does not make sense to list other filesystems.
+
+
 [source,c]
 -------------------------------------------------------------------------------
 #include "tst_test.h"
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
