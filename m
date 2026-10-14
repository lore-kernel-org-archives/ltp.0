Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D7FC3DA7A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 16:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1DC53E26BA
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 18:42:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9DF93E26BA
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 18:42:06 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B29D20026B
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 18:42:06 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6debc457754so494546eaf.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996125; x=1792600925; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5dV9H9uwVBWe4XncMFGDAP96oSDq0qjkySenGvKhIHE=;
 b=ie/JQTTSV4QKOMGHrJEppgW8v/z1uf7Wv0VqnC0U6j/eECyjs9v0v79SQvP3mKHDMY
 HJoApAeCkXwSFYmARorFhLbIzdIwLKnSma4qDwyz1CUIh6rqSsUkUrgQI+h6o90RXPrZ
 kslyYSnrxhiKhFYFaERlMHBz6Dc0cVWwoVQwFBmv3JlIxvKOldfs3tOPF7lsP14FElHy
 RdUarkO1L2FYz7Sse3UN9KY1SJpwDx4zrUasdMgTAp4rHXVbwSo2tViNh81MewJ+Oat/
 BYU55+Ym6xllnZ/UCGIcmHeajtAuJPOds7D7755/pYKv7NsSLhmo2cl4BH43ZUWAmvf6
 7V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996125; x=1792600925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5dV9H9uwVBWe4XncMFGDAP96oSDq0qjkySenGvKhIHE=;
 b=YitQh9o0VdJVB8dR/GYveHg4aaWwaZ0RTtF+hmaJlORIhbTx1MSbrZXFolmt+nF20w
 uQBVElflXG9bVqDbKiidqcefpGgnFCuMhj3MOlUh8+nFTRbZWfevhrE/qq5pksBxKuXk
 YkMx8R07dsy6Hlud3wj1Rfc1yd6EENZztW65mw0O1f+Dp5bfTxo1EUgvsl44jyrey4mC
 p/OCKWgn1s+Td9LN5c2KrheKo6Pnh+Jx0Szdb9vJpHvRIGlNCnjS9nCCJWrQ68t4SN3J
 0drJbUsP6dJJAd3eXtsYpvhR8v0I0OycovjoDqmvRSoT7In5qETZk/et1E3sjTNb0Vw3
 IF4g==
X-Gm-Message-State: AFq9FYIG32qpYLM2IHHdWDhl6PS5fYbvEGZ+PxnXHCQChKkriw1EHdIA
 YRt5IfsF3YotZNVwNZt6gWPrckBnstB6iOScVrV9U7QCRz/coH+veavU
X-Gm-Gg: AYBFou2YaHTiMWHQ+jv9ialltWYHCYcSLCh9mm4rftcANgFfeLLIfIEIsqWKPxIm574
 I0UsmSrv4SseqFKzDU3oRI9J7prmCE5vBn8vcKFcCuQl5O5CpdNUXAUYeOdl9baAkQ3vyoGfaeY
 NS0V1EgkhYlkUzMlIS3W9ON3Wgx1AiAQvEvPViHijntfoqhsgJsSFPkfLj8Kuj6Kag6JXlonJdP
 DUKYJ7BsonuDrEw9ZwNtTjDjFMrsmFqajsPVdCncLOlwUUJwiz4DDnqyVF2GJVaXBbg+Qxq1GJT
 L0Ov2ojCRCinr1NCWwDAOeHrvsPD2ACDdINGFOOft6S4Qe1DNbkbskHSk53FPiKtD+2W/mYBe47
 zm1F9Bq2sZdkvg4wG+p66PyQYJMehpmm8K4WwJEcPOcV99HOnS9MADJDVd6lXtZEJks3MbGBXsy
 BBUp2eZcnmlaq7oXt0parJwuVPK0vVwAG4UFHMb0OgDYxZ9Bzqs2ujDphgmSGgO8vDZ15gq9c3x
 xNX6JsyvMO4mIhFKIwnXcDNbZe5t+/+ID3HJU4CaqirH2RM42kRlekJRbwOZT+1nXWiUKcKd3z1
 CKsktoqw1g==
X-Received: by 2002:a05:6820:162c:b0:6f8:728d:cb4 with SMTP id
 006d021491bc7-6f8728d112dmr6386903eaf.3.1791996125003; 
 Wed, 14 Oct 2026 09:42:05 -0700 (PDT)
Received: from
 runnervmmprz5.emztcjhz5qwezao5jrs3vvmo2c.jx.internal.cloudapp.net
 ([40.119.37.83]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303494f64csm14967077a34.3.2026.10.14.09.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:42:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Wed, 14 Oct 2026 16:42:03 +0000
Message-ID: <20261014164203.9134-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <as9x2R-9IQb7vjn7@toolbx>
References: <as9x2R-9IQb7vjn7@toolbx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Fix the mremap03 syscall testcase
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

Hi Martin,

On Wed, 14 Oct 2026, Martin Cermak wrote:
> Fix the mremap03 syscall testcase

> diff --git a/testcases/kernel/syscalls/mremap/mremap03.c b/testcases/kernel/syscalls/mremap/mremap03.c
> @@ -35,7 +35,6 @@ static void setup(void)
>  	bad_addr = tst_get_bad_addr(NULL);
> -	SAFE_MUNMAP(bad_addr, page_size);

tst_get_bad_addr() returns a mapped PROT_NONE page, which mremap() can
resize; deleting this line drops the documented unmapped-old_address case.
The test still passes because old_size is 1000 pages and extends beyond
that VMA, exercising a different EFAULT check. Keep SAFE_MUNMAP() here to
preserve coverage of an unmapped old_address.

> This patch restores the original behavior of the setup() funcrion.

The commit message is missing the required Signed-off-by: trailer.
Add it at the end of the message.

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
