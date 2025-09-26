Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA16CAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758876666; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=e4xU6Xp2ZVmfrZaDBovLrEGE6DpoKbpl8/QyYxGLPa4=;
 b=fQZfTdYn1mQv+a3a8OxQakYBCx4fOz0LH/QbEETaGuNW0r22eS1X70DWbe9m1FAxlxnRs
 4AfTh4gLLhHRR94zrsPN6pdlMUaPu/O1izSfAigp2da2i17GJw/cXTwnaFyiv35C9cVf2s2
 ZEM/nGTG5GSviMLOtfaAfAKXIACjqYg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A3353CE08C
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:51:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEA683CE079
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:45 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8ADCD1A007E4
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:44 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so328768266b.1
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758876644; x=1759481444; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Wz+dxjEJ3UiGfPVcKo9L/7rJz3HQw99EzgNgH80/3A=;
 b=YO7lRMJKMAZG+8TEkafi+GwxqC+oYwQMrracUUyPNev+xpOAdaJH6aXp81YOyPAiLl
 Gh3WYVDMu3SMdMO2gOAxc8CMifwkeW3VBG9MXy74bRkCeK2FDjxI6VgTs99sJT/6EmTV
 cE7BN1c4cW0ZLlMPHOq5iKbrZLF749FCwsK0B50l8nDscygmJEECzVfQJJNVmKeNKshc
 j6MEbdLLk2fod1KtA8uZv3IXApLdlJXXFvZQIkl9LuA2bBBRM2qkFAt8gDnNoNCwOnW0
 1OzU2ZUY8NCG7myF5GpHg/p6PpfhUWM/XDX5U7L+a4w9RQLTpO/pqmPq2t/2KjHvxyqO
 rQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758876644; x=1759481444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Wz+dxjEJ3UiGfPVcKo9L/7rJz3HQw99EzgNgH80/3A=;
 b=YrOYyd2eBkQzChHn3KSVApwBESbAMsoq0OKIdeipf/BNqavIjFoI/zrOxIWNUsPW5N
 t1a6hWEC8MD/NEpGj9AGR593C8VHbDE3lUBaWjX/Ehk8iCPhuuq/DE1mEp7wFbpd5lJO
 Gf5Md6AsvFvU5xC55bweZZv0b03pTYacUjApkvUstX90/mAehsmM/QfvvuN0jEnJMIWw
 saH+1CfXJ9wK29SNsBRdBUD7NW31wYlgLULKXVuVRQdJKJQPOZUdJTTnUaDfoNxdozRM
 EL6YoPz+CmaqR+mXkEKVrRwD7NVZOK7iGhX77rI1ZW1ogla1i9SMGbSz+U3eVyg8eMCN
 beYQ==
X-Gm-Message-State: AOJu0YypCOgFh7Q6w0ZNqyqzzlN5O2YS8G9l34cCRYbOtbm01jCzMvB4
 4C5XZZjUskPhvqjz++o1jpa0HBhzSs6ng7u9+hi8EK8mhpCMN5iiWeyJXiTywOLs/Qk+2OUMW/s
 TG1Y=
X-Gm-Gg: ASbGncu7V0B/w1zP9MhXrnQHDqguiJ9n6qjV+YCpQ3X+8FQwAHBLG3wQBLHr0Uh2Log
 v3uNPR0ZfHPcD6UHvYgTcwsCmOgSI7GNMYxgeXR/sIL/c9lcaax+nh9zbr5rxxzXNOQgpD6KVT8
 nQuj17XVeYc0gBmF0gnE1qrCnW+FVyTJwJmFT+8ZBjF2hB2se+eL0tCMo7lsdcuZ6ciJ6xxRtar
 Gm8m1RINRproipo4qjC/obBONnl4LWkuQtq4TIa4vu38lx6o/gMnsMyDvgCivPxx+GzHld1VZC5
 1leMRUP58L6JMDWiD5vXM+d2K/8+FKpPK21wD2b8nNvM/JQNJ2zQakn+eEmEMyEHLJLc2cbBddv
 K7T8H9hibFLsNpRmknfneyOcphsSoLMyjuONW7YRzZd0C9RtnaS5q0l+thAuRZmPS
X-Google-Smtp-Source: AGHT+IGQxpqByn1js6Fp2AD5wHFATtzgtMUNrFiYnAt4ofEA4juWONSKtdlOhBByawn6P2M7o/647Q==
X-Received: by 2002:a17:906:a24a:b0:b36:4f39:3158 with SMTP id
 a640c23a62f3a-b364f393739mr352810966b.5.1758876643661; 
 Fri, 26 Sep 2025 01:50:43 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-634a367924esm2529241a12.23.2025.09.26.01.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 01:50:43 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Sep 2025 08:50:10 +0000
Message-ID: <20250926085021.22141-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] new cmd support option for needs_cmds
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

NOTE:This patchset is draft for review not final one.
Since not include update .needs_cmds for all related testcases.

Wei Gao (2):
  lib: Add support option for .needs_cmds
  ioctl_loop01.c: Update to new .needs_cmds struct

 include/tst_cmd.h                             | 15 +++
 include/tst_private.h                         |  2 +
 include/tst_test.h                            |  2 +-
 lib/tst_cmd.c                                 | 98 +++++++++++++++++++
 lib/tst_test.c                                |  9 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 23 ++---
 6 files changed, 130 insertions(+), 19 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
