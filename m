Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015D2C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784102831; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=gk0B8iJxG5II09at9OonipVsGD3/Srnro3D+yUYx6jD269HLbggF3uR9JF5+Ou5RrNyjE
 l1dNdz711YOqbB2KPG7wxahs6w+HsC67COMb6B3HkmKIE8sk02//MTxq7nplHJbyU5aI3vQ
 SWBxSnK4qFRKlok7QII4LXCxz08amTY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 079AA3E5654
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 10:07:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 013EE3E1E71
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 10:06:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE9CD1A00163
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 10:06:48 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so1857805e9.2
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784102808; x=1784707608; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=A00YlZrgfP/U7UNnh1BKEiKlk2CXGelD7836ptTQCZ/0S322j9/WNFwhDes2UqgCvA
 /WIqJr2fxf6Kxh+qydce28QCYHr1ZNllonal+owYN9cpuZk4mkwQkZP4bQUKtYqxyTL+
 j4GJh9jcimFaBeBzi4X2Q1QrdPu4+zTA3YePh471n/oAm6KCze/NWZs5XVWvZ7wtPXWP
 uMn7M3NGJffycNcJZDgPbcI2r1e70k86vr7Yy/UrG6uh1m4vEfabQDt+fVLa1tYZ8MDE
 oyjIgLsX3EiC3KN8QZYoK+qcAvHK2OfNdRoXlouac11oFts38FqCyTKsgSJboIO3SkvE
 0eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784102808; x=1784707608;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=UokPRpleOWzmfYE5AxHQDL14anSOwhNQkyl37Dj4jUqlqiPOAF/8robY/RT9pcU+aG
 9pxpYTNMc2rBJja3sx4k87loyNtzKjI3tpW9Lavg6RLcOW9EojxtbqsHVxBgwB2yKChd
 JFfcMQ5ERrUCAnwz+KesU0lDJp0pIHqBGtl1T4ZE5zdI67FgtObjqlWWpvoA1LLEkFO/
 xiQv8mE61+fw7eqiAHqnXZm2uVZl5GG2yzNiI/SZ6kDeqJ1VMgwYafdWR6ZjP1h8geGk
 VsfdlgKtaVPLFiEUSo/a1JEXhbq87JmVwEoVX3e+XBi14ZY5vgj2Tg+7cAi48h2Thh55
 XwTg==
X-Gm-Message-State: AOJu0YwlFCL3/wu9qOlrHMSZEP5xZHNVQ2XIjBPRCK+ii1ooC0C1C13c
 UYJ0TL03f9NRB3ABM/lDLG/7qrXwxiwnX36SBIPuwcG8gtfO5dzlskAqkD96Gff3vWM=
X-Gm-Gg: AfdE7ckqygd0x6FK2h3NaFxjw8VYNbbipc/KzgEeXCjaJp9XiXw6ZK0u7a/yInvjfe5
 kq/GNHqf1KgjrEDl7GBq0gDFyJDAtxVwPwWi1HdDRIX/fK0n143MZqyNZ11ycy0isrIWN0+Xql3
 uMbLJZ3juzyeAnavLDugYCOSQQVnY13CcS/ryKG0Ld+WrD1M8dOY9vXvVlP1n13y2HRXZP3qP3u
 CAkUFKf0HipISEuWs9BgJtPZhOgjsS0FNfdPmcZLIP4CRtMOraJSQp75SBLrVWG+XWaH51NOs2U
 gcTzH2YcUY8rWSeK51Sxyj2Mym5nkU4dgkO07+ECjic2IKY8C1+GQIYM2unhSOXGKlJ0iALNG4K
 Bh+Hz46AvLQQk3kGvXjrlI48+herqJ894msVkRqPaSIrTUPwRPicD1shkTRlU6xCuFMGxthGFjQ
 7LO1mYWySSNAH2zyQ/a4n6EoyyfRk//mkTfX8S
X-Received: by 2002:a05:600c:a111:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-493f881d11amr136945265e9.25.1784102808146; 
 Wed, 15 Jul 2026 01:06:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950871d1bdsm134578215e9.1.2026.07.15.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:06:47 -0700 (PDT)
Message-ID: <6a573f97.48ddc8f2.52c69.fb6d@mx.google.com>
To: "Gang Yan" <gang.yan@linux.dev>
In-Reply-To: <20260715075850.66118-1-gang.yan@linux.dev>
Date: Wed, 15 Jul 2026 08:06:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] loongarch64.in: add memfd_secret syscall
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
Cc: Gang Yan <yangang@kylinos.cn>, ltp@lists.linux.it
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
