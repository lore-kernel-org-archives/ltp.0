Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B8C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 09:59:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAA523C964E
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:59:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 219683C9175
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:58:58 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A5E060347D
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:58:58 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id mf4so26191784ejc.3
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4lpjxDXIovQcfv4X8qHvnAe0qatSomoWG/Tu1gbq6s=;
 b=CrzfblqpLWPa3wvDT5LKQdBP1MLvTEaDGGn2fTzgyQyf2o49wIFquz7r/3KA9o10Hf
 xbkOoz8bcd/3YGJ4TkHwY6miWA6F2NV02FKlGFXYhMhkfG1A56bD6iEEoQ7uBgcIDg4N
 YWY7KT3EYOIOqQLuNt60WCmFH6m89PiL9ufL+CqpKbsagm3kqtxemrT2Bq9ST8ufc5XL
 SyNZMFVzFG0LOVukNW8UuLufDclzUV3RolYzQiomHWWzBDymqX17dYGMItxQJ5X3z7kl
 cRxxsrFg3yi/n94kaAfsFZTfljITnsN6wtJrJ2gGxRfFVbrQANp0vm6Bpd7r3w1pYA47
 rCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s4lpjxDXIovQcfv4X8qHvnAe0qatSomoWG/Tu1gbq6s=;
 b=mqYACnOaQs/n0Kw5IRjmC8bhJQeyr7EIk5IBit0us1bj6c3jVOpoTZ4HVWMZjV+afe
 T5wbx6R3OvSAurK/F4ZzdVCx/MLAjdYHSkkZhFNa0X7vAt8B7bpLvu4coMYMajx3N4Sy
 SStTyJgN0a/6lIludyyyoMnCveO9CqyfVRTNHIx3WCG7quqhQ92ddhi557BG0lIU+DWy
 pVLY6Pas/UCzMeybc9/rHU6KYzMdl+ILGqTO/T5H/1dIcQsMo4B8THdQtbFueChRwGBw
 fyOnHau2cWMqKDyp2nd1JBJylDgBhMrq6O3bRCFNUN0lphR1C3/y+H7Ad/JP9ZnHS7Sj
 D7aA==
X-Gm-Message-State: AJIora8FWi4xQg5CGtQJCO25FHtQexduZg+xP+qCJdPq+pViyFmjwhCu
 tMGbetscmo756loS5cbdNiCj8YcyIEseCw==
X-Google-Smtp-Source: AGRyM1uEVGKrW/OQlQwsqnciNkTbg0fpVf08BjxRSobIZnwCpimRhYxYymGkd8tAhU7sZCB9t5n05g==
X-Received: by 2002:a17:907:16a6:b0:72b:5ce6:1f7d with SMTP id
 hc38-20020a17090716a600b0072b5ce61f7dmr31023780ejc.28.1658224738009; 
 Tue, 19 Jul 2022 02:58:58 -0700 (PDT)
Received: from amir-ThinkPad-T480.kpn
 (2a02-a45a-4ae9-1-844c-43f4-b96e-8109.fixed6.kpn.net.
 [2a02:a45a:4ae9:1:844c:43f4:b96e:8109])
 by smtp.gmail.com with ESMTPSA id
 r23-20020a170906a21700b0072b616ade26sm6477512ejy.216.2022.07.19.02.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 02:58:57 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jul 2022 11:58:51 +0200
Message-Id: <20220719095853.3373732-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fanotify tests for v5.19-rc5
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

[1] https://lore.kernel.org/linux-man/20220630190610.3043428-1-amir73il@gmail.com/

Amir Goldstein (2):
  syscalls/fanotify14: Encode the expected errno in test case
  syscalls/fanotify14: Add test cases for events not allowed on non-dir

 testcases/kernel/syscalls/fanotify/fanotify.h |   4 +-
 .../kernel/syscalls/fanotify/fanotify14.c     | 102 +++++++++++++++---
 2 files changed, 88 insertions(+), 18 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
