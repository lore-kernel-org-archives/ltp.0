Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E97C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 13:33:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B65B610E8
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 13:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B65B610E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEBE93CA2C5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:33:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E57863C2435
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 15:33:12 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73B0F1A000B5
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 15:33:11 +0200 (CEST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmU9R-1nAIFj25lx-00iUFb for <ltp@lists.linux.it>; Tue, 21 Sep 2021 15:33:10
 +0200
Received: by mail-wr1-f54.google.com with SMTP id d21so39177119wra.12
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 06:33:10 -0700 (PDT)
X-Gm-Message-State: AOAM533dOkLVeRe/V4K7qwJPpqAjWcDNqhv5mf+zBeFLwgDvKPFTUg7s
 a4UUULTVC5iyBBix7Qe0wO1YgO+r43sIUazi7yA=
X-Google-Smtp-Source: ABdhPJxRIj5D47cQHOOP5MhzKSO5m6QcwBx7ekdGgjsOCcTSMmeomDdEql9MadmQK5oL6aEohxff777ifq2jViQ91sU=
X-Received: by 2002:a05:600c:3209:: with SMTP id
 r9mr4658602wmp.35.1632231189987; 
 Tue, 21 Sep 2021 06:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com>
In-Reply-To: <20210921130127.24131-1-rpalethorpe@suse.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 21 Sep 2021 15:32:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
Message-ID: <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Provags-ID: V03:K1:uhtkxgcBR7maIDEP4gS2hT0ghyz+HI9qWGbbgZ16RVKIIZw1emj
 P7OJSWhaL/znxED6Clk2JCOnocRDm7op6OaqUB+FUNRODx8WRhfJ8AdGEsb1kosBLJpgKVe
 Wt003JRUeqM0uGsAZKEnV1+ew7uB1PIsyKiBPl1k3nnxCCQdA1wTcQw8fWH0pnqIB5QC8Xz
 7lcMSxxTthRmTOwO17HAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1bKRp2PbnP8=:HW6s24yFBxrfjEWJUC9H+4
 W/xyyl6FtlpBqTOhRiL2uzI4WblFXARwpL6rTwk2fnYsBVWyJzIEsvQ8vHdh0rhX1/1CTFg+b
 Hs2pkXwGFpzbnUMvpjdQXtYk0hAh7Lu9APf6nUwGiu7yM4pg4luAVHV3nsDN8SrdWUZ3wyPjz
 x6hR3AhjqJR+UEDzHiBv7JOhf8EdC7qyBDS0Gbtc2nS/Hyy9ou3qO9QZLtA32+XBni/9XATQa
 wEmkIF0Snt1o+1+Xg7KEzpxvhnI4N1PfboKVHJQgMUPeW9YdCQULEwFEk7XgRUArDgbXqpkcO
 e1gMCrQWk2/6zGBhBRfM0j2KTQFTsw93hHzkoMiIWq+ZJLOhYbnQMQJMmaz+to67o9sxnPABR
 np2a35f0TE7lJaPLhqyX+xYyKVM1mq/yIH+eMi5d4fJazhMzyi2Ej4xzB3T6UKoV53Qyt7eqa
 aWVUNFVf3CGwx0xjB0JirOdGxxjFXAJ0oro93BP14FW6NXLzzPBzFlKY4DRL5pj9s1Iq9klZQ
 ZM3z0/zShoAMhDaxPv2gPb5z9EWw0HWYFQi6aSbIN8Kfjjuxefx6KvRi4eTEGXAXWKDriMZJU
 gKW/utIH3Mu3hd7GoFdmIpZGsz6FPhAoloWxHjZxDIVucAQ4Tfz7po8ZQ3ntFhdZnEYMDjWK2
 YorRanOzoc+7WSmDZDb7rv/H++cQaNjm4LTkUuTPkW3LnqhThCR2K/qnLWRfjJKExsffP/F64
 kmugdAKIxqYtXI/Lp5wVybnvxhWp0V+Jp5kFdA==
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for
 x86
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
Cc: linux-aio <linux-aio@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 21, 2021 at 3:01 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> The LTP test io_pgetevents02 fails in 32bit compat mode because an
> nr_max of -1 appears to be treated as a large positive integer. This
> causes pgetevents_time64 to return an event. The test expects the call
> to fail and errno to be set to EINVAL.
>
> Using the compat syscall fixes the issue.
>
> Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks a lot for finding this, indeed there is definitely a mistake that
this function is defined and not used, but I don't yet see how it would
get to the specific failure you report.

Between the two implementations, I can see a difference in the
handling of the signal mask, but that should only affect architectures
with incompatible compat_sigset_t, i.e. big-endian or
_COMPAT_NSIG_WORDS!=_NSIG_WORDS, and the latter is
never true for currently supported architectures. On x86, there is
no difference in the sigset at all.

The negative 'nr' and 'min_nr' arguments that you list as causing
the problem /should/ be converted by the magic
SYSCALL_DEFINE6() definition. If this is currently broken, I would
expect other syscalls to be affected as well.

Have you tried reproducing this on non-x86 architectures? If I
misremembered how the compat conversion in SYSCALL_DEFINE6()
works, then all architectures that support CONFIG_COMPAT have
to be fixed.

         Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
