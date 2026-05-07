Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE598CD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:58:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FDDF3E5F70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:58:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDB1E3E2C9F
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:58:06 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BB7A14002D1
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:58:06 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso756511eec.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155085; x=1778759885; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/lOjR8KcZflpG0+1dXLATN/26v9ZtlHwrMP0hGHYyg=;
 b=COnDDm8GVnmLGXaiGZlac8UuJuRDMg12fR2eLVrNw+2IdpHXFgFTDg/fAqy7GApoYi
 7V9gtxHNecOzzhA9A7IwxQaD9J+2K5wTj0GxgwAxK65NxB3yReWjZFdhTXTYDyKiT3w1
 NPhiEku2aZ9wAuhsslBE8fnSdaCSQdhn3uMjNq76EPqM5ncEixtRNCVCayORLG8kczu/
 ZvKIKkx4wBLDY6WZtmqlMim68pTYICKP7oEl2gMYeeveR8T9O6gTI48cRz0ZbNsjanWw
 Ty3HKUDwu2Ge2vHxnp2/ZrBpGwZ799RJ3HML1R+kw29aWzQKk4D+083ZCfRU7jMNxML+
 1IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155085; x=1778759885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m/lOjR8KcZflpG0+1dXLATN/26v9ZtlHwrMP0hGHYyg=;
 b=aD6YipBRFj8VccfLgOvzd0tUDqqf92aDaxCyy3PHUtnK+M42jf0WABv64OmQGN59um
 1KCznZrpiXjk8S/XAem7GQSfkLZloNdykSR8Sp1AYkf/5sL4Rq9l+/u0wtzlj/GxsUPY
 7kqjxMdf1hGU+aJyngwJGQcCxGodzYe9qTNph5s1IlcyCiWvowl8nzSNc2613TWx5daY
 o5XZPEDGUfAA1haLrSbE0+Y7a3nPFrO6470/pmMuLdvy3jY9Gf3f8cchB4A9S5AZJkG3
 uCms4NqWg4OIZ6k3q7snuwTSJrZlTU5Zel55bIIzx6bd3fDVWEP7B80qVFiDNj9gNxsH
 799w==
X-Gm-Message-State: AOJu0YxwLEfwWVnEEkpqqsO345o5tTjaEnOrBbGPjA0DWVD7W2HvuwZ3
 kX3OkU2MzR0W33f72xgQ9FIwwG3HrOz09NMt6RIxoo0wdjGa1r5p5CBv
X-Gm-Gg: AeBDiesS+uNbO9EBOCPqEH0/FCmSNwYEB44vzakx6Zfo40AOiuuG7ng+iLk3gRu+H6a
 O19wGN/Md6m91rgx90VJvmvmTozq9NRxkFYqipjrCiHV/gTiyyehbW+8XUA/S4lJc4BDmUliSSY
 gXkke2+GQ6lSpKQFfkKE+/M6F+8XLI0il0c8lxCftzD2cV/93Sv+hT2RaXXRxC4RVBcJ7yBCfgP
 S3HXrMh/eG0NrCKYUIN3EjMtVGCrQu/OGQ7lrXjLeXPjNkBU2aBlMDWW3CktjOQM96aTcxdAa1Z
 WQoCYInDCyvHBrMLUELheMrLGsQEmEdrckneAPXfxJ0N+L+VNkhURdFfw5tUvOicNOGphFME+fG
 6XF7ZpbJp87+482hSCgiGo5rRCu+GseOBoqE65VTtLPIF6ZdY69EjCUx6z879/Ppb0xim1W9dM1
 pUsntWtBwi4HcDch6cSoGMvrXWs9kjlUfOyj4nPTyOCafcVxxy3oPzlPMcd+/FjNelECl6TjpXC
 Od7lg0BZTPYjM50OflRpzUSAfHsH7gCdgMU9EszJtEWpmRZXNSPYyjGl/ZIcdmD
X-Received: by 2002:a05:693c:3015:b0:2ef:2878:7ade with SMTP id
 5a478bee46e88-2f548b9d579mr4180950eec.15.1778155084452; 
 Thu, 07 May 2026 04:58:04 -0700 (PDT)
Received: from
 runnervmeorf1.2sftis5shwvehknfm3w5ec0hue.phxx.internal.cloudapp.net
 ([172.182.226.73]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec592asm8274848eec.5.2026.05.07.04.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:58:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu,  7 May 2026 11:58:03 +0000
Message-ID: <20260507115803.4007-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507094643.47079-1-li.wang@linux.dev>
References: <20260507094643.47079-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima: rewrite ima_mmap auxiliary with TST_NO_DEFAULT_MAIN
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

Hi Li,

On 2026-05-07, Li Wang wrote:
> ima: rewrite ima_mmap auxiliary with TST_NO_DEFAULT_MAIN

> +#define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"

> +	tst_reinit();
> +	if (argc != 2)
> +		tst_brk(TBROK, "usage: ima_mmap <filename>");
> +
> +	fd = SAFE_OPEN(argv[1], O_CREAT | O_RDWR, S_IRWXU);
>  	file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  	SAFE_CLOSE(fd);
> +	/* Waiting until ima_violations.sh open and close file */
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +	SAFE_MUNMAP(file, MMAPSIZE);
>  	tst_res(TPASS, "test completed");

Correct pattern. Moving tst_reinit() before any framework use and
switching to TST_NO_DEFAULT_MAIN properly fixes the IPC corruption.
The checkpoint handshake inversion between the helper and the shell
script is consistent.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: (not available)

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
