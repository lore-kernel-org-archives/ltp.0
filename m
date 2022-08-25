Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D5EC04AA5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 07:43:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20E923CA417
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 09:43:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6A23C9672
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:42:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B288200B83
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:42:57 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id c93so279241edf.5
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=pTSOf4yZBT6vxC8cWVxq54me3auAZtvDfhz2BczVtgE=;
 b=Ig6BLIDsaP7fwO4f2tblxSV8D0IEZ23t5746evH4pnH6oehSyZT/w7P79opUL+FnmK
 po3y3tMhPtweDHchzB18ityI3jwyATZyGSAP0WrqhvTn5ohd5US0JPEFOAGmxSk5vacw
 sKRqdCKWOUSMVwQEX9dCud+27HCTh3lUtbqk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=pTSOf4yZBT6vxC8cWVxq54me3auAZtvDfhz2BczVtgE=;
 b=dj6BqyWtX7rtWoX+K6C8ea+FX/3HU+Wr7mke3g8bOXjG6UZFzu2CiH8lLwdwpg14zn
 hoUaHlHh4+LLL3jQccp8rCSorIVnjD9P2GkbqUhiW89/9plTQHGFxvr4bcLRi8J6s8a+
 9JDU9xH5pVi0kzdvcszU2hTEd+IVUdF8DtDLyXYIRaAH5AU82yW98GJuUfnSBc4fEmZe
 zkbXR/4/fA0y5ZvhceEH7PtBUkY9wCYO9IK4zqB4Iwb0U/V6Kd1puGpCHX3yj7Cj3q7p
 XtMXtJAltM43ePQfzltWx/Vt50iA9ErLONQWC4oaJzIu9FSZyjZdHkXLrtrtktGRdQX/
 j5ig==
X-Gm-Message-State: ACgBeo1aNjb7kDhDPqH7iOA5LlRw/1jjAu4xRCaS+p0plzOIx346jtO6
 /RthsrdTolkXbZs6Pvp9Fgah79+3djFaKLmuatM=
X-Google-Smtp-Source: AA6agR7BONL3rVjMUxd6TfWgLzL3hD1AQaloim7wlvJlAAbaMCgNwIwfFqxchgvEX79DIE09vA3OAQ==
X-Received: by 2002:a05:6402:1041:b0:446:b290:ea94 with SMTP id
 e1-20020a056402104100b00446b290ea94mr2045384edu.389.1661413376358; 
 Thu, 25 Aug 2022 00:42:56 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com.
 [209.85.128.52]) by smtp.gmail.com with ESMTPSA id
 q24-20020a170906b29800b0073a62f3b447sm2095609ejz.44.2022.08.25.00.42.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:42:54 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id
 n23-20020a7bc5d7000000b003a62f19b453so2189701wmk.3
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 00:42:52 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr1402129wmj.38.1661413369950; Thu, 25
 Aug 2022 00:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
In-Reply-To: <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Aug 2022 00:42:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
Message-ID: <CAHk-=wgSx8O0=p18C1aQuH4Gw7xmKujBKMEiSitCA7oG2h6WLg@mail.gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
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

On Thu, Aug 25, 2022 at 12:20 AM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> This patch is not about kernel, but about the section 2 and 3 manual
> pages, which are directed towards user-space readers most of the time.

They are about the types to the kernel interfaces. Those types that
the kernel defines and exposes.

And the kernel type in question looks like this:

        struct { /* anonymous struct used by BPF_PROG_LOAD command */
                __u32           prog_type;      /* one of enum bpf_prog_type */
                __u32           insn_cnt;
                __aligned_u64   insns;
                __aligned_u64   license;

because the kernel UAPI header wants to

 (a) work whether or not <stdint.h> was included

 (b) doesn't want to include <stdint.h> so as to not pollute the namespace

 (c) actually wants to use our special types

I quoted a few more fields for that (c) reason: we've had a long
history of getting the user space API wrong due to strange alignment
issues, where 32-bit and 64-bit targets had different alignment for
types. So then we ended up with various compat structures to translate
from one to the other because they had all the same fields, but
different padding.

This happened a few times with the DRM people, and they finally got
tired of it, and started using that "__aligned_u64" type, which is
just the same old __u64, but explicitly aligned to its natural
alignment.

So these are the members that the interface actually uses.

If you document those members, wouldn't it be good to have that
documentation be actually accurate?

Honestly, I don't think it makes a *huge* amount of difference, but
documentation that doesn't actually match the source of the
documentation will just confuse somebody in the end. Somebody will go
"that's not right", and maybe even change the structure definitions to
match the documentation.

Which would be wrong.

Now, you don't have to take the kernel uapi headers. We *try* to make
those usable as-is, but hey, there has been problems in the past, and
it's not necessarily wrong to take the kernel header and then munge it
to be "appropriate" for user space.

So I guess you can just make your own structures with the names and
syntax you want, and say "these are *my* header files, and *my*
documentation for them".

That's fine. But I'm not surprised if the kernel maintainer then goes
"no, that's not the interface I agreed to" if only because it's a pain
to verify that you got it all right. Maybe it was all trivial and
automated and there can be no errors, but it's still a "why is there a
different copy of this complicated interface".

If you really want to describe things to people, wouldn't it be nicer
to just say "there's a 32-bit unsigned 'prog_type' member" and leave
it at that?

Do you really want to enforce your opinion of what is prettier on the
maintainer that wrote that thing, and then argue with him when he
doesn't agree?

                  Linus

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
