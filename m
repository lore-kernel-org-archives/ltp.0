Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DDDC5CFCF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 16:04:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2D823C6F71
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23C453C2150
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 18:04:06 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E1671A00646
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 18:04:05 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 46e09a7af769-7e9fdad388fso13700a34.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786637044; x=1787241844; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+PilSvWCnmVH0xI+le+9Jg8AZQWNxHhDNthtpQOGh4=;
 b=BPGcB8I8U340bFOIwTGDAHzNXKf/DdgiCTadREiJ4PQH8iUcT7HaQdkBDtG4wTgwo4
 qKc5SlU4V+5hGVvQ2BEDzUMSt6TgzLYQN69PfrN2GlLBp++rpo4jYtWVgtP+Mnu0jEYU
 WkgnbJulfHaTndj3Fse5UyW7MjpY8LSx1ig0hgwW1LYvtV7VCL1w/w7pZgpt/DW3PbvO
 qz+wji+hyyynLGEnj+Bc+NcAcRkbfy4yUBnbBgQQ+n65/nMtXlD+MyCCoSsO1DHNiYXf
 WCPAqidATmDvzqH0MgGNlqBtSZBYd0xTcK5C+kyrnUJ0modvqsNIz9BScKcYoRUU5m8u
 TR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637044; x=1787241844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+PilSvWCnmVH0xI+le+9Jg8AZQWNxHhDNthtpQOGh4=;
 b=G6hsc0Rqv8Xs3yZYXA1tvk7vzYU4clWh72XYXFlcP4OpQVU6t8kCLSEN8Oeh7QCiBC
 hcsrPR4pF6hjUNO4+RI4SIWpfkpeqUK2vwoBP6h3bqVoA+iZ4teQthvDVYp7i34AWrWf
 Wem+Pux3dWqLWUeHs/0chwiI8bff7RPORMjrWqM+ffIPo1CAtVEltjaTv4EyjebWlBQt
 6wbUzgPlD6EQb3d1hJWU+I6pW47Stdo+W8864RQDyJoUgEJKrGsV5W4CkiTUShE/0YRO
 GuJivGeLMaNn2v344oPbKy3wnb/Ldfk11cYnh1R2HstuzUIXxosqN1tkhkiql9Ic95rr
 PAiw==
X-Gm-Message-State: AOJu0YzsXdRzUmTzrtUiFdjB8EB+VwTr14zX3Jljda8IZhxPeZZQuCMe
 ZZuTMaj0IAFLNnXuiEpoRArBpTEJKsCyMhXn5jbudeGa6sfyPHC1hgHY
X-Gm-Gg: AR+sD10fcctgYuFZEPtXk50QsJQ6GWYHyGjsqJQSVfgK6hhyvQxkn88+OM0KaWzQzoR
 zCyLFXndSEfP1w0E1cDti0tUEGUcSlmqzxYTx7tZngAlfxwC8GZunPke7jhmEybPTJEsytT+zF3
 Eb8NL3R0Tk0mIot6aV+ZXB6rbGGpHrW3UKYnBbdv84hZ9RvltmOLGhtvd845z3YM5cMH+F4kUpG
 gYHrLVm3cCG015hOeDb0Pd9EHi47kFBL11pzCiTR0lDfVxBVGVeaESskcokcfA8xeJr7TLqFs+L
 0sD48IK3uC23V2tk1ca/9Shvy559U2DLUGL7cNHdpNKOkLyjnYtpjOf+wAHdjHS7NmBH9F15M4N
 4q6gOI+JLSyoiYk7cyJ3p5HIHJpo0spYlu7TNbLJ4b7X/RG0lEQwVdMauT8KdXyoGq1h+foOzse
 SbMeXlZri9eNedQaVPLHazUrgjU1MPcVfUb9W3mYxPeZdd8mvnft/PXLW7w5/+Xf4xgnKz8m8tm
 GXszBz3pegSPghNkKmGgVp35BdQwhDxtx6lapUyHyU6RIXLUXA8ie4UIQBo9HeaDxVgoQ9kSPYn
 9A==
X-Received: by 2002:a05:6830:67d9:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7f3ca310348mr6189885a34.0.1786637044024; 
 Thu, 13 Aug 2026 09:04:04 -0700 (PDT)
Received: from
 runnervmvrwv9.oibkqik1sgtutjdscjavv13dxh.gx.internal.cloudapp.net
 ([52.242.242.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3c974c65esm2457150a34.0.2026.08.13.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:04:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Frank Ranner <frank.ranner@intel.com>
Date: Thu, 13 Aug 2026 16:04:02 +0000
Message-ID: <20260813160402.9147-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813152433.73259-1-frank.ranner@intel.com>
References: <20260813152433.73259-1-frank.ranner@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/kernel/crypto/crypto_user02.c: fix hmac
 candidate probing
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

Hi Frank,

On August 13, 2026, Frank Ranner wrote:
> testcases/kernel/crypto/crypto_user02.c: fix hmac candidate probing

> +		rc = tst_crypto_add_alg(ctx, &alg);
> +		if (rc != 0 && rc != -EEXIST)
> +			continue;
> +
> +		memset(&report, 0, sizeof(report));
> +		strcpy(report.cru_name, ALGORITHM_CANDIDATES[i]);
> +		if (tst_crypto_get_alg(ctx, &report) != 0)
>  			continue;
>  
>  		/* it also has to be deletable */
> +		rc = tst_crypto_del_alg(ctx, &report, 1000);

Could -EEXIST candidates be skipped here? If this result refers to an
already-registered, unused template instance, GETALG selects it and DELALG
removes global crypto state that the test did not create. Such instances
remain registered after their users release them and are deletable once the
reference count permits it, so cleanup does not restore the original state.

This can also leave another implementation with the same cru_name. The race
loop then gets -EEXIST from every NEWALG request, creates no larval, accepts
-ENOENT from the fixed-driver DELALG request, and falsely passes. Could setup
require successful creation rather than accepting an existing registration?

> Commit a4be708b4 ("try non-generic hmac names first") added a list of

Could this use c05a44cf instead? a4be708b4 does not resolve in the local LTP
history, while the Fixes tag identifies the same subject as c05a44cf.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
