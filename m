Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20A1C00140
	for <ltp@archiver.kernel.org>; Sun, 31 Jul 2022 16:03:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158253C8D6D
	for <ltp@archiver.kernel.org>; Sun, 31 Jul 2022 18:03:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374B93C87C6
 for <ltp@lists.linux.it>; Sun, 31 Jul 2022 18:03:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E932A20033C
 for <ltp@lists.linux.it>; Sun, 31 Jul 2022 18:03:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67A2F3467B;
 Sun, 31 Jul 2022 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659283396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p4L9Qkd2gdeZ2TNlApycON4Ljo8qjwPh+92ALTu8HKo=;
 b=YDoTbujcwwHRz5Q6fofAISJonEbTpb6131qvgeAOeVm8Prxfh1BMdBN7Pwj0Ee75SYFQNO
 VPOSlG1reaSloOBbl1TZ14ZybzzlOSXgsTaVt1+dggF7OZgUeoGRzUjayXaxGN2m0ZvlSr
 qOSnLq4bdxqhU1lCKcli+hjhoaGLItQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659283396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p4L9Qkd2gdeZ2TNlApycON4Ljo8qjwPh+92ALTu8HKo=;
 b=72AdWELO6p2pG/tMHYv3f9hjtBUeI3eH97agA5gpqooxdcnYJ3GXqKgNIKBC6aENKJm3Hq
 kxpHC8TivQ9tfYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B850513754;
 Sun, 31 Jul 2022 16:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bVKfKsOn5mJxEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 31 Jul 2022 16:03:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sun, 31 Jul 2022 18:03:07 +0200
Message-Id: <20220731160307.16063-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] MAINTAINERS: Add Namjae's exfat git tree
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Petr Vorel <petr.vorel@gmail.com>

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..0cfde0f3544b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7573,6 +7573,7 @@ M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 F:	fs/exfat/
 
 EXT2 FILE SYSTEM
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
