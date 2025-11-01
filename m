Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EC4CCF9F8
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761960227; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=eD0zhiacbrQDMFPtz9WZcX/3iHFcGq+4I2z0vPuNu4A=;
 b=ovS+MGchtC+SBZbs6LhWFQUCgwwiUOq6Bbb/laU7y+jlbPG0Q94NvNy3TESobTM01vigY
 +QyWHLlmumrLlcVZ9Cp+7XMUSqAFZn5mKYicWB8C59QyRFfxGKRslaPUCDmlVf0l1POluD8
 raQjdHoeSJEjG1T0Fs9ZdnF93cUeFbQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0ACB3CCFFE
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 02:23:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C2F3C85EB
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:26 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35A6510005DC
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:25 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c21467e5bso5995767a12.0
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761960204; x=1762565004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spWMNe0bcQme2AOU+9IqqoNrbO1XgjMwbGM4Rp1EUXY=;
 b=f42X+Tywa+OO6gpIfsI+UHOIE/z2m95cGBtmNJAi+ECIqGK9VuOKFRpscoBhOi1BDq
 ianT3io2WY7cbV0uGdL0j5TWAQoEm+Gld97/vqY0Gu6emvHRTAN5lIO5WcxXhfMz3yAn
 RQcoReALm8uqUNcb8PN4SbLK+UPYwxzi9dkkoBxFpMXnoN1usLwdGrwBLz+hG/40cOXb
 obsSzOtshnX3bK5eKBtRNksqc1ifuuEI4kBLnsT2VSwUr5ts8RYdqaL0fmXgG/qNbJ+p
 2SCFcIWBl5v0RQGJ1qXGZkPOkpXjUoBbF9SNVayonqNLygYw6KMfr2DSYzIYsJhupM+O
 Jrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761960204; x=1762565004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spWMNe0bcQme2AOU+9IqqoNrbO1XgjMwbGM4Rp1EUXY=;
 b=bNo6+sH2Tphw1PsxBJ6Qt73KY1EchHNXiG018VIoHtPwHh4HRuX3o31lkXMqEwDS8r
 /62R4qqrahtvJV53RLNxnbGBCJ7DUQ0kifNO6m7XbNn8zODj2pp+OS5bQMM+LaQrfIJP
 kd1V006zPtwvQNkycD9FSOKKdwTvX78smoRZrORNKWTzC0FtcwIL7da4Rhl0W/YNo1rq
 rkm3NJ7Wbpbg89YE4UF+UlDDXlqGqEfYRWH7FHpwWVJDRYUMUaD8wQfJXwSocM795o6q
 6EVcUAv5R2Tcx79zbWHzH28vBjPg9Qb/I0KQsIlSuvjwecE0whnbJlc6J3uj9bmbDqYF
 X28Q==
X-Gm-Message-State: AOJu0YxzrfjMN8AVeA50hTHsrRI7U3KwzqAjKzAxdkOEXkNqw3OyBWdc
 fM0VPSfM1W/JYCnq4yBBlUMi4ssuayFkRYd2MfRzXTKp3ZmDm3LFApvdCJ6Kv6d3NokHTAQqy2I
 ny8A=
X-Gm-Gg: ASbGncuN0xr3I0kVkPKDzRnk8l44jD8IZJ9VuxNoBwb121AFM0nCHmS8YBD9+putW6X
 cdhsbWLj9lqby2g/PFkGLNLu3wo9qQQ5VFUqnc133NM0+c4xdZxTNhazgvkOanri6Yu6UQt6n/2
 EKmrb5snnTeBKyHjZys5+c6IIt+/5q7eW8r70w2mVeHw1oSJjgVuFr0mEPNAeLJB3TtyQvZnLGO
 Obqimu/DeU9i2PmBOnssXGKFuopvU+4GYzYuBaocE+HxI+n76t9hcU5fSqSHziYsvXkN9EGz1Wk
 ONt6vMhGvG+tGh+E+dWIIToQmeE/4xtQvutHTHULOaWHiRISzdAbo6NSihoqY9TE8cF8GsmJi3Q
 7Yan1XMDkrlHxAp/YBhupsEXDpyTwRAGwMJRRz5ltB82s6ymS8v4nHLBupW+R+zFm
X-Google-Smtp-Source: AGHT+IGxEqv48IF3kuSg5+5ff5FaVrujPthdv+cEC1f6Zi/H8F3KDE058ASdsmgUu/WtPtbdRCfN9w==
X-Received: by 2002:a05:6402:5347:10b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-6407704fd5dmr3638999a12.14.1761960204273; 
 Fri, 31 Oct 2025 18:23:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-6407b392d5dsm3013990a12.15.2025.10.31.18.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 18:23:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  1 Nov 2025 01:20:20 +0000
Message-ID: <20251101012320.24972-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924084223.20597-1-wegao@suse.com>
References: <20250924084223.20597-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] tst_filesystems01.c: Add test for .filesystems
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

v2->v3: add e2fsprogs for CI check

Wei Gao (2):
  tst_filesystems01.c: Add test for .filesystems
  tst_format_device.sh: Add e2fsprogs package for CI test

 ci/alpine.sh                                |   1 +
 ci/debian.sh                                |   1 +
 ci/fedora.sh                                |   1 +
 ci/tumbleweed.sh                            |   1 +
 lib/newlib_tests/runtest.sh                 |   1 +
 lib/newlib_tests/shell/tst_format_device.sh |   1 +
 lib/newlib_tests/tst_filesystems01.c        | 104 ++++++++++++++++++++
 7 files changed, 110 insertions(+)
 create mode 100644 lib/newlib_tests/tst_filesystems01.c

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
