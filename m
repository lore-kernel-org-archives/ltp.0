Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797A5C4828D
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707355976; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bdJJ/kJjMwQJC4PEYCLC18vVfnw4fYj0DO19NV7WXog=;
 b=eYNafuhyJeq5DaJhslSu1sMadK9dRUBVChZWu+T7SeU7xCaIQrNoKGtIvlcliGJjurK/l
 OFO5c7aMDC285CjTV8vqgp1BBWmCPjmEetqmO1N+oK3zFUTpLz7caXKmx9xPbteI++M0eQ5
 2O51hxobswghFm7cxxo2arZiwXuaABo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 234DA3CF5A4
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 02:32:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F38A3C62C5
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:34 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27AD31402FBD
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:33 +0100 (CET)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so13411451fa.2
 for <ltp@lists.linux.it>; Wed, 07 Feb 2024 17:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707355952; x=1707960752; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDSEGCNLyzgsZGmnErzqs793kaUDL6VspVQILho3OKI=;
 b=c6z5fStBXKfZa2pKl5mwD3islzPkyPSJF8L4HqKLnkGNuhWkEog4Va4Tgx+LExcHEB
 6ytv2Y5uDlf1phsYR86JmCexJkYGcw1mdBiy4UzrA4K7oZQurc9I6kcKE0rAZrznmRkT
 Wmw95VaxHh3yRR4ykF5Wsaqrv1gjcFtpg8IlKIiIXy1dWjG5Fogeq3B2N5u2e2LTxk/j
 rNFy0JX11K4EELMfU/K1WsxZPNv5+Dr2HtLM1CjvgSUpU6J6DKTORCOIOO0TBe/v+kAu
 obM7bjJbntGFGfEHWw0dHBO0FZ9YqFsaDGgAdgYXVfBMrpQGevn5AV9jKgGwTEpkjQGb
 gbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707355952; x=1707960752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDSEGCNLyzgsZGmnErzqs793kaUDL6VspVQILho3OKI=;
 b=OSbpgr6u9U37fpbPpba1eW8ykptmD830C85WjEXotlNh2jRCkASQfvXJXgmVePUC+3
 6NnBm5WIzCr8xmsMr5ttQk1J+GgpBApTLazdlMcH4Fz0Ioq6ixJkTTdCkJDkOZRaGaxI
 roJBOswXyq8CL5QD5gbNX7fKJQfwPtF2dl7H/cfBPEzDHLxMcDlXN7DcnMBSYaS+myza
 /ih8OWUXiBcGJtZDH/P7jGSvRTlNvoO13pcSJMz9PgairJMoDVDySwHxRAYm66bvQNcy
 HftLg2RxhlDJEp8Z4CVBWudpanHIih6hDyYkRUTlSnKTeKEAHeFEA/KmgzcWeaqdrt+3
 RVjQ==
X-Gm-Message-State: AOJu0YyvgTyl4sekTLlzlbwz1iLuT0pbj5+a+g7iAw4+Efm3hxtrg08M
 BkD2s/GSZokyROsQ5Jo5y3rF+Zdmq7L0z1r7SJRLGrBbe0MfxoZkswk6fOUy099hMDXB7tt9Y/E
 =
X-Google-Smtp-Source: AGHT+IEV6HIsyhCpj0aX8elxFxVUEemKtgfLIIg3LJCJVdqaeGdVwmNxPTR9GgtmfE7SGDTWt7WfSQ==
X-Received: by 2002:a05:651c:1051:b0:2d0:d451:f795 with SMTP id
 x17-20020a05651c105100b002d0d451f795mr273601ljm.6.1707355951771; 
 Wed, 07 Feb 2024 17:32:31 -0800 (PST)
Received: from localhost ([223.72.87.18]) by smtp.gmail.com with ESMTPSA id
 u27-20020a62d45b000000b006dfef3ed2d4sm2413857pfl.110.2024.02.07.17.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 17:32:31 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 20:32:21 -0500
Message-Id: <20240208013224.859-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240117125227.24700-1-wegao@suse.com>
References: <20240117125227.24700-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

 include/tst_test_macros.h                     | 59 ++++++++++++++++++
 lib/newlib_tests/.gitignore                   |  1 +
 lib/newlib_tests/test_macros07.c              | 61 +++++++++++++++++++
 testcases/kernel/syscalls/ipc/shmat/shmat02.c | 15 +----
 .../kernel/syscalls/realpath/realpath01.c     | 11 +---
 5 files changed, 123 insertions(+), 24 deletions(-)
 create mode 100644 lib/newlib_tests/test_macros07.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
