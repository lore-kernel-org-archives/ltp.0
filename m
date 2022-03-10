Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE7FC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:59:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D6BD3C5594
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:59:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07C63C0CA6
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A312600E59
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 11:59:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56339210EE;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646909961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RufOH0q2Sa8fxT6JWG2XOpaafrT5KUJEy05rYIap51U=;
 b=U6GKUd0jliHWDVoeeaCYudKQ+O6FiRABeJm7cb+8d2/MB8SBiSL+5lcB8LtLOJdNM8z1bv
 5D8kYtN9i9vP/arc4I8wTHP1eUNT1zNujClReKrEnjHihRx7Gntyyn5qzFscSKEzVzdVux
 2a7+vwC7j2YW5/UCYeWsveAMECmwyzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646909961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RufOH0q2Sa8fxT6JWG2XOpaafrT5KUJEy05rYIap51U=;
 b=FnvjxXPRZJixJh14FK2p9GmYRIHsXdN5gcLS2LxBDsGvMiCzQruq4bBPIqt6WgWsiX+oJ0
 8qgiGshOs++/xVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 308C213A3D;
 Thu, 10 Mar 2022 10:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xmLgCQnaKWK8fgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Mar 2022 10:59:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 11:59:06 +0100
Message-Id: <20220310105916.7960-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/10] Rewrite sysvipc testing suite using new LTP
 API
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

Andrea Cervesato (10):
  Rewrite mesgq_nstest.c using new LTP API
  Rewrite msg_comm.c using new LTP API
  Rewrite sem_comm.c using new LTP API
  Rewrite sem_nstest.c using new LTP API
  Rewrite semtest_2ns.c using new LTP API
  Rewrite shm_comm.c using new LTP API
  Rewrite shmem_2nstest.c using new LTP API
  Rewrite shmnstest.c using new LTP API
  Remove libclone dependency from sysvipc
  Delete obsolete ipcns_helper.h in sysvipc suite

 testcases/kernel/containers/sysvipc/Makefile  |  26 +-
 testcases/kernel/containers/sysvipc/common.h  | 157 ++++++++++
 .../kernel/containers/sysvipc/ipcns_helper.h  |  41 ---
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 247 ++++++---------
 .../kernel/containers/sysvipc/msg_comm.c      | 180 ++++-------
 .../kernel/containers/sysvipc/sem_comm.c      | 180 ++++-------
 .../kernel/containers/sysvipc/sem_nstest.c    | 212 +++++--------
 .../kernel/containers/sysvipc/semtest_2ns.c   | 295 +++++++-----------
 .../kernel/containers/sysvipc/shm_comm.c      | 167 +++-------
 .../kernel/containers/sysvipc/shmem_2nstest.c | 239 +++++---------
 .../kernel/containers/sysvipc/shmnstest.c     | 182 ++++-------
 11 files changed, 746 insertions(+), 1180 deletions(-)
 create mode 100644 testcases/kernel/containers/sysvipc/common.h
 delete mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
