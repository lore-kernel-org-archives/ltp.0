Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B57C07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8AE3C899B
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:14:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31ED73C0FA6
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F0E76008C2
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:18 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 70E151F8CF;
 Tue, 27 Sep 2022 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gMY2NJofqNdVf0h4d63nnTyBhkZXH/BPE9aSeGcu6vQ=;
 b=WI9oWf6lhOaUaWQYmHxwRtyOL/Gxi1jZxcKsmr2p69sT3eXGbAknGmyby8GfZcILbFkpUM
 HZpEyWWoHu/uKhiAQ3pn5y+hC2kU+DFOAxTTj6D4vA8YsD4H4sawV6DEA8MBq1bWyt/h8j
 1HMpmpoEZ3NVG5zICrF+KjqLH3b6X7k=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id C37202C16B;
 Tue, 27 Sep 2022 16:14:17 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:02 +0100
Message-Id: <20220927161408.23743-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Locally distributed work API
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Sorry for such a large complicated patch-set. This is essentially an
RFC, but I haven't marked it as such because some parts of it may be
ready to merge.

This is motivated by patterns I noticed both in the read_all test and
work we have been doing on the LTP parallel test executor
(LTX). Currently LTX exists outside the main LTP tree and doesn't use
the LTP library. However it would be nice to share code between some
types of test and LTX.

We have various ways of communicating and synchronising between
processes. This adds another which is particularly suited to
distributing work across multiple processes. Including work that
completes unevenly and is likely to fail.

Currently these are local processes, but LTX runs as a remote process
on a SUT. It takes commands from and returns results to a test
schedular on another machine. The interface should be relatively easy
to extend to support this scenario.

Still TODO:
* Documenation (other than commit messages)
* Integrate LTX into LTP API
* Implement variations on the read_all test (e.g. splice_all)

Richard Palethorpe (6):
  api/epoll: Add safe epoll functions
  api/evloop: Add helpers for creating an event loop
  api/state_machine: Add validating state machines
  api/channel: Add channel abstraction for message passing
  api/worker: Add library for distributing work over multiple procs
  read_all: Migrate to the worker lib

 include/tst_channel.h                   |  97 ++++
 include/tst_epoll.h                     |  36 ++
 include/tst_evloop.h                    |  32 ++
 include/tst_state_machine.h             |  50 ++
 include/tst_worker.h                    |  62 +++
 lib/tst_channel.c                       | 410 +++++++++++++++++
 lib/tst_epoll.c                         |  81 ++++
 lib/tst_evloop.c                        | 102 ++++
 lib/tst_state_machine.c                 |  98 ++++
 lib/tst_worker.c                        | 285 ++++++++++++
 testcases/kernel/fs/read_all/read_all.c | 588 +++++++-----------------
 11 files changed, 1424 insertions(+), 417 deletions(-)
 create mode 100644 include/tst_channel.h
 create mode 100644 include/tst_epoll.h
 create mode 100644 include/tst_evloop.h
 create mode 100644 include/tst_state_machine.h
 create mode 100644 include/tst_worker.h
 create mode 100644 lib/tst_channel.c
 create mode 100644 lib/tst_epoll.c
 create mode 100644 lib/tst_evloop.c
 create mode 100644 lib/tst_state_machine.c
 create mode 100644 lib/tst_worker.c

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
