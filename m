Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0D4CD6E68
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780552664; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=a3rvyekdzOJGt0IcIl1Jf+pJCjRSVRb7oK2ByPs+3e4=;
 b=hkduiksvgmOBVQx+ZkGqEdhujq+ezQg+YtcQG3k7ixUA0RtgL2F9uZEGcaI2IIXKR2UEl
 JGDUeUD2Vm5rP1+8V6Jr5fSh+GE0nEl3M9q8HKX3ReeSESTVZH/AlQ6o+IUKlhra8k1Atq+
 CatJApk56IEZsgECUQkAix1lryCPTVk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A2AC3E2790
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 07:57:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FD993E276F
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 07:57:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3B9560007F
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 07:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780552642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSLFjvo/WDkAsNuNHp7KQZm06Zb2oxJTU7gKgfHl+Ao=;
 b=WZbhhUE5y2RCRZ/Wf30t5A3DarThEXCBBW6I4ZJccll+TZZZHu73WDeHMWZOkcjDgVA5xR
 aKbBPFz7a6w1UgJL1I8zMB4iDpX3zJ0VK+kOKRDRlAiIQ788ShgDFvSgdcJvkGHI7U2aYE
 zy3Y2kUNLz96D6fjX9Sycp4PNwZ+zLU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-3DFaEY79MQOXxyTCUNJAAg-1; Thu, 04 Jun 2026 01:57:20 -0400
X-MC-Unique: 3DFaEY79MQOXxyTCUNJAAg-1
X-Mimecast-MFC-AGG-ID: 3DFaEY79MQOXxyTCUNJAAg_1780552639
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-460153ce644so182617f8f.0
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 22:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780552639; x=1781157439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dSLFjvo/WDkAsNuNHp7KQZm06Zb2oxJTU7gKgfHl+Ao=;
 b=BuLXE4g5Ur5cvnyws6EFEvRLUUzbK4Kdtrw0MffBR+H5Jtya2GaMCkapHH/dfTtyLi
 lm/jQd0nMEhgbDzo2xkgli7wuGuW2ppUcWuKPFQJdk/CC4W92ipAWKk57H3P/kFKuy6u
 A4VhJ2H6WQo2u2AdLI8rmaoMgnHl9zsnUiSRvMVBdWb1YPO9RbsVKTdFPVLJBDyklLzV
 ZoSqmEmHpd7kCF0pg4BbkxqoSHe8Ds6L6QnXgsVe5+r8YbjMclkUbdGhZ7EDZ50kcne7
 aR3+QlRxLY1kUy8LYc8N5Q6w1dFc5a7Mx815R1cqhuMGN4L5SwxRPyBdg9nPS4xitrfQ
 LPGA==
X-Gm-Message-State: AOJu0YwjWkgV0eCIu/dbwj+mGUXLjP2Q8Gj8jKBJN8U/k8TTnWRcECJ0
 qC9NJ7ZHd26fDCvIAFpyKv+7nrlkr4dxn8su3qqD0F2H1/f2i8CbfwHCTV+x9XsrpOQ/Cbb7tnQ
 iYX6HOsT55Raz4E0KTp72ipKNB5mM8kBuLdl0ZXtpPNhv4XqTdkJUzU8n0SV9otAFZIIKyoUOwa
 AJzi4KCxZShcNoKcWPBn/rkw4Jhy5sJkkMB9qK
X-Gm-Gg: Acq92OF/vyMgQo84qi39+AOxd4SJEA+wxkl3ZjUGUErCrr38QvsEVO0+5C+vrw3bCAa
 XSMlTeSVEFO3ySSsgwdDIuUIEv00c2t/EhhvlEKI/f7T2XgP1a2wo1gKzYEfjwkSJiJNObClLAx
 8H8IK00jDm1tFebfBNzlpXah5gP93MhDOq1DBYPvVrLPnjmpSmys7bqu8cxJKvTxbJDpHOb4WNc
 p8zVspxnp56o8g7sbjXwQw+E7EoKIfhmDZFYYSM4tWyRlseN7XLtbt8jaTKYsnowKXcI0fg89l+
 w6Gg5omY1U2ryDsOm2J4W9d2DslgScQaj0nJZTCax7ggnDM/GVedhVg8alpezT3xAZ9yriy/P6f
 tvpU3nG33fKc90nHQPzHt9wUUAQhvGSjJFkkEWnFClnLovU7EWsBe8PPReNneX7iat/RxfmuqR6
 wGgg==
X-Received: by 2002:a05:600c:8184:b0:490:44eb:c1d9 with SMTP id
 5b1f17b1804b1-490b60fb00amr92078035e9.28.1780552639145; 
 Wed, 03 Jun 2026 22:57:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8184:b0:490:44eb:c1d9 with SMTP id
 5b1f17b1804b1-490b60fb00amr92077755e9.28.1780552638726; 
 Wed, 03 Jun 2026 22:57:18 -0700 (PDT)
Received: from fedora.redhat.com (46-116-121-128.bb.netvision.net.il.
 [46.116.121.128]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd663sm50289385e9.10.2026.06.03.22.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 22:57:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 08:57:16 +0300
Message-ID: <20260604055716.12177-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-1-mmenashe@redhat.com>
References: <20260527092618.14824-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6HH_WBj4pl8YxyHnW36RndUJZ4Hpmr43nJeUF5tSg0k_1780552639
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14 0/4] futex: Add error coverage tests for wait,
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

Hi,

Just a kind reminder about this patch series (v14) sent on May 27th.
The LTP AI Reviewer has approved all four patches with no issues found.

Would appreciate it if a human maintainer could take a look when
time permits.

GitHub PR: https://github.com/linux-test-project/ltp/pull/1301

Thanks,
Michael Menasherov


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
