Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264ABC44511
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:15:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156683E5C92
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 17:15:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BC3C3E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:15:22 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 131871A00649
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 17:15:21 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 d75a77b69052e-51c169d90cdso27147571cf.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784214920; x=1784819720; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TX9ORL6tBBVLbvHP/lgo01bY6OJsYaRBw7BUxeraUXE=;
 b=G/eABQ2A9tEAegQ4zjVI6W+4MN+iFKiQkuyxp73UGTSe8P6CdprrnnXJ1CQ4sER5S4
 N//SA2jUwFnJSmhBXkAkiaZz/XbuR/Sz6IAhT6GAxURyq43url4V9vFUXDd5p6rwFi0q
 xE58A3OqSjLzXRMsI+qx3u1lxlRHaYvMz/0piqxR5dbirXDpEd7arq7DYV7dhCwZcFf+
 T16nuiY2toUHKw75YEoXDNSOdhUwQqDgqYD3hg1rbAEem0FNhau3QKICTtsoxAEHiz0F
 qFcBgm/M2xaV70PyN+kDB2XoqVOF0M+xTSvGxdrGMeLWtz3CbOMYNgQP488f6Sr6Beku
 SSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784214920; x=1784819720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TX9ORL6tBBVLbvHP/lgo01bY6OJsYaRBw7BUxeraUXE=;
 b=XBA0QCAwgtHO46wE6YhSlIRgbOj2lnHMx0gPa0PEraAm+UcIoz4wd1AV9Q/ISyclIe
 NvGXX6k5W648+pZUyEFF2oiDUV8pTBDEKLT6LxY+dQ/bbC5rRSDhN1D0gpCj9zUXzbY2
 oTTXwo97uuLGcQBFizlKvUPqIJVO+5zn6XJW2byLaNDIQo5SkZjwnTtsPZ+qHGE1aOR1
 P2AJptMxdiphaWC4T8yDjF6cgWclg/R00k2eflV6y3TO3J77Lxen1GiJ+BK8j07b/AuQ
 4olWQXBa2n2fmkVI1HZStmBJdJTzDzPSmuOB9lwWNryaGtvuVe9LAN6B1ni4IRuI/jip
 HT1Q==
X-Gm-Message-State: AOJu0YwxIraItxWHbbsjGytJ/YEs1jgpnKCD4r5Y7pIcuq11Q6bS+8rS
 PWJXmwYQj6hY//NeKRk9zZJuS07pHgOMas9wMtEYp7BxI3fHEPvZNtXu
X-Gm-Gg: AfdE7clTl69FDh6z7wK/Ig1GqPD/l6EC1O5ZI5qdd8rFt5Vp3f31ABswobfssmiu7qC
 b5ORfcqOArOx3LYzqbUeBK0bDxR/XN2LsdGJo/x9tIeI1efjNjfSNnmNqYqk7YFR3ngRMdZE4qv
 jof7CcVWKYBp7vrvpSVfHU46S9Qr9PQqGCh2EJonHviFsW61BuiXAoJIu4EU78PqD369ZvAlAuX
 JBwWWz3r9+oQ/F3RY83MrVbD8Fd5FTaRY6o4G5Ffx7OtfiQqZXBz5h+5ofWbs7/MNim0LmOrmF5
 EKWxPK6dU5ZejCCQoXKhdgBj0oPenPyUxKpEKvsADe5g7A0W1nx2duiwfeTBQ4/VmPmy2xMvGVn
 fBFIGddrGEaoMx6TYsqkDA9z19x2l9Npg8x3166tg0gbXFai7MrcUtE7wvmC+LHY8br9Kcda16w
 ZSaC7y0zhobeMsHdNwdh+9NlOPnTf7z9I82Bd020hCyOXBwJGcdrT6XEvo1fxV2o4vLgKM5RS7D
 OmqqRnVBW7inrNL58U=
X-Received: by 2002:ac8:5994:0:b0:519:ef86:127d with SMTP id
 d75a77b69052e-51e42364116mr109596911cf.18.1784214918455; 
 Thu, 16 Jul 2026 08:15:18 -0700 (PDT)
Received: from
 runnervm3jd5f.uija1hs0nz2uxaixrrhkeiq2kh.bx.internal.cloudapp.net
 ([172.190.102.85]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caafd8b4fsm161930671cf.31.2026.07.16.08.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 08:15:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Thu, 16 Jul 2026 15:15:17 +0000
Message-ID: <20260716151517.4088-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716133108.13003-2-mmenashe@redhat.com>
References: <20260716133108.13003-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On Thu, 16 Jul 2026 16:31:07 +0300, Michael Menasherov <mmenashe@redhat.com> wrote:
> futex_wake05: Add EFAULT error coverage test

--- [PATCH 1/2] ---

> +/*\
> + * Check that futex(FUTEX_WAKE) returns EFAULT when uaddr points to

The doc block is rendered in the test catalog as reStructuredText. When
referring to a raw syscall in a /*\ ... */ block, the :manpage: role is
required (c-tests.md rule 19). Should this read:

  Check that :manpage:`futex(2)` with ``FUTEX_WAKE`` returns EFAULT
  when uaddr points to ...

--- [PATCH 2/2] ---

> +/*\
> + * Check that futex(FUTEX_CMP_REQUEUE) returns EFAULT when uaddr or

Same :manpage: issue: "futex(FUTEX_CMP_REQUEUE)" should be
":manpage:`futex(2)`" with "``FUTEX_CMP_REQUEUE``" for the operation.

> +/futex_cmp_requeue03

The git.md rule requires .gitignore entries to be kept sorted. The
existing file already has /futex_cmp_requeue01 and /futex_cmp_requeue02
near the top. Appending /futex_cmp_requeue03 at the end leaves it out
of order; it belongs immediately after /futex_cmp_requeue02.

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
