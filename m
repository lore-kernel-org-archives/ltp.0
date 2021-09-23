Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BCC433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:25:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B758560F39
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B758560F39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B7B3C8FA2
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 12:25:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 983373C8F5A
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 12:25:26 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BFB34600FA5
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 12:25:25 +0200 (CEST)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTzKW-1mL4D83gzC-00Qzpu for <ltp@lists.linux.it>; Thu, 23 Sep 2021
 12:25:24 +0200
Received: by mail-wr1-f52.google.com with SMTP id t18so15819973wrb.0
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 03:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM532lGUINq3EPRAbM6nPMY8Hnupov8KzTeLMlu14gB3rJXmyLJh1O
 cNKb6IQ0AehgsEAqFSO7OHYntR10AmG24FtMcu0=
X-Google-Smtp-Source: ABdhPJzC5Pos1T3UiHJSSsCIdXJofBl7ZfARwRkYsLQOoX39pi6HQSPjzuB5Y3XPLHj7prwJBhe6ePUG76CgqIgVldI=
X-Received: by 2002:a05:6000:1561:: with SMTP id
 1mr4003238wrz.369.1632392724385; 
 Thu, 23 Sep 2021 03:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
 <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com>
 <87fstvlifu.fsf@suse.de>
In-Reply-To: <87fstvlifu.fsf@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 23 Sep 2021 12:25:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3H3ZikSfqoeh0=PQQuFw6PTg2KgP+p=4G26ayuzgwQeQ@mail.gmail.com>
Message-ID: <CAK8P3a3H3ZikSfqoeh0=PQQuFw6PTg2KgP+p=4G26ayuzgwQeQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Provags-ID: V03:K1:9EkW7dyizVHq/hdEgVofZwj7YY0qzWBswEWe9mxrpTVh3LK2DNO
 cTl5ofDoxW2wLOLphXMcjB1tiGUWwOp4eS4bry482JdTy+UjhYYtbwjEbnDC7lTuwqjotKB
 DfHit0cGE826yuxBkcTrrJIyuCZYklXqV5j6d49fJpp8ImyeANJWoLKY0FLZWtH5taIE/cy
 wWIpwFdzhDEqU4ye+sByg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Dg44HUlcPU=:VQR5h1BeXm5EBN81fI7Iv4
 A1SgpK5QnGurKeauCOJX22Ss1ob5RVEWQHmHRagYbdcy1SQr4mkfP+UIPL/62BP/ax0uINKAb
 JEWQ+w+UzjWlBESQTWKJKWJ1hP5lXwmxO9WsuU+KSBMrtn58vBJ7sGfMJlFYjp8FYRte7sLPH
 RtzvF1hoJQ9/2iO4fMxYAMXFRTkLVt3JmhhlqJDXOtzt/Sm2hve/0KflLEoIVj/vXIEzbsWgs
 GJQxaIUXkRj8Va46dBXEhQbQPxF20ehYk+Sd0zZ1sZZjLkvME7q/dQeouc9UWNmNlMWCOsuuj
 CN+289CI7xfKbAwp3gZoxzyMu51b7/71bCy4nFNFanAVE57wzGP52pbfdxLScegkDWQOXJRSl
 yFrWb5a0wUHVf/214LjLnUhyiCZJbP3cDjIw4WLY/oibRJhZ38CsVd4aAxw6N/52N97XFs8yD
 tfev+7mhfaYoYXTI/g2V8h65eBYAzxL3GT/zfp5VJtRx2xUwn8Jg4NICE/zs0xhrrxdZ3zT6e
 WA1wNgxW+vFnLeRO2nxqEo46YN/OG7sFLMluhUWjbiY1VpVqGuPdXmBO498lfPngubtene1Hc
 /jCM4T6p2kIOWI1HbJP4APxhEc693uxIeXPWWo1oRHy7VivCKJmElJjcdWFPUQGhB52Z7d9JY
 SD5EoLAehfQ3LfxpLhFmiXd3uk3uurqDp7rUaOA2YOJ1LJtxNjzFp3EsWpzLb1txIxfW1Nt6W
 G/PWTpYlHKUQ2YY7/WMKDrXwXxWNSI9x9acuBKMLz1P2UbKnAx+08cFzOCRFNwgze3Fjaqr5X
 p8AmGlB1Kwr9CdbZiBDlSuvEOUoXRkOYwHcB0iEA3MHC+Rwll8+j0hzGd3lqItuPumLPjRAmZ
 tItwTN5XHvGMgfXml0Og==
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ia32 signed long treated as x64 unsigned int by
 __ia32_sys*
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

On Thu, Sep 23, 2021 at 12:01 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >> Richard Palethorpe <rpalethorpe@suse.de> writes:
> >
> > I also noticed that only x86 and s390 even have separate entry
> > points for normal syscalls when called in compat mode, while
> > the others all just zero the upper halves of the registers in the
> > low-level entry code and then call the native entry point.
>
> It looks to me like aarch64 also has something similar? At any rate, I
> can try to fix it for x86 and investigate what else might be effected.

arm64 also has a custom asm/syscall_wrapper.h, but it only does
this for accessing pt_regs (as x86 does), not for doing any
argument conversion. x86 does the 32-to-64 widening in the
wrapper, arm64 relies on the pt_regs already having the upper
halves zeroed.

        Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
