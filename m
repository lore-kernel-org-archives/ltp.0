Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA411CD8CAE
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 05:14:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8FFB3E1642
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 07:14:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CC873C8679
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 07:14:33 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22091601409
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 07:14:33 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ccf6a63a45so64592446d6.3
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780982072; x=1781586872; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJE9jmyINedG5J+RxZ4KKz64CR6iv1j4+0AK/GRp2oA=;
 b=eyGV6/Vq0/xfIgh1995hNCjyEzUBj6olELf+iuJUDliSoG65AF9gKXfH4K4d3hMRPY
 PDcC73zR4KV1yWvKd6uLYOmcTiYZWjRSpL8E0afjMhRwa00FKObhpBmCunHC5OLS6zPo
 imSnHIJCh5w/4mff0u2u+cRE69iyV6qlJNfgXbxbxlcOaueqosUpEDIOY1LPO1eguD90
 enuTnXkPbRl/6Ztva2UjvApUSegIWDj3x5Dvnn9e2MKIx8b68behJpvBqUJO+8sjbVND
 Xo8o16RdqPm1coGIvHdBJbDKYMFXDguThgfDznBjc66ZHIFRgU2dKJoSnBApLASso1QD
 lo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780982072; x=1781586872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zJE9jmyINedG5J+RxZ4KKz64CR6iv1j4+0AK/GRp2oA=;
 b=f0PRC6sQ+Sb/Ks1ybUGTDa8+XwlHt7UpeNXhp7G3MBeE+6D5RYJS80z87Sg/q54kkX
 WCOYD59xlNzF1XJmDdTYzo2gE9btEYZL7yVoXtAxDehhpYAHfaP+sWLfGohi5rbXzZOs
 3tbgSPxr8N17gq2p72aLW1nsSwnuOXdyfE1Sgn562XLutrIqXVMg/rjMczSS5y4eIHaB
 yyEZHJYFWVyFeLFn1YUV5rkYobKAvHudPBoBx2d656olcez/b1thentjqoeuMQftdzEy
 Y/UiH/FHS7ng2JtR8uCSdrG5ivI+0OVE0Xr2Cy5u5vO2jtxkb7cDZDsrfTYMbIMLqNKE
 FEXw==
X-Gm-Message-State: AOJu0YwY+1q/pldXXWLRxARR99L53VD6Yns3xrVN9VFnlUDbkTrfs6st
 neFtSLcmZMFVMDCllfqcRuI2yL/1jePAPZLRfoel7T8hIVJmzzcT3RHv
X-Gm-Gg: Acq92OEzTPnxvJgHLmsei/LSVR7yVHd0m0eot/ZZHDGW4tcTYydAyD7VNDHxSLofjv6
 rBNqty10w7ZHa6Ya+HkBX01Afu7K6EhW6NWxl49h7ImSm1tG0fZExt3wmKMivQRF4hvAqLkOMuM
 +4f96bHyXsAgNRdZxxgRExsbhFKdacFo1uZZb6YMdg5csWWaKDUovVWDVi757B0aWGLV6CFYzLJ
 LXy/aje5c9hfvukHxVpE8vUdxpG25aOeuED3pWzHGWzHqSfn9p7OyKfgzB13UNqmdC+c99yg9hj
 suWlQgFOUWNQrWW/7gngdrbbHoAQE7IN7PoBYJgBM9DK6RGqLMGP+8HnXfCUuufiiwO+dHjjxtj
 kUVsaarGs1Sd5hVyRG9OTo/BwU7ESsH0Abc5lBowtmgcz+aajFZ0SqkXFt1EGAudAeGaBc0N1qb
 fCBT0Qe7BWJQBpErk5IA5Fwi3rSfa1tw915zqmhfNrk3sZ3268hG3e02vRMJ8Kpqz3ZjBmnIc8J
 jegkV5Vt7x4hAzP4EEA01M5MS9juJ7gxJV6jG+OPsD/RaSX7w==
X-Received: by 2002:a05:622a:2597:b0:517:9407:5c36 with SMTP id
 d75a77b69052e-51795be8eccmr270893041cf.53.1780982071728; 
 Mon, 08 Jun 2026 22:14:31 -0700 (PDT)
Received: from
 runnervm3jyl0.f10dncn03soelb24l4hivhqg2e.bx.internal.cloudapp.net
 ([4.227.169.196]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51795d46f12sm120983241cf.16.2026.06.08.22.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 22:14:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Praveen K Pandey <praveen@linux.ibm.com>
Date: Tue,  9 Jun 2026 05:14:30 +0000
Message-ID: <20260609051430.4154-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609041632.74427-2-praveen@linux.ibm.com>
References: <20260609041632.74427-2-praveen@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ftrace: Add common library for C implementation
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

Hi Praveen,

On Tue, Jun 9, 2026, Praveen K Pandey wrote:
> ftrace: Add common library for C implementation

--- [PATCH 1/5] ---

> -INSTALL_TARGETS         := *.sh ftrace_stress/*
> +# Filter out ftrace_lib from standalone build targets
> +FILTER_OUT_MAKE_TARGETS := ftrace_lib

Removing INSTALL_TARGETS here means the ftrace_stress/* helper
scripts are no longer installed, but ftrace_stress_test.sh still
exists and depends on them (it is not converted until patch 4/5).
This breaks the shell-based stress test at this intermediate
commit.

Moving this removal to patch 5/5 (where the helper scripts are
actually deleted) would preserve bisectability.

--- [PATCH 2/5] ---

> -ftrace_regression01	ftrace_regression01.sh
> -ftrace_regression02	ftrace_regression02.sh
> -ftrace-stress-test	ftrace_stress_test.sh 90
> +ftrace_regression01	ftrace_regression01
> +ftrace_regression02	ftrace_regression02
> +ftrace-stress-test	ftrace_stress_test

This patch converts only ftrace_regression01, but all three
runtest/tracing entries are updated to reference C binaries.
At this point ftrace_regression02 and ftrace_stress_test binaries
do not exist -- their .c files are added in patches 3/5 and 4/5
respectively.

After this commit, running ftrace_regression02 or ftrace-stress-test
from the runtest file will look for binaries that cannot be built.
Each conversion patch should only update its own runtest entry.

--- [PATCH 4/5] ---

> +static struct stress_test stress_tests[] = {
> +	{"current_tracer", "current_tracer", stress_current_tracer, 0},
> +	{"trace_pipe", "trace_pipe", stress_trace_pipe, 0},
> +	{"set_event", "events/enable", stress_set_event, 0},
> +	{"buffer_size_kb", "buffer_size_kb", stress_buffer_size, 0},
> +	{"tracing_on", "tracing_on", stress_tracing_on, 0},
> +	{"trace_options", "trace_options", stress_trace_options, 0},
> +	{"set_ftrace_filter", "set_ftrace_filter", stress_set_ftrace_filter, 0},

The original shell test exercised 17 ftrace interfaces concurrently:
trace_pipe, current_tracer, ftrace_enabled,
function_profile_enabled, set_event, set_ftrace_pid,
stack_max_size, stack_trace, trace, trace_clock, trace_options,
trace_stat, tracing_enabled, tracing_max_latency, tracing_on,
buffer_size_kb, tracing_cpumask, and set_ftrace_filter.

The C version implements 7 of these, dropping 10 stress targets.
Is the reduced coverage intentional? If so, it would be good to
note it in the commit message.

>  * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
>  */
>
> +/*\
>  * ...
>  *    The test creates multiple threads that stress test different
>  *    ftrace interfaces concurrently for a specified duration.
>  *
>  *    Signed-off-by: Praveen K Pandey <praveen@linux.ibm.com>

The commit message states "Test timeout set to 300 seconds", but
the code has `.timeout = DEFAULT_TEST_DURATION + 30` which
evaluates to 90, not 300.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
