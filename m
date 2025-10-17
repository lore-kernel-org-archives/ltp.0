Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA663CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760695836; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=quKIeCOnuhdxRm98KsJ4Hojaqvfbzl2a+KousMnqcG0=;
 b=hPix7ibsg+yUPrKyxufgnbycPCdDFcR7bWOoWRDbdrmFlJ2CGM7tvnXGkVTCor0JGG1F7
 DGsMgclyful5YBilpXBGKuCdsN+i/GJHrPHennThfA1GQRB9wmOkNI55UnlY0xg5S3TKmoz
 CAZFLVtaw2SpEiw2rNrUsYbW7xCuABk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 849283CEE35
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 12:10:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3A53CEB80
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:15 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6447C600294
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 12:10:15 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so1162848f8f.0
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760695814; x=1761300614; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjPVXFDqKmgoxxYNhsBdmChdJy3HE94h5ZF5hP9P2l4=;
 b=cBKGEgAkSSktZ8vvULTi+qr9G812F8aWHpgr7JfMjd/SrmR6I55rYqezleuGrOGqpc
 83Kj1pOLUNaG8MVcWrbAU7v7pZfkU0lmhlcAffdGIzJykyvugAs+4Tm1OpPD0FElbZZI
 CfS8FmWLpht4kN+EL+In7qavxbQlViPqUMB4H8bnbhDzIrUiW/As0yqWNTRzfQ5I0hw/
 TGgY23CwdAD+WkPlpPAd5ZNlti05TbUNNE99DuIU+5eFlLcMxbuViu7TXksAq8Y+Nc9O
 DNvfXtc68XKBQtGSTgO7luCqeHaBre2nTpfYzPJDkH77QNZZC4irdkHjrJ63amYg2G4W
 reRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760695814; x=1761300614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjPVXFDqKmgoxxYNhsBdmChdJy3HE94h5ZF5hP9P2l4=;
 b=fpw/GhSZAXWBfa+5+wHnLBfWFRv0P2zn/HPOofPuHxRt/FXiMROzPS6dTIzhbI9X5+
 9him5Guw6f38jXr51MbzOhQmLaTb//dqwDO6EfxKyVvUwhZ6Gk08MFdL+6VRMFyx6B8L
 ZibuLfzlkbfUvHikBOAsiqob94VV4dnKhFrefnoQFHtowjw03fXFwhCLWyJp+mlx9RaL
 J0I5G6Im84TF1FY2cwdkcyZD2ZFhdx/yv6vkeqlrlogSRiGCBPAcoM1t1AZIezhvwVKn
 foVDCtKELbwQgOxi1umCjJEpHs4IP2skmPpNXIb6UFDuYchiDUY7a5u08ftZ3gJqvN50
 KFuw==
X-Gm-Message-State: AOJu0YyzHESRTBFPO0fFn+0dExkQ8AXaxV660z6ZdfJBghmiwo2ZvW51
 0rtPtOnQWWxxOJ9kbB8BhW4Dy83AAEhOblp9ULQ7s/xS1D9Fpjqv9Leaqrze2GpdeS7vjOL4aT2
 Xl6s=
X-Gm-Gg: ASbGncv1x/q+k+VQ55VJyOL2FluqXz+BSefLqmDHTFWJUBqmqQwOsvCwGsxBArWPlod
 paHBWPwGCwlCdapTOMRKEevWKcqtRFAFhuOeKzbk8as/4pmdO5aaBktz6ZCV7FXWQx+GixPi2dY
 75yWKf83bP4NabMWQ7kZ6s5oyxrk/7VAbzBocbZQIn+FY73xNRAKWAIUyYbG4J7/3iHxpm4MZhy
 03rmVD0fruHwVguJsTqyEnKSuVE5tEao1MYCFs0AJqgLhOYKqMXvtGsI6HkppdyQvLD6qbBXs3K
 4bIG+MHMTmm7fbapVSUJQjbXr7pam5o5NGDo/qXM7bSzZcAp9hm1G6xP6yo2cLuEUDpTOTM2HEn
 Dmw9ntRHfVn3bo9finWGqKZB20TmK0K7dsX3EQCH7nksjaVtrbc+66WCEBDNiYz9l
X-Google-Smtp-Source: AGHT+IF+5c7h4GTS7ufNqRr3ap6QgQctydck5JoNb0OIzkCj1yFAY4JbWLGAw4juRD/gIYz1HxYG8w==
X-Received: by 2002:a05:6000:22c5:b0:427:4a2:5124 with SMTP id
 ffacd0b85a97d-42704ca720amr2142822f8f.0.1760695814482; 
 Fri, 17 Oct 2025 03:10:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-426ce5d015esm40884690f8f.33.2025.10.17.03.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 03:10:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Oct 2025 10:09:55 +0000
Message-ID: <20251017101011.3811-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] new cmd support option for needs_cmds
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

Wei Gao (3):
  lib: Add support option for .needs_cmds
  Update test cases use new needs_cmds
  tst_run_shell.c: Add new function handle new needs_cmds

 include/tst_cmd.h                             | 13 ++++
 include/tst_test.h                            | 16 ++++-
 lib/newlib_tests/tst_needs_cmds01.c           | 16 ++---
 lib/newlib_tests/tst_needs_cmds02.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds03.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds04.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds05.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds06.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds07.c           |  6 +-
 lib/newlib_tests/tst_needs_cmds08.c           |  8 +--
 lib/tst_cmd.c                                 |  7 ++-
 lib/tst_test.c                                | 22 +++++--
 testcases/kernel/device-drivers/zram/zram03.c |  8 +--
 testcases/kernel/fs/squashfs/squashfs01.c     |  6 +-
 testcases/kernel/security/aslr/aslr01.c       |  6 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 10 +--
 .../kernel/syscalls/fanotify/fanotify22.c     |  6 +-
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  6 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 28 ++++-----
 testcases/kernel/syscalls/madvise/madvise11.c |  8 +--
 .../kernel/syscalls/quotactl/quotactl01.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |  6 +-
 .../kernel/syscalls/quotactl/quotactl09.c     |  6 +-
 testcases/kernel/syscalls/statx/statx05.c     |  8 +--
 testcases/kernel/syscalls/statx/statx07.c     |  6 +-
 testcases/kernel/syscalls/statx/statx09.c     |  6 +-
 testcases/lib/tst_run_shell.c                 | 61 ++++++++++++++++++-
 29 files changed, 205 insertions(+), 102 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
