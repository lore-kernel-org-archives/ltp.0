Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA525C5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786603013; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IgK9+3nVJG/7/T4kbai9A3V86Fmjo/5J6xOkotRKqpY=;
 b=joq3HOoE1l+i63DS2TWDCGqiiad/hXfqeDYze9LQky4dXiKCl0y188K9UDKjLuFxbJ+5l
 G7h4ylJgBdpUnyR8dSTuljKa8AO+vWT0KXVN8zk77+/hME/8RYYn+1J0kD4C8GsgrRtchHZ
 3lRm8TWdvFCj7Gt3tLQaZo1v5/QdOWE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DD83E6BFE
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:36:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77EFE3CA177
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:36:33 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 013096007A5
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:36:32 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso128229f8f.3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786602992; x=1787207792; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dk69Bk1JZ6h0c40PD30Lm2DYP5VN4dQL32h7iTcBvs4=;
 b=ZW2jHYI+5clEf+bn84Q90Bk5flckUwaWWkF+3vc41xOmomr3lZG6L70+Obrc2VLd9V
 AlqxbQc5Kl53RPJ7XvnhsNlaLj2b+PlC+dDvKA43TAURy0Ji8SXkajJWTFq1/GitfDEU
 /qhEhTMvOj2lTMzS4JlhAm2iJe+OfiQ+Q1Yl9Z7Npb5j0cbj8BRME+lEr5q8pFECsN0u
 JbHv+5TzKJnAhnJkf4+2t7cHcBdfURyAmJ1jt8G1f29F9etuhb+ahFzJqPKqkMnsQCsw
 4rq5L9LCSo4n0PFAW+s1DEOS5lLLfFnA+o6AkwavgbZdAba1nF6RraCNhdOcbykjqgsZ
 1R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786602992; x=1787207792;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dk69Bk1JZ6h0c40PD30Lm2DYP5VN4dQL32h7iTcBvs4=;
 b=I7ufDTFa8HKOTuk3r7nPT7CtkEKhuxf3WgmqSkezhySOZbOD2mbH4ovNJFRwhdSEie
 nVMz5FkcApvOFX4G4Vs/5IiH7JVoJy5uMt9L9hOvhpGbHzMM5q2aucAp5bHPKs1tboy2
 mO/TejZqsJKfuNrjrSws7eLh+eliHK+ghqLOD9wd4Him3AjSBd29ylyf5bPfufbMf+EK
 hdi/OQqXFhn04mY7GiDDHBZGPuAViupiTGZ8Cs2cd9jnOyzzYQ5tNc6GcSzYOmf52Rla
 LxlZIF/grsOaz6a3u7SowZa0m9uXupSWxvvgF5fK4Jz/7jH/igIaw1syWXAhz505KIFW
 qXJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGM6elAkeqp1O/f6RiFOKfsMGD3mNUpkrBSomSeEL2j/E8n+lNsOsL7Vm53xmlSPymuLQ=@lists.linux.it
X-Gm-Message-State: AOJu0YxVJOWVI8i5aNHHw1vxmU+LbKuG3LTChpVl2x9o+4x0sCTcvRz7
 pu3cMNNMJQ3mILVcwMJwoFHo2BI9W8fQa200TGZ0DcbHoMbATVTiMNa6ZX8z2Rw4ucc=
X-Gm-Gg: AR+sD107lB2TuFKkHJOU6LnVdCuy/ruWk6+dq/gKeRfRAduDsLl5F5VXJQEMYLknM3E
 thCly75kF1ZT5+wUy79f2BbBNwiU9y8YIntNm8cXvA6XREH4MHiXWG3F33amf95gw6S+il8wVrP
 gaaj48HViLoHPlh3UGIsef3uPO2954wY65YQHmNRAyo4I/Y5oj6xoEP3+CjdancrxlQByt15kv/
 GAZHU8xIIihy4IPIJzSDm2wMmkY8ULDr9DllMfw7iukHQqwQg0IcMssRT4tj0/BndJycfMB7eXN
 A+L4iuBgkb4rpRTsaOO6zTBPQCOyXQb6SkRsMrVYljsqQkG2GCpe2lppqdBQ1+mUY2yVPeBSG59
 TMdon7LKPOxh9v5JvSSZIrFBaR/88ZkvcSwjzYeHkLL1uwksAhRHADzgW39nZcWI9NQPl2mr7dO
 em94nZBH4WfapUdiCA0apPDoRpe4wvy/OCWSK6Jgy4lJJ1Jmyg3ypk3soniN1Fs5X0VlgcIY0=
X-Received: by 2002:a05:600c:3ba2:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499821bd042mr37587615e9.2.1786602992379; 
 Wed, 12 Aug 2026 23:36:32 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982121658sm38631085e9.3.2026.08.12.23.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:36:31 -0700 (PDT)
Message-ID: <6a7d65ef.3527643f.912f0.f60e@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <anyWCO1ABtTG06QM@yuki.lan>
Date: Thu, 13 Aug 2026 06:36:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] refluxfs: Check kernel reflink support before
 mount
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> > +		tst_brk(TCONF, "Kernel does not support XFS reflinks");
> 
> Wouldn't it make more sense to add the check for EOPNOTSUPP into the
> tst_test.c library?

I don't know if we really need to add something in the LTP library,
since we have this check only in file_attr02

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
