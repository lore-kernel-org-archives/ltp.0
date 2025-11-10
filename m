Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D564DCCFA1A
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762742912; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=WxxgWGt8FmL0SUHwm2a6JMxNmb39LOK8WREBkcD653A=;
 b=hPHnIqP6tAyMBSaoKgYXB3Jc1fEuZ/YeK2vWtP/I5mkqZQjBTSwM8r77WFM49NAhDcCiF
 MIbQB+8JbcmkY1KkKkc7+R/6o6DE6fM83yStFpdH/qozquXLkxf//nLpCX7LQELsxhVA9dL
 upg3SvFoLxfQDoi7i3vJl76C+GwVCkw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E1693CF54C
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 03:48:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 342A63C9ACB
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:11 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28C4E1A003D3
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 03:48:10 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6407e617ad4so4302632a12.0
 for <ltp@lists.linux.it>; Sun, 09 Nov 2025 18:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762742889; x=1763347689; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N93VqJBF0U4Yl2+Ej3IRAvcK1rSppbRW3/SHoCfPTtg=;
 b=NHcs5c6QSbZ5wS5/2DxThZyA2z+dTRk/pbpUjEsxhQmhdv7sQeJZWyYB9mtt1cT8bu
 ANjagDATfaktOZucv0GljjgEGMYO7uLBhUuIJcVyBLLF0C1KSVoY++f3U2zAUo5Cx0t4
 Z8td5yrY42669ziRDxdSTAdL+CY7/q294z/g4/3eUuXNe6BAwaLMqOSaLSDwdQksqieg
 7ihUojcgmdMgVnhYYw/bE0IlWkFi3TTHUEfiP+zNCfNnr2gzWUnKUvyReFrKXvQhB4yo
 DsspZpkKM8aM6+eAPkiuGKLb5P1WXUpcTxeATlhS974F4rZ63mURNsE013D6nSrLAGMW
 wo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762742889; x=1763347689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N93VqJBF0U4Yl2+Ej3IRAvcK1rSppbRW3/SHoCfPTtg=;
 b=LpaVamNBFRv/oljv1biF2aiBrgs4omcQa/H/xohVAzluP5+gr+GH8kb87qco5BFI/J
 uS42KaWJfk76yMcWYqhb2RkiAPVR5cqXeinsIyVLepbk38SjBAq0P5x2htidwgScYNhy
 SE70ETlZw1p0qzJmQh5L9gVbXNueyb9Kg80B4aWkvvOlm0fuyWAx0Aw6gBCPUk0qNxii
 ctw+3ujeBdFmfsqcPE0X1Zg6DnAYSUS9UPDD/kilQEOe60Z6m9Od6K28HqWeuHqcaFql
 +nW6XNBw52iH7945EvNXKCYCURx9xNzAmn8jqylmphUbb+G8oFr1DNv9sVGDC2bsDeV0
 P7mw==
X-Gm-Message-State: AOJu0YxWOLxBzDAeDPq4zPluxdfZeREwTPRo4/xGLv1yGTxGIqgI7L+4
 V9xHZQFMwzONo2ESVL3MBi+5QadR8bzhDgx4UdbKHgImoa8CFNTEYqGAoYLMCMR/3nc9eVQTqER
 J9Os=
X-Gm-Gg: ASbGncuToSCm8lxZoBIbN4boYZE3OED/3vXmyi2BkvJzssw2jV2RSL0SFth5n72R5qh
 m/q8sv/W88hVir1wt28UWj3ud2rQ8iUNS15vg+DtPgKtZv+I7HTbrWDp0QJhhOMAc2HJgR0F2NC
 g82eos9GtZNSs2VOTPEwPjV9k732y+jA8Z3GYODdaaAuOhUrScnWvaw4Xku9KTxLnHrOk3ScUmU
 JXh27dKxbqOBUa2EV6ERvdFoJuzDBA63TJVSVNMvZ0WEHzvX+NC7/xVjvhEea879GmiZOWKFKQk
 vWlw+T5zPqyjmVg++Mu/N5CTYNO9OM1Ii4HDzPC6CsRFQk9L3NaE/Mb9Zja0NUy5IWSw3PdfTUb
 81NX3DXbZkH10I7LVajnQxNnH7Y4Cqu/4tcC6m2bcbFewC/k8alw5mTrlX7sI3sw0Ar8KZbtapb
 g=
X-Google-Smtp-Source: AGHT+IFlm0lZRJRKhviIGACB/9kQlulRLE2ttkojOh1H+HBPdAty081qbVMGjL5xhFOWc6YYrgeBqA==
X-Received: by 2002:a05:6402:1475:b0:640:cf58:47f9 with SMTP id
 4fb4d7f45d1cf-6415a077e9amr5631433a12.9.1762742889218; 
 Sun, 09 Nov 2025 18:48:09 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6411f862ca8sm10202041a12.28.2025.11.09.18.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 18:48:08 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 10 Nov 2025 02:47:52 +0000
Message-ID: <20251110024805.31070-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107003041.28929-1-wegao@suse.com>
References: <20251107003041.28929-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] new cmd support option for needs_cmds
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

v4->v5:
1.Remove https://patchwork.ozlabs.org/project/ltp/patch/20251107003041.28929-2-wegao@suse.com/
  since already rewritten by Petr's another patch.
2.Fix ioctl_loop01.c rebase issue.
3.Add expression check such as "mkfs.ext4 >= 1.0.0" into test case.


Wei Gao (3):
  lib: Add support option for .needs_cmds
  ioctl_loop01.c: Add new support .needs_cmds
  shell_loader_cmd.sh: New test case check needs_cmds

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
 lib/tst_test.c                                | 22 +++++--
 testcases/kernel/device-drivers/zram/zram03.c |  8 +--
 testcases/kernel/fs/squashfs/squashfs01.c     |  6 +-
 testcases/kernel/security/aslr/aslr01.c       |  6 +-
 testcases/kernel/syscalls/add_key/add_key05.c | 10 +--
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
 testcases/lib/tests/shell_loader_cmd.sh       | 28 +++++++++
 testcases/lib/tst_run_shell.c                 | 61 ++++++++++++++++++-
 30 files changed, 231 insertions(+), 104 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_cmd.sh

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
