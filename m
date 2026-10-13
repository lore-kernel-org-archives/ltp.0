Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A566CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 11:27:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0AAC3EA82B
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C3F53EA80A
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 13:27:18 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 05567100044C
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 13:27:18 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 d75a77b69052e-5350beb1d49so24310221cf.1
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 04:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791890837; x=1792495637; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ojCbmcjTXCHOQZPSNosKyo09IwLTzJxLZ084/UJaI2U=;
 b=XhjKCblQtVGnvIzATXMZGeTp3EpWOAtXK4/taYwPLKJYaIO3GlMad7jGGaO4mVakVY
 HJaPDpbspprlrPON8jHYYyBwo8zPp1x6KuPjy8AHvgTOaMBQX0JFrtfKo8ckrJ7t0lLl
 m+AeplDLjawSlC2xrghwAfUUezl8+j+Yn88eG1Kkp4O07qm6xRONa3POYW82pMrGPjuz
 SdUWpsqTXxwvH8CJg7Ou/xTv+X1Bb1Yr46Mq8i1TlJJaAVGbIB9JLI/Y5+HK+FdJa9Ny
 rWMkMX9yU7x3KW3o4YUkJ2p+MvoMdNL5yzfAaQJEGJI1uALhi/m8buJI99dgOM32MVu3
 ZDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791890837; x=1792495637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojCbmcjTXCHOQZPSNosKyo09IwLTzJxLZ084/UJaI2U=;
 b=JfIlZrSYCOH4YcPSql5/w1HpMcm7d1zSBFPGd8zvQq62sq3ubyuPn9SEsRaTGPX+G0
 Bz1GcwxAyC+uhdDM2WU5IQTyFbhhXgsuewMk/lTAiMSFXrTOrP5p6QBwt+PXvyr68wR5
 0CAjFm+Ioc2xifkBGspG48uQINr0sCb+rFCQWQukCshLRU6c3uvppp7QN37AKNGfdZB7
 O+GbXem1vUZvsBBgmoxLl9MwJ6rZqw8sTAuNzsZTv/18FeV+y+VZZnlHun3j+Rckcbsv
 nS9otjbenatAmiDoyDQ0Cij4XBlsYLgT1MZr0bNjo67SzW00ExDtjNg7TsbiBIM3tkNU
 kRUQ==
X-Gm-Message-State: AFq9FYL8gbOJkKAAH2WzlSDKMWH0hkjFefKtePTTguFKRlUK393Zf0Ad
 jpd9JQa+8GJuNZcTbt7qyXIAsQrEzHy1a/ZmQMVRKz9j3sNEl8hUhMXF
X-Gm-Gg: AYBFou2izhp3RySzIfW1mb1nJL43MBCpq8sgmzXE8Dg14OsuoYoP0k8iYn7KrKINZO9
 92LHl9i6kyMUNZaGdVSzcN7n0tgEbreZ5EMRmc15wtOK7TTb4N8X4QEvcU6id5pjuy3UPB9uKBJ
 Bxz7ksX2YsSfvg27c0kIo3aQ+jfeEODU/4jEmqJyjlcr/ywMlRJ4RZkuSVfgJM/eC5jXNnjMgbC
 2Vjn4SjDnHFXwqdgu5YozzzjGJtOpTc4LlyOeqzuv+4btenV/eVh7+1d+iVHGD3bozdM05Xy89G
 j0qFsDAJ6xWEwamTrhh8YlecNPyA7c1UgNLlaDyUHXfvT/yhUrrNRtmHNpHxVEb/5kKrlUvdhVT
 en7/nZxoseQGIIlo9msnSCrjl059HLOhCtfn5dzaLOmWNVjOsUjWEvEu36PWlBWCAvMAsOx6X9T
 eRc6aHo84AHiKJ2XoxvxP9S321BBnhbGrqFz/CaWS5PqZW4eOHGc0LIbhsbPiuUBK8F5qjiF10F
 0cIG+oShlOBZU4Y3GBRc32p/h0Tv0zPHQqMYFRHzfu7s2F8OVqMgCphmf2AwlZ6iw3u8bx70CIm
 ztKzfcakNVFvbG4TUNoBf6Q=
X-Received: by 2002:a05:6214:5985:b0:910:4da6:8354 with SMTP id
 6a1803df08f44-91b554f1310mr217938216d6.17.1791890836593; 
 Tue, 13 Oct 2026 04:27:16 -0700 (PDT)
Received: from
 runnervmmprz5.4qywrrvrkjtejbh21wz2rbdc5a.bx.internal.cloudapp.net
 ([74.235.102.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ba684f404sm251776d6.31.2026.10.13.04.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:27:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Tue, 13 Oct 2026 11:27:15 +0000
Message-ID: <20261013112715.9633-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013090740.71898-1-gpathak@suse.de>
References: <20261013090740.71898-1-gpathak@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On 12 Oct 2026, Gaurav Pathak wrote:
> syscalls/statx13: Add basic test for STATX_WRITE_ATOMIC on regular file

> #if HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MIN
>
> #if HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT

High: These probes inspect libc's struct statx, but buff.data is the
unconditionally extended statx_fallback. With glibc 2.39, a valid atomic
write response yields two TCONF results and no limit checks. Remove both
HAVE_* guards and the new, unnecessary configure probes; detect support
at runtime.

> 	if (!(buff.data.stx_attributes & STATX_ATTR_WRITE_ATOMIC))
> 		tst_brk(TCONF, "Filesystem does not support STATX_WRITE_ATOMIC");

Medium: Valid-looking limits pass even with stx_mask and
stx_attributes_mask both zero, while nonzero advertised limits with a
missing active attribute produce only TCONF. Validate both masks before
interpreting the fields, and report inconsistent advertised support as
TFAIL rather than skipping it.

> 	TST_EXP_PASS_SILENT(SAFE_STATX(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff));

Medium: SAFE_STATX aborts with TBROK before the expectation can classify
a syscall failure; returning -1/EIO reproduces this. Since statx is the
syscall under test, call statx(..., &buff.buff) directly inside
TST_EXP_PASS_SILENT.

> 	struct ltp_statx buff;

Low: Allocate the tested syscall output through .bufs using a static
struct ltp_statx pointer and .size = sizeof(*buff), rather than a stack
struct, as required for new LTP tests.

>  * It ensures that supported filesystems (xfs and nfs) correctly report their
>  * atomic write limits to user space when queried via statx().

Low: The filesystem array tests xfs and ext4, not nfs. Describe the
actual coverage using :manpage:`statx(2)`, and document that root is
required to format and mount the test device.

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
