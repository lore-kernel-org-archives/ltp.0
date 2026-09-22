Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB125C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:40:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D96B53E6D3F
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 20:40:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189663E1B18
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 20:40:12 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 734892009C8
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 20:40:11 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-33be6703b75so9889eec.1
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790102410; x=1790707210; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DobGzo6ufMHiveJ2XKzcwSJ6Lm1walKEPkjJbpfsQ8U=;
 b=FxwNE8n+MtHFq0M2XdH6UaY7GplGBVMGcdY/VUMK81tBU3tcPSt31PGieQPdyWUgcr
 NIakS7oQcJOjGoRIYrYq/I91iSTSIno1e82JPb79/mKOVWiFr2gPy7IC3xDj5hJtHUV+
 Tx/nXAndaq/Do5dPApdIxSZbjnnmc+YbZgVZkQ3kiq30JrwSSHBSSOhFOEY7YAR9Baw+
 kfBI3aedAXCSjt0XkldLk3bnSzwu+XTvYH6B7sUJSSyT+k0yi/3FJr011Poa50Rsu+mu
 87Nl5vVjRdqDB027Klc7aPagcsvuNyjLfOEizgt8POmK+U4i7L68qOcl34LOGUC1tNk/
 ceQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102410; x=1790707210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DobGzo6ufMHiveJ2XKzcwSJ6Lm1walKEPkjJbpfsQ8U=;
 b=D5x6pLaqdJ0VYMO+A7pu0s6moN9aO9/ITIkGVKkjroFYI70fxMc54QzYNctkwUso14
 zBA+/2UIZmmp0DCBWlcYe7JFzWT9bK7Gdm4aSkkyc0YIWDc8QIuWwreQF8hYUx1KbUTW
 5XoTH7LU0GuxINY2CiVQqgGexLiD87Qc3y3nfZRxMOwpXrA8xjcxzvd7ZXPx9TaFmMzt
 CHyB/qOf/2Ke/Evwb8A9Xz2UASu1/gPM7tt2ZcxcCfJCEjFuazHeyAfxNYAr0Wz1ey7R
 By+nqMVRmykdtddTwwZq9IFz6KeTlqkAOTV4sW+dKCJdLLgXP4MZUkoOh2/vVWzPhzf/
 t9kQ==
X-Gm-Message-State: AFuF++nk6rE7SFBSIvMdA7+Zp/4VVT2Zw9HDpeb6l6klbqF1sckfKdkH
 Q5LEqjG5vP909Tnpn6JGj6JmxbPLqTPika8oBbKnvafSmgX05nbdBlCmF3mIsCi3MxQ=
X-Gm-Gg: AYBFou1PDy3r8r29qje7SWoVBJcfqWvxmZ8wfvaYRj/sgug+Fg0ZOBFwIdAVV8K99Uk
 VItBvkx6Qg5YLa4+ye67X32t1tKxp0wVpwezauXj+b3PRisCCAOis/MWRuKuKFjtfHUU45aDNZc
 mrLzRWkEiOWZV+zIySDxfEwo6qR/U5z5GUPSwXXEFoWv2LLT/eZLSU64J1LT3WBxeFTtA9jC95Y
 f5bQsRg/1+Zo4SrL7Cyu1MsHUhUMpk3F+9W58NIXwqAnET+neMvf3AYQM5jyjKoZ3eWkaMoLPIT
 gGwfVIzLiBz1QqDP9pGSpBLQQFY/q7SNlKDl0E5AL+DWhE/NCvCde+35LHWmAbIhfJT15faY3k9
 /d7Hkc7F9KLIb8uuHXsuuHS8IOb1UUkG9UnUTgYMCxGmPZKlm0ngyr4ZDXclkGGOCQCCeT+Qr06
 NJSNWie7a6hDV79RuP2NXVxMNUxeilxUzZUaSUAQkKU7kIDXxDCMAGvX4LaxsWsoRF+xiKcNY8Y
 2fUZp8BtP3pUGZ9iqdXXUaK5o3wuSKoxum1OjuuqoEKrGKmbhch0WNGdByhncFcnYq2s7SqFLTN
 +so9m/ucOMDo
X-Received: by 2002:a05:7301:2529:b0:33c:e8f:5700 with SMTP id
 5a478bee46e88-33e8e1b47c9mr160935eec.33.1790102409512; 
 Tue, 22 Sep 2026 11:40:09 -0700 (PDT)
Received: from
 runnervmlun5p.bvzgo2codyhutcgvsnpxtiy5cg.phxx.internal.cloudapp.net
 ([20.169.53.120]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96846f85sm142985eec.20.2026.09.22.11.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 11:40:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Sep 2026 18:40:07 +0000
Message-ID: <20260922184007.13630-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922160911.2271754-2-pvorel@suse.cz>
References: <20260922160911.2271754-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/keyctl.h: Remove <keyutils.h>
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

Hi Cyril,

On Tue Sep 22 18:09:08 2026 +0200, Cyril Hrubis wrote:
> lapi/keyctl.h: Remove <keyutils.h>

--- [PATCH 4/4] ---

> Follow-up: bc8ead0f06 ("lapi/keyctl.h: Remove <keyutils.h>")

Commit hash bc8ead0f06 does not exist in the repository. It refers to
patch 1 in this series (875e1f2966dc).

>  LTP_CHECK_FORTIFY_SOURCE
>  LTP_CHECK_KERNEL_DEVEL
> -LTP_CHECK_KEYUTILS_SUPPORT
>  LTP_CHECK_LIBMNL

Removing LTP_CHECK_KEYUTILS_SUPPORT leaves the LIBRARIES summary in
configure.ac printing "keyutils: yes" unconditionally. Also remove
"keyutils: ${have_keyutils:-yes}" from the summary and "keyutils.h"
from AC_CHECK_HEADERS_ONCE.

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
