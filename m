Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FF606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AWGdjf/m
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 531553CFE76
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 09:13:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35583CADDA
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 09:12:53 +0200 (CEST)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B43766005C5
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 09:12:52 +0200 (CEST)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-13985f8229aso1377809c88.1
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653171; x=1793257971; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dhqt0u6uHqX7irNP59Rj/3OCJWyhgNHnX2056Xx09RU=;
 b=AWGdjf/mgeHmK45qgXUB3udvBh9fNn+YigRtnpu3AbxVwJcXonzVXj/Pb9oACZ/naX
 pe7qRJw+V8+a2zLWH7cuOESURDHYfhswcJIg/Cva8XwV6fsR1v8Nfv8kKOjLEjynVi/Y
 ZHrdyIhjyXxu2BrG/dtmMRtw684v5gNRkCloypAD/WfGezZPniOorBoQalqjsYu/hiUL
 8m74sjsXk03n/X7z3Nu7SZAKpxQVadPe0UBUnuo/lZHiBOPMfSKou9sONK4cSSaM92kz
 76WFgr/9QK0uS6aSPKgFo+jEy5JxaQ3X74M5TQUbgo46qcnE2YP1NHmlz+1mERIrbXa/
 06IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653171; x=1793257971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dhqt0u6uHqX7irNP59Rj/3OCJWyhgNHnX2056Xx09RU=;
 b=hIbRWPG2y3cqAiBRfhz5iyKC9x18133H7Lgllf0wR+TmMxBbgT5IZUF6mY/HlEyiUe
 zP7ch/iepBJGnfXNcBE0D7TNHd6kbsDO/+HSZRzryieXaWvkKj7m0EkCXo7SvCkiKmXs
 FbHFwFnFxky9HC3mvUSiuHq79IfEk7QT+tPeKQILg1Lda2GwdR5c+nUgWHUvcMQPeM8+
 ntoH7bAo/7lOML1tiQdmUUvkUf8YP4fVP4tka2DIwTbelQMxDQBBWtT2MKsfpZVT0b3+
 F7pFF/W2EDaTKjtx4oaKP9ZUkc5A1uxq/Sp20BrkrwTvCwXcSDzndrcjpqtFNxaNS1YS
 gbbQ==
X-Gm-Message-State: AFq9FYJVw1NsIkzbwvI2xirIFCIgquL+i4kHb22gfWIcG2C2w1u31Lve
 mQdpBYYQO/OMOPNI542Rz3CWox/5Vxk4OMluW/fEilsUohUyXJBZ+ChG
X-Gm-Gg: AYBFou1ToUS6KFPx4rfe8r0luVWwIeWjuUI3POZCG+nFtHj3F82vj4fpKQdf3Xh8aJK
 86iqTrbPj1CUUFIjiGz9lz8fXq0IiuhsuMcPIVmstD4sQJmW64ZcBtAdWbVyyfBidgIL3YXYpPx
 8GUzD9Yz5JczcZbVBXSf3qYLkR3uvoOwg0O1kkhn8fIfm6J/ZQf0x6L74GtlfsLKtrjQlATQuHJ
 pDBbHQwl+Ad5/5RGBWQ5r5rklMLyYPHSNYKFEPkv878eMmZVW2Fbmk5joBQkgmdg8tQguAI8KQS
 bpo4RN8kKFaprpCRiI+zNhfNdcfpDS5mAs82PU2ic42f0+CSX/giWplM5pdXf870yW5Thy66cQ1
 pg2WZFE2FEnFc8sZ5ggXyJEVwztzt+R+eaaqjnMJbMyn6QaBL6mybjxGd8+zWHre1L1nDRaRCYY
 Ogq+2ctSr5eOkc/KF+P50ikucOvZJJG5FA/s0407luGA78SP6Ayt+pz7DaZBc5Vsx3YGhm/R20f
 AvTEZe8zm/N7Y8M4Fo3bg0CgeX18XB3GwTu5FpOHN1NwKTwTW4xcDwvfWazHK8wEHK7BscwaLwz
 xDN4Od0jzqV2kSGpPEK9oG9s5sL1ytDuIiVQGyzvtm1OQ8RiK3g432Bx4BxWOk0HHVy0/18=
X-Received: by 2002:a05:7023:a44:b0:185:1640:5536 with SMTP id
 a92af1059eb24-1933bf184d5mr1815863c88.19.1792653170792; 
 Thu, 22 Oct 2026 00:12:50 -0700 (PDT)
Received: from
 runnervmxehtw.si5vesnirltutgysy1tpxjbuwf.dx.internal.cloudapp.net
 ([172.184.220.152]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a275026sm18251818c88.5.2026.10.22.00.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:12:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 22 Oct 2026 07:12:49 +0000
Message-ID: <20261022071249.9346-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022022824.19735-2-wegao@suse.com>
References: <20261022022824.19735-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On 22 Oct 2026, Wei Gao wrote:
> lib: New library function tst_get_free_uid

Verdict - Reviewed

Runtime validation was not performed because access to the required
sysctls was denied.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
