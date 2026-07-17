Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B55C44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784272131; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=WhM/JVTYuotShL6NZIkk46LjKB3fHJ/MGC2dDXNgCTVOmBA7DWX6hbTS4AJsJRpV/raDW
 xHQgREHobaqReDzK7/MrOiDninaO0CE0IsDC6aQuAi5rFaGvwP77/foRjUUoZPdVRq8rLeE
 t6Hp/YogK+j+p6urj+QwyY2QRJDFApk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A6DB3E24F4
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:08:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 936A53E24D6
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:08:30 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F03EE1000A04
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:08:29 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso970235e9.3
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 00:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784272109; x=1784876909; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=LCKwBurqbhevmPrkl8Wcz0opgP/RnwZlp/jcTCGFsnafWQJNmEKY0u6q2ZE04dCsWN
 Dp1te3SQeDqUuQ2M9byssJipzPCp3bxFd7z4XM8CIGkOBU5l96dKL3chW/OLLeaN+iaH
 L6NQWfMYdqDphz2yHG0gDXUUnd/pN4fYkg6JjXCIUaszURStyDte7lueB5l2CRI1hQYu
 CAIUAl0c+vevU+DgY28eh8xtHg4swdH3gXuLXxs773EZcTa36tkUdolFIpuM8luIMWnD
 f3Ifg9nZ+e3YT69C+LgNPA4vMC6f4SRc7nBDu9/sIOj44iL6B8E10g5RBTTaTKeKD+QR
 zdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784272109; x=1784876909;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=UJyf2mkv9HI7UHED2paDh1+pCFlIXu8A2n3O4tAfF6t9et0nUXrdnEn6mWOd1A0AEz
 e474Ks+nvHRlpyezO1OZr8SO4PcXlR85j+j26MrIu7e9RBFOKocOL5vGAyWeViTFa6ZW
 3yKn7Ae0NB5sob+/Scw5oH13nKwWwLsAcmd19GKXGblVNBFy8SmlQmQ7DRrTuziKc4fa
 32qv3qjR1uEsTFhxLNbbz0gRWQb7Xx9qRxY8mumSJV9iAkGHrkDgRYIKSGoijFGAqtQU
 CNo+PpNPgnWKpJbH2rJX5/W2Yii3wAAlswEGqiM9k0oVRBTps4X6hk5J9Bu6JkwknEWy
 +Qaw==
X-Gm-Message-State: AOJu0Yy90LXWq2TdgbhHFHqcQ92q40VSxsWx7lX50Avbvnz7wT4d1e1W
 oIbKkd4HDtphuT2nqtN4E8dZFdR11kYQOGdFIZ/7m1rGlN/UrdWHpGYn4KvCi/cyWIbcl/3yr1e
 GmEbjs95Gyw==
X-Gm-Gg: AfdE7ckFjor/9uI80eUulMg9TKcq2ftWuXl510B3MPbZLjgV7DwZ4q0QHsy7qbBkNEf
 deGMh1s++VBQnxb0w1TKYu1iQoBtpg1RvvS8azjIUM+NEA5YqjJyhTJ4ZXpcPzxqSGnXle/pLk+
 rt+HZjdhJ5Bt5wYjnm/y4GbLtpi/JtlvWjWthBdSbMlgoBhqBXWVHDPGHuhdfDGgN6KmZdqie0p
 1Hzf+pcj/DVZFiUabpIv9fPGfwqQNcGcf6pbWf6Po0X3eJ7i74/uGvpPWdkuKjgRcMs4XWcskOX
 Ag65Z+VEF7YHdAYl6FiziGkg9FJ4LJFlknI2b+RLAnpmpGGTRK6gUuFNwvMxvZt7hjUED5DjLAN
 TltaDYNjY/A4scmJGa8UnGXz/CkIB0LEqGYFqJ4mtw0mosG5GZRmuiP35BqZGkJEN0YyPJVmi2k
 X5C8gDaU8q1LRTGKSnaFXVH7BMbg==
X-Received: by 2002:a05:600c:c055:b0:493:bcef:5646 with SMTP id
 5b1f17b1804b1-4954a3dcbb9mr8496625e9.12.1784272109020; 
 Fri, 17 Jul 2026 00:08:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c96fecsm31460905e9.11.2026.07.17.00.08.28
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 00:08:28 -0700 (PDT)
Message-ID: <6a59d4ec.87c5160c.c54f3.9833@mx.google.com>
To: "Benjamin Wheeler via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260714162834.47191-1-benjamin.wheeler@canonical.com>
Date: Fri, 17 Jul 2026 07:08:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] cpuhotplug03.sh: Poll for CPU migration
 instead of sleeping
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
