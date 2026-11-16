Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDE606A323
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KoHpeEea
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F283EA9DF
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:15:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C5623C9C7E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:15:01 +0100 (CET)
Received: from mail-qv2-x09.google.com (mail-qv2-x09.google.com
 [IPv6:2607:f8b0:4864:33::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76746200906
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:15:01 +0100 (CET)
Received: by mail-qv2-x09.google.com with SMTP id
 6a1803df08f44-91ea45ca140so16988826d6.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831300; x=1795436100; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7G5iP58fsRfE9RWLdU2GTgfwlJBE2FCD0yTASJtsLp8=;
 b=KoHpeEea6nXqVMjf6LuIg5Zsg66MUtmtet5OnuTDNR8nVPW+RDpMxe39oZXIjRtcop
 BICchJVaKskiH/lXaFkjPNtCgf5/tynMVxqhV1/AV5mZ0JQ3sdF/GLm8GDPngy1Nq49d
 I+Tcf5iHARYFxH3FuKT8K2S9S2iZkj/tVjFSHXayhsWk6ZFykEBEgRXf1ir4E31bl78k
 yN+pJM3klDwpNzw/Y3lyX6cXjAzahn4WH9TyFi3fB/bG8+aDrok0vNqiCxzB0/racuSa
 xFh8+FOLQzQgzflqjIgkt0AXfwAxt2S2xQPwhrKV1FtASoTECUi64zG4JtYMsssGlpbu
 VVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831300; x=1795436100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7G5iP58fsRfE9RWLdU2GTgfwlJBE2FCD0yTASJtsLp8=;
 b=IRLMdVQtxw/114y9Qj1RMjUZFjOPSjITQ8MkvkrAeetfY8gI/cZj9renB63iNOD+kk
 1PYZ/mGIWiGXcT3dEl4EjMc6Kk8WWI8vDNYei0nWo3gd2YL+5RZxk8oel12/aW7dgw9z
 vqty6cpIPfAoZ/hb4TOL74T/7kP1uNWoCOOAvf/m0tZGceVBd6KgVA36s+bahN6qzfAQ
 nCok93U4C078FqBoeY4oyPdAsiUugg+knA7iMSEje/jrtkYNE6po5SAiub0RkoVyklht
 QqoO4fgyKeOsBdSWzYEoTaBXm9HpvNsFJerJpJE6DPh9UySXIWSUdjnUx2gYa7Dw6xta
 BTCA==
X-Gm-Message-State: APuU4Z8tiP+8CwoR4g2wT3w5KNhyEQ9Tj4LkyCsZWQp7fRLZE+6e33uu
 Dcp2/fUw1Mdu23vcfoMn+e7kRuKijig4TpAtewDRvN+94DmJYwCmXblz
X-Gm-Gg: AZFdTZczs8c/nWG3kp7Kb8OjaV/iszMxiDrUFYMKZuoPzOpR99mkhMKz9ASYkyP/h56
 gt+3cbpxDlsGsVOC/p9jlKwwqlmbAJw2nwPU5Z1bpXfJhzw2JqTG6gwqzjGXB+/SfKQvSXB0WsI
 EQ2a5t9VhOh0qTDBhB7HcKGe8wFp17EcQaLc19GggFrLAdERjc2a79WtCi0JJUASdCmIYy7o5mV
 65pg2vCDoOFYPf3Yi/ILsXKRxTPZmJLrwXdnelEUpBUnDePzEcD33S+3++aRWIX6VO3YpZb1Xx4
 zPVZc2QevAN9d33Zi9JcDQIDfPL5bG4dVX2BDelpK4qCHRyYH67IAJAOV7tudJu14UX3cgDJcoL
 wV2AeDXWeyG85ZzXqhktLbWiBUbGPXdW3M8e4wN0CchwVh1zkxSAUWOvzp2r+Ucq4VFIaHcNNMN
 zvJRDmrliXrgT5E5KU+5XNSt/zzpO3s+OXwnB+qwmn6L0GEcMPG0y1GJU2j9fZgZsZYlzBOBlYR
 0ekrG9XXACfDWSK7pHSiAQoDFIOV7Kqh+Q9FCivT1mqlPHz0p1G5CwjyLoJwnjHH8XvW/od3KqL
 Mn6+ApXW8L3pZwun4boBZ3TD8+Y86BS86K+H2eExv+LZFSwJ1qHloAGCjC1TmeeTnbpQWy3OrzD
 NY/YDHiI9ah9fUQvoow7kQwvCUHS0MHVrFhbxxFTDiA==
X-Received: by 2002:a05:6214:623:b0:91e:b874:1290 with SMTP id
 6a1803df08f44-91f2420900bmr155822446d6.41.1794831300178; 
 Mon, 16 Nov 2026 04:15:00 -0800 (PST)
Received: from
 runnervmccnms.t5mktzjs2r5e5hum2mxw3t1oxc.cx.internal.cloudapp.net
 ([9.234.220.229]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d952fesm83514286d6.32.2026.11.16.04.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:14:59 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Date: Mon, 16 Nov 2026 12:14:58 +0000
Message-ID: <20261116121458.3877-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116073956.98789-1-zhaogongyi@bytedance.com>
References: <20261116073956.98789-1-zhaogongyi@bytedance.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify13: clean overlay workdir when restoring lower
 objects
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

Hi Zhao,

On Mon Nov 16 15:39:56 2026 +0800, Zhao Gongyi wrote:
> fanotify13: clean overlay workdir when restoring lower objects

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
