Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D3C77B7C
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:14:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF66D3CD8D5
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:14:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2BF93CB749
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EFBDD1000A0E
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C20A422518;
 Thu,  4 May 2023 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683206043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6zuNBKSgyzbHvrNMhySy4dCq62+jMm3tUSN1h9NEC4s=;
 b=pXDDHv7xNKfV4bXbmDhqJjX660/o2DJREW6+E2HSwU+rIJmcEi5hSPPxC7pulfSmWL/WUZ
 +NVzHRDePn1TGIsOp2sr39S6UwwKiwXvsHP3u4Ww5chQ7NeW7Tu+tFJi1KNeP/jVIGJBbU
 fgAC4oeuhHXzMYKETno9sWQyyWdFEW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683206043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6zuNBKSgyzbHvrNMhySy4dCq62+jMm3tUSN1h9NEC4s=;
 b=BiiWE5iJ1yTH+R4WlT9a3sUDVnEtWaiJI9TSo5S2VpB6wlesS8ISxWRBvd2RJb0dZ3RJox
 AtKHi0vm4BSVo0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67F8713444;
 Thu,  4 May 2023 13:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A+9eF5uvU2TXVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 May 2023 15:14:09 +0200
Message-Id: <20230504131414.3826283-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/5] NFS: test on btrfs, ext4, xfs filesystems
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

changes v4->v5:
* test only on btrfs, ext4, xfs instead on all available filesystems
This increases coverage but minimises the runtime (compare to running on
all available filesystems) => should be safer to commit now, before git
freeze.
* increase sleep to 2 sec after first umount (to avoid "device in use")
* new commit to fix not enough space on nfs03.sh
TODO: better handling space

NOTE: this patchset also fixes problem with device in use in case
somebody used TMPDIR on mounted loop device on current master (without
TST_ALL_FILESYSTEMS=1).

Petr Vorel (5):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs05.sh: Lower down the default values
  nfs03.sh: Lower down the default values
  nfs: Run on btrfs, ext4, xfs

 testcases/network/nfs/nfs_stress/nfs03.sh   |  4 +-
 testcases/network/nfs/nfs_stress/nfs05.sh   |  6 +-
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 73 +++++++++++++++------
 3 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
