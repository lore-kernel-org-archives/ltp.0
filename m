Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB4CC433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 02:45:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ADFA3C9390
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 03:45:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7E33C21D9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:45:40 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 841B260081D
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:45:40 +0100 (CET)
Received: by mail-pl1-x630.google.com with SMTP id j16so7235640plx.4
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=g2DZtdX9GrbLHMGM4U7OYrfzPkddxIKgpPOEcEzLmsI=;
 b=al1wDZMN4u+7BM5+bWmaWERtpTUlYEJ6dEkS2xzn0b5NR+1tp4VVIZGCalYASPS/2w
 SttnvqY4JrJ+OT52ik0I+7IJpP7RvbL7CLn8BPq3ux9VIexcOJPL9VFtEICik2D1ilBw
 P2IdiMWgfIJHE59ZZ2A0Hfyg1p7vzWOZ10Lb/XryOzHdhaEBN/1AktEzN1nJIk2UbZwN
 L1ytooo8VcsPyvGAoEFoIrrCtb9dx90wELZCK35aWOWUfeUUSaQNamMC69CxxmHyaJuJ
 eRi2hpCju8StKaoZAvlyq2WXXdxjlH9AGef7rrpkVeeQiHkJc6fozuclEAUs3ujzewJb
 PRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=g2DZtdX9GrbLHMGM4U7OYrfzPkddxIKgpPOEcEzLmsI=;
 b=B0k8VpSOYm1KwWsikN7AjEjCv6Q/QJb/HH9M363ijvxI8HAbdypBGEdZVwzkrBteiW
 uIdWS1EkAVxhPcc9fLLRZOF7kZFp20RwouANHAABJU949hLSrEvrIJXvYbhIz2QPFOer
 Wxtp9xl2GmqbPSabuexyccqbvddBnKPBtNt9Kgra+Lg+yMOURgcbMZMV5LzuG+EGMoyN
 NSWL/F7IOU4ikNIy/SJTYhyxjTPxqryLBcGpF0yKztG5KGJitQkkL1zlqsmASFduAEtE
 oIPDkLmu/5O5oUGykYjGRi0ERn747U81U4MfvG36+eFgGL35f00W4SKLsRlQan5YrIOy
 DZdA==
X-Gm-Message-State: AOAM5336PvLQmzr30/0WTJHvKAyQaGYfusROnRsvsxdU6pg5PvPc4g7t
 MAOb9lnP4aL3bj+d4B9r8yR0+z1/yBU=
X-Google-Smtp-Source: ABdhPJwxeNNVhPnFozfdEqYRoPtYeLx9lkK7vinfeVDud4IjOscE9JqsPx786fW+wE2TiwnMPEXjfA==
X-Received: by 2002:a17:90b:1d06:: with SMTP id
 on6mr1354143pjb.6.1643078738395; 
 Mon, 24 Jan 2022 18:45:38 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o18sm17933684pfu.45.2022.01.24.18.45.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 18:45:37 -0800 (PST)
Date: Tue, 25 Jan 2022 10:45:34 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <20220125024534.sdrsppor2n7s3pjb@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include/mk/env_pre.mk: remove dup makefile sourcing
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

This will cause file not found errors.

Signed-off-by: Murphy Zhou <jencce2002@gmail.com>
---
 include/mk/env_pre.mk | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index f36215167..f913eb5fd 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -88,9 +88,6 @@ endif
 # autotools, *clean, and help don't require config.mk, features.mk, etc...
 ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)
 
-include $(abs_top_builddir)/include/mk/config.mk
-include $(abs_top_builddir)/include/mk/features.mk
-
 # START out-of-build-tree check.
 ifneq ($(abs_builddir),$(abs_srcdir))
 BUILD_TREE_STATE		:= $(BUILD_TREE_BUILDDIR_INSTALL)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
