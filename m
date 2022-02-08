Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAA8C433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:10:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B04BF3C9B37
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:10:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA193C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF8FC1400E1C
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:09:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A630210F0;
 Tue,  8 Feb 2022 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644314992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=I460rcnxAWwu71oAb/Cu++VohDnkW5cVA5XCK/8ocgI=;
 b=Nzu/wN+PO0hHtfNRsVThrq4A3Txj7ypypQDRgBV3KUBNYRQ8LmrBzhBmMYgE6hsTA1Eo2e
 Hu7jXiA807Op1XTceRUw8yfovEcldbuXmUz8TEKjAKSeIlWjtysqqko0Hahcl9o6YEfWLG
 jgWB0SEtYcIbbV4OG+Yy1ViBiYu+Wj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644314992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=I460rcnxAWwu71oAb/Cu++VohDnkW5cVA5XCK/8ocgI=;
 b=4POau7F6bg/ZjKp8VxjESpZS5zJgiai5ziMn3CXCZL4nd/SEjB3ALgGqS+1xgRXYKfnjlw
 bkbHQOdsxzXjJnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D55D213BF9;
 Tue,  8 Feb 2022 10:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 58b5MW9BAmIwcQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Feb 2022 10:09:51 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 11:09:39 +0100
Message-Id: <20220208100948.22913-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/9] Rewrite sysvipc testing suite using new LTP API
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

Rewritten all sysvipc tests and removed libclone dependency.
Removed TST_CHECKPOINT_INIT from all tests and replaced it with the
.checkpoints support.

Andrea Cervesato (9):
  Remove libclone dependency from sysvipc
  Rewrite mesgq_nstest.c using new LTP API
  Rewrite msg_comm.c using new LTP API
  Rewrite sem_comm.c using new LTP API
  Rewrite sem_nstest.c using new LTP API
  Rewrite semtest_2ns.c using new LTP API
  Rewrite shm_comm.c using new LTP API
  Rewrite shmem_2nstest.c using new LTP API
  Rewrite shmnstest.c using new LTP API

 testcases/kernel/containers/sysvipc/Makefile  |  26 +-
 testcases/kernel/containers/sysvipc/common.h  | 138 ++++++++
 .../kernel/containers/sysvipc/ipcns_helper.h  |  41 ---
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 234 ++++++-------
 .../kernel/containers/sysvipc/msg_comm.c      | 159 ++++-----
 .../kernel/containers/sysvipc/sem_comm.c      | 160 ++++-----
 .../kernel/containers/sysvipc/sem_nstest.c    | 221 ++++++------
 .../kernel/containers/sysvipc/semtest_2ns.c   | 318 ++++++++----------
 .../kernel/containers/sysvipc/shm_comm.c      | 144 +++-----
 .../kernel/containers/sysvipc/shmem_2nstest.c | 262 +++++++--------
 .../kernel/containers/sysvipc/shmnstest.c     | 185 +++++-----
 11 files changed, 887 insertions(+), 1001 deletions(-)
 create mode 100644 testcases/kernel/containers/sysvipc/common.h
 delete mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
