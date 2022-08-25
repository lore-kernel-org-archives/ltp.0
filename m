Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E468C3F6B0
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 00:53:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E348D3CA409
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 02:53:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3303C941D
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 02:52:53 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7357260122A
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 02:52:52 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id z8so3531517edb.0
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
 b=YpSDVkBcxWVnnXfQXF/M7AZGWY5x+V+c24wMO5zVR8RFtXivElwnk0FLNTXke/emLT
 oh8/MGX4jyRJc+YrZXh96+Jtsdh8UfgCE6n4YSYTOMmu4AtkTQJ7laVjSVHJm8+QclNG
 oVzUJs4I5lvMg1LyJ9KO0CmiPyQ9FIcsSPJtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=ot0aEvyT380VjDU6PPl13tz+5G5649T71Q1QmyiGXIo=;
 b=45gbI8yzvp+ERatTr8u2XKlHvNQPm90o8vZr7hAlfjjIcDc6yvQLy4ohAFJ3HjJAAQ
 b/wbJaBAxIKfaYllGYhe6PxsYtEghjCuHnL28qb7DpiIbxlVCB0nsbVKRLSlTaU4FhSB
 rM9p1IVk9aKATWClrB7ifksjqJYeYbG8smWa2GUSxZlQ1qbGXPXUWJS2aQjSMXOpac2B
 mKodCB0ViHWjnTA7PzFe5Co80LP1zz75Z8EyaBMqxkSoL/kByQsT/bKFBTrSpJjavhNU
 uJqQTwQcQiBqAdIhoEsQVt4Is6+BCYROyeEt1uvORgN4qepUAth0kL7Fsr/4za/qZEAJ
 WBWQ==
X-Gm-Message-State: ACgBeo1E15WQqcaIg9eQnp7jPGH9cyJX3uoO2YIwI8PfofpZyqhsnOm0
 s+ALxMKwFQ/svW8Jfb+XLWLR0sD3JX61S64xdwc=
X-Google-Smtp-Source: AA6agR41MaZsyGcRAtjVAlwrgr3FWrafwz08RXRMg5xe0vzSSPvLnp23SJC8qswT1JNmocufsKBCUw==
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr1171999eda.75.1661388771720; 
 Wed, 24 Aug 2022 17:52:51 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44]) by smtp.gmail.com with ESMTPSA id
 b2-20020a1709063ca200b006ff0b457cdasm1795919ejh.53.2022.08.24.17.52.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Aug 2022 17:52:45 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id z16so3891891wrh.10
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 17:52:38 -0700 (PDT)
X-Received: by 2002:adf:e843:0:b0:225:221f:262 with SMTP id
 d3-20020adfe843000000b00225221f0262mr764111wrn.193.1661388757863; Wed, 24 Aug
 2022 17:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
In-Reply-To: <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Aug 2022 17:52:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
Message-ID: <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
To: Alejandro Colomar <alx.manpages@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On Wed, Aug 24, 2022 at 4:36 PM Alejandro Colomar
<alx.manpages@gmail.com> wrote:
>
> I'm trying to be nice, and ask for review to make sure I'm not making
> some big mistake by accident, and I get disrespect?  No thanks.

You've been told multiple times that the kernel doesn't use the
"standard" names, and *cannot* use them for namespace reasons, and you
ignore all the feedback, and then you claim you are asking for review?

That's not "asking for review". That's "I think I know the answer, and
when people tell me otherwise I ignore them".

The fact is, kernel UAPI header files MUST NOT use the so-called standard names.

We cannot provide said names, because they are only provided by the
standard header files.

And since kernel header files cannot provide them, then kernel UAPI
header files cannot _use_ them.

End result: any kernel UAPI header file will continue to use __u32 etc
naming that doesn't have any namespace pollution issues.

Nothing else is even remotely acceptable.

Stop trying to make this something other than it is.

And if you cannot accept these simple technical reasons, why do you
expect respect?

Why are you so special that you think you can change the rules for
kernel uapi files over the *repeated* objections from maintainers who
know better?

                  Linus

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
