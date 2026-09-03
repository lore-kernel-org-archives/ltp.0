Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3C3C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:02:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99CCE3EA7F2
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:02:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F6F3D86E3
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:02:07 +0200 (CEST)
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B50C10005E4
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:02:07 +0200 (CEST)
Received: by mail-oo2-x07.google.com with SMTP id
 006d021491bc7-6b1bebb3ae8so602837eaf.1
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788436926; x=1789041726; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lFfVz7j/r5kFfMy2fM2NCgS5CGJbfJ4fY7JwSVdpVLA=;
 b=eLgZSB32YV6U6HDwW1QkwFhf1nGiX+HacdIorJipaaiZ8cJJb0+gMA7tOCC2A+G/SL
 ejjPky/BtqdsiMmR+5wL3lhiZjkCVfXu4EschhnlCs+wSl278SBlHJK5knt9Vvot8ULj
 tAm/b+bktBY5LXhwMe8gczL8S9FEDEobOn3lXzz10QDd3sNeqXyJ4NVxv8x2lzJFsWMo
 /VU6yhtBwte77uM8cXcsAR32lJ/l6SZBv+ksGvQewQMokqIIrW+Z+AuR8ObXDiAGKANv
 oogOB2JgSjf9QYO2WtIt+i86h/NpgMW/MbuxWDpnTF3NBuGEZr6qLrPW+btEWDzQKhUa
 AtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788436926; x=1789041726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lFfVz7j/r5kFfMy2fM2NCgS5CGJbfJ4fY7JwSVdpVLA=;
 b=gfSEBNr9OLUAxfmVsXNsRJQKH4g+YmhXCaufTZEYkwIVkgxOG8/LH2Ud9Pcf3GPKL6
 uTX/9ojfuzC3eIiDLd6YcDFJr4UjTDyNmc1AnZwJy0b6ye60VxTeVNvjQ+DUR/o95no/
 ThOwZSy6u45Anq/zHmHJQnc3C34XaRebitUOzewRTvdTkYHRxmph7nuWw889aJSb2wmH
 WQU2M0fWFyg0BlHi0Tl07gW5F2cT0Q3CSi/u6BQA+t55FX9pVyK2hdteMEy10EHgfSbV
 /SaVYv1BTKjXGxcXic2uJ1PdshbhnQCeJ7khNmZ/gSU1/hsiwpTdDz3+fEwpOiHjLCDv
 f9cg==
X-Gm-Message-State: AFuF++kEKJuN6evwK1UQh1Wy/zrJe+wSAx1iuP6Qb8uylY5xVBRFcdPL
 vQYJfAa5ipk9Ua9rM7Nz708wbGjdZlA+s0sEJn9MORSszrvnLx8KE/W/qSeCxHNjmpI=
X-Gm-Gg: AYBFou2EQLKM7IFZL5XXvkWXtaBQJmMBYgbQo38mdI9KnsJmXB1KWIcyCcsiLpE8P4X
 S9WaRCYWByuYC+AM+I60FbrMj7noHwYH7bs9nESbLdePGBDtCgCujQ89uVrODTTUNn8ExW7Rokr
 a0+4K/3jA6pqSL4t70e16ezJogU4f02Pn3fTPikIqPtWPt1++tamHBUG6m/olvKhRfUBFCyhPdH
 pdiMwbgFvg1u6Xt6r950entU5pMY8k9G8Y7iyM+NH8zJXnEbeMXRq5Es6ph0S1bL2tPCvNQ4O0B
 laTQiLrui70we/xpTziabeBdtJLp1tlulkTu85QURY0mWMU7I+3Lj+Pe7V+7FBeekbYQNluS+fb
 b3FIILyb5puniryb2UhBxmECjpMeVh4AeK71WoHroDCQeymkX/vZuMLzCqAL2Fe/vM5fYbm6CC5
 qEHysd0x+1OLe3U3L2xh4PusJOVtDKeSmAiwJj/Ka7CBfPgP/+Ik8oxMP98hMLIqh05hu/q3kVv
 7cay4teaoZeUI9Zhzf3dNvY9+S+CfLtmy4dljCDSuF93LT4ppWLymLePqiUG296wXZWafcSLVza
X-Received: by 2002:a05:6820:1524:b0:6b3:5741:591f with SMTP id
 006d021491bc7-6b481740de9mr8741885eaf.26.1788436925707; 
 Thu, 03 Sep 2026 05:02:05 -0700 (PDT)
Received: from
 runnervmgx7h7.ormaw2ex2ksuvj5jfkmmwsns5e.ex.internal.cloudapp.net
 ([172.183.89.66]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f336c72f2sm6484666fac.18.2026.09.03.05.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:02:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  3 Sep 2026 12:02:03 +0000
Message-ID: <20260903120203.8665-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903-cve-ghostlock-v6-1-a3272bb81e4d@suse.com>
References: <20260903-cve-ghostlock-v6-1-a3272bb81e4d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/sched: add SAFE_SCHED_SETATTR()
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

On Sep 3, 2026, Andrea Cervesato wrote:
> lapi/sched: add SAFE_SCHED_SETATTR()

--- [PATCH 1/3] ---

> + * SAFE_SCHED_SETATTR() - Safe wrapper for sched_setattr().

linuxdoc requires macro names without the function suffix. Use
`SAFE_SCHED_SETATTR - Safe wrapper for sched_setattr().`

--- [PATCH 2/3] ---

> +struct prctl_mm_map {

This new public structure needs a kernel-doc comment with a
`struct prctl_mm_map` summary and entries for its members.

--- [PATCH 3/3] ---

> +	futex_lock_pi(&f_pi_chain);
> +
> +	TST_CHECKPOINT_WAKE(CP_CHAIN_HELD);

FUTEX_LOCK_PI can return ENOSYS at runtime, after which this checkpoint
incorrectly announces that the lock is held. Check all lock and unlock
calls, report ENOSYS as TCONF, and abort on other unexpected errors.

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
