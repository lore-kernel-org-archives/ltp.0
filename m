Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DDCF8A15F
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776339502; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=z8fOGsmJH+hIb3sJx/UIFt2bEzuhEMKrpgMsejLOrgY=;
 b=K3ZDz8RexXvw4JxPfH/dPbMybWBhXshCfqGcdiWpRvbjG43a+DUM1Id6EQSuceazYEmer
 yhM3/k/ksEcdfjg3S8yOLvpN+CitAz0Mn/tLX/RZPXF5MsbkRsQqXGm3AJuGZoJQB9Zuh2T
 0yF8naqerkPcb1RN9jA+dBpGiQZ/9pY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA92B3E1043
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:38:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0418C3C2B4B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:37:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D45C1A007EF
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:37:58 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so74688665e9.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776339478; x=1776944278; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tg9tfNOZduQJez6wKNhnXTAHZhWZPoV8LfXNgtQVzck=;
 b=d0jDKyk0odJJsqUq1Ix+DPobIz2EBtH6rWW2IJx3A8S5Amd6j0uaSCIcpggImUbzZ3
 EXXLSyUhj2G6lmr25a3Y4IDoiL2lwyeO+d15w7oN7GAuFToYpkownkN9PMelrMRuTObH
 pUmCXTKBi1BJ0SE5YNitpNilvkz1+NvCVYtR3Yn/M2/lzsY2mfnIcFwa/Vh2AQ3ajIzo
 qXdEU9CvlCf9MtMEz6n9Jc23A+JamESLc/Ef/GAWFwcf5Znr1gI1OpvEtStk0DAPL7FL
 umy1Yun3rZEWZv6hYdkkSmeEV3kY+g5RoKmetnPa042Dlhy0NQN7rUJ11XKH1uKlPs5D
 VIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339478; x=1776944278;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tg9tfNOZduQJez6wKNhnXTAHZhWZPoV8LfXNgtQVzck=;
 b=W9gXy5k80YT04fecP3FPtpxBkTcozq9crxIfQ2vAziucVXjVC+2PqutLu5Ws4rtwj0
 Wys/6Z2IBbvPlqr8P4EJKS5WrggiveqLS/8pxCwo2+mNScd6fLEFFxdb+VTHpoZWkRen
 NcSJ4dWAdVfzuN9LKgU6wELVkZWQscvLcORWwWjYO5jfA+cn1OZNp9C9MRiWO+JReMZu
 tv2lAks3dKCOFKcuVTU/sspaJjrv1/kp1+uNDuh7rGmoOGd4GfkHqqQDr6xsOblCvT/a
 G0p51mOpNSnu12/7XP/1Iy+4qy5dlWIv809eEH2uWnGfkZG901QfxW572dQaOAnhuLee
 1PHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MAVRePytmW65h1PntnZ5XNchvOUg+O6hsCft4DH2brEi4yw1MAYYrW4+FwK7EeTjxGM8=@lists.linux.it
X-Gm-Message-State: AOJu0YybX2WwqeZoT3Njl0pTuWHis0iU4/Ag7HhZqIWX4KABe5OUockc
 dCh06OMciBUIekrVpFAzNVH2n7FVh5851Sym2H9LXoXwRS2XsNSVwUM2Nc8wsLW5JmQ=
X-Gm-Gg: AeBDieu4w4rZ6NiqV4tfZa5ElUI8xt5GW7DAZvRg0acFguQhH3dzdqVr5CBy6YX5g/3
 erbTkMEJ6GDMcYB29OKn3wwy+p7n+Y6NgoXfqDwCKR5gwJLj+sVUdU8ESDCiT2HHbG0efCUUfxd
 2X6KvYAeoGxAUgoN6YloWv81IAp3qtTPXSVT67cc6E8+Aaj93UZU6oaqivsC5xmrwsvRjk1r0tY
 t34whAQKXoaGta/ErFBktHkAX/OkKjd76kIegwiH0ZCStCMqC1TxClD8X8s6zI+xGkNwiEjaki+
 1vgiQWNtIyHETY01bWjM+EeIkrPZfYn0dnLtRr0Qw5wKoKNN9Qg6foXV0WOjxPavpYi/+vHXcJa
 Jv2hCb5hhC6bI4YgnrtWNMREvtslMwbVj11cPw7HvhRAkYK5HY3ID25I9z1CKBMgXzNGtfTA/kb
 9+Cl3fU7TqTHx24GD8L9tqOcRW0iQgHCjbTzb4wFuC
X-Received: by 2002:a05:600c:a416:b0:488:7f69:4abf with SMTP id
 5b1f17b1804b1-488d67f946bmr267284015e9.12.1776339477712; 
 Thu, 16 Apr 2026 04:37:57 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818e51sm75875995e9.5.2026.04.16.04.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:37:57 -0700 (PDT)
Message-ID: <69e0ca15.050a0220.37714b.e02d@mx.google.com>
To: "Li Wang" <wangli.ahau@gmail.com>
In-Reply-To: <CANgNiRx-Om37TC8DYjGWqB++AGoxZCrXam_Vt5+H1d9j-YaNzA@mail.gmail.com>
Date: Thu, 16 Apr 2026 11:37:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Use last successful run timestamp to
 avoid missing patches
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I sent this patch 3 times and all the times (even with v2), patchwork
is not recognizing it. It's not the first time that happens...

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
