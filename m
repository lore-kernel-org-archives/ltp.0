Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0620D6ACF0
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766059129; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4MvOM0k9jPXsiydycwfa+1aDa7q3hQADuW4FBT5/0eE=;
 b=pBXoJXNbniGhHcWB7BkTihlzWFBlsA/wpwvd+XsUAY7Nu/MiKBYrDcwtLqNr6/yFG5G/b
 IdRUg5pUr2F3pN8yNvfL8mol9Xu7UNsJEFHQCBYH9miUQLEt05d4EsdID6JSJIrcQOX7Ca9
 TSusn3eNsEhOnU8bLe4GLK3P5nQ90gc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A4453CFA8A
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:58:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2AC43CB780
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:58:24 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 898BA1400F25
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 12:58:23 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6418738efa0so986074a12.1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 03:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766059103; x=1766663903; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUSPd1GDXs5HEC8AUTeQQR+MstU3CWM0QMUYI4qmkjc=;
 b=VwQi4f/k6llQ8aFfqqFNzlqrwE2jrPOVghweCGBTWHWCSO3gWNPNMEl6fdhuqNAF40
 rniY7EWYYv1fcXooq1/P5a2V5LTZKLsTVW3InUiNRkuLyD3yyzBVU3ZGkGc7/yly3azw
 TowEyFBfNQkkOnmjihXrenv+knwjvh2pAIp9Z7mvl+NYcN0pfSOerdSj0O9ge8VhAiaV
 RO7AH/Nv3SiwxXdgoEYmleJBR7qhHkQnuOTHR+Tp9pHmcdSbjxJUGxfDwqTlXLleRoIH
 NVmWASRLrkbQC2CNU97CukhYNqfZ9M4nEk98saAKaqqg5w2GraLUIQ5gAigRmxi3Wurw
 dS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766059103; x=1766663903;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VUSPd1GDXs5HEC8AUTeQQR+MstU3CWM0QMUYI4qmkjc=;
 b=QaBg1iuNKDPodLgr2+9q3hvTKURYF34YWiHltSPKNIZT24aVqM7GzZpI+pgNjVtSvF
 P+FILcDLtYOKQPN0HtRDTuCyFoCcUimlD4zV0o8hE3d9QFL3IszKB4OAgOYMVwX5kP4U
 V9gx9oMmWn7VMx0s7MtLu/MTaEzpNkprW1SeklNwUbg3zuZvE6yzJIpDLenMaCqL//L/
 pvgayeMQQDDdytan/W6Tht/FX4ploiz5rRLkgDw9/bBK0ikAcWVSnk5D1ZloAe9Pd9r6
 +7NA+x5lIqtnM1FrX3tFgQsRRb+m+wZ0ewtkZBQbEgsT6EFzRTWqhmgs0MqtZswYQMfw
 QycA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvAJvuO1P15LfzoZODVARhrEvDHwyRpIM6Pbk6hJAwpeObCsL48XNivc4cPJlzG/jdCAo=@lists.linux.it
X-Gm-Message-State: AOJu0YzDb5EW85XD+W2W7pmYktob3MowTXDQXO8TtkDbWXUWjap+K6Ls
 //wMTfzQEexSnu1/07Fxq/z7wyc/+kumITP3+HFJEGPjoHCbd2Jd8gEgIaTn0Y0f8sg=
X-Gm-Gg: AY/fxX4pRW0f5Ja317WN0Utq9LZ4KwMCOFJLo7dO7m6B63wMcpN1aDd0OHfQ+kMxHYa
 UWS8jRj82rZRGbvPpLQVoKF7KJ216PFBq08LVV8LFdkkm13olkOLlZN/Dof+by/b52MfhWafC8f
 4l/ZyS5gdfZ8qdABjGROcEEZD7Fn7GYeHINb7nKpKv/KsDkX9qo76effGnHp+rb6+TM2LSlhq5o
 VhgI0LQYkMTy407kDyNGSssDtdAVK7ePFqgnWd6pZJENuA2vJA+IVRSR8Y1rum477YuUn3ylbpb
 7mpwNrNSdq4iRSvFN7/vbJu6iyxfLektn8zbqlO6O6Z7ew6yEFJlzjo4WTUYbKMZPRPgioA25r9
 FpbogOdPJqlzGyTVs3AABsPOmP/k0aWsQXs5FONM5M7Unn9H54sEl145T5zDKuD5cuF7lvqG/bV
 qzIOfFz78wC8UKMSA=
X-Google-Smtp-Source: AGHT+IHys83aMk6lfw2DFq3KwajGE7IQy5kEFG+J31deikcXBe+7YyIi3XW3oVMUQh2QZ23nZNkbdA==
X-Received: by 2002:a05:6402:40cc:b0:64b:7654:f8b with SMTP id
 4fb4d7f45d1cf-64b7663592bmr735317a12.25.1766059102902; 
 Thu, 18 Dec 2025 03:58:22 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b585b52bbsm2522835a12.6.2025.12.18.03.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 03:58:22 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 12:58:22 +0100
Message-Id: <DF1BPB5HEPMM.2OHYIJATRDEF4@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251030192543.761804-1-pvorel@suse.cz>
In-Reply-To: <20251030192543.761804-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: dirtyc0w_shmem: userfaultfd01: Add
 safe_userfaultfd()
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

Feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
