Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB5FF9EDFC
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 15:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A11113E5819
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 17:19:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE9E3C66CA
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 17:18:56 +0200 (CEST)
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com
 [IPv6:2607:f8b0:4864:20::1141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93E5910000EB
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 17:18:55 +0200 (CEST)
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-793fdbb8d3aso58216137b3.3
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776871134; x=1777475934; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyUsV6uSzqOtrioqeWDTa7QbABg/QdZSz//zqMv0snE=;
 b=VU5k1pE91R8awANSLQc1Ri3VWlAuNVkA9luznr/oa1ciAZ8W2rZ5XuUTel8Jif8ThZ
 0ZGPJ3I8/IGkPyW3kkQfl2KMXVODaYHBb3bPlv4UgGu9W0VSAWGl857FIFZBZbCgFyUC
 ezUI3CiqBMjldZFy7wWN6Y9PyU9hL25jOF8qKm6tqZmq+whXrJA7Rg7BXI4THt2EZsQC
 jTjAaG9TRuXVO4+Awm30Yzkbmqz4G0Go3YOBfh9+VOf0XEonlOc7DFpxZ6Fgyeqiz/wD
 b7onMwdnMhNHbTxZuIIjZpQbjfpWHkXufXuy1uzNB0g7yNXw8aJ+iF/VOh0dKibq4KhZ
 C90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776871134; x=1777475934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dyUsV6uSzqOtrioqeWDTa7QbABg/QdZSz//zqMv0snE=;
 b=V8flCq1cr9VIsTUc7IIe/1pFJoUQ3DrKXhG1b0KpA/miE58aLrJEQ1iUk4Rd1SlfYD
 def7WUUIK4ynfB6SPtmzdOnhQxCkUm2LMItyVHJs4LhhuQ9xRCpLlhfITYNVyDIXSRyh
 PPz55o0lrriOCVtPKpjDeR2qfCfTQSj/SaZbLtLE0DBgWmZGPrFTYMmWcuHSi6ichrkh
 gUCi2eSrHQTEEUv7yn952utC86HizbmZRsCit5rvgfzBzXQZRrJ0AUd4oUNl6kpSrKgR
 9t4FEo2L1rD4jrMfVY2BgP9QxXUb7otDDD8bsOIVdLUqgkewNI4egHEJllFEe/COjTZo
 T38A==
X-Gm-Message-State: AOJu0YzUSWXDni3dNbKA/llGyUzunvi/op/1OqiBTm0edSloo+rX/yr7
 NWa1PJkpcIxeTl+4lzTp7wSaqY9cijaVGzvsN/fiqV3AUq93yusb9NtC
X-Gm-Gg: AeBDievHCpj3gFxX5DkUJAc4IA+3igXgtr8jYWNUkGFDMYzX2ec+VdKiQRnDVYlIMrt
 i92ONToILLezASkluD+5gY8NKRV4n0vT+G7s96Vm+E5lS8atMYjdOZ01RAxcABvz1I7IRl3+FDw
 BvFEquyblGEe3Ete8n2H//+LRseaSeYhl8YXeTWZR2lTL2mNOVMdYLmw1iJIyepN1BrBb8MQEfK
 oDYHsF8KZQdnOsiw8WF/JWKZ9VgY8T/zIrh+Njco/7QoDVuGLaUJFULsd3/41tuXfc15NTapSoE
 wuUS3XKwm3GRKmG75hP0oTZRV50ttktaWrzoDcM5dg75B8IKEptsy8m00dpy/XbfUSR+RS9rmWM
 4IukVuOifagKvhoConnMYlA2CY4ImDOCCuXbI4gX7XY+5mhYf9REp8Ya8+L4PiQxAbQxtOSa4fT
 +ngEWJaPTn7frKycMtkoJ1jR/jY64B8PWDK4tqscw43VIzp4a0MQLTx8KXineoJf5YdXXIYRZLg
 xntoruxHmtGi1/k+bk7Mrg0DJGsjVMPoToUKD9eZE1jkGBByvMNfHvWsuDyng==
X-Received: by 2002:a05:690c:e3cb:b0:7b2:9347:7be1 with SMTP id
 00721157ae682-7b9ecf86543mr239444317b3.29.1776871134288; 
 Wed, 22 Apr 2026 08:18:54 -0700 (PDT)
Received: from
 runnervm04xxt.ufidxgkzfoxuhpw0hs3jtcphyb.cx.internal.cloudapp.net
 ([135.119.239.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee9b1c4dsm69911247b3.33.2026.04.22.08.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 08:18:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Apr 2026 15:18:52 +0000
Message-ID: <20260422151852.3943-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422141234.632195-2-pvorel@suse.cz>
References: <20260422141234.632195-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Ignore empty LTP_ENABLE_DEBUG
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

Hi Petr,

--- [PATCH 5/5] ---

On Wed, 22 Apr 2026 16:12:34 +0200, Petr Vorel wrote:
> lib: Merge functionality of LTP_QUIET into LTP_REPRODUCIBLE_OUTPUT

> +	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TWARN, TINFO, and TDEBUG messages and");
> +	fprintf(stderr, "                         discards the actual content of all other messages");

Both lines are missing a trailing '\n'; the next help entry will run
onto the same line in the output.

> +		if (reproducible_output)
> +			return;
> +		res = "TCONF";
[...]
> +		if (reproducible_output)
> +			return;
> +		res = "TINFO";
[...]
> +		if (reproducible_output)
> +			return;
> +		res = "TDEBUG";

The help text claims TWARN is also suppressed, but there is no
corresponding guard for case TWARN in print_result(). Either add
the guard or remove TWARN from the help string.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=501017

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
