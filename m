Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A676C83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 08:43:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06EF43C71A4
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 10:43:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B7AD3C091D
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 10:43:31 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 918832003B6
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 10:43:30 +0200 (CEST)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b350704f506so1992112a12.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751877809; x=1752482609; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LklowgplYENw1i7IrjdnHI57VuSnPOYFZ+BKhHkshBI=;
 b=ldG3TFuVNne9F4A+8pGgomGu+kJJO+10U56TXF/ty3GJKfEhtNul5rXCnRi2nyn1i5
 hfTMUSOa0TBisi4Lw0iepy8dRN7U+XHzRoA0P/LA2dEXV1ILzLVSboG4+N77bjfhKL5p
 jijRPXIajgI63r2wvT0wvVJtyR/y7TXUfXJBsLFOdD1y15BmA3QCrX2lKEiVKUKcFjnN
 1BcMiOf89Aa9tzEmEy+hG4A9WRPAzsEmB97VEwRbwoZTXLCymaV4HcOQOFlQEb/YVRJ7
 h1jMXrMiQW/GnO4muj6srlqlRum3BqZmHotromrRIcF4eaV8GQ88eLiuaWN0TAWUh6P1
 vo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751877809; x=1752482609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LklowgplYENw1i7IrjdnHI57VuSnPOYFZ+BKhHkshBI=;
 b=jrkbMaFJPllkN4lWy8dMUNQhCO4iYLZVtClnphzQh9Ffm9h8XCt44MCMJHulpC+pVq
 sHtvdb2OOh1rlreWNhItC1PFpBjvOwKkfOxIEwbZE+t0RQSnYkDTpA7z0Dj1KAJgrIQf
 TnGg7cfyu7Fr1xgBO/RARuyPXVt4O4LbsN+XFeHfB3hzMyq0lAcDkZmrPkQJIDs3H2+j
 yCtjuiIUgW9gRTEjvKcgAqolJzCD7V36IiAJJSbihdCtXO6ve2ytxQVuyWp/hL7yUI+Q
 xTV6xo6tURijGY0LDfA/ChMvHyJfVDkqjEKdyfEjnvih5pxm1QJ+OXNXYydHK3WWfn9Q
 sbEg==
X-Gm-Message-State: AOJu0Yx2E1R1JXT1tCVT9SCmdaYd5GNyz299bbOPyK+TxAuduDBw7BNi
 FeygxXTZwNVF5nmYxTGdbd+CDf9qKxNFASNtQvWYxmATQ0tVcBsVMtsWewDF8M3qIiMpfDrsEbJ
 woT1nYp2UYM5EBauiHjtVKF5O74Mq1i1CnQ/3oLZ0UwInALTVdqho
X-Gm-Gg: ASbGnctCKpCO1/ubBDcglaqSWFJYllVPgB1b8BHX6dlT69mgBfHYz2J9lgVW0vwta+Z
 Ad0on5IBVCZkhUcg61Zxe4zMoBsE9lx3wjqxEkchTRlhWkGOX8EV+rQpoCb7ROjR1LJl0dRkxKY
 F79/eOQXYwYYkwAHUfVyhtjoCOH6n37P+OaI3n6wbANTkkYpIrG6m+jTFQfCI/jcmo0COhSOT9W
 fGR
X-Google-Smtp-Source: AGHT+IHukxRqvzepVhYBRpt+PLlMQ3SlnLL5W6s2lImeMWjf2sMY2i4Bu4SdjhsaHOmFNGgSz7dhys43qu/uU2e4sN8=
X-Received: by 2002:a17:90b:33d1:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-31aab854dadmr18730822a91.5.1751877808741; Mon, 07 Jul 2025
 01:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvD1A12WE36NjELe5cD-LbPsmwJnH5aUAcufBZ7ndt2Hw@mail.gmail.com>
 <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
In-Reply-To: <c9ba86f6-dea8-47bd-88e1-edf49e4bf9fd@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 7 Jul 2025 14:13:17 +0530
X-Gm-Features: Ac12FXw-G_lNwP97raxqWFOZUtf2EluymJriGyENT10NUGjfSc__f9FGW09O5J8
Message-ID: <CA+G9fYtuh0FwKfjadb7c+jr=ZZ-wXjmkbcPA4sp8OqzARBV1Dg@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP syscalls mseal02 and shmctl03 fails on compat mode
 64-bit kernel on 32-bit rootfs
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
Cc: LTP List <ltp@lists.linux.it>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 3 Jul 2025 at 19:47, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 3, 2025, at 15:47, Naresh Kamboju wrote:
> > The LTP syscalls mseal02 and shmctl03 failed only with compat mode testing
> > with 64-bit kernel with 32-bit rootfs combination.
> >
> > Would it be possible to detect compat mode test environment and handle the test
> > expectation in LTP test development ?
>
> I think we should either make the kernel behave the same way in
> both environments, or accept either behavior as correct in LTP.
> NVAL (22)
> > mseal02.c:45: TPASS: mseal(0xf7a8e001, 4096, 0) : EINVAL (22)
> > mseal02.c:45: TFAIL: mseal(0xf7a8e000, 4294963201, 0) expected EINVAL:
> > ENOMEM (12)
>
> This is "length=ULONG_MAX-page_size+2", which overflows on 32-bit
> but not on 64-bit.
>
> How about this?
>
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -234,6 +234,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
>         if (end < start)
>                 return -EINVAL;
>
> +       if (end > TASK_SIZE)
> +               return -EINVAL;
> +
>         if (end == start)
>                 return 0;
>
> Since TASK_SIZE is smaller for 32-bit tasks, it would detect
> the overflow in the same way.
>
> > tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
> > shmctl03.c:31: TPASS: shmmin = 1
> > shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295
>
> I see this is being intentionally truncated to INT_MAX:
>
> static int copy_compat_shminfo_to_user(void __user *buf, struct shminfo64 *in,
>                                         int version)
> {
>         if (in->shmmax > INT_MAX)
>                 in->shmmax = INT_MAX;
>         ...
> }
>
> > shmctl03.c:35: TFAIL: /proc/sys/kernel/shmall != 4278190079 got 4294967295
>
> Here the value from /proc is defined in the kernel as
> "#define SHMALL (ULONG_MAX - (1UL << 24))"
>
> On a 64-bit machine this is 0xfffffffffeffffff.
>
> However the 32-bit ltp tst_assert_ulong() truncates it
> to 0xfeffffff, which happens to be the exact same value
> that it would see on a 32-bit kernel.
>
> The second one is 0xffffffff, and I don't know how that gets
> computed, as it is derived from the same number in
> info.shmall = in->shmall;
>
> Are you running this inside of a container that its own ipc
> namespace?

No.
Running on the real x86_64 machine.

- Naresh

>
>      Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
