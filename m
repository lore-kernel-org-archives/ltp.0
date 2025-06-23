Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E3FC7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750700850; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hSkCavIaXEi40tlnlb9JqRCKLWk5Plj52RolNdChObM=;
 b=dFzUKIbfcwLrIqH2Vu2EauJRIopaZhINF6Tnwv7Aqqm5XlwYmQI4HGg2DQ9DEZqeGuVHI
 fwGB/JBGE38XPJ8+fFaHoM8IlRpjwoQ9EoJYsHyEb5bmqI66upuTkLhyI8AeV+CvA9FKzwf
 +Kmccaqq2X2Ujm+fSrZ7GdgdNt/G9A4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B81FF3CCAA0
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 19:47:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87BE83C9982
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:47:10 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2408714002C2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:47:10 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2895000f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750700829; x=1751305629; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7+I9/L4kviXnZRcPNKtIN0Pk1TrJEH1rKZmjuYuM3A=;
 b=Sb1OXtY5YkWZrCJoR7LcnQaAW1oriCSuN9ScFGsPH923qmuv83T444JkQBnfL1JyZz
 PLHzV5BnwYzYCh7+GG1UJR4ltzbPu2aFijYk+lPFdnEkq9G9IWcpa1359Z6iCtGMMe8n
 Rsk16M8N8+R5sF5ODpY+ZybpFW+xCyYf2D2OyYMJNpRVbABAlgeLeutNdkFxwIVBZLYF
 Z5AxLRHmGBfwFcTwDqIkGzkNbsP0xZ2z2HsNFRouvnOd3HD1Ykrzfb1Kf/bvgMXe8cMJ
 QfSxkCLh23WN2YQniy6W2/Dnf9vRqY97x9tMxgmUsxuYASvUlKHj/IOB5C7Qfl7u/Six
 qf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700829; x=1751305629;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7+I9/L4kviXnZRcPNKtIN0Pk1TrJEH1rKZmjuYuM3A=;
 b=WFkkMxb/EHUYvgSWE8OIDrX9PiOQC6goysW6wg1y2RS7qjPzxU9qxYv9d+z24uWGkE
 H/IY7nfzEreXKHtG7kcSRA7Gnj5Ea9yV7vOHmyff1yVtT7dzIck/4fZxd8J0mANSs4Ct
 U3nKct2NG3vwFt/+theq7TrfS2XmDN+ZG/ar+OyAXoJgblkaeWpkIz3M/UUxydJljm9K
 6AsISLurs8mdETnM2IfwAcqqdLeaAgp33HdRs20suy9IymkysjpofcOhs9VVO7/NEsM3
 GIBif6vqaUyt2Xsh866Ykq6itVRYdKwPWnU+SAMxNefxiXaMtM/KcrmM0kHp8kwC38l6
 tX7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgoXRiw2IKFKlFM40YbdO49sLzGPaP7FqUgTtmggHI9LdIpip57ROpKPVrevi2iIXhf+A=@lists.linux.it
X-Gm-Message-State: AOJu0YwPH6b1YSxwgz0nFxK7/v6peWuNzzEtVGIlRK0vDQdLjZeaXVD0
 ihzip1Z3Ce2crIXy1iGXf/wzWbI1hsA+uARXFuh1zN0R84EVxmAPZhpIwco5NUx0Rs0=
X-Gm-Gg: ASbGncutS6XizKDNliqKv+RBuH44oeTHQWTBG00aGA3lE0NdE2SbdUX/q0BHyIZkYbc
 5lJLJ/NToPomG4WMEYIuYJ+KR3GOfOHhEJ7/uXqeDhWZhM5ScbX4RWBsXE1rSwAeRLGawGhATpH
 Uihmih0wu3i5Wf6KRcbGQus0oQAW49cDsLJ/yzpW+wOya3QlGO8IFajiAKIfLHg+tptXe7sOaJc
 lc1Voh5IrRLaLkzPbDzhCULP+Kgcvzf9ZoJZCz//DFPNGU6oimazEMLbzeC2cUVlaFbxEh5TCU9
 2aCaF8WQXS99wf2ifTuqKiiyL2RvPiN1ZYm/EHaD6bR65Jb4Lg==
X-Google-Smtp-Source: AGHT+IEKCsp8HiPsDh49GwEIprs/cL53tBcg9DmRRNffgV9W8ygnVaabcj9ckb11SIo3TJJAlzjPyg==
X-Received: by 2002:a05:6000:2209:b0:3a5:270e:7d3 with SMTP id
 ffacd0b85a97d-3a6e71ff79amr362891f8f.13.1750700829568; 
 Mon, 23 Jun 2025 10:47:09 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-237d839332bsm89134515ad.40.2025.06.23.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:47:09 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 23 Jun 2025 14:47:06 -0300
Message-Id: <DAU3NCJMM91X.MVSUZMBCKTI5@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250623-conversions-shmt03-v1-1-a5173cf34a34@suse.com>
 <dd349553-7bb4-4399-808e-5389487fdd63@suse.com>
In-Reply-To: <dd349553-7bb4-4399-808e-5389487fdd63@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem: Convert shmt03 to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon Jun 23, 2025 at 2:43 PM -03, Andrea Cervesato wrote:
> Hi Ricardo,
>
> it's probably better to create a unique patch-series with all the 
> rewrite together, so tests are easier to review and we can avoid rebase 
> issues.

I wanted to try this approach after mknod() rewrite. Seemed simpler to
do it serially but I don't mind to make a series if you prefer.

>
> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
