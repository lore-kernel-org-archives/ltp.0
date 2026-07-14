Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B43C44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 16:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BAAD3E99EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 18:26:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AE013E56E7
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 18:26:16 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AAF9160083D
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 18:26:15 +0200 (CEST)
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so959814b3a.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784046374; x=1784651174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AhZurK7SFHDW/41iG6OXT+Lyflf6movLHAenJ6QhvdE=;
 b=RgUj3xtUsSv5FyQzSXdUQdZh8L1OLpRUgl9GSUd33/+qeIn+Ypzl9OXmDAH6yhgUfM
 dmH/qRjGlViAT+TbnYYDl2OQzaunM+9cVI6rMW08YADR29ULQAOAy+ufNMlET9AnYKdu
 xAJUF1ok/zle0zqms9PxBOmZbgR9TilSjMtHCAmmDQRvCnn39E969oqWBWDMYWpVD76B
 UBu9oFYb+JMo0v5EK9IqCcCeFhxxcjSEaosk24hiFELqNcTBbm3O7i66udtN2QIXVwwP
 xEaw5W6YsPRuS3axPUl/52X81COlTLVTXMdWmhE8+Wi9EnPNp3QHxW/9ZrjKNoF15EZe
 ZO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784046374; x=1784651174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AhZurK7SFHDW/41iG6OXT+Lyflf6movLHAenJ6QhvdE=;
 b=kX3tPuDiSbaPGCaqjJ/hGQaQBQ/BB6/WKLnB9l7KtR3XeRfz7H9ciHAcUDqxyu9vZL
 apOc0Z9C2FNfoF+OX43kR4h5tfYb41q/WYIy6NZ5plr6Cgt5syg6Ypj9aTtBVlY2NO2G
 AmB785ki+ep2y0jcAZaLP7ogMH7MGQp+2b4pZ+FNIall4OPVUckJPFClmGinnHeRUW/Z
 xoScxAn9OfqATGxbk66KrZ64w97tIrjkbNZ98wwgig8VIFDw3ZWCA4NZMXi0UXcvQsiR
 ahLqBRh5gv3dFJO/AKCxPLx2ERGmj5QkR2dHmcFV00wyn/+E07ic7sNWAzEzw7l9rm2U
 KSXA==
X-Gm-Message-State: AOJu0Yw07Kucyot47xs7RVtcP9OjOgbR6WtGENiw5M1eXDJ33j7hz39L
 A9cAc/UqxvNczN2IRUYwo/1xakfNL1aVvxFHNV4yN04APAvz/4zKd8TC
X-Gm-Gg: AfdE7ckjS0vmUfn6GOAEEF2Y27yridj4ILMSKD/j42FRZogGI3OjjmZiP/9XIhHgP6Q
 KzdgP4xfrD0enmUN1JIUS2MvkD+ynz7XfU+YSR6wTG38kq1A1s2tbEy3RESog8DztGICHnoNcE3
 L45pygKuTL6IkNPgYEM3tip8exqRL+E+qsoP5J85wDIRLAkOJc9QsmBsaDa7YBTLKNxfHMoEgVx
 gMl211eybKa3wTErSGDZrA4y3EJcI3YBfztCprmUuO+NE7Lr7Wtwl/VFwaesklZ0x2hTPcdZbwA
 C0gFM5XCKHdBt1l0pnJUFSTO+L3AGQe/l/8Qurt56J+qR3l409qcoBacJVnnNdt0N0iZFklE0xA
 +T8lwvIzkPGj9xKMTJHnHZ0uNonWbXNxZxNKdeOturkfXKKVEaUD37wPqHS2P8z+dN9FoizMU5b
 omujDA3xmQuIDm2XgiALHt/+msVtydQmmfKE7lmtvGtLt+WFbJO5kysnNnkTVGMpdyMR4gXMz7f
 Ax7UiPFz6wxtbrOHX9GuiQ1ceGi+w==
X-Received: by 2002:a05:6a20:a10a:b0:3bf:bde7:d67e with SMTP id
 adf61e73a8af0-3c0f0bcf127mr22130082637.32.1784046373818; 
 Tue, 14 Jul 2026 09:26:13 -0700 (PDT)
Received: from
 runnervm5mmn9.1xlrnzp2busulcmx1tuvjmdqng.yx.internal.cloudapp.net
 ([57.151.128.192]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b8a5992c9sm35345027c88.4.2026.07.14.09.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:26:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue, 14 Jul 2026 16:26:12 +0000
Message-ID: <20260714162612.4256-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714150631.250972-2-japo@linux.ibm.com>
References: <20260714150631.250972-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Simplify to focus on CVE-2017-1000405 race test
 only
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

On Tue, Jul 14 2026, Jan Polensky <japo@linux.ibm.com> wrote:
> thp04: Simplify to focus on CVE-2017-1000405 race test only

--- [PATCH 1/3] ---

> +static struct child_state *child;
> ...
> +	child = SAFE_MMAP(NULL, sizeof(*child), PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS, -1, 0);

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.runtime = 150,
> +	.forks_child = 1,

Is .forks_child = 1 intentional? tst_fzsync_pair_reset() is called
with thread_run as the second argument, which causes it to create a
pthread via SAFE_PTHREAD_CREATE -- not a child process.

tst_test.h: "@forks_child: Has to be set if the test intends to fork
children." No fork() or SAFE_FORK() is called anywhere in this test,
so .forks_child should not be set.

The child struct is also mapped with MAP_SHARED|MAP_ANONYMOUS.
MAP_SHARED is meaningful between a parent and a forked child; for
thread-only use MAP_PRIVATE is appropriate.

> -};
> +};
>  No newline at end of file

The file is missing a trailing newline. POSIX requires text files to
end with a newline; `make check` would catch this.

--- [PATCH 2/3] ---

> +/*\
> + * [Description]
> + *
> + * Verify that direct writes to /proc/self/mem are correctly rejected

The [Description] header is deprecated. Remove the [Description] line;
the RST block is treated as a description by default. See c-tests.md
rule 18.

> +	memfd = SAFE_OPEN("/proc/self/mem", O_RDWR);
> +}
> +
> +static void run(void)
> +{
> +	int test_val = 0xdeadbeef;
> +	ssize_t ret;
> +
> +	/* Seek to our test memory location */
> +	SAFE_LSEEK(memfd, (off_t)test_ptr, SEEK_SET);
> +
> +	/* Attempt to write to our own memory via /proc/self/mem */
> +	ret = write(memfd, &test_val, sizeof(test_val));

The write() here is the subject syscall and its result is being
checked, but it is not wrapped in TEST(). c-tests.md: "Subject
syscalls MUST still be wrapped in TEST() or a TST_EXP_* macro --
never called bare."

Use TEST(write(memfd, &test_val, sizeof(test_val))) and replace the
ret / errno checks with TST_RET and TST_ERR.

> +	/* Allocate a read-only page - writes via /proc/self/mem should fail */
> +	test_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,

The comment says "read-only page" but the mmap uses PROT_READ|PROT_WRITE.
The page is made read-only by the SAFE_MPROTECT call two lines later.

Also the blank line immediately after '*test_ptr = 0;' contains a
trailing tab. Remove it.

There is no entry for ptrace12 in runtest/syscalls. The test will not
be picked up by any LTP run until that entry is added.

--- [PATCH 3/3] ---

> +/*\
> + * [Description]
> + *
> + * Verify that a parent process can write to a traced child's memory

Same [Description] issue as ptrace12 -- remove the deprecated header.

There is no entry for ptrace13 in runtest/syscalls.

The blank line after '*shared->test_ptr = 0;' in tracee_main() also
has a trailing tab.

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
