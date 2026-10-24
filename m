Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE83606A31A
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1N81rup
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA82C3CEBEC
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 16:21:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74EAC3CAFDD
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 16:21:30 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E450D1400156
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 16:21:29 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so1719630a34.1
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792851688; x=1793456488; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cFerFQhvvm1PoF6PYHyIVUsObFd0MjcLwJaRAyagxNk=;
 b=O1N81rup4xAqqjW4gXe1S73lLzkD2IrWOuATd/6vAXl7WOlY6afPlCD6mK43oWaucx
 fKuSgiUx8leWUenKORVmaRx1wapNOwbKUYxia6KfWpVstzj9y9Wp+gZtTo9ws7FckKLq
 jJJX045we2aTFGWV1KmdV9S6iQ6CLLbVkAYDLzqPGDcvb7f1THUayApO/IUcoLxmbToP
 ltg+g31QX5BGRzoUxFWZXTmFeULkkpSXPsCOStbT/N8t/cXxV/MB80B7nfK6bDJLfSjm
 g4bZj7W/Dcg7WzbGwFn11N05WF9jwqIargylq970dm0uLZYtYRili3zjSq+NjnapHh5u
 2FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792851688; x=1793456488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cFerFQhvvm1PoF6PYHyIVUsObFd0MjcLwJaRAyagxNk=;
 b=mnxA92S9c1+RPFUQWOzB/KnfV3Co5BUUcIOJcBtFfJJMKFg9fL+wngxB8MR2eiEDZL
 Nx9yx0Gjmn9BZ5+QbasHufFfnjQOyP7XZMAciWNwUnfdfBCZPAMng13bVQEyYAx8bAaW
 wkzBXU8gW8myg2fzvCvx8dt7ady17n+NpfQWIKOht6TwdqUGMI9nc08ebvPD+Ab9cJRr
 CiUC+uvBknvKQed83SEjXEOrOY2MtjDLvcMIYE0NKM7LPTW1lhivMc8RIryr8jTH/Xw0
 qAgEEy5KUcjEKe6/AqaLnyVIzymN3fV+diwoSoytKgCeb/8GZWH+j8fuIQYVj/8sXN1H
 Ko7g==
X-Gm-Message-State: AFq9FYI2V0pdz2JYPGscHfu2E4Tp5H+m2n2sJv6LunAphgP4rvL1EJOO
 A8B38Dknw6kHwaUPcd3QkC6hnIrkCoeMIShuBcgtMfzmyeNdaLjsu/xT
X-Gm-Gg: AYBFou2ooJj1SDZ1piE9BPwwypHZAT0CdGJhyBOUulq68NkjHsqDjew3GC1UHSXvDe5
 YSE5MgatI44sEOHvCNOcAUnLwTe1YB5aP4NaM1QnmtxTxgLK9zvDV7hOXRYTG4+7CyvtveBZTHH
 kVwJx94eC1dIEDA+z7xCw+M+9mY2vM8fXADQKQajdyA6Pat4x138gWnYlGYiO4B2r8y7LiZ5T7x
 Mg27G5wFwSqmYhcdHafUkwb+SB7QKOTG/iD2yP2/Xyd5mlyg86YAZXDOK4j+KVi1+wDuz5gGRlI
 YAlOo04Z+L2qqY4+bIslAA1NHzMrybmlNtdkMYMBCe6sSlaHhX/1c+65JVgZuuYM7SwRX4dGOND
 qJPT3QGG5bbYnqxpXgQH+DtnqO8NZEdJWsUhfPEmagUkmIObHzIzLxUQk2xeZAGuyjY8o2RY+3D
 nG1D6DW63TpqNhGXj1EAxe0vsaFLkcb0Nd377/QxqJmzQl35rns0VpjxCC232mnORZRzBTFSaC4
 D7sQz8ZaMQFyHptuXLrEgN2T6dnmjMbC87bHSK7kBml89HtbtEpO86Hg+LD825gyNfZTzEvkCwt
 XK0qvz38iZ3BT78lyABAgxdim4Bp318hSzP+gddLD1BQohFil7LGJ+KxnRjYz3AHZA==
X-Received: by 2002:a05:6830:4426:b0:81b:65b1:504c with SMTP id
 46e09a7af769-850fd37acaemr1776405a34.9.1792851688393; 
 Sat, 24 Oct 2026 07:21:28 -0700 (PDT)
Received: from
 runnervmtai0g.x3ic44oqlxiurgd5tba2tdgpng.gx.internal.cloudapp.net
 ([9.234.23.48]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm2439840a34.24.2026.10.24.07.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 07:21:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Sat, 24 Oct 2026 14:21:26 +0000
Message-ID: <20261024142126.9085-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024120743.583665-1-rbranco@suse.de>
References: <20261024120743.583665-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
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

Hi Ricardo,

On Sat, 24 Oct 2026, Ricardo Branco wrote:
> userfaultfd: Add tests for UFFDIO_RWPROTECT and UFFDIO_SET_MODE

> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
> +	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
> +
> +	SAFE_CLOSE(uffd);

High: Closing the last userfaultfd independently restores permissions and
wakes faulting threads, so this test can pass even if the unprotect ioctl
returns success without resolving the fault. Remove this close and let
reset_pages() close the fd after the reader resumes and the handler is
joined.

> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP);
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP);
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP_ASYNC);
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);

Medium: Both tests skip with TCONF when vm.unprivileged_userfaultfd=0 and
CAP_SYS_PTRACE is absent, although these accesses only cause user-mode
faults. Request UFFD_USER_MODE_ONLY, or enable the existing retry, in both
run() calls and the feature probes; check_uffd_feature() currently
hard-codes retry=false too.

> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
> +	SAFE_IOCTL(uffd, UFFDIO_SET_MODE, &uffdio_set_mode);

Medium: These are the ioctls under test, but SAFE_IOCTL accepts any
nonnegative result and reports negative results as TBROK rather than
TFAIL. Use TEST with an explicit zero-return assertion, or TST_EXP_PASS
with appropriate failure control flow, for UFFDIO_RWPROTECT and
UFFDIO_SET_MODE in both tests.

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
