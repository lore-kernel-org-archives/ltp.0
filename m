Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93002C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783391422; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pH4oOZvQ0BYTQfe+W8HxeylrgEze05fzmRQAMz2WW1I=;
 b=NLvo7KSQwIoWQ+RNvj9ONE3VxxnowmeKlShz10XR2/FPT3RAR8pN6EEI3LOnzGwUJUYIs
 0MrRX9JVcUX2FnhcFVlxTq/nOVoqdraAuSzhtQ/Sr/WbHuENun+HhRhlsZfkQgsKCiUA5yT
 2PMGgMISR96TxWISNN6/GnP1XMZGg5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 769E93E5E01
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 04:30:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09FF23C92BA
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 237B71A0079C
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:02 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso37096475e9.3
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 19:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783391401; x=1783996201; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfLBJrHYcdXNzgAetZvqEkSaKgSeFmm1ocLsLqGqQZk=;
 b=IA+b38SP6qqnl6L3RpV+XagspcDgcqq51+Y+hsCLlb38PEhRxW1DghPe0wK7vuNUkb
 pCmanezlLJd3QRV+V0zCPp7S3GL2CWtId2kP+5LM/HddvAnDtU7OTBwHctV7flCilXve
 xm8jK4b6l9rFcZiAAq4e//Cikm4BYRy1mNKf1edShC/p5C+zoL6/vecn8cannt/lXtno
 FrAws7h+wk0wCrj7JAR35JoI3xLy/TGiPF8bNMT7JycyVrX/am1lOT+uQ80Z+GIEOfSA
 OZVnK3M1bNEXLuo/3N+UGUgmnqSfTD4NtNCjraNeplMcq9soq2WdESwaXCwFpemiUsYF
 LtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783391401; x=1783996201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfLBJrHYcdXNzgAetZvqEkSaKgSeFmm1ocLsLqGqQZk=;
 b=J+pZqbHSg8VaJiPtiJGb4G3cSROneZfKX3HV1Cu/L7ftOfFDBu+sdGHmUmufjj3qRP
 qcpGah67SqVWjHBnBBD0j3kaPvqvJc2m9JJZXCg7DvgfaFOMreBZ0bi+N9sChkXcmAHU
 VydlsgdD+gI8sFMEXRf7OX61C1rCPdPBzQYVanh+S0G/o+C38UPMS0oHRqHPmTpYqcLQ
 nx1UY52nRA9cOt6Ggwm4+c7VE0lgK3kdTE9Ko8Vwnwm+DQdpXIsBNSRK56ciK5XRsbhu
 /+rtq/CFXEuBiyyK6KmhfF8Ls8SUB3Q4oq6biQ+j9V+Psx2Y4/X46/9pe8GG++LZ9thv
 Xpnw==
X-Gm-Message-State: AOJu0Yx4SBVFEcijiPz0vzs8oR7zN+ruNTIec8FuE6dvsptrm5nq8own
 PFnBAO/2Aqs7wRl6nS1qT5ckY5nzZ2MLQySIpR6fgqp53n6Do0UCBACAqbhE4GV/k9mMb+XMBpz
 /Wyc=
X-Gm-Gg: AfdE7cmrDhQuyDU//SjJftHqZZd43yM20eSEuLfaO5Reau1I3rTQ40TEVj6reBQjDjo
 nSDw9+7uvCRJekGJzhKueq9v5OK2zTGlbPSuizu1A3uqxTSJl7Yp6asLjfMRd3QxIrVz5YOfhLH
 OqwwIIsGVMt+VdhoR0yFC1CYZh4evKPFSgCgiXzNUVak/pnAC9/RwbbC4Q3vHfKPPGAsuKRirnJ
 SkT8wJ5JGjkAqExViisULfU2i6ohzHR97ZyI9TCTel5nAFRSHPfkNHUlX8qyMhbctNNgcuKKBvf
 M+MBfvXWTtbiXw68v92kI4VjgGTtBbFnSz7BXd9fnNh1H4zRAkdSAp2o4FSWjrxGq1V6cPSLbqL
 i4mx8wlEoWQQjVA1h/RN2XPSf5QJCBOuRPw9jNpIOIaHUy779DRwl3cVAdbBjLsXs9xrDwzgSf1
 9IwwswvFw4JcY=
X-Received: by 2002:a05:600c:1d1a:b0:493:b783:ad59 with SMTP id
 5b1f17b1804b1-493df07390amr35187855e9.14.1783391401556; 
 Mon, 06 Jul 2026 19:30:01 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47a9de1e736sm32436738f8f.7.2026.07.06.19.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 19:30:01 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 02:29:40 +0000
Message-ID: <20260707022959.24088-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416005603.22427-1-wegao@suse.com>
References: <20260416005603.22427-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/2] open16: allow restricted O_CREAT of FIFOs and
 regular files
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

v8->v9:
- Use a canary value for excluding SAFE_CHOWN/CHMOD from
being used

Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_uid.h                         |   7 +-
 lib/tst_uid.c                             |  26 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 131 ++++++++++++++++++++++
 5 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
