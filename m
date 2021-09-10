Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF9C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A136103D
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58A136103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 129103C96A1
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11E23C2185
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E6111400B9A
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:29 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A17BB20211;
 Fri, 10 Sep 2021 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631279308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=orABgbSp6N94xKqCUzAxoui9u33658KDq8hsSqWEizw=;
 b=Rhvl2yxK7zzAIbbR81aLO8tvNAVNEPrrPAEQgMXIUG8NvamnlS1vEpzXQbXfKm4pKn/i1T
 YK6bCWL/NYAv0HhTn+5kpxVU/mAmTSsPBkeX5VWpv0EvDx/SDfIqDPZhGjRYqkoLmcF09T
 6UWhpFZSqd7MbDzYQ9tJYoAHRfLaJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631279308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=orABgbSp6N94xKqCUzAxoui9u33658KDq8hsSqWEizw=;
 b=33hdZXrgcCP8ma5nv3bIQqRNpnXLrP7HMA77PLF87UwIK15LazYe6hPaQ6wGJPAyVG0B8Y
 nX6Bl9zq8gEP/mCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5B212133D0;
 Fri, 10 Sep 2021 13:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id Bro8E8xYO2HKdAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 13:08:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Sep 2021 15:08:13 +0200
Message-ID: <20210910130820.21141-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
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
Message-ID: <20210910130813.JOM92yOg8XlrBwLdzutWUSXlng9AiR6jpMm28AfmDOU@z>

Hi,

changes v1->v2:
* split 1 commit into 2, use freopen() as suggested by Li
* 4 more commits for further cleanup

Petr Vorel (7):
  sched/process.c: Replace errfp with stderr
  sched/process.c: Open debugfp with freopen()
  ci/alpine: Enable process.c
  sched/process.c: Log into cwd, add *.log suffix
  sched/.gitignore: Ignore logs
  sched/process.c: Remove non-Linux code
  sched/process.c: Remove useless TRUE FALSE definitions

 ci/alpine.sh                                  |   1 -
 .../kernel/sched/process_stress/.gitignore    |   1 +
 .../kernel/sched/process_stress/Makefile      |   2 -
 .../kernel/sched/process_stress/process.c     | 118 ++++--------------
 4 files changed, 23 insertions(+), 99 deletions(-)

-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
