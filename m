Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCE5CD3427
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 17:32:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E9953E6AE1
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 19:32:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66CE93E1FD2
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:32:24 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01FF11400B8C
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:32:24 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2f3c623322bso2659214eec.0
 for <ltp@lists.linux.it>; Tue, 05 May 2026 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778002342; x=1778607142; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSoBqsjbFl8q+6zwL64yOjvi2W1+4b1yk7/xy64KHw4=;
 b=DfS6BHeSOE5WBJGAHNjynpVM7vaNSikWyKYWY5A76GOt/H4TuaOJ2lZZ0tr1MWewNb
 4KYNLerX0n26T+zp8z6Ur78sRJN2M3ZJx4g51bTg7gE9twgrDnb9b2vZc3CIhhcJFaH3
 LDqXyVX7H4FJpwDQOuFjwC8feR2clrJaKCOX7nU3TZqjUCVe/sg0kKQpNJPvnhgOB93v
 SdMaPXvDb4wuMnnt3rdnn+SZOUVLMX6XtB/w2tb1WvHKUq5vtFOGpZyHiofbnB3SKe+X
 JLKQWALR4yUFzkQLb1qARNZiM8KSUTAcMDLyG8I1dgxXUZ0T3pO+mUJVMRazqyRdpuof
 qlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778002342; x=1778607142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSoBqsjbFl8q+6zwL64yOjvi2W1+4b1yk7/xy64KHw4=;
 b=X/HtRiUedUtXpPJtvPtJ/A3YjcpJ8FtMl+Og+xPaznwiGJk/kVBS8vjlYh3AaiRRjx
 LBszdvVtoygGy4y02Xc87zTg/rumv2x0LBiYxXLikj2kLhjDRuzKCRhYXe/m993wZ8PO
 zjrJVP2tDjivDHIzIXPyIezAkweoq324IBGoyVG5Jue2ytuXs81BLV76G7cEPIfxyJDW
 sXcLr1r2sZt3ONRSqF+I/iPzvChIQs7mVennhXHYP+rkYFLM4h4zP5cYv81fdVyY5Y0P
 J1jDmxjdg8s0ywdvKE5tDm+eeZ6BoFGi8gznERTjmRkuDv6/pmIAvP6KBXwflUSXu0Ry
 7VpA==
X-Gm-Message-State: AOJu0Yz4PU8VkKS18FWeAPNMBbu1yO5yDjRU4GdBR3F2aEnN2gcEBUvO
 V+RhvSSTsPAXqenkAn4XAwYalTaGhHcBwNIKCYvTO/hTD9UKjFM59Bop
X-Gm-Gg: AeBDieunxOHoO9wlVJwKR5N315OC+VS98Yb6yjkAEYS4EtbDF8Sg01/znQbDDjHGa6P
 h2/Ee1TCtEDgALTSLZSJQ+LR/eAdx70N53GDS422Gzo6w14A1TXl3Y9l0HJfFziD5bJlsY8ciNq
 6eSiPs2KMa3xOcIft3l0qg/wvy4K0hr4bVSk2GsPEePw+vdDh1pgEd1hEZrRjjAno+bpebBsTYu
 /GM1aXmpIGoBsfhlDzy/c6WTS3Z1cBxYq/TYQJoeaGQCVEBgpM788LWLmImrg19v4yexCdahBnU
 ucocue2Np3QNBDPVlIqHH9XEXbtqZJvSp/MhINkwq15vb3Pz+PgsPMJLBlAsusNxxjxzakkLlW+
 rQdQuFcvviU3i3Gpt73TrgzQ0QCJ2u8zE/9zwEyBsT0lUQ+42CpLSNvYOkO2AA8v7lHIcooeUSv
 wgqTD6D6pJHFwkVGZlERMv+iM1W80SuuSeNvMtxq+p8GslbICMTZtqocfXrXRuv5FJqlkymVdsP
 LETyW/YSw36rfCC/gig8bAajG37tQbVrcoBeBcQcmOPynhELYQ/
X-Received: by 2002:a05:693c:2c14:b0:2dd:6937:79c8 with SMTP id
 5a478bee46e88-2f54ad730a3mr108091eec.5.1778002342068; 
 Tue, 05 May 2026 10:32:22 -0700 (PDT)
Received: from
 runnervmeorf1.si5vesnirltutgysy1tpxjbuwf.dx.internal.cloudapp.net
 ([172.184.220.149]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d634sm25748841eec.3.2026.05.05.10.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:32:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Tue,  5 May 2026 17:32:20 +0000
Message-ID: <20260505173220.3999-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505131538.21645-1-rbranco@suse.de>
References: <20260505131538.21645-1-rbranco@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Minor fixes
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

Hi Ricardo,

On Tue, 5 May 2026 15:14:41 +0200, Ricardo Branco wrote:
> userfaultfd: Minor fixes
>
> - Use POSIX semantics for thread function
> - Set cleanup to call reset_pages
> - Use long for page_size and use unsigned cast
> - Call the SAFE_ versions of some system calls
> - Use TFAIL consistently for unexpected UFFD_EVENTs

The body only lists what was changed, not why. Please add at least a
sentence per item explaining the problem: e.g. the thread function had
the wrong signature (UB when cast to pthread start routine), missing
.cleanup caused leaks on early abort, int page_size causes sign-extension
in the bitwise address mask, etc.

> -static void *handle_thread(void)
> +static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
>
> -       tst_brk(TBROK | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);
> +       tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
>
> -       page_size = sysconf(_SC_PAGE_SIZE);
> +       page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
> +       .cleanup = reset_pages,

These are five distinct fix categories (thread signature, resource
management, type correctness, SAFE-macro adoption, result-code change).
Please split them into focused commits so each can be reviewed and
bisected independently.

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- userfaultfd04.c (and similar): early-return TFAIL path skips
  SAFE_PTHREAD_JOIN, leaving the handler thread un-joined.
- userfaultfd03.c: .needs_root = 1 may be unnecessary since
  /dev/userfaultfd was designed for unprivileged access.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
