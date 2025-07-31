Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5244CC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 08:23:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588A13CBD20
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 10:23:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DDC83C0980
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:23:35 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28A82600956
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:23:34 +0200 (CEST)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-70740598a9dso6477306d6.0
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 01:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950213; x=1754555013; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yebPsE2N05VbVy4tE5ddjRqrIYO/wXbd7rdZFxX3OCE=;
 b=oXzvCVJO4Oqo8rNyFuogMmelDhs/tOpxLi/WiZ/pPfV2XlAJVkZYje31OP7op9L4Yl
 Q9Z/UW7sANNDtJ/uXWKg7iqmweBIGDCwgGtSS6h1ApOB5dj3+BBQodPft/19cH486Fbq
 KQu6AyiLdd+a64ztLGbgWf79P9SDxqosdRE1InwsgMfY6npqTiO/kUYeSFKY9+J/biXK
 M/jacKGm2Rj7yA3GQ32IdJrZeZI0PzfrQrlzvjiW25JKD7T9ec+ay2DHXWy6IrpaFbIE
 LF4Kbrb0CgJdKg/uNJbFzHuFH7G0qBjfcTVTf2OHmwqFHEfTMt0b0pU50sQ6mUTdvE+c
 1d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950213; x=1754555013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yebPsE2N05VbVy4tE5ddjRqrIYO/wXbd7rdZFxX3OCE=;
 b=w7Hsl1byOwwbTWvrNiiLsmlftnagL/N3Y2cvhZN4N4xTgUNgIpO30ivhpoi8tg2AIl
 wmR4m+XEaq1vyjiu+zUwJu8TXMxgtIyMeClDptoUxNPUprjDZcqc1yVvsq38Rm9PhBk/
 g2luc1gPsg0biw5u22Vy7zy1fs1YQpl576sfmbLGX9A9JfHY47f/ssZy1fEhvMLiL+Km
 iDjGTtSaBhu7uomI0Ygy5EID6rLeb/QJPk2PYUNVuqKYCNLVl0EEvSO0pgRnOTfhDP4N
 oh1963pXIqfPQaLpmWhXx09zn1kVj6ESvWEExwC0oG97a/NjhoSFmfchkAi6IfpJzOr5
 +BHw==
X-Gm-Message-State: AOJu0Yzf02rZkcH3nUo0F9f26l9J22wx7eks8eeh+etVWAmHwhAGqEm0
 AuFaWTbIQk1KVCvIP6hQGjm15QF3+wssoi001rmWVc7hYjs29Fj7pQmNYNa2Ei4d3ijgQEPERvQ
 b1Q381qgZeiZ6lsc/3EGlLEibWCUhWsPNdHRGypKN
X-Gm-Gg: ASbGncubHsVL4bD33RcfVh1b0/TuxUhP8PxUmnbvMVDnPf8B755eD3tAjlqipH6xMD/
 RBKlzE1p0ScEzEtUBDoxJdZhZD+vTX6ErxnnPROeU8Y+vv6l2JBIE8/3TxJW9qs+8ogQMLNWrt4
 qDohkpiGRf8aVv8Dc0J/T/4EVz3Ye10IrzUoX4TUsQ5CNpCIMYhRuwiGFZAxX+KNjztpFBKvE//
 jIc
X-Google-Smtp-Source: AGHT+IGVJeOtZpnre3wVtSsTvu3TBu7iyJL+cvj1PmEGhD5m2qAV9HtsqukkPpE0sRZ9RQsk1cvK6+ykS4JyiOh8e04=
X-Received: by 2002:a05:6214:2021:b0:707:5633:d6f5 with SMTP id
 6a1803df08f44-7076725cab3mr92087216d6.49.1753950212839; Thu, 31 Jul 2025
 01:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250730071342.817400-1-ben.copeland@linaro.org>
 <20250730075254.GA50561@pevik>
In-Reply-To: <20250730075254.GA50561@pevik>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Thu, 31 Jul 2025 09:23:21 +0100
X-Gm-Features: Ac12FXyCOKrCu0G-mWBwCqM-bahD-ddPP6n5golfTPNIRJ3pFKnPVztRElchBsA
Message-ID: <CAL0q8a5CsRn_CUWMorzDxNUx2hwPxbjmNbbLK_z27GDRTQ54Tg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] vma05: Fix false positives from stripped
 system libraries
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Wed, 30 Jul 2025 at 08:53, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Ben,
>
> > The vma05 test was producing false positive failures by flagging any
> > "??" symbols in gdb backtraces as vDSO kernel bugs, including those
> > from normal stripped system libraries.
>
> > This caused widespread false failures in production environments where
> > system libraries like libc.so.6 are typically stripped of debug symbols.
>
> > The fix filters out "??" symbols that originate from system libraries
> > (paths containing "/lib/" or "/usr/lib/") while still detecting genuine
> > unresolved symbols in application code that could indicate real vDSO bugs.
>
> Sounds reasonable, but I would prefer Cyril or Jan acked this.
>
> > Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> > ---
> >  testcases/kernel/mem/vma/vma05.sh | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
>
> > diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> > index c560eecbc..09757a0fe 100755
> > --- a/testcases/kernel/mem/vma/vma05.sh
> > +++ b/testcases/kernel/mem/vma/vma05.sh
> > @@ -64,11 +64,14 @@ tst_test()
> >       TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
> >               vma05_vdso ./core* 2> /dev/null)
>
> > -     if echo "$TRACE" | grep -qF "??"; then
> > -             tst_res TFAIL "[vdso] bug not patched"
> > +     # Only check for ?? symbols in application code, not system libraries
> > +     APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v "from /lib/" | grep -v "from /usr/lib/")
> You can pass more regexes to grep to save one pipe:
>
>         APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v -e "from /lib/" -e "from /usr/lib/")
>
> (or have single more complicated regexp).

Great suggestion! Will respin a v2 patch now.

>
> > +     if [ -n "$APP_UNKNOWN" ]; then
> > +             tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
> >       else
> >               tst_res TPASS "[vdso] backtrace complete"
> >       fi
> > +     fi

I'll remove this too!

Regards,

Ben

>
> Suggested changes.
>
> With that you can add:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
> +++ testcases/kernel/mem/vma/vma05.sh
> @@ -65,13 +65,12 @@ tst_test()
>                 vma05_vdso ./core* 2> /dev/null)
>
>         # Only check for ?? symbols in application code, not system libraries
> -       APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v "from /lib/" | grep -v "from /usr/lib/")
> +       APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v -e "from /lib/" -e "from /usr/lib/")
>         if [ -n "$APP_UNKNOWN" ]; then
>                 tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
>         else
>                 tst_res TPASS "[vdso] backtrace complete"
>         fi
> -       fi
>  }
>
>  . tst_run.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
