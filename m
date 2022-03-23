Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBEAC433F5
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 19:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37D443C98AB
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 20:04:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7BCF3C9413
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:04:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F204010000CA
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:04:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B95E210F9;
 Wed, 23 Mar 2022 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648062278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2iZoj3lgqjwfFZu0qWKFexyaW62tnIp/tBraJr9a7Qk=;
 b=Uxqyqv6FN9WL8UioDpR/Oh9T/VUd/R4BrhMShOhnyTqpeSwwwELbypuHc+o+OhIAQ+hBVi
 mYwcTRWUE71pTlqxGPNmVU4lGfRU8SMzVGBxkLtaXYyTZ9kPzTDjHaUSVqZV1zSyrXMBAG
 eCYQdw3oSBRmEGEMVoKdC5+krPL6MlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648062278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2iZoj3lgqjwfFZu0qWKFexyaW62tnIp/tBraJr9a7Qk=;
 b=h7bQD/YOExItM3I6pc+JTUbxYB2exm+1hK7AHw4Ym+k7KmzuKQNAi922fmbxQlsUaVV8ym
 qDsrgORakRooH5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3E3E13302;
 Wed, 23 Mar 2022 19:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FdaTMUVvO2KQRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:04:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 23 Mar 2022 20:04:29 +0100
Message-Id: <20220323190433.18821-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] shell: Add $TST_MOUNT_DEVICE support
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

next step to all_filesystems support for shell.

Petr Vorel (4):
  tst_test.sh: Add $TST_MOUNT_DEVICE
  df01.sh: Use TST_MOUNT_DEVICE=1
  tst_test.sh: Improve pattern for allowed variables
  shell: Add test for TST_MOUNT_DEVICE=1

 doc/shell-test-api.txt                     |  2 ++
 lib/newlib_tests/shell/tst_mount_device.sh | 21 +++++++++++++++++++++
 testcases/commands/df/df01.sh              |  3 +--
 testcases/lib/tst_test.sh                  | 14 ++++++++++++--
 4 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
