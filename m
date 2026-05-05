Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3D6FF8855
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 17:54:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0C223E6AD3
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 19:54:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E27E3E49FC
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:54:24 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AE9081A004E2
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:54:23 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8acb3daf2aaso86147916d6.0
 for <ltp@lists.linux.it>; Tue, 05 May 2026 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778003662; x=1778608462; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axxxSggrVNoJjTKqZBzkw0s4iOtgnuXYMHJEltA4y5k=;
 b=owTyO+gAEAtru8sieNScM5q4awcFB4LIpWde06ZT7WVPmnXO0UsOW7Ohg7o1OA60dD
 KqDZFukL3xWXtL88uGC0qWBsTsM4Pw0ZwtELfAVzxFrrECHN0kKM5vTmauSY1aeoNp72
 oto6DzKfo8XpDiKJAhtUtKZezHO+hJDJtbcD5hzHUpeGJA30N9nXXaMdbZYP2AYnukJ3
 a/iU3ae6+IjaCgfTxuhmx59ylEsW++KsU1xkp9/MmcpOWq7hLPZDQmqxaVU0dmwfgzpn
 35blnJu05/7YEYMPylNPn9/W0xTiLRr0zT4SMSn54RH3ZJEX7P0Y8WAFm7yBXotYdDDa
 0pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003662; x=1778608462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axxxSggrVNoJjTKqZBzkw0s4iOtgnuXYMHJEltA4y5k=;
 b=JSkXEsW36HjPW6D1NrqGVrUTePEpIaxrblqOUa6oE7TDviI0M6OV1UcPCAGlrUrQcS
 VjZq5qRf4eVt9gXSZcOnE5mNpnumxfUCmrOxhoJ71Zde8MTO5iVeYzoT+xm/mGMrkdME
 0xcjAYsAVKqJdmVowYoozuLesec2cVLn/hwDbCTLcjA5WvTrCekurYYqCmctm4kszzU6
 G9jIIPGXoWoYx0CVH7gq9zckqfyQVxvIj/sPWumQiDEF8sQOisuxuyRGvjmbh4/B5Ppq
 ka6xp7dJDxzb17cwGLp1rJIrEti3tpJLjZ5QMew8WNtTBfsbNTcHiqS0gv/YoSU/Riki
 0AFQ==
X-Gm-Message-State: AOJu0Yy1z5fwDc79AztOz91rwpW2Q4aS92garUohfBWucbO5upCIG396
 BU0Ttnb4DkYrzhtO/mR8SiUVuiipmlLLqcI4oUA1S7LnruqMtdCptfySuTRJIgh17gU=
X-Gm-Gg: AeBDievCXWG9dYDKPRMvU9lEJmaFCgjgibS8phZm+t6SMkZ09wmglk25WM/RYzMVxla
 gQKyXaRbtHRU22QY1cZqtE4BDw+TE4shAUaGMHDS+wJ93LlqbE4yE3VPstCv9NO77FEDKkWVQGE
 b84CkOXpaaGPjKX1d0Ch9K+HtnVPjosBn4IBklKOB7DsVONtkaGuHlbf7beSyChbgJjx1dBeiQU
 3SCg06Fo22zbOFNHXknsuaN0hp18pGX7WGuVNscIHeQO07BG5iKsWtfy2m0Qe1tS1n5KHYNPEQb
 Z9DyCI7cr3FzHrtk+Dn0qb5P+sa+JYjkfk1B6HT85baKA7NUuKJLupF6IVEnJNB4tHLZBbap4RR
 FdAfMF26DWDsW5+x1J/cc8MJFYLhSZ6CoZRanLqx1ZdIHMgKXQvdrsQbDNxsbB4TEZIfFp+S5VP
 /JeMuCk7oKS0tdHBK2FhZwa2gIxlH7RjyqT8xfwVZLry8m6BbLNT0oLFTVdqyTwjk9hyDarV2OG
 U2KH/EBPP1VMjX5lUYfOb8RvVeDvr7g+CZMhxYTMFw3d6xV
X-Received: by 2002:a05:6214:4c46:b0:899:efbf:9292 with SMTP id
 6a1803df08f44-8badd87153cmr53196686d6.43.1778003662454; 
 Tue, 05 May 2026 10:54:22 -0700 (PDT)
Received: from
 runnervmeorf1.waqj2igf0bnehavxy3b4j2vbqa.ex.internal.cloudapp.net
 ([64.236.135.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538b1d833sm176491686d6.10.2026.05.05.10.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:54:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue,  5 May 2026 17:54:21 +0000
Message-ID: <20260505175421.4007-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505095451.26212-2-piotr.kubaj@intel.com>
References: <20260505095451.26212-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On Tue, 5 May 2026, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
