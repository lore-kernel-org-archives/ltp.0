Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA5E9E301
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770814118; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lxcO4dNGOqPGPN4oMXKeRYOTIruV3COfE4/jByITsdQ=;
 b=VtQ2+mHjvNBaviGOv+Jg3q3ZzXnvrz0S1Zk2ZOiDbioJRjOow60tfzb6HAuLMQi/S0JKd
 kro772/6SDLJUQ/w0ZGotnB+JoE7pFMENkEJ9Id8buRqzwLshs9AESmCc/UQIhLjo3EhDoF
 jk+RlWmthJRy1nCjsp2h+zyvZhMUnsk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC31A3CE229
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 13:48:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FC23CE229
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:48:14 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CCDA91A00A30
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:48:13 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso8346795e9.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 04:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770814093; x=1771418893; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PjxjkqoGq6Yvr26Uu+ZLJ4xolB+CSCV9r35W6eCTrA=;
 b=PNKx6YuqpjgcWcXeA2mYSEO80JQMkz7hqGuEMifYeXecUoyB8bnZ7ONU62FlyR+bY6
 ghla9cHkW5FzhRtr8vzmriP9coZEYvoB3X+Q972gF7le+iCP8z2dpwKPI2Mq1JVZrsys
 7t8TopHi7QTgUX+BfmMdQmCBfS4jNTj0lJDpA/BsHsr/vWia0FzWyUCzUai2cACn3Wyb
 oW9ATteTBKHU46VOuU5G1zmY/CPI6tOySZmyZDe2KIP/VZRjg2loBIR00ivkIhnIMWND
 LF3k123PEGXr5ROwTr6HgRcyUk5pXpTI934xIvEqldZh9EQPhyFsqXRrB/hOpdiXJmre
 zKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770814093; x=1771418893;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0PjxjkqoGq6Yvr26Uu+ZLJ4xolB+CSCV9r35W6eCTrA=;
 b=TH9uv6LZV67KBDS4+MYDurZqZlkYd2+vdR2CQixfwpptHsu0w4LlivHeIj3Uy0Qh+U
 c7Z75IMMRdf4uU/CXwHTvSwPXpevFclUsb5faghZRwlbex/LqAKntrxjcwYz2ehGzyyr
 IvNDGEGflK7EHeStyiBN4fD511LQJyaZvdSc2R63B96o4HTPzy96J/jY0jM308SxYtOf
 V5M6QDsM9kxh02bphyoqlDY3QbfYaDVNrfLExUV3csNCK6ISD0v0o/XFoK0/nF9H9TcP
 EQ5YqL23sgT25EKG9AqFL+zDqPKEZ9yryiACsSacAsvzrOrO+lvPf8SpTseeyy0sevEf
 QWAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWCRszarEeYQvxIaL0bTUWMnEeR6PoJAGzrVLjI7ty35C9EEgsbM0bpcElD5dEEuPYBGc=@lists.linux.it
X-Gm-Message-State: AOJu0YxWz3KIz1uUtXzaQ9r59+jjqT9EiQXGIaSAN4ZVqWko07JZzyqq
 D6hN7rsQfkVVKYWlng36jw7UDFMVS48El18TpdNNfwYzZlJQFTIPBRidWSHc5xvtzV59khwsjjR
 bagTWMLs=
X-Gm-Gg: AZuq6aJbFpXO7PgEz43ZNqy2JdQWEpjthkMKNiRAPrHAFnEntafmoOxoDQcvtW3Tq5+
 RE5UOSsSzc9SYAQ50eRgdhf3gE8C7c3zEArB9eKrp+PYvIpZffOZblbhYmArEc/Yo51BOJR8KwR
 dKvMdSmVIKkscqRrZRnJOjcK63+ZPMyESbzYkjrN74TTDNO/qGHRtxvnbSzK75uLqDk/Or3FSxY
 2xiXPZWLP9lOwtOXUEX56oaC0TIQuLcgV6csZCigsPlpdkMZix4rJH/5FhZnEZ5P1hVP91BTrGC
 DrheBQO3P3h3Ws3GLjUejkdfQoKfYR5XSnEip8iMrZ/hM6LUYhuC4hvlVA3WeBzoRDqNNGQEkJT
 elTKKgfbEt9SjipfxdkOh0/LvlcVtpHfPOOdsGsJYzT+sXcziFyFAI8qVdXqX72vZQspX0BTdVz
 csnmm2SwRucC5Hm2aW3XlVWbvg9k8=
X-Received: by 2002:a05:600c:6c5:b0:47e:e48f:43b5 with SMTP id
 5b1f17b1804b1-4834ffb25fdmr50773235e9.18.1770814093110; 
 Wed, 11 Feb 2026 04:48:13 -0800 (PST)
Received: from localhost ([37.162.249.193]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a627147sm20671155e9.3.2026.02.11.04.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 04:48:12 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 13:48:10 +0100
Message-Id: <DGC57EJ5ML0P.1QXZU4BD77ITM@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260203125029.15413-1-mdoucha@suse.cz>
 <20260203125029.15413-3-mdoucha@suse.cz>
In-Reply-To: <20260203125029.15413-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix/aio_cancel: Use setup helper
 functions in tests 5 and 7
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

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
