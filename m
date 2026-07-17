Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FEC44516
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 698FF3E76B0
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:27:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A84B3E92EC
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:26:56 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E654B1A00F0F
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:26:55 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo3568533a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784287614; x=1784892414; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrRUoEveoIMCAuEMzeFZti6Gy/mXwTD+y+9su9HAftc=;
 b=mu85DXMCNwvuVjKNa4HyZ40BjJDp3qYZ1fFV4E1ntTo6o1wSO0voO6ccYVDtiQLAGl
 gMtdS2mZLYgEg/DEQf5RBHO56QzdMME4R3B0bw3Q7cq64SbYmMG2+gk1+6vgNdxDU6v/
 XjPK7D2x5yhHKcerdgUOhCeEtb4dA1pfO6dozM4VBlrdq/ifWqVw4xKK4by2upfj24mG
 ioNsWUefInjbYDEElixRIqqF+RdrULq6tE28vSwcR6PxoAMiCfor20mu60yXN3AF2HAJ
 gDwFBgzSwAnmnkFQGsQ/t64i6BNzv7HORmBICW+X9iyyOgVj/v89L+N06jKH0DRyeCiA
 NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287614; x=1784892414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrRUoEveoIMCAuEMzeFZti6Gy/mXwTD+y+9su9HAftc=;
 b=YUwt6gSkKECGDdW1eVhG8FshvhixItkaxv9nvhLvzxSvq06mPTFkPWWnJNAVFB/Q68
 Jl0nf8BwYNmNWa5YXZz0trorwi5J+N+lhnImx12w2mGgoz4ily3qBSsDTfRNfgOli3RQ
 x2SOJJezLfFVNG6EhFl5WyFUjBbRVCYtNXsUPZdWQCJBrPnwWbIuqsZlyZ7UJ9BHayqp
 DA/a/iz51mkiXutkN0ZYpJArz9WgqkH4TeBaidkUKZKpBrfKaPVRcVe6XL684T2WEK8r
 WgDVHhyZWPtIylDTZVnAWiiN/07LPuihIvLMHXZoyVnk+R6vTYSXzW7t6sFWhRP2IRXR
 ADJg==
X-Gm-Message-State: AOJu0YxvaugHeBUL3VRJNx9/0ryTQNKfWtJJlFoiqWwnwNo5l9sEaYiv
 H03aeDW8EJiwYnR1k54hYx7p/2eX0gQNYPCbYApv2uooi+5WdXhx6mQcTCjOU6PK0tc=
X-Gm-Gg: AfdE7cmNqqoMgy+XuMFRb317oihKtExeMmRKnZw47qdIzR6sW7bR8Zuh+bYhJZfQD4g
 0TOpsRKUR998XiUIyruYKwbKSpOoOQTrj8zOzXP0hAtFly+zNVe9JasAqd+lmRG1InofJ29baiQ
 dCJNujiJezQthAm4YPtAnbzjdRINNu6n09OSMHjeFKbNVP2e9uME7KKZhtufcC/y+jgF6UEoV15
 nWvYnugQFtPx9hyz4uvbdb8EvLk8qj9ArbfSrbRbl7u9W44uVFBpz80DR9kUusLz6WNz0nE32Zy
 1e+gdbI40y40mHY7g3BwzeKJaJPtTcH8HCc5Aq04qQNkjtfvndcNxkE+w8kedHBmB9LbedvKlZb
 k1xRo4ivgTepurc86/KPs9aKIcTKwCwAl/q3YkVQHFB9VmyXifIIWVcORVXYGCXyECVwxrrqTgp
 QjTIw0Z1NVvhLFB0iCPDD/y7bRVxrkc6J3S8al5ZsSzdsZYwALTqh32uOWWAZ46uIbpvh6EAAym
 UqLLGznegJrUFfiQw==
X-Received: by 2002:a17:90b:4e8c:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-38e4b422c0emr2158792a91.2.1784287613811; 
 Fri, 17 Jul 2026 04:26:53 -0700 (PDT)
Received: from
 runnervm3jd5f.bq5y5o1wsmce3f1q0ufmkssz3d.dx.internal.cloudapp.net
 ([52.225.35.115]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cd764fsm4784480c88.12.2026.07.17.04.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 04:26:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Kuba Pawlak <kuba.pawlak@canonical.com>
Date: Fri, 17 Jul 2026 11:26:51 +0000
Message-ID: <20260717112652.4015-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
References: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_rtctime: close RTC fd on the ioctl() error path
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

Hi Kuba,

On Fri, 17 Jul 2026 12:19:59 +0200, Kuba Pawlak wrote:
> lib: tst_rtctime: close RTC fd on the ioctl() error path

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
