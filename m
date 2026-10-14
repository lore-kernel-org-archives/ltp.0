Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7647ACC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046983E6A13
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:00:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E79D3E5531
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:59:57 +0200 (CEST)
Received: from mail-vs2-x08.google.com (mail-vs2-x08.google.com
 [IPv6:2a00:1450:4864:3a::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27C9D600478
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:59:57 +0200 (CEST)
Received: by mail-vs2-x08.google.com with SMTP id
 ada2fe7eead31-7bffbbcf007so116706137.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791964796; x=1792569596; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jO4wdAHeJKofuHR1jemond3iSc1H7kV8dMXFmWzsyow=;
 b=DBlr0wPmEeBpTLLCOgPU3/YlgqyTh5h/82Ov3/JoK+FJ2c/dd72lGbb/cWxGm7SJuH
 NVUScgpI1AmbI4gyeq46XwGc5UjC0LCyGJ+WaB+REh8RAu2yUy5YBgOSW7eUc2KdxrMi
 5ullRvLNtThNbVAhK/x0+geIFwo1MbF/gmJcwO0a8CsKWYD60R3KwsUjVKlUnPXzSySE
 kz5TT0LFoe2UY7+9nnip8v9mo1gbmiD81tvZy8gfo302/rOhuZe26jgfz7xlQRJOQ/ME
 plMbrlu1o9Her684LjNE0N+/A0H28nGu+tulqP1QHMmxpXw4NRCKaoXzLy56w53AIFg2
 tOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791964796; x=1792569596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jO4wdAHeJKofuHR1jemond3iSc1H7kV8dMXFmWzsyow=;
 b=mF+7W4fF1xfXc/8QebaYEL4biWPcN1We2z4DHEQppW6ejJN2Oo3w55IXmI349o2swA
 0zjsfmhLCywtDHNOpEwhe2/0Nu7p/N6BVToqMEnvMrF6q4idrfuS49WOVsnhfimcdCnK
 6HS+DmOv9jUWb8x8Ix0N3NzPRnHO9+Acg/dBIxYlAN4jrTJt0r6FR8IiKbFzj9u9UbrG
 jIVJASzlPuKpDR8N5/1l77Rmw1n6ZYpyt6pzrYTJVxvRCISWNySOXSltGE4ovk1qroOl
 tlkpU9sW4JqWpmxZMLPTwE+pSQRHZlFANuPkE2aCsRPDCOOJGl/fseWulQqw4CqRsIB6
 sESw==
X-Gm-Message-State: AFq9FYJ0oYZFZFoC+lZ/XkNamATCpZ+Q/RVwCP3TU25aehko5s/iUJZW
 J+nEL2llYpi69ElVk8PRCxCOzf2GH01vR98JEYqylSBOrb4wLnTHhPDHy98ZEsjS
X-Gm-Gg: AYBFou3G/nkqlN5ZrdGKDhSwYTAtGspqyIEJsS999OBv6j72xZITVNV0vVT4SR1B0si
 ryGhFJG5mH9R4KUqFDMmJF5VAFmXw8xNvZd+MxUWYAdVETrvghneREWZfqQBO+vURfwLdvFpD0N
 xadbHXqsGZVCRKzAtjmnLzqNfaW3pNNF1Ttw+7ekcg9sMGBmpHQZvoL3qAo1sBQQIV8hPz2CNB6
 5/PcqV9EhEoO7i2yr7xj/8xLgmnSgoct4rz0IKTty+ArD2nW3z3F6xdcLGBzeS6TeAoK2wPvCtk
 Sp8H6P3Ss9dwIUcMaBS5PeG5imJfSc+UnXl+0XYDqPmlMH1o3NC2T2E8OmNhDfWkH8psF4xRNm7
 a7T4hwYoxNbNlGV+oGBpfTvjfJP+uFS5rMgiJ+elsv4rQvvER2yaa5oO/V0VZxVC1BMN0IwxbaF
 YhMTEvxBZgQYueYkc0fPO66ZiE4txRGyyaD+sK16h82XhO8dmxkRW8sCEW1/JJYs3csYSX9yRGI
 bC1imMv1j3boYWwmCxE0wBLqtlwLTpCVHaq6eW8zwqJ1p7tunDUoo+QuvnpzNfjb/XIYF15vNPE
 7G4pfVtfIujYVigKawg=
X-Received: by 2002:a17:90b:224c:b0:3a7:9adb:2a0d with SMTP id
 98e67ed59e1d1-3ab3a0218bfmr14090537a91.0.1791964374291; 
 Wed, 14 Oct 2026 00:52:54 -0700 (PDT)
Received: from
 runnervmmprz5.ldcbmbo2laxuhg0cuwrmeuiwuf.xx.internal.cloudapp.net
 ([4.155.111.1]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac7a17cd3bsm1002347a91.15.2026.10.14.00.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 00:52:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Wed, 14 Oct 2026 07:52:53 +0000
Message-ID: <20261014075253.9979-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014062016.178140-1-gpathak@suse.de>
References: <20261014062016.178140-1-gpathak@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC
 on regular file
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

Hi Gaurav,

On 13 Oct 2026, Gaurav Pathak wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> +	struct ltp_statx buff;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff.buff),
> +			"statx(AT_FDCWD, %s, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buf)", TESTFILE);

TST_EXP_PASS reports failure but does not return, so a statx() error leaves
the following checks reading uninitialized output. Return immediately when
!TST_PASS before accessing buff. Allocate this syscall buffer through .bufs
rather than on the stack.

> +	.min_kver = "6.11",
> ...
> +			.type = "xfs",
> +			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},

Linux 6.11 rejects XFS blocks larger than PAGE_SIZE, so this configuration
fails to mount on a 4 KiB-page system admitted by min_kver. The framework
reports TBROK before setup or feature detection, also preventing the ext4
case from running. Use a portable block size or separately gate this
large-block configuration.

> +	if (!(buff.data.stx_attributes & STATX_ATTR_WRITE_ATOMIC))
> +		tst_brk(TCONF, "STATX_WRITE_ATOMIC unsupported by block dev or filesystem: STATX_ATTR_WRITE_ATOMIC missing from stx_attributes");

A response with nonzero atomic limits but a missing support attribute is
inconsistent, not simply unsupported. This branch hides that regression as
TCONF despite the stated goal of validating the attribute. Check
attribute/limit consistency first and reserve TCONF for unsupported results
with zero limits.

> +	uint32_t	stx_atomic_write_segments_max; \

verify_statx() never checks this returned limit. A response advertising
atomic writes with segments_max = 0 passes every assertion, although it
cannot describe a nonempty atomic write. Require
stx_atomic_write_segments_max > 0 when support is advertised.

> +	if (buff.data.stx_atomic_write_unit_min <= buff.data.stx_atomic_write_unit_max)
> +		tst_res(TPASS, "stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
> +				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);
> +	else
> +		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) > stx_atomic_write_unit_max(%u)",
> +				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);

Use TST_EXP_EXPR for this comparison and the repeated power-of-two
assertions instead of manual TPASS/TFAIL branches.

> + * It ensures that supported filesystems (xfs and nfs) correctly report their
> + * atomic write limits to user space when queried via statx().

The filesystem list tests XFS and ext4, not NFS. Describe the actual
regular-file checks using :manpage:`statx(2)` and document that root is
required to format and mount the test filesystems.

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
