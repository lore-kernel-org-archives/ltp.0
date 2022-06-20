Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A58FC43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 13:27:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDDCA3C920D
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:27:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 166BC3C0727
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E36860005A
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:43 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 h14-20020a1ccc0e000000b0039eff745c53so1565642wmb.5
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eZHF0/Xy00OusPXQpmT3OsUGkGM/6gJxUM3v5ToG2EU=;
 b=fx+vlV0wMRKp5G2SPzPrm/Xrp9Z27RAttY9xbLG8SwZMMAJD/EPia6auvnm3CuKQNL
 TjWlBh2MhnnLorgyCRA1egcV5sWbGF8AByYymNeqrXGTl6ncRgRyg14+IgvN2XzwIyBf
 EUJWISUbFlDzszFmmPKXlLLmVOZxCK5BkEzOSJaGYhhfzcwBTyyE8fWBFZN2VaFw6AsZ
 JaG9CWJ/R/qT2/LtUzPoOswxUygfvQFDO9NsKnLLs6ScM1sKeHIu0aijFD/JJPbDkzGZ
 oMQZpALiv/daFVIKWdi+eolR/L9UTxhkcr8+rpuUx64RlNxBb6UG3caMyP7fPgdj9U50
 AgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eZHF0/Xy00OusPXQpmT3OsUGkGM/6gJxUM3v5ToG2EU=;
 b=Z1wsNFKdapv5AfDJBAWj9ZsddrPF1/bPhFStTgYAgCXgdw9/P8qCua1GaXDyi76ysB
 oQwSwAJymY5T22Tpro2SwcUw4gae/XDcNQoWGkq0MbyUmX9cGgbXdyzaeLOq1hI3Le5a
 WviyooQnY2NsfGgENwcN973pGhi14pg2mg5HR7uLDxZhUVx0V/sRmFS7473pDjyKiLB8
 rgufzoBH73jveeBL3W+tuYGtvF+n1tHbJmb6WnakdTaYBeGtyCGblI5kr+TpRn0Zmikk
 jzxLAuUp/9tpFcLvk8OMvNOsLJBWIfCdQWSZuQe6fDZQWumdY76bhXysj3gv7ny6AbsR
 kPsg==
X-Gm-Message-State: AJIora94bJLI4P9P/NUBUXu9AOfEo8ebZk3FwroBIQz5eut2b8qxVKL+
 FxLIRmi5P5FaK56gH40y+gM=
X-Google-Smtp-Source: AGRyM1umvcwADg1C89hHKqOKP5DpDP9WcYoNrgO0xA9UBm30v0yOpK3BVfp9saSCncwd+o5F5Dh75Q==
X-Received: by 2002:a05:600c:3551:b0:39c:8a93:869 with SMTP id
 i17-20020a05600c355100b0039c8a930869mr24134529wmq.107.1655731662834; 
 Mon, 20 Jun 2022 06:27:42 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d4f85000000b0021b862ad439sm9086556wru.9.2022.06.20.06.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:27:42 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jun 2022 16:27:33 +0300
Message-Id: <20220620132737.2015073-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] More fanotify tests for v5.19
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

I remembered I also have these 2 new test cases for a fix in v5.19-rc1.

The bug is quite niche and fix is not trivial to backport to LTS kernels,
so I chose not to run these test cases for kernel < 5.19, similar to the
approach we took with another fix in fanotify10.

Thanks,
Amir.

Amir Goldstein (4):
  syscalls/fanotify09: Cleanup open event fds on error
  syscalls/fanotify09: Verify if no events are expected
  syscalls/fanotify09: Tidy up the test to make it more readable
  syscalls/fanotify09: Add test cases for merge of ignore mask

 .../kernel/syscalls/fanotify/fanotify09.c     | 180 +++++++++++++-----
 1 file changed, 130 insertions(+), 50 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
