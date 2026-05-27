Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D3ACD5BD5
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:56:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 204053C9A33
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:56:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86ABF3C6FCD
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:56:30 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7FF6D140013F
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:56:30 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-914c12b9458so247798185a.2
 for <ltp@lists.linux.it>; Wed, 27 May 2026 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779875789; x=1780480589; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyWWbHjf5xcH2pIH6+M3+twNk1cueTNIRM5pQ49bLGE=;
 b=ZcOBh+r8D/DuW5SskYxk7cEw3rTm0wHD6QF+wWVbUBX4oXRmiyJA/AAotCY/Xix+wB
 +OiWukeEbGV9cjD++cVHlPwJFquk1B4hCIa7GgN5hnALUdD5qroRdVimGiLNqFXtipnf
 94AoZ+IPSVZpTSh92A97pQCpTzd4981/aRhFltUo4FmWPkUjNIkUWLUkwniFqom106yW
 dSuaw+wx9KieHyC/XlW/GtRg2hUSfaEcg6LSiF6rFNLBApIdzwVi6ifGxg4ayJu+SDwZ
 +X02RlHHnOoEQx268hfPkRMVysoh9aVYJjnHIHhQQWlSa/pDIaxz8aboGXYUhARhgvhE
 Xf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875789; x=1780480589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kyWWbHjf5xcH2pIH6+M3+twNk1cueTNIRM5pQ49bLGE=;
 b=LTTTqdHz0OX/KjEpaWlpRBZv52vV/FEgZGMWB5hMdzrF9fuM1al1Iw31cUnvoyZdHN
 1XpNFzuh6YwnibD8IocWCxK9znF0KM4nRyzV3ybAKyTUkt4praLzBU5jx3gh1kFaPp03
 RlWKNnyZAGihMN6jTx7lCZJhHkIfgFyd4zU8KG3ru4+LQ/o5FFJK90RBquUr/S46Pszi
 wWn5rUPxCy0txlOPoouxpWmeAZO21FcUsixeMrPNjRaSSvMRcMX74c2IW2cI8cklY7v6
 h8nuGudc4ZFcyCC5WSZ0+aMIHbECT8tRWkw/K91BbKGcuDilQyDc7s+XPf1pDllube8u
 4Gzw==
X-Gm-Message-State: AOJu0Yy3rjijVnrqvwUZIhgIrbEOn8q60mXTQaXTpFUZNJpJLNvi8glC
 pMDMomO1uxfwCTZJbCsiFdBqdt+wQP+uMoAvsNga7zdxUNkiLLmHgoAr
X-Gm-Gg: Acq92OFDRny5jFLS9t9DfNrlY4QJncfGCqw5awLsznxC4joXzsAzlpoaJlgp0UA2NCl
 B3aF4FMWqmgepa94CONCSD/j7BdFOiQII90xKL0ge19rkFgbj5NTATBMDWrVD4Oura70UbG3Nfw
 Q3GTDGeKa4iZ8+HPOWcEBqmZ4wNlx5YCRH/uNXas2dlP0Mau91KD3uEO03KkPPJs94PpJGru+hA
 wN/6yC/sdUNqNVWGXLI7+1P4IKG4aZ0No7bK+iZAzCGNXurePf4gqfZh9roO4PdUQ8wqmsHO2n9
 ZmFZzvRpI6K9a+Za8+lMExwfLsW8aeGJxgEYC7Kukk9sjZcTOkFfRQG4HGPUPsDi554hYm1HrMF
 TirzJAvFQda+QSu78yGmCB5y1m470fEfkpj3RFt8K0zaxcHWZBYPXzAYhQ9ttzx6dtYWq8n+mEh
 MPuKzOpQpq1myMvKg0CJrG36670ZuoOPMxDqgcTf6EHG2kZ/5npd/kWs+p/sra+2y08RZqx2M95
 rjIISf6NMQaOczmYMkoZh7C0DnIsciz3JyjAL3T/Q==
X-Received: by 2002:a05:620a:262a:b0:914:c58f:a70f with SMTP id
 af79cd13be357-914c58faab0mr2612811885a.44.1779875789138; 
 Wed, 27 May 2026 02:56:29 -0700 (PDT)
Received: from
 runnervmg397c.sbo4f4120sjejcpudlippbucbf.ex.internal.cloudapp.net
 ([135.232.208.131]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9150af8487dsm66105885a.3.2026.05.27.02.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:56:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Wed, 27 May 2026 09:56:27 +0000
Message-ID: <20260527095627.4035-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527092618.14824-2-mmenashe@redhat.com>
References: <20260527092618.14824-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

On Wed, 27 May 2026 12:26:15 +0300, Michael Menasherov wrote:
> futex_wait06: Add EFAULT error coverage test
> futex_wait07: Add EINTR error coverage test
> futex_wake05: Add EFAULT error coverage test
> futex_cmp_requeue03: Add EFAULT error coverage test

All good. Reviewed.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
