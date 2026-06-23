Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5EDCDB471
	for <ltp@archiver.kernel.org>; Tue, 23 Jun 2026 22:15:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC99C3E5937
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 00:15:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98F6E3E2248
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 00:15:03 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DD69E14001FB
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 00:15:02 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso861692c88.0
 for <ltp@lists.linux.it>; Tue, 23 Jun 2026 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782252901; x=1782857701; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zZUJj0D4nMWwz+lVGtIgvcxB//m5zKV4pT7iwbHeLA=;
 b=c43pYd67khJHRcfWyqucAUtJEDt3F7coPzaGhT9IUCtHHXH+mw0osOMChVH5m8mvKj
 MxNe3hlHakQ7kDt8OYBJqHJ+KvAgSDc850DEzB3n2aXACQcwW86BgBr2gYRQAELjEbnU
 pL+fICVCPEpKgro8gSAnw3/fxScPvzbA72Wa0v9wH7fXoAPaw1/kal5j5ebQcoiBHCk1
 2EWU2u/F2617L7B9Mceqzsjk5d3qVMVxKB75u4eWCLTNbYia1lqb1XUJZXstlerciO8T
 /hhgMo4AuqZpx1qUEy6hOoTAcU41694UFhkDBqGgWsOi5wSWbh/IMTTaBlAE6xC+JsL0
 XHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782252901; x=1782857701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zZUJj0D4nMWwz+lVGtIgvcxB//m5zKV4pT7iwbHeLA=;
 b=KC8JDdxYLXdVM2M9xdbo9ehbncdBW8mi5F+xWjDcJn0Y1GxX+0ei8SOU5cuYHa2lT/
 QKPoZYggjowL35c+TkuoaDtaEEpXG0UgN7LrpT3BN0mHdVhOsvgskIApNypLO05B2bZB
 Y+94UIrJLppWqlNfzSaLHevWp+Ku6AKPRrsagbMnVj/3ke1QL8dDYVJihJh/UVfUsHVD
 N9ghbyRL4iP3Zrd2SX+9I88pVj9N/auMniFOJf4XmUhjP4DMqYsWkHLpwNH0rs79X7dy
 +WKtWRE/aobej0Kxe2B2cZytc4cIuk6SzPVuDhO8jNuFU4byh77rPcH8M1n8MKfWWp9h
 TvDg==
X-Gm-Message-State: AOJu0Yx8Rg9Nkxix7WzphqPkJV8RYiNHCzfx0dTfhIelwmyIGhtJ16CV
 HDcK/DFXRMCyAV7VGQNj1rjMrzdMOEnM3GAk3gXsj6GHXH7RaslnIoBLLX+/bndU
X-Gm-Gg: AfdE7ckB8gKDtK8X3Z+eO/5sGkKJERbZ5BJ86V7y1dG037SlKxtnvKpQj4V9YnY3OpV
 p1LJY1gdRZR+nh2YGxo6CAhS7Ngbk0pxSX7m1nsPpLsV1vomquLSkm/ZkGh2NHck5DSOv3nv8mU
 iJJfUZr+svh1IaqPSrRGpRD6FmWFM+6gFmgxIrjpU5m2Oc7+wV1Vn9efI9IeWJMdYrIYMr2ZAXo
 mifc4RKeDgZR3jm2E8zggRQsc3k1AsQcBUvpzGTFMvCbFJiFXUoXhx1+HM3cRzefgpGfosr6yn6
 kUMoyQmxLA7rBRr9ZF1v9flUubNhqF3TR+dnw1OGa1qhO8SdJHz3NZ1B24pl3PF7kw8eF/LO5JX
 xVEHZOOrdC6eVmLfOZTzj16EFu6Xwqa0ohXWnm5HBugeej/7nr4xdAWcBnuRCAVDqjxnB+2ZsCF
 fVA46mVVObK+pCzTPQ/rWsltecY4oXGvQgea7PRjTF+10UjLOIdjBwQTRCnc7hliUlUp4Vfe573
 o6xJ+caUKSWpFZ+gSVCjnPqK7hfV2Q=
X-Received: by 2002:a05:693c:25c8:b0:2fc:9ae6:e5a8 with SMTP id
 5a478bee46e88-30c58b5e602mr4207523eec.20.1782252901005; 
 Tue, 23 Jun 2026 15:15:01 -0700 (PDT)
Received: from
 runnervm7b5n9.uymnkpukq3xuhcx0fnfqnihgha.phxx.internal.cloudapp.net
 ([20.163.82.241]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c68201a19sm1677239eec.12.2026.06.23.15.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 15:15:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 23 Jun 2026 22:14:59 +0000
Message-ID: <20260623221459.3866-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623200336.116104-1-avinesh.kumar@suse.com>
References: <20260623200336.116104-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] swapping01.c: use .needs_abi_bits = 64
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

Hi Avinesh,

On Tue, 23 Jun 2026, Avinesh Kumar wrote:
> swapping01.c: use .needs_abi_bits = 64

> As this test is not designed for 32-bit systems, so this follow
> commit 6b7ccccbdaf8 ("swapping01: Use .skip_in_compat = 1")

"so this follow commit" is not grammatically correct. Perhaps:

  "As this test is not designed for 32-bit systems, this follows
   up on commit 6b7ccccbdaf8 ..."

or:

  "Since this test is not designed for 32-bit systems, follow up
   on commit 6b7ccccbdaf8 ..."

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
