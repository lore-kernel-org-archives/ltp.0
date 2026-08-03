Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F525C5518E
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:37:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049673E7191
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:37:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF06C3E0E1D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:36:57 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 518D160062C
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:36:57 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51c26eb5e81so9198991cf.1
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785749816; x=1786354616; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hozlzYIlXf/CH0iQ8lgg5cq098/H/haFJ3d8DC3t/pU=;
 b=S+T5bIro9/uVZsBeZNJ3BBegbUSItqevaW+MfxE5BAeORxWXse1gEYFBQq5ncXkFJ7
 wWXGqBCd6B1HC9ovCVo+ctNmdkLUCTQ8QfM9jDKCTJGgpeRQeAhvvgLgY9TsA4QkTjVz
 +NvMVD3LnTBCCGoH5RooVYq+Fr246hm0NxHgw/Afcsr9MplEe4t/TY6xZTzvD9S0u9pj
 L5amaf447UpaiuDU8lSrfL+XGXD01nHGBnQlVo71O6fXw7LHAysANxVs1GJtrYd7ek9z
 i5Nulhz0ByATz0Xl+foT+TdISMLohee+uP1x5US4S8lp5gncMRrAXSbvBAouJ7HbJdbt
 QDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749816; x=1786354616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hozlzYIlXf/CH0iQ8lgg5cq098/H/haFJ3d8DC3t/pU=;
 b=ePo7XMmhrgk+ZXPaxB/uDzOQ9WWmXrCInUUvR41g6FNlWYrJCMvZMhVKHsmwXHm6S0
 BS9BjEE1EDjlhvkwNk4Ewx5VDm5lvP7vUXSh3yIE1Tr25qbs+N2Nitkhmwf7HjAT2VcL
 ODlBIDP80kefmhPuqShRM5CNuRZjpnB8Zwx78yyrAKKyWeoBEbr0nWrCDmpTEuoMm0xU
 FoCrT6DrrPgdvXYvPmq1PRMaY03JZw1jLD/FC7Gi/UcL3//wRYQKXGpH94b39SrX6V01
 ks8WP4GOJL6Qv7ViSmHgguCHB/kHP1Br70KGXSgCkPgUmuJnYuPv8AZZGt9P4/svKNwO
 IrVg==
X-Gm-Message-State: AOJu0YxKFuLOq3QfvsmAaVBzPmjN3TQvKRf3ToN7v7Xek9qBBIzW6D+c
 swLsMB4oG7F3EPWx5HTTCqh9oHxgwIe6zBH0F5gir6ifnjkwfpIAyadd
X-Gm-Gg: AR+sD10TYo7gpZVMHxkanjlUpvP93ed2wo2qzYKBThs1nNTL+buCHA/OQSucdopC0sq
 NFnlw+GcnABtqUHSZdhWpThQoTYCB7cwpa/TAfRm5TB4E9h8Q+2XLuZ/SqarjDpB7yVzCbGXprz
 Qj4ZyfqzFydc9mIwXewaQF2C1sGckbDyAVuTY5+mWbJdnpPpUtlFe+Fm0hMFYLBw84ES7x4RfSr
 FVe6enGoXsCJT9I7sxo1UdnqXARfffhGPwnEq3D29EDvqu/5YzjiLAUU+Nsap0gUCE3YhPX3LL7
 noLiaQf/WSk/FfT2vZS0GSW91wlJFz619spZt78cdyk/Y3JwTB+xYtXtGIatd45eiVmKQ4neKuM
 LVrS1+z4miWn+hP2wDU/gz9dovdGjuEcyQqF+YcYmPQXYSZfwmiECmNe87osvdvRt6S0uyU35Mk
 cYPegQXb8snX3XBzMCi6K4L2cVKBaUnuoYMRvZw64qSob/q5Q4caCtOl64fLhdsODv5rnOKU2kc
 CtvdQ5izgtTw4WxgqTUrpIV0crIMkxRuVunIMpc+x4kVW8mkjuUJb2q4F+DjBbHCOtN3/rjDWcE
X-Received: by 2002:a05:622a:588c:b0:517:7d9a:a88 with SMTP id
 d75a77b69052e-52b56796734mr183681561cf.37.1785749815906; 
 Mon, 03 Aug 2026 02:36:55 -0700 (PDT)
Received: from
 runnervmvrwv9.pqtex04ndr1ebezct4p0ipab4d.bx.internal.cloudapp.net
 ([20.106.231.42]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908432a1e44sm70829906d6.2.2026.08.03.02.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:36:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  3 Aug 2026 09:36:54 +0000
Message-ID: <20260803093654.9064-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803-cve-ghostlock-v2-1-b60588853140@suse.com>
References: <20260803-cve-ghostlock-v2-1-b60588853140@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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

On Mon, 3 Aug 2026, Andrea Cervesato wrote:
> lapi/prctl: add more fallback definitions

--- [PATCH 1/2] ---

> +#ifndef PR_SET_MM_MAP_SIZE
> +# define PR_SET_MM_MAP_SIZE	15
> +#endif
> +
> +#if !defined(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP_SIZE)

Could this declaration be gated only on HAVE_STRUCT_PRCTL_MM_MAP?
PR_SET_MM_MAP_SIZE is defined immediately above, so the second condition is
always false. On systems where configure finds no struct prctl_mm_map, the
fallback is therefore never declared and the test fails to compile.

--- [PATCH 2/2] ---

> +	run_spray();
> +
> +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> +	TST_CHECKPOINT_WAIT(CP_SETATTR_DONE);

Could sched_setattr() run while PR_SET_MM_MAP is still copying the controlled
auxv? Here all prctl calls return before the checkpoint wake, and the waiter
then executes checkpoint futex syscalls before the main thread starts the
chain walk. The controlled user_auxv stack array is no longer live and can be
overwritten, allowing a vulnerable kernel to survive and be reported as
TPASS. The referenced PoC keeps the prctl copy active while sched_setattr()
runs so that the forged waiter remains live during the chain walk.

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
