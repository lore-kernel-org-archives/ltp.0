Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBA2C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 12:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D2A13C1FF3
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 13:55:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58E953C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 851226011AE
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:54:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1BB31F38D;
 Fri, 25 Mar 2022 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648212886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=94zhqNsXloRWhogSJedWQ1vop4sQAoTaB13q+M8UBJ8=;
 b=o/ceKIod9AIg6XAfUldYGBEfIsBX8Anxa/6UshZJ5z1KHqLyf3TKHHC3roQF44A8ROilhv
 rDWP9ieI9Nnl2gK46fibkJlVwzUHWYeAilLHOvCCaVJeZ1NRmSZoNpWP0iB1yQiWrmYU/o
 z83ev0YbmYCkUCAcnCAiecpTB1nVfZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648212886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=94zhqNsXloRWhogSJedWQ1vop4sQAoTaB13q+M8UBJ8=;
 b=bHCNvU+FbJDzVcgsJwJwBc8vPyvhjgEHfm3c1jjnBcF0rdoV7USvSXIp4dUKrQF2HvZKbf
 eLMvl12YpdNxbnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 718131332D;
 Fri, 25 Mar 2022 12:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vTC0GZa7PWKoZgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Mar 2022 12:54:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 25 Mar 2022 13:54:35 +0100
Message-Id: <20220325125445.11984-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 00/10] Rewrite sysvipc testing suite using new LTP
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
  Rewrite shmnstest.c using new LTP API
  Rewrite shmem_2nstest.c using new LTP API
  Rewrite shm_comm.c using new LTP API
  Remove libclone dependency from sysvipc test suite
  Delete ipcns_helper.h in the sysvipc test suite

 runtest/containers                            |  30 +-
 testcases/kernel/containers/sysvipc/Makefile  |  26 +-
 testcases/kernel/containers/sysvipc/common.h  | 110 ++++++
 .../kernel/containers/sysvipc/ipcns_helper.h  |  41 ---
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 244 +++++--------
 .../kernel/containers/sysvipc/msg_comm.c      | 180 +++-------
 .../kernel/containers/sysvipc/sem_comm.c      | 178 +++-------
 .../kernel/containers/sysvipc/sem_nstest.c    | 212 ++++--------
 .../kernel/containers/sysvipc/semtest_2ns.c   | 326 +++++++-----------
 .../kernel/containers/sysvipc/shm_comm.c      | 167 +++------
 .../kernel/containers/sysvipc/shmem_2nstest.c | 239 +++++--------
 .../kernel/containers/sysvipc/shmnstest.c     | 180 ++++------
 12 files changed, 719 insertions(+), 1214 deletions(-)
 create mode 100644 testcases/kernel/containers/sysvipc/common.h
 delete mode 100644 testcases/kernel/containers/sysvipc/ipcns_helper.h

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
