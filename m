Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8C4F8FA90
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E62E03E53C8
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:17:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609AA3C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:17:01 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC96C2000D0
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:17:00 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12713e56abdso2892872c88.1
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784619; x=1777389419; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqsyKWiiWWgDCVno6Y10EgPCBGDHfcoDbnhDlpkXb+8=;
 b=r/iGPsDD1f9D5EedMuW9YQSuMBtOme+JgFSSTR+7yqtfmZWgYID23eeUPJvHy4j1TR
 ZwM9KwC0Mxfzyqu/8HcwqG5dDE+/qwUN4EpuRDLm9nIbDuAPufHR35PSCFTBFNPhjab9
 JE3ghtsJeDDg2S7EHSZdX2Wl6RWHL9jFHnIndrF+Dx6ZOeeqtUMIKmz+eZUHD/U4cZen
 FkJ9Zw4ISidHDkJYni4SUmkyW0CazRtmOZyyWi6EVa2LW9GPOAd/yHaoTOkULaZSVQfk
 5Rvc+IKp7l4jfXvSQ6MNaRbX3O6UdgA2KL8G8LS+uPBfeGnP6GZAHxOlmLR3Tm8a9QLP
 df5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784619; x=1777389419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqsyKWiiWWgDCVno6Y10EgPCBGDHfcoDbnhDlpkXb+8=;
 b=dg3pmwHnMcnCssMN1JBiutaiYdcDbSfqxugGo/riVdmSUB2F5Hh0FOyKM0pvrx0Ywk
 9ZRndesPY3veTXt23NaFg91Qx9KK98BgK6ufIJlYbwZzISoM4TaTBUEJUcV1A/3kL0bA
 rIykOpbZ3BRPn1afbGSpMat5IUmyaV1+3CtKR47p9DIDFwj6qT9h3gDTBlU3o+6blbzv
 pdMb/FqTI908QyyvvuPE+ujrZFnAJiVMeKw4ScKyM0e76DzMCVDp/Gg2PqcKDKtLdVSv
 X5mkeZGcGXuluhFh5Y47LJb2Dz/sG+6nQ4iYc89fxkfsrfM7M25aqYkcYh3ZdgV9snTD
 t+/g==
X-Gm-Message-State: AOJu0YykNZiRaRT8XZvR9ORtanB4VsorAJdO+8NUXbob2xpAeS6C/vgM
 Mu/xgqn8xmqI8anMf7F1RHYlQMM5fxNZ/CcIhrN7duzNcSYPA86RvaN7
X-Gm-Gg: AeBDies1KpexJiCvSP6DwibwSyeVxO4hN9XGVamzxVgacNHDRGiJvOTfY4d9gSjgET1
 omHuBcIBH6B9YKghvd339KoDqZcIbqOMKDnGsNLy4JqoFMa8Cm64fQL69b8v3zdXGXhaWqcHp/2
 6Xo8IXRLwb+oVabhk8YY8mBawzJPgeokgyqbXF4XbZEfzhFoErAreG/SFUkNxLFEqhPW7yTXIQX
 2ogQH/iJtirISbXJAv22JUMAk6ufOySb/SWdwZWxXxihVc9ifJ9ZdvPz2/BNlZkO/aaxwEHIAq5
 Glb9Gb1TJuPAKgQve4mpoRkv5nvhaxX9IxXWYlzpOsww6PL7sf52hobrKTFDM1bKdajBUz40box
 0JmbuI2izVDIqGflsg6vyeaekOCZJ/ADavp3SzqWTdrans4lCAxzp98/l7xecU1YBOrwlsmr/Dy
 hnDCQnsjmEyH8mF+cocXgMcBSUX/gQKeOoAQmMRZV2Kz9WlsOmDzg9I3dLEEcC8PtcvoJmwYLel
 dVodBDKyTviX4YJJc38yobaRTzRQfChEdqo/NgLXCiwgNCUjKw=
X-Received: by 2002:a05:7022:388e:b0:12c:9037:5115 with SMTP id
 a92af1059eb24-12c9037539amr3228076c88.13.1776784618776; 
 Tue, 21 Apr 2026 08:16:58 -0700 (PDT)
Received: from
 runnervmeorf1.sx5he3nppg1erlzumq214gj2qb.dx.internal.cloudapp.net
 ([52.159.229.147]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12db8684f90sm203695c88.13.2026.04.21.08.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:16:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue, 21 Apr 2026 15:16:56 +0000
Message-ID: <20260421151656.4042-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421144246.2046-1-always.starving0@gmail.com>
References: <20260421144246.2046-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

On Tue, 21 Apr 2026, Jinseok Kim wrote:
> close02: add test for double close EBADF

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24730323743

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
