Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D891C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:27 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5E1619E8
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 02:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D5E1619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1373C871D
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 03:54:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4C53C6268
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:14 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 09CAE1000DD7
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 03:54:14 +0100 (CET)
Received: by mail-pl1-x629.google.com with SMTP id y8so10668389plg.1
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 18:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qQ41mcTQFXP5DjqW569tHmKorBCmZYdPg2gt5VnR27Y=;
 b=iXQUMkE7XtNm3TScb6nnOyVDCmaQH0/ygfABKK5cm9q6qEWHMsHha/BjiqRpPWobVc
 8LXe2ukNg44K2aMYcEBI3d98oOUgFDuVox7r6sNr4DQ1L61/Str4MzHSg+yV6+TwKag8
 RiGR4JjOPE8Hkt6z4MXRPeoAn6YnRnLYAMYo2xQkhD3ZSE0rxS9hz3RWHykTZ5oLNabn
 vNQLap+7e7iKIALr33qaks7fcrXPcSQ2aArLCHxdx6RXNWaD5qRTMTKDGkUXM827r5in
 Z4ZiP9jm/1px/uV0LyuWtJjccCUn7POQ+7C/PCfEbxa3YEgHeKbe6PgXszO9+AvmrLUb
 DKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qQ41mcTQFXP5DjqW569tHmKorBCmZYdPg2gt5VnR27Y=;
 b=zwiRBybCPV13pkSTh9YRtX8wCKyNXPUyq3Pcjv0zZg62GOQ6EnyiRlV5IB/NemqXU4
 GlAWk6SgHFVZetHbmhxaYliHcO1XPmwLAAb9uXXr79H6VbG7E/0R9m/OIRxQk0TarmHp
 3AwHp37nRe5dGBJUU+OxPvC9rX1OTGjkv7GpmRRLHMMTLdWLhCqmn5H6FAkGX82Mdhsy
 qi4ja6QQK93QgrkvAZmnka/1v9vqdRGsoqNtVEDPGG1p4yUteaalIa/8yoB+uO3Y46sL
 6liFfJnc5rvncf7cyx5e+nfmKiC6Y9gAPBNERq4zyN0MpXXxXIVcAddn68bTLJcz4NZ8
 fLZA==
X-Gm-Message-State: AOAM530Fd8bnWpnsICubVxw9A2D6FqR4QV3MAL0h/Ft3SLP6yID2e5tM
 X1sIXMJWm+daL78FivgtouTH79KB7L1wgg==
X-Google-Smtp-Source: ABdhPJx6C6gYfO2/4ipCIVhcDiJn/aOATylAe5evoRa3TNX3ucxvhqBS7CBQL0r0rbHZyKcayeeFJQ==
X-Received: by 2002:a17:90a:ce02:: with SMTP id
 f2mr4361653pju.77.1637031252575; 
 Mon, 15 Nov 2021 18:54:12 -0800 (PST)
Received: from fedora34.. (125x103x255x1.ap125.ftth.ucom.ne.jp.
 [125.103.255.1])
 by smtp.gmail.com with ESMTPSA id e2sm13000922pgm.48.2021.11.15.18.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 18:54:12 -0800 (PST)
From: QI Fuli <fukuri.sai@gmail.com>
X-Google-Original-From: QI Fuli <qi.fuli@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 16 Nov 2021 11:53:52 +0900
Message-Id: <20211116025354.2566-1-qi.fuli@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Convert syscalls/dup3_{01,02} to new API
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
Cc: QI Fuli <qi.fuli@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup3_{01,02} to new API

QI Fuli (2):
  syscalls/dup3_01: Rewrite dup3_01 and convert it to new API
  syscalls/dup3_02: Convert to new API

 testcases/kernel/syscalls/dup3/dup3_01.c | 163 ++++++++---------------
 testcases/kernel/syscalls/dup3/dup3_02.c | 119 +++++------------
 2 files changed, 87 insertions(+), 195 deletions(-)

-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
