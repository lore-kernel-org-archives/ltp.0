Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5563C56208
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:41:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B5A33E2D1F
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 12:41:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00823C2678
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:40:58 +0200 (CEST)
Received: from mail-yx2-x03.google.com (mail-yx2-x03.google.com
 [IPv6:2607:f8b0:4864:41::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38DA42005C3
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:40:58 +0200 (CEST)
Received: by mail-yx2-x03.google.com with SMTP id
 00721157ae682-81e7a64294cso5337657b3.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786012857; x=1786617657; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zP8AtVzRtKePExhSp/kxTYBvn2L6Tzz00hfedEk5hEg=;
 b=iRvC0klpInuXxWRUBr/k8FAdHyAIzVp17w31Hmwfx61sRI3/xww/PttupfL+1Muuvd
 zp6KsRrn4Qh4p17cLVJQ9jZOlBhLnzYOmO+3U4tP2owCsnJSbE6nvwB1senXiXDJMcZ3
 VGXPty0XjxyhIKtdW0j0orCgAzTSAWBhkQbrMsx3rS8W7a/rfbKsr9rzUsxhZsmzcTUj
 UL08tsfYNvECYHqW7R3orc8DA/d4gE4xuUkJaTFDcRQvN3j4ezgfq1Ykc30BUS/LiyJ0
 DAR86SrK6mEDW7W9PA6zTd5oz1HypTf+h2c2AVTLwTOXONEaoW5cNoJHIyB5fgdNX2V5
 ExRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012857; x=1786617657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zP8AtVzRtKePExhSp/kxTYBvn2L6Tzz00hfedEk5hEg=;
 b=RNcPGmz95Esh8ESQW1ToSxsGVhgUrUBWK4h7Ffe4p8oVkuT0etJJklnkaRNhAoAtBW
 2BzYYKMh8NWnwdtrDk5duvyX4EFrLICkzUBvqpjHmaHeP/mPbD40IZBi0r9Xuri9yfyz
 Y8rXtyoPQBYtrscZot/sruQCmfdc7onCDruDG9osdXhu/YCEGX/RiGfj6h6bgLEoD9YZ
 aUwLUpx2vce1Wora8lASVF9E1rmILQK19Qho51HVWN+Cm8Hwo5ehWSYY2S4jQglws4Vj
 MJ4I7L8zmrE0CmpYKEnQSjduHxSCBfuO1tzof4NCZv3O+IFx8toKdRvb/xulsG7+0XHX
 cUDw==
X-Gm-Message-State: AOJu0Yx3YnnhHAMfKQY2eSqihhWbLe45ZFrfqCtwoUmz/ISpuBOqfrO3
 ab7WRQ6TVYU53OM0pAV2+gJs2qR+c/noB3E//MoP9pvieW7qrEZybiSK
X-Gm-Gg: AR+sD10Abi1jWTnAn1rxCM9bw8HjAsQEDSE70ihc+P67giTKKnljHG2bjYIaof+qUEY
 VA0w4v/e153h1AT+Cqr4Zz19NGdCsnlQ1rAu5n8fSGELREpx6xnBG02UyB9NZ+fkS150TSfv4Ds
 Ywv3Q24c+wYl8aHrn/vOPKt3yPG8xRkRXNyddobnAEX72FhjUsshxP3pcy2CR6a79MbjugY5j1d
 PieHO3qqtoJPRojFp/gNGrAmHvUVIZqWCs6CBE+oM+3Ecan4zzrTtWeIyDLos1epREiWA+EPK1t
 CZvaEtK48U0nF6ijgTcVc58Q1cA6CKqR5OAopQgoiQFMPPm/4rhWsJFv8FxmB7qN5m1fbkRrE3O
 gTkhF3cPZogYTxyXMntz0fR0q1OJJ4XIUKNiiWMMmqxhbLHbR9GY5O2na0+Z3vO/lsE7YxRySA7
 Nma7Hh8Wihb/cV1tztzyyeyQignMfPIclj7QZtyFJU+7fvO3hT9hP8btcTEYUVHwt/Mb6pQgM2A
 rSAhWfHvb4RyzzHRxpZT9LDhHMkZrziKM9+vJUP82Ziu5QZCckwYQs5Bed7YpcZKKxL8parFZzs
X-Received: by 2002:a05:690c:7286:b0:81e:6a10:f90f with SMTP id
 00721157ae682-8225ba2bd2fmr2477367b3.17.1786012856944; 
 Thu, 06 Aug 2026 03:40:56 -0700 (PDT)
Received: from
 runnervmvrwv9.floazsvxcilefmrd5phyrjbtph.ex.internal.cloudapp.net
 ([64.236.201.39]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8201323141bsm36654597b3.15.2026.08.06.03.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:40:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  6 Aug 2026 10:40:55 +0000
Message-ID: <20260806104055.4267-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806-tpci_refactoring-v2-1-bdc3a749ca02@suse.com>
References: <20260806-tpci_refactoring-v2-1-bdc3a749ca02@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tpci: refactor kernel module
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

On Thu, Aug 6, 2026, Andrea Cervesato wrote:
> tpci: refactor kernel module

--- [PATCH 2/2] ---

> +	for (int i = 0; i < PCI_TCASES_NUM; ++i) {
> +		if (i == PCI_DISABLE)
> +			continue;

Could the successful PCI_ENABLE and PCI_RESOURCES calls be balanced on all
exit paths instead of unconditionally skipping PCI_DISABLE?

In Linux 7.2, pci_enable_device() increments pci_dev.enable_cnt even when
the device is already enabled, and pci_disable_device() must be called once
for each successful enable. These two test cases therefore leak at least two
enable references per run with -d, and more with -i. Unloading the test module
does not restore that system-wide PCI state.

> +		if (!is_target && is_destructive_test(i))
> +			continue;
> +
> +		SAFE_FILE_PRINTF(DEV_TCASE, "%d", i);

Could PCI_RESOURCES guarantee that the target's original driver is rebound
before this destructive case is enabled?

test_assign_resources() releases the driver before pci_assign_resource(), but
only calls device_attach() when assignment returns zero. It also ignores a
zero or negative device_attach() result and treats -EBUSY from assignment as
TPASS. An assignment or reprobe failure can therefore leave the selected
device unbound after the test, and module cleanup does not restore it.

> Merge kernel module with the current test inside the same folder and
> refactor tpci test using new API.
>
> Now test has a -d option to select device for operating destructive
> tests on target.

Could the commit message explain why the directory merge, API conversion,
and selective destructive execution are needed? The current body only
restates what the patch changes.

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
