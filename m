Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558E606A31F
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EuVjaS2M
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1D8F3EA3EB
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 20:04:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A32E53EAE02
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:04:03 +0100 (CET)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E2C560049F
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:04:03 +0100 (CET)
Received: by mail-qk2-x03.google.com with SMTP id
 af79cd13be357-93f21bc9a5eso5687385a.1
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127842; x=1793732642; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPihgWqVk44t7yYvXs3RcYwkfGRMhSqeldpr17FhJkQ=;
 b=EuVjaS2MCoQxeYeMDkeaalK9m90QvBtjwYU1/H1aFWCnGmIoCZgcwaPNZy77HVkEei
 R/SOHHGkO2+/2XYS7qeyIeGx5KCWNCDz+/34082usV73V1mnMrxZtLCeeARaezZ7eKL5
 w0x/QjNM4TtbTExijCJPdSepcOsC3h7UbwC+w6sa0jxsSGWc5nSp3M/KN18TYaUvQKXZ
 fGnsyYybIloIQU1EMsyGpIDKQZQ4yTEeFtHHZ6n/mLKQ90uhndotY58O6O1HmwgW5yLc
 NhAuJ86G9rsfDTdhKPDqj44y58LU1PXiOYXdr6uBpqjf+mmiahbZj2OSU9RZnBRze+rz
 f2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127842; x=1793732642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DPihgWqVk44t7yYvXs3RcYwkfGRMhSqeldpr17FhJkQ=;
 b=md6UE1VOBxyrtlFY8ba40YRIYbmYkyRqKT/DG1j6yQViKWky5PVIhiLECN6Y5bC5uX
 DnUTsU3nUyuM41HMIHjzuROVMqyAINaXmERCLSo6+Z5HaOMEvFKG30h7PCvE0fIZA7Ck
 QdYkQhXyPhRbnfMPP3pFSat1lE7PSahSCXlNb0/IIzWmFb4VRuFl1UDYDEkbhlT0ERQY
 H5iJ66+ovA3PAPiwHvt0+lusL2PVw35JF58wQBUC0QTLZjWobsxk3uXECYvxqfzzLDim
 s9seNlTXj9Cb27zsFuHbXaHDbDSHnBIBj/TIY77+Bc7/u5xurU8SjEkf9e+SPs/FgJ8q
 2EAw==
X-Gm-Message-State: AFq9FYKQMbyHTX/guXyH76KjD5sh99nnQavxN9Bux/z5gmcQHymzPOeU
 dtnnM6MTXBJ2ss2QFGYs8UZikuiDkYNkYSrgA+Mn2o8R+B7ui07gghok
X-Gm-Gg: AYBFou3ge1Smp5hEkpxsqEUJ2Fq0y43OxwpPIUzMHsK2ZKryT4sNizpxm4aMFo1Z/Gn
 5ZWDtobbUDn7o2ftGHTcPIfb5LLcTzGiVRcmoY3dsBGZQ+kCNGvV0OR3RaUl2Ho6evfawpLGLAF
 eY/ljU99c+Qx+p6QZZReCCJpq5buc7CJmxLgLNiy5az6X6xHOlAEsoGTBSZXy99/IORCM/Jczv4
 GE1tZsiklNWR+nUzaCTpy7/9QI+b8pq/oIYEHt5tHtIJaNQmYMUvs2hM3tKsg0EwD8bqRwjuPLz
 1vx682KM8oswhEweMa+XdCdjaX7V/Oy2qFUf5/Xe4HnQbHJ5S2MHVqUe8dThHbp62qACi7tDnQN
 T5XYr8xWYEZP149RjukTyi9r4OpBY8m54ZTlwxdKL4brA7dbrqX+XvYgha7ZF51eZhKzLEG+KxQ
 8MziVnaC12ClOO71BjEDI7FdEBkWc5alvF7muSzkjWu45bLCqhF+Q3sAh8efE/2CFYYfhHDH1wM
 Qu+l9Zh8BC66/Y2LlnlFrjqpDWqsNP9iEczkOtoZFCvMUGho7NTFeODR/m1foILVYcPtePDBD2c
 kU9yBXTNAevAtTnzXFhLEUNQ6/Iyc3TZ/Xh2tdQdQ2bniGBpH0liz5pMUHObuy4nChzjLgj1OTT
 qteIJdGvIYeZwkHQ=
X-Received: by 2002:a05:620a:458a:b0:93e:5ef8:c794 with SMTP id
 af79cd13be357-940ef8f03dcmr1653648685a.38.1793127841753; 
 Tue, 27 Oct 2026 12:04:01 -0700 (PDT)
Received: from
 runnervmtai0g.acyskmvghfkufmvkr0iu0wv0ge.bx.internal.cloudapp.net
 ([20.115.102.158]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a8164asm1046188585a.38.2026.10.27.12.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:04:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Tue, 27 Oct 2026 19:04:00 +0000
Message-ID: <20261027190400.4266-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027142747.19192-1-sebastianchlad@gmail.com>
References: <20261027142747.19192-1-sebastianchlad@gmail.com>
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
Subject: Re: [LTP] lib: tst_device: Use exponential backoff for loop device
 detach
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

Hi Sebastian,

On Tue Oct 27 15:27:47 2026 +0100, Sebastian Chlad <sebastianchlad@gmail.com> wrote:
> lib: tst_device: Use exponential backoff for loop device detach

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
