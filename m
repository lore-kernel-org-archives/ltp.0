Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B52C433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 09:13:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917BD3C967B
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 10:13:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E66343C9690
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 10:13:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44A30600209
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 10:13:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81F721F38C;
 Wed, 19 Jan 2022 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642583593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fk1mp6RfKjyEuQZPXN6qYdt9CLti2lYktOHyPQd60jU=;
 b=la130rOjD3eyq5yJX9aJYt5xPg1NJ4nGWtPz4Sd7CbLlIV/nF8YOVGvnYTjgwn6K6n3ISa
 wm0kH7OU5mbeqJ94oD9t+G5JypHiN7AFNzN8mocJxPn29DQUrVW+04pfO4OaTLAjQW2WdV
 hPP8dQCytzuyaEaOUcuzHUsNUDgTF7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642583593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Fk1mp6RfKjyEuQZPXN6qYdt9CLti2lYktOHyPQd60jU=;
 b=HSYGt3WERPPTnI0WUVS1GLFl/PklsYvKiBJY3Ll9L1hSMhF0bV+FAuU6wRPWfT4iE2zWtN
 FS54KsrcOtkUMDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B79C13B2D;
 Wed, 19 Jan 2022 09:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6glLFCnW52HfHQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Jan 2022 09:13:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 19 Jan 2022 10:13:09 +0100
Message-Id: <20220119091311.22150-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Add futex_wait testing suite
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
  Add futex_waitv testing suite

 configure.ac                                  |   3 +
 include/lapi/futex.h                          | 180 ++++++++++++++++++
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/mips_n32.in             |   1 +
 include/lapi/syscalls/mips_n64.in             |   1 +
 include/lapi/syscalls/mips_o32.in             |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 lib/tst_checkpoint.c                          |   1 -
 testcases/kernel/syscalls/clone/clone08.c     |   1 -
 testcases/kernel/syscalls/futex/.gitignore    |   3 +
 testcases/kernel/syscalls/futex/Makefile      |  14 +-
 .../syscalls/futex/futex_cmp_requeue01.c      |   2 +-
 .../syscalls/futex/futex_cmp_requeue02.c      |   2 +-
 .../kernel/syscalls/futex/futex_waitv01.c     | 129 +++++++++++++
 .../kernel/syscalls/futex/futex_waitv02.c     | 104 ++++++++++
 .../kernel/syscalls/futex/futex_waitv03.c     | 112 +++++++++++
 testcases/kernel/syscalls/futex/futextest.h   |  72 +++----
 29 files changed, 591 insertions(+), 49 deletions(-)
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv01.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv02.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_waitv03.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
