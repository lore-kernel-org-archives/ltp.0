Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761EFECAA24
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9F013CA48F
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 18:43:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D29D3C0134
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:43:31 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 113221000411
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:43:31 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id h22so30414736ejk.4
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
 b=h5BQlI0xIEyNRWKjxWMt8RcIcaw6Iab9Lro//TN7cNvmYLCYmjHA9b7vqil1aO5lR2
 jjncnbXB0E5n8vUT5r/OBW2cdzESp8HNiF0+6Am4i8gbPE/IF29BiN++mET+t+9HhGXy
 KU+7dVHbSPecBR62YILXw08KL2z9er7opHtdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Zej4CxY/1CWynJQcpIFCE/ePm/cZkXwlSREUqfzuJ8Y=;
 b=HyuYV+vz2qF5G4UJMxKRc+agb49tb/eZzdSxGMy8s30ut9ojp+IBh+R4tqMTjS0YB7
 s32AkCth0THUmi5h0W+7oiYwPfIJyOG6uidW48VHl5B430tDzTpaDYNbu4VRBq+GO3zE
 PIV3jrPKg0twK6jjuh/rxtowX+zEBE/MwHRRJ1BFs2T9ukrfwCflIgXdNsOo8AqU77iB
 CSLjVWKTHmql1hSJWnr3Q2nu7eSkw0fVLlf43Bx6EppfP3CWVxbzSe+hzja5Yjec4pDT
 jfsACT7A2MGn5NDxRX0uFOIwAYUp09WMUQlUpAiLEnRUDJjQNRejsxFpQP4Tuvnz62to
 LPoA==
X-Gm-Message-State: ACgBeo0IVUT316sTvxCV/9fGaOsenRB+fsYK1L0QBMm5OdkRYTrqSf+M
 umlpbj6kZHb78eSEtVWBg5bH7dCTMM56PP6JFVk=
X-Google-Smtp-Source: AA6agR5Ltp6P8MtPvso0KrCcWyb/BDLyffL3bamM5R/PBbsiY6i5ti39shF7qDYULk//FiSXe22hMQ==
X-Received: by 2002:a17:907:c0e:b0:731:614:e507 with SMTP id
 ga14-20020a1709070c0e00b007310614e507mr3072571ejc.529.1661445810134; 
 Thu, 25 Aug 2022 09:43:30 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 d7-20020aa7d687000000b0044786c2c5c1sm2872318edr.3.2022.08.25.09.43.28
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 09:43:28 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id a4so25386631wrq.1
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:43:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr2680808wri.442.1661445807749; Thu, 25
 Aug 2022 09:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <87ilmgddui.fsf@oldenburg.str.redhat.com>
 <CAHk-=whsETo4kc2Ec1Nf4HQY5vKYmRi9et243kyqN4E-=PgKJw@mail.gmail.com>
 <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.22.394.2208251435370.104368@digraph.polyomino.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Aug 2022 09:43:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
Message-ID: <CAHk-=wgWiU_KjueEE1Mi7rk6NCKaQRE=5hQaQC+2MY6-CabKFA@mail.gmail.com>
To: Joseph Myers <joseph@codesourcery.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

On Thu, Aug 25, 2022 at 7:38 AM Joseph Myers <joseph@codesourcery.com> wrote:
>
> I've not yet implemented it for glibc or for GCC format checking, but C23
> adds 'wN' format length modifiers so you will be able to e.g. use "%w64d"
> with printf to print an int64_t and won't need those PRI macros any more.

Yeah, that's going to help user space.

We don't typically have huge issues with it (any more) in the kernel
exactly because we refused to do the syntactically horrendous PRIxyz
thing.

So in the kernel, we still do have some format string issues, but they
tend to be about "different architectures and configurations do
different things for this type", and those different things are sadly
not necessarily about a fixed width.

IOW, we used to have horrors like "sector_t can be 32-bit or 64-bit
depending on config options" (because small machines didn't want the
overhead of having to pass 64-bit things around - from back when
32-bit was a primary target).

We got rid of *that* thing a few years ago because it just wasn't
worth supporting any more, but some similar issues remain.

So we still have a number of cases of "if you really need to print
this out, you need to use '%llui' and cast the value to 'unsigned long
long'".

But it's happily not as common as it used to be.

                 Linus

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
