Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E2ACD5BD5
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C643D3C9A33
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:54:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CBEA3C6FCD
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:53:44 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC51960093B
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:53:43 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8bb09239328so86976016d6.3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779875623; x=1780480423; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1BwIO+wyA0vNzSv8KtZqlkcyqlN7InO5r6okKTlels=;
 b=T5ZUDVVpYKKhEsR3ue0a5yIX31d2Ys03j0dEJwOd2XoPFVxDkZuOSdnOnoeXUUvxR0
 1XvQzVKmZBDCepadxPzzP73gYKRLlGkZYqeJgx9yEDQfNdxYbEmntdLjFUr7fn2u+a/Z
 TNbyO+y72h2Su2MqSRgApgkTPjhsH5PUGdVBCx9b7RPV1mDcqk98/eehHLfrX6NXLrMB
 99o1PLyu53ObKINu/cgtWD+A+ZOZmpw3oLV4/x6h/jsT9RccH+pFd6bcl3FY3cKlMYaa
 nVJh6wA1ORAIlGyXGPrVmKM2/HlbwLPgqup2nxaaWkmOcMN6U22WywXZbNnciSZoI3RI
 bPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875623; x=1780480423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1BwIO+wyA0vNzSv8KtZqlkcyqlN7InO5r6okKTlels=;
 b=d+qGxFQfYeCyBAlVj9XRNPDJqswePiCUlcpxLoroza9A7ZzBy91RHnA1SFI/4BzsGx
 bzhS9fmXmj+27dFyU59bOnrg+d8U8Dru/G9RWD13g9mXBapTVQTc08j7XL6ly5pvoASh
 rJ1HM+pUZBnp9tgBc1f4S53dO6+5vdwr77jsF/ohbejikPfvYelJgTQAIS2+EMruuJSD
 FNGlVsgVGkPNUl9ZtR4ZNgPilIBi8VMXajOl3WcC1jHvuH2q36vPqpLJRWEevWZH5jNJ
 sHn2fH6s5PulqJZ0aWGffgvujuOFa9Jok27Bgi3bg04oyC3DpJz5DuyRcuQT/FpJc6J6
 um9w==
X-Gm-Message-State: AOJu0Yyn7/p5aHmM0twxyUF32mFxLzyjkqM6t88l83JBvsiV4Xm6hbXw
 FnKe5N0p/Qz/k2KL0c9F3rkp5IS+2jHWEx7seB6MrMKjtBAoLNcdJ2+EQIYvGo2G64Q=
X-Gm-Gg: Acq92OGtfbCRA6ikpQtSTIPgYvTCUKWGDgaAN7YDaQ9bLZbWnBm2Rui7u4gzf3r7abg
 kJBGiXPtSYEV6RyMV0Ip0s9/lOyQc2Ayw8LCvZwi0OBlA+wH9hEgjjKHw1Cv8ssOqfO1V5A6cMF
 e2Zkg++7DpbQU2pt3+e68d20+HgaZvnFo6eXZvLNpdNHLeixXv1GD1+Af36jAT9Qb1o3wd9HrOe
 04EjVw58uMl2V5MlpUUahmYFUZkD5FrwNiR99z6nThvDcynz7vnBiKWVEwEuHacLiOgtAWQGs34
 XZj3XZTn5pn6MRS/zdFkRL0ACqTCMVjUy/csy4psoh40CJppsifpti+1Jfi2BUQsctShk4xGbR4
 fHdODXz8iWyewaEJ8n+RLikuqv5yZV2Rd8s1cFlrT11Ruahw0uVTOGeidmhXEJBvFtKIkJIELMh
 PcOV+/u1d/0hi+nkVHg3Yd+AbgTzwqP6T7CUpkTgT6BryKh/tv1SO9DuZ+34XplBDXqg0XvNNvx
 RC3TooAEKixBkAhxMG4NuMjmHtgNOA1j1SKaOWyYHcOvIqa1Iw=
X-Received: by 2002:a05:6214:1d0d:b0:8ac:abc5:8754 with SMTP id
 6a1803df08f44-8cc7b65ccb5mr334800486d6.30.1779875622569; 
 Wed, 27 May 2026 02:53:42 -0700 (PDT)
Received: from
 runnervmg397c.0xavb5yt4blube0y5vrnuhw5xc.ex.internal.cloudapp.net
 ([64.236.177.115]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80dcd81esm163108306d6.9.2026.05.27.02.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:53:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: AnonymeMeow <anonymemeow@gmail.com>
Date: Wed, 27 May 2026 09:53:40 +0000
Message-ID: <20260527095340.4092-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527064041.50443-1-anonymemeow@gmail.com>
References: <20260527064041.50443-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify: prepare tests for thread pidfd reporting
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

Hi AnonymeMeow,

On Wed May 27 2026, AnonymeMeow wrote:
> fanotify: prepare tests for thread pidfd reporting

Commit message body is an email exchange transcript rather than a clean
description of what the patch does and why. Please rewrite it as a
standalone commit message.

---

> diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h

PIDFD_THREAD is used in fanotify21.c but is not defined in
include/lapi/pidfd.h. On systems with kernel headers older than 6.9
this will fail to compile. Add a fallback:

  #ifndef PIDFD_THREAD
  # define PIDFD_THREAD O_EXCL
  #endif

---

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/...

[...]

> +unsigned int needs_thread_pidfd;

Other boolean-like fields in test_case_t use int. Make this int for
consistency.

[...]

The file-level docstring says the test "ensures that the fanotify(7) API
returns an expected error code when provided an invalid initialization
flag". The new third test case behaves differently depending on kernel
support (may expect success). Update the docstring.

---

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/...

[...]

> +if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +tst_brk(TBROK, "child process terminated incorrectly");
> +

Trailing whitespace on the blank line above.

[...]

> +static pthread_t do_pthread_create(int want_pidfd_err)
> +{
[...]
> +SAFE_PTHREAD_JOIN(worker, (void **)&status);
> +if (status != 0)

status is int (4 bytes) but pthread_join writes a void* (8 bytes on
64-bit) at that address, corrupting the stack. Use NULL since the return
value is not needed:

  SAFE_PTHREAD_JOIN(worker, NULL);

[...]

> +if (tc->trigger_in_child && !tc->want_pidfd_err) {
> +int status;
> +TST_CHECKPOINT_WAKE(0);
> +if (TST_VARIANT_PIDFD_THREAD) {
> +SAFE_PTHREAD_JOIN(worker_id.pthread_id, (void **)&status);
> +if (status != 0)

Same bug: (void **)&status writes 8 bytes to a 4-byte int. Use NULL or
a void* variable here too.

---

Needs revision:
- Add PIDFD_THREAD fallback to include/lapi/pidfd.h
- Fix SAFE_PTHREAD_JOIN (void **)&status type mismatch in both call sites
- Clean up commit message
- Update fanotify20 docstring to cover the new kernel-conditional test case
- Fix trailing whitespace and needs_thread_pidfd type

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
