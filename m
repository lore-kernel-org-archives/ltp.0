Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88DCD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779809206; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=6GDo5r7xwFjtuJaQd8LVsOlfPEvbG4PoFqCyqedrHkc=;
 b=NDVeDEtpCEH3F5w05kHAcsUKhwUb8MrhntN8MSoiV2kB+SqXU835C3HOU6vK3/lvbVAw0
 m9XoEmpyOVA3EFT0DKPeXk5aaSgzznZ1ilxchDPfkmcmmBzVkF1u3KB2hiKUq3TU3oDFgry
 5YRt2EnEJXppAUuX0myahhWnNBRLU4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 247203E62CB
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:26:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1AC3E62B3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 719E4600942
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779809180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bf0cuJirmH6OiaaQDtciypULqqI/pi+2wFTsUg0oqyg=;
 b=TtSzBA8mAFUlYHxs3+7R2eqRglNAyadZ/Ix4brZ63IowbHFZW4Eb6Hw+jvrgO0QvJLVgDC
 P/jKfhNZnQs6putqmZWeNGVlPNch59H6N6Eif46l6Cl5tFSRygdv25JJGif3KEiAEdbCGm
 2o85y32cXQepXLubdqhIZvFx2CsDUTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-_NxK-MEiPoOpIGNY_epxmg-1; Tue, 26 May 2026 11:26:17 -0400
X-MC-Unique: _NxK-MEiPoOpIGNY_epxmg-1
X-Mimecast-MFC-AGG-ID: _NxK-MEiPoOpIGNY_epxmg_1779809176
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so29703835e9.1
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809176; x=1780413976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bf0cuJirmH6OiaaQDtciypULqqI/pi+2wFTsUg0oqyg=;
 b=Xlcv6IxumTElNIqHwe6meXNwWEWdhxEvKzVEtuzQPY7Lvk5o65x0sz65HxpefjROLD
 t3HK1lbv6IzWJ6amwikB9E1NRQYD+qUsHiaIKHIjItKuxvXQNrIsAupV98rFLQTQqhqw
 MT9nZuzTK1LBiEUEJoGpmEZQbVpZXfRsS+VdPWfIu+g7/sO1olQ/fIEZUB/0bFpuw2r+
 2CTQ4v6orK8/1moevte6iAHlYaUlYvmpBQkUU/3nKOM+8hFKc8tfXsrXIJeyIlJHCVpj
 ChdJxhReys2kY0EhjN/pphnv7+Vpl9Zvhdt8/5qw4g6OC1LzE3eUdRElM+pWiYMTdDhE
 oG9w==
X-Gm-Message-State: AOJu0Yyg73mYmD12XxzAZgyRhJrurqznmNXYvg5DhU+WR2bhy/ckGlhV
 Oh7O+fes4Dev+gRyh2T3Fyp7gdwLyL6iOZHEcDp3bKzdv6kUX3eXkLBI/09IxTjPw/YVEb2Hkc+
 l/fTfGld0FVgmXy7xqnM960dVY1yEAWntCaOtJZCIiYSxyw9TI+2NkcdXqvn08zSA/k1FI9FRg7
 awKBwu0jsGTnEcANZ5pJT1ncWNmHD7UmtWuCd9
X-Gm-Gg: Acq92OFaBHG6gh3f1jrnh9bv2Gj3scpndV+aIlG0eyzs+2eoeC9+bubzOAzbTjHoZT6
 KA63osBFM1XdgNRHzdUsgo1GSD7yA1Y1W3gCyF50BMyXp6V5iluR1b4EBbUuOCoPmjcxv3DiCpG
 w+VJqqXpHpfuzccF/tnZzPqO0VRn8fY+6OdlVXwtizI+hTS08VLVOvqsWp0tmOdpj+ikR4A0PMm
 uisToOhNyeNi8hLuv1sfLd9O1K8cWsNPG1Tj5zzR/A5seUcxKrrQ40Koy8tj+gkue2tCLOX8LZV
 thxt9V8QXEH66sB6hZZY1bAZz/OTYouxHjjY8MTxpr48fAGkQMz0HaVzgUm6R3DlvnGNzpdWGQf
 Nyo8oq/rp/28m6+xydMZzQMLceuceRoNEs9jNjLvdVIC5WZN2zLF2BT2UdAsT9n3OqIB7Kp6V
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490426d3319mr240103075e9.25.1779809176526; 
 Tue, 26 May 2026 08:26:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490426d3319mr240102425e9.25.1779809175969; 
 Tue, 26 May 2026 08:26:15 -0700 (PDT)
Received: from fedora.redhat.com (89-138-3-119.bb.netvision.net.il.
 [89.138.3.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm384735795e9.9.2026.05.26.08.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:26:15 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 18:26:09 +0300
Message-ID: <20260526152613.109485-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5rLqpxXH_y9d67CNVhnLPRjqZoliHS6SasA_hnZeKE0_1779809176
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

v11:
- Fix alignment to match open parenthesis in multi-line function calls

v10:
- Fix doc comment in futex_cmp_requeue03 to mention both EFAULT and
  EACCES outcomes for the PROT_NONE case

v9:
- Use compile-time testcase arrays with double pointers instead of
  runtime initialization in setup()
- Fix sparse warnings: add (void *) cast in SAFE_MUNMAP calls
- Remove unnecessary braces in single-statement if blocks

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 74 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 ++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 87 ++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
