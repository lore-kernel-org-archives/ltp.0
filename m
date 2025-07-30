Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034FCC87FCA
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753828881; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Aq1sysgNHM0J5yDNcXQuxp1fAB/I3TnBPQ2Jvj2aZ6Q=;
 b=MgNFbJeUM5a30FG4DrL4j26sRphibVr1tn788TT7ZrKHnzijwPqX3t6Dyh6lWX+E1GmRO
 rtmwP1JWc++m5rkp5u9fK1CgmgtbAiO4ewtTWsxyn+l+UMR83Eo9QLM7vIVPZN7mLX4tzTe
 5TEhmgRAIeQwg9phS2SnzTjYrKMQfIA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE82C3CAD72
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 00:41:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D77143C2E27
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 00:41:01 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A29A10007C8
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 00:41:00 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so130215f8f.2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753828860; x=1754433660; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JW467GmM8Lc8OwhonjCUmwwluI4hgYQef25ZBOu/94s=;
 b=gY4RaNk8ZgztZkBrrauIZiedFNVnjV/TMqZ40hyNB/ZEGCG0XchD3WM3GAI+xmS5nH
 kr5dSgONKqLr6SVPjfH6h7na4CsbCeNDXPeP+xJ3AeOeZgOeJ/QRsiK9w3sBxrsJCanH
 inPyEjLxsrtsWekNS4zvj2+OHYstU36NNkWeBqXGjwh6kSsw8yYXpX/j9S8hqqTAGkAK
 q5SR8Xj+09YaV5vvnNP6wIB7U4S5Q+N2I7ZX/JX1mlXP5gj151j72wvnzONOTIpXQFz7
 KCJmubaIkQca5WqMf+EGoGC/JbhZXyQyYZtaf4e8/bfFQ8MixkOCV6TajaD5mZOHUiRi
 lPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753828860; x=1754433660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JW467GmM8Lc8OwhonjCUmwwluI4hgYQef25ZBOu/94s=;
 b=oPLQBp2vySYe10PbCyVNmM8ltwtlxZjh6TLD6KJahLBP6fSvi1SqUsZbZi7gpTKaj+
 kHMaAVAjwryiq1jYLx3BXZKRTCVZi9Uyoh1iHeZtzogbaYX09XMkMEPmchl+MZGrJYuB
 hxuldF24j8YqxHjjEPKOcFsNiPJ/GaPxkp7Drc24NMQDqmDUzLR0AqHhSMa2p1Ievjre
 LF0Hg4+ydr8w2RoD0QJmTvULUg4h+otLejV4ax1srdIpoV0z9XfT9KyZZTxPzaAh1j+v
 5S980H22TgzoKkS8DZ9SI49Q0Kl6/XaYVW+sXlsMpfniYqvE4Owe9UnyfwaI7YixzD/G
 vgeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi5WBDsrxe5RaSF82HiV2MeV2e7H14QoYML1lmZBNVGw5gKHhYwqbtFxRB2bPUKJeTZLI=@lists.linux.it
X-Gm-Message-State: AOJu0YzJBa30Kz732p/noTRwm1AXAb6iWcSqV27yu6N4iqmSFjl/Q/Sy
 GDf7KEuWqbWXwNYoCBViXZTs02Nv+WGdAzyNSRNeeqfnQ3aMksUPIq335tuqOGHOtQ==
X-Gm-Gg: ASbGncsVLUSXAUFmI2M6oeU51ZYLTXUZAbsEGEDMXVmj+1hmYOkhLBQaON+kqIYOzWP
 1F7Tmqj8lYAEiZ9mtqmChBhVUAJdF7g56bUEzU82Am8VD0d1zQZE5cnzzz6D0GucuF0v3H1qP8s
 LuTHIoa0I3ff8GPViNJhk1Rsu97Ck3UlzLzbJLYdt/mdxXLEZVzb0IPQKaFaANgFQ7ca6s3yHBZ
 dqAy++4c93FGr91OiqY2fahNK7xx0e06InkertaxaMc1TUISGZbh6XoiLZRh/38mG9aDCgXh5Rh
 U3J7+VO96jeuffbY8jjuvGRqG1LvxKYTYgYyUltSCNTCv/OzA29QOsJ3bfgtnkHKf4KPw2kCHD9
 cR6FyTeoR2DgG7la9/XeS6Q==
X-Google-Smtp-Source: AGHT+IGQMmnBdW+U7HAkpipPgbR89J9BMOkhMWMgcYfPE2Cx0XzM3rgLSTkh6QmRatbQ3wBQyW5Neg==
X-Received: by 2002:a5d:5f90:0:b0:3b7:8d6f:9fe2 with SMTP id
 ffacd0b85a97d-3b794fed8f0mr754677f8f.23.1753828859742; 
 Tue, 29 Jul 2025 15:40:59 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dd3d88sm175142a91.16.2025.07.29.15.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 15:40:59 -0700 (PDT)
Date: Wed, 30 Jul 2025 06:40:04 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aIn2hOwIadEPpxz0@MiWiFi-CR6608-srv>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad>
 <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik> <aIj0Jyn9cq9JVNbI@yuki.lan>
 <46e5368a-71a2-4a7d-9987-a9face630f20@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46e5368a-71a2-4a7d-9987-a9face630f20@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 29, 2025 at 06:48:15PM +0200, Andrea Cervesato wrote:
> On 7/29/25 6:17 PM, Cyril Hrubis wrote:
> > Maybe it would make sense to inject additional errno EACESS to the
> > TST_EXP_FAIL() automatically if we detect that selinux is enforcing.
> 
> This is potentially true for every LTP test, because SELinux can be
> customized in many ways. Technically, we should not take care about SELinux
> inside tests if they fail because of it and to threat failures according to
> the LSM configuration, considering that as a known issue or a soft failure.
> 
> At least, this was my first idea. This patch was introduced after talking to
> other devs and I'm also not 100% sure about it.
> 
> - Andrea
> 
Just FYI discussion on similar case for fanotify14 handle selinux
https://lists.linux.it/pipermail/ltp/2024-March/037564.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
