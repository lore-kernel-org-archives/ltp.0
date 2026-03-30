Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02552FB3CEA
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774863613; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=UcAxF8bibvkMFlEDiKABZeQp+MOJl+VkxUinUuq/ErE=;
 b=pPP/Ofti4kYFvRvWxa/AGm5iu+DDJrz2qWo9jjxYJW1CmPfAiWhpxLt7d0srUEyo+FD+6
 XMIoVI1CnLYV0d12dp/mV6AXFa/UfH2IOKRTbHjH1le6CxaN5vTPxmDe1rV1+CKZ14+JyDJ
 TxPeC4GruZJ2PXJQ/XbcGcKKTIjoMhw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70EB03E4F11
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 11:40:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 110D43E1F90
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:39:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E48A1A006F0
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:39:49 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486ff201041so41928105e9.1
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774863588; x=1775468388; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hbqy5j6bypI4ej7qhtks18/v8MOdVLtqtO+vfPmmJME=;
 b=Tv7FmuWAZDxDcjx5Rm/vLRsIbT4FL970OI83MfNFxZy8R2riI/1QQlbWmVyre7SSl3
 FraCWObk1xvpsjl6Jya7eI8ajUhuZ7GPrG33FK+hPfZ6PGL+FYkcQxqsN+RYV2LndQq7
 P+gfmsknYAaLRgTfjbwrDhhgiHBzfFlIpeDhHPk+4sG9cC69/viDj/jv5pshIyd4o7XN
 bCH0/wY/sG9TbnsOQ7FMIk6zj7qO6OScFGJtv+rGAOE+4wAEwSxL9TYWcv1ZBPQJhr3H
 0ImGVPQ5HuB0/GsPVNFtpELXi12XBzC0HewB1OGHduu/kk4rS+5CX5vaSUXbHc16WJGS
 PqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774863588; x=1775468388;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbqy5j6bypI4ej7qhtks18/v8MOdVLtqtO+vfPmmJME=;
 b=GwtzWCVfGdSuUlNtvQCJ/Ld4VTktwFcdnCbTNjI3r1Ct32whIcsOHzrWboR1jKzE6g
 Zoly4M7ephJXTviRsXtR2Iy5p14jIJVY+lQMPVgv63kjFs5DTDJuOZsGOzwfXY1D5JtX
 8kRF+JLsEU9bJCRMfzpY+rhLCADjgjUWT2qDGPiIxEgozVu2q8up3Xr8V7i8DP06F1XG
 rK+cKonC6afMIZzGuvg8KFYTgNGIgTygn6fx8oJKOlf6DJHwoQAwpaqIwNMjBR6G5eUr
 mGTqcUtdo1pOpnpLGFTKDIygYF/uLKkSmrFsw79Z5LcjoHzHeJ5jIkE52dXEDeveVIpz
 efLA==
X-Gm-Message-State: AOJu0Yz8iw1mE/5HnEhukGwm4dum/vh3B6JOhv5VnRC4CrvMqjAuasYG
 H6Gn6bEL7dq0pJuKoZQ0yK2C3EgPkIKicyDRwAipjdkyPG40pBxaU/fa3RFR8Roc7NLk7Mrk4iS
 tFvrWjhI=
X-Gm-Gg: ATEYQzz5x5P6DKMokeopVfGW1kr9k598O1ItXvgZTXDPVm/xiEIwq/IP3i4Wbv7LjeX
 zUi+1ydWTzg6/Ydz6J/dSvHf4fKW2C01/VewtxNTsmOa5dycKhDAyn5VfXu+n13/1jxwZI49xZ3
 MpO4Htp+iWBlgBFJvFtWSQKVXrHzAKBAKJ93YuLlCqueXkVxp0IO4d+6UecN0bp2kgug3vgQD7b
 HP3mE0z4G/jPyFQOu82MPJMmvRS9eJtB+x9UBqK+bg7i7eZ+S/UTWVOlvUdsg+BS74EJRR7HPzj
 opOjNVi2GU9HvuzT5YyECb4PBonVkz2F78fYwOrrs345VqW7shWKhVBEvxVl1n9EQX9tX1itqNR
 lSbkS/Qd2nFjD4kKqMprEX7oo2f2nCLvydLFOJW1W664dqmQ7SF93GsSuviy2LLkaN0zSJqoVQF
 idfdhazVS51A6RA1bpfYBq/M+uzY1M5lpBahJtoLM+yJIXC/h+OuDD5VJ4CuoMd7b5mkOfVKISe
 Jj1DiDGx7TS5GiwXNSUemgY8GQ4NGGlkKQ=
X-Received: by 2002:a05:600c:8819:b0:485:3ff1:d5c5 with SMTP id
 5b1f17b1804b1-48727d55fc3mr193915485e9.7.1774863588498; 
 Mon, 30 Mar 2026 02:39:48 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4873062ec9bsm166734625e9.7.2026.03.30.02.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 02:39:47 -0700 (PDT)
Message-ID: <69ca44e3.050a0220.1c18d2.277e@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <91b22331-8fef-49c2-8976-0389c6064505@suse.de>
Date: Mon, 30 Mar 2026 09:39:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Add test using UFFDIO_CONTINUE
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

> Shall we declare page_size as long because sysconf() returns long?

That's a good idea.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
