Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89515606A32F
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGM+heNu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 080F33EB2CA
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 22:41:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9FA53C325A
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 22:41:27 +0100 (CET)
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8DBBA10009D0
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 22:41:27 +0100 (CET)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-70073621339so494710eaf.0
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795038086; x=1795642886; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DMb4i+cKTm3k0dMEgnKPuhihQ7jOLchLygCoeDLA+yI=;
 b=OGM+heNuJfWhPxEcKmhlST9MVHYZPa/b41NWUSFLVhMuPvZxWJCcXJXhFhYiL7dpVW
 NPUveDjdyph+D6TjD4JNKIZVTFH3Z87I2OFc/BjcPlRuLNAPaf9SQpTWeSyAQmbeBvUe
 Ontr8YJUNPvj0cd56bni6/XkQIIZBzyI+y2fKiEDWmUoc5dy6GOk/ubi26slVsM2ImXN
 6HmI7bpcXsPBaUCBOmcQwBwXKUTzgguqVsZ5yy3Srx5LT7AgvZaiL4AV6ihDT+Ery6GK
 iHBnN4cU2jJQ4pzj5CdXXYduLl83j57An9wy23/FinbcGsUfIBalFXSf3BsydXRChL2r
 ZB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038086; x=1795642886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DMb4i+cKTm3k0dMEgnKPuhihQ7jOLchLygCoeDLA+yI=;
 b=P4jDhLMMrKKdUPKXWLr2CUkLUsDkUpKClbZ+gj9rEyF35c+s9OtXzy5YRxt7l+ma+0
 Sddc8a7oqfnI14+0xtgiGZQzdbxJJb9mCtRquGHD4renEfth/fTfmplmBZkEKBSVDP4X
 PpfqWzeikwJ7EvBvhbSA3lSUt7VTzrrjTArRglpIzc2XGEVWjydw2CvScIyhBLhkVy+Q
 g/gKX2nXDF6JPG3VNQXMxshLLJMvjKRoNnOH/zn05qBUKCvvHaeSWtWsNktw0qG8ccPp
 q7drY5CduEsNfKE2T4LYQykMlOLFlvhZKPhimLZWEL11/SSX3eZxy8rFGCKpaI3jt3Bt
 EejQ==
X-Gm-Message-State: APuU4Z9au3k6dmkcPEVZusMxg1nIQnWEJMob7XCj4Suh/g82+TbaQnIq
 2s+pLnS5WmMKoQS2PY8+e7uwqzxyQTPuMtB1yzdCqMnp0uomwnvjY8c1N1iT9cr3
X-Gm-Gg: AYBFou2cLnN+wMYfAkfaU2vuFmWwcMLl+Ghl2+GVD+XQF2nMP1sN9T5Jcay/sK7ovgf
 2ZY5JxYPMWBiTCbnfS+vYZ7+cp0oEzNzLjIoSQgmCvkv6gsM2x0XQp90LxGRWoKBeDhzNIa+24p
 UKVeuaMX6GcWYg4s6FEWdTujLbJ4Sdn9iY0kZGokaC9xJ6inRmoG6F6vAN4GB8UL8xgP2ls0Iw0
 WoWoYo9PMczW1STiajc3oZ30fxsd8/psgHxKqMpy+gw+lNZ+AqesR0JFoBrfTVJdUIV1XYDTi5a
 iRab0FPEDZ0XISX++DvKRisrKaoMM5bCONL11lMEyG91nvIzX3a9/yuhJGugQLlyrCHKDhudbcd
 tj6GoAyqYqpb3uP1b682qDsCEwszHvsghMfFu1IDO+ltabBhyPQII4spkeZR+EZOMG4R0eWVw2z
 +FdRDFHoWFNhM3wHJ8QrasSn+rKTYnzH0nNrFolm7SpYIUQptGXjLXFS5iMgXkXZzGDFmLCD5tv
 6DqPhnPXoD5BekowGTnfyM9xzPn43TfiQ9Qrhol9EBzhQSTfrqNXn2HX+wtIPikjDMkcOpzBYs/
 aHJ29AXj8i0PTVzTDOeWBleAg1b+akQDw/beib3AfffMl7Eyq4RUsL4o2P3WILcAIhLE1/SBu+0
 XsZmumIL+I/iwMs99ujzF4gIfN3AY+X2fvnPofz3kZQ==
X-Received: by 2002:a05:6820:82b:b0:71a:f0a6:e2e4 with SMTP id
 006d021491bc7-71b1836b8e1mr3130225eaf.8.1795038086137; 
 Wed, 18 Nov 2026 13:41:26 -0800 (PST)
Received: from
 runnervmccnms.2c5nrm3boe3enn0n421mfffcfg.ex.internal.cloudapp.net
 ([64.236.201.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74560e8b7sm3229705fac.17.2026.11.18.13.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:41:25 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 18 Nov 2026 21:41:24 +0000
Message-ID: <20261118214124.4120-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118143256.195124-1-sbertram@redhat.com>
References: <20261118143256.195124-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] network/sockets: Add handshake01
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

Hi Stephen,

On Wed Nov 18 09:32:54 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> network/sockets: Add handshake01

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
