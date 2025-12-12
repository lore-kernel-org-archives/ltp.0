Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE77FD4415D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765531801; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GV9yAiXZ6m92pUeasiOtvpuid1A8Wek4Zy7eHLvBnFU=;
 b=qYDo5PNrSW+z9dPCQ9MVjOEH4KSH9z4GgDGbNQkgx5E87rRK8590NAXsPkHZpoZ5Cb5f+
 Ws7TiI8MeEnZHr0/IP5gLnbQMblvpfgNF6wxU4bJYJRAx/SpAMZ31GbiKfd62b337nXPe1d
 KsUbfFmbqJofnjunOjw2vXPs46myPHU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393203C60C9
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:30:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A12803C29D2
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:29:37 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38DAA600D55
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:29:37 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so10811785e9.3
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765531777; x=1766136577; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLC0M2fLUxBSTgRjrR3C/4NPdF0TF/+7jN1A4z8PMds=;
 b=RtnBLavAfcc+U1pb9lTYYfwokQo8Vb43CjmX/z+Vb1T/02c2H/y52pfJoeZR/IwxoX
 Pjv8YWPP0LD4C0e5zRwF0VBf81vyMgaB2Ge0ko4sKKy9yVHuWlUxho2DLMYboPG84XZ5
 XK2Wu/6o0vtB/Ug6IjBBMHMbDu0vNChr7B5Nub3lbbB0PSSg1x4mYhrwMvlG9s7a2D14
 UG86bkk4BW92gTyjs26Qb9ZIFz9uhDyDIRA4P9kgKTmj3hZPga+vb39eDq1nuRIJHlBU
 5ojM3tiFFUPu1fB9sz5cT5d6717AMLJioIHe/cNu/iW5QJvhnlah29TPJWPNhJacFTrx
 VEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765531777; x=1766136577;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLC0M2fLUxBSTgRjrR3C/4NPdF0TF/+7jN1A4z8PMds=;
 b=bs1UMWjowqkBzMFA2caxl0G8bk7PgMgT3DBSrIuG/BI5K1bilPfS6WTAXgWULYbw3l
 JGqq/s5NPIePhI9DPBenloZ9jRmD0FixR1dA+NmBqRQWTJ3o3nc3pesGuCKa87Djv5Vq
 eBNmxRnlO6UOmv+WQqBlFpZ4wXU1N4+Q7AzMiJrTFwExPdesTPtOB/Q1LqL6cr023Lp9
 k45GW04Y60NcABPIaTZT4/RfCT+Fj3w1zHf3c9FGfV156zOORbsVjmrUhpeuL3Bz8Ok5
 FTR3xUwvxnwQNMCErKZ+/xg7ZUmRZACvmeQDUL1TkZ8amnNvQ4P3SxTRMed9a7jgIu8U
 /C/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWwtQsEdAnLnDeWUr4D638yE1dJuiYGjFrrF2K2hel7JnL3qGoraDjAp6ctUzdrAhjBGM=@lists.linux.it
X-Gm-Message-State: AOJu0YzHYhzoupt5XbbNCK+l7/cYmSRyVP3i72URMO0Ecpfobf3qMk4D
 5TDY1UGQRGaYOALtB+za+jZp8R84zpKCRMP5QucSNpe1u3Yq/Mfql9iePrexw3vt5Ug=
X-Gm-Gg: AY/fxX6pv2rwOyyvG1EynERvDrxXCYT1EXfpkzSq51/60JUk/1jBwg1ezjhy3HUb0q9
 C6ExT5zpJHM0Ma+ZEGjSmWtjRHdyvtwm7VPHeWSCHyXldzfqRAwMimI+hBnqg3cY8AeIH0ajfMK
 fJap3ZW90Mju4/tOFpetrf6XgG+gSItW/iTQxvluFd/7jyN/Pydvmg2SGCRj/zXXbn6GuiW+2aC
 cjYaJThXyMJahQ6XBvIG2KwAkvb8ooaHbJdgf79Qm7iAkE6etu95oHYrkvpoQqaSoUzxg65Hxh5
 sf7AqphI9TgWZ0c2h5ahetnEwMGLQamSqcVzBsfpT13jSrrEfXUcV1Pdr0uNSlfqLjskbqmicnd
 l8GvrCr2pC352TeNCBkY+95KNpvFwl8XujQs2xUk8s8CxqlH/sBFvwFi68B5T8HA0Qb43doM2N6
 h+X/YnunUu0i041UVmZPQ=
X-Google-Smtp-Source: AGHT+IF5osYMPhwejmtUeJ+kgpOCgU3B4JcQeY9TRlbAsBMZCKI4otJ4j42PmI3pwJJyiDUJZ0hXTQ==
X-Received: by 2002:a05:6000:2411:b0:42b:2fb5:73c9 with SMTP id
 ffacd0b85a97d-42fb48e870emr1387065f8f.58.1765531776527; 
 Fri, 12 Dec 2025 01:29:36 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a67800sm11216984f8f.4.2025.12.12.01.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 01:29:36 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 12 Dec 2025 10:29:35 +0100
Message-Id: <DEW4S4LXK0U5.RSZM163LCKXN@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250526143551.1321709-1-wegao@suse.com>
 <20250603214503.3792293-1-wegao@suse.com>
In-Reply-To: <20250603214503.3792293-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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

please, re-read the previous reviews before submitting a new version,
because there are still some issues not achieved.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
