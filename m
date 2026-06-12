Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC124CD4F2C
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:41:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F16E3E55FC
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:41:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48BAC3C22A5
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:40:42 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06BD76008D6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:40:42 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ccef25789fso5986066d6.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 01:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781253641; x=1781858441; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0YvHaT+sw/eKbbfR6cimIYbDW/ehTTlam0+lbl2czI=;
 b=WcGlwZZQZnPUxWvzz8W0ug5r2CLW3LKf7PT6p8QS6/zMHjO/zGvHT2j6ZGJU4joV4r
 1MKsV2uzj2f2lA4pYtBls6RfJs/Z3On0SZyivA93bcBleqWmSVSt1SQG0tJWNNvvN3hz
 p2GNaoatkRXtA8q21dc8Opg38jJ4xUKW8qtT/w0t9i8fK4aPFRQYQtTSxTvtAitDwC6P
 IuBm7NKNXCcKrzMEtakBVSfB+9JB3rYFgyQjMVECJEmqv9FFOxo8Awqv80rMjKpNoO86
 gS+vKPEdBIzMG82eByq8Uend4IcBkqBUWeGs27x9v5YyOJqbnuNyB3G0DfRLVelhm7kS
 4tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253641; x=1781858441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0YvHaT+sw/eKbbfR6cimIYbDW/ehTTlam0+lbl2czI=;
 b=nGAUC1J+esTKhOLutu0tg2RHayXnSb9dBZbbhSMhFjXuvImIOzSp+lG3dZOB1tjVsu
 Uu6E0Y2TQDf8aRZM9GZC2wBO1ypHdfQV9boLVlacQTGv5+wLZdMSNVcX80E/qO0HLVYH
 ezAzUg32755dbykSHG79+l9mhUqfDTDfBHxXoVirfmvmD3EjkpM/ATHf1KEWDMhXALFp
 XsEA3cM79elr/eKUVchBW4e3puda9vuMRQEnKGIjsNmcfgYA6t5KrqFHyv3BV1GZdG0R
 O3lqOV1j2PSF0nFb99mK4S8YK7euTaqVfeGF1pEfsC3VAyBwD6Y8CA12SsGVmlkX1KPL
 iApg==
X-Gm-Message-State: AOJu0YycgyotClBazBNgg6wEeNFLnk9uLa7z1sBreGAhkrVYJR4KXeWG
 t4fYHDEsqkoCCMQv6ZBVcAFKK5k3ORFIK6Fh7jx2P2Z4HrV+6Ib4t4b/
X-Gm-Gg: Acq92OErKNXLT+iUGWOLt2ZCnQWfWyKqnvxJHyGGtB2bftPPcQqIm1j6oZFMdssRbz7
 yd25SP4QW6q5EtLmtZaCgPNf2biKozfbBh727p//6DLFAzr0x7/EiEDfPXqZHUl4Ocgae8vHN1f
 kijOlggGFBm49dJHuCundtE1g+d6ntT9gcbW3AtQrT/9IBO9tEWislMEMiPh94tG1gHqTGs56Rl
 pakklfJlupnt61QhjZQ13GrCbDsdMRzZsW6q9T5QBI2jGdZ+e93L01GHUASOXJj3OvhOxlpqNFc
 q2nG+c9qwfyhoK/55Ju+WsE2Z5i0fMrQKoq+zlj9cZCFGjd9gEsoEr6K2nSOPdr3zDVonsS9qMA
 4zdjTJ3oKttS2s/rqU0kIOyq4Bet6Hf1MM5uEQvi3BoP2wj2PUu33XVEhz1WyH4A0nB9g+fw5Ky
 krIgW5i4p74x92W7DOu4ae1FFlaYUQLnfIrR0mI4qagpXQ6UFLKw/kx7b9Iemi2yVqrE1t75obv
 UYVInJ/5n4cHmINYh91xQnKc0VjWTC34BG/lUzj6A==
X-Received: by 2002:a05:6214:5990:b0:8ce:d557:74df with SMTP id
 6a1803df08f44-8d32d7617a2mr30632416d6.22.1781253640767; 
 Fri, 12 Jun 2026 01:40:40 -0700 (PDT)
Received: from
 runnervm1li68.ttj1kvl2lauutisz3lmvkbflya.bx.internal.cloudapp.net
 ([172.174.109.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d304577e2esm17027246d6.32.2026.06.12.01.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:40:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 12 Jun 2026 08:40:39 +0000
Message-ID: <20260612084039.4204-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612051605.5385-1-wegao@suse.com>
References: <20260612051605.5385-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

On 12 Jun 2026, Wei Gao <wegao@suse.com> wrote:
> mmapstress06: Convert to new API

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
