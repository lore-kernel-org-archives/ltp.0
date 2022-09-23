Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941CECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:56:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9213C3CAD96
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:56:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C63CF3CAA78
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:56:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4ECBC1A00807
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:55:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9731F947;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663930559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=omV2GJgzlRxuWB9JjhLPNPgqDLYqOFyC9qFyv0ivi8A=;
 b=Bo3V5CC9lqkYQoShu0fRv1st19M6ct3oFSfsduaPew1kivsEYKMmcCNoyDsJputPCXRRlG
 a9TiV0usAWoZ5ty2RnXRbO0gc0Lf5Op21u5lDy50s3yuha/zGyNhq10IVLKqpgxVLgQ4//
 c30fZh+p+Z8MbvS5uRDYRvsZHZbQhSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663930559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=omV2GJgzlRxuWB9JjhLPNPgqDLYqOFyC9qFyv0ivi8A=;
 b=Q3siy0SuHnTCPh10Tu4JJGqAiloLtHnzK5MHKE3lm5V8wBjsGu64AIKT8xYfaoLqJjCut8
 PgdXFd05kfFBWgBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 155F813AA5;
 Fri, 23 Sep 2022 10:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sY6cA7+QLWMBSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 10:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Sep 2022 12:55:51 +0200
Message-Id: <20220923105554.28942-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] IMA + shell API fixes on umount
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

NOTE this is based on my patchset "tst_test.sh: Fix filesystem support
detection" [1] which is based on Martin's patch [2] (4 more commits
needed). Also available in my fork [3].

All these 7 commits would be great to get to the release.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=319660&state=*
[2] https://patchwork.ozlabs.org/project/ltp/patch/20220921155006.13360-1-mdoucha@suse.cz/
[3] https://github.com/pevik/ltp/commits/fix/TST_ALL_FILESYSTEMS.v2.ima

Petr Vorel (3):
  tst_test.sh: cd to $LTPROOT before umount
  ima_setup.sh: Use TST_MOUNT_DEVICE
  ima_setup.sh: Use tst_supported_fs instead of df

 .../security/integrity/ima/tests/ima_setup.sh | 29 +++++--------------
 testcases/lib/tst_test.sh                     |  3 +-
 2 files changed, 10 insertions(+), 22 deletions(-)

-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
