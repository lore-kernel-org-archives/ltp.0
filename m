Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D24C44516
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:28:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EF323CE2E5
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 13:28:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35F4E3CE2E5
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:28:31 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F0A5600667
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 13:28:31 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51c0ab4fb8bso24694461cf.1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784287710; x=1784892510; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5dShZJHIxd7G87uGH9fzTKeWpgv0DPuiN5btwIl56nU=;
 b=C5FzYBj3lqCQ14nUpAgne7eth00azeKlS+5aXQU198euk5Q2ezxJjRIaiquyIjLbDF
 mVZhS4+8emCMbqpl6SU2VyiOz4lAhJqgi6za7Rhyvs3/T7zp79gHDy6CePWly+hIrLUb
 /jQZjjzBVp28SAfxwtcFJSNp2dEK5CH3mnn5ut2BStnQXz+CbCXREk84sliv5SNEVgXs
 DSnc2+tC/a3Zvl+Z7ieX/rgUgw9pckZdmZ4la15RqvT0gLeA3kpYXSoaojQ5xfbiCoF4
 Ex81rlhzclxUtalWzeZmHhca0e4BuQzAYYtCElpNlfz79LnGTIhDpByM9kBo0/DuiW+g
 /BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287710; x=1784892510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5dShZJHIxd7G87uGH9fzTKeWpgv0DPuiN5btwIl56nU=;
 b=lm6kA9whrdutnJ1cB4be5F5nhhvKlnSUaCtsQMPOroqLJwadEDLzkU4YbypSN0a1EX
 gotYNh/dY18RC+u8S5IoU4VAtqAi7WasZPndy/urQobMXGEyk5R+2GazlHRiTD0/YX8C
 Td7krhptAkmZA+1EtL7mT5bSZtnYou98fy4cARRqvLuIg82fPiMJbt/WB88YKUMAv0xu
 ZetPoT8YwxyTGVnrY6ARLOC9Ei1EwtyGrh8Uol52SjKrqhfwsRpX7TmLHH/YmDiDAU28
 N3UC+ULvf7VRi5Caz6l6yruBV6mJjOZLopT0oU2z6DfI5+ONmdtjWuFYtcUDKU0Zp0Du
 uSWA==
X-Gm-Message-State: AOJu0YzVfUwfSu55PT8moE3ABVb6E8i5CcFqAVf30GtgBzFKTjIncdXg
 3V/Ffm4yHNQ/iifYEsk9ss2ajt6txmRUBLSi8tSqT68frVrStMwjfIhZ
X-Gm-Gg: AfdE7ckULaZ2QvVSB/loJvXQlYnNOKZk2hESAJaz/S5AWXB4XNlaXqY6HO8z77Ab6Nz
 wQejnlnuM/0pEwPbp5HtlCRTYErvlTwx/xf/gYogecHtUOASaqEHOxfn5aA8XREfNBqUK/VX99z
 aW4OxYoXC8wJ+vaBphsC+ieBDKLQO7BIW+FaLg7ZT91bVCDEiIi6RMmfWm1jRipbHomIpT3bRkq
 NXqilS2MGYmr6P6EkRcdqbYU0cEX2y5u6xpTDsIAPYNwhK4J8aAha1+6soTRLh/WNSg2uKUa46f
 Aj/r7vy5SIH3tj3euYvvADUOCScFJH7hhUp2BfMyK5NDsm4sUjH7oMHEwTB0g529+LF6YtTkTSP
 z8854UhYzt1ND+Fy2NKM8XA4GsnDehpf4tE63+BPlNpwghBrv5dEzE0XsDsVT1NUNGb6not4EJy
 7K5CqE5vXBuPwH1dJH9oO++uUCkxpAPjbYXFcPTio8y/Ur4TJVs46ArUXuMU8E7ONqWoaFXq2KC
 gomElCGYtUB41Mp
X-Received: by 2002:ac8:58ce:0:b0:51c:7b12:5fed with SMTP id
 d75a77b69052e-5213d4bc5d2mr18315411cf.73.1784287709998; 
 Fri, 17 Jul 2026 04:28:29 -0700 (PDT)
Received: from
 runnervm3jd5f.cjo3wyyrofeu3il553x5iqp5yd.bx.internal.cloudapp.net
 ([20.81.47.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077871f766sm14278666d6.46.2026.07.17.04.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 04:28:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Fri, 17 Jul 2026 11:28:28 +0000
Message-ID: <20260717112829.4056-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717110234.1070268-1-pavrampu@linux.ibm.com>
References: <20260717110234.1070268-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

Hi Pavithra,

On Fri, 17 Jul 2026 16:32:34 +0530, Pavithra wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

> This test verifies that ptrace POKEDATA and PEEKDATA operations work
> correctly on hugepage-backed memory regions.

The commit body describes what the test does but does not say why the
migration from libhugetlbfs is happening. What is the motivation?
(e.g. libhugetlbfs is deprecated and tests are being consolidated into
LTP.) The rule requires the body to state the motivation or the problem
being solved.

> +	err = ptrace(PTRACE_ATTACH, cpid, NULL, NULL);
> +	if (err)
> +		tst_brk(TFAIL | TERRNO, "ptrace(ATTACH) failed");

PTRACE_ATTACH is a setup step, not the operation under test. A failure
here means the test could not be set up, which should be TBROK, not
TFAIL. TFAIL implies the hugepage ptrace feature is broken, which is
misleading when the real cause is, for example, a restrictive
ptrace_scope.

The doc block already notes: "for ptrace(PTRACE_ATTACH) to work across
processes when ptrace_scope is restrictive." At ptrace_scope=3, even
root gets EPERM, and the correct response is TCONF, not TFAIL.

Consider:

  SAFE_PTRACE(PTRACE_ATTACH, cpid, NULL, NULL);

or, to handle the ptrace_scope case explicitly:

  if (ptrace(PTRACE_ATTACH, cpid, NULL, NULL)) {
      if (errno == EPERM)
          tst_brk(TCONF | TERRNO, "ptrace(ATTACH) not permitted");
      tst_brk(TBROK | TERRNO, "ptrace(ATTACH) failed");
  }

> +	err = ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST);
> +	if (err)
> +		tst_brk(TFAIL | TERRNO, "ptrace(POKEDATA) failed");
> +
> +	tst_res(TINFO, "Peeking at %p...", p);
> +	errno = 0;
> +	err = ptrace(PTRACE_PEEKDATA, pid, p, NULL);
> +	if (err == -1 && errno)
> +		tst_brk(TFAIL | TERRNO, "ptrace(PEEKDATA) failed");

PTRACE_POKEDATA and PTRACE_PEEKDATA are the syscalls under test and
must not be called bare. The rule requires subject syscalls to be
wrapped in TEST() or TST_EXP_*. SAFE_PTRACE cannot be used for
PEEKDATA (it treats any non-zero return as error, but PEEKDATA returns
arbitrary data), so TEST() is the right wrapper for both. Example:

  TEST(ptrace(PTRACE_POKEDATA, pid, p, (void *)CONST));
  if (TST_RET != 0)
      tst_brk(TFAIL | TTERRNO, "ptrace(POKEDATA) failed");

  errno = 0;
  TEST(ptrace(PTRACE_PEEKDATA, pid, p, NULL));
  if (TST_RET == -1 && TST_ERR)
      tst_brk(TFAIL | TTERRNO, "ptrace(PEEKDATA) failed");

> +	pause();
> +	/* Child is killed by parent via PTRACE_KILL, so cleanup is not reached */

The comment says PTRACE_KILL, but the parent uses SAFE_KILL(cpid,
SIGKILL). PTRACE_KILL is a deprecated ptrace request, not what is
used here. The comment is factually wrong.

> + * This test verifies that ptrace POKEDATA and PEEKDATA work correctly
> + * on hugepage-backed memory regions. A child process maps a hugepage,
> + * and the parent uses ptrace to write and read data from the child's
> + * hugepage memory, ensuring that ptrace operations function properly
> + * with hugepage mappings.

The doc block references the ptrace syscall without the required
manpage RST role. Use :manpage:`ptrace(2)` when referring to a syscall
in a /*\ ... */ block.

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
