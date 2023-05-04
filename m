Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D18C77B7C
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08DF53CB79B
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:15:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F703CD860
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4835B6008F0
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:14:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6CE22B0E;
 Thu,  4 May 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683206045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/FKdR3mIdN4rPKTA6ko4I1q3qCq+vibsIIkLB7RacM=;
 b=dEGVOk1vro9p663Uf28UeoFc+8I1gDCRfsGtWPlPRF+sYOIAI47XOCNfwXtdr1qOBgro3p
 8PQ/3EEkLV26VQeMb8TJv2xofh2eZ/DF3rR+pjP8fnsWJ2HvaQGyuugL8xo7GvPmBwvouO
 nNKOEoTx+zKNDXBfKRAx1p+zwTmPhGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683206045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/FKdR3mIdN4rPKTA6ko4I1q3qCq+vibsIIkLB7RacM=;
 b=HNiYDbgWLh/lCqln5c1bfs60SihWBJEh+d/SXg5pVsV+IubmbXwtZ+q1j1qAlO18uAVLGj
 MoipT0zNy5x1enCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F0F313444;
 Thu,  4 May 2023 13:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mPXhOpyvU2TXVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 May 2023 13:14:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 May 2023 15:14:12 +0200
Message-Id: <20230504131414.3826283-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504131414.3826283-1-pvorel@suse.cz>
References: <20230504131414.3826283-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/5] nfs05.sh: Lower down the default values
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

nfs05_make_tree.c runs make which needs on Btrfs quite a lot of
temporary space. This is a preparation for the next commit which
start using all filesystems via TST_ALL_FILESYSTEMS=1. Currently we use
300 MB, which was not enough for Btrfs:

Filesystem     Type      Size  Used Avail Use% Mounted on
/dev/loop0     btrfs     300M   62M   20K 100% /tmp/LTP_nfs05.Vau10kcszO/mntpoint

More space is required on ppc64le (higher page size ?).

Proper solution would be to detect available size in nfs05_make_tree.c
and lower down values based on free space.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs05.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
index c18ef1ab4..760b585e4 100755
--- a/testcases/network/nfs/nfs_stress/nfs05.sh
+++ b/testcases/network/nfs/nfs_stress/nfs05.sh
@@ -8,9 +8,9 @@
 #
 # Created by: Robbie Williamson (robbiew@us.ibm.com)
 
-DIR_NUM=${DIR_NUM:-"10"}
-FILE_NUM=${FILE_NUM:-"30"}
-THREAD_NUM=${THREAD_NUM:-"8"}
+DIR_NUM=${DIR_NUM:-"5"}
+FILE_NUM=${FILE_NUM:-"20"}
+THREAD_NUM=${THREAD_NUM:-"5"}
 TST_NEEDS_CMDS="make gcc"
 TST_TESTFUNC="do_test"
 
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
