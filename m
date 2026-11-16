Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD597606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Quw8o1qN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lIwrxNaH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794838952; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ok43+B6L1qNUvUYFm4AK+98TUs4vjk7kQn+09tsWZBs=;
 b=Quw8o1qNgLDPGBYYsDLsAPWvr55PBKujhMnqWJcyjUjkxwdya6tmr28id9czYGCeN2VMw
 ktw/OjxyMNg1+TEqDlBYfX/ydwTyKg3stTAksQ57x6k9LZsdsXOp5jXaTI5biZZfr/lGNBT
 zhVMqz6mYpm9uEiCkK3HQ93UKlTAdPE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B143E595E
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:22:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D47E33E595E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:11 +0100 (CET)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 16B3A1000234
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:11 +0100 (CET)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8b847ab3fd3so1551512b3a.2
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838929; x=1795443729; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wc+GaO4B0uqeDDy8B4cEgoLECW5rZooO8ZVisSZzBcA=;
 b=lIwrxNaHh8u778CDHY2elmTj6OyUpF+m/DYlHHcnSAKnueF9ae+sHQ3UEHW+vEdeqg
 N0dc6Gb4aTzCs8P4gj4LRLf3WtNW6w5M/6b73sZqCUOsvRcIvFaHJt7zZDIrNAKs8COE
 TacImbc96NU5HeDq21uDzDWkmMWy+YYoHduiFnWdp9RuJf6jPlqCNhXwDCRbBBcFyqZ2
 p4G5G9DAzwXwwMM6l5COSn/kBUvMH7ZPv8ve2diOqdoscpysosQFmYSJsPrNxWRhdZIl
 tl9kBEWwppGZ/5CsptRA2uAxjqFLqC/02HBadcTVQxFz06Syo2/aouB5gKH66A7bOFpi
 Yzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838929; x=1795443729;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wc+GaO4B0uqeDDy8B4cEgoLECW5rZooO8ZVisSZzBcA=;
 b=Ml+vzZ33SAIZ6r2vIwR3N1A+z0TJU17gbqK76Dr4X6n3i+D5D5ppQ1xmXVInLFT66S
 qK93UNsKQ11D5OaoiWpJf+uFrbdYGt0cYh3FCeJQ13l1YmG0jVBxDdznlqEl/fMra8Lq
 D1QnnIUU3UFq3mjRm2UeofKn+LxtflZGpRd+dNXM0Eb5KgexV1lEXxLMrWrIv1+JNtCT
 6bmpeEFiEGKR+A/UYmu2lTR7wuCCT9Wb/Lw0lirvAveqwpcIQC6G/PtU4E+/nqwEwGMc
 hQTNlNuJEh7Bme7Myqd3Fe5T/sjLxTvP3JJ62F7tk+CEyzntgMZuJ6ESr0Qe4z6Qz/fZ
 IC2w==
X-Gm-Message-State: APuU4Z/DXiNIppP1+TBifBzgCc3FTr6KskRe5Pi+Ok7Th6oYOh3/RczX
 EQhOYrJKU+t9D0+UOP7gXDfJR9q9dJNZ0bC01t+Hs+horKL6KSdSnxktYQ3ROP0IlxppaC59olI
 RBrQsxc7zKdD9DTB+Ge6j5r6DI97msXtcCDPQaWc9P4aF7ORXOEkZI9sa/Tl1jjnsFrm9P41d+v
 AsoQELpUvzOmnibq8SgWB9VgYkAg==
X-Received: from pfbge4.prod.google.com ([2002:a05:6a00:8384:b0:88f:dade:52e])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88d1:0:b0:8a0:5da1:2264
 with SMTP id d2e1a72fcca58-8beb792923amr10216506b3a.47.1794838929019; Mon, 16
 Nov 2026 06:22:09 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:02 +0000
In-Reply-To: <20261111093151.374731-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142206.3151308-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Don't derive kernel granularities from
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

Changes in v2:
- fcntl35: Use the pipe buffer size for the unprivileged case too, as
  suggested by Kalesh. pipe-max-size can't be lower than a single pipe
  buffer, so with 16K kernel pages and a 4K page size reported to
  userspace, setting it to getpagesize() still allowed 16K pipes.
- Rebased on current master.

Tested on:
- x86_64 with a 4K page size (Debian, 7.1 kernel), where epoll_wait06,
  ioctl10 and signal06 pass before and after the series, and all
  changed tests compile without warnings with gcc and clang.
- An Android x86_64 emulator with a 4K page size (6.6 kernel), where
  the results are the same before and after the series.
- An Android x86_64 Cuttlefish device running 6.18.32-android17 with
  page_shift=14, where all of the patched tests fail without the series
  and pass with it.

For v2, fcntl35 and epoll_wait06 were also run as root on the same
Cuttlefish device with getpagesize() and sysconf(_SC_PAGESIZE) wrapped
to return 1K, to mimic kernel pages that are larger than the page size
reported to userspace. Both fail there without the series, v1 still
fails the unprivileged case of fcntl35, and v2 passes. epoll_wait06,
ioctl10 and signal06 also pass with the series on the 4K x86_64 host
with getpagesize() interposed to return 1K or 16K.

v1: https://lore.kernel.org/ltp/20261111093151.374731-1-wakel@google.com/

[1] https://source.android.com/docs/core/architecture/16kb-page-size/getting-started-cf-x86-64-pgagnostic

Wake Liu (4):
  epoll_wait06, fcntl35: Don't assume a pipe buffer is getpagesize()
  memcg, userfaultfd07: Populate whole pages instead of single bytes
  ioctl10: Compare vma_page_size with KernelPageSize from smaps
  signal06: Allocate the alternate signal stack with mmap()

 .../controllers/memcg/control/mem_process.c   | 11 +++---
 .../kernel/controllers/memcg/memcontrol02.c   | 13 +++----
 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 15 +++++---
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 21 +++++++++++-
 testcases/kernel/syscalls/ioctl/ioctl10.c     | 34 ++++++++++++++++++-
 testcases/kernel/syscalls/signal/signal06.c   | 15 +++++---
 .../syscalls/userfaultfd/userfaultfd07.c      | 11 ++++--
 7 files changed, 96 insertions(+), 24 deletions(-)


base-commit: c4be3107083cd11e4732884c4c8c5e9c6665e729
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
