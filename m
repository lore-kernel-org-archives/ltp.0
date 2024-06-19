Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4999BC27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718814514; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=M1t0BI8qNm0fgKRmEsZDygxh2K0jt9ubqr34BXphMD0=;
 b=pj2KqQiyBnErk8dD3Q1PVFvB5WCBV2/ngIaKi1zh1MXDYCTEvQcD+CVqNJwr0x5Yygueh
 ab7M59RaMBi8zLjV770D2boeoZripH8V4geGoE0QpzN/M1wHuG68G3qpeZ8mLGPwL40r8I0
 bSYbrGO0m3CsVTdzg4GzrGmDVijKB9k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A09003D0DF5
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 18:28:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14C383D081B
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:12 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0969C1000CE0
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:28:11 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so6290194a12.1
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718814490; x=1719419290; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h/OUUVkASrbAhicHoFKpSqUdby05sZ1NuLCLGIC+jfw=;
 b=31gZkPAhvdUuQFi15hbIVdlKEwoNXuMywf4Rcjt6UISm2Z/7v7ngEVgS1ccFpvZA7f
 CJf58GGwc20ToMjIfjJ8rYbxkW9JswjNPuoxPv2w29PcwI4a3liM015+tyzDWBjIx+6B
 KSPCDeWsyY/HplG5Nn9Kw1tv58uwCkxB9hud7726g4TQ3RUm6/ZWYzkpNFyGU4C4QH/e
 iUkot2caY0RiZJBWy2Sm5xTKWYpQHMUH+EozpQIm6nmapGEd3G136tK31A3eMiK68d5i
 nOHWtdvYVLgfrk0lMS3xiIS1QIpA667Pt2/jDCG1s/fY2dqqzhFa/D7ETzkm4QH0bgq3
 Nk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718814490; x=1719419290;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h/OUUVkASrbAhicHoFKpSqUdby05sZ1NuLCLGIC+jfw=;
 b=BMuBZ0donSL++TXIwmrw/kn1MOn9Hsc5INsLXQUzM4Gjujh2ubbxZEHPzO4cucU4GQ
 B4TbCAEPRKr6gQ3QNv4yuzUbbEZj71z1mp9ayx8v4mj1erB9IzV2lFuzvqZ1wNM38jUB
 LJWS++KtfE/nwcJmZlubxirDxv7sYRst/EnCTZD+WaSqqQuOfV8a+02o2ogJ9fygrOgW
 eJSXBe3aoKaZ3PAyDULiHAEsjbTps8ctzyKdChQwNo6IZQaE3cakocxMeXa6YGzkpEBE
 9XnIVfGwFhBm1FFSovcOCvSwb68LnB8zKmAUzPQZp7/ceFbbfeLfw3XRlkj8i4A762kJ
 0Bpw==
X-Gm-Message-State: AOJu0Yy/jxCgN1BvYyUrJf3EYtoKrPF59waKCHl17Dhulj7iZ6qMdVVH
 KJZnA5xaHNXIhNGICbVXWTs89CVuEQh1P23V91bUOlCJNObYkQfevgVXWrCFMEv09AtkBWeZyck
 F7upkdCQfcYdA1ro2a4M8wOiziDwAIxIml1sObTcdR9WGu7Pvibajs6OUVvL4iNW50rljQ5tGoG
 DEw7R5jCj/hcMI3+b1Gx3amGI+RfQ=
X-Google-Smtp-Source: AGHT+IHXOy635VvUmFJLnYpbrE7pGF//NgGhcj1xbjPRykFqJjmDNUmnWrE6n0LmkgTaLcahdacwSlzK2Ho=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:5217:0:b0:659:23db:a4b2 with SMTP id
 41be03b00d2f7-710b8cc2034mr7894a12.8.1718814490040; Wed, 19 Jun 2024 09:28:10
 -0700 (PDT)
Date: Wed, 19 Jun 2024 16:28:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240619162807.2725018-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] sched/starvation: Choose from available cpus
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The starvation test was failing as a 32bit test for some arm
architectures where cpu 0 does not support 32bit applications.

v1: https://lore.kernel.org/ltp/20240605180536.1288027-1-edliaw@google.com/

v2: https://lore.kernel.org/ltp/20240606014022.1425928-1-edliaw@google.com/
Made these substitutions based on Wei's suggestions:
s/TST_EXP_POSITIVE/TST_EXP_PASS
s/TCONF/TBROK

v3: https://lore.kernel.org/ltp/20240606173933.1671989-1-edliaw@google.com/
Substituted test macros with check based on Petr's suggestions.
Split commit into two: first to fix the return code check on
sched_setaffinity.  Second to choose the cpu.

v4: https://lore.kernel.org/ltp/20240613210059.352767-1-edliaw@google.com/
Fixed some typos and commit tags.

v5:
Got the return code check reversed again.  Fixed it.

Edward Liaw via ltp (2):
  sched/starvation: Fix sched_setaffinity return check
  sched/starvation: Choose from available cpus

 .../kernel/sched/cfs-scheduler/starvation.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--
2.45.2.627.g7a2c4fd464-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
