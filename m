Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1590C54E67
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 03:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711511395; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4z6odbpQcfUq9NWxkTE5/rYAA1uw0yWY9kSbXYevx6o=;
 b=PqAYyc1PBXvhbQpEkCfpArCwhgaLYIWzJrf1SAMWbl5As6T1qSAVA9vq/FpfKo87adSm7
 XVk0eJsXwUwFdQd6mAUM9sovtc3NwoSNKYDocFXBEVH3qw3e8oo8anPtJCXHDaa1pd0YLn3
 eRIM416qLbUpLnAve7gZycIqYPdb5so=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8FC3D0EBC
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 04:49:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4493CFB9A
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:33 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A26F60256D
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:32 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56c08d1e900so3880998a12.3
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711511371; x=1712116171; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJEFcLfQJsneeNX/pfA67osj7Ddeia2Pv9MA1bb+bFI=;
 b=GNpq2P5x5rkbVCtR4+zb2Ry0Hk8f3UlEWFaJIzbfqzxfJsggb4rtf0JgkD1VKyHiUa
 G0JflzQ5imlcouj6LlBCD5tVTdazNBMf0mYWmLTiudUmJekAgXGxjzMGBQBcyevZBxTc
 GiUhbR68IfzPtxsEm8UK1RUrkGfTOUvaGIChyvvPmE2RTkY2QUz53v3VvTImUztWLxjI
 v1d/2GmpMKa6Yajx+zDyXZx5mJ+HSS0q+qoY+NFW7XyyzB1hFzgThpkmYDpyrsgHFIJZ
 ABgow+XW0rQtA1SOwzjzFdi1zCujYwWhpzjetoN6kxNMVRY6rLX0+5Lf5xIin2DE6md7
 h7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711511371; x=1712116171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJEFcLfQJsneeNX/pfA67osj7Ddeia2Pv9MA1bb+bFI=;
 b=OqsJycW3oYC/OKo0mgOQFgh4mJD7cE7lg7j7rsa8Ee8vde42bEGKNxPkayp01U7vCz
 QT1KoNt7sfCJc1t8tbDMyHD+w85COQDRWuWimoQTgzyP0MyVDTGsQMaSMP3/nF2G6Fb8
 o9/9PacL/3GYJY4M1aqYFipoxxVEc1mcdl6iZR49KqDwqcpRMV06Cl1N58jIEmQL+Ros
 33yB0kUoP1KPpCnGiMrn7cwbd+Dg2STKmYZQVCz1gVgosVu270/l62Q1YLUvH/CLDsUz
 gpQqHh0c2As5DD+iqFNctZYYQfwzXe2/llfIQPuCo3nwDWyrk0iTyJPiq5jOBH2SOn2P
 lNcQ==
X-Gm-Message-State: AOJu0Yy1g+Ipm1CsiIX1yBXWkT6AyrKN7yQLXgWO4PcBXfw/PrFU09bT
 yllQohYVF3HapVhnYD5+sa4o2ZrwmEUqpmKC6BZtoFKKAGhnG0OnlaWKnA29uCpnQAe4GgmX4b4
 =
X-Google-Smtp-Source: AGHT+IFCqu8PyG2iOpMarLipdGCPx7GptRpgNoTiea2zPCbN+4VUQk2xXk9Cci5xZ5MoWYJnOo2BDQ==
X-Received: by 2002:a50:d71e:0:b0:56c:d47:e403 with SMTP id
 t30-20020a50d71e000000b0056c0d47e403mr3186404edi.28.1711511371254; 
 Tue, 26 Mar 2024 20:49:31 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a05640243cb00b0056c3013485csm803610edc.69.2024.03.26.20.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 20:49:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 23:49:20 -0400
Message-Id: <20240327034923.30987-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208013224.859-1-wegao@suse.com>
References: <20240208013224.859-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

Wei Gao (3):
  lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
  shmat02.c: Use TST_EXP_FAIL_PTR_VOID
  realpath01.c: use TST_EXP_FAIL_PTR_NULL

 include/tst_test_macros.h                     | 61 +++++++++++++++++++
 lib/newlib_tests/.gitignore                   |  1 +
 lib/newlib_tests/test_macros07.c              | 61 +++++++++++++++++++
 testcases/kernel/syscalls/ipc/shmat/shmat02.c | 15 +----
 .../kernel/syscalls/realpath/realpath01.c     | 11 +---
 5 files changed, 125 insertions(+), 24 deletions(-)
 create mode 100644 lib/newlib_tests/test_macros07.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
