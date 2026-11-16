Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AA606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=eed2IxRq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UrH7zmGy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794813852; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=3VZ84/MQ9Bm5RAoalGRJSVw5D99Fm8xpIRd4uh4ottw=;
 b=eed2IxRqHSefuvkE0a+DWh+/5WlQ0lw6f2A5fqu3T8bHbG/XTikH5/j5UR4Geepkaevem
 Dj0gn6L/1x7mOQPBnKA6wTZxlS/MjuBtZLMOajFdBasLpjwdhx0ha/BcJbSBadF+OW/PUkG
 ZFsG4F4mgFVPtjZteOA2M+SUyzHFjBY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DE753E483B
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:24:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FBD83CD3B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:51 +0100 (CET)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com
 [IPv6:2607:f8b0:4864:20::448])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34A4960004C
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:51 +0100 (CET)
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8a0619b1fe5so2104783b3a.3
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794813829; x=1795418629; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e7gPBc78Lf2UfUeigZBtsSNND0wr8T93abWWKi/99+Q=;
 b=UrH7zmGyB3lu0pXDFFi3iYkLuVAccJ10sdaNOyQC6evTcyZnzX1s3oKwFoawCPxOph
 hjGzYIoA8hsUOufRMHNLHZjDGqOblV8CPi460wwoxwvsBY8SnZMkRz76KYjvmAeobO9e
 gUW5CdEOOdghLTguXtn+tW6846AqDKgSniACjhmngUqdKG++xLVJb0MAo4tT5cKx7Atg
 qOKJH6m5Vm3PhuTLiW8VwI2Q2VHUw9FojG2LW9/EaJoAH4R6tDmhk2wzqw2tND0KQEBX
 fzO9D9KLEI8Gzuiygw6JlDU6PM2cDWfL12QGUOhte1eo9iv4xr1ZsxbuPaZYl5Wz2EfD
 uhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794813829; x=1795418629;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e7gPBc78Lf2UfUeigZBtsSNND0wr8T93abWWKi/99+Q=;
 b=s+f3DzRST7WaC3jg4SRZJkQVhFnHkqEYESPRnDLvB+P5AYXcYqs3dysGytskL5VDkO
 CWY9ekz4eo/wF4SGM3jSjuFj3FHFdpB5df4oG+nP4rc+WXm3HSOe4chP9bSpT8Q9EVno
 wJx/9GYzKXmrgwyymX5nLLTpKAhMm2kQWZe37FF1OUe39X9O/zRC9Mp6dYvvPEdpoyLl
 4YzGAMFKoB17VLgXPz/ikx1GjscCVxeJN++D7QFA9rftphz99dj2UD/b10shvzRYf7FD
 80GHaFxwU/EF7Vp5lLGQRxiAwSb9y+lF9VVf+McqPrdiiIyLPwbmshMK9XKJuQoKGka6
 3ryw==
X-Gm-Message-State: APuU4Z/ZKBjVxcrnTAG7VLUzybhzJnWZUTbR5oc0pc6GuNMbMCy3FTzq
 31Ym9ZTLKxTt3vjPJsgLK/bShhCiSqDCRlRzH/ec0BzuHHScRQAyLKuIMt/UyAZ+crr2Mdcoxuf
 5fsk2MblgnlIe03Rpn8rhAueBv5rsru8PAufxqnUkNbtKJITZ/dG0CSb4vFBWWzOx0aVehEo9w/
 v9Q/SSHBKXuDgp5uyScLtm7sOt3g==
X-Received: from pffi13-n1.prod.google.com
 ([2002:a05:6a00:c28d:10b0:8b6:9f1c:546])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:909e:b0:874:705d:f640
 with SMTP id d2e1a72fcca58-8beb677f05fmr6925551b3a.34.1794813828983; Sun, 15
 Nov 2026 23:23:48 -0800 (PST)
Date: Mon, 16 Nov 2026 07:23:44 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116072346.2462510-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] msync04,
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
- pipe2_04: F_SETPIPE_SZ(0) rounds the capacity up to one pipe buffer
  (one 4K kernel page), so checking that F_GETPIPE_SZ on the other end
  matches the size returned by F_SETPIPE_SZ and does not exceed
  getpagesize() preserves the cross-fd check without assuming a pipe
  buffer is getpagesize() bytes.

Tested on:
- x86_64 with a 4K page size (Debian, 7.1 kernel), where pipe2_04
  passes and both tests compile without warnings with gcc and clang.
- An Android x86_64 emulator with a 4K page size (6.6 kernel), where
  both tests pass before and after.
- An Android x86_64 Cuttlefish device running 6.18.32-android17 with
  page_shift=14, where msync04 goes from 4x TCONF to 4x TPASS and
  pipe2_04 goes from TFAIL to TPASS.

[1] https://lore.kernel.org/ltp/20261111093151.374731-1-wakel@google.com/
[2] https://source.android.com/docs/core/architecture/16kb-page-size/getting-started-cf-x86-64-pgagnostic

Wake Liu (2):
  msync04: Check smaps when the page frame number is not exposed
  pipe2_04: Don't assume the minimum pipe size is getpagesize()

 testcases/kernel/syscalls/msync/msync04.c  | 46 +++++++++++++++++++++-
 testcases/kernel/syscalls/pipe2/pipe2_04.c | 17 +++++---
 2 files changed, 56 insertions(+), 7 deletions(-)


base-commit: 686a331b6240e54ac3170717adfd28ec94cfe100
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
