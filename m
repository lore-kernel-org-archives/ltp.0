Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C2C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB006141B
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 18:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AB006141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 787053C8B53
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 20:17:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7EC83C819D
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:17 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A7AB60221A
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 20:17:17 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 z184-20020a1c7ec1000000b003065f0bc631so6120165wmc.0
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TTf0MSEKvuq5yMNAeW8xeYVk1VgnkqHY038r1XXUDUE=;
 b=S4xSBAp+jpzdsBUnPQVL8/4GZCdVLVtSypwv8QbFRybq/hY9yIW3e2fF0lQDnKDqqy
 RYH6H6boON5s7fdAnaRExWJ1Qcqim1UTX7ACjWeZkju7cT/8bq0B286RWBM0HkgTZc87
 nvTQeO1/CaNyp/uQoKPaljyX1N12UAJk4JFNX5HXvDyB+4oQgmuymwvf3gAn3iCotza7
 w7rKvutz7WzBjhLDUN420TpzH+vuWjm+e+c6HBKZTqQb+lZWC45/V/6w4lQJwnumtEn0
 AoIlbADQxWXPwmzm6Y4WsSDyHlCRNs9GbM6mJcyx99FzlGU3h3URs3PNL2IKLBtavhpr
 TKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TTf0MSEKvuq5yMNAeW8xeYVk1VgnkqHY038r1XXUDUE=;
 b=OPfJydFqMDZFSlvPk6D3jy12sEUlmg0OW9cqKhWBBdcg/cLagGxbIeRJaVc19BxJ6U
 fuWx8n+rQ9Fh/WFaMOwsPH7JhQQtb0bByhW0Nt16IO9aQwLUY656HIyBi4fjhfcGELkk
 OsxRK3CfOuvoyZe1QGguYOZTE0fO7tO8W8CkI3Esha++9RL2agnYaQQPMc0Ny5j5d77Q
 JikHhQCFWqwSB+kn40i28SQhG9v5NnZSBJMflchH+bqZPlgoLtkRk4qWRWCOSSZWjkll
 eyHO3lHEF8KlaVTi9TYPDLEyrvflu6ht86rqNh3da882LChVfLneWvteLfXjkYUgUsBO
 nyAw==
X-Gm-Message-State: AOAM5305avq+WqsknTgd87O/U7dx4bIgaRHutvU9whlLGnYm+C2pstVt
 rCXr7erWNIhHgqRJkIMKNgymDLGK55A=
X-Google-Smtp-Source: ABdhPJwf5Li0jMXaopChA5I+HoAJhR7HLcWX5FZYFkNdr8Kyc/HS5I7k++JVnuMax7neEHA+ps2MPQ==
X-Received: by 2002:a1c:2209:: with SMTP id i9mr12192351wmi.67.1632939437092; 
 Wed, 29 Sep 2021 11:17:17 -0700 (PDT)
Received: from dell5510.suse.de (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id f15sm449299wrd.44.2021.09.29.11.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 11:17:16 -0700 (PDT)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 20:17:07 +0200
Message-Id: <20210929181709.31788-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/2] Fix old toolchain (< v3.14)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (2):
  lapi: Create if_addr.h and reuse it in rtnetlink.h
  lapi/if_addr.h: Define IFA_FLAGS

 include/lapi/if_addr.h            | 19 +++++++++++++++++++
 include/lapi/rtnetlink.h          |  5 +----
 testcases/cve/icmp_rate_limit01.c |  3 ++-
 3 files changed, 22 insertions(+), 5 deletions(-)
 create mode 100644 include/lapi/if_addr.h

-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
