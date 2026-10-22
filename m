Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138B606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mtC2tnGl
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629DF3D26C8
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:35:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009AF3CFE58
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:35:22 +0200 (CEST)
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F27F600840
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:35:22 +0200 (CEST)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-5187c752f46so735364b6e.1
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676121; x=1793280921; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KV5CUGTV5lfc2CR8MneWtR8MLzewLkJ16kpt492PgyE=;
 b=mtC2tnGlS3du/KDFjonla4UZJ+BIR42xrT53j65+GqJEtOtG8VKhhi6XBYxS73Td0e
 9hK5psfuWSmfng+KLvFstAvn458IJuhkknIW9xi0lQ4NVzQqWrAjEpzVopcSyUQFscua
 0uk3SJxeF4d5PX9Fuwx0Faxu9EeGQzlbPQVzWFxzA9IYHmyjPAy4mc+Wrh+vgLQO/eQj
 fdHrRK2pLV77LwkX4ksjRjZnY8na/u2k7OiDsijvLTY3DM6I7PMmgJ0hpZWLLH+fbr9k
 t6+aJ3b3iDrGEaBUjaOPtX7m/sVBBzXyh/+y0a4wtHz5J6ASnn6U9GB2g5nMSVgg5ZLa
 wXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676121; x=1793280921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KV5CUGTV5lfc2CR8MneWtR8MLzewLkJ16kpt492PgyE=;
 b=2NKYupED4/Zc3RX/MP4to99vp/B9ETcWloaOtPzquFROq9cHbjd+O1WbmZjeoUdAB2
 qnKk8JAlg5K8BVzlQA1UJgmrKLepyWzo6hhRa98Hcc/cQ8okMTLbokRJdVb6fFyAkGr6
 JGglbxY9Z9Dsrh8a81I33pjv3VW9h1vKHSJB5TUbur6H8xrz/ziujXEByQTBPUV9q1QO
 ZF7eaOkdHx2bW1DuWTO/PnEoFjPD4IIspxYced5kX/SKdFrS8Mq3/HMY0RhbYWfVeYTR
 QbP5iOmIQ1kF0E8an2P/U5FWz0R4CfZLJHeo3O0xMo9D8d6zid4CnNjP5vW+Fkgtne4t
 zP8w==
X-Gm-Message-State: AFq9FYJn6xw4EpERv87X3+HGmQGGQ325+P0wQrd9M2VJ2ONxxVIvkVb6
 riJPa8+4iAE9bx6dOFq9QhlbrvT1zpGqzyK+eIz+d11IkfM5ldQOi2I1z1Buo2UNa5o=
X-Gm-Gg: AYBFou2RhlvIrykCHtqBwqPalhk0pSsGKCqT2TRh5WU3+SKDN7fDUvVjQUdXQaP+B7l
 KA4HM3YmpTBEFWyGinXwt6+6MCX7RdnH6T7XVQX2BR4/H4Md6KuALUqo1dUnpfBDZrNCvY/9LIR
 XFbtUz4fLTSjhK4Xf3NSwuAR8iqjsAd5D3V/qICBQAEqevjax5zSnP9t6tPjTfF6j7Wg+w1Lv6d
 OBfv+tRvkgUoLE5x/0SJX4UFOMF1Y4oMbwttC7IMyDQfewbCft8aibsPakMktmKQVlrmJiMFE95
 0tQZ+bvOUjLcqIlOK8PIqB7xYUlCdGewzEmq2IVRameBhnzwAUFi8aZ0/SC7i0tbKnlr9IQCrDr
 ZFDmx3zkwFe9zqKE3/fggTnzLqWV47eNF3ezoKD6Fw6ZMKiKqvEZlWr5CZNx14aOqHVAyy4+pfT
 AN+KwQmfVf7Kux9eTOyRRpKvfpVGKxPiPRQy44gc8HPXvym3bmgKw00ioZ8g0zScei4bSY6K45/
 0Ii8HdQLnLypXhGKoA9yKGcEDzC9G1lZFQvWcgtq0RObN6xoIg5vis56tY/plH9WGLk4qcduPH6
 GIPXAjvRjcGkMK1RuVwlc2xpGc2xB783IGk54PfiVdQ6dh8e8WlEM29dHDeOQKzYeN1a
X-Received: by 2002:a05:6808:67c8:b0:4f7:a3f2:d8b8 with SMTP id
 5614622812f47-55357011c4bmr3404154b6e.29.1792676120830; 
 Thu, 22 Oct 2026 06:35:20 -0700 (PDT)
Received: from
 runnervmxehtw.nb0zx4alxyaezovrn2kcuna5zd.gx.internal.cloudapp.net
 ([52.173.221.47]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b7454fe5sm4902038b6e.13.2026.10.22.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:35:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Date: Thu, 22 Oct 2026 13:35:19 +0000
Message-ID: <20261022133519.4037-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021024758.13541-1-kuan-ying.lee@canonical.com>
References: <20261021024758.13541-1-kuan-ying.lee@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] binfmt_misc02.sh: Fix interpreter with uutils/coreutils
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

Hi Kuan-Ying,

On Wed, 21 Oct 2026, Kuan-Ying Lee wrote:
> binfmt_misc02.sh: Fix interpreter with uutils/coreutils

> +	interp_dir=$(mktemp -d "$TMPDIR/ltp_binfmt_miscXXXXXX")
> +	[ -d "$interp_dir" ] || tst_brk TBROK "Failed to create interpreter dir"

With TMPDIR on a noexec filesystem and the datafiles on an executable
filesystem, open_exec() rejects this new interpreter with EACCES, causing
subtests 1-4 to report TFAIL despite working binfmt_misc support. The
previous system-cat interpreter did not depend on TMPDIR being executable.
Detect a noexec TMPDIR during setup and report TCONF, or place the wrapper
on an executable filesystem.

> +	printf '#!/bin/sh\nexec %s "$1"\n' "$(command -v cat)" > "$interp" ||

The resolved cat pathname is inserted unquoted into shell source: with
cat in a PATH directory containing spaces, the generated exec command
splits the pathname and exits 127 instead of running cat. Generate a
literal exec cat "$1" command instead, letting the shell perform PATH
lookup without reparsing the resolved pathname.

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
