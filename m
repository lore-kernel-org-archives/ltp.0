Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634A5C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:54:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B60FC3CA5EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F88C3CA5B7
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:01 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1008D600A3D
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:01 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id s18so10642242ejr.0
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UlkeDm1Uby3559XyXa8EGrY8W/y8v/e9CMrd/v+t6KU=;
 b=ZeKXh4Lax9/4k77WMPoW38lz0NfkSyFJIr463aaaqDbNnOqqWG8eLwJiHnH29UY8CC
 ++7uVRQ9m2ARX0iul6+026PnkLkZLmk4+5WqjwOyllskwOzxgTt64VvmsP0CUCziWbQ2
 kH+7zz1jMlPF6xtZX+IC+OXjUaflDqgVlGyZL5EpwjHJVciqSo55bptJ34c0KS/sPr7A
 EmG1PmRhQmHLwqEqpkjL6UCoNqlyRjAya08/8GGjSbGG2ZzxrqInA9fyeQ+UIZHBH7Iz
 DC64nYq6B9uurFKXzcqFnl81HlO5X3pEgXgUcO45GXzLiTUPPL63+JvZqiuq2c67M7GQ
 J/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UlkeDm1Uby3559XyXa8EGrY8W/y8v/e9CMrd/v+t6KU=;
 b=b87Imk6BPfx1FKNTNu7xAZwf/zx+y5lW8gc+/XteW3QbEpW/In/guDffbEdGXOMFnC
 KxKhZHcTzo0kmfPwu3ECnGDxFazWvvK80lDTJBV5DkaEwD78OKcEpvIQRxrOP9dKiGzw
 2D622ZwDjNsGYjqh0nieQ8DXTOX1ojXuT/94I+Z2s9EpWpy1k5miS6RfbK/aHAGQH1Jm
 gtlKAuRbGLdf4jRVD8uq/UUtuNTTVg/Cnv7ImgEzUrW3pxVQPAnc5K9lM3k2qG1CtCR1
 vL0yhoSHTj5LOVTSBajwMVPjGcPekv5tZccueO0NZhlKUAjSz8Y8nEnkDDEUfBW2gBNK
 7XBg==
X-Gm-Message-State: AOAM533PqrNRVhOyoox0TK+cNGe1p/2ISk4HH+w1xhnD6/O20fT5nlKd
 KksSMpKf9PCTlMKJkUmVFs8=
X-Google-Smtp-Source: ABdhPJxVULGmm+pFd16/u/c12caLNzfRXTr9e6+zo/Tp1JyoLCvUwYgukYllTKctaQUAAiz2H9v2uQ==
X-Received: by 2002:a17:906:9b85:b0:6e0:5c22:f0df with SMTP id
 dd5-20020a1709069b8500b006e05c22f0dfmr2586343ejc.114.1649948040488; 
 Thu, 14 Apr 2022 07:54:00 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:53:59 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:51 +0300
Message-Id: <20220414145357.3184012-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Fanotify tests for v5.17 features
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

Hi Pert,

Following test for new features FAN_REPORT_TARGET_FID and
FAN_RENAME included in v5.17 release.
The new test cases do not run on < v5.17 kernel.

Thanks,
Amir.

Amir Goldstein (6):
  syscalls/fcntl: New test for DN_RENAME (dnotify)
  syscalls/fanotify14: Add tests for FAN_REPORT_TARGET_FID and
    FAN_RENAME
  syscalls/fanotify16: Add test cases for FAN_REPORT_TARGET_FID
  syscalls/fanotify16: Add test cases for FAN_RENAME
  syscalls/fanotify16: Test FAN_RENAME with one watching directory
  syscalls/fanotify16: Test FAN_RENAME with ignored mask

 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  15 +
 .../kernel/syscalls/fanotify/fanotify14.c     |  12 +
 .../kernel/syscalls/fanotify/fanotify16.c     | 256 ++++++++++++++++--
 testcases/kernel/syscalls/fcntl/.gitignore    |   2 +
 testcases/kernel/syscalls/fcntl/fcntl39.c     | 114 ++++++++
 6 files changed, 385 insertions(+), 16 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl39.c

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
