Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D328C77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 16:00:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BABF73CBA82
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 18:00:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DCB83CBA47
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 18:00:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2605600098
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 18:00:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C86E721A2B;
 Fri, 28 Apr 2023 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682697629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pYNhcoSI8w67TCWRIKTXvM7uOQtjaNFojNq9m6DCuhc=;
 b=ki1oVdg8VQ7cx4SwiRM32TxCFvg6c3ScL1vHFPgoqY8wfaaUS5/esTZD4Y3yGk11WU3Dqg
 DUrOK18BgvlNS1VlOhbjEQMeoUSXKVItjdCad848qOE3ajfpj0E8o5Z+xeSgXydKjJkJBp
 jsE/WOseISCK3TQXrsWCGLGjSo+bD+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682697629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pYNhcoSI8w67TCWRIKTXvM7uOQtjaNFojNq9m6DCuhc=;
 b=ahs2DHLqX7+xM0Yc/GhO8ipVOlYRgXb/zy7t1vKwcCneWA7FpLAQmdFTjoRDgc0sxuHIlS
 8y2wOnUy36tixFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E128138FA;
 Fri, 28 Apr 2023 16:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8ki3CZ3tS2SRbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 16:00:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Apr 2023 18:00:34 +0200
Message-Id: <20230428160038.3534905-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] NFS: test on all filesystems
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

change v3->v4:
new commit "nfs05.sh: Lower down the default values"
to fix nfs05.sh failure on Btrfs.

I'd like to get this change into upcoming LTP release.

Kind regards,
Petr

Petr Vorel (4):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs05.sh: Lower down the default values
  nfs: Run on all filesystems

 testcases/network/nfs/nfs_stress/nfs05.sh   |  4 +-
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 82 +++++++++++++++------
 2 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
