Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD8C982D7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789760622; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=NdMKSr00o0VmAXgE3rcjqlwtsUFo7fKwMQWKtxk7hmc=;
 b=aRDmyb2tMhan8FFsjwVf8UxW1P+RccDAxwMFY3x67szpU7IYjCwx7mABWx6TjUvQtuER8
 CulC0TXJbj1EEzRbEXpH8lZDywZ6VUXYqjqXSaKOvRE4iqbixd5qc2rD8amH82CruoHzPWN
 Wm5V1ev1YXH7KViH5AwfP6632ksnL0k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECD6B3EAE1B
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 21:43:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 416A83EABAC
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 21:43:18 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C2D071401117
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 21:43:17 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso14084965e9.2
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789760597; x=1790365397; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IvlDFAhvo79OBVvebFRodxa8/Z9yUtdfwjgLJXtp/6c=;
 b=eD6oytRQd5Js9hjS9/JkLWQmh18QLoF3jEYWni4hOP/EF8147oqESvWvNJIj63BA+e
 Dckdt1xlC47+bhqiusuMUjZEFuViXl3tiKuA+rAU5BxMb9paT23aNgtAqC79mwiyDL5T
 m/5Ry+1rOahffX18WQ6FI5+fX8sGPYL5bELQJYgWNtkIfnnfXKZWX5YhbQwFGixV1fB1
 8QtEKXv4rJzeNhuubQDZU76lujrsUruYezF/64Y6E0gjyXzMmIdIe3dTef8wIHKn+AA7
 CDQwG1yp6E3jdp+NTrFnp0FD67592AR/jpinZcbnYHw0/cnA/B3KTrLcyF8Y59Ycr+Ip
 o8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789760597; x=1790365397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IvlDFAhvo79OBVvebFRodxa8/Z9yUtdfwjgLJXtp/6c=;
 b=R1IWWjuz+6kDFwYRDAEC3KzegDrHS5d9eT1Nmxh54PuOgHCbsaeHYkwcroqhclj5cc
 5I+hYPzMhWlto/hUkwvTq+EfaEd9ddA/WWlS9cYvXWjpbyhxSMW4v1lNCBLgbo/pwrNa
 ibsL2ofHW8gYAA5rVJ8avwm/eSxC9GqnIwnp8e1DhhF6V5y75J+ngY5U1+vCMDUFyLYG
 tt8KJZ9/GmygDkOjcKQXwXVCO0Y5SQvU1PsNnzqK2teVJX1EefpobFEkqBEa4/wjjXc0
 SkdhxFqkr5V98fOjK7cj9MMVxVlN75rCfEk9gGtPiJGFbeTCh2F49B7iwjsv3Rsj3L12
 HN+g==
X-Gm-Message-State: AFuF++k+zFcbGvrqOyoatVSnQt/7Lfd5UCGtiyU7kqV/M1zDzQ3gn5gs
 LUCZ5IiIrwu/IiDbf/lwMDwjkB/nFBKZs9P7TF8xPP87+P5R/up81qsiu/Xw+PT6xCFzyg47Edo
 ZdDuNVpo=
X-Gm-Gg: AYBFou3aXMcYKFJBGrWCETsbj9h/1yOAV5WFi9KZ1R/Z7tIBIus6IfHnJ2rXYhVwZD5
 MGb+poDUdjrb/satNAO2zARGOJ+jtEtFA3/LNBM+ZuOuxvThiZWgGB3MinlsUx8uvPcMwHOME2w
 hJU882Pccuq9OGN2ulN1SQYHWKn9CeZBXCct3H5f6BIX8A2VGpn1JV1QTWoEpDxvL4sLtIjtQIr
 eXrIGuIDjwtHneKrF85Z9Jb/qNH1hXCKJ7uheQ4fIm7IlCVvFAGNjRkWtNlGDvpb4y89fjtrIjS
 AsRLxzh+aShH7y2uD9Dhw/ZV2rYW8pnlldTuVIxjUGwOnzc12oLfYa9nCDv0nNEzELNzMps4yVU
 74T1K8fv8wNB2vdCLTgup8eSlAzfOUSvbGIAgB3O2ewqhCS96cvUIPcX+emyOHHz+ifKXD9CYhr
 4osI4MWnkT6pxVmCAWtK//2PgZMDkQEz15GWf17f/1TyGY/Of1AHVG2XqnZA==
X-Received: by 2002:a05:600c:8b03:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49fc566e609mr43590815e9.3.1789760596874; 
 Fri, 18 Sep 2026 12:43:16 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm875564f8f.14.2026.09.18.12.43.16
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:43:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 21:43:08 +0200
Message-ID: <20260918194316.109853-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] coredump01: Skip pipe core_pattern under SELinux
 enforcing
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

SELinux in enforcing mode silently blocks the kernel's usermode-helper
spawn for the piped core_pattern, so the helper never runs and the
test reports FAIL.

coredump01.c:126: TINFO: Testing pipe core_pattern
coredump01.c:100: TFAIL: coredump01_helper did not report any core dump

Skip with TCONF instead of failing.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/coredump/coredump01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/coredump/coredump01.c b/testcases/kernel/coredump/coredump01.c
index c4fb92e4dcb0..15aaf8c56143 100644
--- a/testcases/kernel/coredump/coredump01.c
+++ b/testcases/kernel/coredump/coredump01.c
@@ -31,12 +31,14 @@
 
 #include "coredump_common.h"
 #include "tst_kconfig.h"
+#include "tst_security.h"
 
 #define HELPER "coredump01_helper"
 #define HELPER_TIMEOUT 10
 
 static char helper_path[PATH_MAX];
 static int static_usermodehelper;
+static int selinux_enforcing;
 
 /*
  * e_ident[] and e_type live at the same file offset in ELF32 and ELF64,
@@ -89,6 +91,11 @@ static void verify_pipe_pattern(void)
 		return;
 	}
 
+	if (selinux_enforcing) {
+		tst_res(TCONF, "SELinux is enforcing, skipping pipe core_pattern");
+		return;
+	}
+
 	set_pattern("|%s %%e %%p %%s %s/res.%%p", helper_path, cwd);
 
 	pid = crash_child();
@@ -137,6 +144,8 @@ static void setup(void)
 	tst_kconfig_read(&kconfig, 1);
 	static_usermodehelper = (kconfig.choice == 'y');
 
+	selinux_enforcing = tst_selinux_enforcing();
+
 	if (tst_get_path(HELPER, path, sizeof(path)))
 		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
