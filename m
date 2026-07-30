Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F9C55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785409995; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BRtBKalt4vVmVW9oxCn3wKSwi1v2UAvgNf5iCgII3SM=;
 b=oXpzKAROkvsZiAdjaEhGsN+zHwh5O+hlDWmIX33yXdEWwVHQiwDdWyJxim4uHXnSu03UW
 faHJzFRSNEHh0SJVklY1KtWEIGGZ5JjRaq6E6X2iwNbq8JGsjBMckf9PS9NYLKLusIXmXnp
 f+Q3Of8dk6osNHBes22VNm4An9/A2uo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 496EE3E55AC
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:13:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BEAE3E1F8D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:12:54 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 01E521A0079B
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:12:54 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso1857013f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785409973; x=1786014773; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9JR34Hmq9Jahai669lxrZ4Pn8WGoSgJIO5HjR3f0Ixo=;
 b=L2LD4M7X90Tqt7XZMSQQDeNFqorpO6zbXyQh7qrL+kZFqG7tX/PVARNj8XkPcCn9go
 ulvyX9MLuOVpVO9qfIeHtfm/HTJtPLsXo8KDXGgLbgeH1vxCcina1ImMC3Ov1BJDyLed
 IOi9I8rNWx5yuUwI7x6N8AhAD3PawGMZyQvA+LAhtlaOonyzMH42oM+GudCxFqvFKY4O
 0YX1EwfwpNb3u0mesUEbV8ZS1hrTGMAjBsTr7Qm5kdCR/SwAylSXmG56tTwdLlFa5W2+
 Ve+atlsqE5QyvaNZsWa02BW2ONaSzbP38EirygHqzBIIW066vWwpPSr5MEAvwHg4nRuD
 vXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785409973; x=1786014773;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9JR34Hmq9Jahai669lxrZ4Pn8WGoSgJIO5HjR3f0Ixo=;
 b=ACBJDV0JP6s8JKHi7kMQhXYPTCnfP3dsEiN554ts//LSb6Fdu17ks7y7EGZP9PjE5p
 Rw/3iUIkDg0TQfoosRawyGsxIuHzapRbtQOF+Mxetd+y7vfjbsjLpiNluZCc10kc33aX
 ATnS0r5zw7cqegqndInPy+eR/q6dahO7g9L4vBn+JLqCHJZazPOCzf64ZGELXD2XPcDt
 GpAzgo59g92JGAKraNqfQunE/+9EJ4JvXJWXdtEKYH5kLxGPHp85MkvlfBd4/ZRcNjNq
 bgVb+1iJS3xerd5oCMDhsJqJU3nA7spCwwBYA7goswp+k1xfecSTkdlsGkHMTUgmJ0bw
 MnDw==
X-Gm-Message-State: AOJu0Ywd5GVbBTORNC9EM9U1sKt2G3camDEJh+qGXOkS3ozEvPgf+x9f
 XH8TKrbcrzs+cMfkCVuWexdFsn4rb6kZ+cMMxoSa3WCNM8tyYhwGIf2hz6JAQl+TcN0=
X-Gm-Gg: AR+sD10O+EuyBxJ0+FOnj89KN7tk7O/wr7TvlvadyQPAbz1++jUtdCYBGrfak26T4ks
 lc0HM1mxWx0q3KHpcS3aBLKqXwXWYXf8gIy0Y/x4ioESnzVRvQ/vmrgFxRG5PWxVijxjz1dLOjg
 7C/spN9ZyjmHKtwy4WaigV2LLHITnKZDniAdhTSXrcmPgDMS35dvrJYkVpM0Ehvt8ZDsKiWYAeP
 1POZEk9KDCWpwWxgIW4Yi/DPl4Ba/wvobbsaIJ6n4MLDVBKFd/sKd8MhBOw94DQxCozTGUyWd0x
 84XjIs3K/ueRjI5qTfPW5NXUmeR/BTPI2RtZs/Z1FTnUBXXG0HjaHxi9TJ2CfBT7Ht7wy53Z0Ku
 Py6cgU8pIuV6PAgZxhM8ppb55buiu/S51Dxpo23T1uhwDcn+wUk1+SpsrMMGa2PW1gMjZjwebzN
 9eObK/xuzCuPUoK16lzsReNmJZuSUQKzUObOy6ylfYmzyUt+eWlRzjp56mG3TU/Qu8SRvt6UlWP
 DlhINxVT4Vw2ZRHLOPxM5C2FeDEBQ+TLyjZtA==
X-Received: by 2002:a05:6000:2612:b0:47f:8802:c182 with SMTP id
 ffacd0b85a97d-47fcbb4c6e7mr46610f8f.29.1785409973287; 
 Thu, 30 Jul 2026 04:12:53 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm5047990f8f.8.2026.07.30.04.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:12:53 -0700 (PDT)
Message-ID: <6a6b31b5.3d30ac2e.39874.ecbc@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715123612.1684984-4-chrubis@suse.cz>
Date: Thu, 30 Jul 2026 11:12:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] syscalls: Add epoll_wait14
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

Same comment of epoll_wait13: we should use fd != -1 inside the
statement. Otherwise:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
