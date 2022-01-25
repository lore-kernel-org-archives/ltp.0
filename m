Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A44C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 02:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A66A3C93B7
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 03:50:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C29443C21D9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:50:13 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 622DF1A0042E
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 03:50:13 +0100 (CET)
Received: by mail-pl1-x636.google.com with SMTP id x11so12014746plg.6
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=eQU94wOd1uc2l9OeM2350Hwf19qGWFvLrPhexh4olxQ=;
 b=AouARl/iCtahc8fHCGX1f2BAZUBFQtDMVSXiSo2c+doRIXhx9EWnF32J9srJFpUHPZ
 9MEqINlHQV7Oja8toKYfMFVZc0/2y2XLTVIWd0Zxc8CKbcUUFj3CaPP8XBn+zpwFmGZV
 7NzztbNcNIKoz2oOTx9wxSDdHVWniV3+mGd7cBGnCjeISXfNzoHFGtVmv+TO3Di4zkiB
 8KwsYsLA/t1PBaTYzcdPScvP7lJacGHWXUPqqqROcDrKRROiNYJ7heYsnk+rTyEoXn6U
 bPr4ETwbA4NcoX5NYtpGr1eYLR4+Hr4ynz+vseplctBFl6fDqsTmAqDTdRzPa7MbT/sh
 yaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=eQU94wOd1uc2l9OeM2350Hwf19qGWFvLrPhexh4olxQ=;
 b=m5Sm+0UFtIa2lMUQOD0sJTCI6Q4ieJTlOdaSpnfYEvXOXS1+uAikHMHbiHoYetzroS
 y7DmBvEfACwxGFbuIZdAoXxPmNserfmYf0Xqj3dVD1vESlsQLO/EmZhMsxqKhFkGPnYn
 duMflvkiJ3DXP9/KP0OZZonSnR/XP+9WLI2x4nv/fPa1o/c5GNrDnDEdW3zcqDZyHO2y
 t4uPLDr/CdJqCD8BfRh5kbZBn/IyNJrX5riMoOYSE1Z6ABC/+wJB4nIznQSXQZEdFvhh
 9IrPRyDho2G3oJ31sWluUFcdMdtyRTiUCzjC80Le3L+C/o4DYNVxBWxUXyltVlBGxKcM
 Ckag==
X-Gm-Message-State: AOAM532Dyha/A4aTXBisDAWO9+81V9/1D24O03kikUi5dHydNxLBh5eO
 ZsinY2PvpIAlDpQbj0Fv4UfCHuuyyTU=
X-Google-Smtp-Source: ABdhPJzULwIOALM9oHU54qgnU+Jb0CXRGqcCxqqvvTlBVfvx2bD71qLCTA9nZ0+6+6Gec9KXSqo0dg==
X-Received: by 2002:a17:90b:3a82:: with SMTP id
 om2mr1338661pjb.119.1643079011516; 
 Mon, 24 Jan 2022 18:50:11 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u18sm622718pjn.49.2022.01.24.18.50.09
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 18:50:11 -0800 (PST)
Date: Tue, 25 Jan 2022 10:50:08 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <20220125025008.xlnm3uwafi4dvaun@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] include/mk/env_pre.mk: remove dup makefile sourcing
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

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v2: fix sign-off mail address

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
