Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EE1E6B26E
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766455744; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bjdVYL1Qoh0Wwr+o7rqNXiH3pzuK9GC2cPT9ILcCwGc=;
 b=Y4GKu2CxlRzEjFIc28Qx61zfgBWaMAuJqIK0I4MqYqcKuS6HI9sY0Y+0giIdeXrH/R0XY
 Bks+gZWsVy6gYFhUUTHOIMv/z+zyT2YppTqZ2DIQZA4LeKFMqXBIJAepHTaEHkS2VzTLxs3
 i1gwCmQotDNQnXhMnDmU1OqP/0DmJqU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9ED3D0733
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 03:09:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77E753D044E
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:40 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B32E3600A63
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 03:08:39 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so28700385e9.3
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 18:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766455719; x=1767060519; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u0QaC7PrUMkAMLUuHYhNWj3mCRo4dOhLCfIDC3tJA8=;
 b=FlSp28MDEDv6RJ1vLjtXgiNLjqyQc2XDTJ84aPm8eD0qi5iDZbJv14B4M6VgafnxU1
 ecHLT3HYrLza9JA3Yx/3z78jnSq6kyhdD0fWymETdJLeYgv7+Q/+ZCWqu9NZ7AEuEj7w
 2GECErk7uDglf5XmIK72FIZff5barz0LrnWCf0jBmhOYvmDAVBqeivN/ibD1y9GlfGBV
 nEKf41YfZ1e5ULIIwBSEvQ3zCleiqyl+PFa8uh6f6otMNRZfnHsMmQv6GcZv/5biCXm3
 bZHXZOwUA7Gp0/NgQpna57bonONOu56jgOA+YR1FssRE5g2uVwgtHfD9Fai7wz+H7oVG
 zCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766455719; x=1767060519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1u0QaC7PrUMkAMLUuHYhNWj3mCRo4dOhLCfIDC3tJA8=;
 b=rQO6c3koEHIcslryWTbc+K7Rp3pcL6/CydOPsvWOnaKlv2KqZOjZdyzL1vVSrQZiHE
 VFMjeqD2y3e6cALwHeZmnqUmtr6tV+ObNckFzL0linwPxcWIkDmPT5EadLLpOSLl7hqp
 cL6vg7Hj3p7bFdTKxAkI6PfmzboenfdFvACamLp6FCQP/DQtY6ii6Mc5ABuGcKJ0EMfd
 a/KgBmtUZ37PzhMvCGINK9Loi2hyR2lTPd/uEXniErwr3RV1CoLMr+TGUy//0/Mbh5pS
 S9jDWzx+9pXXQdnVi3Kjk+M/g1W7nM8GFruvUrT9naKRW5ovgWlM9ekX0rjV67VgPxRU
 r1kg==
X-Gm-Message-State: AOJu0YwvufMaEAi1P31rUwV1cq6uKGsIJ+GsZIiEsPsTTCfh9dxBVFgG
 4y+iSrjEJ+/Du+ovOrggr2X5A/CpjJH7GvLPtpteZEQoCR9xmBbaOC61lN6LBJ6gmYIzjzgDmTj
 SSzc=
X-Gm-Gg: AY/fxX5VsUU9bmZKeSw0XPsMRubG35ww5q7/CvmIlTxoKY9fBjONAvifE43eTebYM+r
 dZN5r9c/gbKglANK2JsmuwQBr4kXTih+O0oQzkEx/K6ogGnm5bOwnKsD0o/ECsxj37Kp7tyxw44
 CjDMV109N7OhgQxTu93xFd/tPxtDjZV6zjCHS3uDHle+GPL9J48htntPzVSgtWxBS20eNcmGIXI
 8XvA+Tm+NEYmSX0XBYG1pszppJd+tEng3E3ck32CdV1aHmwHKbYx4W+zT49kPcpcCkw8WLE98DA
 GhiE9YPx3XapUOpxOQFpE9jetbL8rjZM/sweh3qbmHOKz8MK8gz4YJ9fcxZ5DLtRG2ePAUT3Wga
 RMrygKAhb76K5M0UyAmttR+P/BycgLYUmkOWu5ooXwAQnrhl1j95tbMP8U1J8d/ECQvb3kSU1g2
 U=
X-Google-Smtp-Source: AGHT+IHqAIFE3M/muoDW7nOweBs0XsSiCKIOT0N0giNecc+fYKvi6GZDKa/vfTfhj55nyOA88doiPA==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id
 ffacd0b85a97d-4324e50b88emr13821219f8f.46.1766455718910; 
 Mon, 22 Dec 2025 18:08:38 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4325b6bfe88sm16585635f8f.19.2025.12.22.18.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 18:08:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 23 Dec 2025 02:08:14 +0000
Message-ID: <20251223020836.9439-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110024805.31070-1-wegao@suse.com>
References: <20251110024805.31070-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] new cmd support option for needs_cmds
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

v5-v6:
1) Move the declaration and definition of tst_cmd_present to a separate commit 
2) Modify function comments such as add ref:`...`

Wei Gao (4):
  lib: Add support option for .needs_cmds
  tst_test.c: Add tst_cmd_present check if a command is present
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
