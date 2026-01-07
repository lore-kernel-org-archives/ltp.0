Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0025BCD585E
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767787356; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Hpwlsl4R0tQa8al5ShZKjtqOm3sy4aOem3i4p+Poo5E=;
 b=EclwFvd0vEJT4qYl+Pt9lYXinmiqmQvIxNHLQgySMiCfv+iGyrym9+hOJwNrrdjytNUSD
 ae+RalX+QAd5D30rT8JXE5+z+0i+MqFbT2bt3ihf98du8U8jQwdBamxIc/Fk56LsPFdDl0x
 2wLvCTv9X9Z7UUZD0UPCT01dU+hmIIA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80E663C2E38
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 13:02:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A3A93C298C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:02:12 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 260F61A0068E
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:02:12 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso3524815e9.1
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 04:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767787331; x=1768392131; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=GHK6l92SzlXlGJN+5e+OvEKxhsXJXJ7/EKB8/mq8h1Tu6fMoGMSO49S7pUKpK7qONU
 lc6Fn07bXa7yEV7WYjtaUMcONi0kVq5dRT4SKMgu+8LakaPJZX64dF/FWEaHfnaTGMJM
 8uTWA2iZbnVfQrk21RQTlh1vXwCmv+oz+y6hxJH5a7vSiMRO/3RcxSUf8akAfkQ78oG5
 2IbZSfuhdF/KcmGQooimsBYFMGEbxWdAvylc16LwFWwy2BxNZ1iGA72YokafXydRnjBH
 ec52U4K/SY6n7HrGThEtrgWaxWAZ5yHXh0m+ezD0TWRh+UP6vG/5lQmHxkFLSAc4p5cz
 WwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767787331; x=1768392131;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=P4YBEzTGF005jOD7niQv4WHQVcMFnPik2zRQCe740dKEAKNfx390gdBkKPFmMQ4V/D
 e99Bz5VpUFb62QF+Bo9XdLERsNajVpIgkVwi28ksAE6YNELNfEnPV1Zvh2uuctoaELoh
 bjzpXi7Z7X1dUZF/T9CmXVPT674n4+dDaD8ksJJn/NvuL4x2N8EvIZgsF4PvoDjNSRxW
 Zyc/KciKAYYpJGl6weJ77j715RwGzGIjJOxZVOWwAgzEiIAAMxiCzi49h45RtCV+REbb
 w3/cPztoJhU6pwAIyzgUUU3/sAufgvZmii3u3VQ+6ThX6lKC5oB0h51+x4SnEhzAw88J
 hGiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyliePFa8zTzlbmhspSfVeGy5uRBjaVYpRszUhvsOujz5Zdj4ZDjI7K4wyTv/aSKXkEd8=@lists.linux.it
X-Gm-Message-State: AOJu0YxioZtecB98DP9V8Q7phXXQshTERizvQ5t40PwzsUteb8wLJqa4
 +AxiTwDqZiEe/EZ5v+U2upmZBAu8PllxT2q/Cp9dkHmuiOn+aRcR5EyyCa/zF0GZWo0=
X-Gm-Gg: AY/fxX7s490sT4gYWMit6fcXDOUnE5tfMdCD99CnAgnpVxopLkksOv5NknWolh5Oh+H
 zthE9iIWNG+wz7DvHoQ7/MhXBibs4d2iRyEt9mgYmpin9rpaAjxja1OJ0Ak+VZztQ34ZK0Ntv75
 nSjgG+sMsU3/eMcwarVjXwxyV0z2L6KzzW4DMiIT6Cw+kMiR1VEHUVTtyk/q0C3KdCnixwel9+x
 k58dl4m3fnkYNIO0USIRORNRhscV3jJRICEv4cQdXmtSiJjFIjlhM5UbuUKipzyGKrx0Zr6KGlr
 V1FZhFNVnNM5NmJjIVyG85KE5Z7bxXW3PRBlsGSqcsOCkzgTNiVcWday4OcPoSjPfKJakXIrNsA
 7nxE6/3GlO7OQWOn0rvnHliTHYYtXtsT0V2KCVjGru4+ahMxkHbc7yAn+etK4kFzUs9a6tJAIfh
 Is9upnSWKP3JHAem3dhvQ5d6I=
X-Google-Smtp-Source: AGHT+IGkU4ei4FRmAs6RPKNss6GaM+HSzZgzv4hYiXa4VZVgEPbMqpeU72wyM5iWhmVpZ5dzFtGg5A==
X-Received: by 2002:a05:600c:c0c6:b0:47d:87ac:73ef with SMTP id
 5b1f17b1804b1-47d87ac77c3mr10897305e9.13.1767787331406; 
 Wed, 07 Jan 2026 04:02:11 -0800 (PST)
Received: from localhost ([88.128.90.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm90073585e9.10.2026.01.07.04.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:02:11 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 13:02:10 +0100
Message-Id: <DFICB4CKKHLI.QSZDWLKBJUCZ@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260107114933.762846-1-pvorel@suse.cz>
In-Reply-To: <20260107114933.762846-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fw_load: Skip on Lockdown/Secure Boot
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
