Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B0EC433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32D443CA724
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 17:55:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04F753CA942
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C3B8600840
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 867CA21BDC;
 Tue, 10 May 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652198082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2cV/n5wS2asqa+qRGX09A1/5WmYih0zkD3a15Lfi90=;
 b=I0tMfC081xc96jGWm2crMQwXxrcLFvjlTjiIfhb7rIDBsFkGQcK1LYl9elTjJ5J2L3LS89
 caB1fH3q702YB2pYqtO8q2eKC6Lw9WqKvwJFifb0MkACz5E70Ql77gp94urdDFRHBJPnBY
 DDeTMiFGORynpj63olimrNZyWWjikBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652198082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/2cV/n5wS2asqa+qRGX09A1/5WmYih0zkD3a15Lfi90=;
 b=H/OI9kEoxozQ/ckkmNOLG6dmnTVQnFgqmKZnRbozCB+c21uBMNvufxJ9N91QnzbFe2vX/Q
 O7rLDdZxQASaJQCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5695113AA5;
 Tue, 10 May 2022 15:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p+ldE8KKemIScwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 15:54:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 May 2022 17:54:34 +0200
Message-Id: <20220510155438.15754-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] shell: Add $TST_MOUNT_DEVICE support
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

Hi,

this is a preparation for .all_filesystems equivalent for shell.

changes v1->v2:
rebased

Petr Vorel (4):
  tst_test.sh: Add $TST_MOUNT_DEVICE
  df01.sh: Use TST_MOUNT_DEVICE=1
  tst_test.sh: Improve pattern for allowed variables
  shell: Add test for TST_MOUNT_DEVICE=1

 doc/shell-test-api.txt                     |  2 ++
 lib/newlib_tests/shell/tst_mount_device.sh | 21 +++++++++++++++++++++
 testcases/commands/df/df01.sh              |  4 ++--
 testcases/lib/tst_test.sh                  | 14 ++++++++++++--
 4 files changed, 37 insertions(+), 4 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
