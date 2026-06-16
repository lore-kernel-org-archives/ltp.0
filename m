Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9A6CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781598864; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=9wsqxRh3PuY9M3D9oomC1WI9XZa/hNzaxJ4/JoZpmTI=;
 b=FzjC/FHw+/EFaN6O5lsyVKX7EKDgKgmnQxwAzPK8mT9FZWogUBUpquhbeQaxPkMimPOJg
 uG5lOqqTFPsTx8J2LtYuC7bok8u+6Eo9hU+upJL0lqSiChb7dr6PZD25hMgPhODij21a8Fy
 FvEm8WqkB4Q31GpmjVi4yMJuwNMghZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10B363E596B
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:34:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 246903C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:34:02 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 90AF9200B7B
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:34:02 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4923139e940so1732485e9.3
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781598842; x=1782203642; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oLhawgGEGUnv5VlARU9W02FrQUcOdrXr9jAn8JGHOkA=;
 b=Dq1eqWCqnLWLQUu3jEtSFieffThXICtAvvznhNY16vuSQzWDGpi0yx6Ye0xabDY0Ss
 EE8EizqlxG2dlWnPwKFfdLBakPG8QI3QSqc7q6GyK+BEkk7QIVV5oCBMD/rjcuLmrxqe
 YmD5SH3wvbRaqr2hjK+/e+4nV94koLtXMuSntubLmb6S5tMF2NtN5GdEJ3ruvIRmCITe
 96Yp7xM91aNxWpiXtSP9aLudapM8asupsfHDup7ORFvydxmm0kqyOhKF58HINTYdo8vg
 vBXX1BaAeYKGeffPHmgzJCLHTC5Ve24/zjLlrCARreVRK+V3xkH295vDigW1ryRjKTmP
 PmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781598842; x=1782203642;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLhawgGEGUnv5VlARU9W02FrQUcOdrXr9jAn8JGHOkA=;
 b=GgGaz5UwCLsYuExaVPGhXJ2JmJExcvm1QpShdcwnxOgLV5utjkfaGHQf8/v+ikTLoO
 VmQA3QlJcVWfJOCtBGO0rh3y6fKLYGlnqyEZ9YBSlQXmydLhU8HSyluhTqAU9rTdi6ih
 /HsQpuTknHzQ2Qqgwj0N4pu65illGm4/UH8/Q+l2cMzhoxudvUFltXFvN3rSnbHlVNlh
 u52Bv1OVoWkCoNoqKm4n5gXF8pW0O6Hg7/rmy35GxPX+x++8QFsp/3M2PqvRS+gQXwbY
 GzQDAtlvFbmkOuOzRsZKHb8ciztqy9a9bBp5UhUZRszc1kxbgpN4lR/dZtvqiReROKYF
 iufQ==
X-Gm-Message-State: AOJu0YwEjNvJiA78y+LmkRD61EWT6Dwv2PfbWYOUJ/b1jLUhVPXAXWRr
 d/cAySRGOEXWWsRBT7hXZxCKRocIn70xhOd674R3bCy1kzLMtZI6gYwm8NjbkSbthx2xdQU/QPq
 6mvSuJ4GWjA==
X-Gm-Gg: Acq92OF1+0Nih5lfJLOJelbniOUp0q4dOAwVm0FbLEAXnpsMqS7SLVCY5kpFydQx83F
 npU/xPJYeoJs6s924X/Xu1M5YiDHOv3A3NR+r/WFWnTRV9eRkMWV+M/pmSH+lg2ErslPJP6yx51
 kMdYBoZKHyJMefhjT6J//anTPuwH7C+cX8GjoDh1CRjlK6Y6vOISFm509dephSwZuUlQQTwAt6O
 eZJvStIrnONfLYSv+OdfnGg+JfwtixzeIKdFiBLJNBKDsCE9DhaodO5q+Bgh2tpIAVZvCR1SeMk
 SBBn8qnsO05G4Z2cDiZT/ZfbeCEsW3DDKPD4bbCGvBuFNMtlY8z1VVCI3tO5YZd4Ag/mT/yfWQL
 i1NU045hZ39ee4V2sNRTKAMIIBEa2ngaBvjzFbPNT/+q9Mm5PnFt+N5BGezDeON8+7HkltTxyv6
 X85ol/LgHqA84EuZpheStI6MTlkTRkgeBeBPWKPtK893WD+BVTQxCVT7Kmu/HzdydKz4Ucb+sY6
 TYCVrxYdlKxUZDtQAE2osKuKaN/GNhT0KDaVx0pRS4ZmA==
X-Received: by 2002:a05:600c:c8a:b0:490:cc1b:15c7 with SMTP id
 5b1f17b1804b1-490ec52114fmr231022565e9.30.1781598841803; 
 Tue, 16 Jun 2026 01:34:01 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263923sm42645061f8f.2.2026.06.16.01.34.01
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:34:01 -0700 (PDT)
Message-ID: <6a310a79.379593d1.36e868.af2f@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260615111358.73462-1-avinesh.kumar@suse.com>
Date: Tue, 16 Jun 2026 08:34:00 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

The patch looks good. For some reason we didn't receive the
agent review which spotted a bug in the test as well.
I think this is wroth to fix on a separate patch as well.
WDYT?

---
Pre-existing issue (not introduced by this patch):

tst_disable_selinux() at line 122 uses "cat 0 > $f", which tries
to read a file named "0" rather than writing the value 0 to the
enforce file. This should be "echo 0 > $f".

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
