Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5D1CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780643871; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZVNj/hJXxnS8elPUxOxudOY4j4vwkTIBnj7Eqfzd4SY=;
 b=lDNB4Fn2qtMxtgf19Y6SKUAy3q+ggBF3CtNvwDcDHe0j378a2BpJARQn6cqTTFm7gzZHL
 ZkDymUoXXZR1INBPcCmmC+W7O+BtHIijjHkcAgxS+dVzpU5D9dtKr9ggItlCRABGgerLjLO
 JnR4c03HSQnEfWYQ55GY/fbvPhIYdhs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826DC3E3019
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:17:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E74E3CDDD0
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:17:32 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E52D1400DBE
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:17:31 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so12293045e9.0
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780643850; x=1781248650; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RuEM2nJlzPzaRWq9VM1JPzqUI7cOKCKWsLxpDsaeTAk=;
 b=UCrBFVZFn7Z3gdXOMJNKorvQ6EBWiWThydKBahdY0jSRGSKtXZmH15yCbTSvQ/c1PP
 rt4UJzqp90CNuErhuEZGOy+jZgWEaX/JJo5UOy7Uhr5OY7Bl/3H86U2mnKBRaJPkq3Z+
 Rvzfw58+8D0y6uX95KX3Qok+uXk7By3gL1cgtg8CmlwLLVMuUJ0MqvHVemo2jrFXTuxY
 3IHYGIpFN41AlWpGMD8TiaUT5/5XwK6bWe8+e25e73jl0M1EnB5A2kciN1XwXP+ychm5
 yi5+QhQNnICQ9Sr0y7NtaDsB6tj71V0h2hjdxajlzUOHY0zq47g2BkWpp53Omu7b41PW
 1ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780643850; x=1781248650;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuEM2nJlzPzaRWq9VM1JPzqUI7cOKCKWsLxpDsaeTAk=;
 b=IN04rjPOkYlJLhz6XOEozMDlGhm+meKPYV+uJc4EUIFq5UNBP+XNCvcGXWTfC02xh5
 OB89bc+9on9EboEsM0VK1GzhmgcOg7Nxt4ZfcZ9vrvW5wyxZlpSArl7tpy35yV7X5zJe
 7EOwM44rXuLqjMWmtdKvnxrnYLR1eOWHZHzSvZUYVMg8bBXT/gArwkWVVyz7cxmA490T
 R4BXmpLeqT7JTPjBK6XJl2HJfLFCCuYWe9gwq0BeVG8MD0/i+e+bZxZRVN0M9tTi6rC+
 cEJW5C2fpGFo+Wjl7rq4S/umR96uYnfZeKTlknQwFXIwGSsUIOSTS1lnMMuyxcIhxmxG
 9KxA==
X-Gm-Message-State: AOJu0YztZWir1KB9aJluGBMIagtm6N4JDNboqgW0vjqWkOBoYQCWVFT0
 6Mn4KFOe8hPoruMHmgxONwVxH9vZg686R9tKpuO+DdPN+NwyZdax1KCf1TYetdkoIHU=
X-Gm-Gg: Acq92OGLTkyY+5in/WR0WBBo9xuYEI9Eca5W9DqSyesA1lrX74xsGsAZy4pnG2JY8Dm
 7VvK5LFE9R/nFXX8yWvCNz0W9r67DiFWDsY+0zQypa3U09qEFAu9WkkmDqASbpWe/Or6RTh433v
 jVc43AZgav1Kat9cnmGa/4OaT64+76Gg1jaXCr8NGaxfdSu/xWNkjxOt4VDHxxXyDhk3tN46PYb
 +UuhDLNiqlh2/EybkeakDaNSUnVu5xwtzbKA8jqfbkdHT2KhWjT6Dy0PFwTdnHnUsSgUvAEp1W1
 7DXLONJTBf3cxML/rgTiCSUV6WElA0GyL+ZQXt0RzqcUAnlTORF4pYo4FzufDbxgMr87WhppI4z
 YTXu1uYVLFvTYI8I0XJsXGfWylEBpgyqVRPZXut7Pig6Jp9SOHxAJN2EK8ybUzxL8bTXnnE3qw9
 uIn2gH2lyLDjYQfbv3D5aF7KgH1bip4sz4rRN5yA7Hy7mRfFkjof6FM89q1Q==
X-Received: by 2002:a05:600c:8b6e:b0:490:9d1b:f05c with SMTP id
 5b1f17b1804b1-490c261746bmr30656385e9.33.1780643850503; 
 Fri, 05 Jun 2026 00:17:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc391aaasm153364975e9.1.2026.06.05.00.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 00:17:30 -0700 (PDT)
Message-ID: <6a22780a.a05553f2.14c34d.8596@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260605042942.30480-1-wegao@suse.com>
Date: Fri, 05 Jun 2026 07:17:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Convert to new API
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

Hi Wei,

did you use the ltp-convert skill from the agent to generate the first
draft? If you have any suggestion please let me know, so we can fine
tuning the configuration to make it more accurate.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
