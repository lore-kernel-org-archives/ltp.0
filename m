Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA6ACD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781784290; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KuJDLqKoRDRoqBGJI//RCDor5fQM6HZWvmvWIW5Kcww=;
 b=SZWJU8ZtlZIxVAchKPJbGnnxtsPsmyNQB5rwBecP4sJfZhaL5q4G6V4exWthXJ35BUpli
 SmY47Duzf4YWaH2lC1jS45jFGkZ326tiQMpR58uNCzKbgclP2tDVhaZiyehn/Tb30Q6F+Ll
 A9IJp2sd0MynnDhokD2iDt8gMS8gZhE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B439F3E5880
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:04:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ED4E3C0528
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 14:04:30 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B200A60071C
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 14:04:29 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4631679f204so848241f8f.0
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781784269; x=1782389069; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OrdPA13+PMMQD+yceWwXJOFea9mhDXrvdaXeMR4aHTs=;
 b=CCjWzcP5gXCS/qQQQQGkgDyfzE+GDKQk8g1JNeFTTqNYBJ1JfoJsldcnBnNw+ZFEL2
 TYb5h7PvTXeDmOgCp46yuD2JvvOR6U/6e1dd5bXtBUAIGUrV+PepgLNVRUvjLgLyQV4L
 axRp2oj2RYUIxD3BFIYSnbfwio3VMBv3NmYe6R/jtMKIIkn9m/EUhwh0lytaF3J0v/vU
 VYA2Mil3xw0Ev4OE6k5VinUFqCLsN6OqLfpHVrS6F7afJ7RierMvObyZ2SbZH5EJhjbr
 5B8Xa51gJ5kPCcxJ7wg2s/+yEY4PYKcuDI8KpAWFrrisoxembyXej0ektUA5Ag9hGQmG
 YawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781784269; x=1782389069;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrdPA13+PMMQD+yceWwXJOFea9mhDXrvdaXeMR4aHTs=;
 b=g620nvpQJSGZQUPIv6tWPZM+HaHeYHUaPSWgNJHB0BRA/YsFdh6kaAbswz5dkzTicQ
 yfScx2EoBBSMUdcv5DlvEnylYcF2yIECJ0GZEaPpXmRsx4pH7RiCfZUYU6/q/3KOUbkS
 lxmzwhEcBFCBlrwFQtCgeGE0VjsV/FSRSax4CaI4jND1E+gxCiJGiSDB+CFV3y4L3wIp
 8YP4w8IUCKCt/L9IBC/lYon2oxFAoGNC4K7FskeJBQuyB/NYM2NWM1HEyp0H5s9RXA6y
 89N53sONivt+BWfanybJg7Q7mRm/+w3aDrMsAC/30yM2MOgSKxSrOGz2w+Fy1Wa/t0yy
 HLoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uQeS8kZlPXgcUh8GTP5iJTbVlvenoCkafVlTPqpveJuDWDQqvxhsxwV38fcUQfDL08OU=@lists.linux.it
X-Gm-Message-State: AOJu0YwZfUAt42urS0t93yHJyHkcTHi1/pqBqSUkXmPxGynoQEv57bxJ
 F/aYrcVOvC0TVvpj1jO/jcFfCGa6i6enB8YGFK+eoQC/0eozFF/mokOPcFvht6+bVjU0xixchgJ
 VGCYFj58=
X-Gm-Gg: AfdE7cmdilPNTc3ArUptDTnSlPxallCofzH852WqBP1tOX1fF51F8WMrklPt1M1VYU+
 20rj0gTj35TjgeAtOsgXEKm7Jgy3XQANldcKyKUvobGnRXMqZfuxwMuhhowuJmP3S4jN91YHzgn
 hjx0CZqJCt0FJldui8uWEG7sv5UKLlthTcfTsDtEHbJjOj21u9+Gs7DXM4xegM5EwNTQtiuifZo
 xGJI00p2XJjLNsa3c0Yyn0++fdNG79wnPwKcWMvXnzuPpMY5o8mWwe41uGcvuPJ/6c8MjBeMZhF
 sTSksaMlZY7bn99TJJhr74jOuBUoo7gkvmXKo9EMdtbe3A5rDuycHLEkdo98W+TejsV79cj1Ue0
 ABb8HJgvvTi1bnBX3d402uC8qYEgH+749IgQBAbdbUpXS1G8+uPKgh+6KdORIWv1DAdjlH/EAA+
 Ig+37tpWlROVeAxV2ypbpdyXK8+Xp6fF2lKjcsAEkvp+OL5tK6NZUXZ7KtDhTBww==
X-Received: by 2002:a05:6000:2892:b0:453:9897:76aa with SMTP id
 ffacd0b85a97d-4639881b261mr5389836f8f.21.1781784268994; 
 Thu, 18 Jun 2026 05:04:28 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3dcsm58879077f8f.13.2026.06.18.05.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 05:04:28 -0700 (PDT)
Message-ID: <6a33decc.06c236eb.d871.078d@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <ajPcMQprnR4HJfAi@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Thu, 18 Jun 2026 12:04:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

Hi Jan,

> Hi Andrea,
> 
> just to add some context: the regression itself was on the kernel side.
> The relevant upstream patch is
> https://lore.kernel.org/all/20260603131950.321858-1-japo@linux.ibm.com/.
> My understanding is that the kernel-side change did not resolve the issue
> for the LTP test suite, and that there was also a separate LTP-relevant
> aspect for exfat swapfiles, where actual data writes are required before
> swapon() succeeds.

Sorry, I forgot to properly reply to this email.

Today I sent a patch to fix the kernel, you can take a look at it here:
https://lore.kernel.org/all/20260618-exfat_swap_activate-v1-1-4c6a465df295@suse.com/

This patch should fix the issue, let me know if you are still seeing a
failure in the LTP tests after applying it.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
