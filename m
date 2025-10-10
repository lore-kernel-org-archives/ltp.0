Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2F5CAC5BB
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760078899; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FfQtETlAT0wHjL80t3ua/+XLKaTyNVUNaLYqZyUU5Gs=;
 b=VXkRTpw2irNaMax/d8hvELqbeKgy+EEVXPEddYYFOszz4/AU7IdQW+I8dn0OWdMOP1uME
 YW4TKHq92HzaG7f2xre6mtbcHj+bNIe6wGr1zvtZsxsL6kpmvPU6gN7YKmhf2fbfRCs5YuQ
 MH+9uQHq1DebUCycYZ97hC32n+Q7rbM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 179A13CE97C
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 08:48:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E493CE802
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:47:58 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CD851400210
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 08:47:56 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so9555115e9.2
 for <ltp@lists.linux.it>; Thu, 09 Oct 2025 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760078876; x=1760683676; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jvlQ7LAVK7v9Upf7qSzdtfMmhM+VUHe5UzUpWegXY8=;
 b=duHsMMkBIOPAsXcpbWY1ED83UO1Wn4iPsjSl+NhJbxMvWsDVvFxZA9DRapop1a29/Q
 iemsjBdkpKXbLtpm68GPp/gkVoGr6D6czoA3ZJlkPm9vIuoF4NGRyt82nYufsxKOYfwx
 4ueOjhuwZk8i9J/K2hknYpEjupcW9T06b88GbroUhBSje6D7ThbPHPTgISU3pNWJ/nVo
 qhQZ95Q0K9u04CF2qeXXcM5zu2bS43RudTjxWWG206Uho0Bs5XS1zA0Zf2eCzTINngrU
 iB3Du9Tiyw8dzEBxl6B4400PNTIrA04dltRQGKizoL8duiYM+vhjeBgUW+oRXZdzYu8x
 JhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078876; x=1760683676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jvlQ7LAVK7v9Upf7qSzdtfMmhM+VUHe5UzUpWegXY8=;
 b=MrsuC/IeZFzM7XA14eylTF0QHOBHJsRC4CxtK8EVa4o5c/vQResG8eOTBQ5fZZaGJG
 nCvu/COJ2iJiah39DZFIy0xaPGziqZg9b5TH0EUUyWqqWR9Swg5jCE87Rc4Baoi/yPoc
 7/GeaYvDWyOXVsd4Rjn3E+i57fnrcevRauXC0pWf42NyDxR4EF0fd2Uvc9I6HYtgiFsT
 SioWao9PkZQDqHhg541W41BEDq5zBcYPvmMTDbcfbeUnJb8ty41c2tyVJoqAdsXqk8zA
 8l1tMeXj2h388g/6fiAXbzKfnLpmLXvhwWoBcEoE21ffyRFnnGocYVSN9dG+sBtKhPRF
 CduA==
X-Gm-Message-State: AOJu0YwipAozpGzUF0NnEfCIRibrdI8tpDSgAjDRBLN0mE0u2ThelsJG
 HpQr/c7i0FM1SynfBSFQvzOpJKovY69KetBUU/sct3d/yLMrSwO4S74M2lmQjGZcmuX8r+x6PXi
 KHNA=
X-Gm-Gg: ASbGnctFXfNRDocZlEzYByh91j1MDKf8Cl2zsDmorF5OE7jF38UZoLkPMPJ2mnPpk6v
 5yj5X8blYoO+yzHyehuwJgm885xkx7gcrfcMKPAlIT1XXHCe6ivxkXQT2/vbaBqrmQ8tTFX7Hca
 TfoF5N87gZ4LuX7bcrY0b43tkNmVUktXmxJs2OdM5jpI4o2+jvBaBqDDWwxim8aCi63py9JQ/fN
 7RMg4zqn6TzGvUbM2Nw55P/UUORU5z50cd5JDrkKLwIGVhzDe+TUSFu2Qek6FjcPK6PV4d6GoZv
 O3ckdqeEcL6Pm4OgAGVFVv8xerY1An6LfSxtcfgVG+WoY77ZHEDv54Od/ysaKEV36cUlrK/34iM
 rcpnoST62d38tbmgm/QjxP2tEqzUjVw==
X-Google-Smtp-Source: AGHT+IEdynrez/8Gp1zaZLs3XsbYZZnHXz1AgYtO+a2oosLZ9YCbU1Ba2C8ZGzQdSZ7PIHxwbxkJqg==
X-Received: by 2002:a05:600c:4687:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-46fa9b02000mr73182045e9.32.1760078876059; 
 Thu, 09 Oct 2025 23:47:56 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46fb49c3eeasm29304035e9.14.2025.10.09.23.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:47:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Oct 2025 06:45:46 +0000
Message-ID: <20251010064745.31361-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928232708.24007-2-wegao@suse.com>
References: <20250928232708.24007-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] new cmd support option for needs_cmds
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

Changes in v2:
- update base Cyril's comments
Changes in v3:
- update all new needs_cmds related test cases
- fix Ci issue for tst_run_shell.c

Wei Gao (4):
  lib: Add support option for .needs_cmds
  ioctl_loop01.c: Update to new .needs_cmds struct
  Update test cases use new needs_cmds
  tst_run_shell.c: Add new function handle new needs_cmds

 include/tst_cmd.h                             | 13 ++++
 include/tst_test.h                            | 15 ++++-
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
 29 files changed, 204 insertions(+), 102 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
