Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5C606A31B
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LZ30t6Gm
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1736C3E20CB
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 08:26:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FEE23E1DC2
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 08:26:09 +0100 (CET)
Received: from mail-qk2-x07.google.com (mail-qk2-x07.google.com
 [IPv6:2607:f8b0:4864:34::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 605AD1400502
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 08:26:09 +0100 (CET)
Received: by mail-qk2-x07.google.com with SMTP id
 d75a77b69052e-53607df0fd3so39719091cf.0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793085968; x=1793690768; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQ6EriJUuLjcMWR/doFJOZRr+oc0iy6ADe/ooN19/H4=;
 b=LZ30t6GmwF3lree0nEMn5IScLdfjFrweor7+5m0sFtkz/21CZ1Lzi5NS+lad7OZtb5
 a9wrHd0zp7gRnkGQj1ayNGSy2zVVwaVMf9G2GsLGka1BYCTMmj3djbI5WN6zBNhTDUx9
 rSGDTk4OX+V3iUsxdZQP5rH/hSl9W+glL7DmnvmHIei3FYw1s3muLCi5fYMIiWfWk+u9
 SRvZTGOT+GOmUr0lZHjFur031ZW1BXWw6tZmrPMfNzPhb2Elmm/H/M1SXesFOHb8dxP3
 taqoRawGyOHl1G0MWxFo7MzUT7+0yoLP7EEXAjdyNDxc8LB97kqEhkJV0bYm9IkRMAf6
 XdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793085968; x=1793690768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQ6EriJUuLjcMWR/doFJOZRr+oc0iy6ADe/ooN19/H4=;
 b=DuLQ4ChypryVrPB1HuOjn9N+QhMqahxDegrmzLGCgVMjIGdvb/m9HqthDRkS9c5aX3
 91NKzFj/RrxB3U0plz8tnT3+1j1+/B1rbDfaGkVETRTOpprGOvdwG6Lt8Yu3AtgVZjnY
 pcNik0ofqFgf7zdYzXZyVgtnpZxJDwgeO729qlcm1Sg8rpXxcLX8AdU5JrN+w9RnGHOO
 MrxomB3B+DNIIsVyDSfEg7yyJNLmZyrQCL1whbp9TUvQV/tGRBWG7WD0tM6umiz8WOH2
 /SIeVb46rR76yL+cytDmf/W1ZIICC0+jxN04FWk0NSSRta81KH/zMPWbi3f7ziO4lYuB
 8K2A==
X-Gm-Message-State: AFq9FYKndIxEwhcKgW0WV6m9JB5ogmkBOclfP56T45mI/YyEAADp5maf
 jYkk3Y50IZeZg3bI2z17dOQVV79MLL+t2yt2E+iaMHd+nteQ+ic58hs4
X-Gm-Gg: AYBFou2cGr3HCz9XAVMm/UmZBA1+k3AJume45SHly+Itas/UhWZ1pITC46LWi8NKhrJ
 BwaarXahKmJYbz0TLL3Lda6iLKaSp9X/qFsDjYOASBCjRn/IARmSTKNUnL6B2fjfiR+Th9JzfOS
 c4Jow1p6Y+kjMOSRtqZgHvp7wJRcC7fMpHOop87NJ0LFViX449KvxbhfK797oD9WrmIbBsmzm7D
 jgvRBYiOylCRXK5nm1ZDd0UxIEkGjzt2A1+FLLxVdJ+0XwG+Ksv0/DBwOQleby8nqdvGSMYLPG9
 Tpeti0ihzuqlDQqev2HG8IfHWQiDM9meCJQYnhCmUXxXl+RMWZSCs8leBf1MIIFq5qguW64sfdU
 PfSGQKFDrHkt0TchxHnYrtyNvxAQJYoDbzmlkiw4NjQ/g/0zA6hTFvL/IhZgwlf1cT0c3RHT/YF
 JjNFvTCgb+grgJyjKL3HbwV2FqxKYFSXggLPO+LV83LqsKY5Rud0ExjVf3Lr5X8qzuBtnFvqKrX
 YRUT05KOkjttPwIE6Hk/rG8V8cpbFyt2lG+W9Rdr0lV/Ak9FD4H2DEjQFkA/EnHQVMIG1choAhF
 /Dve3rOTGlwm+/CiU6wH4fmDv/hGfIw5PxlIdAdTHKs/7Ow02f2+RG1iAawaqMofauwkxmY=
X-Received: by 2002:a05:622a:164f:b0:535:92a6:22d9 with SMTP id
 d75a77b69052e-5383b725bffmr143532901cf.57.1793085968119; 
 Tue, 27 Oct 2026 00:26:08 -0700 (PDT)
Received: from
 runnervmtai0g.ttj1kvl2lauutisz3lmvkbflya.bx.internal.cloudapp.net
 ([172.174.109.241]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c53fdcsm95769256d6.27.2026.10.27.00.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 00:26:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 27 Oct 2026 07:26:07 +0000
Message-ID: <20261027072607.4196-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027024906.31789-2-wegao@suse.com>
References: <20261027024906.31789-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Tue Oct 27 02:48:59 2026 +0000, Wei Gao <wegao@suse.com> wrote:
> lib: New library function tst_get_free_uid

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
