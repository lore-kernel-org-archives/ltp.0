Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BC606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 02:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=WDrHrt9g;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=V2KMlqEb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793586220; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fVHSL/xvZ9EjGNtiPjm14j9lRxDRHKKwNwwgOuC76Bo=;
 b=WDrHrt9gYZEmLkim+AyjtiXov4Y045BIOk7bwUr/mUE6dzb5QfKGiQOdxWCYofVv1hM3y
 ZhgM1dpnBZ6C670Myb7gPXaGaoUlogy8evgIgCwXEo3U+ocUmsKnWkiYQ45SCFbM+O6zknQ
 6zc7UXX6TkVOMBMRv83zicvkOpb2q4A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79FDD3E059C
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:23:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73BE3E05A4
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EBC44600647
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 03:22:54 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so26372105e9.3
 for <ltp@lists.linux.it>; Sun, 01 Nov 2026 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793586174; x=1794190974; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4R6s8/OE0P4oCwGkW64UfRv3BsTAQxs2ARKUdOFvio=;
 b=V2KMlqEbCfmGaJ4g/khIYBAsCoAJcMRo7SUkdhcu16Q/VBpgpTpCiRFGUO6K8qPKCo
 9+vVLIGZxsDOSmHUahU5hC4A3VLxP2G3adFn7HOdlSu8/OQ8lBEyiUht3aMu76YYQbNw
 T2pgIFiAJkJsF2meTxwsdARl+RAtaaNsQ3Sxwd/wEVZSgO3NMMaQgxUYOEUP6e2O9F78
 K2T71+Mneb7ygt+p4ehdUmoOYew3Q+X5Oe9eQ81TkzP+Lwxte2AyDP6aDlSRYEpOIHpk
 XUkzpdIcUV3ywd1Qn0hGEZlBKfJ5xjpDRyH8Jc+Ir+pYiRlaqDCpUEw7FqgXFgTmROWQ
 xjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793586174; x=1794190974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m4R6s8/OE0P4oCwGkW64UfRv3BsTAQxs2ARKUdOFvio=;
 b=Fvq9fM4JlcnehYwXmu1kmQagWuECGndlW/+h/YsHW+KXa9RgHdYmemrjqcFLvjxOkJ
 lsuXZTgDJD4VDzGHlCMNlJsOO8jEGxx+du1lqy2ZhZsur99V0Aq8xPxSbmPNEWozAwgn
 HIc0AYX9zvUIz+2yCFgzX25FMVLDz9JxilxqmmVybepvXSMa5oBG8QhnbejC1LjkunB6
 JQ2oCWLtgupN0GoT/v8SJ7yJ/TEpRmMjdHqCLo6NXBS0z7gEQz50F0UiVnCSRYbaXeJh
 SvcQxQ1Nsa66mWR/1h8sExFcBBJNNXOCDUlUq3COzac5+FE8Mw31NjRF49FsofdydGrs
 sb1w==
X-Gm-Message-State: AFq9FYK0zJPSq5blCU/0zlWu/9HbOSbJW1qDfU5hJiCpGlZThs2bBPu0
 gadK+2SVYiAWhiLzjx4hcrnLFmzKJK50erwq2cJRo1vW4iY1LSZL3Whq+kE9/x0qRGQehAP/8Zo
 xZjU=
X-Gm-Gg: AYBFou0LMUVFo0k3sE7LKLYJAwO/FObPNHGbfkvfJdy4NTfjWy+4g4XnnoM/HViuLri
 Et0ukGPm9o4z+Y1itk5lep7wb4OceHegONXB+3CrfkWlIStAYhWXp77uIf/fzj88iF4Rtu/7GVA
 DPV533WpNPJCkEhVzdaZvrZoP8DFEyuSPW/Aq73+XMIdR6AQVvOs4iroqY4U2VQ96RTyQiKnlSd
 gQM2gzzzoMham0Ka30m5qoD6RYrKvAjh7dK92JHRPWuDnLiM7iKNfh16zUts7IWUTZEu55KIuFN
 hE3/+jLtc+Jkc0ZRfTdmliHJV5ol1dWtrjuvZc7RppqD1zFqn4RnEb48DoF6Uh7YSlRo3PRXYKD
 z2fLPmgD5cWxOA6vQ0tC/Nd5cj8GlHIN4XbYhEUE112lYa5TE6EkfscjTSbCRLfMRTPKBF6Ub0c
 Yj/Q/9AkOm4+fV80zfjZW9uxoCegQVAMX1+aY8BebmKbdFMk7+yCGx8JvCE/Qis6caTDB4g8BtT
 jiJ5cRizlw77jVdmYNfoFYPCnP8lWjrtYlGMcjOB+ZgjxCvJt7jJL82N6elnbDOhHRCTeOOGNwu
 oOz01KZY7re+K2qBCtGPYNt1+GxM4FNUo4lf1SlXJEZran4XUiYjzr5h+EXqICSAhzN3yer7GsO
 eAd/ofUSU3U8JPc9gzts=
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4ac17b2ce84mr219720595e9.6.1793586174367; 
 Sun, 01 Nov 2026 18:22:54 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4abf6e63e0esm304765355e9.12.2026.11.01.18.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:22:54 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  2 Nov 2026 02:22:38 +0000
Message-ID: <20261102022245.3922-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v18 0/3] fsconfig04: Check FSCONFIG_SET_PATH
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

v17->v18:
- lib: Add tst_attach_loopdev() to find an unused loop device and attach a
  backing file with exponential backoff retry on EBUSY, preventing race
  conditions between lookup and attachment.
- newlib_tests: Add unit test verifying tst_attach_loopdev().
- fsconfig04: Update create_and_attach_loopdev() to use tst_attach_loopdev().

Wei Gao (3):
  lib: Add tst_attach_loopdev()
  newlib_tests: Add tst_attach_loopdev test
  fsconfig04: Check FSCONFIG_SET_PATH

 include/tst_device.h                          |  13 ++
 lib/newlib_tests/.gitignore                   |   1 +
 lib/newlib_tests/runtest.sh                   |   1 +
 lib/newlib_tests/tst_attach_loopdev.c         | 133 ++++++++++++++
 lib/tst_device.c                              |  87 ++++++++-
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
 .../kernel/syscalls/fsconfig/fsconfig04.c     | 166 ++++++++++++++++++
 8 files changed, 395 insertions(+), 8 deletions(-)
 create mode 100644 lib/newlib_tests/tst_attach_loopdev.c
 create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
