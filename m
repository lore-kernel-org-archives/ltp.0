Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80154C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2AC33C9EF5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:27:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14DF53C9C2E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61747200935
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9108E1F391;
 Thu, 10 Feb 2022 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJcG9JVDK5f69rnkhMYcMjpNX4I6dZYJvMst/3n62Jo=;
 b=NnG+nO60nDzMrcDI2Vr0VAArmZd2tkqDbqcej5rm1nhMOmEUVy6hAmiGVo7QJXt41VXaxB
 szqkSMinKxHoWXKVMTsnVxSnXxtk7BsNLl2yOiT+D0u2tobt+tJOQKPjFB0zPWQi8YyLZ9
 /F8orp/IbLz7puZVfJVaYM1ZUQPUrHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJcG9JVDK5f69rnkhMYcMjpNX4I6dZYJvMst/3n62Jo=;
 b=rYPqZ0scxYg3ZHXRO6FyR0YViN6AvFTY/E/8z8uoWxbZWeuhk1CqJ5t1OsR58/3LbpRsLn
 MCM205rC4tsMwrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D79F13BC1;
 Thu, 10 Feb 2022 16:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B4CdEP88BWJAMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:27:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:27:33 +0100
Message-Id: <20220210162739.30159-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Add TST_FORMAT_DEVICE support
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

changes v1->v2:
* Replace $TST_DEFAULT_FS_TYPE with proper $TST_FS_TYPE initialization
  (Cyril)
* Redesing tst_mkfs() API (Cyril)
  We now parse only fs_type, the rest we pass to mkfs.* the same way we
  end up passing them on a command line.

Petr Vorel (6):
  tst_test.sh: Properly init $TST_FS_TYPE
  tst_test.sh: Redesing tst_mkfs() API
  tst_test.sh: Add $TST_FORMAT_DEVICE and related vars
  df01.sh: Use TST_FORMAT_DEVICE=1
  shell: Add test for TST_FORMAT_DEVICE=1
  doc: Add missing shell variables

 doc/shell-test-api.txt                      | 37 +++++++++++++++++++--
 lib/newlib_tests/shell/tst_format_device.sh | 24 +++++++++++++
 testcases/commands/df/df01.sh               |  5 +--
 testcases/commands/mkfs/mkfs01.sh           |  2 +-
 testcases/lib/tst_test.sh                   | 28 ++++++++++------
 5 files changed, 79 insertions(+), 17 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_format_device.sh

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
