Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9041FCD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781607561; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=O7g+QBgyj/pSHO8dOavLe8Fhf8SBW2qG2VQ9tEmHS/sDTWhBVXjtpDF47sDBlG4I5mrtR
 Hy8WUo98cZL5aAQVP7CDkvMf3Tj7TidOW0N5uCSIDpT6G6nslI6SbxwuJB4wGM3l9JOD1ru
 sNUkTR8K0Lye71wn32PkV1rvLLdVAsE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FE93E5970
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:59:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069F43E2026
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:59:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AAA50600AAB
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:58:59 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso21528275e9.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781607539; x=1782212339; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=G5P1jEu+c+NKlGvMU+OoyFo2ON+TUtuMlVKZO5YAfHttqkGl961zFq1Rm8bRFC08lL
 GlC+5eVMKzldnOeOI94KdhxO5Ucpt809pOp+ErDFEjmTl+9CE13TE/wP2diX+AQiBYwJ
 Xox4rBLtOfKcBQNa3b31j34Rd/VpSM/5HhijLr5eNj0wOgBvtf409GXNM2YRqiNIfPdP
 L9xIW3W4xSNWq2oj0Qi/3T8V+MSCnWstG7GhbTamWpOUbWCrp5gEBwnfQBtze8iUtROG
 jq6CpPjWPdkFr+fF+w8SdcZJNHMrCJry4MVI6YUts/zo/XTYUjEVxm4jJNUxjPOtlbVX
 7nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781607539; x=1782212339;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=VSk6N7604eZShUaA28H2pnns1z/q8uyvHeWGIFDGl8zChsoaJHXs/y0XlyjORybXtO
 yUDqv78IRDNilt7Qxk+QgLUmvI0yxecNRaVWR4rfN5IWuBkLAjFWlTfOn6vhRfb352GI
 MXuE6lDualY3e+pDJ/Y5riyP1YrSQm9KDBPSyXJyFhf0DokhnGWihGHOcVNyAezjHAWH
 Zr5F58PrwanN8csgdI/0wOYROKSEfNKti9CXDBQivc/g4y7jRcIXGLG3PetAKC62sw/c
 9zRKlqkdZ6ChVTeBch6OjLQwMkr1z2op7ZpsacI0yspVCOgndnhlxtZyWia88inhCkAx
 P2uw==
X-Gm-Message-State: AOJu0Yy38RoXj99aRs6liUXtAIpeDsQU/qHPEozkz5xD17o84lRnsrsG
 FJnG5J9O80SSDOHMRIbZCuoqIPApmcRLu9+AM7cBodqTeWCXekOHcK2hjoBtRwlVGx5VYE6ULYe
 s0DgATYkFdg==
X-Gm-Gg: Acq92OGVsC5vt+/9sX4O6WrVNYHV4ExcygdV31liBV6oL8C7Fy0UjoqZWSOpThcig45
 5C/i7TFW3yJtiU906uzSNHUNhO2SySri5H2lR+im3KbXQpnd8FAq/sY7a4wXITbW/Vyc8riOIAT
 MLgV2zw/aEBDyebtvqyKN5VOZ5jX8d1fRHafPM1RRbN3xUyPcn0O4bfN/ZGSx86SdUNyDsW+IyT
 yB2LYSAQ/fFZ7sZ7ec5xcJQ04LiaknUVzW29ogD6D/rOcmlYyUSDGk+q6+XEHKPKCjBgMxSEXz5
 CLw3LHwaVz7XsQLZYNruiQ/LEa8sRghti5l0MzqYv3XkB2EjsjkGLLBPOo97Sk7NhdOTp3PmWXI
 JufwVykcn3SsmqJTFNpJR8QLqVcPw9cPQCnCa2OOkrybumBwVogc+A1pPABb88RFgJ7Jv+lptlm
 6T3XAyBhGXDU0pcDbi4wyYecdumblcOkD3wWfeezzRbImLL4bJv8klOTQi2K3JAnvCgg7iWhmjl
 V7m1h5IQWY=
X-Received: by 2002:a05:600c:5288:b0:490:c0d8:d517 with SMTP id
 5b1f17b1804b1-49220051691mr191497225e9.3.1781607539027; 
 Tue, 16 Jun 2026 03:58:59 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa9f2c0sm82534875e9.15.2026.06.16.03.58.57
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:58:58 -0700 (PDT)
Message-ID: <6a312c72.6161eb1e.89f94.2477@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260615111358.73462-1-avinesh.kumar@suse.com>
Date: Tue, 16 Jun 2026 10:58:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_security.sh: Use enforce toggle to trigger
 SELinux measurement
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
