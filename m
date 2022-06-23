Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE2CCA47C
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2A9D3C9486
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 09:48:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFEDF3C3129
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 09:48:33 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E59E960004B
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 09:48:32 +0200 (CEST)
Received: from mail-ot1-f54.google.com ([209.85.210.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MP2zs-1oId240kdo-00PLuR for <ltp@lists.linux.it>; Thu, 23 Jun 2022 09:48:32
 +0200
Received: by mail-ot1-f54.google.com with SMTP id
 7-20020a9d0107000000b00616935dd045so1303055otu.6
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 00:48:31 -0700 (PDT)
X-Gm-Message-State: AJIora9PLQopAMymtfA6KrGTrSmoryTcVZUkmnKWkWud0rGuW1018kkk
 WkGHTTq4fd2JTTyzfLE50syvIuH9575KbZu9hQw=
X-Google-Smtp-Source: AGRyM1uHkBIdCkI9mpCrsEZDA8zvdmE7/Fo1G/+3sQac7LSyKfcZpANe6OOE8iPxe+xA5YpR3xLpoECCt9dTyF/gSRw=
X-Received: by 2002:a9d:4a8:0:b0:60c:76b1:f1be with SMTP id
 37-20020a9d04a8000000b0060c76b1f1bemr3345332otm.347.1655970510870; Thu, 23
 Jun 2022 00:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220621120355.2903-1-chrubis@suse.cz>
In-Reply-To: <20220621120355.2903-1-chrubis@suse.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 23 Jun 2022 09:48:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2J5k2ub6TNu9qDympdWEdQkqpbL_SqAznpwaQa+S9kXQ@mail.gmail.com>
Message-ID: <CAK8P3a2J5k2ub6TNu9qDympdWEdQkqpbL_SqAznpwaQa+S9kXQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Provags-ID: V03:K1:P5CDbFV7CtkcUIp53/C++ClHlWHETBNkvUHAjn4FrVkV3qN8gGw
 kHPyJnHukAYKG9zpmAXVx7MCaK11djEzAD3yUxEQuUyYeP5uAM0VmKip3UihDupOnlYETp3
 ioNLSRuGR5iy2X/jfDHLxWVGQ/r0yIX0J5jma94S1iiINYmDVOXGBKoyp5B57CuVmd8gtn1
 PAeM9rT1Ba9Tx0UW/yZOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rpRioXiD/A=:AM4xew+9WOXmIZVbeepPHS
 cjp/ulFQzpozkqUAIdLs6BAeY8LvEi7GnqelwwzhtuG0JZJmHWwcy8VtcVDvD6zZgEPf0NydQ
 a0DdkCURfWoc8NFpAh0Ff/2UkaubRODTZJUkw3GWTZCkpapQoxN/tfO8Tpmh6978micTj9f4n
 8PJecCtGu3QRRmzlUsVvYcR2I1KYPdMuhglaySk7ma73jIUY0+3YRdnb62EAsapW3VZC6llip
 ysqXSB0DCVsEfDXf8sUrOwbFOJuFrY0lHMubaPMmN26j8kZAhPVlyPdywzFyhvxg1QK8hj7mI
 rjZj6fQPMKBQKGaKihU6gC2fPyAeASBEpVL3AguHEvioD/nd5by7LJ+3AnuF5o7FWqZeX/HIg
 IzgBMGH44Bge6bTd4Eanrk3NbX86hOg1SPlCWA1Cvn5BuZSWtRMjvpwcp2kEexhLkt5rpg7xw
 3VAqU7/g7slkDFTxf/eQKBU2A5h6c/X6bc6/nxe44hoTN0tcHr1A64VeXERm6zUx3hja8UPlK
 v5/YxmxieF/FzjpqOMFhErNys711ocDy7DWU9mY9dQfBqVZ3jKU9UrpsBHyL7SgCH5uVAirc3
 d9nTJEdrxYmPbYHgK/2/sNCFbJTvFTybgkRE26NRpAyiuBTJwk7aY8G4THzW02Xss2S+FFj4x
 V0DsvXs9otBcp2CjlfQUTr+HJcbEjP0BbbcT7SCvsQJgVuz8FPp8+ng9cSVXF6ogylPMK3aC4
 M+SH7p7IJqZN9DornBEIQ9PGIi9T97/07xorLZFg52BcTTX0CVbdYxTeO69U5fBX/e2wHw/5y
 z4ZmoR1NDF9eZSJ1NYjD+fGPwRgN/LGcuUCjcJTj2slofk48nz9xzVpJE8D42JHri0NmYa4ud
 SW4x7DmDSRv+LVDv173w==
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] uapi: Make __{u, s}64 match {u,
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
 David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>,
 Zack Weinberg <zack@owlfolio.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 21, 2022 at 2:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace for C code.
>
> We cannot make the change for C++ since that would be non-backwards
> compatible change and may cause possible regressions and even
> compilation failures, e.g. overloaded function may no longer find a
> correct match.
>
> This allows us to use the kernel structure definitions in userspace in C
> code. For example we can use PRIu64 and PRId64 modifiers in printf() to
> print structure membere. Morever with this there would be no need to
> redefine these structures in an libc implementations as it is done now.
>
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
>
>         printf("%" PRIu64 "\n", stx.stx_size);
>
> We get:
>
>         warning: format '%lu' expects argument of type 'long unsigned int',
>                  but argument 5 has type '__u64' {aka 'long long unsigned int'}
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

I understand the problem you are solving here, but I'm not convinced
that this is actually an overall improvement as you introduce two
similar problems in its place:

- any application that has previously used the correct %ll or %ull format
  strings for members of kernel data structures now gains a new warning

- After your patch, neither the PRIu64 nor the "%ull" format strings are
  portable across old and new kernel headers, so applications are now
  forced to add an explicit cast to 'unsigned long long' or 'uint64_t' to
  every print statement for these members if they want to guarantee a
  clean build.

Do you have an estimate of how many build time warnings in common
packages actually get fixed by your patch, compared to the number
of warnings that get introduced?

        Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
