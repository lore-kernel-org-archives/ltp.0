Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F9606A321
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=UvkVk62K;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZJzvME8c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794389537; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ymC/y5bop7gXW91Ctov7Jk+Z/fYKdvjhhSwhUquic/M=;
 b=UvkVk62KG0ANMl/ZinHt/3B8EMkGpRck0r939EMaQz3xJhu2pDlr89qzpSQU+dIMFfwC2
 WiN9FS07a33NwYFyAxmzTCVm3ElnMp6DFe2kvyl/NJ5+j+epttWBvsRwQ7uKSCcf997qu1L
 hPFHFuagJSUyTUKtsv+viHCLefs1gjs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24A823E9504
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 10:32:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11B113C99C9
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:31:56 +0100 (CET)
Received: from mail-dy1-x1346.google.com (mail-dy1-x1346.google.com
 [IPv6:2607:f8b0:4864:20::1346])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FB6E600A47
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 10:31:56 +0100 (CET)
Received: by mail-dy1-x1346.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3692605eec.0
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794389515; x=1794994315; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fPmks5qJ/8E79TtiKeILqKlrPZwiVmi8Xwnka8X1P6c=;
 b=ZJzvME8cveCJ31pSVfjxsUrw6avKCKL3WfQk2Kmo3z6gGFT77zfMvPRsAze5UEV6dS
 0WrLwvVK1XGHCmz7JkNLNcFCrC8nC1knBpI6lPMx52+lNbkeSmD8Dxucfr2FFee/cg+1
 tDVBH3QfOibrzoUQshREdX6LuOI17aU5upbdx22DF2xmxkoTIGGHmq/NmHTPaZsKJ31c
 9nnJQPIasWHROQbJFsL1A/Ynecv1sjqj6sUbuVAqf5v00eZABGWpQn6z8PIVQV90qvoe
 xx4vM+0JK97QaLUBjBR/Vt+7Q5sH5+a8hJGFSt73ClATQvEzkQq+wentsGj3J1FeGpYG
 8hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389515; x=1794994315;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fPmks5qJ/8E79TtiKeILqKlrPZwiVmi8Xwnka8X1P6c=;
 b=hbx/0+7hAmejoxyz9nGLfg4Jx3YifQQUom7Mwt7DdobMO8sz8Zuu4djZ+LFlhCUt5C
 XNnatwDpapp9QCkknfRYOaBkVk4rCDAPaUFvC6fj48GH2t6qTvkeoTQuew5+E0VF1Ar7
 zcyPQbhiS/PZvdOr+gF77wVlOB1PcFWk96KacEVL+IIpOhoPBqH2qWRWTXl9DIdrtGKc
 HtCDpG7bsCTsBQxWAOwHqM0op8EvZyqNcvWZAambXaY0Wbhr3tQ3OaSc3EOnh/E/dCtY
 S8awenQypYqnACtOL4li79IyuLMUZo4mZui0bZ921pmsbVfuanaL4ikTsepKrp3hBWth
 UE/Q==
X-Gm-Message-State: APuU4Z+wkETUER6j9wV7bnaij1BrHxqwrHFplurYyzToeNtI5+WV1NYQ
 1pRiz5vE8L2DnwqSPbop8PDy6Ee7umZBZtNs5rDhVBSNhAsJTIlsktPThs29boigKsk0RONZ6CP
 JVAt03ydaHdAg1/EVa+IwKQ/J/05+2XUGlMu25/B4eweb0WxPqPJ7q/rLxlN1j5Pd8H7MeapXQe
 CIuvfEHsGSgKHsFoXs5ziYuV3VLA==
X-Received: from dlak27.prod.google.com ([2002:a05:701b:291b:b0:1b3:b4b8:1a68])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ec02:b0:1af:16c4:d06b
 with SMTP id a92af1059eb24-1b3c02f36ebmr2068677c88.10.1794389514147; Wed, 11
 Nov 2026 01:31:54 -0800 (PST)
Date: Wed, 11 Nov 2026 09:31:47 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111093151.374731-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: [LTP] [PATCH 0/4] Don't derive kernel granularities from
 getpagesize()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Several tests derive kernel internal granularities from getpagesize():
the size of a pipe buffer, the granularity memory is faulted in and
cached with, or the page size reported by PROCMAP_QUERY. On mainline
kernels all of these are the same value, so the assumption never shows.

Android runs LTP on x86_64 emulators that boot a 4K kernel with the
page size emulation of the Android Common Kernels [1], enabled by
page_shift=14 on the kernel command line. It is not part of mainline.
The kernel reports a 16K page size to userspace through AT_PAGESZ and
enforces 16K alignment for mmap() and friends, while it keeps using 4K
pages internally. Interfaces that userspace commonly relies on, such as
mincore() and /proc/pid/pagemap, are emulated as well, but pipe
buffers, page fault, page cache and memcg accounting granularity, and
the KernelPageSize reported in smaps and by PROCMAP_QUERY keep
reflecting the real 4K kernel page size.

Android has carried local workarounds for these tests so far. This
series instead makes the tests rely on what the kernel reports, or
populate memory independently of the page size, so that Android can run
them unmodified. The patches are grouped by the assumption they remove.
None of them alters the behavior on kernels where both page sizes are
equal, and none adds emulation specific code to the tests.

Tested on:
- x86_64 with a 4K page size (Debian, 7.1 kernel), where epoll_wait06,
  ioctl10 and signal06 pass before and after the series, and all
  changed tests compile without warnings with gcc and clang.
- An Android x86_64 emulator with a 4K page size (6.6 kernel), where
  the results are the same before and after the series.
- An Android x86_64 Cuttlefish device running 6.18.32-android17 with
  page_shift=14, where all of the patched tests fail without the series
  and pass with it.

Changes to pipe2_04 and msync04 for the same setup alter what those
tests check, so I will send them separately.

[1] https://source.android.com/docs/core/architecture/16kb-page-size/getting-started-cf-x86-64-pgagnostic

Wake Liu (4):
  epoll_wait06, fcntl35: Don't assume a pipe buffer is getpagesize()
  memcg, userfaultfd07: Populate whole pages instead of single bytes
  ioctl10: Compare vma_page_size with KernelPageSize from smaps
  signal06: Allocate the alternate signal stack with mmap()

 .../controllers/memcg/control/mem_process.c   | 11 +++---
 .../kernel/controllers/memcg/memcontrol02.c   | 13 +++----
 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 15 +++++---
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 20 ++++++++++-
 testcases/kernel/syscalls/ioctl/ioctl10.c     | 34 ++++++++++++++++++-
 testcases/kernel/syscalls/signal/signal06.c   | 15 +++++---
 .../syscalls/userfaultfd/userfaultfd07.c      | 11 ++++--
 7 files changed, 95 insertions(+), 24 deletions(-)


base-commit: 0ee0ca5460402f6219df4da3e28b7c4aa4b8207d
-- 
2.56.0.567.gdb80ae8cd5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
