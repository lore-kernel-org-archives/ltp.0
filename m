Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFDDCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 727073C19F0
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:10:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AEAC3C19F0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:10:22 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0115600D77
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:10:21 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30759632453so6631111eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604620; x=1782209420; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3AsxgJJY59D9AVb8GXuIwc5frLPJU6/hDCXbgXaJPQ=;
 b=hLUsSohhzRctvkqFnk6rsS1lSkH0BumYmX3cpXWg8k0wpyPA9lc0KX7xIaccn0e91V
 qPUEdmAtIUgU5ohDcSsz0OCLnxfZNd+z1fsfVt49/uu6o+wK21K7jH/JXs1H86kJ2poC
 D66u14Ii25rWGtZBf25gCz6BlaId8USjDdZSzHlsGvugU2jZ4cMYJyJbGNSZWvqHHpX5
 46W+JzluN3qhz5q5lqfRLhYWtTvM6//fh4iaxK1IiII/ItrUPJZOqEMSmmbEL52RNyrY
 3rGHhGgRv7nB03LcTWKRIkXWQ9v+F7jq+wb5EjJHiXKmcF3AYkz6kO0l8GuY/2iEipc5
 gNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604620; x=1782209420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3AsxgJJY59D9AVb8GXuIwc5frLPJU6/hDCXbgXaJPQ=;
 b=PNs53gxMiWizDkzqvqQNZE+QhTItLQuyxBfAWjC9naaH3SzIds8fojRAKUTG/nILv7
 2LmLnR8qIRKG0dAGFIsXT5L/W84eiCcZplrsjs4qftxfz1P6mdN7kExRp1DvTbju5gkD
 Wk2GlFJiCtqO6GjQ1eZZ2kAdhpPQOM1jSoDMx03DiRZEWnYz8R2akIr11Z4QM5cDsCFa
 IjHnqEUPSLh8TdDIhUTwOJcyOYTyyQG8tQETqbXlci+gWP4I3kP2/jfDu1qwuJNzTZUD
 iE7oH+1RHaPNYU+sn0Xcpv6KlgAgOwxlH/EO2jjeIASz3kISsAUBQzR97qlDxb9QJlF9
 9mlg==
X-Gm-Message-State: AOJu0YzVIQelR4FH/kYGOOnEHhIENvxaxIWtity5FEIoGNQVDg49rps3
 VwaTcnOk/YZNm0j011UR4YSwkXECDfbcpnd3GjuE6yWG54rk7qxg88M+tjgZ5m4U
X-Gm-Gg: Acq92OGfdPIkzB23zxLiS23xDgFndUsTRMbQBBK6DV9Ax5W9vx6KNyKxoUCunOZxxkm
 5M59y0n2FSE62GkfZQrqpK86433goI9YRmZUB9g0oGu2j07VYRyte2YT3sP99P86kWf9srJN8of
 ml+A9NXqxG2XkO76ZcUUQT3E0+pOl7QICigHkzXfZ8601fQtcj1ucx9CYoW0h9aCZX6Dx/VVmXD
 DWlhGo1v4kNIe455SMOHKyVCtIYy+ffBj29Lsz4qZzN7yY5M8yEYSdoVZdxM1fkIciCNESd3KHD
 NuJBEES20Kknn6+BNk714/Kyua6YYSQUxLG/6IvugI58vRSXJnBwSKBlndLg7tMYCejn+kuIkjS
 6SZt7IwInMm3spjQIYXUdMtcb9wgnY07XUyBomz0E5J25GpC3ykUuGdZXjiZdFgQvUkdGjPVo8m
 xZLzDO4FvP/H+xmTS8ozKzczewnOuqGSRWmHLursDZgZdhUF4yk+rP5ttjmxTL2FSZpvla80tUw
 RbWeKCgTQHDelNVGfd+O6poD/0kTGB3GwIMg9eHo6JoWxfN8v/SLfM=
X-Received: by 2002:a05:7300:cc0a:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-308201de230mr10956834eec.23.1781604620028; 
 Tue, 16 Jun 2026 03:10:20 -0700 (PDT)
Received: from
 runnervm1li68.2fvbbrm5ht2erfgp2g5ajppu1b.phxx.internal.cloudapp.net
 ([172.182.201.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea447b4sm17158849eec.23.2026.06.16.03.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:19 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:10:18 +0000
Message-ID: <20260616101018.4064-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616-fix_pids_errors-v2-1-a1e1d377f8b7@suse.com>
References: <20260616-fix_pids_errors-v2-1-a1e1d377f8b7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pids: fix cleanup of orphaned pids_task1 children
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, 16 Jun 2026, Andrea Cervesato wrote:
> pids: fix cleanup of orphaned pids_task1 children
> tst_cgroup: tolerate ESRCH in cgroup_drain()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
