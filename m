Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F0FA0C2D
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 06:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776233274; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=vwIs9RFo4vIzhhmX5NKEFrg9dYjHnBhKp9HhFoeRyGs=;
 b=OnYAHZ3/004I8QILBtol7kvlqMOTRJ9WQoIAgdBoTswFEt+vHvpZnPgRZ5rs75jZJRmNB
 1iyARXtUZi1QcyCtw7XdQWqIHsH37ZR74aswpUwLLnURuOW4W5bmeYmEOrrtYafvGRVC3jx
 uGMRFFUKqd3lTZkKmcGdJ+rQPxk17FM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63613E265F
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 08:07:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D0103DCBE9
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:32 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B87D0600802
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:31 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso1918233f8f.3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776233251; x=1776838051; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMJuShkmv9CJcJZ5ezrsqq+IQg8tfQ2a+tpblx6Pkyo=;
 b=c7oavEvCXjTIllxjHgYLSu5lJ7LZS2MQZdP1sHki4CLljWFB3lE1KfBWVS3iQwRBFs
 u5sHasog4t9vj/d/RAEv/JubUSXD9vWR/1H3BLGXBBRpqE788pptN5XC/lnI+yi4Oge7
 jl3CudA6ydvD/L29D3Ucno6TSiZjsl5e2p9/PP3zfGnWx8b2Xf7p8eKNFzb7ZWUCjAfn
 v6KWEr5V4STYXY41dtwcdNQoO13T0LyX5zuIUCbQ/qjFxE+2q5eIM0IGVtlu1N2fCcIC
 H+lqYseNsdNh3bRa3ZqlnMdXmq+w4LxOdxuOzU1W1LcQcCBSo6KoM4eXRjAKc51YOSHi
 6OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776233251; x=1776838051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMJuShkmv9CJcJZ5ezrsqq+IQg8tfQ2a+tpblx6Pkyo=;
 b=qt33GLwtufb365oDWDeVbPoN3ag6NeMNKcFzzg/CuBJaWN98rTIumqHYrLBuSrk7s+
 RguLC28ZZRxhuY8KJpnfL13LTOI1iseEKM5mbKLnbdOvMvvz5gjcseiu4tLYgX/9CiUb
 6bdAsDYFLNqWwUZX+aBek37ad+0wILdk0BKy/65lu8Lb+rvzd/pvd3XNnPTsT6Qexggp
 O/5BhFp5m9mJZ5CZxnLp4MiG0RATP1v13H1ZqUfG/r8wYGgD3AYNpWLm6845yO2Jc+At
 VcV2P7zhqXIDoRJ2inZJyaY8ezMsPtou/GiOSOADUkHn2GBEdgkHGAnapSZBa0OOyxIm
 h5AA==
X-Gm-Message-State: AOJu0YwbeYhkrwRGHHrlipZT9BacQwsvcYu1xHKjGZMPisGJIcEa0+vk
 ZyMfGQWUeuaDwgEDyz/qU9AGMBOO4qBsEAG+e1qa+0icFfp/jgE7e4z01GdmUODHhsQX885n9Fv
 lhks=
X-Gm-Gg: AeBDieuGlsvz0LjYKp7QozpjDsJ1egZTJY0SahJ0ywPX2GcSISBdcK5lb9c3Z5W7O3a
 bEi3zqjkOQzTu2ElXl3LIfM6lGvHwkGy9B8UKfg2uoQk+dDV2cwNM9gsDGl6n0iQmmd2zAJFGPu
 KlZi+ZIRp07HwPumHLxWFOopJIRk2OypUyn3pJzgCdkRB7IjGrutA9ftTBeg9nu+wsdynH3FiKi
 NXSwMDKBoAcWhjCyc6oH/cpnM6Vu2fq2Yj1GBC4ebIj4jSfZXff1M4BYbblPYOlIPPM62OgS7W5
 oCskuTjYt9UaOTfvhnreRhC3Sg7OEiUgDWHGcG1q4ppX+djSuQdgvTTlGlpWQB3AiTV/QeV82L6
 fKXd46J1GnRzvWWpzgJiKy6jyDdAK/wDrud2U4ChCTMP/2RWukycg132QzipcftDC6xdKRNT7UF
 Y/GLAEL5b239Y=
X-Received: by 2002:a05:6000:1847:b0:43c:fde6:2126 with SMTP id
 ffacd0b85a97d-43d642c1479mr29464301f8f.37.1776233250829; 
 Tue, 14 Apr 2026 23:07:30 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43ead33d6d3sm2396873f8f.8.2026.04.14.23.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:07:30 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 06:07:15 +0000
Message-ID: <20260415060728.21662-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723154610.3860563-1-wegao@suse.com>
References: <20250723154610.3860563-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] open16: allow restricted O_CREAT of FIFOs and
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

Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

v5->v6:
- Remove unused FILENAME
- Initialize dir_fd to -1
- Use tst_get_free_uid() dynamically find unused UIDs instead of fixed
  uids

 include/tst_uid.h                         |   7 +-
 lib/tst_uid.c                             |  26 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 129 ++++++++++++++++++++++
 5 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
