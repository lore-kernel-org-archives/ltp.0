Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825A606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=VGpQR+HY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Yyms0/ke
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793069375; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=o73pPePhNxxCdYGIaSqfHAtkNbrlVUw2bHUsKFCWRsA=;
 b=VGpQR+HYAWnAqO6YlGGQTijCMKcPUsJXL5EYDhuGUbWIVyqsED0ut75P6hor44zYTcw2S
 BtKNLPCNSIi+J0t3MX4Vr0GJ6ZPkeuOTQqD6VMflOvKFgltN4gwWrppfRNx21QtTRCnrh7F
 YxHybmQkEKOIsaIyZomMKnxfoJBdrnY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 601B63E9A60
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 03:49:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86E8E3D2387
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:15 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A25231A002F0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:14 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so19203655e9.1
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793069354; x=1793674154; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1QpsE61qpxPWyDRIscMvG7HkXpQbiWFG5CtX6fWwe+0=;
 b=Yyms0/ke6h0AHku718yBtBTfg7Cey9OXnkFS0kFMFfx2MMe7b5I6dIeVjH9EWwdwuZ
 kShujNLcbv+bT7D6DGPa4VVsg+QIcUkso7Ao7JIMenKYPKd4wCHqbmGflHK7EhWa7GIp
 e5Hmo1+qc0/SyNflJAa7d1s37AzdVEHBFbz88I6tGF3eelzX/p9ZNMiC08JqboS6C54f
 OAllaV4JeC/unwRaigu5uIEnYYLYHlYd3ZzPOn1YN+tVh4VMsW/evqOXFSbDG+FxoAi0
 tvxsKII6qc+gMQY5dz/1YHeA/HGavUw2PPPK9azw9IvtLDg6YiAGHE1+yyunEIS0CjOL
 hWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793069354; x=1793674154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QpsE61qpxPWyDRIscMvG7HkXpQbiWFG5CtX6fWwe+0=;
 b=CzNRHC2ywfHYb6uSM/VAX8d7AcvV0sSvNAk+TXRSHBP91JRmLM2lMxvp47YaENWuuY
 HjZzREAQB/y5oIg93D7Ec8+72Y363Iz3iI6mD7RLwiXkz6XcRtG/4FxevMu4tc5JD2Gb
 Njh85MX9cFgliKD72PN4mtHXKAtxxDOyWlFu0ZevHz4LXykziGz/0BJOgOjVd5kvtEYB
 TqVLrUVIiF8hNN/Zf+BcGjJVvnjgr7GEMwX/1VhwmHYBmWWriJb9BCxu9rygQqsxWNRD
 VrHEpZ7Rs82HTSm99rLy69q1HKn1Q73J9/Zpu1l+1b9HCbGbWIC8R7cz3cyZq99EjDjQ
 djUA==
X-Gm-Message-State: AFq9FYKnlX7j2vg0e1wqsJ/SI2iHs1vBXaOw6PhZZxM1gFF+4Jzd5jnv
 Hkgr2SurvAT4IqqgnX1GhGaohQq+10DeXl9wcoDegntqR7iO1lkRQfwviQrnhkMVwlrmKE1Wdo3
 pz+Y=
X-Gm-Gg: AYBFou2fAoRMV8Vezz2q/Lt7QNbjzJGM/nkXLxRzN++0fLJNHhqg1VY5abxDWW6rw2y
 93LqqQqo/tahUUgA9SNj4kXrk91CGcR+nOa5eMFB+peV9BOEX5peRdn8Eaa3wZVAmwBaOSPxfUq
 HhsN88/0K+bSWhydgzY//P9wiiV5dpS1lZkgddgXYo/R8OKusX3DXqR0Rf5Zqz9wf2fJE7yA25j
 AVwFBWoM2M31EElqRcWcFx61PJIXWgHq+O0hUw7juVa9bAXPRyJCziu54OlBfKT2Vd4lR6S3CA/
 tr4uuc+UjLnFbvBEuJXKfSrTvY/Vb3Vl23aYaSTDG4eFpbAvpiQemfLtAxftik7ixKd7g+MlbSn
 HI63og3ZcSrbO+1x+BVdjdgcgq7/keoQBeYxmCucSrMUpHe0Fm0L+xzcd0IBqyvbVvevu5Bxz+f
 ualzwENvwQgmyFazdw0ivDElZvuPpyfY3N+ol0w0pjCnQt61UGbhpqFhvFpjQjg4xoWdHZb3i9e
 HSrhfgS2D6WBYSTn1KA6oXoDDC3SuC0p8efifbiW58q8QIWxWjC4M4QmUGlSkBvIdOHnHbiqpsJ
 LLoCGkP0idW5LnBd0U4BqBob
X-Received: by 2002:a05:600c:1992:b0:4a3:59c9:a743 with SMTP id
 5b1f17b1804b1-4a35acaaac3mr169575025e9.27.1793069353890; 
 Mon, 26 Oct 2026 19:49:13 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a35a03654fsm115492805e9.2.2026.10.26.19.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 19:49:13 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 02:48:58 +0000
Message-ID: <20261027024906.31789-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 0/3] open16: allow restricted O_CREAT of FIFOs and
 regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v16->v17:
- lib/tst_uid.c: Align tst_get_free_uid() with tst_get_free_gid_() by
  setting errno = 0 before the loop and combining the check
  (ret == skip || getpwuid(ret)).
- lib/tst_uid.c: Add TERRNO flag (TINFO | TERRNO) when reporting unused UID.
- include/tst_path_defs.h: Split PATH_FS_PROTECTED_REGULAR and
  PATH_FS_PROTECTED_FIFOS into a separate patch preceding open16.
- open16.c: Remove redundant exit(0) call at the end of verify_open().
- Add Reviewed-by tags from Petr Vorel.

Wei Gao (3):
  lib: New library function tst_get_free_uid
  lib: Add PATH_FS_PROTECTED_REGULAR and PATH_FS_PROTECTED_FIFOS
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_path_defs.h                   |   2 +
 include/tst_uid.h                         |  14 +++
 lib/tst_uid.c                             |  26 ++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 141 ++++++++++++++++++++++
 6 files changed, 185 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
