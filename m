Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D0CC433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 20:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6303C9611
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 21:24:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 477083C964C
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:24:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 325F42002D0
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:23:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44AE21F39B;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642451036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zwFGwPYK9oHhAHHQVkyJgbAAJfo2dsDAg/aA4Wd0rX4=;
 b=mVME3RElsuXPLXfTut4YjWKNolKm/GNFQACWmMFJELXmDMjifzvp1DyTr1I2XRTrMGLqwI
 iXA01fdSxb0+5ARMekS185oQS4KmWV02+jc/7P/zWjKUMBVOZg8zhnRAisKQEq9h3+Kttf
 VKTRbiqXDlrMGDwWqWvT8VIiv2EaAc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642451036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zwFGwPYK9oHhAHHQVkyJgbAAJfo2dsDAg/aA4Wd0rX4=;
 b=l+dgsGxp4R2jwezaXbSeLJCiokOBmVz4gaQlvw5ExncLIN6cwzpZ1u1zb5v3UipQY5+b3O
 JFGVlqngzlZVgXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 117F813E9C;
 Mon, 17 Jan 2022 20:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TfFsAVzQ5WHSUAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 17 Jan 2022 20:23:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 17 Jan 2022 21:23:52 +0100
Message-Id: <20220117202354.20785-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] Add futex_wait testing suite
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

futex_waitv tests have been inspired by
tools/testing/selftests/futex/functional/futex_waitv.c that can be found
in the Linux kernel official repository.

Andrea Cervesato (2):
  Update lapi/futex.h fallback
  Add futex_waitv tests suite

 configure.ac                                  |   1 +
 include/lapi/futex.h                          | 178 ++++++++++++++++++
 lib/tst_checkpoint.c                          |   2 +-
 testcases/kernel/syscalls/clone/clone08.c     |   3 +-
 testcases/kernel/syscalls/futex/.gitignore    |   3 +
 testcases/kernel/syscalls/futex/futex2test.h  |  23 +++
 .../syscalls/futex/futex_cmp_requeue01.c      |   2 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |   2 +-
 .../kernel/syscalls/futex/futex_waitv01.c     | 129 +++++++++++++
 .../kernel/syscalls/futex/futex_waitv02.c     | 103 ++++++++++
 .../kernel/syscalls/futex/futex_waitv03.c     | 111 +++++++++++
 testcases/kernel/syscalls/futex/futextest.h   |  56 ++----
 12 files changed, 567 insertions(+), 46 deletions(-)
 create mode 100644 testcases/kernel/syscalls/futex/futex2test.h
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv01.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv02.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv03.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
