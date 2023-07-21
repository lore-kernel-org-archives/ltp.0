Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224CDEB64DD
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:15:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9F63CDC75
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:15:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ACA03C9481
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 620D960008D
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E8871F461;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BtdmUYiq8wvV1RTWfbOQh/Sv/Om0O/EOMT11O7n/1Wc=;
 b=MuQ+GWcERt+KIDcQ5dfJ37ibyGhW8YeXQ4ABS8IWnptPB643vt0rHKI3SQPSDiG8zeQsJZ
 UQMELBFUKFkPDpUp5+0VtHaNdXAc92AZgq3t+725Ht5Wy5gJEqcnCpO44QxO4y6cpobUb4
 QsdQUpl9EBiT9sosuRyld1owkdHOhuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BtdmUYiq8wvV1RTWfbOQh/Sv/Om0O/EOMT11O7n/1Wc=;
 b=UiAsU+Mt2gTnp/62qEd6uTMuEGnrlGIC5J3FMb0SzXQ+3rDjqCPFvbFheSJC1y95AZ8Wt2
 VSPn/TmayJt0QtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A136134B0;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zcbYCKpMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:10 +0200
Message-Id: <20230721091515.1353371-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Add .skip_in_secureboot flag
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

Changes v1->v2:
* Fix check for CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT (Martin)
* New commit to print lockdown state in tst_lockdown_enabled (Martin)
* Simplify TCONF message (result of previous, Martin)
* Merge comments (Martin)

Petr Vorel (5):
  tst_lockdown: Check other lockdown configuration
  tst_lockdown_enabled: Print lockdown state
  lib: Add .skip_in_secureboot flag
  {delete,finit,init}_module0[1-3]: Skip on SecureBoot
  doc/c-api: Document .skip_in_* flags

 doc/c-test-api.txt                                |  6 ++++++
 doc/test-writing-guidelines.txt                   |  1 +
 include/tst_test.h                                |  4 ++++
 lib/tst_lockdown.c                                | 15 +++++++++------
 lib/tst_test.c                                    |  3 +++
 .../syscalls/delete_module/delete_module01.c      |  3 ++-
 .../syscalls/delete_module/delete_module03.c      |  3 ++-
 .../kernel/syscalls/finit_module/finit_module01.c |  3 ++-
 .../kernel/syscalls/finit_module/finit_module02.c |  8 +++++---
 .../kernel/syscalls/init_module/init_module01.c   |  3 ++-
 .../kernel/syscalls/init_module/init_module02.c   |  7 ++++---
 11 files changed, 40 insertions(+), 16 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
