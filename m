Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227FC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:30:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D85A3E5DD1
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:30:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B023E2017
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:30:27 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD1BD1A0079B
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:30:26 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-9371529ed6cso37876285a.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787916625; x=1788521425; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lY6Csf5iFZSeyajX3zfEcUca7gLwvdwuGpc3tnRY3BA=;
 b=AEBofbNrkrWrkifmChkqkbwZ2mKSejpe8JupAtRVKkjQuLOm4/78Xzswn0lTWmMiAx
 VTudgbPrbggYdYM1KDCJSkJpOIPQsU2XnsnWiMVaedBEdiSOgweDeIy4YyGNeIsS+qKO
 EbZveL8U+nf4nfdACMo3GTrz6vXzw1ESHLGTPzc2d9/ai0gIxfrFFQVi5GlIe6W9kxyR
 OFfxdMTbq/u5Bamzi/w7UzSlR6uZZQeABTkFN9tRLWTr7j7IatbFtFpSGP7X5oZy01Wh
 WmCBtLomawlpGn9RatBzPIIrd1+J5ztCpKxpHx92n+TKHUGOt5/0BcF9q0yxjGzHDcGc
 m/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916625; x=1788521425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lY6Csf5iFZSeyajX3zfEcUca7gLwvdwuGpc3tnRY3BA=;
 b=bOmxkaBwncJnoxJ4jAg/re7YkV2aYdo6g2hyG6Mjo49jdGicITO/XbP2rJuej86AXt
 Eskmpts0iKK8b58n6Avd24yiHu3VGV9BH58NyPaZrKlqgOQwNmVpWFs9dIlTpkMV7FOU
 rYeqTF9ggt9D1rgaKXnmZBYRGVkTZ//D18HcGiGv/yGVXFekGIRw6/047vJtvXpLJ+SA
 NHnqTxFmKyv/mM1WsJDD4omA94kUaH6rvSOpOHHRzg0V6SZZncyQzamkYOOojl4QnaVl
 h8ZOwYsTXy42HXcp+PEzX09OT189YjGTCkGw1w919+fKMn7ES6D2EyZQw7kmKR0WOEIv
 jSYQ==
X-Gm-Message-State: AFuF++kQCM0M8x/RlJ0Wxp9upblI4q5zYSBQ1d9V48MYMnUiK18fKwAX
 r6US8VEhPRY1iheB61/vWldBNpbamW93xlBOvoRFa40TowlK/cv9zw/0
X-Gm-Gg: AR+sD1219dMIS2Rsmc0NsYvxnA6dN4BnbW7QQgGulP9Co8e6dZcLy/GBDLUX1Oz9lCj
 F1W12uPVjIRMmd2faGVgmezvxwlEEjsz4RRvRTsZ7oNtXz61WDrGt82wByHehmnf+V/EFYA81qx
 hNajay0kgX3qazN5Ahr5IHjHvSi/Wp7edZ1KiD2IRZ/7mALM+M10G/H7ICRP04BqySyIbIa31xt
 J6qhYpMoKGALGj8iok+ieFxvioUvFoP+Qse+lC4dQMe18+60UNixenXg2MKeU406gXkE8Nrdvth
 xZgQR+9CiwScIJnASP7TZjXHJYzCncAbZCRIn33lGkbL9UEWxLPCPWMA421Na1Q0bANv6pwyz3s
 kQ9zYNn4AJ4wU7mO6larmEUch2cxNCsvfF828/QKdIIuI1geplxi98RHFDJLRXx+/7mYRODnj0r
 D4vLDQspoSoV7keeAp2WBy6I6GiAV0E0X7gtfVHJtKtH54wdbWJsyZZvx8MvxVCprPOI/Wn9R4h
 4+wJ5y6RcLzJq6yP9poqTyhjGrnDN5tCf/GAkltWyfd5gRNaItUpanUKbSdfqhTM9Ebga+tjndV
X-Received: by 2002:ae9:c207:0:b0:933:aa0:bb83 with SMTP id
 af79cd13be357-939138d3141mr453463485a.34.1787916625281; 
 Fri, 28 Aug 2026 04:30:25 -0700 (PDT)
Received: from
 runnervmgx7h7.w41skhc0wtbelfhr5so31abmxd.cx.internal.cloudapp.net
 ([20.55.213.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939170138eesm123873185a.3.2026.08.28.04.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:30:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 11:30:24 +0000
Message-ID: <20260828113024.9090-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828-swapon_discard_coverage-v3-1-136924a1a730@suse.com>
References: <20260828-swapon_discard_coverage-v3-1-136924a1a730@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tse_swap: Add fallback definitions for swapon
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

On August 28, 2026, Andrea Cervesato wrote:
> tse_swap: Add fallback definitions for swapon

--- [PATCH 2/3] ---

> +	if (tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_brk(TBROK | TTERRNO, "swapoff(%s) failed", loop_dev);
> [...]
> +	if (swap_active && tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", loop_dev);

Could these reports use TERRNO instead? These calls bypass TEST(), so
TTERRNO reads the TST_ERR left by the earlier successful swapon() call.
That value is normally zero, causing a real swapoff() failure to be
reported as "Success".

> +/*\
> + * Check that :manpage:`swapon(2)` discard flags control swapon-time area discard:
> [...]
> +	.needs_root = 1,

Could the description state why root is required? Root-only tests are
expected to document the reason; here swapon(), swapoff(), and loop-device
setup require it.

--- [PATCH 3/3] ---

> +	if (TST_RET == 0 && tst_syscall(__NR_swapoff, tc->path) != 0)
> +		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", tc->path);

Could this use TERRNO as well? On this recovery path the preceding
TST_EXP_FAIL() captured a successful swapon(), leaving TST_ERR equal to
zero, so TTERRNO cannot report the swapoff() failure's errno.

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
