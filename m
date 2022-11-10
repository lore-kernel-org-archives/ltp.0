Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1584AC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 14:54:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 430AB3CDD86
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 15:54:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540B53CD695
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:54:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7EC09140114C
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:54:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B96581FBBF;
 Thu, 10 Nov 2022 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668092074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHjLiynUDtaglhd+lrzHXwhYH7BYTCOGUOQlIqXhdAU=;
 b=Nn9jQjuGsXn8fC5zpZ+dGwKbnQxSf+8IwCY5m89JCXBe0Afo/IY6jNKN9kUBGTEf8MTHac
 Xlq9StnZXg8ZNIkXLrljmsttH7yKd9ab9bfTCcsCAEKh7/5NcjIZgq9TKq8YMf5QcQmwwN
 DF1sVfGlG3Q3gDmXfeufaEZqfawM+iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668092074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OHjLiynUDtaglhd+lrzHXwhYH7BYTCOGUOQlIqXhdAU=;
 b=pdZQOXtG6IFsidZZD3/YVjzaG7kDASnhu8Jkl12UITygFi2kngw/XuaoOgGw+uSDxZrYRt
 q0i2zBOLfslfdKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 937C113B58;
 Thu, 10 Nov 2022 14:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id omaVIqoQbWNEMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Nov 2022 14:54:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 15:54:29 +0100
Message-Id: <20221110145429.8158-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] README.md: Document IRC
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
changes v1->v2
* s/on/at/

Kind regards,
Petr

 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index d45d1ee44..89b2640c1 100644
--- a/README.md
+++ b/README.md
@@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
 LTP mailing list is archived at:
 https://lore.kernel.org/ltp/
 
+IRC
+#ltp at https://libera.chat/[irc.libera.chat]
+
 The git repository is located at GitHub at:
 https://github.com/linux-test-project/ltp
 
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
