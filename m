Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910B1C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 23:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4F1F3E9874
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 01:08:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EEC63E2D90
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 01:07:44 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 408531000448
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 01:07:44 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-936623c6dd3so48886985a.0
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788390463; x=1788995263; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ROCqSg4YJDj/a94YF2/UalAhrRcR3k9er9FtS0oRk2A=;
 b=BhM2PUQhkWZfjtHL6YiyBIZkR+iloQfa6Yqjs6RxBAOcHHbo/+lp3uViEoG3HKfyaL
 Tizb/GhjRdAzXBZCn6MsJMqKmL9Q26p0uar88nL4TgpqUeuT8gR35X7LlAWreAQBPEAA
 yl0bjXhq3EUw8P6KDiKYvJpFEi1wwb0Hf0+3ysOCDQC/570+IV5l2vOaKkZmo5dwhUSq
 1e9AWqzYj1rTcV8nenZ5xXkMpZL4j24MjYU1A5H2aSKDcgE1ajeu4EYvoIJYgc8ol/+t
 b5VKAEw3+BCraxeZviXAYF2qK+9a6SPbhQebMAhoYxOxuXr3LhbG/k5pvGpjRje9OXqC
 XTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788390463; x=1788995263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ROCqSg4YJDj/a94YF2/UalAhrRcR3k9er9FtS0oRk2A=;
 b=MHA/uNKgtJ0Kan54XTWd0A6kJjchm8TLgbG/fwREFgomhDWjLNUR65S1S46oqC4a5i
 LxTZF0+UE4mYZv5w0YJGg5IYzTHXlARJ6HkLFiWrRYQR+/xp2qPcNS8Ykbr7DnxXoyLz
 IeDeOIPbWgCCO/zJ6/MoO6lyjfN9oISE7jEEJvuBFH9K8yejzNkF+P15fwZ4Zi5hOJ0Q
 /Oo4nUJDMDLbb9mI6ZNhInlK5S9X641x8Q1nWe3gYxj128J0miZ/iKaF2MYvjEkpSvJ5
 vYfbcT6mAdZvau+Bw6WFQHd9nmqK8QohVGlzV/tGyWsA+VQ1Tv+pmx6HmCGOPcS7vJpw
 tYeg==
X-Gm-Message-State: AFuF++nWZoh4qmKQU9vYdkG23WX+/vJdzDs/OsSXKeQtxjMqZ/MpoY3X
 cU/I9YwZLpDzuv85qRXrYk6UOJjzU4xt2CFKylO8u4fFxGSVclNXrRQX
X-Gm-Gg: AYBFou28X+1qxJ0Xbe8+ZJij94QdOPJqJvhmyRZQr18B/FiBUroc6l46PefjcPRZXJh
 fV6inywKxBtSa+i9Fy7xy6PkM0DM70Xx4bnYtSiaMeLl6wMk+ufyL+Lbg8yKHKdAIaqoEzXNf2R
 CW4r+L9wM8p5kqrcifebLwRkNOKvxTjB0eP1y16X1Eia+uBp78xLyF8FXuobKkBcoXw41RBs0u4
 ZAbpJEShRTGMUgLTpv2xuErJxvcIoTcWN31nCMVagRqpIzzgLzOlh+k21QQvqb9zNh8h1PlLiST
 AxhyiieQXo/x3HuGyUDvz9VUY4ajwt23xV72mR5iX/Vcs93gUuCOff7wu9arvELtpafv4J2FOXv
 loiNY12uIU+zEVJAtMGE4QHYLKF8YujxLFMIhjFjaaVdrZSI+KOMUdFR/hGheGk/ZYsdXlGkLDh
 JY5JsiIumsynBONIr33vm9ZctiizMpChq4+3+nYcSbw0wr/lFLR31j0Tc8wH5TX1VbgqFyhLiBY
 TP+HubUGFLb6HZ5iz2bxtz1JoROH0urtOjIgAj805uyDAgKOWrtWesgik5dZk9LMTMOd/UBHSpY
 rQ==
X-Received: by 2002:a05:620a:6193:b0:939:72cb:bae3 with SMTP id
 af79cd13be357-93972cbbc8amr12406785a.26.1788390462842; 
 Wed, 02 Sep 2026 16:07:42 -0700 (PDT)
Received: from
 runnervmejwal.h0l24wjbi32ehma3ntfoutcuxb.cx.internal.cloudapp.net
 ([145.132.99.102]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f398a18sm328923285a.37.2026.09.02.16.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 16:07:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  2 Sep 2026 23:07:41 +0000
Message-ID: <20260902230741.17215-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902-cve-ghostlock-v5-1-569b9eb37941@suse.com>
References: <20260902-cve-ghostlock-v5-1-569b9eb37941@suse.com>
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

On Sep 2, 2026, Andrea Cervesato wrote:
> lapi/sched: add SAFE_SCHED_SETATTR()

--- [PATCH 1/3] ---

> static inline int safe_sched_setattr(const char *file, const int lineno,
> 				     pid_t pid, const struct sched_attr *attr,
> 				     unsigned int flags)
> {
> 	int ret;
>
> 	ret = sched_setattr(pid, attr, flags);

glibc's sched_setattr() takes a non-const struct sched_attr pointer, so this
discards const and fails with -Werror=discarded-qualifiers on the new glibc
API. Match that prototype here and in the fallback declaration.

> #define SAFE_SCHED_SETATTR(pid, attr, flags)\
> 	safe_sched_setattr(__FILE__, __LINE__, (pid), (attr), (flags))

This new public macro needs a kernel-doc comment documenting its arguments
and failure behavior.

--- [PATCH 2/3] ---

> #ifndef PR_SET_MM_MAP
> # define PR_SET_MM_MAP	14
> #endif
> #ifndef PR_SET_MM_MAP_SIZE
> # define PR_SET_MM_MAP_SIZE	15
> #endif
>
> #if !(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP)
> struct prctl_mm_map {

The fallback struct is unreachable when needed because PR_SET_MM_MAP is
defined immediately before the condition. Gate it solely on
HAVE_STRUCT_PRCTL_MM_MAP, otherwise the new CVE test fails to compile on
systems lacking the struct.

--- [PATCH 3/3] ---

> static struct tst_test test = {
> 	.setup = setup,
> 	.test_all = run,
> 	.runtime = 180,
> 	.needs_checkpoints = 1,

PR_SET_MM_MAP was added in Linux 3.18. Add .min_kver = "3.18"; otherwise
3.3--3.17 kernels with both requested configs reach setup and report TBROK
for the unsupported operation.

> 	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &ts);
> 	ts = tst_timespec_add(ts, (struct timespec){ .tv_sec = 10, .tv_nsec = 0 });
> 	futex_wait_requeue_pi(&f_wait, &f_pi_target, &ts);
>
> 	TST_CHECKPOINT_WAKE(CP_SPRAYED);

The futex result is ignored, so expiry or another failure publishes
CP_SPRAYED without establishing the PI topology and causes a spurious TBROK.
Use an untimed blocking wait, or validate the result before the wake.

> refluxfs
> sctphantom
> ghostlock

Keep the new .gitignore entry sorted by placing ghostlock before refluxfs.

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
