Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D035606A320
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+ZL9gxO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94F683EA0C3
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 09:36:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A5E63CE356
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 09:36:27 +0100 (CET)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97973600B07
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 09:36:24 +0100 (CET)
Received: by mail-pj2-x04.google.com with SMTP id
 98e67ed59e1d1-3b10718b387so1882364a91.1
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794386170; x=1794990970; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8bIe0jtJB98i/IyYhYRe0iTRuhIry0j5BVUqitwX7hk=;
 b=n+ZL9gxOsutkWmcn0efYikgueOQbrg7o7scuEu8MF8M9Fz/jB7JQQ0y37ZD4z4RynR
 riqfXa48StTO4rNwLFAyjDtD+CXHAC/AfvtS0xZAtbzy+Emlb8wpo8r47USX6/iFzRQb
 CRYmOMUrm18E12M3E2dAj3mENZHv60K8Xsj+xVuUNr3Qi8M4vFbZBkWZos9Go0PBaDeH
 vF5qcbOVdFdHn6X8+EihFrqJFfcXSxLiKB2UGooTt8HJJH7At55xIN4wqr4cEtAaiDJj
 b0giQb3X448rUgAD/GaQbwlEjhT2VI3DUkAvMVLP6eWmpWihWXGfuN2dtopPT+a+iYjp
 MgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386170; x=1794990970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8bIe0jtJB98i/IyYhYRe0iTRuhIry0j5BVUqitwX7hk=;
 b=1YXq+SJF4fxSfC2MpV9boIBoU95r8SvOX/k9igfUb1S1iCRc1Fm6wHnUMcoqRU1I4O
 E+nPiA++8EePG/MLxMXUoGMlcBlvTHb19qfpHDZIauNTY+2j6+/+klSTfY1l5kHx5BmZ
 UOsKyDgUPMoIFNn+0sCkp+khHgD20uuxqhPJ4fzlMpN46SiWv8XI3FjKdTjQPeNiYoL7
 mg0SAKxHZmAtGP3LdCrF2mkkCRPg7AoLBLYSngs+dFy4izTam6gQVzjypOuYi5vRIp0z
 4UW9TXsokaH1tHC7HTOl01nfKAWB/J4g6Bz9A4JDhr5HtsiNJarqXhVdrrsqO0ZV0DFh
 wvVA==
X-Gm-Message-State: APuU4Z8FGlMX4UTeuuQ0m7Edn4C9IOZLQZU80QW7rausCebthz/CUW+2
 oRRBJR0cAfvk9ldgrdBuadXluIeOYDnRlXGLEzJkYFH40dTKmnDs5Bc3anX3TBSh
X-Gm-Gg: AYBFou3MQX+8qzJr39m9iVfXPDOWI6K5ByodnmB89jhX9CYkll9BDFx75OvFRdXJQ9J
 jBRqSN4uBTTNqUneTrti0/cV8EjZ9CjWitMr4LWTC1uDo8TzF9ERA9h6vFi5G/S8xPcIgqsMOjL
 Y96PRhlebboGiJk7Gy5/oShRIjX42MWZPTPNKkj1vG64u9WpJM+ec9O1jSLk09qkpVAGu96gg8N
 /KfIZW1+EuT/QZJX61O356A+VmyveIMP4BnuMhkEcboEqkp097A6ZNjhW3L0gnfNt+CnpgGKAow
 pDHFC6gs56YfjFVwYd/kaR7of9zfVondm2ojOoZtAtm0Ek32YdSbDtZ5L/KzBbisdDBxBqVTMVK
 0u0O4WcT7WUM5ruibAhZkG/mEvfDlrn5P8zLXCPfVg5JOyegwREBCwGe+1V6xfNPIVqq89NLOKq
 lXuQeHbhr5EeTcVrP7Wiua8mi7950Lf7JZpPRrC9SYlIjxbXFoISYhatp2hlm7vvn3U71iyBIRX
 5Ct0WP4/c7DX+0yTjPMLRQLsDuaiEFoRoPasKqnJkubUp1whWmtUtVNVdeNLvKKKCmHeBEXmmD/
 ZaU/+ByMnDG8HUQaj/q0rtJv5ZnSASV0qcJ22trsn0BmU5R2FmEuerN9DHKSBgTiCIFAnmaenBo
 nuVLOCoIhMQMBNrsAWh1cM5f/fI866+VmK2njSsai6Q==
X-Received: by 2002:a05:701b:21c3:b0:187:c940:21b9 with SMTP id
 a92af1059eb24-1b3c032e0f4mr1418797c88.30.1794385825246; 
 Wed, 11 Nov 2026 00:30:25 -0800 (PST)
Received: from
 runnervmwuk1x.teebitay320e5bokkizavziwsh.dx.internal.cloudapp.net
 ([52.157.33.33]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b20c55sm12376403c88.8.2026.11.11.00.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:30:24 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 11 Nov 2026 08:30:23 +0000
Message-ID: <20261111083023.3953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111081150.15101-1-wegao@suse.com>
References: <20261111081150.15101-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Subject: Re: [LTP] swapon04: Settle udev after mkswap to prevent tmpfs hole
 filling
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

On Wed Nov 11 08:09:10 2026 +0000, Wei Gao wrote:
> swapon04: Settle udev after mkswap to prevent tmpfs hole filling

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
