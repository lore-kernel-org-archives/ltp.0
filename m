Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E08606A31A
	for <ltp@archiver.kernel.org>; Sun,  8 Nov 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3BbvwOf
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 604993E21FD
	for <ltp@archiver.kernel.org>; Sun,  8 Nov 2026 07:49:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 396513D0627
 for <ltp@lists.linux.it>; Sun,  8 Nov 2026 07:48:45 +0100 (CET)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFB9D1400510
 for <ltp@lists.linux.it>; Sun,  8 Nov 2026 07:48:44 +0100 (CET)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so113419b6e.1
 for <ltp@lists.linux.it>; Sat, 07 Nov 2026 22:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794120523; x=1794725323; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cuQ506jYbq4Q/SM32k7cjcKlugaROoqqG+1zivCSoOc=;
 b=t3BbvwOfnhqGb7pusyv8KAVoMugX7S3t7EVFUxd2QiDT3N4kSYwUvhQhcRMnEidVsb
 aHQjElAp911AkStlONVSu4pEj4ICavn+ldAlOmKJ9Ekyxqof+iaNyR1ehapmVeyIqUi/
 LAy1U61S5YVxIdY3nTnU7dicJUrG4p3ZDInm2LthZEm9jSdYQmsqDIGBEBCOXvQmdUQT
 4AO6ZwXbEtocHm1BKuExdeECMglz90Zh0P1Qnsf4KeY/vFwGwAaqKVuLgJiHacodJLhA
 +l0iflCDvdL9M0RVZppg5sK/TtxajNJr7oTc5sEr/5rdc76aHgTkVET33knPIpcU/+oW
 7bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794120523; x=1794725323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cuQ506jYbq4Q/SM32k7cjcKlugaROoqqG+1zivCSoOc=;
 b=awg5uTG/zMOxgN/4KRe9UwwAbGOXcNAJpJcd/JktiTbexgvmoFbUhAYpfMJuXjvucs
 88GvSBhIaQ9SyxR+ap476Quyyg2SalXZYQc+r7Nd0CATtJbu01ADK3CoR7/Eg+R4bg9G
 AOYFnWM2VVK6DAil+p66RJE7QUYtoFcDBFSy4+PxvdQEqyY9cGB0p8YMKrGEzUMnKzxf
 rO0xOrVgG5mTmHdtIWxPQrwXSXoVyuTHUipj5T6V0rqsWpspWPVJeYSHp1Qz0WOIgeay
 LTBr4kOF2/lFWEthHg3NWQPqGBjsHcyazVfS5Xowne3/COWnVX4EfmPxBDBGGjpD0JHp
 rpCw==
X-Gm-Message-State: APuU4Z8cY3Fz46E8crlj2p/rUoBo7yqJr9JAjzLYisZxX0VTKO/kXQfS
 2cyR9cF22v62rgQDcAKgada6gRhYTZwgq2Ncm16Yl+LEyH5WpGrGK3Yn
X-Gm-Gg: AYBFou1WD+SHTbC07j0yzS5DJuqMNFw7RuAFYGx7YK8qnl52dY/berXahwGBYmPpqzu
 s6LDa61GGpd+HzidfbSQscnwCsQvGKEJ84vUD9vHq3c3EuCWEDRlEmqsFif5NjCud+gZIbkx09A
 SXwQukh9S/1gItVxb/64M1BOII0k40laYW2LYG4zCdblne7dGZbqOYxfK1R4T+KB0mQYWmhN1mF
 u1K37+z/Qohf55rZS95fr9UETRpOrywWJs+ycImuFPbzrzPhWQXp9AILPvJUWcMyug2h0heTVvt
 tWYOS+jQPdCwhFrs4s7a4hWo470JnjdUh5HPFnzcCJUlBW7ivbo6KSCLjBmHVrXq1sH7H/piKEh
 4lson1IjQMFiiU/BCk4pSYM0kDWQdSS3V+Tw672rN6E7gN6rUO59kkUN2OI6/INJJ75zdRePcBe
 HqPiHtUSHV3O8bKZ+ZGqrA1zgkm7lSvqjoe8KHq0ReKRqGCsGNpbqhbwEDsJfGCcIS5Uz8Xc4XY
 cv5MiRpUk0E/GvI4wuCrlEfwYlTverdYWA8gycAureL+6bvga9dGyV8pt11Qt2hWKmnFRPBVOod
 UHuLudKAzhi8g8P9pNufcJMsWxE35CMdd1QQ54TxRw+8ge/wF2zXHSJNCfJZoMWKFlAu+AsEiEB
 8vAdE7Rv/kb41ggtqo41gx5HiwiCLa2A1mfTDTPjomcc=
X-Received: by 2002:a05:6808:1383:b0:4cb:818f:d56f with SMTP id
 5614622812f47-568143a8337mr603215b6e.23.1794120523462; 
 Sat, 07 Nov 2026 22:48:43 -0800 (PST)
Received: from
 runnervmwuk1x.5li5uw2hrgtubf0q14y3yw0lbg.gx.internal.cloudapp.net
 ([52.165.102.161]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813df1277sm1126254b6e.12.2026.11.07.22.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 22:48:43 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  8 Nov 2026 06:48:41 +0000
Message-ID: <20261108064841.3781-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108062034.41022-1-pavrampu@linux.ibm.com>
References: <20261108062034.41022-1-pavrampu@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Sun Nov 8 11:50:34 2026 +0530, Pavithra <pavrampu@linux.ibm.com> wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

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
