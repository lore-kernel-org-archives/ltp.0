Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F9C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 21:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 608793CA1A2
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 23:19:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 318DC3C931E
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 23:19:06 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6332060066B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 23:19:06 +0200 (CEST)
Received: by mail-vs1-xe2e.google.com with SMTP id o123so2749114vsc.3
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=+hfQ8wueaucFBGYQ+2wnV2w3LB+Nboj3w75I11W2FIw=;
 b=d5D9xQnhAr4ymdEODzhvTcX9tBFjQcE8naO1gXsHGS5q+ax/00GIcyv31SfZTsXGWi
 It0h4kfjFDa46ZSs1XsV6788ZvURTM7yVe4CdfFuH3lHW3taXn3M1iP/hMzPJMZdLhZw
 En+D2PdmP0xYMhmjUxO3ZcYiXLREOu5oSY2M4Q1QiOm/gHfF4hcVqdFdWr+Dqfzj1hhr
 MJVBKun2cpJvZV2uIZsVN+7OAoE0dibvu+VklBhNkBaGY+bPlR9joKcypzB/9uR9nINo
 8RNfBN61ND1j19Fhvnxc2XxgPJLNxIIv1YiY1K9M/OjeLdZx7THIyjQuJhOMYovTJgiH
 eUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=+hfQ8wueaucFBGYQ+2wnV2w3LB+Nboj3w75I11W2FIw=;
 b=okM8yQf2kfCnA3IYofNX+PtCjROQ3opnFjYvgT5G1oM1aqcNg/NCCI1UYWCzG3frf3
 NoTeRoQ2MjcaEpZtcvBnj89x9TuM29H6QVYSqUtJIhSr7NAZoSnKbV/DMTrAdzY4u3aY
 GmlzZqj9UO1cH3G30rieA+DOpDtmuCyMAOtmiw3cfBfYn5rIYCeBnJxaCuWXAzYuKM+U
 pnRgJ6AUtOUDD7+J/E1JM9Z2tW0ek9GM11y7vUaPwrQqZJLqnzz5gXqGCygoKvzB2AFV
 YCo9Qat/V+Z25aGft3WGMwG8nkOZ6Ak1WF3YAaLUifL27v9SsOSeNhJ+l7CW13k7zZ/w
 CI6A==
X-Gm-Message-State: ACgBeo3CTTbHERheIeEbxkUZRQZtme0UsRa3JUCBB7MjOSbkM0M2h5mN
 FsDNB24f6THsO+k0ydaJoRcxoX8UB0KhOk/vS4g6Rw==
X-Google-Smtp-Source: AA6agR5I8h3DnRaEsM3DFb2IQ6c0s6oNxSmq2MTa4juW2Q70jfxfAHN7v5hdM8nHNQ9Xo/lqGzJLShUR2dWxTUvslDE=
X-Received: by 2002:a67:b249:0:b0:38a:b02b:b161 with SMTP id
 s9-20020a67b249000000b0038ab02bb161mr1889976vsh.80.1660857545082; Thu, 18 Aug
 2022 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
 <YvyxCXTGYpLd8kbQ@pevik>
 <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
In-Reply-To: <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
Date: Thu, 18 Aug 2022 14:18:39 -0700
Message-ID: <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1650467319=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1650467319==
Content-Type: multipart/alternative; boundary="000000000000ffcb8005e68a87ee"

--000000000000ffcb8005e68a87ee
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, Aug 17, 2022, 2:12 AM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi Edward,
>>
>> Would you mind we delay merging after you fill the bug in llvm, so that
>> we can
>> add it to git commit message?
>
>
Here's the link to the bug on llvm:
https://github.com/llvm/llvm-project/issues/57234

--000000000000ffcb8005e68a87ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"auto"><div><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 17, 2022, 2:12 AM Petr Vorel &l=
t;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Edwa=
rd,<br><br>
Would you mind we delay merging after you fill the bug in llvm, so that we =
can<br>
add it to git commit message?</blockquote></div></div></div></blockquote><d=
iv dir=3D"ltr"><br></div><div dir=3D"ltr">Here&#39;s the link to the bug on=
 llvm: <a href=3D"https://github.com/llvm/llvm-project/issues/57234">https:=
//github.com/llvm/llvm-project/issues/57234</a></div><div>=C2=A0</div></div=
></div>

--000000000000ffcb8005e68a87ee--

--===============1650467319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1650467319==--
