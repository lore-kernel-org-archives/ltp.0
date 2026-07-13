Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C499C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783941847; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=iSrMjfbVzFt1wGp67XX99kCZcDHjgMcAi1dmROxTDyY=;
 b=hPk4T9QiABCdDIivM5BVVobmB7DvnZGE2lwpJcbKsq/c2W6bK1EtVrjXf++tpCbredSs5
 GY2bHySX8M1oE4O0poepf/DJJoT7EZP9vmNCFOgwzzDYmVekRQKocwuJ2DA73Alk65wpLJd
 766xUMitkGXYFECl7ugGNOLTRIbFu/k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBB8D3E7B83
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:24:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC5483E265C
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:23:48 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA8BC1A00437
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:23:47 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so22824895e9.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783941827; x=1784546627; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+302PUved2Q8aimxqeaem4jjoJSwH3AL0qw5LsZlEVI=;
 b=A5XzCclc0ZFVNC5Khbs5picSERQ/XqzpGbIE/os2N1EqSGzhZG6Zdf4rsE3Aj1BR+8
 IZLubUBkEHT7MXJEcRVoI1mjMVGirfvp92pI7gofEpWuri4zt/ukBvKaALuGOOy6paAM
 EHZ0KG8HToBxmTrBu+SsPrDY+zABtqYSfDX4ZVc2E2+Hnsw8zwg3BZqsFIzAbBt8JC1q
 xNufk0g+AQLA5CqRgjgREGMLYQJqvIvgeYd6tzSmQ8px/O2FFooXGbWEnurj7V0UOWtW
 QvNa+92rROZj0vyDeUzp448Pj0UVC+3ojhNubwCcsXmOXEQIcHO8F564n2SrFcGgjHTt
 YLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941827; x=1784546627;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+302PUved2Q8aimxqeaem4jjoJSwH3AL0qw5LsZlEVI=;
 b=KAjj7kVOgRnPnNOPMXZXUHgqXkdx4A1TgZAuK4tamuiJ2MlQqNAHfLo2iTvziyP+EC
 GJFjx8Dkaf+XfPGuKFSel2fzLUqpAmmMv8dbTrOljyoLls5D+fDgXhQfShLi/KbW5bl2
 udNAoboChzZd2Ab+POiAr8d0h+kohzeIiEFsa24iWj5IlUbh66VrebJvpAsiYwg/vRO3
 yZo333bYuT8i1pKEXsA6BIj6xSBSGarkggzPTLIcvfL6U/orca6FZuHxwxaRLfxO3Bp8
 YNh9gp82Drcnd2ZDtrr1QEeeKZhr5sG2YfD5MTMx0/44zyMjxwU5g0x7H8HZ8+MO84+2
 N1gA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq736N2Ms3onvoEUxbukVc4HWgn8s9jGsSC4e+dX9vuAEH1RZ2A4WlwdQnsy7P6XKjr/tM=@lists.linux.it
X-Gm-Message-State: AOJu0YykWsH+SzJ2+vKemADuuqBx1ziPx6KGSaJJ02kPO8cFiNjrTJ8A
 i3y0oGWtbjL7zTHTeRbVQ8ra3LSfVMTek41bDBKJXnpw53nEbSqKfTtm6URCz9P/spA=
X-Gm-Gg: AfdE7cluQfNEHHKFTPnfHbJ89LnyEqWB0FLrQTXQH37UyHGM7D9marGN4jb/Vlb8Ssy
 YWt+I2KdcbVfZbmoQ9Bp/zdlNYc38orCeQtVCdLRF7FK15FUjNf4uw0paWERjSs9SzhPKlgb7lQ
 +ktZIhYOBYnG41xRw9+jBEs6vlZfEVtWrCWrsjuqd26Br2zPuX2g9fesr8dOyEGHlZgaVaU6fup
 D/OMu2DMcn+bjk+rDPXjtYt9TkkgJ4hvopacLKJ6TnC0xk8lZ62ic7GX9cQ6hp+hsefbtuNoIaq
 CfDxVlYtOeqSrEgpTdyJlRL3EQdAEtRNom1N9rHzsR1BO7zl56b38ArFulucwTeapjI/8eSWOg6
 0V2aq9MsYifFlqgyGryQzyyVqzDB/Sjz994Gm8AD/KR2CN5vqDGXyhficl76RdObRqZBx7lPi0i
 UCNw6kgzM+7+n60gUhCYT/6cyTQviIzgdS
X-Received: by 2002:a05:600c:1c27:b0:492:3fb5:3a17 with SMTP id
 5b1f17b1804b1-493f887ab70mr93294035e9.2.1783941827259; 
 Mon, 13 Jul 2026 04:23:47 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm592809405e9.14.2026.07.13.04.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:23:46 -0700 (PDT)
Message-ID: <6a54cac2.16c38fd9.114f75.80e2@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260713024404.3955-1-linuxtestproject.agent@gmail.com>
Date: Mon, 13 Jul 2026 11:23:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Reset cgroup limits before retrying test
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

the agent review is correct, please update the patch to v4.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
