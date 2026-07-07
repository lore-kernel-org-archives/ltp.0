Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C50FC43602
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 16:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D00303E5D3E
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 18:43:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594BC3DCD69
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:43:08 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D215F1000488
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 18:43:07 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 d9443c01a7336-2ccb0e85312so9455385ad.0
 for <ltp@lists.linux.it>; Tue, 07 Jul 2026 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783442586; x=1784047386; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jUVgshPDiMkUZzpL44SWizimgvlUnRDyEJwUPVEf5o=;
 b=UfH/33FZLBqFZEkD62apeiN8pwf4jVPwbm4xltKAmpx73vhveRAZJ8On5yJEZjoN5L
 Na51PeclRWHYwcu//BA8L5TXmTEP3J9/dOEfHCazZ0pv8wfBIQ7Z9SfzqxbL2lq9Yic0
 S9Ofw8fALOTb7s71V85cwWkJDz5W/HoikhN1jv4wSP/feAs/6O4HtS5wQjZDJ/tHS2oM
 /WUj4EMqo+OJa8LZgW65nFOVszcvd0jQ8+g/XmyWfxwmja6W3nP7vG1cb5f52f57XFov
 D1rl/suqskdMERbcXZBkFNi4E5jyRdwqPgB/0CIaHPPO6yB1ObjIDeeeKlSTv7XKFJwA
 +ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442586; x=1784047386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jUVgshPDiMkUZzpL44SWizimgvlUnRDyEJwUPVEf5o=;
 b=OGDSs0NBLZudtJCEjBBu7GcT12aL++vGE+cRYejUkwJBLIQIqXG+yehMTrc3sqvVyq
 1O1/xeXwmR1nTfrTueI+7ViW6vso8iMT/+8OqFYPzLF+IaqN9tFJGal4XxJSkIWjrmnH
 JSlNpFlN3gW0vyrLBHJ7JBDfmWdfZrmEurG5L2eEHgm+PdZZxLPsbEtPXCjKoiCJjsNb
 uFlqB23Q8Ed/2pPJsKzp2BMUXxIOyc1vm/tAPYU6+5FMMHSVKZyNPbQyMVFlw2k8/Avy
 t9fkXLppQguMFpHGX0TQB3cmv056cF2KjXtzp9XUvBNRUZtekS38oKl5m4cBl3BPeoF1
 lE5w==
X-Gm-Message-State: AOJu0YwDmPieJUVAYwY8reo1fgmo3mb6HHdAboGolcqVVH/XumErPZkr
 a/zDCC4nmm0+jkDJ++FEuSqpRD78aj9yeTEtbXHOGpJfwFbbsWC7MtOP
X-Gm-Gg: AfdE7clsaLbcXtz5i/uQwozOt5WyVrdlFX7t6/BuUkSURtPDE+xKylZFDPaD3/xs7ff
 eyzAbqEyaQKNOo/aaTu67P/eb6RDM8j/RrtjqSmNnAAwkSqzUPRKeOetse1r41bc5c9WS8M+H9C
 yq7rFy5PPbeURqHpy2jd6C+ISLHrXNiKdwz7hIZL2/8btirZLh4NwjHahy42kmArzYa1gQzcLYu
 C0jgouVh7lP/WaoM1Re8/3TDavWMr19qmcBI1lB92uS/fAX1mLGKHYYLSHvnURzxABZEA0NPvyT
 GayNc5XvoTVHenIFhIV87ZW1zIhEDer6C+VfOiudRrk5CtOU3EITTVDwLYJcZG+/ayWUHyOWCay
 PALb6IKW361j2/h0qq0UeGiz4qD/vcQnoPDp8R83vvHhenWLl0bBhzwljevz3YcTcZyFso3myjB
 wfIjV8UtvlH7QPT555JKpblMrz34e9epqqbtasQ5QxFvb+25u93y5lWbq1QRczLeU8tv+RicVP4
 XOJn2RzQLdCIUuCDhX6UbzoOg==
X-Received: by 2002:a05:6a20:2583:b0:3bf:e2dc:bc85 with SMTP id
 adf61e73a8af0-3c08ee88445mr7032314637.40.1783442586126; 
 Tue, 07 Jul 2026 09:43:06 -0700 (PDT)
Received: from
 runnervmkkn4f.jugp4dghd53ezkxajpihhsqn3f.dx.internal.cloudapp.net
 ([13.83.98.83]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b658a99afsm10567298c88.0.2026.07.07.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:43:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue,  7 Jul 2026 16:43:04 +0000
Message-ID: <20260707164304.4232-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707160024.216347-1-japo@linux.ibm.com>
References: <20260707160024.216347-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Add ptrace support for
 CONFIG_PROC_MEM_FORCE_PTRACE=y
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

Hi Jan,

On Tue, 7 Jul 2026 18:00:22 +0200, Jan Polensky wrote:
> thp04: Add ptrace support for CONFIG_PROC_MEM_FORCE_PTRACE=y

> - Restores lapi/mmap.h for MADV_* fallback definitions

The diff shows lapi/mmap.h was already present in the original file
and was not removed or re-added by this patch. "Restores" is
inaccurate here.

> +static void setup_ptrace_tracee(void)
> +{
> +	int status;
> +
> +	/* Test-loop state is initialized once and read-only afterwards. */
> +	child = SAFE_MMAP(NULL, sizeof(*child), PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	memset(child, 0, sizeof(*child));
> +	child->writefd = -1;
> +	child->readfd = -1;
> +
> +	tracee_pid = SAFE_FORK();
> +	if (!tracee_pid) {
> +		tracee_main();
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_PTRACE(PTRACE_SEIZE, tracee_pid, NULL, NULL);
> +
> +	/*
> +	 * Tracee will run first iteration (madvise + check) and self-stop
> +	 * with raise(SIGSTOP). Wait for that SIGSTOP - this is iteration 0.
> +	 */
> +	SAFE_WAITPID(tracee_pid, &status, 0);

There is a race here. After TST_CHECKPOINT_WAKE(0) the tracee runs the
for(;;) body immediately and calls raise(SIGSTOP). If that raise()
fires before PTRACE_SEIZE executes in the parent, the SIGSTOP causes a
job-control stop (T state), not a ptrace-stop. PTRACE_SEIZE on an
already-T-stopped process does not generate a new ptrace event.

SAFE_WAITPID(..., 0) without WUNTRACED cannot see a job-control stop,
so the parent hangs indefinitely.

The comment "Parent will PTRACE_CONT us when ready - no checkpoint
needed" assumes PTRACE_SEIZE always wins the race, which is not
guaranteed, especially on a loaded system.

A second checkpoint (wake from parent after PTRACE_SEIZE completes,
wait in tracee before the first loop iteration) would close the window.

> +/*
>   * CVE-2017-1000405
>   *
> [...]
> + * Test Modes:
> + *
> + * PROC_MEM_ALWAYS: Direct writes to /proc/self/mem ...

The patch modifies this description block. The required opening for an
LTP high-level description block is /*\ (with a backslash), not /*.
The block is exported to the test catalog and must use the /*\ form.

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
