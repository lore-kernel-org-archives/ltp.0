Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57870C433FE
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 14:34:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17E1D3C4F4B
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 15:34:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09D6A3C4AD9
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:34:38 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 58C01200C65
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:34:38 +0100 (CET)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McH1Q-1mJTNZ2PgC-00ci4G for <ltp@lists.linux.it>; Mon, 29 Nov 2021 15:34:37
 +0100
Received: by mail-wr1-f52.google.com with SMTP id i5so37288438wrb.2
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 06:34:37 -0800 (PST)
X-Gm-Message-State: AOAM531F6RCOBlZnOMfJAIYZyMzCRG5hpW2u4QumhGvaKMp4ZMLhKeUA
 CB9NmE7Y2BaQekDu7dMG68XK89bG15pLpBGr3Ok=
X-Google-Smtp-Source: ABdhPJyXREqU8kKGWYixStrxiAg8L4JSL6SJLG6LnHyFXcHPbgouHOXEYlIbqnHI43DcIJk+Fnqff7ZB74EzR6XRxRY=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr34125698wrp.209.1638196477109; 
 Mon, 29 Nov 2021 06:34:37 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
In-Reply-To: <YaTAffbvzxGGsVIv@yuki>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Nov 2021 15:34:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
Message-ID: <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Provags-ID: V03:K1:bN4ag08ug9jfQyQdV1jSSF6cdX8lhJyePmCp8uYq48SNo8MptfV
 VVj8qvCcJ/1h3F+bqoz8djzX4oM3oCtmKfOwxkn2NJ9XwmgR1Fs8DSJgcTWSkdJrGGkunYi
 BTV4dzb6YyAfN6IFdiR+d2Tr5IAxUQ4bfCwPBci+2nBXDAAev0v41o8I6+Ihlb3RKDkaW3y
 lEg5CZdVV5Z9colZV/pqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J/mGgfZp2pA=:OY1tcbI/PZHXNCyr0+15Yb
 spWbH7Pzx2CffsFzrZe5a8iZJLVNlCxkpwFfWfBN9lxnITGxlbp/SUXJrVMOm44AGiqxhHHom
 iK08mEQZRrC7Ra0kJ2FO8f9I2KIfovl23Ngzn3IQWl5og/VJJVtjEfre3uYsIVvaYFJQtNfVx
 h+aimOfFWTOpsH9ojFWjwv9wRI49AER/xyJtxhz+XUZKqOSOnyuc6OturyHwlh560Mrrs9rUm
 1Xbgzd9eOAPi/orGVhWSvbw3Wj7E7R/WKYBHd1bemEj8Uhm9Fn3w+wqVQv5eyoYi29Xy1YPzh
 TsJxNZAeHa43RJP02siUN5DE+kI+pJj+vfsZRFtxtYiiCAdiDu8V8bmckkWo5ba/pFhI3zvyR
 u2ucubitmEBTwOuSiNUxMZoQbxyPk3uZpmzbeszLrC0Ac/lvOJR4KpcquPWkINuFR6bc32VL+
 Hl2Dn5Tl3ulnn4GMC2fgpE2Ye3+Vq5r3P3QDyn0M73M+GmJxfPJp445WsRazki0OabTYb5qmV
 N4/VRJfr5uLkZOmwUjNFhJylQdEHWY1FTzkVTQNHg/feIvhSFkDLQNQZAeQqlRgWIpb004UO0
 W+eKNgidmS5xQmXkaUXJIE8iNNlx1jSlq7LnYiExO69mldlPssyxItxhlceALA/uw+fwyMhYZ
 Tw+YBDtNtr9hYCHp5g6zthseBNYYHH1fCJP9q/IFHiZ5Z5s0pklVGJR+A0EuUv/QX/uA=
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 29, 2021 at 12:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> What about guarding the change with __STDINT_COMPATIBLE_TYPES__ as:
>
> #if defined(__STDINT_COMPATIBLE_TYPES__)
> # include <stdint.h>
>
> typedef __u64 uint64_t;
> ...

I don't think we can include stdint.h here, the entire point of the custom
kernel types is to ensure the other kernel headers can use these types
without relying on libc headers.

While some of driver specific kernel headers have libc dependencies
in them, the general rule is to keep the kernel headers as standalone
usable.

       Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
