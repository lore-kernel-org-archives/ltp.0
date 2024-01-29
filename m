Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E0FC47DDB
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 16:08:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C65293CE174
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 17:08:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 826393CB9A0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 17:08:42 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2A951A05C7E
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 17:08:41 +0100 (CET)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cf591d22dfso17934201fa.0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706544521; x=1707149321; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KedPhRMp74V+6dCeYx2XhMpU2tmadNU5z+adExRoy4c=;
 b=WZvPDodR/fwuAl3pERinmZZJfaNn9JggAsribfnbUEIzzGJS75os5vdFpa0554/OwI
 vJkLdc6RN5El46pDkmh4j9pzngao20yc6S1Z8tDmpyVg5S8l0v0wY+NxRrAV/Idz/hud
 DILPTlDSNzaCCTSjBQL0zPNzvz5YFEANLjC8QSxiYIId7vLJluFL0mMhj178VyyUVhQd
 Pi0jeJU3hMmr05UbwV7ZLL38Ho+zEtwwzcjwa6543wqzlWaVhTu8uZ9rnBHeGaoKWZSs
 fG09iigkIlAx89PlF4Sn1eL1NRDDkWLwQb07PRj4UUuc2Tg+eXTd2B4SiUduHGWWHnFh
 aMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706544521; x=1707149321;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KedPhRMp74V+6dCeYx2XhMpU2tmadNU5z+adExRoy4c=;
 b=wq9WpeExnrVOCyIttRayivWKa77trp2kcOrQPYzge80HyVSTYZLue2ow+zf15JZJxW
 IUhEt34pusuG9PruGOa5P/5iyCE2i6OiGS9WZI0MW/BfqnX8mUnyb+guNIhIRAz1Pd6G
 Yhgt8q2Nwou+ozuMZ4wi3aLRWnX6KE77yAOO0uSHeouqlXut3mYfdBP4bL/z3kJWR91E
 tvh2SnzIQ0TrOIfpp22/pBzAMKW4vv9F0AVzqiFaVaReAXzK7DzqMG24uks/4k9ujVYn
 ZtvM+oN/0P0fphwcTxFY97MfQBY3mVy08GAoeGmgXfez131Np/YCsnjCfQ/CFaRcgNKk
 hwxQ==
X-Gm-Message-State: AOJu0Yx60AV9hMKsaPF1O3LIJQFOHR0q0j1nb/L4K/lihTq93iWdz7+0
 O99lWd9ivJEC+BFKuTk+fXg2jQvrcUzKIW0IeIle/8YSSq/56vEDGSxmR+IrC+Twx/mGprZqyzF
 CQl7mVWGM5/3dufJkCq9/nscTctn6UFA=
X-Google-Smtp-Source: AGHT+IGsIxEscdBqjeXybwtMnjNxjU/lqaprd2SuNgTy0SJRY+SAzJqXAyOZn5wBu+byqmNiwuj2ZfYRX5JIcLAUjUc=
X-Received: by 2002:a05:651c:2221:b0:2cd:4f3b:d0bb with SMTP id
 y33-20020a05651c222100b002cd4f3bd0bbmr4649886ljq.8.1706544520532; Mon, 29 Jan
 2024 08:08:40 -0800 (PST)
MIME-Version: 1.0
From: Anil kumar Julakal <julakalanilkumar@gmail.com>
Date: Mon, 29 Jan 2024 21:37:23 +0530
Message-ID: <CA+QiLSF+YSpv4OR7bJsQWH2dp-=eU-ERXCy3keaV-Sr23hmQmw@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Test mail
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This is a test mail,

Thanks,
Anil kumar Julakal.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
