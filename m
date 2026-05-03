Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC3BFF885A
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 08:56:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 168983E1FD3
	for <ltp@archiver.kernel.org>; Sun,  3 May 2026 10:56:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3885A3E16F0
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:11 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A900060029D
 for <ltp@lists.linux.it>; Sun,  3 May 2026 10:56:10 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-362e30526f8so1269482a91.3
 for <ltp@lists.linux.it>; Sun, 03 May 2026 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777798569; x=1778403369; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t7iomLe5ZcM1VHftyXu2sJIzkQC2IhxehXiBm4uZYtQ=;
 b=RU2k+uInw3tTbkQdURlgS+IUwrowbxvNLnn6RdxkwEhoeFlM8W79MYXubLZ51GjI8/
 88HmQqFwE5Y1RhHHDIkYsbqP3wZdh+P5y5OiK1u01UxDN+xSKU2+ZpgGhrq7ykAkK9pb
 VhAH5fz5OgZVBrUhrJvcnYadL2wtsYjC7zNwmdciPc5RMvbx2pa38Hm8o3xp5UmI5YHa
 y8toE5p5ECFxup99dWqj6njs400KpWP6e7sGa8z4W69w5Lea2Ed8DToAPmTA7LT8tjEJ
 mMvK8e1NMOZjA6W5AAr4VZGRJABAoLPEG0leKZouyqumklmJd/7lnGU+oAT5ZZMfZ4+5
 Lb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777798569; x=1778403369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7iomLe5ZcM1VHftyXu2sJIzkQC2IhxehXiBm4uZYtQ=;
 b=GcAnNOh6ykFvOr3PiUiBi+0o1CfOjatCtm34o/T1KNEQlGD0TWtbXH3jc0fkspsJkb
 uYp4XAxpsIbqhdb9yowuORXFu9s4lxryAz0dNJzAPlx22LTFTcHs1kt03hf2D79T0ubm
 9tjkmKRxikWnVUYAarqEf4jRl7hZVKPmKMP4C03FwyEGRhEri5c9aIDZyqAKSUw1rAv4
 iW0oRWV0YN+3/+DehBHtNo8spie/tD5JW+SuTUHA1EbyKNXyPqLfJDo2E0v4dp7WuqxP
 lifd+KaHHi0sO9aczu/CwNEwBjj+bIDaDDORhNErDbebpnJ20uko64xG59tUY9sXO49K
 /PAw==
X-Gm-Message-State: AOJu0YwSU47bFn0g8LLU7IJJBnx78+8evh7/WZtMwas9EWXZvcYyvMXF
 xVt48dkXw6PoWo61eF34YdgBWFUNIEAXV2Jez1C3PGieGBSGW/BAKGvBmAKX9e6uDRVn
X-Gm-Gg: AeBDievQ07xyBHyFtPgxcToAOd3TLXFebsc4Vw48+1YvkJNXOJLvVH5FuIa4/zMMnQ0
 Iou8+LBZh6XJuAtAuPPVl5BR4QZz6eRJA+IE1gz7Tl/dVOeKIS/vZDBS7akWVOrwJJgPrWGmjCj
 MG6weIV5v2/p+e2oS80yhozdOzFJ8ciYMwbljWZM2z3z3IOPZ1ApOEdMCMbBVmaiLEAilA9c/gR
 jZ9z61uo0PDOdTxHVWwwNuRu/eN6sbQfihd1OC8M+wy2hOVdVAIFMJpT+9itEBZ5ENCBqDSI+iw
 l6FENOjCStzn7TFT1CKRiRfOnsG6CT5ND9sxrp2QhDbSACGd1tZd94UZvJ4XTjO+jkPeVDM8utG
 k3kMvrKNWMaYtsCkuPFSKdj28h5vZ5ATpc3nW1w7iIBqxed+zDC34ewSVbV2Z0DXwCHkubC6JVw
 2xiepwjY0O9Q2pMyoWFQAPnFJgteVwPFtjr/v6iAm9mbZQK95yHYma
X-Received: by 2002:a17:90b:3a4b:b0:359:d54:846f with SMTP id
 98e67ed59e1d1-3650cd4ce6emr5349433a91.7.1777798568583; 
 Sun, 03 May 2026 01:56:08 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec899esm8044167a91.1.2026.05.03.01.56.07
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 01:56:08 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  3 May 2026 17:55:37 +0900
Message-ID: <20260503085544.16915-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] syscalls: clean up getpid/getppid tests
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

This series updates the tests to:
- Link to the manpage in docparse comments
- Remove unused header includes
- Fix minor style issues in getpid02.c
- Tighten input validation in getppid02.c

Also, getpid02.c and getppid02.c appear to have overlapping coverage.
Since getpid02.c seems to exercise a broader set of checks, would merging
getppid02.c into it make sense?

Jinseok Kim (2):
  getpid: Link manpage and fix minor issues
  getppid: Link manpage and fix minor issues

 testcases/kernel/syscalls/getpid/getpid01.c   |  3 ++-
 testcases/kernel/syscalls/getpid/getpid02.c   | 10 +++++-----
 testcases/kernel/syscalls/getppid/getppid01.c |  6 +++---
 testcases/kernel/syscalls/getppid/getppid02.c |  5 ++---
 4 files changed, 12 insertions(+), 12 deletions(-)

--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
