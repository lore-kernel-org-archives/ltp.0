Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8977CCD98C7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781165113; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=IQQ5Sv1KDhyhPzf1mPRvbpDE4iRPfhlZ+B2qIpxXP0VlnK8xi9pRu/+BVmtIHNrgKdjtN
 NF3rI5jXtgxN92tD6d94UCsId8OlKFC6eZDQxFMDIMtZxqCgOU93mAWw30tsoUKqWkbbG5l
 uVmaX4nfu1FlCldfDvJec79fva04P5g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E96183CCEAA
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 10:05:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7A6E3C0354
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 10:04:53 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A499A600041
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 10:04:52 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so61725425e9.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781165092; x=1781769892; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=I6XsB02P0IOTvZ5bJ6647zrNUJCXMRVAaEJlubjC2zsWwJLYtYzW102KqR4Uza4Lur
 D97/6kYcrnIwJ3DyAWoKK0u2mRsKvuW3o67WaM9/38lXVGCuNqwxiC5bQB6n9xXc8M6T
 TboLLemq6qYJOKqd4OqxEiu0lIPg79azqij1485Va+uAy7jSuxKBxCVFi+7XtWNu5FKn
 chzfM+Xa8908/aDj/a96b/ul5kc4Nk0UHOZ8a9dR78sreNw3tM/5rv0ETTtKO79HNG8l
 9QjmnLXjdn+2ld6zNwNGgRNzrZa+5jm3I4EF48D+gwz1QziSp8jjiw5u7NYXUtbAFveq
 N1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781165092; x=1781769892;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SZpscqFz4ysviml0juwSOfm0OH0k17qYBLQNZ5CcztqqhYbusJ+Rbo8DuNI3/esYl+
 u3duY6nrK9wQyLpC8uudW6pfxyk+S/gjQb2EcOy1dkf3H/QUYOHBK3+JMS8sqgmc6aTC
 /h4fG5aNCgs3tTyn0wjtRibhnk7AJQA8MEaN7hAHETJktx5uFphqeUTakN78wlG1REMJ
 x2gpM0g3kjZgXbrxd20cXDKy2V/PjzB6BtD7cX9dQOzVd0gZ3vWYcJWBcxu2iuk4wEja
 keST7ZUzywLQC4DfWD3x1xng3Ic3jGoxuzrx35443mYOYHZ25JC6F6ozjiC16SPkdiea
 8OtA==
X-Gm-Message-State: AOJu0YxtTjGpXQ4rP557WVQdBAES5DvSqQAGm5MbukOULn0usBnBIGqe
 erTJUqoNpn8R92cbm7ff46gbDdJLN3DpiuYjOM7r2MEJGyopZnvOtc8JSJq/21/ofy3fDHaOZIG
 HadcRGLs=
X-Gm-Gg: Acq92OEeyAQPSOQ3gEZGEizcwoyrdh7r3Vc7pYeRUkdesyijJLf1RVIpy8DgEICsUhD
 5yxsDbrFrD7IsY4i6dM8u/ghADXgTTRuMijYDcRi5aSLakzo8DSMKk3ehuKZVFRLAMAYrZtOpPP
 fQvjjFajTNxxMfdLqhEoBkDXM1NapIj0kEbxtPGacyXuCtFgVXm/NVBKjmidotxL78uaMczsDM6
 OV5SsEb4U2fIb9N8nkeeKtphQmIqhe6Ur++4zMxMlcKvlrK3dz1IW4K3Q0Sq8D4nWT3w43LbtPX
 Or3dtauPjXG7PI60YusRsNd4anqp0lTWVwzqxOkjwqgzrq6wkNEK/yMC3TuD5+eZYjanlJA5qKW
 jcWQ+v5/gSKJ+uqZ6NX0iu2UCqzwYsXu5dvhClYcyiFKV8ao8Zk9OYOPE/G5jONVelS1aGCL08P
 swTi5ZSqGqcdr2U+rwuaIb9lDSpdRt2hPSO+3CrjiKJtsqOZvlTfaMKZDow1jv0tLLRrIPEbIHz
 WO5+uh9YCTlj0UP/8xbeac0oEwLIIugkJXEvXueO+C73A==
X-Received: by 2002:a05:600c:c87:b0:490:b58b:a4a5 with SMTP id
 5b1f17b1804b1-490e5622250mr19304935e9.31.1781165092034; 
 Thu, 11 Jun 2026 01:04:52 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e44ba907sm32128965e9.1.2026.06.11.01.04.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 01:04:51 -0700 (PDT)
Message-ID: <6a2a6c23.3dabba3e.175af1.6b0c@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260509073921.8487-1-wegao@suse.com>
Date: Thu, 11 Jun 2026 08:04:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pthread_detach_1-2: Fix failure on modern glibc
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
