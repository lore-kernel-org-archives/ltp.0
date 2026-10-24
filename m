Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C13606A31A
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BY85C3im
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002C73D0F88
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 22:22:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8B03CAFDD
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 22:22:08 +0200 (CEST)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 540D71400326
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 22:22:08 +0200 (CEST)
Received: by mail-oo2-x05.google.com with SMTP id
 46e09a7af769-8458555b6a8so482850a34.0
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792873327; x=1793478127; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qmkHMvyp4o9npYVqUpr6neV8+gbg+HFiueWtYGPpxDc=;
 b=BY85C3imbNV8V1UDFrB0M33KznyKlaNstTp6Y6Teo/jlpo06h2YaG8BeCzc/TxaZKW
 5DZ6f2sfu9KqZKsEa1fnmVRCnguid6mzFwy2DpiJOWJOqwHu/MS+sXP+rUznLeefok3J
 LvFHwE9cv8yWOZy+jGfx8v68/brvoI/hX7yD8RGu1Xyeb2ZMp3qDzz4rVJ+7Ycv483Vg
 hRg3O40rtKo8omIX8CDuIUZMH0Qf8bGTlFKv+uDEnxHWPg8+Uh8GEvSHhcxEAEFGEvzN
 kfOd6TSmuBJtQSqQbsN5iVSUvoP2ORMhS4IUoDEp6/wTz09SBNjkXszzQneopVLkzmN6
 bFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792873327; x=1793478127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qmkHMvyp4o9npYVqUpr6neV8+gbg+HFiueWtYGPpxDc=;
 b=kBy/0j4V2UnJCMJUhukNNwuFmCY/GZLMpMOkeF/xV14WmbbMRMdpEhaIa7vdbNiZbd
 vgBCvH/aiTKDUBChvJT3kdn9wR9wCzyuSN+G/Uo5Fgfyj07W6du4pitSn2tdRbPK5jZC
 e7SLmFE6G3s0zKtdkZKR0bkhoNj9T/38e9ArTM88f5+4ikpTLkqN7VRKaIleNA12xqWT
 igHEYwa7jojDp9IcVrN+T9u/b6SihW5aRbePS5nh/tPn7Ab5MoZ0qj/79zbHe/JIYp8I
 P0yjJYzVYRBt8zp+i14pT3iiA20d9x5rDRK8PVtXV3hVGArumBV4YqRCo1+yZIPdiwcS
 ODPQ==
X-Gm-Message-State: AFq9FYJz0NTTNFAHMRZm6u0Bquz5KFYOzZsRZRH8KWApnQq4XRMVxXDh
 FbT6Ocxpq/lV2d8H6jT76o/02rHU/cB1f2ai6ii00Zv8oVghuVDPF81V
X-Gm-Gg: AYBFou0lsd7dZwoyDY/WdGNv4uLOOm0QHBYoM12FbPeMLMKwtFnS6acwWBQN+vqEBaN
 nnReCVZuaUFoNGoHnujI69lzPLw6n6b8aX3TfGLZQ6hCUsQE+Uq3T+UeR0iIhGkEFVZhf4mhmME
 EbgmVUd1kQ9/nlMV+KamnBV+erAFkrLKGez1JDdRtjaLb0SdJknk2toZzzziZbzZkaw9pHEnMRF
 lD3qIeFe/TVyy+60VoLWamZfU0hcM+KSqUNMad1+RdqcZlXb2+b3gv4jEmQ9FPnBJBFQNUoKuu5
 UenDPF3OgXSYcyjEEOt4pIJsQGPRtu8s9OqtJDbpCAlUrgI5dfdfzMWb0WVBHNcrsni/ka0enSz
 kbMlKYU+5433XHo1ButccT/6+G5H66vTWwfCr0oMRMmGQUjTeMSUrjL5kPl0zwCc1W1GJHaDd/N
 ES8NrEdT/QPK3At1gg5IDIXYB73Pkg+flb1csVDFUtDWk4JWLNd2p6Cc6osNc9yC9X5DA9g2NLT
 fFaX6iKu6YXzeTLYD3zUDzUWsrg7h5YCj9OzkKTlzgq55XBTqH5ZJ+t1bsojZuGDL0RvXSEMDh9
 RvZBpaQ/2nAFTHTrG63euMO+fTF2V4cdxJFbLHLptk/WK2nOPBoSNYAWS3W9PYERBoH7
X-Received: by 2002:a05:6830:438d:b0:821:a94d:3b51 with SMTP id
 46e09a7af769-850ff6814eemr2148953a34.25.1792873326754; 
 Sat, 24 Oct 2026 13:22:06 -0700 (PDT)
Received: from
 runnervmtai0g.0rdrhlq1m1iu5ibr54o1m1i0sb.gx.internal.cloudapp.net
 ([74.249.190.49]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fbb25f59sm3047856a34.20.2026.10.24.13.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 13:22:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Sat, 24 Oct 2026 20:22:05 +0000
Message-ID: <20261024202205.9296-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024180654.623705-1-rbranco@suse.de>
References: <20261024180654.623705-1-rbranco@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
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

On 24 Oct 2026, Ricardo Branco wrote:
> userfaultfd: Add tests for UFFDIO_RWPROTECT and UFFDIO_SET_MODE

> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP);
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP);
> +	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP_ASYNC);
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);

Medium: With vm.unprivileged_userfaultfd=0 and no CAP_SYS_PTRACE, both
tests report TCONF even when RWP is supported, because CHECK_UFFD_FEATURE()
and run() request kernel-fault-capable descriptors.
These tests only need userspace faults; use UFFD_USER_MODE_ONLY or enable
the existing EPERM retry in both the feature probe and test descriptor
creation.

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
