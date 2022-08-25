Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA588C04AA5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 07:34:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 949BD3CA441
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 09:34:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDBD43C3090
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:34:20 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE7981A0044C
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:34:19 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id c93so254832edf.5
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=/oj50hsl8kbfl2r5TD7WwWtw83gdRut5PdToYGpC4Ik=;
 b=Goy06y0aydlFdewFjaQoeuV6+94AF3G4Kd5MnBCFsRmAguUDtmTDpQb6gSDsC8v858
 O/sDYoTbg6PSw67ijrEnRK2ZAHwB9YaQefNZl+U/92XlmmBmO0tImfXBiXc6OEXrm0Mk
 aFgclEQ/Wy3ZKJgW2dVbRAOlKaWpWn3UCrdcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=/oj50hsl8kbfl2r5TD7WwWtw83gdRut5PdToYGpC4Ik=;
 b=qiOmWVBe3wVJFXY8NuvSkh2yQlAshzSZjtyNHGzU2qv8xa4SokKdIKhc0hHonSmiMF
 B3SXONkxN7Xsg/F1zoeRIfI6m11rl3KdFwcJg8AE62O4gYO3oiK1MpfxwdiQSgCXk1+h
 /Anzq3epyGdd0E6lZA/z4jbu0MWewyfoIg5TmgwUl8HUAueuzvklnU+q+Nugo/fnAHVe
 KCe0nDI7d8vfqs79BXJkxJzkM/4syD8xPHL4QpdtPTfcCV/+ZyKQ3a8c92PByGyAa7Hn
 iqpkaAL1n1A6hnUS6YgSJcIb172HJcVfpth5Cy2MQ2EAGfsNLqC9e51Lbn7+6ec8xptp
 YZjA==
X-Gm-Message-State: ACgBeo2plX8OQMTC7xJn26YydKBAY5x5NeeCzDhNZBit6oMiMJUvR3it
 Tr9TP0A1/3sN6N2AGTKVW/FEcuXY8broKMEhyyA=
X-Google-Smtp-Source: AA6agR6N+s2IyUDHeEf/dglT3byuUrs/PZmXXCROK3cvcSPQY/7uBnbRh/YBJZmbmJHEPmNOfAQBHg==
X-Received: by 2002:a05:6402:43c4:b0:43b:c5eb:c9dd with SMTP id
 p4-20020a05640243c400b0043bc5ebc9ddmr2060793edc.402.1661412858921; 
 Thu, 25 Aug 2022 00:34:18 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 t26-20020a50c25a000000b0043bbc9503ddsm4359334edf.76.2022.08.25.00.34.18
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:34:18 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id og21so312918ejc.2
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 00:34:18 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr1385724wrv.97.1661412462666; Thu, 25 Aug
 2022 00:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ilmgddui.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Aug 2022 00:27:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
Message-ID: <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
To: Florian Weimer <fweimer@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Many pages: Document fixed-width types with
 ISO C naming
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
Cc: Alejandro Colomar <alx.manpages@gmail.com>,
 linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 24, 2022 at 11:41 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> The justifications brought forward are just regurgitating previous
> misinformation.  If you do that, it's hard to take you seriously.

Pot, meet kettle.

> There is actually a good reason for using __u64: it's always based on
> long long, so the format strings are no longer architecture-specific,
[..]

That's a small detail that yes, we've tried to avoid the absolute
humongous mess that the C standard library has with their horrendous
'PRId*' mess, but honestly, it's just a tiny detail.

The real issue is that we want to be able to control our own types,
and our own names, and in the process have sometimes been able to
standardize on types that makes it easier to just not have to deal
with "oh, somebody picked 'int' on this architecture, and 'long' on
this other, and they are both 32-bit types".

We still have to deal with that for '[s]size_t', but that's such a
standard legacy type that thankfully we have the whole '%zu/%zd' thing
for that.

And yes, sometimes we screw up even *though* we were the ones that
picked the types, and we've had pointless differences where '__u64'
could be 'unsigned long' on a 64-bit architecture, and 'unsigned long
long' on a 32-bit one, and then we were able to fix our own little
broken type system exactly because it was *OUR* little type system.

So you are correct that then in the specific case of '__u64' we have
been able to simply just standardize on 'unsigned long long' and make
printf strings simpler.

But you are wrong to think that that is somehow a special thing.

It's not.

It's very much all the same thing: we have types *we* control, and
thanks to that we can do them the way *we* need them done, and can fix
them when we made a silly mistake.

In other words, it's the whole *point* of not ever using 'stdint.h' at
all for those things.

(It's also about avoiding the kinds of unholy things that happen in
system header files. Have you ever *looked* at them? Christ. The
amount of absolute crap you get from including <stdint.h> in user
space is scary)

> You cannot avoid using certain ISO C names with current GCC or Clang,
> however hard you try.

You  are now the one who is regurgitating complete mis-information.

You do it so prettily, and with such weasel-wording, that I know you
must be knowingly threading that fine line between "actively
misleading" but trying to avoid "outright lying"..

You say "certain ISO C names" to try to make it sound as if this was
at all relevant to things like "uint32_t" and friends.

But deep down, you know you're basically lying by omission.

Because it's true that we have to know and care about things like
'size_t', which comes up for all the basic string.h functions.

So yes, we have a very small set of types that we make sure matches
the compiler notion of said types, and we carefully use things like

    typedef __kernel_ulong_t __kernel_size_t;

and then we have our own 'stdarg.h which uses

    typedef __builtin_va_list va_list;

that is explicitly the one that the compiler exposes with those double
underscores exactly because even the compiler can't expose the
"standard" name due to namespace issues.

And no, NONE OF THOSE ARE USABLE IN THE UAPI HEADERS!

And equally importantly, none of those have *anything* to do with the
'uint32_t' kind of names.

The fact that yes, we care about what the compiler thinks "size_t" is
(because we do want the compiler to do memset() for us) has absolutely
*NOTHING* to do with uint32_t and <stdint.h>.

And I'm pretty sure you knew that, but you tried to make it sound like
they were somehow all in the same boat.

And yes, some drivers tend to actually use 'uint32_t' in the kernel,
and we allow it, but they cannot be used by user interfaces. So a uapi
file really *really* shouldn't ever use them.

And no, we don't use "-ffreestanding" and friends - we actually have
occasionally wanted and tried to do so just to make the boundary lines
clearer, but then that will make gcc no longer do sane things for
'memcpy()'' and friends, so it's kind of a balancing act.

> <stdarg.h>, <stddef.h>, <stdint.h> are compiler-provided headers that
> are designed to be safe to use for bare-metal contexts (like in
> kernels).  Avoiding them is not necessary per se.

We explicitly avoid them all.

We historically used stdarg.h and stddef.h (but never stdint.h -
there's absolutely _zero_ upside), but it was always a slight pain.

So we simply bake our own, exactly because it's simply less painful
than having to deal with possible system-provided ones.

People do odd compiler things with host compilers, bad or odd
installations of cross-build environments, it's just not worth the
pain to deal with the "system header files" when they just don't
provide any real value.

                        Linus

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
