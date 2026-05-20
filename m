Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAE2CD4F54
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BDF23C737D
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 11:45:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 515FB3C724C
 for <ltp@lists.linux.it>; Wed, 20 May 2026 11:45:17 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0A33600755
 for <ltp@lists.linux.it>; Wed, 20 May 2026 11:45:12 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-512f750d4b2so55535201cf.1
 for <ltp@lists.linux.it>; Wed, 20 May 2026 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779270311; x=1779875111; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gr9mfAemOakV8D0ckBhwxQXfyQKue6xyaIjIDwpR6FU=;
 b=AN9ETyccypMF38wPGe2NJ8lw8HGwUxC0ims8eDSdicDpmJt09oD6cSAcAcMAoGidrt
 GJUiC024qkqEyK7ss8Ft9gelFwlL4M/QYWqw8FYS0rJHayCSq8hDdpM4gE9Kj4UBwG5P
 rmcPN+U3/WdCSH6g/RnMwUY+c2sLI+xEriqcNhOZPQu1aVL+iJDTdltNCnCWC4MBebiQ
 oLAYqNN3PAscSlNxRlhID8/+7TvWkcFBkJcOW+lg3M9hz+4wr+WmyId/Sz4bNCW03IP+
 F3yq1oWmJudIp1Q1hoCXja81Em3D2SyfXb4x4hOiHfRdhelRACiJo9f8iCZwnj/aUzGc
 /dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270311; x=1779875111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gr9mfAemOakV8D0ckBhwxQXfyQKue6xyaIjIDwpR6FU=;
 b=SgMP/T/nITRMmLkcPisiyXZZLL4/l4FjsDWFttIIyHSjbiqMfyxlcBq8R1QbEXiGOZ
 ntFefvL8GYqKohRNgvOPOxxc8pajWqToyhEZasxyeaRXaYkG8/OWW9kD5HSpXD1JwZv7
 0bgwmKhNMw2SDOaSmYLAirkE2xajA0NiCaV2aPAOnS1ufr+b0St22MX5dqOY31FbAGlw
 j+Ajtgd42jJU8l8ddkDEZ2wc7BBUd8rHWr7GdLg7nSBDm/XrFS9im9bV837ivKjMRE2V
 yUw8vKSbD8h0sdBnisBS0BqBcDIRgxxJmY96pOZDGO1UcH6qb8+lZYs66pJ3P3MsIIMx
 lYLQ==
X-Gm-Message-State: AOJu0YwIalIGamujpSinREBiYBhMOYEgdt09Zi2DNgdT5V1qwypcv4oq
 DwUWoysy0pnpOT6W+BSdEdo/TfvrbIxW/OJo9D1S/S+aJtGyHCsqyCHI
X-Gm-Gg: Acq92OHEmEVIN1eI+v0sNhSOl87WIx0N6K1tZE1inQ3E4TE+1+f4bgS8msdeX2Im1qe
 XBUEO4fuCuLUxdSY0d3NShLn0Q85vQW5Td2zfp+8cHdJqzeMMG12FYjesbW/emzWolCogcSqmHu
 sxJahBvJjWbVpN7XJW5aRmdUHQFuG1xQp2kq31Ue4whsKRP3GPuhnH5wFMjsRQlBo4ejknRSGj2
 9IEBKJ2YtTB4WZuP3mFLmmseo8PQmPgHNuqOFs8am8Epmkz0vYnIY04Q+DZ2XvouARaXHnIaYo/
 OkDeoa1bLF8xO1p3ahCIbUxwgRayy/7KYKFA7kyUgaOvBltQGTDk67j8VSNqoxadvFTqi8SXtz5
 tv1GvSYseDMEWekOMVu5KZnqfWTGo/Vl3Zy3GVzdQ1T11EMJ4RRvt/VYY8DmY645tolVKDAYLuI
 RFmCJXzdU+Zz1XotZUHZ2lmOx9wvy31MZMIMC2rTm3tjomnin5tHrv6UcfxoN0yu3Qi+fGiePJ/
 1PyaYj9Pvi/82df/M9L5kNvOO0IifLZRTIwng==
X-Received: by 2002:a05:622a:2505:b0:50d:8905:7cc7 with SMTP id
 d75a77b69052e-51659eda415mr266813711cf.0.1779270311525; 
 Wed, 20 May 2026 02:45:11 -0700 (PDT)
Received: from
 runnervmrw5os.bbvfuim50bhurirfaguag3kcgf.bx.internal.cloudapp.net
 ([20.83.174.52]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5164581fdf9sm187975161cf.24.2026.05.20.02.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:45:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Wed, 20 May 2026 09:45:10 +0000
Message-ID: <20260520094510.4156-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520074427.39155-2-mmenashe@redhat.com>
References: <20260520074427.39155-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

On Wed, 20 May 2026, Michael Menasherov wrote:
> [PATCH 1/4] futex_wait06: Add EFAULT error coverage test
> [PATCH 2/4] futex_wait07: Add EINTR error coverage test
> [PATCH 3/4] futex_wake05: Add EFAULT error coverage test
> [PATCH 4/4] futex_cmp_requeue03: Add EFAULT error coverage test

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
