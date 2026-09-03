Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A4C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4C3C3EB0C1
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 18:04:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51793EA7BB
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:04:15 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56F52200B31
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 18:04:15 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4a4492f5cd1so4968b6e.1
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451454; x=1789056254; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s20LqvZ9wH5SSwih4ih6havUTCI7+zk7QYqZgNVM58c=;
 b=r878a3KDNXQRnwAvkrFnRtwgnZenJL7ab8jO5H0xJLQLvQzJ1ceSPLGEC5v+JEUQvi
 sFGuBw12ImizPNeZeqcYPBHG2HUzCzME5cizkFInzdoddvbcT0m7+TUNe3fPXk4plr8P
 C9rOwGshwgFnZMGzsGl4U3aQJMbIBLxEBpsw7n7TlO7ZVbrVsRQQT6lNJtPqNV0/q/7+
 etJplvGlCWATDQ7VN9dD+tn3YdJ9zQGB5QNEpKsj2IgZI/cOthSiiO7SDwmAq+Piv2RB
 5yI2WqcVodDHH8nEXBFHmWeSkLmiQN2U5xWhb4jPzNO79pIa/AsslGNCxD46URKIVf5S
 hYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451454; x=1789056254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s20LqvZ9wH5SSwih4ih6havUTCI7+zk7QYqZgNVM58c=;
 b=HXFLGJPmbaNpQ9roZu6HJVZxhOMGjVSTeGv7WbSsbrGYw+MsU+5jW1NkBhnyLAIE0s
 cIJ4mN78OzgSCQmlMynjC5/JjDqIxWQkkZIA4ejAO1Au6pTyJqtwVNxSD+m6ZJzzQJ3b
 CxhRzLKmfG7FWroTZvopuRVt6mTNHyYtNnCbUk0p2p/h9LdGZAuJLr2SXFgG0A8Xdrdo
 jV6LwXSza814QHkbg5I3E1vJ0VnZr5quOFaCZMN4auRClarMOEplrEN+q8EDrQuns5GB
 bBx++7um8LAxo2Q2SemZUoBlvOTuJsS31N8pdXlheA2tSoMxX4RoSnEXvRho+4pZiioK
 ZYgQ==
X-Gm-Message-State: AFuF++m4L2H8wL0nWU2OpXaDRHeydnwF44/T26ZwyKgpr6Y6sqhHFWNQ
 U8z9yvjNHGOvRBDI4CvdxYcl0oHcN6u9ojJ9MpGAha1Jp2dobddxQR99Oq6gWBfAcHw=
X-Gm-Gg: AYBFou2dg2SpOr3WAR1lddeczy6izS6oAKKmjGt78xiY11sE+/8h3UoI2AniENwoLoP
 g1CWNiLNCuzit7PWfK/4CpAd4+RN950CNQYdNdcUAjvQhAXNVZX3OP7uxQoWhEaPj9k888SB1Jd
 SdPZhdklzW6YAe+4Du4EM3ZKnjNaSkdnaYHwDJyC3DxdO2vbC4pWlnRq75MsrIlrK3zyUQ/rwhl
 sIygj9NXSIE+AXYRzFHSGThE4jBjjWbX3zwPyIpoY+HVMORu7nOFChCYcTOyjdj+L0rPWZ1rrzv
 D4xENqQQWYbq0Og5V+4W0SRvsMGmnyQrjQJEHRLBfeuFuGfyy+PAV2lgNiNT27KaBDtLR6tXayx
 TxB7D7tZPVeGFplJ7ytPI28/FbMmF41VRllFeX6YH7XyWgvrreuPcdUGs6mQFqW0TY4OBJbFfn4
 62w2nsHFpz9uWvVviG5Nn/QUoA7O5qKmvYcRWvS9rElNFdgeL3iB8KIE59vGX/f0rlI+ox802IW
 x4yl7SFDXWoHeEzHXu2hM6qlU5psSvaM0RKhFCwpIXjRJ2k05zI4ZGSQg6DqaWb9us+ST6Fooso
X-Received: by 2002:a05:6808:14d5:b0:4b3:7585:4a95 with SMTP id
 5614622812f47-4b6beb4aee4mr9654118b6e.11.1788451453749; 
 Thu, 03 Sep 2026 09:04:13 -0700 (PDT)
Received: from
 runnervmejwal.23hp1asneuhujhihggnxqgftyf.gx.internal.cloudapp.net
 ([20.118.238.27]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f30cb5a17sm7902985fac.8.2026.09.03.09.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 09:04:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  3 Sep 2026 16:04:11 +0000
Message-ID: <20260903160411.9148-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903-cve-ghostlock-v7-1-771e99aa3057@suse.com>
References: <20260903-cve-ghostlock-v7-1-771e99aa3057@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_setattr01: Convert to new API
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
> sched_setattr01: Convert to new API

--- [PATCH 4/5] ---

> +#ifndef PR_SET_MM_MAP
> +# define PR_SET_MM_MAP	14
> +#endif

PR_SET_MM_MAP_SIZE is listed in the commit message but is not defined here.
Add its UAPI value, 15, alongside PR_SET_MM_MAP.

--- [PATCH 5/5] ---

> +	map.start_code = map.start_data = map.end_data =
> +	map.start_brk = map.brk = map.start_stack = map.arg_start =
> +	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&map;

PR_SET_MM_MAP copies these values into current->mm, so this sets the process
break to a stack address before the test starts. Preserve the real break with
sbrk(0), as waiter_fn() does, and supply valid current values for the other
memory-map fields.

> +	if (i == ARRAY_SIZE(try_sizes))
> +		tst_brk(TBROK | TERRNO, "PR_SET_MM_MAP failed for all auxv sizes");

PR_SET_MM_MAP was added in Linux 3.18, while the CVE predates it. Add
`.min_kver = "3.18"` or report TCONF when this required operation is
unavailable instead of reporting TBROK.

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
