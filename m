Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EF0C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:19:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB7E43E701A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 16:19:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC21C3CDD91
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 16:18:53 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29E6E600A3D
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 16:18:53 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so19751365ad.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786112331; x=1786717131; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hlqs92sBuLH7B5JO8hDdL37IeNGiTDQGYELdvx3TsY=;
 b=YCg+PbUo7GsEwtLQ3/fCDzLXAFl/IaI5Njs9OcKDdI/KwLlA76+qm2A3E43HY6mtAv
 xMLp9YSKXDy8m8mVBryGAAushAwu2MYaKsyRqcfcJ0SGWjfYhpxOmru48ZKlsGMetxDO
 SRCkqD8d1W4lELktJhEJ4YGG50Z7VEOXVDJerShJEqaBc6iVGYG88wrV0zPjd7q28bQ8
 DZqpZDUZz2Wir+zcNBDMsyX5XtsNGIozbAyBxpy0nHfuMT8MtxtfKIHRW51aWLB+U7Rd
 vXPUrLKC2qMAQCXEzy5T/PSRe4BCwmNZGhvIi6RmrDKrRcaFsY8rqEBqPGK49Q5EsXjO
 JZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112331; x=1786717131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hlqs92sBuLH7B5JO8hDdL37IeNGiTDQGYELdvx3TsY=;
 b=K9f2juuQNWFIpq0BdrrFMhNuJPEuoCr6qmW6v/Yfnj+nrLUuMbRxkILTJZtJ/6VKyG
 Mgx8wNXBw8inai2ph1Tt+amKgPfbVw8kfCOm2G+bE5vaCG+HlTDGLmgRBewGZE8HOSpd
 CA5Jkn2s5JLjSScH06fTbq+VFfI2yaDIlzZRUEP70EQgyitCmcQEhfXJhztT/TWOSLCe
 o7KyfD3KBp16SUjJA2iWDHfLRBZevQnlQ1EEmxCC3zxF8zG41Rb0f0fHHQgQC57xYbGJ
 v0pMqJDAhWwIN9MsbKfd0o5u3zr1coVJWWKDrxGYERIR7OMpVrRSuFMEW0kTkyqxTKpP
 aXRA==
X-Gm-Message-State: AOJu0YwkpJ7NflMVG2jf3aoDB/UQjmsnwNsRaVXA94QKwpRa3lyIX4Cf
 p70+DEWEmpNlMTxFUThlvFSf0vGmcTcNHtTlCYqIIlApzR7BsgYOnefA
X-Gm-Gg: AR+sD13ivRUR0vufla7o0Cty1t7wSgBLQvJmBzuMbZmhoO5//RNoCsorHZvZj9e7ssv
 r9K9CSVjrMu6Fym3KJxT7/zr2nmFGhDBT2kVyyLSrR2Rf8tnUdduaq5fHqyRqO5RdTsAB9qknGU
 6Ga1ior6Aa1KV3fOUG6Sk3sW4on2uaP0CDCeOw2lA2h6qPNvWIrfWWVE7nfZHD2W6lLdIeIRN/d
 Za3xZ6ApFe23uuLiggleVQfFsaF04BZpyTzIikeq+1sRWhL0hU+FnbhJ7JNzBrMuEl1zEPnyI2u
 wsy/geUL80lVTYfnmdqeQXEmRAeOmSWEGNMWJf4CiEgKL0f/h0ruAaVilVME2BbrWv3e1d9gGg3
 sm5Tc0TeBmGi60Eji3+qDnd645EeGWVp9P28N9mx8hrStbqtwArFvpLN+tRwHEFHiCIIXRGqz/a
 XCKMcQhBNWjzKMVyvUeUZteYFgKCGHBrf0y8/xOEiz+PohjxgJoSQDQoYrZgqV3XdZ+ykmPF58y
 xMGYwfKXISzVk8N5gwciSQGDuSr0fsafDBLUvPWYHMVvwqxUdfpsA6hSzKDw2o9xu5V4oY24Es0
 NQ==
X-Received: by 2002:a17:903:ac4:b0:2cf:a1c0:d4ca with SMTP id
 d9443c01a7336-2d0ca961ad6mr301743585ad.22.1786112331226; 
 Fri, 07 Aug 2026 07:18:51 -0700 (PDT)
Received: from
 runnervmvrwv9.dgolgrmsjpeulka1dcwqiikfqe.dx.internal.cloudapp.net
 ([52.190.140.103]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb88413sm12554645eec.18.2026.08.07.07.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:18:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Disha Goel <disgoel@linux.ibm.com>
Date: Fri,  7 Aug 2026 14:18:49 +0000
Message-ID: <20260807141849.4616-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807130523.49068-1-disgoel@linux.ibm.com>
References: <20260807130523.49068-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol02: fix fd leak in cleanup path
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

Hi Disha,

On Fri, Aug 7, 2026, Disha Goel wrote:
> memcg/memcontrol02: fix fd leak in cleanup path

--- [PATCH 1/2] ---

> fd is initialized to 0 (a valid file descriptor) so the cleanup()
> guard 'if (fd > -1)' would never trigger.

Could this explanation be corrected? Zero is greater than -1, and the
cleanup guard is added by this patch rather than being an existing guard.
The relevant problem is that -1 is needed to distinguish an unopened
descriptor before cleanup tries to close it.

> +	if (fd > -1)
> +		SAFE_CLOSE(fd);

Could this use `fd != -1` instead? LTP file descriptors use -1 as the
invalid sentinel, and the LTP convention requires this form for cleanup
guards.

--- [PATCH 2/2] ---

> #include <inttypes.h>
>
> -		tst_res(TINFO, "Child %d in %s: Allocating anon: %"PRIdPTR,
> +		tst_res(TINFO, "Child %d in %s: Allocating anon: %zu",

Could the now-unused `<inttypes.h>` include be removed from both
memcontrol03.c and memcontrol04.c? This patch replaces every `PRIdPTR`
use in both files.

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
