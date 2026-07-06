Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B691C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DEB83E5DFC
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 22:03:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0454C3CD7B5
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 22:03:10 +0200 (CEST)
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 944A360072B
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 22:03:10 +0200 (CEST)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-7e9df14804fso415899a34.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783368189; x=1783972989; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ImIJW2NgdRfMC9/vy+d2q7v8G7RTkXyd+I5Zee2S02s=;
 b=qf3AfYhxAHoGW1z9QdkxXcqG26c3YHv+piX2R4lrk5/9OYiL8wqZwFIIIndua1RT47
 TA0LNR/NaA11e3e+TH/po8Q3dc1GmM3dxi5Ko2+D6gq/64i9iw3EVPJ08s64gOEMqJYd
 P/Tr1JwN7qgpB2onLentRVxmMQzAi9omIKLRMxExAuO9h+tqJkh256LrfUv8U+A+3o2J
 sWSxvzAj/CfGdXJFmhWOv4ZDnCgoLpH6qEqEdcFEhvlO2M7NSMBCUYeuKjy4627vosBP
 AcdJXo2m76/wuUYfCRYbX6KktWQOlrhJicJiiFugX/YraL+Ce/CtjGebFWaZ5NZT8+uX
 RSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783368189; x=1783972989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ImIJW2NgdRfMC9/vy+d2q7v8G7RTkXyd+I5Zee2S02s=;
 b=EO+Z3/6DL3Aj5K96LMDmw1Mlubi17OeD+c13pDMXmRsoZCAV0SU2OHPUKjhgCnxq4l
 QzQwuQfRxX/FTc7WKKAWoqrnG9DZHQOqJ+J7arSFhKdJeul6ICihXKXWZMUh/V4eBOcg
 d4UBRsnZ02svKiHjxag355jiZCbWcAOE07llFUw0PqPYL0k1zcP8FUXkjtAPL1rwd6ay
 JYAnJs8ueaPBqF5N/rYsIi5ss8Ot0UEIe9g/+xZM9LMQHzZLuIQlLm3Vv5o7DexkNQYr
 MNhLsNYjEggYJj/FaMxGSY2UdohyGN6wqfREMTva1V9kOjA6hcXO33pSihLR7Reio39A
 K4Vw==
X-Gm-Message-State: AOJu0YwA96FXBS4VsspJSTnl/W9AbzRa2RM0cDG0q8Uz8cLrM9Aaf+dU
 LUxfb4iL1duqF3L7QSKPLAExD69+caiPTrdCnvvjRbAYeeMLxMGR0OkHP1zgxOuk
X-Gm-Gg: AfdE7cnNulaxDUNOpOuY9iof0idLe8a5ltOw8qJ2OLRuXmlmc7BeO4xDmUg7/DNjDMx
 XfuZOO5rjx27V+2bis/wX863c+E6pUfrROiMOBbIWj4uueN2ggGXmak73jSXXPQ3fnuVPdtPyUk
 /1d3as8sghRex5wMW1IDKCxOGUr6ApAZ1Enaa603cwG6ZJ7Hw56VT8/kWJQ52d6qHsONM3oU8bk
 QpgG1k5xHO4EuS+su74YtzjIt0MMXyzqySA5uBjCTKUv+oXqWADtzS2M9q10IaFGbI1iLaIBDwR
 bfEDaDFFRrbmN+5Qpmaeq88o0ZIfHT84GTGxcLwmkdm01SphvZuAGfZX+aG1MOzdp8SCRxF6GI+
 oKeEUhXJHeAGn9ZaJy0lnjVloCgG1uaREpIZNS2U49pGTjY0hodafUF6/AMvNHhhow/+KTbrwmm
 vClYREHHxh5hUJR5YFcMq+ClBU4CPWEsbDLgda78B+3dJ/itMtEPGtY3TK3Xb9Cj7BKIGs3Mnfh
 KcRlf+FowP65Ve8f6d1H8g/lvbqUQ==
X-Received: by 2002:a05:6830:6ae8:b0:7e6:deb1:485b with SMTP id
 46e09a7af769-7ebb23223b2mr1301028a34.16.1783368188678; 
 Mon, 06 Jul 2026 13:03:08 -0700 (PDT)
Received: from
 runnervmkkn4f.uqmsj1cmwc5evorritzg5ak5re.gx.internal.cloudapp.net
 ([132.196.80.146]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm12359508a34.3.2026.07.06.13.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 13:03:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  6 Jul 2026 20:03:06 +0000
Message-ID: <20260706200306.3982-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
References: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock: fix make check warnings/errors
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

On Mon, 7 Jul 2026, Andrea Cervesato wrote:
> landlock: fix make check warnings/errors

> -		if (errno == EOPNOTSUPP) {
> -			tst_brk(TCONF, "Landlock is currently disabled. "
> -				"Please enable it either via CONFIG_LSM or "
> -				"'lsm' kernel parameter.");
> -		}
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "Landlock is currently disabled. Please enable it either via CONFIG_LSM or 'lsm' kernel parameter.");

The new line in landlock_common.h is ~132 characters long. The
original multi-line string had an alignment warning, but this hunk
trades it for a line-over-80-characters warning, which checkpatch
will still flag.

Could the string be re-wrapped to satisfy the line-length limit,
for example:

    if (errno == EOPNOTSUPP)
        tst_brk(TCONF,
            "Landlock is currently disabled. Please "
            "enable it either via CONFIG_LSM or "
            "'lsm' kernel parameter.");

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
