Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EB6C61DD6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 03:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788406372; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZfE5TBmfkcOdPPknh92BdgYuwjJWMdQ/oTNedJbnuiM=;
 b=CzjoLs4IOq7J+27ax0EoHWd79T4GmQBDBYhDl1pb8a2lxJ0+RLa+YbDrXBcUNzPRlwz/F
 R5NTVVIFSuW/nT/99CIVJhXsr/XrhfV5lDGiGtahETXKJInAp4DHnbugtMCSpUR7gXFNY7K
 og5f+OPnei/wSMIbsRQ6fVQLOo1BglY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18FB03E9866
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 05:32:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 329783E2254
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC86D200279
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 05:32:28 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so14933555e9.2
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788406348; x=1789011148; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MOTsUtLICgcyEubjG9RZ05wQcM8QVjkWBKsx1UU68wk=;
 b=YleJl/EnIQqeJukHs3SSYNA3UvT6m7q0N5ay2oa3SzFO+1q+Vb1iHN4RhWjP2yl9J+
 ek53ry2ywFSy0aXXiuPuulIbVhtcQAK+BJ58SWIaKVCqZN3KiiBzUl2XB07Hr1qXWh88
 Lq1IoGL4VRY/NH8FsYxAhd5mBPILJCs5Txn/gskXBX8az6++LmXWuKqpHi/nLqIPteiL
 FmeBL0hdrNupI4kJjAx+Fi0bxEaX+SSP7J4S0+4qceGI4AHcb4Wjuemnz/bRDi5Q8HPf
 Q8zXkxgYbLtjmEqpjCdpuQe4/Mqf4qqbeWywkS2WLOAo0CTb9iX0Zd/lJxdkVy/GKymP
 PRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406348; x=1789011148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOTsUtLICgcyEubjG9RZ05wQcM8QVjkWBKsx1UU68wk=;
 b=cLADW0cLBLyW/6QvoK0QgXTtrSYE9nGUp7L8objFCtDIzuEb8LP75zXxl04aS7eFtE
 nBAwV8S4d5ML7oEJyAnDSA7HR65IwVy7mIOrw5Wq4WaRi9ySPo/D/YXr3S045uBz48uJ
 UJB0gh9C3kG34AfJpDdU81pShFATPH0bqVbgxaZwMinOzpNNofBmA2v/1TOIaztuyEK3
 GIwnWxPbxTYSm1iy0N5gTQH23GhgZur0VQxZyIHRpilzp0fsSQ48Ihfnn1JjbLWbSfZn
 /wDAnfvS5Nxpo3ri3OOyqKIvVLQzC9sbldH10FFFyW0HpSYk3IqRnQOCQojaYl2rOdfD
 NE7g==
X-Gm-Message-State: AFuF++myBlHpKXDaarDRgoreFp+Y0Vpoh7ZZSlBgZuCHBYkgb8XOIOiW
 PIYxcVc9i+KprWrS71HRov2wb/jHoIVCS7HF7Q6f+/+dh7eohgoLJVcHBElw3f0VMBcBL+GtizP
 TjXk=
X-Gm-Gg: AYBFou3RCr8ev2Xv5kzLCJD3SSLXVFDtkCVmYJC55sOXA6X89t7BrbX4h+CMq3mwxJ8
 JmUNisxuyanxJq9pJjJfe+uKlm5u+WK68Eq6AAAXkhV6pN5U83WyFCKItyJZJgCgX7ffgv1Df7w
 vXV966ACGQ3qP2MKDSVxfo96HN8V+exCFNPYxPEbXqmaf0qcwgfFEm206Vw7MOAgHSBCVN4cWL+
 nzgzD+HDuFedyX3SO1nIB2TdmQ1YDETCGpk7w3W8pyqaaLN3grVumC0WuD13u9VQCQl2Xaw563V
 u5wfs56GaYBe6EDQuUFxRSF4xsMhuJbbDrg8uzYvEjOfRAQaunGXJYWLCauZ/Q2k8d7vijs1hcT
 1V0g8Msj9Y3xkC8k0ai8a6sr+fGL9NjCnuxw8eBtHFaIY+jAnTrVh8y3hY7Vx+KaGdF6TwiFGFu
 Q8ZyYV5hiwB+/rsLGsdVMtIvwmYRZtMnPMZ6RB/XJJOw0bc/Wwb5Xao+4+iGi+Np6/vb4+SGcsk
 XFMx1tiuB0/dPabs5RaOLUw+lq9wlXtkE7DrDKHwiA=
X-Received: by 2002:a05:600c:e557:10b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49ce5822582mr121713365e9.11.1788406348349; 
 Wed, 02 Sep 2026 20:32:28 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49cee6023edsm34942735e9.7.2026.09.02.20.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:32:28 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 03:32:12 +0000
Message-ID: <20260903033219.4747-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/2] shmctl03: Fix 32-bit compat mode failure
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

v9->v10:
- Update comments
- Use decimal for enum

Wei Gao (2):
  lib: Extend tst_assert_ulong() with enum flags
  shmctl03: Fix 32-bit compat mode failure

 include/tst_assert.h                        | 34 ++++++++++++++++++---
 lib/tst_assert.c                            | 26 ++++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++--
 3 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
