Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD80BC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 10:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08003E1505
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 12:38:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 898A83D00A7
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 12:38:24 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EAC1A1400DED
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 12:38:23 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e51e6879fso37651585a.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785926302; x=1786531102; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDLGMlJyDNKNYvte7OGce3AwKbwRd9rft5F6J7WteWE=;
 b=M06aswqkamW6lIipKdrDbdT8lAiae6/XzK+uYglQPfFvHa7seL3iqZ7iFtHhaIzTXk
 CXDm2Dia9aFEQunZwkwRy4HwwMi1UAOxV91VlzS+6Y8cN6jcpSrkXzAabwE/v65Qp4Tc
 uy5fgAp9Hkq81x3Gmdin67Qa1yjObrh4i9TEQdatpeSg3M1McdwHDL4ap+C8Lh4ifR5f
 Ahua5alvbgxxav3TMuwUpKGDc0dQ8S3djXTZAmNYb/GNiJ2ho6zA1gmJ4CWCXkBh+L7A
 s0OyhB6gUs0r6OflFzHL5PN5+3slEOZuh3gsfdODyxc2amz8AdlTJB9bmnbhi47MpTOs
 pu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785926302; x=1786531102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDLGMlJyDNKNYvte7OGce3AwKbwRd9rft5F6J7WteWE=;
 b=sal15Xr3kAAld7yFELJz4QQKjmOAgUrqdhmy1J9Fpew5DISG5xbrxBbqjNJaxQiC4D
 /E+pJLrwvcFjQFnBUR+gTppIliZxxeWIauprSqL1jfE0ZamCUCJQVh2HTXgPbfaalfwj
 4YQdQ6SVg/f7vNmS8Ri3d/W+/2yhIjGbkJai93I69yeUjrj5Aafqepb91A2nwbe5B8Vr
 mNGJ/Gbzs+LLvgZOEnL7I7xsVcTVNcSIZz+eBvtqOyT1E3lo0UlWnC3AOC7b4TTzw+pI
 ut9LojLQSqGEGR78Wh6kjm5lOZ9mZoK3mcOlkIvpc7cs8BBtyRQ9tPRSMKi+Dvm6VMNF
 G06g==
X-Gm-Message-State: AOJu0YzA7XZF7PTVkxIaBxSLqfQ8Rd37z3poCrxu+dJWxIzv6ANxlUWC
 AZ+utyLhlZa+wroTmC1QPgoTaA41R6DQiKP86Fgyt9S8RyQRgtKHesC0
X-Gm-Gg: AR+sD13Oc6f0hfPqfnw+HBcskhzUlF7EbBsXFqkHO/XQiatndC71og34wm2TbjnryII
 EHDcVqrUUBPWYxA9TGooFAuqZR4ueUNAAya7ZsJJ0wd/1l4zo+IXxpKY0CGG2lixjFvtKkye21H
 lSMye6JxQW7i2a2KcNrgrH2y22yE96925l7mBs0SXO9qcpbyE//KyrYbT3/JDpVfMgPdeNBEbWw
 chA9eY1c9Ii4hDVkz0DfwMbrvRoxlhOKEmNHwMfVY0B0rFcnsh5inPsmFmA0TKnqiZa92aTsSHq
 XiElVODTbql9gEbn77Sya8hOFwOwQLVn/B3EvdbSLHMqXp4GcB7Ne8uNLmUXywbV7JkjJiPPzXX
 cYV0MF1am6jb9pPCFz5rF2VlFqbFBFKvPKVps8OlkRVB3jF+pKaeiW11E7iyyWJROzeJAEEUPY7
 U8FeGm62/bnQ5lBHNuiXrCJvRSKUh75FsLwDYDegfaksNQBBYQhTvLbDbrRk8jFgYEYiiUuMwz+
 1du76ke9pIcBz5DMFGoI3sKb9yIf6npm6G8+evViMWm0+wglv1eBV/U0dAbgwcviTqXeQe/20UR
X-Received: by 2002:a05:620a:7186:b0:930:fa5b:6ee8 with SMTP id
 af79cd13be357-9364920e0d8mr379278685a.45.1785926302558; 
 Wed, 05 Aug 2026 03:38:22 -0700 (PDT)
Received: from
 runnervmvrwv9.p1ufsl4xqpaudj01gz3oesysqg.cx.internal.cloudapp.net
 ([20.161.30.225]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a5654d4sm119984785a.36.2026.08.05.03.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 03:38:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  5 Aug 2026 10:38:21 +0000
Message-ID: <20260805103821.8953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805-tpci_refactoring-v1-1-4ca8d84f8a95@suse.com>
References: <20260805-tpci_refactoring-v1-1-4ca8d84f8a95@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Wed, 5 Aug 2026, Andrea Cervesato wrote:
> tpci: refactor kernel module

--- [PATCH 2/2] ---

> tcpi: refactor test using new API

Low: Could "tcpi" be corrected to "tpci" so that the subject names the
component changed by the patch?

> 	for (int i = 0; i < PCI_TCASES_NUM; ++i) {
> 		if (!is_target && is_destructive_test(i))
> 			continue;

High: Could PCI_DISABLE remain excluded from this automatic sequence until
the module can detach the normal driver and restore the original device
state?

This path calls pci_release_regions() while that driver is still bound,
although the kernel API requires all region use to have ceased. No later
path requests those regions again. In addition, Linux 7.2
pci_disable_device() only disables bus mastering; it does not move
current_state to D3hot or D3cold. Consequently, an ordinary D0 target both
reports TFAIL and may be left without its driver's resource reservations.

> 	if (!devices_found)
> 		tst_brk(TCONF, "no PCI device found on the system");

Medium: Could the test separately track whether target_bus/target_devfn was
selected when -d is supplied?

If that BDF is absent or has no driver, its selection returns ENODEV, but
devices_found can still be nonzero because of other devices. The run then
passes after executing only safe cases, without reporting that none of the
requested destructive cases ran.

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
