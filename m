Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC90C6FA90
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 15:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0297F3CAD50
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 17:50:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D8AE3CAD35
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:50:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B4B61A0117B
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:50:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C4991F8E4
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663775418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=As5Pk50TRpvJmkaMskmp9OB0lKP5SYR8hqx3vtFUHiE=;
 b=SM7ft46IvBicWIYiRNTKvLo5jKggUGHkp2uKVTRw73zj7EQIH8v+xCQai+9dwltDuS+FW0
 tGX6TTYSFaewWeF9XJ6jShGcFfGGZ8R354w59SYHqABsSUW4PgaC/i27/P4pGGYTrNYCFV
 YNMRGvXGcVhxM07x5eIsM+NwvJDb9As=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663775418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=As5Pk50TRpvJmkaMskmp9OB0lKP5SYR8hqx3vtFUHiE=;
 b=YGj+1qhkM7KX2pIim8yVU67WQJshIDw7byO4/vN+YgONA4V8fLgQT1myrdchFjMyD+2NtU
 F3C65FqdWbhfFXDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EEA013A00
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 15:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H0JzCroyK2PAeAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 15:50:18 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 21 Sep 2022 17:50:17 +0200
Message-Id: <20220921155017.13394-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_fs_type_name(): Add VFAT support
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_fs_type.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 78944efcf..d9c9c0817 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -68,6 +68,8 @@ const char *tst_fs_type_name(long f_type)
 		return "overlayfs";
 	case TST_FUSE_MAGIC:
 		return "fuse";
+	case TST_VFAT_MAGIC:
+		return "vfat";
 	case TST_EXFAT_MAGIC:
 		return "exfat";
 	default:
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
