Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAD1CD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:29:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0751F3E5BEC
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 13:29:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAB733C0E9E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:29:08 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 605E9600445
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:29:08 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8cce22e029cso21123916d6.0
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780572547; x=1781177347; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zb2eaaRROZ9qFpXO/LCmssjc/nDg+Uy38RwdI8cpGy4=;
 b=Rnx21VWwEZNy78IZCRd5OFdzxf5FbPnXnuiU6+X02+MA8PohJGEOj07qhBhe5ULsXk
 wteUGzzK5pILptmGmaEfr4loC707/JgVXwi5jkOlsmmnVSZFFrY7R5eaSxb2GVpgK/6O
 sjbA/DceJZyQ+bJAnBcdkPgsC9keQbfhJsLx8seFQ4lrzLMihIkwmewgKIoVWCC1UxQ4
 p7rgKJPWmxlitvFxQix7BmrYVxqQFprTIAKWRgRsF8czdVL/2GhiSvJfRoN3eiVs+IbA
 UTLel2THGdMa1OMPCrd2TrWEAhK+CQ9wWX3kraCW6oA/A7XV1HavWv7k4mgL0JSjDr3h
 36pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780572547; x=1781177347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zb2eaaRROZ9qFpXO/LCmssjc/nDg+Uy38RwdI8cpGy4=;
 b=a5rgpnP6ECtzkUqB6aBL1h3NBUDy/IyWR9K7a0H+Q+v1D9YofS3Za+AiJx7XrCwOp+
 n9wjem6l49vDr8m6MBfbkNLGjIux12fG05v8iKOpvWZ7W0c2SL3w/nZQwzUC0ydETY0P
 pF/bxuOcGyyNHF+SyFNgfB8jTMVfXVvpZv6aK08rW2dvtWmY1koNsSl2i8g73d0QfI5o
 D6qgKGh4jie4Kl3btKm0IiOCx1Krshj+IMiCBWV25calqgGQ07YR668YHKjkgDoxpdsT
 WNBdroN9e3zdrlTMJR+wQ3loYg54sVdMu93mwW6/uWn5z0kaFw4FLGBaRIF2o8llfd3M
 /iEA==
X-Gm-Message-State: AOJu0YyJYD6XAfAZ9jkelbjkeyIeXSmQxuumKp3NFfKn/hZJUe9/zTYR
 ciBhJeWmshgBC+xTytBNdjOUCqDzkyPi2ZjAM/gEZWGloorsBHld9yZ2C8KKIL/R
X-Gm-Gg: Acq92OGYpbd/izzVaUHSuvD0EKZWrvfaK54lqYKKb0AVzSi/GYQmDWcYA19WIcmU5Yv
 zJTtyoJpISJcWxICx6qUb65eILHiCv1YF2tXogb+E4eHcoXflioVP2Q9YJf2QfrHGNiZW/YwAQt
 bO3m1Cp5jKQOgIzVwuB5vjSTk+0pibkj42GIiIMuBNlRL4r9xU6k1PjfSV209GmpsmpyVlkZNAJ
 dOLZrS5Hg6dbjLTArI5kf5qVthfOQdhOtzW9MW099rpEeRzZy1s/Y9jjQDQodJSGMJkibZaOVJr
 jlk/48VVwcx9IvSLW4phbvsOa2pjSLTUHSzm5/qGo/xELNwIUBGTuPyDRWzIM7i+s8kF4ATbLJe
 5VwlNWHwxog8ll6bLkHEk/cd1gOM93sf+if3wiW2Apj2oOcjlrb+KxyvGXTTltCxDWCSaRv6pDX
 UHkJZ5painUZWzzj3ooX3O/MpVKyHwnBX963hwmVKdYCNA8urdPPq3/eaPUTByVqM8+GjcuH7j8
 3kebfFkd0OG/OfdEAQh6KuAMleSqE1XWMlOdG7YYe3VsC/QePPG
X-Received: by 2002:a05:6214:419f:b0:8ce:b9fb:8630 with SMTP id
 6a1803df08f44-8ced824ad51mr42445756d6.24.1780572547083; 
 Thu, 04 Jun 2026 04:29:07 -0700 (PDT)
Received: from
 runnervm3jyl0.d25eko5qp01u1c5angi00huzxc.ex.internal.cloudapp.net
 ([135.232.208.145]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd26b3b9sm50256486d6.45.2026.06.04.04.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 04:29:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: XiaoLei Wu <wxl18715129466@gmail.com>
Date: Thu,  4 Jun 2026 11:29:05 +0000
Message-ID: <20260604112905.3987-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604110138.774341-1-wxl18715129466@gmail.com>
References: <20260604110138.774341-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: treat ntfs3 as ntfs in filesystem skiplists
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi XiaoLei,

On Thu Jun 4 19:01:38 2026 +0800, XiaoLei Wu wrote:
> lib: treat ntfs3 as ntfs in filesystem skiplists

> +       if (!strcmp(fs_type, "ntfs3"))
> +               fs_type = "ntfs";
> +
>         if (!skiplist)
>                 return 0;
> 
>         for (i = 0; skiplist[i]; i++) {
>                 if (!strcmp(fs_type, skiplist[i]))
>                         return 1;

The mapping is one-directional: ntfs3 is remapped to ntfs before the
loop, so a skiplist containing "ntfs3" (without "ntfs") will no longer
match.

For example, a test calling:

  tst_get_supported_fs_types((const char *const []){ "ntfs3", NULL });

expects ntfs3 to be excluded, but after this change the lookup
compares "ntfs" against "ntfs3" in the list and returns 0, so ntfs3
is not skipped.

No test in the tree has this pattern today, so there is no immediate
regression. But the API contract of tst_fs_in_skiplist has changed
silently: passing "ntfs3" in a skiplist no longer skips ntfs3.

Is that intentional? If the design decision is "callers must use
'ntfs' to cover both drivers", then a code comment on
tst_fs_in_skiplist (and perhaps on tst_get_supported_fs_types) to
that effect would make the contract clear and prevent future callers
from hitting this silently.

Alternatively, normalising on both sides of the comparison would
preserve the old contract while adding the new ntfs-covers-ntfs3
behaviour:

  for (i = 0; skiplist[i]; i++) {
          const char *entry = skiplist[i];
          if (!strcmp(entry, "ntfs3"))
                  entry = "ntfs";
          if (!strcmp(fs_type, entry))
                  return 1;
  }

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
