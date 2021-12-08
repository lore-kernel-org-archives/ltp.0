Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8225CC433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 15:20:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 370FA3C6DC3
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 16:20:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3CF3C133E
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 16:20:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 751C26011AE
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 16:20:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50E161FD26
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638976839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+rI1EHeEql5PFxVYdTqhJDIxWysaW6+80GaIc4ZNaTM=;
 b=ZQFTcNbr8aSrU2Q7odtute+wVLD7e0AMDF0GZ6ZgnWGCso1dtbdqzDXg0iwi+sI/1tM8gR
 Dp7UwVbxArSBfHbckWa97U1eBOYb/zOQYoN3Y6u2kiadh0XywNOBLBdU2+AwKdJ2zJ86WS
 N37JP5llk+PA5WRcAFMtp0VwMUg6QW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638976839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+rI1EHeEql5PFxVYdTqhJDIxWysaW6+80GaIc4ZNaTM=;
 b=BlnebOygR4d0KXJGsQZe4QLzyncr8d6sHLXK2YMJhOdSSXH63/vAGQgMRB/AZSLqzh602J
 JLCdarDc2oUf8iBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D29E13B72
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 15:20:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QIqKDUfNsGE2TgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 08 Dec 2021 15:20:39 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Dec 2021 16:20:38 +0100
Message-Id: <20211208152038.17355-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix INSTALL_TARGETS for nfs tests
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

Fixes: 7fb7aeb71 ("nfs: Add *.sh extension to shell tests")
Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
index 0b7408e29..8cd095867 100644
--- a/testcases/network/nfs/nfs_stress/Makefile
+++ b/testcases/network/nfs/nfs_stress/Makefile
@@ -10,12 +10,12 @@ nfs04_create_file: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 nfs05_make_tree: LDLIBS += -lpthread
 
 INSTALL_TARGETS		:= nfs_lib.sh \
-			   nfs01 \
-			   nfs02 \
-			   nfs03 \
-			   nfs04 \
-			   nfs05 \
-			   nfs06 \
+			   nfs01.sh \
+			   nfs02.sh \
+			   nfs03.sh \
+			   nfs04.sh \
+			   nfs05.sh \
+			   nfs06.sh \
 			   nfs07.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
