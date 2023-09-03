Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78551C83F2C
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 11:16:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8593CDFD3
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 13:16:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8120A3CB8FC
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:06 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DBD4E1A00800
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:05 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso5759515e9.3
 for <ltp@lists.linux.it>; Sun, 03 Sep 2023 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693739765; x=1694344565; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MOSMOfJkm95HqZ+oR17svgKVSt1ZRz2Ck1qxs9N8/dk=;
 b=ANZvUKJZ23+WNcoXhA059v4nONHcOMFtmeSIAuF+Yg3CCvfOb5OljuCY9oIyQ3qNWm
 K0M1NFNCASAakk8N0xx8pJm7B/T3yoYrFw3LILkmGKxA/sIe+ibvoquoDE+GUEOhzcgi
 DAHip9IbnpkM1P+G3ckxsCuRrXuFzE7HsWtHEeOlwMOlfyn/gi/weTQLOD74psY1+Bkh
 fTna9q01v6NDR13FokII+zUHqKFlNFgcb5CmhpTZtI8ZH0F1Cd8Qyin4XjUe48FRia0Q
 faP9bQ6ya1e+UYeGy5GbYnNt7FQRhRIqmVUrVBkBg67zunFGuoNSHdaV5M1lnEoNxOy3
 tnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693739765; x=1694344565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MOSMOfJkm95HqZ+oR17svgKVSt1ZRz2Ck1qxs9N8/dk=;
 b=ZYyy14x6eA2EC3ON/ExO2ZCge6qWW4GBwT5gv7vaYKibjEWrkCyxVljHDgBfS2dfaT
 qeYpAJahQqnaAIhUR1L3/7EfNNUYosLDs4/E83L+LxW9sYuA99YKwODztJIesMk1UgxW
 mPVpF8QSAaG7s+r+pupevqrrYOp6RX0Qm4pGJMQFEGJIfwHmPm/7aZVr30pPXYhnASzJ
 GQ773cbBd9CZMJANF8Xj0zE13+X0gxfyhqKA/Ol1305rWg9aFoacmLaN9ZYPHLKeL8h9
 Z3bpnVx+hURZ4f+H+5zcVqf7F3EHXfjBERUsv/U0bQKMACSjCETcrw6u0i7jWNiPB1FN
 fjJw==
X-Gm-Message-State: AOJu0YwbwprCR14WrZinIgqL32pRwYtv9sb/IW2S6wccPvWa1ybZ4eMJ
 /DcQSC4H3lZYxS9wWmY0rQI=
X-Google-Smtp-Source: AGHT+IE2id2RYENoL/o5YvIsarDyNaawi+1iHnpkxfbgj9QkZyH0bp50b3hFvC/CwADEqqeevvLFPg==
X-Received: by 2002:a05:600c:220b:b0:3fe:5501:d284 with SMTP id
 z11-20020a05600c220b00b003fe5501d284mr5145081wml.11.1693739765050; 
 Sun, 03 Sep 2023 04:16:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fc080acf68sm13899065wmf.34.2023.09.03.04.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 04:16:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun,  3 Sep 2023 14:15:55 +0300
Message-Id: <20230903111558.2603332-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Tests for fanotify and overlayfs
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Kernel 6.5 and upcoming kernel 6.6 have several improvements
to the integration of fanotify and overlayfs.

Kernel 6.5 includes the fix to generate fanotify events on watched
overlayfs underlying filesystem (tst_variant 1).

Kernel 6.5 also added support for the new AT_HANDLE_FID flag,
which is used in this test.

Kernel 6.6 brings overlayfs support for AT_HANDLE_FID and with it
better support for watching overlayfs with fanotify (tst_variant 2).

tst_variant 2 is duely skipped on kernel 6.5 and tst_variant 1
is skipped on older kernels.

Since the overlayfs changes are not in a release kernel yet, and
since this is not a new test that can go to staging tests, I will
leave it to you to decide how and when you want to merge these new
test variants.

Thanks,
Amir.

Amir Goldstein (3):
  fanotify13: Test watching overlayfs upper fs
  fanotify13: Test watching overlayfs with FAN_REPORT_FID
  fanotify13: Test unique overlayfs fsid

 lib/tst_fs_setup.c                            |  2 +-
 testcases/kernel/syscalls/fanotify/fanotify.h | 36 ++++++++-
 .../kernel/syscalls/fanotify/fanotify13.c     | 77 +++++++++++++++++--
 3 files changed, 105 insertions(+), 10 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
