Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD137C44512
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 04:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784695678; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=XfYbnCMJJQ1mR4X37ZBxHHWfaq9o/xXyco7zqyvd6PI=;
 b=rGQ9aeERQ7s6AJw3pNXI1bvd6uxvlCTYZ0wANMsqiQYa48JFk2vNFCF/nRFv9nsbigTPa
 T2bsWd0kyUyl+/UP7X4bLFSvcCSEuxnbHUl9VtKra+ALDilR+aQH8DMtdRnFRmeMDl8L6JC
 R1GYwbPBt0XgDlJSgsnQdmLe5A1JezI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6344E3E1F19
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 06:47:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18B753D0E74
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6990601DA0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:35 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49557167508so36715375e9.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784695655; x=1785300455; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ionMMXv14dKJZmrCK+Io9viGhjCC2Oi0lBclXyLvLyI=;
 b=KFjqmmbJqUbCwF75x/i36eL/IbVRpARV6+yRW31yAcXsyrlf2AerXA6JECNDK0D8zB
 zz3i542ZjeO2D1vv8aCjO6jdw48UgfN83Wb6Niow8If6nKZs8IqMenIzkvcdpKnXtji9
 E3zmeRTZHPBNWjDeoksKPfe3rsFqANjuPYKvsJ1v+qt+4aLPv3oEMHe7EpYZEI/raqH0
 qxXQ7OwLc0vUyP3+r0bgdZ83JzN4PICEzL9By4ysyGArZq3YBsO9qqhOkDdwlH+IbFM0
 ZxF28k2Xc66B14FqUXSAThY90rK8y1VLbzifkoOuPOXjEhu+jALDhfnCFGJ9ebONI2QY
 TNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784695655; x=1785300455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ionMMXv14dKJZmrCK+Io9viGhjCC2Oi0lBclXyLvLyI=;
 b=MHFWaRGzbr32gispVaH3LzZqs8k7kvfvwzOyJ5+LRBzekoE0sCuHYzZBdMpVpe+Ql0
 4CjEvjR3OMwX5lKsVtVHjL4sULfvvE/2xL+zT9N4vUeMfNp+Grt7FD/hrdRq4sPt0qg5
 iAf0hLrg8zwZlxMeuR2pucZ0Nd5epF4++i6qxkSPh2K9Do5MjqxEi9E88PwQ04TnlKnK
 dTvdOp5IzkHnM0EenVgnZzxg9mwjPVI0SYGvD0SflmSMfXg+PqBuw56moQgxAg/kmJFJ
 2eGvMltwCVTrU9mkoFM1CowwwgzC2nVAXt/eM0v/P16DdEWtx+dcZ3hBQLlYbztjetbT
 5L3g==
X-Gm-Message-State: AOJu0YwG73O6fmaXZqeA7bE3y7f4W/+x9I90gHkjpIz2TGwZ5Jg1pW9J
 oNN3+8Z2sUVog3xfYKctp4+KYK1RvBRxzEFxc8FnBVrVx3kofvqZy2HxhOVqNWH5TH2fJvJIsGC
 hCfg=
X-Gm-Gg: AR+sD10VUv6wjacb1LCLidYr7lnV3J6eFldmfVZsO90ebxFCNI8B6+3Yo55Nw9pfPeV
 5ko+OpZI8LXRB+uTMf79gm64VbYRyK8ok7l5YmaB4ZCzbjaSd2Lz74/38biWz1vKv5E8x+nEBOG
 sgnYDQ4Un5HPV+ToYarO90MvWwzy+D9MbFiiYLTZiWBoOJPvkw5iybuUeJUKdiHSEQNb5b2XypF
 Nk4lkrNpkdCi1fKv7v9sh4zdIRg8peD1Jw8yg8H9BCB9ZSxsmRXB3Vye3rKTiSX4NZECVzuI3YE
 bgnTM1LwDP0C1+BGkk8NfkWzimBKYaVf+msiEkp1wRdqcNcc9EjeaWvEyMLlKsA/x844bhj5DPc
 DPFawFfBSW78am9A0BkFLnfw6TXukQ/Sokojvp6MxvJlT7cYsK4WJh6tq3TRyt+Fa5w==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id
 5b1f17b1804b1-49553d85ea0mr192641925e9.14.1784695655036; 
 Tue, 21 Jul 2026 21:47:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f8635c8d7sm1523861f8f.21.2026.07.21.21.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 21:47:34 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 Jul 2026 04:47:26 +0000
Message-ID: <20260722044732.3547-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 0/3] open16: allow restricted O_CREAT of FIFOs and
 regular files
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v11->v12:
- Restructured the series into three clean commits

Wei Gao (3):
  lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_uid.h                         |  29 ++++-
 lib/tst_uid.c                             |  30 ++++-
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 135 ++++++++++++++++++++++
 5 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
