Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D7ECD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 19:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F2643E6C5F
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:47:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CFDA3E1FC1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 21:47:22 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8355B600839
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 21:47:22 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-307631dbfedso10552901eec.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781639241; x=1782244041; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/aOLIEyOEl9yyBoQfeaZzNoN680yTGYy91s/67HLhQ=;
 b=pb8zMI0HWjniJ1ZC7MtmTQczapyNJjFqskDbqAVD2J8+kaOQCBSa2YAWFc16JJtvkI
 lc5j3WMA2WLvgmOXbPrEFErIW2r1OD+sTuog1CMBUBkIxvKfp3V4pIHUsF58fU4BZoqY
 dnUfjQ6Qy9mxYxV7s4uaYcfC8pudhVJwtSan14SZ5mjX0J9NGfG6DaJmt1EMjbv+A5Ke
 1GPgIMpp/TwhuZfT7r9+grrscBamhk30fkxMV1cDHRX1hDAR9OEsaneRk8KiIXEV+OCj
 0Mlja13cHoTAlO8x8I0Kn3d7iGPccEGZ6H7Z8Ws6L3V6QJeJkZA8NnjjRBczHE13eubN
 yDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781639241; x=1782244041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y/aOLIEyOEl9yyBoQfeaZzNoN680yTGYy91s/67HLhQ=;
 b=KQjE3mM++yhHY20uaFdAe23PGg4MfWekf6r3Vt3ndheyqOR+DBCQDJBx9wCO7lC4dw
 NDDY7sPYn/V06v4jARovICfOiKwWnCsB+o4twmn9UNXVA2wACJ1gPr3F0sHxCZ11h/6X
 xvKmge80/XHvOjO8RknSnx2DLjRwROxA5XLg5QtBC94b1gIXQNNbVf6Ed0gG55uu0Zry
 wvfDAY5fRfHmJpF6CdZxyvTjDQKe11qasESTqrV7FWonh2CW0Jpf58eNMI1bgeRZNuhO
 funnbAl1bLvKQAJkOdq8YG0HKzuanJ5xrKrV9DSpumFk8QmvCZjAlNN6TwaGBj8i1Krp
 uNaw==
X-Gm-Message-State: AOJu0Ywn0Pw6r8jd4LSw7IPvvt6RB6W4VGhZOm7icCH3g3qvXCsRGu5G
 MEOTzIGok3mdGb+nXfqN+jJv9QFjHvfmKNBIRW9tb1BzoPnMPTd3v3WgcH2KZC3y
X-Gm-Gg: Acq92OGJog/trsJvA11X/HTx4+8YW4wus4vMVKW/MUvdDqoCUdDHLCcfzc1GRzlJRCk
 A/bu1LasVDrYH8JolY5HtgZ0uABsHnSNZsfVs2pgR2wwsVWBtBKJGIS3VfZ52ig4uxHzebmZ26R
 10PM6g+IltAtFJibDzFR8ZJ7bm/zYu7ki3c7k6+deI7DfsGhNYHjqBt4tFQLKl00zFD1SwObMfa
 bZzG3dAeO2sj6Mt58jxPj9oGv+MOAhnOiVhvKBSRYCv/B6V6j+pH/5dZaMxcmWc5/5Khd/ROSMo
 CKGh6wxYpJHN0M2djgU7SyL7KiQ3PyvdMNg/SG3tM0Kz6BRZcOennH9XyiYhV4a+7nVt8cy8xL6
 BHfP9uJ2Q4w2zAdKkbUXJEecTaKkPCR24UB207P2Lr5fs3dvAguEC09DyQwrQi0T2/sV6XOFMf7
 tmOj9kdPe+JvFg5vpW9lnMfwzIIhevaQT5EAdw0lgDbtoiakVptVzvZds5zaTeUpLEbN9KC7Lew
 knz0accbZm6+wEsuIuREwnJTLlJ4N6IkZXwvq4=
X-Received: by 2002:a05:7300:430e:b0:304:188d:d0b0 with SMTP id
 5a478bee46e88-30bca0b8c3bmr457139eec.20.1781639240777; 
 Tue, 16 Jun 2026 12:47:20 -0700 (PDT)
Received: from
 runnervm1li68.pp30uvdt4hsedibpjocm02dith.dx.internal.cloudapp.net
 ([13.83.166.241]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30b6191bf9asm14610903eec.31.2026.06.16.12.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:47:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 16 Jun 2026 19:47:19 +0000
Message-ID: <20260616194719.4126-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616183025.26554-2-mmenashe@redhat.com>
References: <20260616183025.26554-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wake05: Add EFAULT error coverage test
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

Hi Michael,

On Tue, 16 Jun 2026, Michael Menasherov wrote:
> futex_cmp_requeue03: Add EFAULT error coverage test

--- [PATCH 2/2] ---

> futex(FUTEX_CMP_REQUEUE) has no existing test for EFAULT. Add coverage
> for the cases where uaddr or uaddr2 points to unmapped or inaccessible
> (PROT_NONE) memory.

The commit message says "uaddr or uaddr2 points to ... inaccessible
(PROT_NONE) memory", but the test only covers uaddr with PROT_NONE.
There is no "uaddr2 PROT_NONE" test case. Since get_futex_key() is
called independently for uaddr2, it would be consistent to add
coverage for that case too, or alternatively narrow the commit
message to match what is actually tested.

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
