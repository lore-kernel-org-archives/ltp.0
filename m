Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE1EC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 20:49:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAA713C8DC6
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 21:49:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3B133C0D0B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:48:57 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CFFA51A004AD
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:48:56 +0100 (CET)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMFdY-1n6Ngf3y1m-00JHh3 for <ltp@lists.linux.it>; Mon, 22 Nov 2021
 21:48:55 +0100
Received: by mail-wr1-f53.google.com with SMTP id d24so35100986wra.0
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 12:48:55 -0800 (PST)
X-Gm-Message-State: AOAM5333s66OC5piYsDOuS51H92AXXPdwzilGM0RLzTBgNoEOAVK2kZY
 THgamuicvLnzqir5GQwSMhLUIAvn/ECezXKizeA=
X-Google-Smtp-Source: ABdhPJwf+d8ctWPtfnfnh90ZtW1kb/NXAtGxWpODV7GJ5lqYNV7ntpKGV2T3UpIDDYaCPfzwOX3Viuecq2sgKQ0oXhg=
X-Received: by 2002:adf:df89:: with SMTP id z9mr80369wrl.336.1637614135426;
 Mon, 22 Nov 2021 12:48:55 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Nov 2021 21:48:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
Message-ID: <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Provags-ID: V03:K1:foi9f2ELqVpijqDiZPrIiB4Ag3nIH358xJNDqiUcsocqlgJiHqC
 epoNKHRGOZqXOlMzFQ4UL4MuFQg23S1LlQHKaRVavVMH9dsIvnAUmnRQt/cX3QMj+rUKuTk
 tryXJibvf2ceNhQ3W2D8/0Hd+SdVkBifc84/NBoQje2O47UWxTgKXBCGDd9yHK1gepvtLuB
 TZc5gFF9TKJXNYRB8Zp4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qu6/jJO5XvA=:PcXY79prnptPRTSHb2E/qf
 kp0nZAGPNVLe5JqNV0l3hQbz3wAA/ZErVvmXHG5aZkpllFYLiXFfnbLxjYUj3EphqYlHTywGt
 Dc6pH6bPHg/y1DywuW9viR6hVo8jdhYKTEa+7lw92JPP4wtbf7wq3q/vwsVgNXkBt7zJl/xLp
 aun6Ayoe8eRbWL7msNbU5l9KfYrMVwSf7KWUM8YNUt6IdGJAB5auSvXhxNfbSqS1m6ipnY/EL
 C1AWjxo3RHus6aI+rU/7VikB0hbH2140cETkdi17hsGQ8va8Qu24DcHGbA8uKQ3iURCrBY1b+
 MmF8pj28ZRqofYMDDjqcBGCkCKhgRNFLGjEhYZJQHvPtpdjO+Qim7R3e/fdzrzBblI/49MBOp
 aJwiYzPOQQJhzxhZMSEQMy403MJTs4EAOJw5C/bxH8x2u/p5gPAXH4wUVk+Iu/tZiCvvs2aHh
 e2XKlUeDIKHJ8htJ+P8PHiGBfodPJv2F7KySwYtAAA5q8XnqWjPaTguk2Ab7rxiUKxOwAEBlA
 AEFUCM3U7h4KgLg8ZBxWis4j2X8iYPkKsqBHEcAfPg26EM7O4wIhz46Dxhc/KO+sZSF50St+b
 V5+MxOOeSOIK2F9enLQSCIdq3/JyH2XlMiw243h+czYfT+VTkbgBtaY3lFbLsSPH6ZZjqPZR9
 RbDn/jdcKh86sTyDTKU9qmw5MWCrjc6V4ykmEojRsUZTig7UtOcBW6CLP000SZN4lWlo=
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 22, 2021 at 5:43 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> +
> +#include <asm/bitsperlong.h>
> +
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>   */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif

I don't think this is correct on all 64-bit architectures, as far as I
remember the
definition can use either 'long' or 'long long' depending on the user space
toolchain.

Out of the ten supported 64-bit architectures, there are four that already
use asm-generic/int-l64.h conditionally, and six that don't, and I
think at least
some of those are intentional.

I think it would be safer to do this one architecture at a time to make
sure this doesn't regress on those that require the int-ll64.h version.

There should also be a check for __SANE_USERSPACE_TYPES__
to let userspace ask for the ll64 version everywhere.

          Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
