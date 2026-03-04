Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15864EDEC12
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772604010; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R4KDRVwm4If1fZutjM+66w3ydmkpax87gTRcIMChCOM=;
 b=ZIIWSaIp1Uu3rwwFyJcmjFLedyz2wjNFZ8SLUSM2McIKKF4IdFyGl+G2akCkRcHKMImio
 Z26ROlvk6bSCpl3QTFmaLxNrbXuJTGamVMB0zuUcUHBGa+Sz+p0CMyBpYNmphNQyFocGxSW
 FfJQ8EXqgPpZgB1pH0dl3h+MfK93ZPU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 509AB3DAC1D
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 07:00:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 145203C2CC6
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 06:59:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41E596009EC
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 06:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772603983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/W1U07ftiKTLNAI8Q70kNGOqbGUJ1BAUW7ujWL6XpE=;
 b=A8QgwnVTtKOpIG+SDkOpPNRCMWquBqGsRMil/9uPpbaokoCOKVoSsA3T0NIwmLkyZmln3m
 DrH0N1xPi3KWQ3CqIuQ/M1tN3Q+gvUhqQa1t/kRn9E4j3fLpmEIk3b6Kn/woRsWp0fQ7iu
 cCrAo2zCZ/p91Vv2KIU2t3zw5mPLnAg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-retS3IPcPcCfYbeTAKTUCA-1; Wed, 04 Mar 2026 00:59:41 -0500
X-MC-Unique: retS3IPcPcCfYbeTAKTUCA-1
X-Mimecast-MFC-AGG-ID: retS3IPcPcCfYbeTAKTUCA_1772603980
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be21c6e2f5so26584876eec.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 21:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772603980; x=1773208780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/W1U07ftiKTLNAI8Q70kNGOqbGUJ1BAUW7ujWL6XpE=;
 b=JXCEmySCtn4B1mFGWeFhAtPmKVUtZYPJWmT8ogvigWKz3p48s9COkB44hGYbp7pFKd
 VjHwflDcP08oFSxW2J1jyv0qzsH0GVub/BHEZxLg+nL9ntPIQMBKm4RQu3AeyysrEj2E
 e50xcz5ZyiPpeuQKEqb3cH2n60mvhmIT99n2vjZJOPMR+q53Cc+DUW1JLXQKLdDFbsTl
 1bmcI71SreGQVsQM/pAofSj/BIoKCihVlS5neqFH2U8k8rImUKVC2ELmohhMx0qzPErm
 mLzbxZrHmIg4UJciqrOmBHg+iuf3Ja5HGCeoLMtOFfVxJ9NVVkTNd5oMyBVbyMDQN7jD
 kXRw==
X-Gm-Message-State: AOJu0Yz/2M1hZof0+IVyUW06NzHxHn5Ca4tdrrwaIgh2JCxBCGWa3vbR
 CvKfEjZUg9zZcLI6v2mYXyWGZ/LG1wb28FwHtG7tRTwbH8XAJl4BT0egwxoyTlP6Oi4hQysWhZh
 wtXjh/0Sq/9RtPi98+EoOehLidvdkf+xDImzgkiXPhVvn65TZETuKTJ3H1IN1VBj5/PI2iZEGcu
 XQSJ+t/ILAzuin4VjcycrI8zRr4ec=
X-Gm-Gg: ATEYQzy9siDV9xxGLfVcvpEsHUWGwL2CLiLcIPn9RTRuIjhei42HF3OApbx60eSioQI
 1u9EiyqOIeGRvbVikqaR+wRqUAgPZCfDx2YpljbkwsACyEKhGradzSwBhHhVA9NJ/bdt+6Hp6t4
 SOsNg4nFT1shd/KLXBic7qZm6ULvyw3YmhAEjybQyRaf8SFnD9h7KecQzBBkP8QB/nUbPkPEfhd
 A6ujZ0=
X-Received: by 2002:a05:7301:1e82:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2be310a784cmr381399eec.29.1772603980120; 
 Tue, 03 Mar 2026 21:59:40 -0800 (PST)
X-Received: by 2002:a05:7301:1e82:b0:2be:3f:307c with SMTP id
 5a478bee46e88-2be310a784cmr381393eec.29.1772603979711; Tue, 03 Mar 2026
 21:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20260226103502.70043-1-changwei.zou@canonical.com>
In-Reply-To: <20260226103502.70043-1-changwei.zou@canonical.com>
Date: Wed, 4 Mar 2026 13:59:28 +0800
X-Gm-Features: AaiRm53HYhwmfk497x-ntYPjGaTu7mJ2bjsVdPUALcF42HzmAutCbTJoPrzndu8
Message-ID: <CAEemH2e1Fo2Ns=Pq8YbqbC1eQ5NAYKNCA46jfZofn2rhfnrthg@mail.gmail.com>
To: Changwei Zou <changwei.zou@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LIW0HW_hs4L5GTjOJlN7hXqO-tWXm2EbUdXajApVEHY_1772603980
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] clone10.c: avoid using the libc thread memory
 model in touch_tls_in_child()
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
