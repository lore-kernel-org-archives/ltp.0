Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B16606B47B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLUfm6c6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89AC3CEE80
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 16:59:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C013CEC3E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:59:00 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22692200AEB
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:59:00 +0100 (CET)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-84e513877a3so803268a34.0
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793894339; x=1794499139; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N8YvS+45FcrfIPl90uFr96ja1up/UIlaSS5OJI0uWls=;
 b=HLUfm6c67xH38WpbPMdXsHAlSHAl8ePJ+haQrP5ZPxbmNZZYuX1sYSU980bc6jik9B
 6dqZOVrlwnfLZvAqQCe/pSAmP0AEBTGWoYuQihknj1EidnIwMPsGLEbqwg7Ls1zOu74C
 JCcXEkxvXkLDoQmsNXykkTCa+sGBmkPBcfBisYuAd60nd26AdeKx0G+Wkz9g1s1AOxA1
 ceUenaE+HHjmym98wjJn+wqBC3DQjLGzlBgWUzVFQCSHl0ewifI8qGLIw5U/JvYMAdA5
 3omDrLbEgTu6Ukhc3hTEEtY3jHIMYzSr2x+FFMr2J6x46LaKLJeFsHCHBxk38gdITAou
 /9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894339; x=1794499139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N8YvS+45FcrfIPl90uFr96ja1up/UIlaSS5OJI0uWls=;
 b=LhxL+uhpVRsnTfdyVMh2HCUXljuI878zgJ262Ls9pESCjzBg+MfNWM8q0zG9qvA27q
 BTeAk+QJyyH4qsMDY7N+PfB5CoiKo/vNnp0VQe3mX47rXmzfHbtR01qRzWsSmuJNiXAW
 ajHgpkR5CLWckwWdmVdxt5XWC0h83457buWOHJiBCOLgrF52VYMJbXtlMsKiYEcCX+o+
 1HJ2c0dy6YV32boSSc79d6KdKb4BqIvMWMmnPbaIAdlK0nuqWd890qjXraRaMY2tRD6d
 M0bph6aP3WOr0J+EhJpUD+CNr9z3a6DTLFqF2wrzm0cDRvB+2/rzOPcB28W3AY6yNR4I
 Ch7w==
X-Gm-Message-State: APuU4Z9mNsdiVIvqn9+rW3I4xUfqZqP7n8AbS28KRmUN9PiviimAl9wP
 j4uadkIxCw8JoKfnGQX+OAVs/tSM4lV+b9QaPnecJRJSfUt/PXrdsDwY
X-Gm-Gg: AYBFou3hFeH5ioapt9nQnEA3hdHQwjRFsdtSCk4rE9Y6Vdj6Ay/98OO09alH4rRyDGg
 vFPModEtkO+u8E/JKTmbPh+FknhMOMAe92GtP7cdcI7TwyXfyWnWU8isrMg0Jo4QHtb+YCCevf1
 /aOEEotswG+4F6rjssDop+0xXqWt9rploru7ZQAKelEh5fuop5aKVoOtLQgJJCWQnzLbeTMTzCT
 vUxp7wiy2wW5QTUBFmeEOMIXxGfiSCg4dcTZc4vjGfMdxCJ1dSmFNPHa30q6jM/J4pAxLsIBit+
 hHHLYKwvlSR+V3pomyTFSh+NNMP62QqA2A7YxsBuw1Y+HLdHItmP+CJYoTUMgqTOX2KT78CSPPg
 56t6z8u4A+YvXF5jV1E4J7enMiC3hsm/NDWQcBJKt6ycCgxV00IxpCJK9yRIByra1g5jTXj/dIP
 nLZ2VWiD7tqI5SNOdAxzo0Wdo8UOsqSQBwQ6QFi1Aiqvf2mhnh9MBtjW9sJgNqo+gReWcpdUf6Q
 SkoQEuxUiZT7Av/FMwADPMmxPeApP0yNyMj3y2M/j7So3KrsnQJguc/YBVLBpKoekEpf11qcP1J
 Gu1WLnHKkxIUgVdXCtcGlXOU3LeGqg5bm8RTgaYR1RY7l6/j+dbZ+m+q359mzSvT0/SG/Bc1Qst
 0G2PVVWxSLY9zhZILcqePPmfzLx+uRvGpqW9MctkIhA==
X-Received: by 2002:a05:6830:3499:b0:845:614b:eab9 with SMTP id
 46e09a7af769-85f0586344fmr1920277a34.6.1793894338730; 
 Thu, 05 Nov 2026 07:58:58 -0800 (PST)
Received: from
 runnervmwuk1x.zdxfk0epy0qenhu4rggsnrmaug.gx.internal.cloudapp.net
 ([52.242.217.91]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3a1a6c8sm4814536a34.2.2026.11.05.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:58:58 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen_ky@163.com>
Date: Thu,  5 Nov 2026 15:58:57 +0000
Message-ID: <20261105155857.3662-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105104617.996224-1-wangxuewen_ky@163.com>
References: <20261105104617.996224-1-wangxuewen_ky@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/cachestat05: Add test for permission checks
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

Hi Xuewen,

On Thu Nov 5 18:46:17 2026 +0800, Xuewen Wang <wangxuewen@kylinos.cn> wrote:
> syscalls/cachestat05: Add test for permission checks

> +/*\
> + * Verify that cachestat() is only allowed on file descriptors with write
> + * access to the underlying file.

Use :manpage:`cachestat(2)` when referring to the syscall in the
documentation comment block.

> +static struct tcase {
> +	const char *file;
> +	int open_flags;
> +	int exp_errno;
> +	int needs_fix;
> +	const char *desc;
> +} tcases[] = {
> +	{FILE_RDWR, O_RDWR, 0, 0, "descriptor open for writing"},
> +	{FILE_OWNED, O_RDONLY, 0, 0, "file owned by the caller"},
> +	{FILE_RDWR, O_RDONLY, 0, 0, "file writable by the caller"},
> +	{FILE_RDONLY, O_RDONLY, EPERM, 1, "file read-only for the caller"},
> +};
> +
> +static void verify_cachestat(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int fd;
> +
> +	if (tc->needs_fix && tst_kvercmp(6, 14, 0) < 0) {
> +		tst_res(TCONF, "cachestat() permission check added in v6.14");
> +		return;
> +	}

Remove the kernel version check and tc->needs_fix. Commit 5f537664e705 is a
bug fix already recorded in .tags, so unpatched kernels should fail and print
the missing-fix hint rather than skipping with TCONF.

> +	SAFE_SETGROUPS(0, NULL);
> +	SAFE_SETGID(gid);
> +	SAFE_SETUID(uid);
> +
> +	fd = SAFE_OPEN(tc->file, tc->open_flags);

Opening FILE_RDWR (mode 0666) after dropping privileges means the caller also
has write permission on the file, so the FMODE_WRITE check in
can_do_cachestat() is not isolated from file_permission(f, MAY_WRITE). Open
tc->file before dropping privileges and use FILE_RDONLY with O_RDWR for the
first test case.

> +	fd = SAFE_OPEN(FILE_OWNED, O_CREAT | O_RDWR, 0600);
> +	SAFE_CLOSE(fd);
> +	SAFE_CHOWN(FILE_OWNED, uid, -1);

FILE_OWNED is created with mode 0600, which gives the owner write permission
and satisfies file_permission(f, MAY_WRITE) in addition to
file_owner_or_capable(). Create FILE_OWNED with mode 0400 so the ownership
check is tested without write permission.

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
