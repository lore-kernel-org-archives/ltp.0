Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186D606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EKPeLi1N
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1753E25E9
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 09:07:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06A003E256C
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 09:07:40 +0200 (CEST)
Received: from mail-qv2-x02.google.com (mail-qv2-x02.google.com
 [IPv6:2607:f8b0:4864:33::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 665FB140162C
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 09:07:40 +0200 (CEST)
Received: by mail-qv2-x02.google.com with SMTP id
 6a1803df08f44-91b851030dcso3090106d6.0
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792739259; x=1793344059; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1rZgw1gRgvsH5d8wlL/H1IvRsCzGu0UL/tdgzvO4DtM=;
 b=EKPeLi1NHRAi4B+xMu3yPa6iAQAVzWfs66yDWFKpMQjGDW9bFcY/8xITaecgHJ2VF9
 4txChAgVlEiIVakvykA33nb8OzYzUhxEznJb3MWm8K98HQJ99wABu5HNpSxDl5GxEFG7
 /6G2p3UF12b/e6vjLPl9P/rAXDEExc8A/eEB1r7NO6q+DvHEy0IMhrXzqiiuMTR7t1Ni
 7WV/58ef5z8BTvfZGiWzekkThyceN8jT5G4JLfAUJV0kJI0uCGb5BzmV3qdurBLNsZRI
 hsbTPHIRxaQZmAf0yTpaZv4P7aftIGcBh75FH5OYOYwg+a9EspM0arowJLTvu5xUXyxn
 xEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792739259; x=1793344059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1rZgw1gRgvsH5d8wlL/H1IvRsCzGu0UL/tdgzvO4DtM=;
 b=rX2nM4AcET7Mu2Pq8Zxe6kIxCmPs9V2IU2Q30XF53ApQb2bypxpkgPdCuvSM8u/UaT
 HOkzm2zIdwPP1q2ffuaAFV4EuN+e7dIljxv0FLruprxAGfV0Sot6d1t0kYiGbl5vEtVV
 xJenm3anIBk19jYJG9gFU5xKh8EDhVQuGLiIehLltH0vaG/1GvvJRVDiLrznyQhYQs7T
 OdKeqba7lF9oBHpd7aZPrsXoMITGEPRDtEOL6yWnDQxifrKOUuOyEqX11hcs5z0VMSQH
 qMZwL212kzK3vai2Bhrm3IIplx4MTCHIXLDgtMOcrHl3EUyDtOEVNqDf60/JYn+QJjNv
 lo3A==
X-Gm-Message-State: AFq9FYKbedpTvfqQDnTGZLg7pYw7KEBIT3yt7uDb2+Jmvrmj+EVpX31s
 3kXFY+5vTPCEhpXuDUZ4SB85oPRDjhy/x7w7dqNfO/zioPBlbsYLv99JdW2bhOeg
X-Gm-Gg: AYBFou1LmKO14xUjgK+KgW/N58XlSVQUZqfEEAtplDuRKmeU+ZqKujfyDpyCZeD34Cl
 Z2PkBO00mP5vkGv0ULq/uQpnjfU+u2dog+Ltyedfs5Quykzsjruie+ZvKsO9bJQRbTyikj4aG4K
 0nid32nSJPGXmhjpbw7tOzCknauLaDUgDLnckk0MrYKTyeCsxKgl5xSWhKaZJ2dG6eCNH250XBN
 hwaABz7A/Iazp3t4FP7lCqVwTjVjw6sVHp4wQ5TBTYLuUBP9y6TAtscZY3edejEgv9teoZQvG59
 zg5Df+B4RaQShpvOB0JWjIWrZYDm2DEGp8si17Wrmk7j3Swro/U3rWsp1xzHrYTursZDqWk811n
 fXef1+OQgHTatkV0msbVrl4Mkb1BsuSNc9q1/QR9zCaqh8qP9X7WQipMG2mEm2fLRADuOSbvTnO
 dIgFrLOCXfBp52bl5v6zhg/pivEh7gITvwIIf4u1NUtHRwAbzqhP01iC+l7NCPzY0QjxkspUdme
 RGyE9FGRIdbIT4lYUJpVQ6MQnDuMtmTG0eEYLYFhgWsFqqiu1V46RGw0TH/3QX7uYyzCQLPTRWY
 RgjMqNIZA2Dx65DXJeP0OLmKRss9ACWzF46tuWjFHWIPsc7ImrhPHUWppa6/lfjL8ahQ
X-Received: by 2002:a05:6214:1c4c:b0:919:53ed:d225 with SMTP id
 6a1803df08f44-91c3a9e6f0amr16960376d6.39.1792739258946; 
 Fri, 23 Oct 2026 00:07:38 -0700 (PDT)
Received: from
 runnervm8k3b6.yxtqycod0cee5c3osj2c14abtb.bx.internal.cloudapp.net
 ([172.172.158.8]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c39507ff0sm13395236d6.4.2026.10.23.00.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:07:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Fri, 23 Oct 2026 07:07:38 +0000
Message-ID: <20261023070738.8726-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023024338.2056856-1-cyyang772@andestech.com>
References: <20261023024338.2056856-1-cyyang772@andestech.com>
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
Subject: Re: [LTP] Update call sites of SAFE_WRITE() to use the enum values
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

Hi Victor,

On Fri, 23 Oct 2026, Victor Cheng-Yen Yang wrote:
> Update call sites of SAFE_WRITE() to use the enum values

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
