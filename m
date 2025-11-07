Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49533CCFA13
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762475472; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=P1WFWKM+G7KylRArWHn438Q6huwrZnoHLzfTt4H5R6Q=;
 b=WDSb/2Or9jJytN2ecJetU7TXL+yNtQA9aLTZPtgbwf2VneRrLXXv+Yd4c20shmFOg2EWZ
 4FCy3cK0UKwHtY4nKS4HSm2IP/Ow1T7VWtbTPaszmx9nv8GCENFejrk+0Mfp2MQmk2y9tBa
 rNoRdbPKqluHqyEtnLE0hVJpeJAiOh4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EF173CED07
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 01:31:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A15CC3C6EAC
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:49 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5AB8600D6D
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:48 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-640a0812658so367811a12.0
 for <ltp@lists.linux.it>; Thu, 06 Nov 2025 16:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762475448; x=1763080248; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqrGuKh3Yk7tMooJaXrZEmRYudZ6BfG2tpbQ16xSzX8=;
 b=d6KFI1fir7DmgehlfYdqStGLu+engVJ0l0laQpdRSky9d9Z7N8MwmYPflf70ab4hhK
 GwSZSSoIinsCmRv47Oj6sJ4fafq6sI/sLSQaCILOauJL64n5kEALXPzWs+qoEMxtIz0E
 L0hvG4N79zcyxy0MpA2gf41+x0oga+GB35SjRxOi2QN/Y2zyanKQwy2MEqmmNQqUMdQv
 zKlYz4hxnddLSKS0/jjXSzDcem8eDVQ59G6/HS+VtBwU6IKrdbzJvjd2bNbQiU7Ruuuq
 x/NqVWrVtaC3+oNv8yw5MyVm5kyz4UUi7RfZklXBByBtSebnXB/Eyc+aIZ9qgXy7A7IN
 BAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762475448; x=1763080248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqrGuKh3Yk7tMooJaXrZEmRYudZ6BfG2tpbQ16xSzX8=;
 b=m4YXQigEv+bEbtketFc6pgVmvya+0300+T6YLKF+PvUnKhqzA8FKzI8jkEChHy8EP8
 5pVBpQeVsMDrhdT9MNrpH+V1GuCmjUql2SwSfXKlz5ja8CGfWEPJtZro5/3qQn2sn51L
 msQ6ee5SNCOq28SZZ4D3z/pXdKja3Hi4yb9+nBwZyvst0iWNBNpn+SsPQnoDtdLp15D4
 kwlGBPufRTnlUTBzNGIdYyBlmMqeuHmlSacOS5MHfR2SzSXPZxcVAVWFYy2YpvbHVY/a
 jE59MqVCx5t55G02qclGog+nOt6Y9W06Zmou2Y2W8FW1CdaYhWH51DT+fnuTehhpPkHF
 tyng==
X-Gm-Message-State: AOJu0Ywl/PyhkPCYDjqvK628bvigpG9cQ4cHlPy1HvkrITkWcmLrM7Gt
 P0ddEzKKkT897mt96btFrmXW74Hr7OVIQOTiTqcG/c3+6PHqVvdJILz+H/iSCXV+jYdTWbhih3W
 BCgQ=
X-Gm-Gg: ASbGncvuSpyCx4eCoQOB68rAIviXr340SnZrsUe9az71IQcunPLoObQod8m7O8rvAhu
 k4eM22KXRdKOL4wjcslPGNdYCDDJHEJbuAmuHN8kwAU9hzMClQNgF9EV3C2WeMR34btsl1dfpEX
 da2Jz+AnbdhFLLHE9ZlROlJJk4dkYQw/AeadqLTeQuaa8CgfmiHUkO/Ihdfta9zljuVr6sE2zxJ
 BoaCJJppWRkDGBPzXE6k5eGJfz6lSf3pjr1FbcNFC5kJKE4BbSYoytxpTL8xgZg8aMRFmdO8Nk8
 f9P5RmyVg8mV0Vg3HJZ9YD+uMoZQ3OfLZ/MqhKS+yjHonrGhGUCTsAMQT32os2dYCC6y4W67tHA
 cNP0qQ1nc/Njd06gIVB8RRl6LRkNUjwq1Ea0Fr9MpmBQfu5Dv4+LH7SgDmX6P3eCk
X-Google-Smtp-Source: AGHT+IFny6gUGSbjCyF2XllFQ2Eo9cRhLDoY5rNTzeWI8UM7lZFB/UjMJS3Zr8QvM7Q3WzOY48E/eA==
X-Received: by 2002:a17:907:3d90:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b72c08ebd1amr114436066b.13.1762475447915; 
 Thu, 06 Nov 2025 16:30:47 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf980112sm83517066b.40.2025.11.06.16.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 16:30:47 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 00:30:23 +0000
Message-ID: <20251107003041.28929-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010064745.31361-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] new cmd support option for needs_cmds
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

v3->v4:
- Reorganize the patches so that each one compiles successfully
- Add new test case for needs_cmds

Wei Gao (4):
  tst_cmd.c: Check brk_nosupp when tst_get_path failed
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
 lib/tst_cmd.c                                 | 10 ++-
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
 testcases/lib/run_tests.sh                    |  1 +
 testcases/lib/tests/shell_loader_cmd.sh       | 24 ++++++++
 testcases/lib/tst_run_shell.c                 | 61 ++++++++++++++++++-
 31 files changed, 232 insertions(+), 103 deletions(-)
 create mode 100755 testcases/lib/tests/shell_loader_cmd.sh

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
