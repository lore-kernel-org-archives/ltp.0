Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E62FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:34:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E193F3E210E
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:34:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 924CB3C1AAA
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:33:58 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 896DF1400C54
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 14:33:57 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8eae9229110so118565385a.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777466036; x=1778070836; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6TUCEl8O9VjO+BN1cb4mF+Aa24Yt539nqdsYDMTIQE=;
 b=pBx5kqCEo11aybYHUaxndxbD64xCgq2am09UdZquU0gOmTymPyNzmUdHW/9jXnXfjY
 0EUO6ExHt58qfsRBtmJ43BJbvmgBlY2EyPYe+ic+BpiD0mmSDAdL5AcHLxImWGvBBB2J
 h2APJbtB7RrEh0mDPoUAXg/IcsPaEP8z6L9Jl0e6+u5Nv/eyx3MDPlB0xvUrGVU61Och
 Jeqw/ss2iVlP5gJenrXdTt/c2n1Y5Y/CljmpUK8I6eB7w76yIBOZY04ze5fKyPDJ/4sq
 v1aZfZKbHrAPNe4XZw9UDhCeJ8lU+1QqySB6AzaadfhOyfdzKJSoP13YK6G3vbxJ64HH
 UaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777466036; x=1778070836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y6TUCEl8O9VjO+BN1cb4mF+Aa24Yt539nqdsYDMTIQE=;
 b=Na9geGOl90bSGgShB5i1wl55hfR6vlp7QJYRNgsZA94GeZxTKH1pPoS/jVcWLQWvaF
 mS2MP/XUnqBqHJovGIgyJoHBYK0jqb5TobqO8CZIJX9zI+bauIs6Q+j6fOXMY5soy4I+
 wqxfT8oiz2ngnTwxLngdPYeSInO5mTV8kU+nLK/NCpzZxZNfE/HIcVnrrRPsnlqsa6wt
 2oQ/AQ8Dvtj1Z0e8h/btjF0lw8IL558aDoZpXshiTkQ6Mvp4PZr4j/d/GDndd0F+cbA4
 q6nm5J9+wExhWfVqVbLS73/T0NCgRbUrJp2reTQT8RGpNPHl7HwTmDBEmKeB9IYBb3+w
 Trcg==
X-Gm-Message-State: AOJu0Yzzi2wH+2nJluxIa1GU7MvUGk97KH6aWfPkpwYDL3i+UxqHOChV
 Gh+OTHn1+SAw+ftUSeoE5HVW5ty4c6RtpKF8oCxz0NffmA81Mg5XnerH
X-Gm-Gg: AeBDieuyK5EkZ8ptMNI79UTEzlDcQlV3C7sb9ABcmilpoXF2HhBxeDF8waePVx7FvJV
 WIQbAIo1pIyX4dW/zBvrfOF4JYGEdDp07rBOtZNDa5E2oITo9+9HNFZmaDa9leaAKkARs8a0F7G
 EaH/GatydheZ9LGE8NZ1fMmYfyl1Ytlshga3HSx3y1DjI8fVluEvwVnQQetOmQ2fRiPHQhEsKf/
 6hgsrRdJsT8rdZ7yV4ZWN/VZ3lRd1EuyuaoarCwwi7Ddmzd2OFWl/h8d4SalP+JinJwNZoowMEa
 Dl5b2k2xQA7v/TE147yGX/7wXq4xMWZz19FnLiZXtOWGAC021lwbxws4rxkINnIjGqcYsIAJN0H
 EzZmaKX3qL0+0NRxAOGjm6HZSmLgFgZhA3NPujYOc1oB/4y9OWqZg48zlyNymRQkB6fh6javEjH
 MqHU7hSU7mrQbXkiYlOhqYL7foA+7XlItnEfAq2UaZcjRYQiCOcktwGVa6dyXZHDBm+vyNv1BxT
 DemDoGjPNSAVpO8cI9V/27WGA7RfrEL/0D8iEm4D87jpg1fgg==
X-Received: by 2002:ac8:5a03:0:b0:50e:5f71:62c3 with SMTP id
 d75a77b69052e-5100e1daae7mr99593611cf.42.1777466036259; 
 Wed, 29 Apr 2026 05:33:56 -0700 (PDT)
Received: from
 runnervmeorf1.zrqr2oex231ezjigm0txkepa0a.cx.internal.cloudapp.net
 ([20.161.28.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101ae3cf8fsm16112781cf.17.2026.04.29.05.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:33:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 29 Apr 2026 12:33:55 +0000
Message-ID: <20260429123355.4104-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429111823.1046-1-wegao@suse.com>
References: <20260429111823.1046-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

On Wed, 29 Apr 2026, Wei Gao wrote:
> shmctl03: Fix 32-bit compat mode failure by adjusting comparisons for compat mode truncation

> Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
> Signed-off-by: Wei Gao <wegao@suse.com>

This is a bugfix; please add a Fixes: tag pointing to the commit that
introduced the regression.

[...]

> +#define TST_ASSERT_SATURATED_INT   0x01
> +#define TST_ASSERT_BITWISE         0x04

0x02 is unused without explanation. Either renumber TST_ASSERT_BITWISE
to 0x02 or add a comment marking the gap as reserved.

[...]

> +	if (flags & TST_ASSERT_SATURATED_INT) {
> +		expected_val = (sys_val_64 > (unsigned long long)INT_MAX) ? (unsigned long)INT_MAX : (unsigned long)sys_val_64;

Line exceeds 80 columns. Split into an if/else block:

	if (sys_val_64 > (unsigned long long)INT_MAX)
		expected_val = (unsigned long)INT_MAX;
	else
		expected_val = (unsigned long)sys_val_64;

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=502039

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
