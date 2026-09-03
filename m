Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA4C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:01:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ED543EB094
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 18:01:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C053B3E18A9
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:01:41 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B49A140025C
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:01:41 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-398da2bdcb9so968273a91.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451300; x=1789056100; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gdr2BVZnt+SaDC00XQNwcJ2X+e4aQUYppfUgf9WaVg4=;
 b=ORnhX9bWpwYpvJ3XNGsiZ0UEBzdH5IlLIdEDJ6Cq2VjfI3kJRqNWem4AYniru8gYjd
 +vDY2X8FbM7asdKxOIs1ApDreFpL9K+0yCbVuUGFbX/2Zyk8ZVsxHTYutyqCNlRnoEvS
 g9b8s006NeDIRUS4rrVtDoJ5zpncFCPrDUduzTXRrP3+DG/vHNDZIn3jUgxx4V2Wu8VE
 3XDofInOm0ufJRWO5s2dY1Nn+IkQO7MvsY+9tiEJTkOR92iJXE2/eXGiiIMCVe2XyrZK
 tlqBXJRwNIu9BkAI/sRlT6AAqxFoqpFPOQ6ueOOLZUk5cObLBdWVOKTa3C/SYguro4HP
 E6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451300; x=1789056100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gdr2BVZnt+SaDC00XQNwcJ2X+e4aQUYppfUgf9WaVg4=;
 b=ivDY9/ucCcnWxSed725P10S7Ob+RjeoOp+45/SVsPerdsm27Rf/TQjLgiBdC2kgwu9
 qAwE7vzdRGAlLYhlg2k/sD7DYProq6TVMWh9EtoOuIEcWd62dE0GspOab0wFqYVrVc69
 RKBI43fYNROnEiIJkqRDp8F1sBmUV3mH9bfWgRWIc2PN03Po6qoayTqmGQFZriut+w/H
 ZulZYnnfpGi2RmbKdOV0RP7Ag3Yp1GSf58IEZBe+llELJ599iia452QkpzQVDPYZhYjG
 AwZb37dFolCdOKhTr78JvukgAdKjPvP1GrhubdiM1p9oZlzVG+9BANqZSLqKx9FhoRZU
 5ERQ==
X-Gm-Message-State: AFuF++mEKg7uiMqAIphbO09Itrq/FzpQjvw4ZxfvOlK3md2rIjd+7vN5
 yWws3kJzBnkmOiCrEem6YMlLSfPMxT0tAfCJRgsyTryDPeeTZOiSxNvRgIqwqKY/
X-Gm-Gg: AYBFou1Nd1ymKaMGRvj/5NoES6HfD2ptDGkT/qQLBOPMJwo9zBwfFS+74VcmbzG77Lg
 Dj+9uqBcViLRxpBS8XIHgqBRAEEgXonW4tShIy6H3p4B1HsLYGkExU/I7IQ711/leIsDFL8+wC8
 Bl0758vd7ufLz0IKKsstKT1DmrWlOTBptWdUAp/vsZF0g3UUhCq75v7aMrr/XX2plq51x9gxAvI
 quwVVuNVeEJOb1FyLajmTjqm1X/J7RIwGNB+0lBGDntRvSZ/cR1Rfqz3mtV7TFgJHTvqmvj4k5d
 EzT0wkF0HnxFHff6AIMUd8+w6VJnoMaWFWICytWUDqsR6CP+Mqj86+AJNK7TR9ppao1ijleZmle
 0Hs7PSjlvk7JQ6j1AmrnKsAh/LR+c/mZu1AkB6mSen/KvApZigB0kPWVdtzII4kyisfzMQFWjxv
 drasq0MaxEoRScLPByXd3CVHJ1eHD2fm/DOzWqsqa42O87/THubJySxLpNtJQ5ocG2lLrNSAdgW
 XYr4BBezPMYuGRcfkV+oy551YCVTPXfZG+WxtVTIDrvCSGXVyl4Hmz0h/A2ZSGOWXloAobSizoG
 lY8/1OPgMT4t
X-Received: by 2002:a17:90a:d604:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39aee16a169mr20867777a91.24.1788451299487; 
 Thu, 03 Sep 2026 09:01:39 -0700 (PDT)
Received: from
 runnervmejwal.olavzxkizpmejmmuser3fvrntb.dx.internal.cloudapp.net
 ([172.184.211.74]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc43d2448a1sm1168335a12.4.2026.09.03.09.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 09:01:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  3 Sep 2026 16:01:37 +0000
Message-ID: <20260903160137.8963-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903-swapon_discard_coverage-v4-1-2a9f721ad954@suse.com>
References: <20260903-swapon_discard_coverage-v4-1-2a9f721ad954@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Thu, Sep 3, 2026, Andrea Cervesato wrote:
> [PATCH 1/3] tse_swap: Add fallback definitions for swapon

--- [PATCH 2/3] ---

> static struct tst_test test = {
> 	.needs_root = 1,
> 	.mount_device = 1,

SWAP_FLAG_DISCARD_ONCE and SWAP_FLAG_DISCARD_PAGES were added in Linux
3.11. Add `.min_kver = "3.11"`; older kernels reject these bits and the
test reports TFAIL instead of TCONF.

--- [PATCH 3/3] ---

> 	{
> 		.err_desc = "Invalid swapflags (undefined flag bits)",
> 		.exp_errno = EINVAL,
> 		.path = SWAP_FILE,
> 		.flags = 0x80000,
> 	},

Invalid swap flags started returning EINVAL in Linux 3.4. Add
`.min_kver = "3.4"` so the test skips older kernels, which may accept the
flags and produce spurious failures.

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
