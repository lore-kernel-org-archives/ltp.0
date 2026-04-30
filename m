Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB089FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777559508; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hgn5T6oNOEMBfvEI21vhSCxnfSaFSu/2du659TzN8LQ=;
 b=DhbXw0WDhYRkf47Q1vrz/7WEXJhGGrG2WSeeop5+yZPiHv0YD0xCRMCuzRpPBkFST4jk1
 8SBJwM0MQeL6EBdkkbrp2AAuBhH2oJt1K9NYLU3Ew4JZhrqK92rr9BvQT1xzNJweSzrbMyg
 KQ9IoAbxSD2ZnY9XPJ0k/UD9hN6N+aY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC5D3E6C8A
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 16:31:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4823E2ACC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 16:31:26 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9EBD5200DC7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 16:31:25 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so259315f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777559485; x=1778164285; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/wcnHzNPljPE0uqL4epYXr8bo9j0N0X+lh/11F7zz6k=;
 b=PkH5ZlIU0bqWYmir9rQK+iQNZvcbAwnWb8el6WRyS4YliBNIRcgu6vtNWX+lWrZYOP
 wcljgt9p/ljrsnOkkcSW7B5QfCRhUxlkSLGCnaWpOjMs09KqogXH9gnmcEcuXxEngRrX
 88I61Vnh+5dEd3y8eQgRHp+FS9IQrwRF/q3t0U6PCaML/tQHq4ApRpRtAjxhfZfqIOVa
 lM3oii12t05pEPH/KoXZuqs1n3RuI+8gjYSIhi2PjcXkSWP0jFJD47w7VbsZj8rmU0Rv
 9eg1t8pndWVvcLnTUfB8yQXROKaLF8L/aDm3vO9rCBfoheU2aemw2h87uPqItx9BlAYj
 tPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559485; x=1778164285;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wcnHzNPljPE0uqL4epYXr8bo9j0N0X+lh/11F7zz6k=;
 b=LU6bqf7XQ8huu8PqBUklQ84wsEHxY/r6ePsaklEok8h9xL88BqNIT4Tc7OQsannWml
 8k41y4+v+lIFYj7Yr+MIWQcDmEQedqCAjRMM1uGmioaGnE8SgtGKutaKjlu5rYcUuV6E
 JPWF/zv5xzbh0zM2jLWlBxAzegBHEslXZT2pTl2WOJNYzMA8Lp3AjOVPljKWnOIpVsXa
 7NHpfGbd3K2yi6Rs+j5ZULX1iTapHS6XH+YrTqLEC1a9EnLcznv5+s8jlDTjc0JnJstb
 k5gqJ+gZc6Q4LZIFdS37kmSJXjRdsIljP03551OvDSjJHU1qu5tHhw6bSt+MRV8/dhaX
 3jbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PD5JQRb7AE8lN74aRQhWkwWVPz9VIFAcFrR3NMGMeLFi13T2rqVbvHe9b5HHB6sCR5f4=@lists.linux.it
X-Gm-Message-State: AOJu0Yzjn2Ca4Ens/FdjIHerx3oUL2dC0TVakYfv0fGoFn1VLEOT0QNd
 m3uU3k6Cqo4wCgPXgipM+QpPU7UZj/iMqAGFkr7N2NHKH906n63SUKamrBkJ/6uSWlQ=
X-Gm-Gg: AeBDieslDP1noIfpEYPHxuPyymVRqcN1dNhOsDtJLCikO1220bMzHvu23W9CKEuQZ5a
 cGlY4h5f1lhgu1MFMbJcMsHFp9uwam9obVnx6r9J3nb8DPEaFr6jWp202SfdtPJPcsvaJJlQAkb
 nQ7Nhw3ZGbRdOEe6xZsnCpajgOIrb2lOn31A53aEu2fo1pcR2fET/0K+v0djz9B5zz44uwPgPwM
 +HC0YNNgi66XJRE+m3bRO0rkQ/hqx9J8XMNuwQK5Z/AVX3/yyv8c0UlEuetjXkSIBqNW9Ri5vDZ
 Fz5HVtZpwFdY7dUOisnHH/AMPj12TOjLG+dW6XtxnNMhMoVbF4ybdnME5uExvrKS3LYiJvjIyPD
 kA2gwa/Z3occXeMfFw2T+v175JvA8d1pIZ5MnHENVb+ULn+RO6e/j3TT0kIB8mpzvN+FQr8spfF
 Un2Ztdg3DiDUBgxnHEcTpHb+fqIaZQk5dtOOpx/jzgUOpd48U8cN7epIEeLuMgBKwsWZNBr+teT
 psCZrQCaghuwMVk1tBTQv4Y/6jiOooeaKlGQJo31bNDGmSwwVcN/QTBeXXGDLxyObQSHYzNzqHF
 OoP2SmJA5idVN7dvBu5DdJs=
X-Received: by 2002:a5d:588b:0:b0:43f:e414:b1b5 with SMTP id
 ffacd0b85a97d-4493a837d7dmr5570005f8f.0.1777559484825; 
 Thu, 30 Apr 2026 07:31:24 -0700 (PDT)
Received: from p200300ef2f4fc9007395fc0cb1d2b23f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d47ff1sm14344455f8f.6.2026.04.30.07.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:31:24 -0700 (PDT)
Message-ID: <69f367bc.df0a0220.323089.3259@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <605015be-e527-4cd1-b541-7721a3ba4327@suse.cz>
Date: Thu, 30 Apr 2026 14:31:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve-2026-31431: Add page cache corruption
 reproducer
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Nit: Please use file_fd here.

Uops...im gonna fix it on push. thanks for the review.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
