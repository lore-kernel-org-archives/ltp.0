Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE32606A891
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ebFCzjHd
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 187743EB420
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 23:37:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA3B3C0960
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:37:28 +0100 (CET)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3931260083F
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 23:37:28 +0100 (CET)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3b3a6a9102eso267816a91.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794868646; x=1795473446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=47C6nAEbF0rD4dDHLaR7XSFNonmPZSPbnkUVRRuJ098=;
 b=ebFCzjHdse2l7gVBpAOZEo36p6HUdm/i8lldq8MuZXJntuXtItsUIPQ/Ww4PVRk7y8
 i2goxNMz3y0lgpjQVmiLaVBU65vZLvQKKlZsecELlEp94yzCds2LlC5yX6xCSTJZ7qhf
 tSEgzCsc7e7tl2+Q6CkgEdzh+w9rW2wNZLxfe6kV4GkAhjdut7NGudUU6A0wvobMn43a
 Vyjt6pLU7z9h+DtYH8yMHPmfyAyaymg5tvRBSwGnZwchUL16Ji5ePK8aAz8nQkyJmb2d
 cE+m3EWsQnvrsSRO8Nu9EgyNpsVri0Ivjk8AwcoGBoeT1fCLeJGihDLcmMKTDxaw+N7/
 0OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868646; x=1795473446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=47C6nAEbF0rD4dDHLaR7XSFNonmPZSPbnkUVRRuJ098=;
 b=B8hS4c/AZmsynf6Amxp+5RQtKLjU4hrYk39+96DhLMJcPKOCuhSiGKqTqKfUmyY1J5
 FC66VAxRL4+LS8YkVY4h5NVnJzE79SpRmsFnq0ltAIFHBHVqwDhUqoByq+/qVTDDwFCq
 u4jwImP6GI9ItUUZCxuKfHn557BnRgs1ur/UAA8icUNhuLkWF/Ct9AcrRX8KxcI0r4Co
 cbsF5Fn2CDlNNth0Brysmf52pL9ts7CqAsXEwcVyA8yMBj2L8TdirbNWqtmCEBvt2YiN
 op0T1T1Otw+Z/zDEL9QMmv7zHhNpkyAKREhTsaidBAnc80MR/eOO1pbIPJ9CYTruVJGG
 9Oeg==
X-Gm-Message-State: APuU4Z/ELE+Lm+HFNtHiGbcuWXACoDZnkAHcIrATSK2+KNJPR/N3QcNr
 uaSI87cKtAWMoSb1zehlRPHRcIWDB8JECwPE+tyxvzQy0h3VtwxLz34X
X-Gm-Gg: AZFdTZeD6gF5ZP8ymQj8Lu7T8oc3D+j0Je4q9jTlHbdMJPtuTeUHs5yIKguJy96bhsg
 pK0dRPOLHuTS/sHGLT2/GA2KttED3Es/6dHkJb2xd2H6DOfIbrZzkA8wqfDaYbGbLwhsvgKBMQl
 LEanfBE0WqDAIdVGRK5LHKrlmwcSp3ZyrOJewzC9q7x+zyPpR+ddhmnkhfe7++anEzu0lm5M0Gf
 apotOw25hmmEAIIv518hbeaSyReTjmbTXanTOR/rBJ7sb3j9d1mjyVIUrBcKF9qoIjJGt4db1+K
 2PQHgolgxIbUEIc6FrlF13BW083aY1/yM639ePwLOf5DMNhB19o0/yTSahODXMX5WYlujwcCR/t
 nX91RXkV7QDLJUUGPBCBriRjQ4hFhaqv98XdfOB8dwQYVRwUvNOOi/Bjvzif2dsuQsobrW7i4+l
 xJHDyEygCmM6YYzI0DzEr60R0G4MCNsPyt9CWgS4BycibLe2QaLSPuXO00FT8/79FqO0ubpYGnb
 H/a7y5HlWzyN2QdfSuDEEKlQeK1TIXL+QG0CCmMds3ldTeBnob/W6b6J4EveeGjCMoXmkOUKRDR
 qd6xhivxAU6fE/bzN27LTdLfxaZu8XiIADHdFYia+w+x/+lis8VMWuBH0iCpkrcqUYC/rLPkZ29
 6ueH0iyrNDav0z+nmejF+3rbbFEmnL0RpRgQnhfxnO9K0v5m9sSBEqsulWd9c3P/X
X-Received: by 2002:a17:90a:cc06:b0:3b3:a575:847a with SMTP id
 98e67ed59e1d1-3b3a575856bmr1207175a91.40.1794868646427; 
 Mon, 16 Nov 2026 14:37:26 -0800 (PST)
Received: from
 runnervmccnms.ph5pejhl5syefhkxupy2w3okvh.xx.internal.cloudapp.net
 ([4.149.238.198]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b2133c5dsm9026207a91.0.2026.11.16.14.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:37:26 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Mon, 16 Nov 2026 22:37:24 +0000
Message-ID: <20261116223724.3808-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116150911.667095-1-sbertram@redhat.com>
References: <20261116150911.667095-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] crypto/af_alg09: Test CVE-2026-52972
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

On Mon Nov 16 10:09:10 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> crypto/af_alg09: Test CVE-2026-52972

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
