Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A32CCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A123E65B4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:33:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77D813E57BC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:32:57 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03F771400192
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:32:57 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50e5dbd8e0eso6686151cf.1
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777545176; x=1778149976; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kzg4eH0RSZWDyhwCdx7kC6MQRlRAtmglx6G5JTjXz6E=;
 b=VFEFX/eFTZDBIpnkrVFsjucNT2BfOz6nv5x72iEAN8Ivmd4zjbiQgrFGvze4XLw3iv
 3HpxXnJ7XY2R7/0uH3clpgnDH3d5/O8uWL5bA0DovwIkBefOQ2m4CQMgBwUnoK2bgeg1
 T9+zMQxh0N6eP7HbwigBA3pG5aXjplGLCuyTGfLpYCOUov78Gw984rcmqMtpFIlCI0Bj
 BGfEqnpC2Vb3wyhT+bKROVl5u16tNswPGdTH3rBYAF439uU6B+cAmm6ZCZF/1PDNlWNy
 B08MWjMYMDIv8Jk7rAdSQTzMGLk5LBHJ5HaghoIRcip2UOEwKE/aHhpDGoLMGcpekb6Q
 4KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545176; x=1778149976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kzg4eH0RSZWDyhwCdx7kC6MQRlRAtmglx6G5JTjXz6E=;
 b=M/6yvWCEAOUDsGT5FxeglIb7WeaDWAxx/Ek8LOxAHEuRxwBSS5FtUCBHaqTpIL8qOn
 o26jTcIpz20AuBlGyAJi5SkZ2iuZIaTXQ/1cGQWdunhQfD3BwKEyDXc2TiS3ihhHKt8B
 jei23KRy55J3J8GFf27PeCzqT2UIThosCmaZbbpw8kcXNra1mydd3hRMFP1AZmAWxr4t
 8wP7U+MUP+/m2blpWdIYZV7f+z59TLWWGXy7CIIVw5++9dTHryG1SVQzh+7VW9yIfADL
 RHFqn29JyECmvgQnYnHBfDrjskvjfeQ1ciNMd18I9zGq2luZ8qxbQsPCYTRo8XgFbJYH
 G6hQ==
X-Gm-Message-State: AOJu0Yyfl184BtjJRo4vKqeo/9kRZHtzxr9cORKkRrhy0PgxUxQL0zcm
 AqCLKhH7Yjan5LoPjQqSHb4HsBATQhivRbO2vyAtxBva92XtEICvb6/T
X-Gm-Gg: AeBDietZNznm+0UsdqR48xiz8qnF3pmiOc9kE6LsqROB3OLG4Wp8u0zaQiKvXeBFrm0
 if/6bkMAB86JzbEYwIMUmPVpCSiisyoNFfrgr7Saz6VFabnZg5DE7Lk2lfNLJiIJgPVIKHYLFAS
 WJ780SSVX/epDOISR+MJTmlsB42DP1r4feDZkMfVM9ACRkg7GF2l7wrmcsHwue8b7Y0aDKQnUpD
 9F96TsuLSwSCGPAyrRlS0H3x/8bhfkd0HUF31i7y8mIKaWpQYBpqU5042paJEI+4wN9VHiijwTk
 pj5IyJIaQJNPTmEi8loXBylSL/iZRXFKOOYCtMMnVzECmkYlXSsM33WY4hwwIMSuHJ4ltr3WAKi
 489d2QJ2pVeqtBhBIhqALXWeLyYxJ5+F+8vvBqo+/VisDVUYG59aklvNEeWDBSjvu6capcdtyCd
 u6mGrABKF+pCZRWxnO2DRHklUy5xYIDuMIjfDX0XKmaKAdu8zHj52tcra1hbj+BXX63my86Rqlb
 j9xZ0oc+ovUS6xRx+CwtbZ8hAqIcT3ceYSxE+J8YhxwEXM=
X-Received: by 2002:a05:622a:81:b0:50f:bb11:df41 with SMTP id
 d75a77b69052e-5102ae35705mr29997831cf.60.1777545175725; 
 Thu, 30 Apr 2026 03:32:55 -0700 (PDT)
Received: from
 runnervmeorf1.khuyxa00f1durmelsdgvmvfuth.cx.internal.cloudapp.net
 ([20.94.54.82]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff458289sm14225976d6.29.2026.04.30.03.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:32:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 10:32:54 +0000
Message-ID: <20260430103254.3949-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
References: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve-2026-31431: Add page cache corruption reproducer
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Thu, 30 Apr 2026 12:17:14 +0200, Andrea Cervesato wrote:
> cve-2026-31431: Add page cache corruption reproducer

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25160424399

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
