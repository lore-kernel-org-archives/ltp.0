Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C629606A336
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=XpVvwDFL;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xoac4gmK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794839052; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Dj4CSmhc66PjSZbQ4Yk0nQRPAxg6oy5b0+R50oofVZg=;
 b=XpVvwDFLWRNDO0vSzvFter7+Xk1gWLXQ1NB1vTUDNlyPPGAVBIDcs0I3VCSm771QaQNcT
 vvWYq/EDkHWth6jwQSILMY6heZ1soJFbssVGgQOrSaOkeDQS1AZmVVeIYs1vGZyCAZWw5Qx
 9OZ8cA052e1Y5oGq5Rjn2zozyMR5ckU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86E553EAA1A
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:24:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 917DB3EA9DA
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:45 +0100 (CET)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com
 [IPv6:2607:f8b0:4864:20::548])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E8151400197
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:45 +0100 (CET)
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-cdb91e288d7so3249745a12.3
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838963; x=1795443763; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tXKYAiJhNP91pQ2RN2Ah3pUh5te0OF+ofXMzTDGoW4k=;
 b=Xoac4gmKDOi3WCuY+8SwlcWmFnvbsvlzrMgb00k7ELk4BPOTNyDIuz3E/nLbV0UHkK
 2A5Ob7DpnLKXzjtEZttYCAGSUvmSfywENUxxqUUxdpiNZkt7Kcf76TFMw5rwFX0+9+eA
 4N3kQu+X/VfJTGerHW2JJQcxDl1Kl9ovvOtafYWwwTUhY3C1OcW8C4Vxg6wSFycKxVPU
 ER2XKxhBCU86/UcyB67/8HkxV4H81UcIbJi6cZzatqTn+ABomn612u+njJBhWuIEX/Iy
 Kff/To6tf3rpV+H5i3jI7lDVlepGNevbwj45Zdo0CIj2lehNsCpJIJ6dJ/tPtaIKX6Id
 dccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838963; x=1795443763;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXKYAiJhNP91pQ2RN2Ah3pUh5te0OF+ofXMzTDGoW4k=;
 b=Wq3yw/e+NcFUzEaqkKDQvey7YhEyyF8HNq4fN4ZeNSDsa/J0KPhC9lnnj0UXTXM2Oi
 IvkgRbAjnWnhPh7R+bxd0tqhfzIsATkuUQe6oBk63TLVt0cUhPJ9TeSkVioT6n/XTQar
 iaH3FWnZKQlUNwdGD7NwlCAVtq+QkSl21ssysf9tTTG+prSDsU2gLlxsSGZtNS7ypFA4
 n7G8Ln8MYIr4i5wawTXqD1GbYWePGQbWP1JDSA2Otr+8/4rXvDwKS5EuHU4g+2osx1nh
 0QcvpkM3dKPdoqXI+LfSh8cqWXXhgQeCZWqZC+gjmblp4Kyrwv8O5VscxgUbR4S2lIgQ
 hc8Q==
X-Gm-Message-State: APuU4Z8Y/OR//Y9EPe2QNLbWkxdnYsDjF7PbdFQgEZLbtOolJa+94Po1
 pML6Q83FYF/MDr8AMFeCRCzxC0kDHdFjMtm2ElEcLKh06onxGFyeGj/ZfiC4Kkare7kVoVzim8c
 8JkA9K5T7Kndfl4j9/cB3/KTRdjPmGX7e3tgNQbMDdgSixOZo2vKoOoGGZE6pWET4oXwhE9fMn+
 eLig7hBmP4cyMj2R1DWFnu0pPXMg==
X-Received: from pjbhl14.prod.google.com ([2002:a17:90b:134e:b0:3b1:5195:b356])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5548:b0:3a4:adea:50ad
 with SMTP id 98e67ed59e1d1-3b1b09fcbd0mr10374585a91.27.1794838963032; Mon, 16
 Nov 2026 06:22:43 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:38 +0000
In-Reply-To: <20261116072346.2462510-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116072346.2462510-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142240.3153725-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] msync04,
 pipe2_04: Support kernel/userspace page size mismatch
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

This is the follow-up to the earlier series [1] for running LTP under
the 16K page size emulation of the Android Common Kernels [2]
(page_shift=14 on the kernel command line on x86_64), where the kernel
reports a 16K page size to userspace while keeping 4K pages internally.

These two patches were kept separate from [1] because they adjust how
msync04 and pipe2_04 verify the tested behavior:

- msync04: under the emulation, each /proc/self/pagemap entry covers
  four 4K kernel pages and therefore exposes no PFN (PFN == 0 even for
  root), so the test falls back to TCONF. When PM_PRESENT is set and
  PFN is 0, check Shared_Dirty and Private_Dirty of the mapping in
  /proc/self/smaps instead. Nothing changes on kernels that expose the
  PFN to root.
- pipe2_04: F_SETPIPE_SZ(0) rounds the capacity up to a single pipe
  buffer of one kernel page, which can be smaller or larger than
  getpagesize(). Only checking that F_GETPIPE_SZ on the other end
  matches the size returned by F_SETPIPE_SZ preserves the cross-fd
  check without assuming a pipe buffer is getpagesize() bytes.

Changes in v2:
- pipe2_04: Drop the check that the minimum pipe size doesn't exceed
  getpagesize(), which fails with 16K kernel pages and a 4K page size
  reported to userspace (Kalesh).
- Rebased on current master.

Tested on:
- x86_64 with a 4K page size (Debian, 7.1 kernel), where pipe2_04
  passes and both tests compile without warnings with gcc and clang.
- An Android x86_64 emulator with a 4K page size (6.6 kernel), where
  both tests pass before and after.
- An Android x86_64 Cuttlefish device running 6.18.32-android17 with
  page_shift=14, where msync04 goes from 4x TCONF to 4x TPASS and
  pipe2_04 goes from TFAIL to TPASS.

For v2, pipe2_04 was also run on the same Cuttlefish device and on
the 4K x86_64 host with getpagesize() and sysconf(_SC_PAGESIZE) wrapped
to return 1K, to mimic kernel pages that are larger than the page size
reported to userspace. v1 fails there with "Minimum pipe size (4096)
exceeds page size (1024)", while v2 passes both as is and wrapped.

v1: https://lore.kernel.org/ltp/20261116072346.2462510-1-wakel@google.com/

[1] https://lore.kernel.org/ltp/20261116142206.3151308-1-wakel@google.com/
[2] https://source.android.com/docs/core/architecture/16kb-page-size/getting-started-cf-x86-64-pgagnostic

Wake Liu (2):
  msync04: Check smaps when the page frame number is not exposed
  pipe2_04: Don't assume the minimum pipe size is getpagesize()

 testcases/kernel/syscalls/msync/msync04.c  | 46 +++++++++++++++++++++-
 testcases/kernel/syscalls/pipe2/pipe2_04.c | 15 ++++---
 2 files changed, 53 insertions(+), 8 deletions(-)


base-commit: c4be3107083cd11e4732884c4c8c5e9c6665e729
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
