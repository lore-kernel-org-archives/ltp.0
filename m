Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C3ACD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:25:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E7F3E6E7C
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:25:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 036853C1C1F
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:25:05 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C7C960071F
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:25:04 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1383e116edfso630676c88.0
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781097903; x=1781702703; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYKlgDb58Tu3MptCBrVzBtt91hqGkXWvI41yLv6RKTA=;
 b=nBSlxbp4MUWRH32QL2SWapCCD7a2XJHOFD7hAj+xtOKYT4FaUYUMd2dLzz4qf2son9
 Fu8SHel514KHbEG5w+YpdbYzgRoY+lgwsOwSTHhRybgIqGfE03uf8vjNhNLhp3a9bbIN
 93yR6FFMMYvol0JXo48dLiFMYpfWjj35bVYCIyXofTijMeWKkPymloaRCl20+Xnf290R
 yrlIEE78Tbkbi6TqnM1iIkIgpMod4Aw/HbEeiquFxB+aCGAuHhY/Bj9jN0tiGicrQq4q
 W0bAfcXOFzboPksceBew2al3jmPmOspNFvxa4OOOt1fmtiVxeXCJxoF7YAr/She3W5O1
 Pd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781097903; x=1781702703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CYKlgDb58Tu3MptCBrVzBtt91hqGkXWvI41yLv6RKTA=;
 b=lapeMAwHvEG9yOLQWl0f26OMJZIkcA+bpayaX2ZeT8uZf+ZXZgoSD5f97MTx8WVRkr
 8EJzSfgm0Y9494wnUXYa611DFWDMdIUP9MhHlb+bd420YVBRlOSyrMMhETiiKgTNEj6E
 +K9RZXDZUUa+3BEXzatRjLpuW24k2PixaBC5rWWwJ2bExcfRfnGuUcPICF5C6JPq/2+T
 BQJrmSqs0NuVKmeRCZvChH6CsfR2TaFYrawZEye7eyAIApu6UgOvbDJvSbqGmLIjKMZI
 zRC8YHUbAWmAvnXLLRfE7EQC2ZvwnNOn0pKEReZcg0Yl332UxWqLGzN+TzPgzYdti4MW
 GLsg==
X-Gm-Message-State: AOJu0YxAb+ot0wOTZYv1ApbF7T/R12GS1e60a0GUyLtqpVK8CnY2o4zd
 euu1m02fqPd34GrfPBgWl/p7hGwtKcZL5gMrOYat5ejihHXjoWws7fFi
X-Gm-Gg: Acq92OGgX1/UKay0+0xXY5q7fziYPv3EMAcNvr3JoPWQB1RUCcpKTF1/qvdU3sOro5C
 97s0Kng16QliDMnvYHiOReMYa6wsOnWMep2+JtaQDtXOnjRzJp20akKKhy21FsCPhRARvY/7xe7
 A8p61XKKTceQ03QNEneuKtzzLDKfR9qPs0T/1g29c+LfvP5JIHgQpbj8b5K+oXGcyJL7wpRtlXe
 28iNN0gDP7VwDKTzP1D5au4zXoQeqJeWeF/L1Qp74jWEMlO/jAdA0YQrMn6TuZlVNKrhupnPvm9
 Zn0AeSzIwQOGWGaj6YL7lsjO3PDXhngXdVjRurSCQzR9ec2NVH5YaqMIMt143QEXauW8jbQ5MkN
 oViY6ZdCvuKQHJqMKN46GhV23uUw53kZkhcR0TFPCXLnRF6IqSMnp80Y6UDpDF7L80BjT2NFalt
 eDCuLGvbTYPlwblC9t1rAfxZppSSpFDvjH1uZxTFkLxiMXobe9g79aySG5XkXF3OST64mU69/98
 dU7zD70d1t3UBApa7jGvcKYiWzkbrTOvldfF38ztoFHDL5d5OEV2ao=
X-Received: by 2002:a05:7022:f8f:b0:135:608a:2864 with SMTP id
 a92af1059eb24-138067251ebmr14207075c88.33.1781097902863; 
 Wed, 10 Jun 2026 06:25:02 -0700 (PDT)
Received: from
 runnervm3jyl0.sbzdpbrwhzzuzo2oi0oaswtc3h.phxx.internal.cloudapp.net
 ([172.182.193.131]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm18501531c88.6.2026.06.10.06.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:25:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 13:25:01 +0000
Message-ID: <20260610132501.3990-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-fix_buildsystem_modules-v1-1-7f24a774d19d@suse.com>
References: <20260610-fix_buildsystem_modules-v1-1-7f24a774d19d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build: run make check on test sources in kernel module
 directories
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

On Wed, 10 Jun 2026 15:00:05 +0200, Andrea Cervesato wrote:
> build: run make check on test sources in kernel module directories

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
