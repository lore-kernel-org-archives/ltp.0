Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0E2D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765292093; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0PUkcZmiATp82mj863foJLlX7SOQYnDAtRWyOqyOJSc=;
 b=lKhWJirWpcPnAiyn3yvqzV1U4F716bGghZFNmMeJD/TU9dppW0Tbr9G1kKIGw2NdGZO0+
 sMIBV81OP9g1bqjtjiMbeZv8pKsais/glN1Elr4xaQbpCk2fsfLigxXBtiTrYT3zMO0vGhc
 fR1Gtnu36vYYNKOz5QwMri/BgG9LzbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFB273D02FD
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 15:54:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B6A73D0293
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 15:54:29 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D7622009CE
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 15:54:29 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso811077066b.2
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 06:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765292069; x=1765896869; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=AwcX5aAOD2nKhFH2otu7r3LyF9EioWh4Bh/yLwfGPoWWBfPSZlJfC0mKRVmIf0N90s
 XCmsxNekT+TWw8x6OLgiqtvNDdKs6vbiEGSN+IBPjiXq2es0XiT9qqcs8hdrHyRe0TQk
 xQcrivTtWqc9CRlvI8OdcUNa4u7jZsiBBFD0DAq1ZL15V0l0aDwWklIrgoROWE9DoLVp
 0EQX64eklmyYQdo2uHR4zG01mex9RmpjvucDymScpOYIY3QuwwWkjV80O88zCxJ+pO8X
 GbbknqH00YLoNfRfCTdWXB6ewCH+nZvK+AasLccSUaZjE8DP8WgHeaDUB4wfvBgPTy4G
 GU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292069; x=1765896869;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=ZYmS9K7l/RiXtxJClXVhcvEXwCtX/BQpgtDclqizxljfGdHGBNll6yRCG7MYl1SoAn
 13qJ+PPmvu3gusG7QCtHFHPuUpWaF+qs5Ega4a+oEt0oNa18mMo3XZJ4oVT8kHshjF96
 fKpYcUaDmGmLG4clUtsf3py3uxVEokWRwTb5FXO5lObRDdeuJ7ixIfYmhiSGxsH2OKfn
 KwiSEIhRyp1zossH7D867ycPVNV//C67Q/iovOgnbvFygufMt282QgNFpjzMbgMqgqXq
 JHJ+Ycz5tRNftPG4HVHAvSKhhl9L5i9NBMkmDbDoQIxsBOK7QPN9YQ89dpCjG72c/y/9
 YZJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTQ3248MIFGOP5BhfEWOsisL+Stfg42a1aEeqOQhI8jYXr2vjc5BgDrfm6Uri6vanxNSw=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/6bY5PmKCz3FVi8BGtsQ2gQMA8rP6wdP80yX/XnY6jFHpWBwf
 j9Hay6voPfEH8tIOJNgOf0iCOemf7FIG5Xa3H6dBgw53vIHRInvV4NDm3ska0o8SDZE=
X-Gm-Gg: ASbGncscLti8eFd4NYoHcogypPWDhwADWk32V2zbBYoadAZRD0oRQtagmjXdw0w0lK4
 aupqJT1TiTvi/MoOmW+D1w0/EwcOYZVd/WDfolnNyKZTjORGXuKJiovdc1F0M7Oc80NmSDf/GMd
 uUT7kncX7UwKl5X1DVA5iFdl7bMjV2teblouXC7RXNFX1N09jT8xIL3qfpvh3RJbR7UO5qOjTwK
 Duzzs+xVBSMdJTFmzUs1bPZuOvJg8fCpALOm2gcBC7GprMQZT6Gsk16VuLgOqMiS4qwy4OgN41O
 XYUT95BVbcTZhgbKqoLkaxzYPIAaneSJU6HWyqKp7A9NMgOKarpoPXOBUEEKuOC/t7ZZNnfSACv
 aSb37Tv5ncpXWUbtgd9AmBrmi0dPh3KqYC2R1l1S7ywpoj0zdWW20y2X9NF214YYedY1rRIP7hb
 LwZzMhiQabj+ZTiHSqN1tAVao+yNmz3cB/+032E7z9pOix8URblJKPRCndh3TIZi/sDjLY3iR6O
 3NO
X-Google-Smtp-Source: AGHT+IHzfZDOjcQ5XPuCesFO1Vdk/wDeRTQLQtdtdYW7DqWZHrvcvFuDQBy1DI3VcXuEkDiUuHYXVg==
X-Received: by 2002:a17:906:478a:b0:b73:6d57:3e06 with SMTP id
 a640c23a62f3a-b7a2428bd90mr1020840866b.7.1765292068875; 
 Tue, 09 Dec 2025 06:54:28 -0800 (PST)
Received: from localhost
 (p200300ff0f1137011c5cd6158c06ca63.dip0.t-ipconnect.de.
 [2003:ff:f11:3701:1c5c:d615:8c06:ca63])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7c2a3911e9sm26303766b.15.2025.12.09.06.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 06:54:28 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 09 Dec 2025 15:54:28 +0100
Message-Id: <DETRT8KZYFAY.R1J9PGI32W74@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251209135427.41648-1-mdoucha@suse.cz>
In-Reply-To: <20251209135427.41648-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_xattr: Remove unused variable
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
