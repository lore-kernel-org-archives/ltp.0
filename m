Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D6C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5FC3C927F
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:01:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A3303C9293
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:15 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 863EB1A00E02
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:14 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8EE2C3F206
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376811;
 bh=jtrvcTEGwPy+doq6FAEprW/B404oSxVLA6pPxuMbEOw=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=kFOjEw1hi76Qg3+lhCYUmJLoHLWoGfgQDD1mO8Yaw50LT5pf7pOzoy4II7R7Gyqal
 x19qbIsdgOfcxr+062SWrFDim0dzEYH0SE51rSEh4QAiVKIB0olZHHhcOp9YDN8F67
 IfWcnnrvcE/orKShjXgHgMoh6A7ZTREJoEDfYmGbz5TpTm8d6ML7Sm0N5Hb+AkvJYl
 I9S7vMkYnXbD/Jgmo/RxfmC6fuTUvkYHRX6T8MYajTQ6VHFJieY6q7Ho1CJsRkjM9K
 vXHiAjNC6dpVRHqFJU86a7pGrRUOJJIFkEns8YhPy3cbYyOcysR/sqbz8b2RGdee04
 drQVNwvQHDY7A==
Received: by mail-lf1-f71.google.com with SMTP id
 p19-20020a19f113000000b00425930cf042so9163802lfh.22
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jtrvcTEGwPy+doq6FAEprW/B404oSxVLA6pPxuMbEOw=;
 b=NhJaFIONBT3ZPUfzYm0cbklgMHpy0SCuhM/IFEY+rALQkPF6V2UjzmHl6VlvdMd+Fa
 QBn9se365fe2/FOtTSncLMFvmRICdmag+sp/PF485WAmqlAZ+BSi+kRJ9I9U7D3RGPLz
 xP8PH8pyf+xtrFlOkMSkcOs9fa+Jr5p/Buj9gwIuREXZgcZVlQNo3S/fPXwTylnMtAwX
 wrLALWiA3qJSESMfMcIIsWbcfwOMHtx9bXnrzRQo18hz/rxpUN0PCSXgduSZLVOtQPa4
 FjG9jfXKPFSMxpJtBVPibDKZYR3i36M8PHoG1MO1MUB3GewTs1BBn0I+W4cga7aiQ/iv
 AHSA==
X-Gm-Message-State: AOAM532taeONowLASUwZuGFmqmGxck+nhvv732e+LpIXB6wqZW69Q21d
 8fTlAq7+hIjt0WfBTZRPVhDjLVaWIJ1bfktxgmcDjLP8dDTV7JifSFMj8USY0FNfFAixHjrPwGk
 mJbjB0B0GKH8TbKIWLyrF65LzazHI
X-Received: by 2002:a05:6512:3d9e:: with SMTP id
 k30mr47099312lfv.184.1641376810821; 
 Wed, 05 Jan 2022 02:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBPaXgX1KC5VStiZLGUVUOnFCYK7/EtL2yPS0jaY1tpEWocTA54Wy5VjrBs055fROZ8mCM6A==
X-Received: by 2002:a05:6512:3d9e:: with SMTP id
 k30mr47099298lfv.184.1641376810537; 
 Wed, 05 Jan 2022 02:00:10 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.09
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:10 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:01 -0800
Message-Id: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Expand Cgroup shell library
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

This patchset aims to expand the cgroup_lib shell library to simplify
and centralize the whole mounting and cleanup process that, with all the
different versions and mounting schemes, can get confusing and rather
redundant.

So the aim here is to centralize all the functionality to the already
existing cgroup C API which handles a lot of the corner cases and
complexity while still getting to use it from a shell environment which
some developers probably prefer to write their tests in. This also
seems important to make it easier to reconfigure the current tests
to work under cgroup v2 controllers, as well as for developers to write
tests for cgroup v2 controllers for which there doesen't seem to be very
much coverage at the moment.

Luke Nowakowski-Krijger (6):
  API/cgroup: Modify tst_cgroup_print_config for easier parsing and
    consumption
  API/cgroup: Add cgroup_find_root helper function
  API/cgroup: Add option for specific pid to tst_cgroup_opts
  API/cgroup: Implement tst_cgroup_load_config()
  tools: Implement tst_cgctl binary utility
  controllers: Expand cgroup_lib shell library

 include/tst_cgroup.h                       |   7 +-
 lib/tst_cgroup.c                           | 165 ++++++++++++++++++++-
 testcases/kernel/controllers/cgroup_lib.sh | 129 ++++++++++++++--
 tools/cgroup/Makefile                      |   7 +
 tools/cgroup/tst_cgctl.c                   |  69 +++++++++
 5 files changed, 355 insertions(+), 22 deletions(-)
 create mode 100644 tools/cgroup/Makefile
 create mode 100644 tools/cgroup/tst_cgctl.c

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
