Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1417D232E2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 06:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767939465; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UzfVtXLmsXI7ZssxbpSUQ5duxKYzP/vMSkCnosgTYWM=;
 b=R3+k/DbH0FbIa63tRDK6ZYfWYa3ngTbzNJgOnC+xHpU3Mdb/P+Bz7t4Bm93cPpgsEGgc7
 kGevb7m+lMzsYbT0ymtNuJQn906TxDftmJddPTrknMIqJrchzfWJwRggxvHlwz+lXUJKJFN
 79CRTosPSc90lgRwTy/QrEk7A/PhLUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0C793C6AF6
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 07:17:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78D703C54E7
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:20 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B19C1A002E8
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 07:17:19 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so2074307f8f.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 22:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767939438; x=1768544238; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onWuG+WaCxh9/9LnjPWT0Rowu1Bwa2xqMgpIXZ2xI5s=;
 b=Q/bQ1s9tMOAp5JEYFA/Gexw9H3VzqjgGmvbbrkAone0Kdde0GAV9/Tpzu6k/dKtATI
 f8sfVi7bX/Nhlp2lPoDn7YmvsuLAjZQ18K53QPJ0DSa82ofeHyRBWW76ccFX4ZNDeJYf
 EWt5gJXYbYi8VnBOZMcPSDNPsCTCqYBk5KLoHowgvr/SsC+pEmPhruMRM8yw140H0muG
 3TvRb8FWExiRIqv+AghCgpuQQ+iZ65umBiDo3fWKxNOmf6WaQ9mbkJ5ZQO52qptQueKu
 FaptRH8SQ8jgHovzjZYf6Xx3GfNJGK06VtD52AuiISlWO5TSw0GuOncg6t95VBXP8AnU
 FLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767939438; x=1768544238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onWuG+WaCxh9/9LnjPWT0Rowu1Bwa2xqMgpIXZ2xI5s=;
 b=m3UVXQq9HyToNgoNMBOIfUQ0yzR66MY1njGbGflVK2pPZdSh9fpSf/2iiAI+V9IYqY
 RSSwJA78z4TEzCEGGl/WdO5agfxUFOQ+MR0/lt8icingwaYwzA0h/xuQ9fMrYTIF1Ud/
 gWEyrrXdyi6zXQLGY/mIotPRhbIX0dAcpRDGi2TY4FNFlY1mr2DWt7H+PxZ7SWaoYWzT
 d14XJndw8wt93zywu0Bl56d2/QqUxiiX9cQ6dNp6WGUhoXmJ65e8ufDGbmRG34uhSY48
 39g1NGYoCUY13zOf6EYrbXPI4gJEvGaxdNnLhj+ji8XUw/NbG7S6bo6Z8PTBexf9GA6y
 SRJg==
X-Gm-Message-State: AOJu0YwSJFraJriW7PMlMeyMPBesaLhksQ/JqCtznlkc/z0ezqkBHzwJ
 eldypAZx+4C8tH3D/rcA2H+KHKbiOsQ/kanHgC1DEY2cBbQMqiZRKW1KDmhg7pYyieYgx5SdC5f
 bJW0=
X-Gm-Gg: AY/fxX7dfMfIZQMRAK9Md2weLAGyaCD4wBLkqiWJZsjSISPfq0A/PS8wPK440lzI4Zj
 xSq0D2SjT3pg7n/awcY+Y6dAPYwXsZJNkRhvjJ6WCdhyLJEP+GOSp38RmN68cIlOa9BNLXO3BDb
 4BdvTruvSIcgKOWahf9MmPnD5AQHyODhx5URIPjD77R4GSJvMVlB3E23wLNCJGpKMxDetGCsFCs
 3/nGyY2palcCl3REh+ZAKLhz9L12vx+1v1Tog3fXSCE1EcKxjIeoM1EbAndvzSREfeNmf5dTwUu
 P5mvIouuK/rvHrNaOpv2IH8kKpgWJOhk5gKTNQrMeOIcOECgWRYFOz2fZnROhDT2oq4yXyJvn0R
 sjdWcw/Nz7JYedodbjJRyS+4khPMcGhjNTGD/qo3DR2doX2XYwF2AiwO7lNHu6TF6IWNc8WyubG
 8=
X-Google-Smtp-Source: AGHT+IHflc263rD+8htzqa1p3IhPSMe4auEd02eSwBalu+rA7uDWFvJxjcYv5/7OoTaulchc8mthzw==
X-Received: by 2002:a5d:584c:0:b0:42f:8816:a506 with SMTP id
 ffacd0b85a97d-432c37769f9mr10345281f8f.63.1767939438543; 
 Thu, 08 Jan 2026 22:17:18 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-432bd0e6784sm20539028f8f.19.2026.01.08.22.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:17:18 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 06:16:29 +0000
Message-ID: <20260109061716.20258-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223020836.9439-1-wegao@suse.com>
References: <20251223020836.9439-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] new cmd support option for needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v6->v7: 
1) Add tst_brk in tst_cmd_present
2) Remove "present" attribute from the json parser

Wei Gao (4):
  lib: Add support option for .needs_cmds
  tst_test.c: Add tst_cmd_present check if a command is present
  ioctl_loop01.c: Add new support .needs_cmds
  shell_loader_cmd.sh: New test case check needs_cmds

 include/tst_cmd.h                             | 13 +++++
 include/tst_test.h                            | 16 +++++-
 lib/newlib_tests/tst_needs_cmds01.c           | 16 +++---
 lib/newlib_tests/tst_needs_cmds02.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds03.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds04.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds05.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds06.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds07.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds08.c           |  8 +--
 lib/tst_test.c                                | 27 +++++++--
 testcases/kernel/device-drivers/zram/zram03.c |  8 +--
 testcases/kernel/fs/squashfs/squashfs01.c     |  6 +-
 testcases/kernel/security/aslr/aslr01.c       |  6 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 10 ++--
 .../kernel/syscalls/fanotify/fanotify22.c     |  6 +-
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  6 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 +++++------
 testcases/kernel/syscalls/madvise/madvise11.c |  8 +--
 .../kernel/syscalls/quotactl/quotactl01.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl09.c     |  6 +-
 testcases/kernel/syscalls/statx/statx05.c     |  8 +--
 testcases/kernel/syscalls/statx/statx07.c     |  6 +-
 testcases/kernel/syscalls/statx/statx09.c     |  6 +-
 testcases/lib/run_tests.sh                    |  1 +
 testcases/lib/tests/shell_loader_cmd.sh       | 28 ++++++++++
 testcases/lib/tst_run_shell.c                 | 56 ++++++++++++++++++-
 30 files changed, 231 insertions(+), 104 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_cmd.sh

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
