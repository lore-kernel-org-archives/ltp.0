Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D1606A321
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RsSbr3kk
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75483E5A0B
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 07:43:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FDFE3E1B9B
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:43:19 +0100 (CET)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06FB51400E1A
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:43:19 +0100 (CET)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-5332a0f6dbbso5908531cf.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793342597; x=1793947397; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cbolkjJDPeCPixLCTn5THch7agW42OiYtesAu76Ea9I=;
 b=RsSbr3kkH8yEe463dKpHR7k0UpQddvmbUkZk4pbd5v9TjxdO15tTY+RZW7fTPhKMco
 2aO1LUHVYW6RDKJwkBJSQnFHorHwA6t6A0N/KF0N6fi9rM22cJDnbx+AHKPB2qa3tCFr
 7526Hor29LmtYzLj6LRstzGE2OcvX7OLc6WoiUxehFmIGuw4KbSO7ssUhWShw8KAMZWV
 uGJajoNfgaDnGDHKTbv21nVCEW2tnrFwR32G7wtiutt9kwMIBBI+lyxsEPQo9lJ7RN1D
 C9v4vZiIIKOT7sFNXGJ9wCbY+TZwmtndMtd2+2ZdxZqLbl7OnEhw70OP7HfLRHrFolTv
 fb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793342597; x=1793947397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cbolkjJDPeCPixLCTn5THch7agW42OiYtesAu76Ea9I=;
 b=olstT0gg3d05NyYAi1QdZJpMCMOQfLYzzKSi5+wwMYRGg7N4Gw+JjEjVpW71j7pQmy
 Hv4aCeW3M9Jcu5sxVHQAtGI4+5QNl4NoGIgdN1jDroKVLEPywYTc9MoStU3ZUiHh6z+/
 Z1TP0Ho1XaTqDiEXO2No0sj0sIbwg7ng8+vB5NXtT+7Qm8xTtc88lRZ2svX1R/vkfY6G
 XWUT/fEYd/lC/5BVq5yhMCmrBWjtqLf2lxLmdgEp7JwO8oyKWqYsRVZuVuSmLcdJnR4u
 1rxAXR9As6ReqF7k6+JTiM5hu2NYNWEMMtoqRnbZZ69tSREuvv8GgHAHR2UKY2BI51GJ
 qeaA==
X-Gm-Message-State: AFq9FYKZRwtjpqe3tJGPdtNX4n4z2BhmbAs9wcArFocmfaWxKn/L9wQ1
 Yf+xlNapqSDmxGU8M7z3KkQpH0m7vuKiotdE04Lwr+BMhkMBFDF8oPUpMzyoWaRxxwc=
X-Gm-Gg: AYBFou32Vp35aYyrwVKcbAXGlEFlRUHgrmC38lMW1v6MEX9LhFB5WuCxCJPBU15VSVO
 FzBV+Sq+I0v5eSeZfwxR4PA2njfzJDMAe6wRvAoqsBBkB3ZbrtLfD279GjAIQ2bXhlsxhTp8bO+
 MmdblwyIgdWEKvwlDoGe3IUoBznRpF4JL68kmn79LizU5cd18Pj3ZiVmQOM6WeSst4UO7IvGuKl
 ECTb8KdmNDYjPveT1wyl6Bjm4WtOjvsWU/N90b9FyV9AtmzPnQn2U5ZAvjzs20xz27EzeAlE0HZ
 zznOwmYM6ydEBvynfyOutybufXZLkHtTD0X2FCLB6BBzSNGktrVn8FQtwAkLESnbGsNZY+NeaLC
 1OOkkOwUSivBV+b3An1UQtg+Q8a9/4Wb67vwRYRx/IZ6rlRRX/e4EBn8FnNajs3zDNVWBfAovsP
 tJY1cSdALSyXutWdDuRzn4o5rGHOqO7QFkUDF6wpaGvd4TIXZJkIdqfjLKTAbNLjyiVpWgETx/U
 y/idnz6TFCnH6iOcLI6Ya/8l7WO5JS/w0p2H60jKnwcdkaW+G29XLKgWy5UDVFDNqDUVGFgIHEx
 T7/mfWPP1Y7iUaxqTaFO9Q9Ws9tDpE+d3McUx0qtyXaQ31aJGgVr08a99u2395mcsl9R0dsSow1
 jzKmcgizOQ4msSqb3JGnYrq9UunEQJ4vGJINSH9vy
X-Received: by 2002:a05:622a:4c1a:b0:537:d4b4:3617 with SMTP id
 d75a77b69052e-542b3a784ebmr23105301cf.6.1793342597219; 
 Thu, 29 Oct 2026 23:43:17 -0700 (PDT)
Received: from
 runnervmnwato.djo20zqc0iyezjaecdggufo4df.bx.internal.cloudapp.net
 ([20.83.158.34]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54312a5943csm5956121cf.24.2026.10.29.23.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 23:43:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Fri, 30 Oct 2026 06:43:16 +0000
Message-ID: <20261030064316.4147-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030031919.3383729-1-wangxuewen@kylinos.cn>
References: <20261030031919.3383729-1-wangxuewen@kylinos.cn>
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
Subject: Re: [LTP] madvise13: Add test for MADV_COLLAPSE
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

Reviewed commit: ac63c2921 ("madvise13: Add test for MADV_COLLAPSE")

Verdict - Reviewed

No issues found.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
