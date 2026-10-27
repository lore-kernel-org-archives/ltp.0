Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DC606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cVXqEZLs
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8EC23E11AE
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 00:20:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 110283E11AE
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 00:20:32 +0100 (CET)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 164362009CE
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 00:20:32 +0100 (CET)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-533fe730856so151162b6e.1
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793143230; x=1793748030; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tx+71QVIXfIzzc0xyzrvoLlcVfeU4sT/1qnKz3TGMa0=;
 b=cVXqEZLsV4J7fRlw+T/uuZlIDF1AoUBeE2yb1WtuoU5CFYBrEazfirkrmjtyc5JT0y
 nZq+pEKldyFjrkq2eZGxAiWdFPk7lIy5erj04pnEubxxhbwLZaErTbt74FNY+uiZ8r0V
 b9xYfcKH06xTMK7witLefNRfky2hy/hLJy0P8+mhZReo7IHwFaDZrdETtR7UdiF2z8OR
 Ear2naqCsdQGZElM931j4hlBFhi+HXxOFMWydLtdbAGorLEOQQw6+a377F1gNniaM+0X
 3uP2EPpR4VMkW8FeFZzBzesH3nv6pCyBXF+0zvCm5k44uWRN23tf0QuUkPrdas7JiMFj
 x20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793143230; x=1793748030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tx+71QVIXfIzzc0xyzrvoLlcVfeU4sT/1qnKz3TGMa0=;
 b=enQfFxfLXcPS5CShvIHhBPAklqIPfeI1YEPG6jQJ+zVJlhwzaAoLd5ZgwJsyDF5VtD
 jf3UDeafRCEK5qjfBlkUqB4oqmoUQAdXGcRGI1b0ds6PxHilpx4faQYxYod/Thfiodnh
 cRDJ1Zw7V35hdMKf7jRyvlgad29XNtW2JJS7nK7NAPaLFm1JdWkApQlynhte3+/LrSI4
 gpf5HK0SiPElR9855EUQVetZV2VdL412zDOwezAOmrQh0kjygjNOZXXe8oapN44nMVJa
 NcD7WtZJA/ID5qv03XU96BLjViCYXvGG5oV4FRg8rc34M5iVW0wz7C41touSVJfjDt/w
 THiQ==
X-Gm-Message-State: AFq9FYKSwlrAuwhg3RjfUtpn4RAgMS/SOblc7cMhtL0y93/2iZKrr300
 E+rgsSV6JeUi8GdILliq8Jyar1N3+3TGO7nZ4KTWJsLVS2IVHkqHjGPA
X-Gm-Gg: AYBFou3E/1+I4UH2e8Lpx6356eK6A1AWSBU4TgVPbTbX8RkQZyFLumIcu+Fa+bzjFbB
 b2Vb5tHKERARW+9Vanujd8KVuEu6hiiAMfoU9IkpcMrQYnSA9UQsmaew8aQGowWAbSOey/JrL2j
 0FU/a48Wc9NI1R0BX/N0mbr2BQLXwO0a/A+OvlrUT6Ge0266XU0JdeUOs5CdJyQIhsOrIFoo2ZG
 SlABmM83Y3uFgwAdfVYLWRfNItZQxpuWLryTmcKzDHNEPaUGJheuwcgMG+grFEyipknxl5UlVvA
 ZjXAcqaX74sa0BPgJDDNbbL1cvFbJC9XL2ijId9O7FNFKGaTZ0aPRoGA/wvQpB5Rc9pbokfaloq
 ZIw6vTOWX58wO9bGW6aZl3QBXBFWSTWsnQiK06OZAsyASBMN2meahAqfw5vK5pCJ2fh6JcdNSWq
 YfT4M0qYtaCzaokhIwE/mZ1uoem3aPjVfT0YuwajmH5mgO+ElaeLjzCNUL9Z+VbwFS4tg+YlyUP
 wZ6AqHxYuibg0HeRxT6S2CtFRqqeu3FInEMfiZ5ZpgMm5Cl/fJI1PtSl/nDKXqqsmFeZS/PRCDN
 qRsVtAsros9zrNm480k7W8qr2cG1SZ7DNk64E8KexmwP9SPXLF2htr3sMJCZ9c2oSsDLkQ==
X-Received: by 2002:a05:6808:c40a:b0:4b9:e5fa:8905 with SMTP id
 5614622812f47-56382681ba1mr513651b6e.24.1793143230380; 
 Tue, 27 Oct 2026 16:20:30 -0700 (PDT)
Received: from
 runnervmtai0g.h4y5e5wkedoedp1mjwl0zuzagd.gx.internal.cloudapp.net
 ([172.202.54.187]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b793fe7csm1147029fac.15.2026.10.27.16.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:20:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Tue, 27 Oct 2026 23:20:28 +0000
Message-ID: <20261027232028.5693-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P4yrQBp--N-9@tuta.io>
References: <P4yrQBp--N-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/fanotify26: Add test for nested permission events
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

Hi Edvard,

On Tue, Oct 27, 2026 at 08:37:01PM +0100, Edvard Conrad wrote:
> syscalls/fanotify26: Add test for nested permission events

> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*\
> + * Check that a permission event on a stacked filesystem does not deadlock the

A copyright header block ("/* Copyright (c) 2026 Edvard Conrad
<edvard@tuta.io> */") is missing after the SPDX license identifier.

> +	if (tc->mark_backing && filesystem_mark_unsupported) {
> +		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported");
> +		return;
> +	}
> +
> +	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +			   FAN_OPEN_PERM, AT_FDCWD, OVL_MNT);

Both test cases use FAN_MARK_FILESYSTEM on OVL_MNT, so gating
filesystem_mark_unsupported on tc->mark_backing causes the first test case to
fail with TBROK when FAN_MARK_FILESYSTEM is unsupported on overlayfs or in
the kernel. Use REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_FILESYSTEM,
OVL_MNT) and REQUIRE_MARK_TYPE_SUPPORTED_ON_FS(FAN_MARK_FILESYSTEM,
BACKING_MNT) in setup() and drop filesystem_mark_unsupported.

> +		fd = open(OVL_FILE, O_RDONLY);
> +		if (fd >= 0)
> +			SAFE_CLOSE(fd);
> +		exit(0);
> +	}
> +
> +	/* The opener sleeps in the kernel once its event is queued. */
> +	if (TST_PROCESS_STATE_WAIT(opener, 'D', WAIT_MSEC)) {
> +		SAFE_CLOSE(fd_notify);
> +		tst_brk(TBROK, "Open generated no permission event");
> +	}

Use "if (fd != -1)" to check file descriptor validity in opener. Also,
SAFE_CLOSE(fd_notify) before tst_brk() is redundant because cleanup() already
closes fd_notify.

> +	reader = SAFE_FORK();
> +	if (!reader) {
> +		answer_one_event();
> +		exit(0);
> +	}
> +
> +	if (TST_PROCESS_STATE_WAIT(reader, 'Z', WAIT_MSEC)) {
> +		tst_res(TFAIL,
> +			"Listener blocked in read() by a nested event");
> +		SAFE_KILL(reader, SIGKILL);
> +	} else {
> +		tst_res(TPASS, "Listener answered the event");
> +	}
> +
> +	SAFE_WAITPID(reader, NULL, 0);

Inferring TPASS from the child reaching 'Z' state and reaping it with
SAFE_WAITPID(reader, NULL, 0) hides abnormal child termination. Call
tst_res(TPASS, "Listener answered the event") at the end of
answer_one_event() in the child, and only call SAFE_WAITPID(reader, NULL, 0)
after SAFE_KILL(reader, SIGKILL), letting the library reap the children on
the normal path.

> +	/* Releases whatever is still queued, so the opener can finish. */
> +	SAFE_CLOSE(fd_notify);
> +	fd_notify = -1;

Setting fd_notify = -1 is redundant because SAFE_CLOSE() already resets its
argument to -1.

> +static void cleanup(void)
> +{
> +	if (fd_notify >= 0)
> +		SAFE_CLOSE(fd_notify);
> +}

Use "if (fd_notify != -1)" instead of "if (fd_notify >= 0)".

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
