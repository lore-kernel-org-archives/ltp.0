Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2203ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 13:50:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C75D3CA6F6
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 15:50:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D008D3CA5C7
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3BD0260065E
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 15:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3724B1FA36
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661867408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PWb/QdgPwlyHoyGMVusAHNbBKJxwL6rIF+CDTjKV440=;
 b=rEzQQJPSKeZwmUXpXeKI7V16rb22+cvI1n5ERSWVDTKqL9CPcBra4qalW3pjymbAAGJKo2
 sr3ybmGfGqB6Kla5J6IUY4CQENacOAAtijsveIyQy8DKxCB+cWikH9/URsmVUlC0U9x+4G
 g7c/a83Ea5RXqg2r1id47WkCwn2b+V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661867408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PWb/QdgPwlyHoyGMVusAHNbBKJxwL6rIF+CDTjKV440=;
 b=SBg9y7+oZIjWTPIIvG5r2OZgAsHtZzVrmQOm/5XVty+HVw+jrdSsL/Mz8kMWtb840n7r29
 ZmyDWaF0s7hsjoAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23D1813ACF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uBKeB5AVDmOfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 13:50:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Aug 2022 15:49:57 +0200
Message-Id: <20220830135007.16818-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/10] Max_runtime and other minor fixes
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

The introduction of max_runtime system shortly before the latest LTP release
has caused some random timeout issues, particularly for KSM tests,
sendfile09 and ioctl_sg01. This patchset fixes those issues, along with
some minor improvements found during during test review.

All of these patches are independent and can be merged out of order.

Martin Doucha (10):
  syscalls/pty06: Add CVE reference
  cve-2017-2671: Increase max_runtime
  ksm: Add max_runtime to tests
  ioctl_sg01: Set unlimited max_runtime
  csf_bandwidth01: Add max_runtime
  copy_file_range01: Add max_runtime
  perf_event_open02: Add max_runtime
  readahead02: Add max_runtime
  request_key03: Add max_runtime
  sendfile09: Add max_runtime

 testcases/cve/cve-2017-2671.c                                 | 2 +-
 testcases/kernel/mem/ksm/ksm02.c                              | 1 +
 testcases/kernel/mem/ksm/ksm04.c                              | 1 +
 testcases/kernel/mem/ksm/ksm05.c                              | 1 +
 testcases/kernel/pty/pty06.c                                  | 3 ++-
 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c        | 1 +
 testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c                  | 1 +
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 1 +
 testcases/kernel/syscalls/readahead/readahead02.c             | 1 +
 testcases/kernel/syscalls/request_key/request_key03.c         | 1 +
 testcases/kernel/syscalls/sendfile/sendfile09.c               | 1 +
 12 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
