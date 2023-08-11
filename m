Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE06C001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:56:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD88E3CD053
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D08933C89B6
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E3B5A1400153
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BD561F889
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lkTYn43T2JEl3k6KKkwbOemNgHWFRKNO/Ormq/wxb2Y=;
 b=nyFKX65fmQQw1L4GmDXqDjUHx7Xo0i9EjX6oFuoGG/AW67jbMeGmRMsrldGZ6LDVffxCPQ
 2va3ZEN1rYnEuHgGHmLZ/t68AtagtmQzYC3KvDBw5DaMT1kTR9g6g2LY7auHNkYvcdzWAI
 X2HJFHvVr5frjcE9O2nAixTkuuHQfvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lkTYn43T2JEl3k6KKkwbOemNgHWFRKNO/Ormq/wxb2Y=;
 b=VqxnAe0pYRpIax1hvM8V7/stS3Q8E2nq1WMVjVh6EKpxWIZNgxsYWidHgDx6EqrTp2/lwY
 0saAgFph0BXbyBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50D43138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ekAZE8Ih1mT0WgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:40 +0200
Message-ID: <20230811115647.32387-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Utility functions for string in guarded buffers
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

First patch adds utilitilty functions for strings in guarded buffers,
which is followed by a few test conversions to the newly introduced API.

Cyril Hrubis (6):
  lib: tst_buffers: Add bufs .str and tst_aprintf()
  syscalls/access04: Make use of guarded buffers
  syscalls/acct01: Make use of guarded buffers
  syscalls/chdir01: Make use use of guarded buffers
  syscalls/chmod01: Make use of guarded buffers
  syscalls/chroot03: Make use of guarded buffers

 include/tst_buffers.h                       | 11 +++
 lib/tst_buffers.c                           | 28 ++++++-
 testcases/kernel/syscalls/access/access04.c | 36 ++++++---
 testcases/kernel/syscalls/acct/acct01.c     | 84 +++++++++++----------
 testcases/kernel/syscalls/chdir/chdir01.c   | 55 +++++++++-----
 testcases/kernel/syscalls/chmod/chmod01.c   | 28 ++++---
 testcases/kernel/syscalls/chroot/chroot03.c | 46 ++++++-----
 7 files changed, 188 insertions(+), 100 deletions(-)

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
