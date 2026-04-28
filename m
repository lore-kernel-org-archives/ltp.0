Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C7FF886F
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777360953; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=elhuEjnk+JIOeERaM+mbVBlgdXNAdC64sgMsK+Z4h4k=;
 b=ftrQZQc+9E/xmi9uVXtJ0EVLvbIi19jNzyy4DR2jgvi0SQgmBGy/A76zz5EwpL+kOo3v4
 zocqbzjxzNZaNVm3eyOpGWtoaW2/SAhRKakYwQuXHjWXfwe496GuMk2A3a7LEAQB1L8G5OA
 psiPJXdeYjcMMrJqbrnQCb+v5gJCryU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B8CD3E2530
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:22:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A3583C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:22:10 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A02EB20074F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:22:09 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so7441209f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777360929; x=1777965729; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qAbob9ePXxjHYtphP4A4pHHvuA7vva/YHz7yIg0WG9M=;
 b=Sc2si8mnZUGulUGN8+YeFoS4ggzNV3P94wvOaHf81FjOucdmk+evynmLHp5kM+fXaD
 2PD0l9imx0C4dK4AjCNSYsFZlPuziu5+scazR/gb4InAqZu8p9y95IUlMHh66mhSEWen
 nEnnzfMMHVX6rcEIc3p3sWDrYzIs8pzBuM16BlVwUCh+JY2+J40BZcDAyIIc8Ghdg2EA
 ArLlucVQBUJ+Rcsqbr8comGiBznD5HuIUu3Rc5JAyvJkpum81XiPQ/CqnBbPHr/x48u4
 I0f6CIsghsVfMBkiJstnAHazPAQcUjj/7VW1PZXUFOLwqsnet02HMDdy8dOJ+p78Hy7D
 GTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777360929; x=1777965729;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAbob9ePXxjHYtphP4A4pHHvuA7vva/YHz7yIg0WG9M=;
 b=plyjc4Ut+ENoap+j5tzN4/0UdKoDylXtKqKY5nLegoYVp1YGjvesMSFT3Am6jrcSI2
 LqiROtbwLrrUJELZjnUk3I0w+exuy1jU0tqePqhveUPnJJulyyt3UFYfH2AO92uq0fba
 30WDSjDR+z1QKApRB8XtKJXEfs0XgYRz1lO5915DcT+pEAAVMRS037cPmJmkLTilrTlm
 3wvOzSwEq/zJZc5DPtY3ZIejYvO0EhFV2xhs1/tGz+6WzPUrqghhGbAx5RGoo1gd13Ph
 XptD6c8XB+keu7O0i5LMxpTKGE86CRlla3mTRGCGhHkn3R8Y0x1mOPOZM0ynzDPQoosA
 WXpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dWTkCNyJAEWNo2b0HMOIQmxEdtzIxcsL225J6bRaWKli8ZWCbqCjMi6LTO/o0e2z8VoI=@lists.linux.it
X-Gm-Message-State: AOJu0YxIg9ve6UMfa8Rh8DBoNeJjRBJFPsXGfflKFeIn3w308SNa7Thy
 AGWROgdmktnDcl6SeOAs+K+3Em9VWV+eiqHZKObpC6hvdXHKrSq82hT4ulZUz4VPZR1JfOLz8YA
 R/ep8pqY=
X-Gm-Gg: AeBDietkf8q+lZR9tzSgPX3mGK/2CFb2GRnKdx6RYK+ve+mJ3XSrr+58R2dOK/QWctV
 ZQTdLnwWb5MF+S3dFulFDCQaQ9860u4qwDBFWYVeoW3tKuuxphqWJW7EgFocoMQSq2CiTVefIvE
 i3gsFHDkO492FlLTRbNN30CDWnGneTkEmt0LJuvFP+cIUylmyouxktNXqK23pcmG7SX7j7Gbgui
 DLbcZM072hrbp0ZByn93ZlG4hOVZPpuNZfXkW/fPTkmAQJxnuvlrHt7QzcIH4FlWyL5kJrGYi6G
 Qk0R8QltfuPCbcW4wEjQ+GeE+PIMKffojWkbeN083QBsva+BBMtWT2h8jsma2bEeP43LavuCX5u
 zdxsEu8dJ49nTvOGSQJoZxHnYOfyN/jeoFewbGemgzOXPxPFn2ICsq8DMHf0m6Trahh9NFglMt7
 Qc3xPDpvSLvUWrc3ym2O0epRZDajq9bvSVoDffNx47C7PlQDD4T/wq
X-Received: by 2002:a05:6000:25f0:b0:43d:799c:b2cb with SMTP id
 ffacd0b85a97d-44651ff8957mr2911813f8f.24.1777360928921; 
 Tue, 28 Apr 2026 00:22:08 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59e90sm3960200f8f.3.2026.04.28.00.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:22:08 -0700 (PDT)
Message-ID: <69f06020.df0a0220.2be985.7a87@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260424113607.GA509887@pevik>
Date: Tue, 28 Apr 2026 07:22:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Update spellings to next-20260423
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

you can merged the patch with the suggested agent modification.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
