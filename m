Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479BC5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 19:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C45AD3C6E7F
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 21:06:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB0433C5E58
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:06:21 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E0A9140013B
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:06:21 +0200 (CEST)
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-456f7012050so1007717fac.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786647980; x=1787252780; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x9dCT1QpgMeWHvFe4BcoGA+YPkYc4UlfipY5sr+B6nk=;
 b=Uf+qD1iir9qTksjRIGY/9P0mqXwhcuUNW6/XflRy1zEQjS9ihxfZzz/V9LHiGH0KOR
 D7xRfBOdY7/J0HjiLebpg9W/xPGd/uLvXGq2s49/fdXaCBEcnDMPJGgxCjbZxBl3hi2H
 bvtzFKI9pPcdlj/8wDjAYAJyxOSgEBJPIRybdcN/uT2PQHuPixMy4HONMszGJO8Nhft9
 CoDswI/qjSGwatboRD1xCiskAp+uiN8O/ulfOrcsTCsODLAEZDaUwbExx4yxX2jnSR1k
 YlFL54dVexwDS8++FijSOlAQTk68g46In+LhOt1pCX4FEGWbHcZbiwNOn34qZd2RVwT3
 Ar7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786647980; x=1787252780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x9dCT1QpgMeWHvFe4BcoGA+YPkYc4UlfipY5sr+B6nk=;
 b=ZI9Jj6so9li5iXETVxQRlsHbty5aZApU/RL9LxlK8MtOWFRqmqNckilId9S80bed3V
 +XJAqWnKmVTz6o9Jk0d9GO6+howsGZws+fIM1f2S06aE6hBrQsOkYXznPe6Nz+F/gcbA
 H+BMPDXbqJk/uJWzJEEwse2UCJeNdfDDMrNGqEnOotAOoDKSR+yECz/wYe3X/g/j5txQ
 WFQmDDWiawASTnpxCAb8/t+ccuLQS0bLFfKfQA984RhRSKkluHDEfCs9WIYZavpt/8ez
 OommFfzfltUZWjqNGAI5vV7qMuXB34yFmcZkgBj47A2x9ZCHEFluqxCJsOWdi7P2+bir
 XmrQ==
X-Gm-Message-State: AOJu0YxTQoX8lLQ4xFVdLfa7nQJ6pfd0nXmo8a6wBbdQZUBtor5hZ8zF
 BrggslKhtsBp/JPg18De0CO778shh+iPdeJ2F5qvLK5GaurTOQpwYGz97ri74yYi
X-Gm-Gg: AR+sD12/ocaijedWNth3aaYGs9PI29pxQzBd1PGBJHBvy/trgdV/BsTFx311h1BjJO6
 xfTj+yZq3uVj24Mi1ifl3Bjd6Q5wkPm0vkmh+WaDaFlCDSbvEnMuboyUl74MRkCWFOt4JVFmsM3
 oSUq2hShM29gSX+8S/Q4lDbbgyhWsYJLnDGCJbaX9Y9VJOXniIe2re/FRw1vP1vaAwMs675bSLR
 lU5xcP1Ru/1EK2FxFl853FgpWTDuopBMlb74n0GmLWMTIk3Ktl3304EizyFmZR459nMVrbXSDj+
 +3MwAumMex3kmczu4Shh66lh88gMnodpcipEpIssFLy8i7UwDP5kRKdbCMYhkMjVEY8PSXRpi0j
 joAqSbLGRtiEMxUy51vDKq6RC6CCND6NmuCAzo4iYKkf5Q9g4OYmhq2rkPnv14UixV16LzVn3LX
 8zvmTDEN8EjwfUenAJHo6RW8oIlUmdfLD2gig9wKSM7++XuJZYF/ehmu4WffRuKZ3RLdu+rPxJX
 1nqRI/YZ1UTSny50JDbe3GShHcpIFv68cizXQUSoKbBipOkL58t2c7ylytIPwMU1dRJy8fK/ao=
X-Received: by 2002:a05:6808:4fc7:b0:49a:7714:ed25 with SMTP id
 5614622812f47-4b227e66b2emr6828205b6e.3.1786647979790; 
 Thu, 13 Aug 2026 12:06:19 -0700 (PDT)
Received: from
 runnervmvrwv9.qp4aleha3tsu3mttg3kqyr0yhb.gx.internal.cloudapp.net
 ([20.118.38.97]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b22cf5b8c4sm2279969b6e.10.2026.08.13.12.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:06:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu, 13 Aug 2026 19:06:17 +0000
Message-ID: <20260813190617.9128-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813184257.3061600-1-pavrampu@linux.ibm.com>
References: <20260813184257.3061600-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Aug 14, 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

> +	SAFE_CG_PRINT(group_a, "memory.swap.max", "0");
> +	SAFE_CG_PRINT(group_b, "memory.swap.max", "0");

Could these writes be guarded with SAFE_CG_HAS()? Linux 7.2 registers the
cgroup swap files only when CONFIG_SWAP is enabled, but the memory controller
and migration behavior remain available without it. On a CONFIG_SWAP=n
kernel, the first SAFE_CG_PRINT() therefore reports TBROK instead of running
the test. When swap support is absent, skipping these writes is sufficient
because anonymous memory cannot be swapped.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
