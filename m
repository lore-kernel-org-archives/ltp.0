Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FACC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 08:30:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A39853E297A
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 10:30:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D6C43E2793
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:30:40 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9823B200ADA
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:30:39 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8fd49c74519so1950386d6.0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783672238; x=1784277038; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkwTo5cSaf/bsRBt8wsDsSHVKwM3K/0MNnxgM2hGlj8=;
 b=kslOmJIWU3hTOwRjWU6iUDnd6QvQL4eRsZzqFfvgIWssbJPRO4N3biKwH4EoXMRwmT
 egD2/EoAh1M5z0XHRsaiqs+B9plSCTG6Hp87bAXj+tSHn4rnQJBhPx0mdNfwHoeEazjQ
 CR6XSwFsoYv3vhjU3K/2WjawiuU3BMn4marfLDjEmtAeUBYDS6VNCJgGPM3PMR6w7BcK
 IdnfnTfW7EwpuXlCddVJgfYz2vViXqQbF1v8DVoW0X0NSAkSzN+BDiQKbvPlo9wOCwEz
 YQo/Cgd1aaDP8VA8G4kniiiLyUZ+sV+GF4YTG79Bf10CyhtsIF630b8KheaC8bxEMEPM
 XpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672238; x=1784277038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vkwTo5cSaf/bsRBt8wsDsSHVKwM3K/0MNnxgM2hGlj8=;
 b=EhA/MeTutphPMz2ONQ2yuZhDs1BKfuMFGXppPPW1aBR3LbLOBe66h3DrrUhbzMKAl4
 qmV0aYd7x7ffamIdkTfWyXFuZTByidpXqOlF87tr41KEHwI5q3MmSDZn7oulDyMSTo+Y
 6zVANmkt6ikq7CIZdssNykcHNoHKG12kl9Q18GSIVEwLj+iS1oLQ4ozmFwYoAWwacczK
 lyf3peomP48yW9nVQIP57jXNGf4nuYJFBxvQ+3WSJTmohccCKLfzdJnGQNzkwYjmQeTv
 ZCYQ6UamT1ohjT6ygxeJ3+MTXNEQfYMCkGxYTXHnDcupxlKq41QFhkGzaie9TJWu8hTq
 bAJw==
X-Gm-Message-State: AOJu0YyK1y5oOWO7A6CmiM0p+rfG4qYeTi3JXsCreLZ5DZ1uBQQBoznc
 0/FSLRmX1beSpC7kZdY0hX7ARlQsuG0RmhFCnJY0VglA15I56Ezzw4HO
X-Gm-Gg: AfdE7cnAbP8SJCa8ZTLHaZoTMPa8rQJ6LSXBFKR5S5xsbVAN2Iy8LfUrOwjlHU9ARdt
 nIYf0nLfgbR4yOq4bhYFD+LrOaujCghX6ZSPbLaYSv0km2LsfNGhmiDb12EfuVj8XkdeJX++V0l
 IRvHfjAVai7YAwgA5UkmgQEcvz7NYq0COJ2rjcN2aXwFmv24crln2NVI3obzVT7h3tKlEWKk9oV
 7bQnwKhEWe/hw9mteE0nT2Cn+UtBJwqELr2rDI1zWa9fU0NzuMn2l62EATYTiapuqxGe49YhTHH
 bcOOWyPjJ6y2z2LtcpHyOBua43LpQOB7B+/V5xfyPVlYjshaDhe/KkulUBSTnTvy5H38M+JuPjX
 uwuw/Q33lWOHHZ6TE5gty7AZ0SgmQ3yV2Dd4d5ciSbijNdlaR5UIZEyFDoxs10k1I+GpHvoEn0z
 8bUuQAU1XhMUt/Xunbbn5dxlFOCujcjQEDC1cD4NxQhM8fuKRZUlis8UloCTkJfC5nLMKJ+QbaA
 849YcmoYSPqw6s+x9WJ4A1Tc47/HQ==
X-Received: by 2002:a05:6214:230e:b0:8ef:1fc9:9361 with SMTP id
 6a1803df08f44-8fec2c4158cmr123554356d6.48.1783672238244; 
 Fri, 10 Jul 2026 01:30:38 -0700 (PDT)
Received: from
 runnervm5mmn9.1nxslduoqheefguh3zlogrj5vh.cx.internal.cloudapp.net
 ([145.132.102.54]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd87c9128sm35484316d6.45.2026.07.10.01.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:30:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2026 08:30:37 +0000
Message-ID: <20260710083037.4145-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-2-pvorel@suse.cz>
References: <20260710055556.1109220-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Makefile: Skip test-metadata on cross compile
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

Hi Petr,

On Fri, 10 Jul 2026 07:55:49 +0200, Petr Vorel wrote:
> Makefile: Skip test-metadata on cross compile

--- [PATCH 2/8] ---

> +	printf "* $i "

$i is used directly as part of the printf format string rather than
passed as a separate argument.  A filename containing a '%' character
would be interpreted as a format specifier.

The portable form is:

    printf "* %s " "$i"

--- [PATCH 4/8] ---

> +	$METAPARSE $i > tmp.json

Both $METAPARSE and $i are unquoted.  If METAPARSEDIR (and therefore
METAPARSE) contains spaces, the shell will perform word-splitting on
the variable before exec, breaking the invocation.

The quoted form:

    "$METAPARSE" "$i" > tmp.json

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
