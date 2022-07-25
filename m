Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3D0C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 15:15:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5AEE3C9F31
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 17:15:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1A383C9202
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:06 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 138CB10005C5
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 17:15:06 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id u12so9350168edd.5
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2bRDEHwZuVNs1zWM/xLm6zsYBFBliua3QfuQ8pwQB/M=;
 b=WA+bhff4b1JYk0P+SLl5aKrRrvI334UutTBaA+IeT4RTej0TvY+e/QN/q+HGOL/w0v
 X0uMVx7fLHrzKEDqViR+03FZscytcUq4II8t+qPxSJuP19k7vc/vLqq3ZaZuSIFGxaK8
 Vd4PQvPViWz+Sq/JJZvFqRSZRKgkVt3zqnjtgxgmkOd9kUc5CJSbpAPSfvx/1e1QL7k0
 Rj1QHAjOj+mg33hOmOch6KpRX8yQCUx0AwiHz1XHgWBgTh5Z+OmTjdnN6S18e3lhsL5V
 6IkrWB+I8zfge5ECdOhkL4ey4ntPb6sCMCWnymgHI87HT9FvnZNa7L/EcrxFTeNlxcUB
 husw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2bRDEHwZuVNs1zWM/xLm6zsYBFBliua3QfuQ8pwQB/M=;
 b=xoofKDhquWfOnAEvBmsabXlg7RvQSds9Ydm2Xj2BZziM9Qmfa+Y/dDrDEYvdqO+0V8
 XCs3AP8yFBcqW1R2Vj30Kllq1qELA27HHmt+TX+5RC09YDbQzz5A+mbuOBMKm1MQvxyH
 HQZMdgBWyth51xzUZXyEM3deA146WVxlvbHIfuJUH8faStco6NN1Xr/KYrtzCJ5Qofp6
 hSkdY4xIQrxj9N5b1kmGmYibTtkf7B7+eS9ARHmKC0BlHLd7QpTvUEs1mX6eYOG75sa7
 EgHSBQXH7zvG2dDvTsrAkGp6tjgMtM9AcNwnTcBlU8wgUsSqN/Tu8Nil/2wZUkagvJnS
 sCrQ==
X-Gm-Message-State: AJIora9CFacgZC5Skid2qy1yUz+qFDv+dTAUs4XAPDbD/sHckqmYOM3p
 1FFdkpOp5ay0JLrpgov80BSQBliMxHNsBw==
X-Google-Smtp-Source: AGRyM1sUFh6RYJByydJtlvp4HjdVRaeH3UUy2akhyscVqS3rtqBU1r3ZjICfbLfJcW/e+moJfvbKQg==
X-Received: by 2002:a05:6402:354b:b0:43b:bef0:5b67 with SMTP id
 f11-20020a056402354b00b0043bbef05b67mr13913527edd.357.1658762105407; 
 Mon, 25 Jul 2022 08:15:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.kpn
 (2a02-a45a-4ae9-1-ded3-af6f-ecdf-f6f4.fixed6.kpn.net.
 [2a02:a45a:4ae9:1:ded3:af6f:ecdf:f6f4])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a17090670d600b006f3ef214e27sm5422966ejk.141.2022.07.25.08.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jul 2022 08:15:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Jul 2022 17:14:51 +0200
Message-Id: <20220725151453.3846227-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Fanotify tests for v5.19-rc5
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

This updates the tests to validate the current ENOTDIR behavior of
fanotify that was merged for v5.19-rc5 and v5.18.10.

This is a retroactive change for APIs FAN_REPORT_TARGET_FID
and FAN_RENAME introduced in v5.17.

The current upstream behavior is already documented in man pages [1].

Thanks,
Amir.

Changes since v1:
- Split comment in generic code to per test case comment
- Added RVB and Tested-by

[1] https://lore.kernel.org/linux-man/20220630190610.3043428-1-amir73il@gmail.com/

Amir Goldstein (2):
  syscalls/fanotify14: Encode the expected errno in test case
  syscalls/fanotify14: Add test cases for events not allowed on non-dir

 testcases/kernel/syscalls/fanotify/fanotify.h |   4 +-
 .../kernel/syscalls/fanotify/fanotify14.c     | 117 +++++++++++++-----
 2 files changed, 92 insertions(+), 29 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
