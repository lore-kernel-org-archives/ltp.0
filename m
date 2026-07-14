Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66DDC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:47:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C18A73E56AA
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:47:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDE1C3E56AA
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:47:26 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DFB4100054F
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:47:26 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ee27aa897fso17983946d6.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784026045; x=1784630845; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UbJ5jDRMBzsO66+5hVgdUIixzEBqHiTHP0ZaS3NvtR0=;
 b=q7YgJ1duN18X8zjYflvjpeesJBOFMerXiZ1/SzkioWOqRU7S+ShW7/VX5s1n2m8U5H
 pIOuUlrvppRZyaGV8wnOv6XLb2e3+e3zj7fd09P8VBc/3MiTIYvyp4UGFcXSA2mXkacK
 X+MkzYHxUSJ9s/SvbQ9kBPy7RDLonv+pRC+kByJS5XOUSRLHN83XIVExwYFsA7G5Ep6D
 E8HYEgnYUtxzaBXX/ahu12Ml2DW1pA7hvdYlkYtDHlFqnpXKwKkvy8urGKwGw7pWXzCN
 p45MD+7mbRtz5qhWZmJXgy+nE9hCTSIPYRKErGO6FNXgec10AYtfIqg6OFAOWm7eGyjE
 KHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026045; x=1784630845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UbJ5jDRMBzsO66+5hVgdUIixzEBqHiTHP0ZaS3NvtR0=;
 b=Shlivm5DApcbZNVrDndvqKVCHSaHf1+Xq4z8IpWv7Z0yYU2hdE1wRrBgOMkC4Nr+RM
 SLKnuHCUxbkwbm0TUbqb7gr1YeMEIAWURByS26VtDkd0gXiVED7DgmQwdOqOhg5yHCat
 9Q+KeZ6BSkYrPViHVKAScJMxBjU+KgS5MMYsssg0YYIa98v3KqwuZchfOVk5EAOq7Y+k
 UiGDgc/VkaT39P+ShlnqirdJkodg4ARR4y8LevWaEtmAlqz513BX0/GDKmSRbIM1n6Ka
 qO9a0eSDAikGg8+RXkAMzQvQelWFTRjVexNrgOtYiTNuGGF3jFVz7K1pAtQTdA2wOIM5
 uxhg==
X-Gm-Message-State: AOJu0YyyH9snzm9d9WP6hmIugGFLRuoAIOXUR1mViIgULNABhmKC14e7
 089zqh61EThIJP1djz6QauUeXKu6XNi+OlBE7t5UrtP8T5VBu1B8ggoL
X-Gm-Gg: AfdE7ckiSBQSgnIsx40RL5TvriYLLchOumxXXYr6JXI68LDNwKuEu1FFOa3SR+GuS1k
 yzmllKc9JO8fTdOitdHsgmUqD7zWERKM69ViXNiO0Ap57AjTp45vHg+DX6KCW1Fbzxyv+V+k7rs
 xwf3HH9xtUBUfukMNJLQ2QBXTrYG1aZOh2VR1eCPRHy5ZRjzKmjFLGpEjdFx3Q5bR+hDabDgjHu
 /rJBUOQnVpD5+GSlWF9/2WN4y/VbAozNGhyCwcSPvQi7vJcmbPycPwN214+9w3ivSr0MUegJUvU
 SFqK4D3I9LmA/JZERkbdhrgOa7cME58hKwdDzeHN83fW+o8EmhwRlRN1w1qCZFTeH7AwQuaLIfm
 D3bgUkszaPZrApixhvv4IHHD4lQ5ycH9AL0NSOogTmf74S2S1RyOhlykn/UhAY0sgU3Q9GCsIpn
 0FFmovj5UC5j19i9wk87GofxjvJK/hWGw+0drKTIpiIgodJWwU5cCDE2zsjxksODQBY2DOPENIb
 heomqjaPm9IQKP7CCCT4NQUQfnpEQ==
X-Received: by 2002:a05:6214:4888:b0:8ee:5e59:7b04 with SMTP id
 6a1803df08f44-90747c53536mr30552386d6.18.1784026045206; 
 Tue, 14 Jul 2026 03:47:25 -0700 (PDT)
Received: from
 runnervm5mmn9.a4l5jnhyvw4elhxgcp3m1o2p0h.ex.internal.cloudapp.net
 ([135.232.201.53]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9063df4319asm62774856d6.38.2026.07.14.03.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:47:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:47:23 +0000
Message-ID: <20260714104723.3981-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com>
References: <20260714-checkpatch_remove_rules-v1-1-b5c561f2dc16@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: relax parenthesis style checks
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

On Tue, Jul 14 2026, Andrea Cervesato wrote:
> checkpatch: relax parenthesis style checks

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
