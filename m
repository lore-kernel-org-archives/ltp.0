Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48BBCD8C8E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 08:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F0633E4E80
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 10:59:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94CF53E18CC
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 10:59:34 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E57A60057C
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 10:59:34 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-517b1f2c668so11602911cf.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780909173; x=1781513973; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De7ao6cX1oTrpjXqlwtAVtoPbWA9se/kcSIiQnsEKz4=;
 b=EVWSN6VmZkS4yFH/AoRhvcX1zgts5pM5JWM01fJgvb0zcHZE7gMPP24DAWZFCUYrM9
 Nn7wZSVPn/62CB1XpwcZBRO6hhibGtkBQMW5/B+RH4su5cnJRZF21qK3aVheL4nB6SZE
 nyrah7yps5Ietfqcyij/mH4IS8zAyBWVJaq7qB4uozpLYeM0Rv7lNmvgy5fb0Jm/vZSP
 qh5bJf3W6VEj2sAf0i/gtkWtdJsZzn1nTCJ902BsuwoFRCOR7x7U/ucNsHSxkFxFbhQM
 X1oldsvt1oSamGKF1M7UjesqQFXJx893Z6fLcivlgnqHuvrnhSM1fRYW27MFXWOtxaLM
 m0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909173; x=1781513973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=De7ao6cX1oTrpjXqlwtAVtoPbWA9se/kcSIiQnsEKz4=;
 b=idkMIuMhlr9wXYjLLoP9NcKdkMmxtg0t4UBkMLkj/Yh54NA6sinmXkJKpayHuL0Lbu
 ARPHZdnyAo2CgI6KtvfDKvBxnfmnUzpLv7aXRLq+C3fkOPlHa+RqLET0uOZ2MZ25N7zQ
 wyuYZQTxMuXyU/CSBe/FBmCgh0AQfQNMYdWxa2UN8A3T0mptuu1qQ7ijYg/x5cIheMeb
 RYDN1ICHXmQZWy18ESLuBEyNXbqB6kihfA3cleDTzlf1RslqRE87Hgp4u4iHp35HRKLD
 F2yf+ZihPqGL7/uGq7G/5o1wQiV6OfNlHIktLcWzvTiNjZ4ElKBO93y6ClkM0TgCv9Xs
 BbpA==
X-Gm-Message-State: AOJu0YxUKqU0qnyPMDdkbV1nPULrUhOw1qsAedhY8ah7ACZqwdYAwo4D
 8N5BY+hkc07vGXGVb07zUak3gv6WL6or4zIVVx04T5WLlWlYH61KB9CG
X-Gm-Gg: Acq92OGshBIgKBHHApUhI2UN+qyN3QP9VhnypXYw70zCJMfem2SEYC2QAdHa7mu76V7
 k4sDfm2huCYm0xX4AnrxQ4FU6d+1WS8P0e/KjSmpxytblBBWZxi0j060TfMAfw148e4jdYjfkn9
 NkDHHJd/lSJ/tbQERQx3Z1MjhmhFDZlkV4HsPwLSc7z6hNsKDI0od5gDTWEscaBDbpTdiaQKVou
 DMN65l1fr3sfKniBjy1I/dT+V1GwAx7SkKJc7CvVgIDW7A8BUS6yTb9I3e12at/Ruxc+t5uNtnS
 0J62W7uOnlgmiU9RMXnPnna/kmgYMBQVauLPG8qT5dlN3SQkwH/7cSGqQ2pStZShiHLKJPdnVZp
 J0j3dAYbguee+QzS15KvanqhG1Hln7wBXhGJK0aOScrBh9bVdCTyRr+pZn4YUD+beeS2eiZhGOG
 887eVWZQ0xD2t6xBQqr8+l4BO+WTJIiGbsA+uwqtvs2y2JjiJ9HEU/Pu9CpbDxsgLqP6AZbBhJr
 zLmuQZqQQwmsSmHUwldE67Cgqtg1G2Kl/qd6/RAZQ/RFjxqLQ==
X-Received: by 2002:a05:622a:98e:b0:517:6350:ed50 with SMTP id
 d75a77b69052e-51795c11978mr194076891cf.45.1780909172880; 
 Mon, 08 Jun 2026 01:59:32 -0700 (PDT)
Received: from
 runnervm3jyl0.ojwbv2crwgce5ixxwjd2zbzc1d.bx.internal.cloudapp.net
 ([20.83.158.131]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775d8100fsm151711371cf.14.2026.06.08.01.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:59:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  8 Jun 2026 08:59:31 +0000
Message-ID: <20260608085931.3981-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608074419.1276-1-wegao@suse.com>
References: <20260608074419.1276-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ksm: Fix sysfs path concatenation in ksm_test.h
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

Hi Wei,

On Mon, 8 Jun 2026 07:44:15 +0000, Wei Gao wrote:
> ksm: Fix sysfs path concatenation in ksm_test.h

> Fixes: 40a366b53adc ("lib: Introduce tst_path_defs.h to consolidate system paths")

This commit hash does not exist in the LTP repository. Could the
reference be verified and corrected?

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
