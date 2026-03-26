Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE0E106F31E
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774520772; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BaZycrsJegI7BNTlqFPpFlBAGGF5MNke6uEOLXqG5tk=;
 b=j9oNMSSnIfGgtTEhqT+e6WdDR+wi9lOSTM5bziCJedrEca6kjR002YKAtJhtRKRRIfzJi
 wwbaDMX8OQRJ0sTj8OGmt9WgwfvRNt9jMsetpZjJWLpSxoUOLYj2A0UmESoMxdblFACAtRo
 yUzyXSXNumSmLI0uKksLHG9y5dyKZDI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5292B3E2FD8
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:26:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 256B93E2AB3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:25:48 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6BBA22009E6
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:25:48 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483487335c2so8918265e9.2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774520748; x=1775125548; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fbVE5AQbe0Uf3hynU83Dh3TVBFbHjcZ3HXlntEBA92M=;
 b=FpDqw3lLaznciDp/GC2dBBm5lwIz0BWqqeYVNqAxf/BWQagC5ps9eoCa/uyU4KPVck
 o92sv3vVW8NWLdsKV1ko+NIRP1uR39B5KN0RT1ehv+KdN0OiW7BEuMtSC6vzEghZSFgn
 JQSp+Ks386dXOvmlOySTaFsLcwtVZZ2hNDPwIiBDOftjvFhGZWYfQ8lCK42gN2lChJat
 0V4WoDXzeFVDYesV1OPaVI3NXcJuV2FJZwo5TNdCWatpFs6rM/H4Ya/rPwIby8ZcG3N9
 Y55FhfTnulLM9AITK/r0lP/LPVIYstM5zNjFC4AosFYbQ4I+x3XLOUD0WLkIrvoYc+58
 qrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774520748; x=1775125548;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbVE5AQbe0Uf3hynU83Dh3TVBFbHjcZ3HXlntEBA92M=;
 b=mV7k6nosv9CNvs/diYpO2xftf0RlqqiDKyb+whQpCqMDjtt1jUIA+vGHe5TR4D22gI
 srrkyhK/qqocecEQN3Cp8jjT31tiT0ZeOhbmsky435KWknAdAarnPayYNhAfO4Y5Nr2k
 UHFeM9NeMmoIeztt4jbQJUU2yso7O3gcSFVtsLcFvt6kAjywvShi/FD1r65Y+eMR6hW+
 fPCtc/zRH/uVOoovvHUHImnwp62vuYwiO4q3ngmTbkvoSA4/YB8DmkgslQ6qfQhVsc7g
 rX7rWqj/9IFSdPGtz8l0y6aeBZNG00zGO+lRxd55Qtn/c3S3eLEwvlhMGPlFx92fO0ES
 hs5A==
X-Gm-Message-State: AOJu0YyGqRsAc1egZjySqcE2A3huEqfYjAuwNYAKgBcPMn6A0jCUdvVw
 zSRDq8NqPFX0+p/RSzMCVQbanZuvfh1gICOJFcnF5q/u4/oVD95jrQxGrxZHwdFNNjzGX6Z0dlH
 KeQiEHDrD7g==
X-Gm-Gg: ATEYQzyOaW+Y2lF4ZJ+XyTuK4zn+JUtHpNkqMxDIhP62VwNjaQbQ7ObE0/yAvR6Hb0R
 ZVl/vhRH2HfJ1hfZTvxPEczOEshrcmq4U7d5KzkYkd9Bvjp8i6GbqQuOv8yds+m3Ta6yKMfHzL2
 fHQcBr6Py30iF203MPAXLT4RZvKhGpfLx8Gl3KQAB8I4Mm7QVZUxNLNPqrnyP2lYqjRvPbJJuPF
 X0kDdNgQp+Il1Tg6n8qFT5W1eaO4/D5zwnsbfr3dh/n3G+Vx9LTcVEOWSDRyVD1QnTy4WZ7iX/v
 v8Tno/CEA/JjC7fdBxIhO63uSkNXWwYeS+Hux0nw83YiW1VLr7WAE3gt3pMNq5xCymS1XxQtImS
 hxIE40OHPxBtW6r6TGneDBRNrb9H/EjZUYUVresmHu3MhW5hlfDn9/K03Qn+/L5pU9j8Qq9SZBA
 vPYLan+B7chKinu73OK8LB48JVw2nFWzbPPj+9gGR91ZW5J/cBwCAK5GUejERQAKtA9zyWTi2RH
 yvo1cjqTD0/5pJi5ce+SOOmW54gsauUMKI=
X-Received: by 2002:a05:600c:620b:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-48715fdebd2mr109211685e9.11.1774520747516; 
 Thu, 26 Mar 2026 03:25:47 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487208ca5b0sm38750305e9.2.2026.03.26.03.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:25:46 -0700 (PDT)
Message-ID: <69c509aa.050a0220.1a7546.aec9@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260311092723.254153-1-pavrampu@linux.ibm.com>
Date: Thu, 26 Mar 2026 10:25:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH] [V2] Migrating the
 libhugetlbfs/testcases/ptrace-write-hugepage.c
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

Thanks for the migration. A few things to address below.

First, the commit subject should follow the LTP convention, e.g.:

  hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

The body "Changed testcase to use new API" is too brief. Please explain
what the original test does and why it is being migrated (preserving
regression coverage for the ptrace hugepage fix, etc.).

> +/*\
> + * [Description]
> + *

The [Description] tag is deprecated and must not be used. Just remove
the line and keep the description text directly after the /*\ opener.

> +static volatile int ready_to_trace;

[...]

> +	ready_to_trace = 1;

[...]

> +	while (!ready_to_trace)
> +		;

This busy-wait spin loop combined with a SIGCHLD handler is fragile and
wastes CPU. The whole signal handler + spin loop can be replaced with
TST_PROCESS_STATE_WAIT() after PTRACE_ATTACH:

    err = ptrace(PTRACE_ATTACH, cpid, NULL, NULL);
    if (err)
        tst_brk(TFAIL | TERRNO, "ptrace(ATTACH) failed");

    TST_PROCESS_STATE_WAIT(cpid, 't');

This waits for the child to enter tracing stop, which is exactly what
the original code was trying to achieve. It also eliminates the need for
sigchld_handler() and the ready_to_trace variable entirely.

> +static void run_test(void)
> +{

[...]

> +	hpage_size = tst_get_hugepage_size();
> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);

Both hpage_size and fd are static variables set inside run_test(). When
run with -i N, fd is overwritten each iteration without closing the
previous one, leaking file descriptors. Move these to a setup() callback
so they are initialized once, or close fd at the end of each iteration.

Also, ready_to_trace is never reset to 0 at the top of run_test(), so
on -i N runs the spin loop is skipped on iteration 2+, causing a race.
(This goes away if you adopt TST_PROCESS_STATE_WAIT() as suggested
above.)

> +	SAFE_PIPE(pipefd);

[...]

> +	SAFE_READ(1, pipefd[0], &p, sizeof(p));

The pipe file descriptors are never closed. Close pipefd[1] in the
parent after fork, and close pipefd[0] after the read. In the child,
close pipefd[0] before use and close pipefd[1] after the write.

> +static void child(int hugefd, int pipefd)
> +{
> +	void *p;
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +		      hugefd, 0);

[...]

> +	pause();
> +}

The child maps a hugepage but never calls SAFE_MUNMAP(). Add a munmap
before pause(), or restructure so the mapping is cleaned up.

> +	int signal;

[...]

> +	SAFE_WAITPID(cpid, &signal, 0);

Minor: the variable name "signal" shadows the signal() function. Rename
it to "status" for clarity.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
