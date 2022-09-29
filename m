Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2238AC433FE
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 19:21:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C4193CA72A
	for <ltp@archiver.kernel.org>; Thu, 29 Sep 2022 21:21:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E672C3C9481
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 21:20:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF15C1401254
 for <ltp@lists.linux.it>; Thu, 29 Sep 2022 21:20:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 980981F88B;
 Thu, 29 Sep 2022 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664479254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kN5MsqmOgjgLsq2aJgbdnalDEsTnx/vGZVhxTEqoXm4=;
 b=pe4yxz0ObF7VSCX0deg0CPvPJgce9a31qDqgfew1UmraZJt35x7/3AeYiskEkAUkKTIo78
 5usLFqChr4TxUyVo3ja0qYey4qf9RRt+3/IG+ZJAWa5xEwMfhqp3n9Thql+CbA+EyV1TgG
 LN6NCQ2xcOvmUl14TqHZrwUCyHyp5co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664479254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kN5MsqmOgjgLsq2aJgbdnalDEsTnx/vGZVhxTEqoXm4=;
 b=RAUWMgCFonFgL5fptLlf6vOU02UurkMHZtwkhd6LhjEMkOb5FLY+29w6pNE9Gb0nXhUCiA
 nj1s2KMbnilbx3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ECF113A71;
 Thu, 29 Sep 2022 19:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j/ajARXwNWPDMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 29 Sep 2022 19:20:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 29 Sep 2022 21:20:47 +0200
Message-Id: <20220929192047.22125-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] zram01.sh: Fix minimal size for XFS on kernel 5.19
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

mkfs.xfs for kernel 5.19 bumps minimum filesystems 300 MB. Due this we
already updated minimal filesystem size for all_filesystems /
$TST_ALL_FILESYSTEMS in 66e05c841. But zram01.sh does not use the API,
thus update it now.

Check for RAM size was added for f18c8fd3a for Btrfs on ppc64le due to
larger page size. Hopefully this is not needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Cyril, Li,

sorry for putting this patch so late (tomorrow we want to release LTP).
Not really sure if RAM check is needed for XFS on ppc64le, any idea?

Kind regards,
Petr

 testcases/kernel/device-drivers/zram/zram01.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 8b92b699f..d126663b6 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -41,10 +41,14 @@ initialize_vars()
 	for fs in $(tst_supported_fs -s tmpfs); do
 		size="26214400"
 		limit="25M"
+
 		if [ "$fs" = "btrfs" ]; then
-			check_space_for_btrfs || continue
+			check_space_for_btrfs "$fs" || continue
 			size="402653184"
 			limit="$((size/1024/1024))M"
+		elif [ "$fs" = "xfs" ]; then
+			size=314572800
+			limit="$((size/1024/1024))M"
 		fi
 
 		stream=$((stream+3))
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
