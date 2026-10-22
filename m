Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FC606A327
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pj33CYi6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826A23D25FF
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:32:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07B93C2CC0
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:32:35 +0200 (CEST)
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1DD101000DC3
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:32:35 +0200 (CEST)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539d2baa897so837753b6e.0
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675954; x=1793280754; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zZgEbNSh324Pe2GRM4tzAg61KJeM3/byJ+5PQJBFAc=;
 b=Pj33CYi6TiuhpGQABwNJFj7YhRcHIM6cCmrA6uO6kuLBY6nApXd7Wb4VaziN62ONAz
 BJ3CYajbRSpGy9VwQLUzflXuI8ePvBhhsBbxb981cFpiyHUMFcrAuMf2FqWNPPWsEfR7
 E5/5RhgEzthbdl7OEloPpSOH/kM0QLLM8FEdduV/we75Q6KzZm7MpPTXj7+VprPdMKXK
 PKsqYP4HmbmFOmQd/4t79Hk5kcvlpz9maPL71GlPmuXBa/LxlBrXuNfjXyMUWME3WvJl
 6HMxDcHmXIKqsHGTg3xUP4kz3YETB0T9M3Z+8PatSicvf6sS4uXSdIM9hxSURq6dAvcJ
 PqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675954; x=1793280754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zZgEbNSh324Pe2GRM4tzAg61KJeM3/byJ+5PQJBFAc=;
 b=HlNLTNqCH2iqGli6bSvUwrUF8Nhxw+qe17NrlHz1SRwuoiJbzREs0zK+KsiWeRq64c
 krifhYSti+R9PmNdsRCriTLnukvuWPsnIOB7HDWFXTvta8oR3Sp7L5TW0JBga/gSWLut
 /tiNX0zqUpUsQOjUlTNsW54syTirKw9TgCXWzfuoqlamR4xYJ2ef76tPR1fWOz0lyLRF
 QD2PqQO4FlgSiosKPEySdIenXHeaXipZoM/aVp6wpyl9jUB6JS9OTjYyfmNklpn+NoRs
 rZ5j+BvqsAWmGZgQpA4VFiNLcR9f5LOXUdgbfB2eNLeumI2jwjokE5Q6YVpOy9vgAnQS
 JRKA==
X-Gm-Message-State: AFq9FYJz3QpmEJXGmR6f4S00kbollUmp0y+paa80K6szRpgz+3iDd6oh
 MHEaRf2ZI8R7v0r2lfdjp0GibEZbxjExqKwdeGiizecBc/5YUYVsy1Lp
X-Gm-Gg: AYBFou1g9wlQjMqXCMdDlBb6+nqqCkcgAHETJajRxCAXlhC5rjLD6hv2rGk7r4d6ZIT
 EhqkdTOCBtY9DHqOOi+g8fAd04bCU215ld2C4m7a9sJa7cTo+6mdZeVlqSyNjbmjtaB0dzJCF5A
 C4311v+1lo2xOJGlN6T5jwprUJYkKxpfGKr67RPZRV+Rx5Sz/EMcDP0OCYXJDu2Bz+Ry42y2WUo
 XlfSbHR4ZptCExSijz9XjRzH63ZCLG2iCnE+z7PNM1o4hxmES/E1a8RkL6vdlINtZppIVCdYW5l
 izvPgmuCGR8OPhb6lXAIrPqgCUClIPpfjB4+OvWWqQZmps9niiMHvajlH8EzBmn0GOdx2X7eBph
 49s37nOitaY5GWFLkk11Gy3SJk7Ryk0kKyoIqx74DUO/UhJyVILTAjIsUCj4FENiUR8R314QTwY
 ZLUqNjVTlcricMVkDCtjbC8Le+VuHRK6tFds0Ae0oB9uweUspeXsEL/ez0XdNDu2Y2ILbGtwB+M
 Qlf0wsz8mptR1iZfh0YOndyZIWMr5ujQy+vUlnot2iR22Ww8UbPn4dFd5LUvT2bL3lR44lQCN9k
 NxiRHx+ImDSwiI2hR1Yb1GigQaw0t3YJ0IavzngWsSNtzZ5l1N6uGR0IorFaYQsHCS3zdg==
X-Received: by 2002:a05:6808:c3cb:b0:522:1ac7:a573 with SMTP id
 5614622812f47-553596f9a45mr3701386b6e.43.1792675953633; 
 Thu, 22 Oct 2026 06:32:33 -0700 (PDT)
Received: from
 runnervm8k3b6.nkh3l3iddl5u3jzyxkyk0o0cjc.ex.internal.cloudapp.net
 ([64.236.134.229]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b5b2b254sm4556126b6e.10.2026.10.22.06.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:32:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Thu, 22 Oct 2026 13:32:32 +0000
Message-ID: <20261022133232.8320-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022115410.23845-1-sebastian.chlad@suse.com>
References: <20261022115410.23845-1-sebastian.chlad@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_device: Scale loop device detach timeout
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

On Thu, 22 Oct 2026, Sebastian Chlad wrote:
> lib: tst_device: Scale loop device detach timeout

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
