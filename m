Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB6ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 21:10:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613323CAD5F
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 23:10:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B5843CAD56
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CABCD1A001D3
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C40551F8CD;
 Thu, 22 Sep 2022 21:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663880979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYKIJnwadcKB5hseV5A0eE/99Inuer3Ejf3ik1NZMfE=;
 b=bUIKZVFXsEDEi2raTEWlLgeVjjduUQad0/YcRqJ32vEigXkG7v53I+N5/xMu6VFh7VmKV3
 AVREdLVkclVeZl7GWJ5tBArcb+FZL+ZKZNnkhl2peGYZi7g7Uo860nd//F4t7ZFgVclUQG
 KLKV12GruxnvGREobYcUeZqWozq8604=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663880979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eYKIJnwadcKB5hseV5A0eE/99Inuer3Ejf3ik1NZMfE=;
 b=r2rMmlm15aHejLzLafiOcdK1eCyLnzyzPR3trEmUAcNWqDXT4eSy6ag5GkJXhK8jlPQFLO
 FHAtntGf6iC5BiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 863391346B;
 Thu, 22 Sep 2022 21:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tl/2HRPPLGMYKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 21:09:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Sep 2022 23:09:28 +0200
Message-Id: <20220922210931.23982-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3 v2] tst_test.sh: Fix filesystem support detection
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


changes v1->v2:
* based on the top of Martin's patch [1]: using tst_supported_fs -s ..
 -d. instead of detecting filesystem with df.
* remove tst_skip_filesystems_skip.sh test
* add TINFO message to tst_test.sh

new commits:
* tst_supported_fs: Unify messaging
* tst_supported_fs: Fix return codes

[1] https://patchwork.ozlabs.org/project/ltp/patch/20220921155006.13360-1-mdoucha@suse.cz/

Petr Vorel (3):
  tst_supported_fs: Unify messaging
  tst_supported_fs: Fix return codes
  tst_test.sh: Fix filesystem support detection

 .../shell/tst_skip_filesystems_skip.sh        | 17 -----
 testcases/lib/tst_supported_fs.c              | 65 +++++++++----------
 testcases/lib/tst_test.sh                     | 14 ++--
 3 files changed, 40 insertions(+), 56 deletions(-)
 delete mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
