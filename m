Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401BC5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 08:24:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF59E3E6CBA
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 10:24:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AA9E3E27F7
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 10:24:11 +0200 (CEST)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 141001A0011F
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 10:24:11 +0200 (CEST)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-7eb36c2f2b9so98729a34.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786523050; x=1787127850; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7SYLbd47pkV0j5yBsnW2xWeJ5jQEwQdaOJw41K8SvcU=;
 b=VmXBfdQ+WBXyf2TCGmqPqqQkynOYvgbDYPmbBOBvDswHfCyjDsC5ZrvCiZW/0l6uG0
 mN63U4M0RxJIHhA4gyDAOs1uw5DbAo8nsXcTcrCGa/q3KJaCKS4+0idedghWqbSWuTSS
 NFSPNiyNXcADt3NolsMWKAUpagOxEXhUqY0GfFHChS25R7n6bAFqMPlE/W1lKz9qTNoS
 0C0Rl2HvQDTCUr6UJo4CyPozyInZxXuPyjS7YZIdqyEQH4Zq8fInbHHrJr2vZHXPAAkP
 lpCIdDqxptpZ1WmZ4v9MWMyiokD/+Dia4CbwJq/Jr2y7G885fxRl6l10Z+kdescsxYuu
 1dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786523050; x=1787127850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7SYLbd47pkV0j5yBsnW2xWeJ5jQEwQdaOJw41K8SvcU=;
 b=rj6gStIHSFmE5jKz4dcSQFfaU3QfFqMgCIBeE8StgfF3jgrguYGp6WWSpXg5FYrXtx
 0EkCS2OeeUDNMuFALGETCwqilYn7072IXAj1AdBP2z0nLy5VD8E4KDLb3iPpUbBz+MAg
 7x2rDfEbXbp4L0qlohNG/Fq1FHO51zhh+r5Rjhr70hpfPp0IPOhgnoRpE2b7XhTnTH7a
 j8FXPPLssqgX48MZnY0m0ykbZBeqs8h9TfNl1UgN2+lHybVwA6TKvH/vo0rTBCf3Ap8H
 fugQazt4pkcbM2p4uqxSpWpGna2oMoHjcO2CpHERV8+kZsVznePokxXngl/MsKGK2hlF
 KrQA==
X-Gm-Message-State: AOJu0YwT2bSb7V0MCNFRh05WVfGzYgWQUdMHv20a6egOqjSmbpZKM3m8
 H4nRv6jITMZZ8ObS4T9udxQiLx2PQnUorpf6GLEm4MCM4Fcx71o4stvL
X-Gm-Gg: AR+sD10cT1UIhNvDznYVPRpMBbjq2k8Z05NMm3ynggFvqWjmqtu0hyvPxS3+TUBMkkx
 zjTPJi+gv7nrxEu1H2oNlfjgdkgGkaiEeoI7z1h7d2WFkVhLxvqg5fya8sC65XbkK6eJwyUtYeh
 XmdIqx8vlhDyrw937OXFb8cMX9CPhAZAEEsoIGhVKlXjCONCqdFweHeBGOrB8PO5+eQag0SHwTA
 HE53qscFt19qQv2dQy/yTxYlVQbynQYUbjsLA87hQ2pAsqWbo1o90Hc1HOLY6zmAM0aAJ5eh9pL
 VvHhdQ9XP8h9RimCBtXXXlSiaC4nGI8s0ZNuDWx1O+Hmoi2hQBCTJj9nRe9Kit/gnm/rUcOsI/R
 dbOiB9TUC6YGXnBl+F3aaFFFwg+fEeyGzbCtN/bI71kT/xVhOYUDy34LJdIVErVm/72Sjlf7Zg9
 dU2y7KfBOhP4b5CgwjcPJ5toZxP4kXVSUMLtz+g89P9smNOwWJpTqBeZ2yPfw24LP5Q50VwWYHD
 dJ5+gIGxmkB3whnkrGZ8TLnzTD52a+ISZBF8SB2AWzKxlhZLYAPxljj2RvHpKhRiI7yQii/2iPa
 BREqdHRcSrd2
X-Received: by 2002:a05:6830:2aa5:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7f3b76e11f1mr3466105a34.6.1786523049643; 
 Wed, 12 Aug 2026 01:24:09 -0700 (PDT)
Received: from
 runnervmvrwv9.cqadvpg5n3kehpcxmdhhiz2x0h.ex.internal.cloudapp.net
 ([64.236.133.103]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3b3209115sm2392714a34.8.2026.08.12.01.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:24:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 12 Aug 2026 08:24:08 +0000
Message-ID: <20260812082408.4228-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812074413.3159992-1-wakel@google.com>
References: <20260812074413.3159992-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] controllers/cpuacct: Dynamically adjust cpuacct_task
 execution time
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

Hi Wake,

On Wed, 12 Aug 2026, Wake Liu wrote:
> controllers/cpuacct: Dynamically adjust cpuacct_task execution time

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
