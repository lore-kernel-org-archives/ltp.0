Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB0CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781790318; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=qnSmAgkveN0vSRR/7Gv9xpDQnCunUF7635HmgeS7sdE=;
 b=PC0qBnp2wB6lAfYeCsuNGi4m+mBsS6tND3VVb4kUSpUq1kRAYAw654FVkLLsWAKtbk//F
 MM2kOIXb9j6e12WAJs6dhM9AOiXCaL4V2stLiC0vUDnEloQ/bOqg2Qsipps+q+hHGGWBt51
 FiTITL222KzubWOujYO+mzxRzHcMzJo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326F43E5880
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 15:45:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506A73C741F
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:44:56 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC3A82009C8
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:44:55 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-462342ac290so1122089f8f.2
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781790295; x=1782395095; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=scnpZUn6U0Dug3JpIFrCelvmHJa6eZpSVJVp9gPrJ9A=;
 b=OsOO9KKdzVvh3eTL+BfR2VnXf7G8kJBnDSqYAlGId13+szq+sPg2J+UDSaaX8CLQnX
 B57i3eSOGMqOu36mmWbQ7Jz2ETLyiS9Kv8O7MIla3FVw0iNFumHqDzxACQzqReqduKYN
 R7e4JO3hGSQNUzD4Qf7R3d7y7YMIBuBolUEEOooNYQWmnkXGxw15PozuUCBTNPLJrCHq
 Uov7o9jbMa5pwpI4TYJ6wTC8uKFJIRpCvle8xSfIYCL86w8MU1FLCZ/rVsQIxfeKNNyF
 M938rp+wZOWWEi/cVsoagF4GPUfL1qjA0EFwju9pH5kdgMp12UlKcGgcic4OttwnmaVy
 mb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790295; x=1782395095;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scnpZUn6U0Dug3JpIFrCelvmHJa6eZpSVJVp9gPrJ9A=;
 b=I1lnR/fnhJNl6GblwFK2jpRGo+t9sXzKNY/svLcd4ygpKVHrYLvT+vGc0SRI9d96UL
 rTdS6MlzqnxXrVALC8/12P90aPiAyTSfC4kqs8pPmHsbrqPT9NrJsbxrQ62IWC7djnLe
 cCJ3F7gSVM7rYrtkRWhb4C48K9hBo24Wzgz2tzTKB3QABRValFugOglLP9TiUUseNMTT
 NHx5jVjBS+plN1fTAvqA155/ceHSUasgQM01GIExkF3s/B0FvijC+UAWni9gEJOhqBEl
 44v6Q0hUT9ss87ud/9pkf252xoBhshgMje4xxPkC6IlTlIa5+zFb71fWx+akKuriR1wP
 MyBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jk/CK8WtdJu6CtINBMJpWqNOM/jCzGoGICZhD8H2VCR7hGU9E16aF1mtCGQ8f/0WJlI4=@lists.linux.it
X-Gm-Message-State: AOJu0YxO4TnTnRkChmXGI7iIdQd1PCU+iuzXTd49zzbPuWcn6ve2VTwb
 YiVpP7KB8QmOnEKj6LoAO23YExM5wNvgdqnl/aEuckBYCaHYASbQRd4PcwObW5L00xg=
X-Gm-Gg: AfdE7cngz6cDx5HccvwQGgxxKwdEKzZUsZgNeRph0608zAOSUTewT9Qyg8uCucG5Gyb
 ULWjrtX4hZYh7/IIEjMcGexXYhwO5eJ+AZ7pqu03Grgb0Y7eWQNZQgmfHte9rVG/LU0A09Xtenc
 gykcf6c90uld4lEJzcXV4tmYyGd3NpnTXARmz+lJz3VVRunUAfm7XXPXOfgzKqD8Am0ElfRV5Pv
 EPCp8R1JMKW100DubtJb87tYLr1WyArYdoe3rO4e1PZy+auAROjXJrlHzAKZ6sSOk5sNH1aWZb2
 v+DN9QMJXiRqM5vcyy1ES2ulzNEBNFVLiRww9yc2Hpsieher8It+bd1Q23yAsl/lgkWrMg9F8qm
 ufUI82VisSIFZfHsuYxfYyH25LegH4FCmtjQzXshUXIRvu9xLqnbuwGyzoD7aOSdcXFQ5zZo+QB
 1LeAILmKD9mzPhTgva83WRVpwKnJk529vTAwjP4wLxa/zltB6T0n3o8s7MShq9Tg==
X-Received: by 2002:a5d:5d86:0:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-462415ad9f7mr13106687f8f.34.1781790295204; 
 Thu, 18 Jun 2026 06:44:55 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm58453447f8f.14.2026.06.18.06.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:44:54 -0700 (PDT)
Message-ID: <6a33f656.283787d8.2dd2f2.4e3e@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajP187rd7nSV-Krv@yuki.lan>
Date: Thu, 18 Jun 2026 13:44:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metadata: add tests grouping support
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> @groups foo1 foo2 foo3
> @groups bar1 bar2 bar3
> 
> That would allow us to write reasonably short lines and limit the number
> of lines to a reasonable number as well.

That makes sense yes

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
