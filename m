Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23979C77B6F
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 16:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 356F33CC85F
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 18:46:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45C6A3C9264
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 18:45:50 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 74C1A10005E3
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 18:45:49 +0200 (CEST)
Received: by mail-vs1-xe32.google.com with SMTP id z13so8105719vss.1
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681231548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mIEqJhThfqATO21A0l51GhFD/DStlepMrZco0lBVm3U=;
 b=yEtKIw265e9dv4kG8hejwXCrbyznibtKsKao/0UNThOgZuUUnt6NhuCa/uW+RGqEje
 aJG7rMVy13g9viI7SxgQfYBLge2Z+E92wji+Vc3/YxDz9/qrvipKSSSf+1VfTaSBKwOF
 Yc/zNxWbXKZafzdRUoplPgwXMkXYBytalT8tWG/wd3J61Bc+nJFeXbbexQWHeHatg1g6
 a5GEeg6GZ3/wFdP/8BXJQwfgGsfPFXRMCzMTwDwzbBak/573a7iVbneqC9JaiNW+1Pay
 0L1PvCVZoELluw1y4otr+Md7DDTpG+dZknXPjg42EhKfAnOGw/2zDZovbG6Fgkz6QV5a
 cniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681231548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mIEqJhThfqATO21A0l51GhFD/DStlepMrZco0lBVm3U=;
 b=vqDyFTkzJotPjB6J6ZfuYRqh/JIWx251W9EWbPbhNapmxsaTYM2HwGPiyk4K6RMane
 GDH9XuFxcamPmBYXd2Hac+BIkaV6A+h7mHkmCmrAUmI01nnXs1YLLlfkpMzb+6E75O40
 4pJhzZleWuXlB9N7Kh6Z9aaCCzwwn/lpzt6XA5W8dqWCx+mi24CpK5cRlB3NbdRDPNbt
 vJy6yjvAB19V/sNBznSnv37n+khAgEE+yu9Q2fq6+KIwL+nbKIqzC+A1nlL4jGqxx3RW
 baqYdeOXcpStr5O6Xg8BRYBWmF9zDbSOMMhZJ3cTgFHShXCMGmP1RzlxPUb1mf4OW9zN
 ztdQ==
X-Gm-Message-State: AAQBX9d2cKSp7e0d6FHyiNU2gT5lRuXRLt7ITzYMjqyywmZEoKGDxKWy
 2xAuLPC+C7o0VtKmO8v+pWgbNckVjAb5E5QYlSbbdA==
X-Google-Smtp-Source: AKy350aLiSIIUedc5/zLhlcykg263K0pGsG2J/2ArbvRP2ytHgzyUKMhyd6G8oT/XuNuItumcNW/oWkCNdWpfB6sNwE=
X-Received: by 2002:a67:d492:0:b0:42c:6fe9:bcee with SMTP id
 g18-20020a67d492000000b0042c6fe9bceemr4138329vsj.1.1681231548148; Tue, 11 Apr
 2023 09:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
In-Reply-To: <20230406105646.GB1545779@pevik>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Apr 2023 22:15:36 +0530
Message-ID: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > Following LTP syscalls failed on the i386 and arm environments with
> > > Linux next / mainline kernels. The userspace is coming from Open
> > > Embedded kirkstone.
>
> > Thanks for the report and summary! I went through the list and found
> > that most if not all of the bugs looks like incompatibilities
> > with musl, not with 32-bit. It's probably not well tested with
> > musl.
>
> > Can you try again with glibc and see if there are any remaining
> > issues then? LTP should probably be fixed to work with both, but
> > if nobody has done that so far, it's likely that this has come
> > up in the past but ran into problems upstreaming the fixes.
>
> > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > You get to see "segfault" in the following logs that have been noticed
> > > on i386 only.
>
> > > This is not a new problem. We have been noticing these failures for a
> > > really long time.
> > > Would it be worth investigating the reason for failures on 32bit architectures ?
>
> > > Test logs,
> > > -----
> > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389
>
>
> > > Test environment: i386
> > > Suite: ltp-syscalls
> > > Toolchain: gcc-11
>
>
> > > fstatfs02
> > > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > > received (pid = 17841).
> > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> This is IMHO using the old LTP API.
> testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> released in 20220930. There is already newer release 20230127.
> Generally it's safer to test mainline kernel with LTP master,
> but this fix has already been in the latest LTP release 20230127.
> And this error has been later fixed with
> 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")

Thanks for insite about the failed test investigations.

>
> @Naresh which LTP do you use for testing? It must be some older LTP :(.

Our build system started running LTP version 20230127.
I will keep you posted with the latest findings.

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
