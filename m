Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A560105F7B5
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773416199; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=cB9DffZCOymWs/b8IZuqpSr8lj8sLh4ZSASZnPqAaXg=;
 b=iWeMkShayFFQjlZ4MzKUVAOww4iV+EbBfgSbkkjS8mvQk1izfMQOKKOZcG9Qvlh8Djcfi
 DOEn9QKz5UXNCI1AEwWH4MjnFKe1VLrWzIR0lfyv0X6wDAi/nH6s2EiKRLECSDDNC3D9uMn
 ZUbsHWCu6CSORhL/37/QRcpwznx8+JM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BE283E57A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 16:36:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E02D3E5798
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 16:36:16 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 503046022C7
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 16:36:16 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so19602045e9.3
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773416176; x=1774020976; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YSPqnY9lEh6TICwg/uoMTwtz3Lw1QieKBkgmuCZ9TF4=;
 b=TyfrP5XGzBknAYqG9NvfJxAAA9BsFdXQXNQk2Ry4U4z49RzwOk5QIrn+NVxOX6bvr/
 DzNgNqzeRuR16+ACiE6Bj9/Pu63Jd2a0ySjIrjASj6PfmCj1Lv6uo0VTPVLgrdtCToQ6
 NyQhYzMkDsT2MNuNKREU7hJOddlqeOe35djfY/blSURTHlMXxIbopOnH0ROsBW+ggppw
 PcEzmRv/XdDVC0Zjm/O5RObu3cxg/n+X/x5qNnDwkW6ivflp4mglJDtsC2jQObzFF/IM
 Hx7jgzhCPFrFOgh92vUziP6/NayHPMJLKwSpW4Yd0GWDKOqXXrDLxztldhZoHed+qtQl
 D9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773416176; x=1774020976;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSPqnY9lEh6TICwg/uoMTwtz3Lw1QieKBkgmuCZ9TF4=;
 b=NJCT4HF6Atg4eLyEd0VgWAEK8VJyMPdryMDjMmxuQZ9/JQ2OKeUK4HI54dKvTAAs4X
 cVDo/sHMu7D3Soy0w2J3mBWL2S0ID1d8EIJGe7+ds6q8X+ENKonHM92VAVWmpd8z0RPx
 1v+GgDM4yKG6lMFRuFcZ+gxOpYQsdLn+OpJZdRZG+7ShOu5qaKGAPZx9zx7cg3YDxZZF
 b6PJCzzQnpTR2hrAZM88GZfEg1T0Lt1vAIQ97hDX/mWPC9Yk4JxGKZwT8SpdiruJOq7C
 r5vnYsZymCi23qhPyd8qDtkQZFVz0IyZF+C6s7x9UxaIzAmNavlEQUpdrQFAmi53exsZ
 vCUQ==
X-Gm-Message-State: AOJu0Yw/FnRGJpdeVg5CyJufH8Ww7b9D0k8uNGJCiAPu+eNrwqz3ryRz
 9EBahVNQ0tY+ijPks0EOhnswdC0/k8yrD+Cl2Qla6+7pAgORN6+m8bfKPyjCerxi5L0=
X-Gm-Gg: ATEYQzw22/rAE/8DVoCZ41iOlJ3k+zDEMMOJVHAIAhAwsv79ddF0E/DE9CCb34l/9Ww
 XDjdLpn66sPqOf9g82fwuaCMc7+UIo6FLweTAVmO3t4lE49HqVCW1RjJ7dxMN/bsac1aj620MJ6
 3pSLFCmJIOsBGkl7YZzakPZveOJdszNbiQvGnbr0QElEtwC5vmNEo9zTRl/CP02p+dWNjLIfHQ5
 oK/affOO7oERfs9KcCS1bOiEqsaHmnCHPAxWUZgLyMCyHFEtqO1jKJibvarNz0nFBT2dIkyjfCB
 7z7/I/YMKcimDLog/rtoKuhJER4konCDvaf/88BFleuFmn5yq+/FxVIO+b/ABCjB0Ikiwy8+xHP
 dXAaHAeqabbf2WSUU0V3o/vZs289SQ4r9TSY+OCq3HMCVeDMUo82LswziWIgQdUylBxQL5TjBS2
 UVTQnTSkNvxTyrmpq03DBMcbO535tLKPhGxPde7IC3zmJRv36DVnDTzLFudSZyePnBxOyjOqvV6
 G5z46phQH4u75nQvSpVmTM3el8HcLJbdF+41EYwhiMGwctR1dqX0RTWY7X7CdepvNzIdwMwPFs6
 lA==
X-Received: by 2002:a05:600c:1e8c:b0:483:79ad:f3b9 with SMTP id
 5b1f17b1804b1-485567052c3mr58974515e9.28.1773416175559; 
 Fri, 13 Mar 2026 08:36:15 -0700 (PDT)
Received: from p200300ef2f4fc90013ded37855cdb3ca.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48558fd09d8sm55740225e9.7.2026.03.13.08.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:36:14 -0700 (PDT)
Message-ID: <69b42eee.050a0220.281abf.2706@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260313140750.3799-1-always.starving0@gmail.com>
Date: Fri, 13 Mar 2026 15:36:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] fstat: add test for multiple file types
 using fstat
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

Hi!

> Hi,
> 
> fstat() follows symbolic links and reports the type of the target file,
> so it cannot be used to detect S_IFLNK.
> 
> Would it be better to drop the symlink testcase from this test?
> 
> Jinseok.

It doesn't make sense to add a test for a feature that we already know it
can't be tested, so yes, it makes sense to remove this testcase.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
