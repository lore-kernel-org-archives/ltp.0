Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FBEC87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753807726; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=BzdrN9IdOPJLyuzcM6qNdz+u3HITd7CgnmJ94ndBSBM=;
 b=dw2Kr//QkJF0czsZ9INMky5wkOofpX2QHiPfop1wsesW+UMxm3bKP73haevYUo8uKzNpl
 KoRnY+Uv9t6X/uqrNs0epoCcZOfu2Oab7PI5Goe4ry2iBIIAI6abNCFWgWaPpXyYhQb17hd
 YUUwLKQ/8YH2n9S41oaXjJRQN6S8DV0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CED363C0433
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 18:48:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 155D03C0433
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:48:26 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 661511A006A1
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:48:25 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b783d851e6so2848319f8f.0
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753807705; x=1754412505; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLTTyp+YcUhajAq3Y6K37jjoejY19woX304AwaxVRzA=;
 b=gosdbXV6a24G571VwyLsDQGWF8s3a4PxPtb3OWdNFm1VjBcGl8UH6ybhDvFaxZxFQc
 swoXYZSPr6cimXq0tNQxzMKQYUx11IAy/XDVejswLA94RPAdsBIW6c8VCNxnh0n7CIWj
 XHIK8/3MiOvwIinjkHPdh1jcMabpumH4H3b7fc6QW652IUMJULyYg9X62YexWQnq0Av4
 ImLs+OrsxxzEgfRLhjrUJUJLpU6KLICEaqylo/fpxUWPRC4YtVWWrJcrfo4e4qYwfUvR
 nOqD4wcuUNqXmSAtLYWLSG4vNo5iS0zfHjBPBrgw4D1qO3BFjq11ENwxI4HabSFED9oL
 4Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753807705; x=1754412505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLTTyp+YcUhajAq3Y6K37jjoejY19woX304AwaxVRzA=;
 b=ioilE55tZEJk3UqS7m59t6Ff3vrx+MH/y6cmvCapk+mnnKnD88xiOePt+XUJuqOzGs
 SoYSm5vfgC9aQI/x7lMNwchDoiFv+eh38O5gWLAnx83WxDDWzgkiJrFfbL07HSY4OHFY
 I5jLqMaunnaYQ+zN42ELcnnDHWdj9w01llGlrnQymdbgOnkOH1SBuMF/KU1Ik6TlNYuh
 fIavfOLcWhLtD0LqDLMDhWV0qbBCXWIAkEj72vBuqteNFvxGrdniIfov/th+1baTNwoW
 z90x8lTCk5ocFjm2zM+laejafRDbbPxd0KmyWXZePSXnzCkM8njdCZjnSDkQ9hXZ8/FT
 TpfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV08ZCyK48Y7JfTqmBxDPFt3Mo71Eg7gOIIvxV15DFHv6gkNy4zDV1okApTyjS+N8xvESw=@lists.linux.it
X-Gm-Message-State: AOJu0Yz55m0+E3K3mMXXqrjKr7VLOnFMwHC0zDGT8XZl5mvsnqHVWVkE
 wy3svs5EJa/ZNFmKmUndT9nyb267P+3qyvwEMH+I6sDOhCBEcv34vVgU+ZjCUavwK7s=
X-Gm-Gg: ASbGncuI9S7TS2EY0Vfxm8S7jnagMFrC6KZB2c2ZFd8MZNGE1O9agcoZOyFrbyIDozd
 4RSaEM0w+Mm3lx6emKAHFKHPKij7vwVN7uOMWfrQ0UEUJfHvdFiWymvHNn7llkmnn6taOM+UKQP
 M3sPQvqc2aHBwuV4hB0fOjA7YWfV2A0zgHC+Tx5lPjBXWVHmGbW36y8jS0WG1HhLJ0bPboT0gly
 9TIKE22uxMZKtPLjtsONMF1r+6RQhwN0OIcIPXAPXDfa3wkBye1rfBtWDvN6pKwIFNr0Eom+EcG
 fJl3sTqtPHpMTwTl6idg9lODWYRWmBL9yn3Qua0m2jitWLzVCE3MMQl+Nvrh2otdwMoMhUT0JiY
 Xh9pVivwa5gA8oC77PkcXQGspz0V2YmTkKw==
X-Google-Smtp-Source: AGHT+IH6/DIWjC27D8ogbLMf4Sqp+yTcXErvCJko+W81vGW/p8BlM1UYacrFeW3xGNDQx1/XF6YVAw==
X-Received: by 2002:a05:6000:40e0:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b79501d7d5mr308802f8f.53.1753807704822; 
 Tue, 29 Jul 2025 09:48:24 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe536e6dsm82807665ad.171.2025.07.29.09.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 09:48:24 -0700 (PDT)
Message-ID: <46e5368a-71a2-4a7d-9987-a9face630f20@suse.com>
Date: Tue, 29 Jul 2025 18:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad> <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik> <aIj0Jyn9cq9JVNbI@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIj0Jyn9cq9JVNbI@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/29/25 6:17 PM, Cyril Hrubis wrote:
> Maybe it would make sense to inject additional errno EACESS to the
> TST_EXP_FAIL() automatically if we detect that selinux is enforcing.

This is potentially true for every LTP test, because SELinux can be 
customized in many ways. Technically, we should not take care about 
SELinux inside tests if they fail because of it and to threat failures 
according to the LSM configuration, considering that as a known issue or 
a soft failure.

At least, this was my first idea. This patch was introduced after 
talking to other devs and I'm also not 100% sure about it.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
