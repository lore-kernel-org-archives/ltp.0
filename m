Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPhEKHpn
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04C5A3EAF74
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:53:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D4AE3EA60D
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:53:05 +0200 (CEST)
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9603F6008F1
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:53:04 +0200 (CEST)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-828c0b569f6so1250238a34.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792507983; x=1793112783; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Hma9vqrzvw6FWA9l5rPilCl76a8MAz/8uAgY1IFuH4=;
 b=lPhEKHpni/Ia7fuXWSsejqAkIbC+01L1f1C9UqfMnB3I3Sj55Ff7wmpCeZXZWsnp0G
 j4pg5EkK97uqxORQsJ5JcDzHb6yGeLQgiBhNlqQhmN4eEldtQ5WFdxWxZ2eMvgyenwsH
 gY1XZyKNGe8Tu/l3zx9wQwedZt37fjijfqkWJuzWSA5kUMUGj5Mi52ADTV1pbnkYuxmK
 B3bHNtMTYrn7wGMBf9Jk0khaOQGM1uxkkMACYOhu6wwaeOswZJRaOwPtr3gthvf7MDYd
 oLMYwCz19lTne8yFtQAYm5X8Y1ahGo67r40FkVQfwuF7prXnoaOpBSHaE0HdxPFEFlJW
 z5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507983; x=1793112783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Hma9vqrzvw6FWA9l5rPilCl76a8MAz/8uAgY1IFuH4=;
 b=gkBeLgwgi0kWLQw4SrHBuzP6C5GcJlZ0kPz04NWMt9IW5k33xh1c0Dp86rs2XD182i
 waMVN2dYkP/Loe/w9QtoveG31qkhN3oxJUMh6hWJxXRAaxjkj7Ly8cAW7lpt60vNPbSd
 Hd7d8L3On2yqHuz88H0VHX//6A2mABSdweyH5LYeoo8EuEvULndCvi+VBq+jz7uyho6Z
 sAYNUVcFK1s3MDckNfgdIZniMdva/xc1hBm2c/h7Bqq3FQ7V4pH2BxH3Z7HB5TtTp9q4
 e+Q7XYrqyUk4BU4IdAKc3nnpaDGcsWquaGNhgYSSLG+Q7pQXjYSqkpURzAhlcBlK1i8I
 +guw==
X-Gm-Message-State: AFq9FYLk5NUoKH23EKpKIZ0wrpkuhy3sOoKIXIiOLlLnkXM4SuV+wVcV
 8qkyprZgwGzFEg9tk0LAt8VfNIbhGKXbkScOKHaHB4WwWWVTiCYABh+G
X-Gm-Gg: AYBFou3F6k6akcAB1RpF5vI8wfurFsG7y1ZHHrmrg0vOg0S8oZnjktOQrYUyGB2yTYt
 VIs8OJiErGU29aMjtU6DpPSoi3sf3BeamOOXCcynlUyrEBaqcEW1g3fx3OwAzjMHw1yBvhzBtbF
 ZHrpEIRZkS1PKVxRtrVCLkmqdvfjw8Bx+WdfYF3gF0X+1f25WCYHPZB00rtFxiOlozzwcliiNDx
 6O2++tqwLziW2MYBZlkWfSAJWs0HsIfDkMVruckLbBzdrJg/y39YjwMmiED0LgjvCDFa/eP7oqi
 SZMLjj9vdJFe1eQg2aQsUdaZlbVi2qGzwbjZwnyEwW+MzGmtkWQrYgnUgfpcfL1xweuIsZ9AInE
 Iu601NMPZW89vBD4bMzH1Qqdm+w/5MXBRVXkdvbdmhFCeDu2J41xtWDPU1drrXuVKK1CGsc/XgK
 cqXZ/INdyRYmol1knJbnYUnbY1ssbXlpEqfJdAE+37LllkCDnXammr4TyG+zJ+r8avaF8KtUMn+
 pbHWe2VZpu1h7omGSI4U8JC0p3Ys4C05YDyvYUBQdQfCtTRF/EAVmXTPh+Y9KeJEsZSgxyO3kb8
 bStpb081gvx/ikTR0O/RI7M=
X-Received: by 2002:a05:6830:4410:b0:81b:9d18:75e with SMTP id
 46e09a7af769-844f93c156fmr11118627a34.4.1792507983052; 
 Tue, 20 Oct 2026 07:53:03 -0700 (PDT)
Received: from
 runnervm8k3b6.0aalnwbd4tbebinze20vr1oleg.gx.internal.cloudapp.net
 ([135.119.78.179]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-842a635cc36sm12407843a34.18.2026.10.20.07.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:53:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 14:53:01 +0000
Message-ID: <20261020145301.10110-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-fchroot-v5-1-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-1-63aa6faff503@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback fchroot() parameters
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On 2026-10-20, Andrea Cervesato wrote:
> lapi: fallback fchroot() parameters

--- [PATCH 5/14] ---

> diff --git a/testcases/kernel/syscalls/fchroot/fchroot04.c b/testcases/kernel/syscalls/fchroot/fchroot04.c
> +	TST_EXP_PASS(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		"fchroot() with the FD_FAILFS_ROOT sentinel");

High: Stop the child if this expectation fails; TST_EXP_PASS records a
failure but continues execution. For example, root without CAP_SYS_CHROOT
and without no_new_privs gets EPERM, then mkdir("/foo") can create a
directory in the real root that tmpdir cleanup never removes. Check
TST_PASS and exit before executing the absolute-path operations.

--- [PATCH 6/14] ---

> diff --git a/testcases/kernel/syscalls/fchroot/fchroot05.c b/testcases/kernel/syscalls/fchroot/fchroot05.c
> +	len = readlinkat(procfd, "self/root", buf, sizeof(buf) - 1);
> +	if (len < 0) {
> +		tst_res(TFAIL | TTERRNO, "readlinkat() of /proc/self/root");

Low: TTERRNO still reads the preceding fstatat() error from TST_ERR,
not readlinkat()'s errno. Wrap readlinkat() in TEST() or
TST_EXP_POSITIVE() so a failure reports the actual error.

--- [PATCH 8/14] ---

> diff --git a/testcases/kernel/syscalls/fchroot/fchroot07.c b/testcases/kernel/syscalls/fchroot/fchroot07.c
> +	SAFE_WAIT(NULL);

High: A successfully executed helper can fail in tst_reinit() while
reopening its absolute IPC pathname under failfs, before it can publish
TFAIL through shared memory. SAFE_WAIT(NULL) discards that nonzero exit,
leaving only the earlier fchroot TPASS and a false pass. Use
tst_reap_children() to retain child-failure detection.

> +	if (tst_get_path(CHILD_EXEC, child_path, sizeof(child_path)))
> +		tst_brk(TCONF, "Couldn't find %s in $PATH", CHILD_EXEC);

Medium: Make child_path absolute before entering failfs. Despite its API
comment, tst_get_path() returns ./fchroot07_child when the helper is found
through an empty or relative PATH component, including the empty component
inserted by the framework when running from the build directory. This
tests relative execution and, for a dynamic binary, its interpreter lookup
rather than the claimed absolute executable lookup.

--- [PATCH 12/14] ---

> diff --git a/testcases/kernel/syscalls/fchroot/fchroot11.c b/testcases/kernel/syscalls/fchroot/fchroot11.c
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS=y",
> +		NULL,
> +	}

Medium: Gate only the user-namespace subcase, not the entire test.
Unprivileged failfs entry with no_new_privs works without CONFIG_USER_NS,
but this descriptor skips its success and lookup checks as well. Keep
those checks enabled and report TCONF only for the unavailable namespace
subcase.

Verdict - Needs revision

Pre-existing issue: include/tst_fs.h documents tst_get_path() as returning
an absolute path, but lib/get_path.c preserves relative PATH entries.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
