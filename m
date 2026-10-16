Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A55CC6B38
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 10:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C793EA720
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 12:52:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB7403E29BE
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 12:52:08 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11EB9140124B
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 12:52:08 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-35829219da8so966525eec.0
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792147926; x=1792752726; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/NHYALfzd4pfrrKuxGTZKAKAa7Bzugg8QZ4yPPEnysk=;
 b=DxregVn52I4LnNk2DkcPLAUvYO//F/GgCGsqPgqY2H8qX+PCX/6GKs16JH99njBF75
 TTgRC6TdI82oSfNLdbqijMfqoEcp9ARV/mHxuTEQl9ipb2VC+L88HW5fAAC2LQ5omESp
 rJM/3eLas6nTEgrYw+eXJoF6hZaqHi/qh9hqmapfI0VgYJ6t08wIHbW8V3U0D/C4GaMc
 I39naA6/2ZcYTyWUAIR2LLXvynIlZt8hpu2EGd7KU8B93Wn+YVOed6CH9LsrLaK+8PD0
 18+D+t2DW1L1Td6L4A28TPY7aJyXmczaUasEprxXkYV9S/CmezMnvSmuTrIZyI7HsJa/
 ssLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792147926; x=1792752726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/NHYALfzd4pfrrKuxGTZKAKAa7Bzugg8QZ4yPPEnysk=;
 b=BqgeRnV7AJJslZXAUj3QahoQcn8y0pVVO92YYoMPZjVND/LpNNm/pwEqSgbyjYAqo5
 xNRh+fvbMuzMdVllvt7oZ32h2Vbu6CL2HWxmEubTQL3NrjT8QO03EGLLtaH17t9HRzBH
 Pqt5kiuzg19ZCVYrnw5BEABvvbUXAjn37zM6pYToMBBG56P/k9m4ap/6kdgHsmWGZX1I
 B+DuWRCI5Rg1KRbbuY8qDwdYKwTri200M5yEQlT0aVx3y8wSX8An4iIFOZn74kI07FzQ
 O9TBfklss+155Ome4FoDMNskP+soFpVFe+9fVL4xr0TcPaKdC//1PB5N/ih4Crh0l1yq
 jtJQ==
X-Gm-Message-State: AFq9FYLVEih3Ge5zPxBCWfaM7v3Kc7PUAjTeGyET0WIzhIqvQcvr0vIB
 QV+VpIVsAGX6y6Bt94aIDH+jzdzjxAN3m14ba0Igkqd33uXp0awmvdCo
X-Gm-Gg: AYBFou3v6yaZB/Ji9pizbxHfyLYpEvhD9OcRd3kpd1qyXPDC6xhwUUyat+Q+3mlthZp
 zootmTRuJYYdJGONX/N4EXV1eGD8lrQIrKP5dNBuf/li74WfgI4cOsMwr5zLtvH9GQTFehNe9sf
 pQVtGb9OoyuQckPOrimCgkqnatKGwoC+3z6U9ps2oju41vXDxR8C1Wwyey3GqsnsuQUmNt6DaWe
 8/nLVHRUw7sGA1Z82CU5hMHSPFSJ2cpS3ta6slPAVL9NnsDxfX3Y75KUliRrqLkul9pOC5vF4aJ
 C9q5STL13CJyaeRaO5bv4Idscjwi0ogmji+E0CHzOYlmDGjAgLx9ZwR8A0mHiePcHrXK/lMPOcv
 +Z37vqnJsMbWkJhWSUZT6txNMEpTLh/vx8iRU3aDJ2H4yPVa2dyHU1ge5PR/ZHO2fSz7iOztUoV
 27+1MkMmyhkKaTv5GQYV+L47wc4OwauSiZT8k9FVmAIwgEYHhtS1ofdN7QI+MkE916OhqNkc6ZW
 cOtzD+TwO7KZYk9Q4nOl7FrdIpT53KP5YLQv8r1ZKg9V7NE9K0v0acggbN57RZ38tz3VcYfw39b
 lzLLnKh3UGOO
X-Received: by 2002:a05:7022:f9c:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-1825856b60cmr4719716c88.12.1792147926155; 
 Fri, 16 Oct 2026 03:52:06 -0700 (PDT)
Received: from
 runnervm8k3b6.3wpxypyusazulgllm30x5wu1ga.dx.internal.cloudapp.net
 ([13.86.140.151]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c2e7bf4sm4526744c88.20.2026.10.16.03.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 03:52:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Fri, 16 Oct 2026 10:52:03 +0000
Message-ID: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016-statx-atomic-write-v7-1-d9cd4e1f1bcd@suse.com>
References: <20261016-statx-atomic-write-v7-1-d9cd4e1f1bcd@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Fri, 16 Oct 2026, Gaurav Pathak wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> +++ b/testcases/kernel/syscalls/statx/statx13.c
> +			.type = "xfs",
> +			.min_kver = "6.12",
> +			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},

With 4 KiB pages and CONFIG_TRANSPARENT_HUGEPAGE disabled, XFS rejects
this 16 KiB filesystem with ENOSYS even on kernels newer than 6.12.
mapping_max_folio_size_supported() returns PAGE_SIZE in that configuration,
so SAFE_MOUNT2 reports TBROK before the statx checks run.
Use the default XFS block size, or gate the large-block configuration on
its actual prerequisites.

> + * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
> + * It ensures that supported filesystems (xfs and ext4) correctly report their
> + * atomic write limits to user space when queried via statx().
> + *
> + * Minimum Linux version required is v6.12.

STATX_WRITE_ATOMIC was introduced in 6.11 for block devices; regular-file
reporting on XFS/ext4 arrived in 6.13, so the stated 6.12 minimum is
incorrect. Describe the regular-file support explicitly, correct or remove
the minimum-version sentence, and use :manpage:`statx(2)` for the syscall
reference.

> +	.needs_root = 1,

Document in the high-level description that root is required to format
and mount the test filesystems.

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
