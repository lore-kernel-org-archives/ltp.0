Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A154B106F317
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774519756; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jI8u+Upi5dBJeQjCj9IGACFIBvuzB8qEGD+JtHx7xCc=;
 b=DwwFCpJhILfeGRYjztFvSa62JxQ/8RwYH92UAqXjzAo0ayRcZuFnVnHq1h3FEnjDOz4KR
 vVGI1KpcXBHnsJ7xI0D0mDpGtuQaMWwAxMH2XWxhgLVXELzW7GUJ6m8TlpBw6KdsqFdjDcw
 c/ref/7mJCB6NCHZ9mGWcMOURJIAV6Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411AB3E2735
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:09:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792BF3E2735
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:08:52 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C763200C7C
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:08:52 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso276560f8f.3
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774519731; x=1775124531; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=GC5EJZbEguGBu+X2LvbTlLmxY8r7XF2O4YZsS2Zs15BbgLynFDQHlP2nGc8dco6xTE
 nxONvYTo0ZNCKQtDf2DZevTZXCI7fPO+J6c8RjJwh3rC4aE4oDHLQqS7TLBEe2Uvkt4I
 yVV8ZieCTmBWSIqSQhJqbS7nDOCRFOaC5Y8SrKj4S9MnWvufBvOf5JAKiXhyEadwMBEz
 qM3LlGmpRHglTHAf+t0L62D1Wn2V6HOPvka+XeP94Ucy92jH4rsC2BpohYZcsAt8Oxab
 B5rjehdVpHwjk1vxE6gQe1pvYp4iWXU6lR/cV9fKwbEj1Xs3PYXhEuMkUwLOJhqPldVR
 388w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519731; x=1775124531;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=sVMzUzjN4x97ywdeyChrDj+2I/W4NOM6KwOfPxnl26RMfU+N2HKwUG8t37g/WhbIMc
 jCzZH9l1QrKFciCxrmo4t1z2e/cJ/9AvXVOaMwIwY3Uc2nf3Tas9x1gqzYQtPwEqqU8I
 kRnbeusAKlkO/E0ey14nrD9FKWvVLVZOGpmadKn8FdAoOWLkbXlaMuaKeRBkdITCZy+1
 5yl3EShbXzaHRHNt6Maa/Yi5xWL8pEbNByqQbAIZGd/augx7xW75oyqJ9qT/U0BiuV4D
 6PdoDBTZuyMfZbrzm2wRNkOKX9UJ5b7NvDzBa82MkUQzmo/O1kjI/J0upPWXuKCUyOZ2
 8aag==
X-Gm-Message-State: AOJu0YykhhU7SvGnWibnN9RVAxW0jP1NMU9MRRHpeuDlCm/iH/0Hx5yF
 N7lgp08X+p0UImcc1x14sDcZBVBP0V9kwu0bMxZMKhZ1BMmIOYhsxhLf6t6zxowbmuw=
X-Gm-Gg: ATEYQzyw3moQqemew3VLTsY7lD/NP7DaFLbmbRPR7TBcPgk6dQ2yHEEz4+iFF6zf3I8
 ik5+F/ZDatYIuJlZ3jNzRwN3tTAA0w9ceFAYJ0akHM7XZufc3XSzjvyAZ6JH0dDQl2/MO3nU/WJ
 +nerhinypZI+UYzE71PaipJnrNCsZIKjPA/ULHAQJ124bxXL+9Df72Xn3I5Fq8i36lcVIltxerL
 c6Ii/FcAAjK4far2FuGooiVwt1CSoX7ecnyCnfehQTmXTGEu1F8shG3M7yGE0qMw5cb5F26P2ir
 r0sVsca4ulu3Q9n/DLeuvqo3T+xEuP10x9nGyP4bWmUoOZ5bDVl46tc3Uk+xQsNoAfQQI8QDmNU
 B2GMED0wEtZNRiNxZewHPsvH9D9GfXsmncPgd8pZ/N2JI83Y3P7ZlCKc/E9jpl8Pn5g+AkVbK7l
 00FmLnIGg8AE/0SwjRG2kqrkZrErZnPcExjHdDl8OgpNQyQpN3QP5JEQmUUxFaMuwcBw0VJ8K+1
 FgvjLXufvxVIHZrqBDh1N06pG5yJVZryt0=
X-Received: by 2002:a05:600c:8011:b0:485:3f65:94a1 with SMTP id
 5b1f17b1804b1-4871605c226mr101536565e9.18.1774519731464; 
 Thu, 26 Mar 2026 03:08:51 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d4d884sm26661015e9.15.2026.03.26.03.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:08:51 -0700 (PDT)
Message-ID: <69c505b3.050a0220.31c6ee.8ace@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260323060846.4675-1-wegao@suse.com>
Date: Thu, 26 Mar 2026 10:08:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mseal02: Handle multiple errnos for 32-bit
 compat mode
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

Merged, thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
