Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451D8C43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 12:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 901663E96FE
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 14:24:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4A523E4AB4
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:24:07 +0200 (CEST)
Received: from mail-dy2-x00.google.com (mail-dy2-x00.google.com
 [IPv6:2607:f8b0:4864:36::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3DF71000924
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:24:06 +0200 (CEST)
Received: by mail-dy2-x00.google.com with SMTP id
 5a478bee46e88-30e928841a2so390480eec.0
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782908645; x=1783513445; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEmxnJ4i/9He9xWTFTIaKTv/agaLK5sza/Ru67/k9dQ=;
 b=FJiwQ1dI4nZworF+aS2YvW3LCS3UPZgT8apIjn6Chkfnc+aS/P8WB6cE1nHs1/Om64
 nJbZRvR4+Pa9dRAgy3S+Ni73JlGG0mwJZe3rSNEqevpAtY4KghQPJs4NhUAs7GmTqjIP
 cU5+1cUUIXQT1ZtJpxzp5e/0HXAb8SZJoAa/qEz//z1RRV0zJdQr3JoT4//24jodw30Z
 ran8lj15IaAWIXK+l/FnmLgGbeXc5CJU9WdLfk+HiJ8O4IJB+eA5ivlCuRJrZ1Bb1Wse
 hbFqZd1oj4DZ43qWLh3qsZjORpxB1dnanW9WfCmKtSA5zn047qOATdgIuNbNW3ctCrVV
 azAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908645; x=1783513445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEmxnJ4i/9He9xWTFTIaKTv/agaLK5sza/Ru67/k9dQ=;
 b=dFODKhEjK+nMShcqdeiK5BRZu0v4OVzmhpjz8DO4jOADqOC6EszeQjKPCDyzOddrrH
 dVuR5YVsOC406gUtipog2R0XYeRmaUsOmpArjYQ0Kbs5Ql7+TI9O5GusIQndTTIWcQSJ
 xTAgD7Ksp2kXGz+25+MkHN9N4B2PU6244jWcbnu2Qhr91jzR93EJYCPb+tpaxi0HaFI1
 aSqiyE1k3wanNykJOhDBWBxnlJBBTqUR4A8Mxmm4XWzNqdVtGg8DU2SXzn5f+TkR7RiZ
 Hyo7RGadP/H0RTVeJgbpFixmh+0H34eGoFVbCF7Y7Mx7b36p8OVHlVYumHaEGoJmDCRG
 vI8g==
X-Gm-Message-State: AOJu0YyJTTscXV8a0I2zaRy1SA8Ukb8+rQ+zzOBUBwC2fg34GrE/qcAI
 E+YA+GsE5Gtl4/SPFhtSnzQ5ceqqI97xml2OQBhiN6a3K+BQ8P2wIivn
X-Gm-Gg: AfdE7cmkBrhLsYo1asryTN3zdlX8bTOe4KH0G93mLH7GzmEwc/fxSg2Q3PO46CqUBDv
 9M2Ri9OMWdEqNNhEN4JricG8x4FjOjRRiAJGaDsj7qwl1DBjbKwMxbk3E9+JTAjr2r+XYBkshQy
 Y2XAn2VuhAdYGjvkn5IkMUmGE02K7E/xAvbViOdSZWSt7xqM4slmBr4TKH9myIboUXSo4kA5jk7
 ARMnxFz1U3dmGf/fO9vyPgr4uTYgTKcS9oARrLrQDVLqWGO2p2c/Cf1kRrIUzAPZbkF4PRid6CJ
 kvVxMg56S/SeEHsm0tQpiCJbgYI32JIOQri6LoFGO4Dv1RbP6CtD66s8+HM6WkF3CEnW8izYsYX
 iAWSIchPwWEM3eCsEJRiFTNASmQ621SO4bkf+8j6gBTys8nWnNwvL4KpI4glpSFRbr4opi21IaZ
 kYEEuHk5QHRX7TGbayWuKfrFfbW7o8yPdeHEMMraX4OzWtKaSW4+0jmUsLEFXKAbpmT8z2AiMz7
 9bx98NNGMvc+EeJAuxQFV1C7OQNWQ==
X-Received: by 2002:a05:7301:290d:b0:30a:e531:3141 with SMTP id
 5a478bee46e88-30eff0b7e71mr1650473eec.17.1782908644973; 
 Wed, 01 Jul 2026 05:24:04 -0700 (PDT)
Received: from
 runnervmkkn4f.fcndp2way23ujcxi3rzubkid2b.yx.internal.cloudapp.net
 ([52.161.180.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3170ef9sm33101144eec.16.2026.07.01.05.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:24:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  1 Jul 2026 12:24:03 +0000
Message-ID: <20260701122403.3847-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-landlock_udp-v2-1-b1a2c71be093@suse.com>
References: <20260701-landlock_udp-v2-1-b1a2c71be093@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock08: add UDP bind/connect test variants
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Wed, 1 Jul 2026, Andrea Cervesato wrote:
> landlock08: add UDP bind/connect test variants

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
