Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD62606A31D
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qHJEEsa7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5930C3EA3F3
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 17:36:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374E53E2105
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 17:35:55 +0100 (CET)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C752F2005F5
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 17:35:54 +0100 (CET)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-93e5da88874so118544685a.1
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 09:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793032553; x=1793637353; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ifKfkVJZS8K2o73cLZPpe+AS8PbTtT3EuEr5zSnD/iU=;
 b=qHJEEsa7OkwWgIOJ01CS59GyZ2oL17WtAPK68h2wgmtxt49cT/HjwX4+QLm3J79MGA
 NxIFQphsLvXA+KzAvqFkKtlZC3RwYl+ILDCsraMyB6L8ffBjK7+HhAQmfv4E0M58BjAa
 /3PUStDzS4taGZyVA6Ff9kbrwlCyET6HARTUGjz38uvUs/ThJQMMOZJWFSus9DIn38R5
 p1BSv6Bn2eg8BZESqvm5MMZX1N8NsGPHNU42G/aPy4iPby3yzj/GcRSo5EZnboFOGJTO
 ssnb3f/ORBEcfVAz0LXKoavCMLT/iOb5pwp1EkvyNhqNgT9iBhOwUqlzPc3gTpM6UOwg
 RuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032553; x=1793637353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ifKfkVJZS8K2o73cLZPpe+AS8PbTtT3EuEr5zSnD/iU=;
 b=nNVKsphChe+hRRJsXWRTcDr1OdMDNEuzUq1FDMqzZMnmJxv51ACRajcptF+uYTJAi7
 x0hTecrw1ujkYRrjsGwcnTNbrytIZ1fJtExR1nWLqSD1rV5QIti/WV0nC3pyZA2G7c8t
 gBpprHgYYetn0LE/V5NXjmfk5FyxSleGSFtsfiHZ3lvixOqlEVHy/iuCH+wclz2P+s9j
 pnTp4RdyOose6WWIErdNcls9BNb2zP1c06Qs+o5uWP7rZU9CJqthq3I/cvYvdvx9hcoo
 gSNIw6xbWRlteFQtj2EAA3/WQ5dfCPQgpVqqicWOW3EXrxSzdG3F8wL7mLVoWEyl6OZv
 dy8A==
X-Gm-Message-State: AFq9FYKH83TvSTS1ITcQiLGiR9PSVVUmYbMJffB2wxehjyE6CcjXWnd6
 xiZNgvHIhCsJ8hVbynXsyih08QVS8Bw8ka7OC9ImR9jeI6qVT1YjOMhg
X-Gm-Gg: AYBFou0WcNNq6NPK20CJ+/Q+rb1C4+TZFjV4Cbrz4hBsKKv16mavm1KVl4B66cPhRH7
 UDZsQJpHmqjJPkRxfOLy3GD3l1496Or/IL1OXpy1VmfI15kYiqW84bDrDUlJsw221Bot6a0xkPP
 nOSgmojPdCTTCPd25JcHAtFcUcosvzMKgDFy8QQFegatV0T6akfczwItpeEcrWu96dh9YrvKFfV
 0hLk0Raz5clW/+896oZBdx3pw0FYkNfThgB35qLXiRNYYPPMqqLCoWkh1ONC4LuVfNdk17Pas7i
 6KwkDcCzakAdNO9oXnrv5GQqk5daY4OrMCvbwmAV/g2dUpbKNIn/dII7Wh54TJfxuvbsdFhWCJ3
 XuzQkrrPqySdUBgTK5LV1FXvhUOVEgk3tdjWVsn/9Hihvs1Qsf6ZxVI2MxiHKrOead5TUulQNYs
 r7o4sV0Qu0cst2rJUtFTsFad1Fxe+sp/oNZQDJdumvEl1wh819pql6n96ibTtESlTbZz6ixPorE
 qDAFiK9BCEM+24LZCjVv2NPRghzTq1WYH9hxAtQNTV21HpnZwOoTolAhiO0fPS8YgWkAtqjsgZ2
 nf1l0jDHioRurf7eWoPyd8ql3JlvuFhL/0POZpYU5VYyDlwt6o9hU4w6QEuimjGDlavmQMEKPsh
 3FmKx+2Rj84xWBrsvnTLuOL40T8+BgrlKQkyX7R5GTrI=
X-Received: by 2002:a05:620a:1a12:b0:93b:d7a2:dd32 with SMTP id
 af79cd13be357-940ef9add84mr1187849785a.66.1793032553330; 
 Mon, 26 Oct 2026 09:35:53 -0700 (PDT)
Received: from
 runnervmtai0g.sgkjpevnbxlejplnkguq2c5fce.bx.internal.cloudapp.net
 ([172.214.97.233]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f078a762sm727645585a.30.2026.10.26.09.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 09:35:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2026 16:35:52 +0000
Message-ID: <20261026163552.4123-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026151638.578859-1-pvorel@suse.cz>
References: <20261026151638.578859-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix shmall clamped to UINT32_MAX in 32bit
 compat mode
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

Hi Petr,

On Mon Oct 26 16:16:38 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> shmctl03: Fix shmall clamped to UINT32_MAX in 32bit compat mode

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
