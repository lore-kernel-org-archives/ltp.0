Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B10BC43211
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782485330; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=G9oral+bXAo0CxseJx1qEADakjl4Tl2oIUjm/GOn9laQFyrXhwnuXw6PfGo8QnV25cG3S
 fy1QuJhogWp0cHLUsmxzG7MI2+3OBhsvh9hQ7bP6g4ReR4PUaWww8JgBzkVyVbxwm7Z3BUW
 ZtYzIaOnC2mCh16M1J4enhCDx7GALxE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B97FB3E4CEE
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 16:48:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A62113E4C1C
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 16:48:29 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4DA76140009C
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 16:48:29 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4631679f204so1218198f8f.0
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782485308; x=1783090108; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=CKBwmjso9MZoWTi36M/USLhgnh+TvxED0cQnLJ1/v3AE71Fi3HV4pi+iWFH6+V6zPO
 43X4rZlikUwMkK1FqpvvAufwbtvRlS7wpz0KVci2k/yOk2vCjNCOEIgFKSsuZyGMYfRy
 xwckcUXFeMc5CV8fEQoPPlFHZwoJRoaU7SL4S2cYNgi4coKw35ywjNRiTRH+K8nMISKg
 gbAxRdcapqN/bDpx3XD44faeNrojjYeNOWrutZTXaO+W0l8xAGfxFsL1jYKV3QE8DG4e
 W+7FV0Xj2XFiaCsP3zhR4gRSNQ2MpInoRGR7bIyaahT6iuqV7GBsRMpt+J2m4TVkOX90
 lKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485308; x=1783090108;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=HjvNJ8Egx5hLj+FjvOxZPEFMpCCYWefS6zjcl3A+PuQARNW6UyiEqqOZZjG6GI+rJp
 t/iYHJfA2v/Z1hoUoOTi4ZxHDWy7Uq7P+SVJ/P2x9e53oVRtgJH/e1eqzGj9QDc9HY75
 mMDJYVuyht1V1/78nzBPHqGmaZfvcJQJ2hoO/VSVI6TqtDyNAmNaoWtY1vjgt4fTg62B
 MSSaGlvfQThQ5bn8QAvZDzMPL3OPWQTPHGtuTeqvBkTW5piCmpVfnA9Ucv5uz+aPpdk0
 iMDyX88ZrQwtlmaMFEd5DyV5opnAIDdlfAWm9rCO59FXi1i5idM1EdNP2moggF1ZJkdl
 JHfw==
X-Gm-Message-State: AOJu0Yx18nSBnA8fmYCH1H7y0Gpc8C5AJmrj19CF6rwKAyngG/cqgEox
 YxU7x4hLZ6/uQzA8wfhALYNc2rKEaA8Nvyx/EWB38X5M8svwF68ijOrkPk8B0etGNi5eE39VOFh
 thpbTQJeZ8g==
X-Gm-Gg: AfdE7cnqJ0D7ugAeY+W5G2c7OUL26K2EFia3I6D7RblCinJXkLfiBMHaR7MNuCDuJrP
 cu/JQuw7dP6YYL62t3rSgjYnowiLUx/OoUgKXYJUU8mT9k2xZCMGXWbRAox7FNsAZ/CWTdT+7ju
 KSVuOqimtYPrfiLeE+wCIL0uAa7zW6y5l20aRTLg3pGqv1kcXfipr2WeAg3HFJl9qMTiQAdvcNi
 4ZWwKK5gv3K4vLJAoSgJDjqKMPLj4BOTpYF4kf64GSseIUxi3soOlygSTkZzm9jttTn6jQSVp/t
 GjVwZIdMmtqHfb21Xh/TQu8WI9a4mT5I8EmOhO+Q2FXCdG3VgfaTSwPLtTIgUtevkUoMhPgsbBT
 lwJ72nUiBiLuaDyk12cIJAfkOpeJ6R3garKgVxMB0IA1pnRdy8oNd3e48QwJG4hAVgoF6UaEz3v
 kNA1LLBad7/taqRd3vYxMZODO9S77MwWmc5unZ0UeKqdM0f0/MFsdKSlUOh4GNCA==
X-Received: by 2002:a05:6000:2286:b0:461:a15f:7aa5 with SMTP id
 ffacd0b85a97d-46da9ad143emr10977190f8f.21.1782485308534; 
 Fri, 26 Jun 2026 07:48:28 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm26753345f8f.29.2026.06.26.07.48.28
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:48:28 -0700 (PDT)
Message-ID: <6a3e913c.159d33f9.1ebc0d.c488@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260623195000.110648-1-avinesh.kumar@suse.com>
Date: Fri, 26 Jun 2026 14:48:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sendfile09: skip on native 32-bit kernels
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
