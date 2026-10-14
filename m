Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC518CC6B27
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EC703E6A21
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:39:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0CE23E2B2A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:38:51 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 40BD6600667
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:38:51 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824413e10dcso227549a34.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791967130; x=1792571930; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/7N3FP2xvNZXgUaW5SMGIHvXvfsM5veU0r4QSJIAWU=;
 b=EDAZzHbcOMEEWvxOpWkAoxUvKAEm3q4vKNXV9SM32sv0rqo89IdlbevmpNeq3/MxqQ
 kCXCp4IJLrJxvnOssgnC8Sd4NwfRXjySjS0FYHc45QVZnGVx+Uugb1a9ElayDcUVXqlK
 DHU9RyNuisLJWBnFAZ4Pdh8O3BtN5KvfmjprhbE93AIN0y42K0LUBZUbpeFEAxnSKuMg
 i0NpHci0sh8gTMIdkUhiftoufdPr7yLU2Qvs7znqZQZFu0rCrIJ6Qo8btu4Wi0Pl31jo
 3tW0Ynu8hRrYGzaZRXukdG61AP2M+UwWPuOC81He4yv/aoSQwasaadprATug/7yHjO5J
 ghnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791967130; x=1792571930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/7N3FP2xvNZXgUaW5SMGIHvXvfsM5veU0r4QSJIAWU=;
 b=V6rxBtW7FBEEibocfiWX3GsyTd6r98xctjnqyP4iGysQX5RYm/SbrRXXitZEqEnjzE
 jDQDAlQDMTPO4VUSg6trcsHTJiVW6R08yO0dM8Ex+M+W4a2zj18OnW4FzNy6io1qZtas
 aU/JbMAAIlFMtfW+PpRMJvP0S7TgqQa+OYkWwL5p38t1jI9P8+l3K0iVcN+aFQhYiA+q
 jmqAKefcMN94Uw4fwvg/X1kuTirY4vbyUjog7yjDGGw8dx0C7OCUk29TP/yN9RfrEJLp
 wKM2/iiPxAhiA1s+ipcokuWF75pHV9vYxX4V4z3cTRkRmgrGrr5QBtBQm8Kzv6hehs8i
 9MdA==
X-Gm-Message-State: AFq9FYJkqAdItJeekzn9egdITezaFi0emnQpRamThoMdee7VAKSi0YvB
 P1y0HujCzNvSVAgNu4qGbViYkRQGV2ZCGIfP8uPrSHw0Prkulu88drGTwJSFJ8a+qa8=
X-Gm-Gg: AYBFou0uPXDAHCEGdvL2T+KANkFFSAhxHwq0ZaMnz2pllbFslg85iV5o3jZlsdHaTxH
 RWFq0ZTuyO7Ax902KPcykWjaBAdr8v6js2UIX0QlLD8RXLoAONOkbmOju/HczFgTnQ1C2ZgNgRq
 jQFMc6wB3hiy4Mhr7fqm5AYnyZhlfBqtfOmThAJ23fwuFdfsByXKtc77ZoPspPIQqOVbGRlkbEp
 +XNHXEK3neXq5GvrY1G+a+izzLdIXofJmrYk6Gknmrdlwm7tpSZG55DwkxIPO5XL9yI8fXUtRzL
 FRHi1pCld9rwks1AZaeF/zi0x280a2gVyx9JR7+vJc2/0EdoPK4J6UZ6FnpvsyEgT2P33obqfjR
 gd91kBDX6bS5Cs2Nxg9ADVcUZKrPq8IyCRzO3bQ2paVLy3TS7JkXzgLFDlkjATri7Hkte/yLzRU
 K8Oic2dYBiDgjUF6Wrgm3XuFuvKpwBo30foJJ0ODrbXPPZpLdFIppxXIgi/4sMjHq1XeZdFt3E5
 3hHsWGb5rPWwLHe5CEOw9V3xCzovvDkM8tv6oscOsb5ZiTBbikxZkYnJGl57pFzsQOTZBsO3rbT
 IVpKhnavn3t8iA==
X-Received: by 2002:a05:7023:a4d:20b0:14e:906f:9c8e with SMTP id
 a92af1059eb24-16a5ed3df0emr20479919c88.20.1791963406454; 
 Wed, 14 Oct 2026 00:36:46 -0700 (PDT)
Received: from
 runnervmmprz5.dkyqhxnpkjpuzcbyzhxqvbs2ad.phxx.internal.cloudapp.net
 ([20.168.125.106]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a620bdafsm58385039c88.23.2026.10.14.00.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:36:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Florian Schmaus <florian.schmaus@codasip.com>
Date: Wed, 14 Oct 2026 07:36:44 +0000
Message-ID: <20261014073645.8997-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014071734.450957-1-florian.schmaus@codasip.com>
References: <20261014071734.450957-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Subject: Re: [LTP] keyctl05: Use DNS_LOOKUP_GOOD to avoid false-negatives
 due to EKEYEXPIRED
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

Hi Florian,

On 14 Oct 2026, Florian Schmaus via ltp wrote:
> keyctl05: Use DNS_LOOKUP_GOOD to avoid false-negatives due to EKEYEXPIRED

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
