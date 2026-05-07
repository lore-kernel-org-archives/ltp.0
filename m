Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398E6CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778142640; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Z+oCOQOI9/bGB8ROe9rJVKDaGCrE+STQCbg6oYrWy4OitVRu8nrRFFj/cDNcpm+qyM7CR
 w3KD2TrnVrJAfTzNqiWWDef6gTVWwTIeBdnqjZO37QpGCS75sLPEnhbV+h4rL+1qMTjhJn3
 HoAHN0vfA70SCWkpQx8TDptU0rTh1tI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE6D13E5F6F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:30:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 152E83E5F70
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CA7E1400502
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:46 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso6471545e9.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778142586; x=1778747386; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Bs6g12FJ8wZQIimRf/QBEaDelTh9GnH6wPa/sPtE/r0NLIiIySsuFsVEsWA4XVnvvZ
 fFDQx/TDRQmRwfbjFidOeNkamHO9itZkHHQOX2qlkbVaCvNF5jbBoV+T7zSznL32oNCL
 hGqm1NueFZWvTFnm5B7fQ9eOXfE8SQV0Cgtd/EKTX5M+X8dRBsY1NFrbGWZ29hWOeDyM
 UHcUHUZXc0FL8mW++gaki+xKa/C+tKnnPmO9b33m5t1vBlttBq08WxmDu9hVvV3Qyyx5
 C1/410XII5L3Yyj5tNN1CJKuoaqIhZ4cv73onUMqclWzBe6R1gRNE6yQKvkvgUVBmLVo
 CKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142586; x=1778747386;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=UfvtQdyb5Gsqq+DT6GRnMxqfJM24EypLM1LMlQfWRfc7oIbDI1lGsZMmSHxZLP6Chp
 LY6M8WhoDATYjlONeMZbFcBXXlWeBqrZ3N7bGGNjNkeX8eoyDLU0FN1peZVYMp3+yEC0
 Xuy28bwWMOcojc/KydLvaYr1h7617mCaM/9PVddKjwus4ALft/pg8B3GpRLuik0kMba/
 6NWLMJxh/ub9+2y7/xVtx/4ZTVVBxAR5PCD0fflSMZtjByyZZwM/xqX7mxo9+/C5cZeW
 nOMfK+7Aa4cnRlyq5+9qXYAwubsU0Fov3nVOjOHmTDIwzpSdSgXmihafPZlhSiLZsqhc
 pdLw==
X-Gm-Message-State: AOJu0Yxy06uuGcOim09sMFIYJ8qUsO2vFtD3bIDkEfVlL9YehZQLzC1t
 zkJeRvMGxnyikTRVA2QIeLVGTDkStihFDriD3IFbsEjzkkO+cSXyiMiEJ5IyOvw1EZeNn1e0QG4
 qQ/mDWVaXVw==
X-Gm-Gg: AeBDieuzVBH2GU4lu7SMT/6VCBvjdjDtiXlhKLzL0DSzduWZx2Ufisz+HyxlguU3WxX
 /KfQggK4iVvH4OP+hfrj6K2YwH4vo1+gCON08mlT31ai3gGm0d8lvXOzqo8skf+dvycHEHjpGn9
 LZBazFTCzXaDStfH/mp240kTMzoSJY6KXciT1g/BoyjiYPV4vW+8HlDc8TbsdNO3gVJGvr3beY0
 xFsTjg71cYhLScfbcSzufm/4Jk8lj8Ts9Gst8uVy+44gTfLiqtG2pM09Zf5RdoFFROP8u6hNZvi
 6uisSUJyXLHWZ4gG4t649Unv3TWng2zYOW5WIX72gKn/hGY3yNEjLe9CDndNlReBojUnt3k8Zv9
 2oZLjQ0cnpk9l+d6ja4f8yMVmsM8oxcT+pqNH0vUo0aW1HrMCSBTg4e10qa/vLPvoRKOjBPPZdA
 +XGFf8gu37g7bFjYI54bXYGBe59mf8UTTrl/IFOizNQjyjTRgCCWFqRY/hRpEbzrbGMZ4M44tbt
 PL3QxqY/iZ6dJbK4tOxVQw7OqNslyPYT+iaQAr2ux+wMiozjjxjE+VL
X-Received: by 2002:a05:600c:8b06:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-48e51e223ccmr112246835e9.11.1778142585695; 
 Thu, 07 May 2026 01:29:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960fd6sm19683801f8f.31.2026.05.07.01.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:29:45 -0700 (PDT)
Message-ID: <69fc4d79.df0a0220.774fd.b9aa@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260507075006.8690-3-chrubis@suse.cz>
Date: Thu, 07 May 2026 08:29:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls: newuname01: Fix fail on empty
 domainname
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
