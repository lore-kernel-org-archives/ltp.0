Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E2C7618E
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 21:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB543CE9FE
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 23:08:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 737B13CB304
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D3FD11A0034F
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 23:08:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E6181F88F;
 Mon, 24 Apr 2023 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682370491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qNqF9lt1VGiwkNxgKI1S7fxgWB8ln4b7o0cffADwrWo=;
 b=FijMpOO6XZChui0YLqm0TR9EcmAtpaDYTrDxRL/9aQAnNydXx5vE6gCFlLybDVH2Y6T/PC
 aiPgizfq33h69qTQ0TlYpwOhXPG7UdIUEq0ubH+jzXc0ou5kaO64fb5Pk010JGaUZ0f4KK
 Wrd6PrexH6RurebNjHMLxd6EfMobBTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682370491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qNqF9lt1VGiwkNxgKI1S7fxgWB8ln4b7o0cffADwrWo=;
 b=i+qty8lDkKPbeJs73oFfCFItLXHgfL9qMJ4T4wa2CG7T5F0gnhrdAMFsbflxn300gcjhaf
 3gH6EV3XLkf8yoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292F61390E;
 Mon, 24 Apr 2023 21:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /tsjCLvvRmSzIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Apr 2023 21:08:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Apr 2023 23:08:15 +0200
Message-Id: <20230424210818.2885479-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] NFS: test on all filesystems
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

finally I managed to finish the support for LTP NFS tests to be running
on all available testing filesystems via TST_ALL_FILESYSTEMS=1.

I believe this will help to cover more bugs than testing on single
underlying filesystem.

Thank you to Neil Brown to help with the debugging of umounting loop
device, which was the problem in the past.

Kind regards,
Petr

Petr Vorel (3):
  nfs_lib.sh: Cleanup local and remote directories setup
  nfs_lib.sh: Unexport on proper side on netns
  nfs: Run on all filesystems

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 82 +++++++++++++++------
 1 file changed, 61 insertions(+), 21 deletions(-)

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
