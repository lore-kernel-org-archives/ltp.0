Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E511ECD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777530840; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1RnTtgW6VW5GU07GUIJTpZiX70YmD4up+Gqn8/PBbHY=;
 b=p4525k5o9OxtE1W9lf6iNZuysqrdhQNGKVM0HCBTXYAl++qxX0n0BQGLf9vkfLUbiZ6e3
 0EjACjDB9BTTEe49xe9pa1J72PTbglrQpemgZZgHruKWkZowvAMA49mYV+YSPzBcU8YCJZv
 fVmlmXNctcBCuVwGqKwXN271+oULIY0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36B553E2106
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:34:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD9A3E2106
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:33:35 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E42CC600069
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:33:32 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so4727715e9.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777530812; x=1778135612; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IBGVIiuVjT7zHc1anmmtjgfMsmIn50XBxZmtGtrK3xk=;
 b=MnnUA0+BBk9ftdocVqztiiE80IDWksyHh+kdpf+ey72KjGAyx9vGKJtcMMzPavO6qL
 gTylY1SFRFhFvAUNRQs7BdZkuv5n1fhatnL90AfGXpKc3FrZIV1T4ijUl46gZ08IaOzx
 bW/KoZNo9TkquSvjSlP8fy31ltF2J07PLf5UJ6AngDQ4JgE+V5zk+v2g9xOghbMpZD+A
 HDyhXjKxAFXh31HYtoGZ/wnGtbLH8vah1SehO/vd9fUPajBRgdII7YfI+CpnMLCDQuCV
 r82wrYttdicTKYS6tDNMqbplnNIlHw3EOTK+/fisNIID1TtecLcsAJzYy84SowxsA/rM
 K1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777530812; x=1778135612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBGVIiuVjT7zHc1anmmtjgfMsmIn50XBxZmtGtrK3xk=;
 b=UyE2eRaA26Ek5BfbZ17N89DKqBEjBTcsJFTrTZXU4XFhvkcsJAg0VE4j3NatkwkrJu
 OUDhVxcVj09BAaOzcAOmQ7m5Vtss3FS07sWLjjseHWZmCfrZSb4uXeEp4UI0kp6qYNt9
 XDnKyaeLENlI4TOOPXHi1agDytmh08COxpC6X+z09ScBJQ06Niv51nFgsOgzr8aETaqO
 1PofQz2fdbDipjKFuZJQieVLytU+3CXEfW2Kofh9yvQAkRvdUiPyRBEiV1cvbIrgKjB4
 sLddIFtqSoNoChKDj9eXM9z/IG/KHAp1rCk2yYX7nqB0wAT54NM+54LT1cp6t+N5MAzd
 djng==
X-Gm-Message-State: AOJu0Yyt/j5q+xaSAJhfGdZg/ZYcM9SC3Awhar9n2jGiVNyN6sYz9GMt
 XC/PSYuQ2HNtvX3PxKImsS2BtQRodF2uG/TnNIqVkhIpd7GggiX9dbZro2FYsYOp9m5H6+hmnMX
 bhqkS47g=
X-Gm-Gg: AeBDiesckx0PMQYYgXrAYlE4D3dqJwCiVBOQMVQffTflHXljgfftBGr3oRv6uKBmP/6
 b+a1laNU0OUM/LJK2JKX2ZExyjVE7a3tWFJ2WbNOePDCApEU6sRbbC+bHeICu8u1ZnAuIGEg1HU
 tQTPGyJnmgVI3hxkyVggIwthv7XCxRTf91wnbbUPOhLu65TQzW6JpBvDmPZ609+l8KBs2SAruQY
 JxrnBDKhm2S93plA8w7+rZVaNtsH/2BpvFX39cORvFFTX0ASwcLabQqrLEA4V5VEq8urzs59uqM
 xy+ZPv64V9AGTo/KARooMyxwy8GrUQ0RhtJY7BoZbD2xsUaCd0bxSieKLpL3Bx6BU6Cd7LpL2by
 kfkUsTrBaFV+ELh2UA9pRnfsmNLu65j9t8SQz1nNVB3oD5DntJCjBOHeFcx/Holo5NWqjM3N3g7
 epzjcu7F6lxRyg8s+ySCYr2kWUIN/0yIHsMaD0XhYJVYZPzR3kfw==
X-Received: by 2002:a05:600c:8710:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48a844448f9mr27108115e9.10.1777530812112; 
 Wed, 29 Apr 2026 23:33:32 -0700 (PDT)
Received: from localhost ([2401:4900:88d6:a675:2691:5d4e:58a0:eb9b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed6bafsm70474645e9.2.2026.04.29.23.33.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 23:33:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Apr 2026 08:33:23 +0200
Message-ID: <20260430063326.53566-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fsmount02: fix invalid-flags test failure on
 Linux 7.1+
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

Upstream Linux commit 5e8969bd1927 ("mount: add FSMOUNT_NAMESPACE") [1]
introduced the `FSMOUNT_NAMESPACE` flag, which maps to `0x02`.
This causes fsmount02 test failure as `0x02` value is no longer invalid.

fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)

Use `0x80000000` as invalid flag value to adapt test for this upstream change.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e8969bd1927
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/fsmount/fsmount02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index 55f0e2f28..934d775ab 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -19,7 +19,7 @@ static struct tcase {
 	int exp_errno;
 } tcases[] = {
 	{"invalid-fd", &invalid_fd, FSMOUNT_CLOEXEC, 0, EBADF},
-	{"invalid-flags", &fd, 0x02, 0, EINVAL},
+	{"invalid-flags", &fd, 0x80000000, 0, EINVAL},
 	{"invalid-attrs", &fd, FSMOUNT_CLOEXEC, 0x100, EINVAL},
 };
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
