Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70171606A326
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EReIFPXX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0ED3E2B74
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 09:26:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2187E3E17E9
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 09:25:54 +0100 (CET)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B732F600236
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 09:25:53 +0100 (CET)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-36758ba1f01so1378967eec.1
 for <ltp@lists.linux.it>; Mon, 02 Nov 2026 00:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793607952; x=1794212752; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WbGjY4t/2Flof9wOVIpOxiCbZUl9Kt1qmoVKNoEccdA=;
 b=EReIFPXXviD8j1lvrulJ0Vxd8l4tpFlB51Ja2grnmXTFMREJ22Xam7tfR3uPO3dmoZ
 2P9RVsVZOeHJOhh8lSRiEvyHPmG1tys7NjvGZkwrtywgGHm6LBymfv/1VlFLKE83lQ08
 oaAQnIWqQ6DgfoV4JrEkXWSpL032duvLwnbsgbH5S3QTm2ctF1VGmYdR7hfg2yZR7xX1
 L9kJUiX5i9rdAOMVqJ4NSRyPgjyrC+Y8TB72R1yHKUyB2lp3HCz1dy6dgUsXpCHc9E/D
 pFt4+3F6omB6RvV7nypwAnfosauR8P3lEurCsV3QRK2ZJsxGt6A83RxgXRnV8RTzBkj0
 jg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793607952; x=1794212752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WbGjY4t/2Flof9wOVIpOxiCbZUl9Kt1qmoVKNoEccdA=;
 b=o20J2th390M2x7gBIlWtgPngpNZ+7ir3B23/ypMeg/vOZAoxXjnCx8dlrTbHDKCV8x
 Do36hq1u00xibPpcTlf3ogPhbj5FiCdn5U7iZRxhUmhE+e+GlWl7+6tzsX8LX/H0MEN+
 paW+WvQLnQCnh0k8Qgq/tj8rDxs3MHWsX6EC5wpmIgwHlOwisHAUoA/+V3ajQxlPvwhy
 mgkh3K8juLQXi4x2/wBkfeKU7ayeERUX4y3FJ5hK2lDiyvFCFA53gTeCXS+hJ/n7c6tX
 XyOxQsq0dqLL5S/VYqVD0K0MSFEc2dUIYsI2Of3usrHxXStMR3UZEn4dacvk0s27S3tS
 iDQA==
X-Gm-Message-State: AFq9FYLLq44IWzIncB+DeLLjKxTTdraPulZ1laJHsxinh/Uk0hk/1ZSt
 H4oib32ibk4ES0pqxoImDVxQhN7e9/zpUV0RJds1yajHEr//P8Fk1h08
X-Gm-Gg: AYBFou2h6wyTbtUaioPV+SpIZvoN4OErq4YhdPaF3DdDzM3WPEvzLg4MqOU7gAbGsx3
 h8PMmGxNnIP1wgWygClUJyQmXcD6WVyVdrHD9soQGlxtUOZvrHQThp7wWHpyWJ3MINFWZE2sQNm
 sbc3PoBmSd6vixkM3ad7idw90zrUpR4juBTHO+2Z2+Q8kG3Fyl9QmkRlnNS0CVRHMHd3flF4nR6
 bDUGmzdaxyfUO6QxcvFgrEqKJMBM+GWBJA0Ziu7y7A2WtiA0OKDug1XWSz26tL/JweBhEDYpnWb
 A5lPV0vFHoqB21rB+M5sJHEO5S9B4+C+vHPcMeBvlo5me5d+ws5R7T8EIcRDODxibdiH00FEG4d
 eEWU0yTdt1EHbMgHRxsoAOuw++oPPid8opk9ljCiwRWaSQucp8/Fmq5H+jmoufiOGX4gR8McZ4j
 LIBcoXN8ukvMrq0yP00kIQyRe7xtzzXuSN7bIZVo3IgDbjgk0TdQ6ODxwtaBwQUPYoX2Ti7VXtk
 AYHak/np6VudXQOtMKLtqbJZYeHwSsn8eRkv5UMbd86k318bhg8gS7ARf8V+Iqr+t4b5Pt52nGo
 hRlOF8fqd+TJ08C569rTJsqNLq0+tCUMVg66yz3AqQB2sNbERsSD0Nueb+xLHu37oSHT7pGoW/u
 AP8rzAS1Sp6N60tuKnuRhKMO/mshfFmvIjLr2ZWByyGi/1XnIBYgQ3FQPoK2i87I=
X-Received: by 2002:a05:7301:1a15:b0:369:a113:756f with SMTP id
 5a478bee46e88-36a423f980emr13706073eec.34.1793607951750; 
 Mon, 02 Nov 2026 00:25:51 -0800 (PST)
Received: from
 runnervmnwato.wrt1uumabuyufaoiyhie0rxx1a.yx.internal.cloudapp.net
 ([128.24.162.176]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4291e38fsm40674841eec.15.2026.11.02.00.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:25:51 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  2 Nov 2026 08:25:50 +0000
Message-ID: <20261102082550.3940-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102022245.3922-2-wegao@suse.com>
References: <20261102022245.3922-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_attach_loopdev()
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

On Mon Nov 2 02:22:39 2026 +0000, Wei Gao <wegao@suse.com> wrote:
> lib: Add tst_attach_loopdev()

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
