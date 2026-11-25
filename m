Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8904606A32A
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=jeyizbuq;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=COTj1RSC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795596490; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=U1Km9P5xfj+jGZqCIMYUdYJbkjinkHTtSeFxm6QQ6/Y=;
 b=jeyizbuq0TiKA6jb2+u/lAv+K0akOQj+vByiuxA4SYUXp5NKYPDYtPN06f875OXs3Qcxi
 sQRZtcVZwLC/opXZorSOZkkNZg4cG4COXYv13rRxcVLYTSAePAUIqVT11jeX+hdjz8EQFBK
 sDIArPYZfsu93mtm0RxyHnzR4XrNnCw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BCCA3E92E1
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 09:48:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89BB03C9D7E
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 09:47:48 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 020896009A4
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 09:47:47 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso3663215e9.1
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 00:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795596467; x=1796201267; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JVj/9TihgUfNGmo/Zz8zx3rA0ob7zrrtxIhczJjtbek=;
 b=COTj1RSCwu+OfEWFPHKfxzMwwPngjEqOQE019PJzBN3acKCZqgQ4Eyfy+480w+Z/Z+
 LYNDPIunWElnuD6FtOKy66zt6oBbcTPoeUYUj4sHgqY8yOBPnD7ulVcefYKu6GbgE35S
 48rzp8Vn2NWiaC8vLDJZJ7+QRksgNXdv/8sj0aC043wceDLpGoHaKR66OrPnmnLWqTuu
 E7y0nqy9SIwSVM56+m9yu0z0M2J2mscBD7wBg7dravrNrCXhuAKC38NJ+Sty51N0Gnq2
 ueNvZIxRepG8qfSu1yWMBMcmStqQ+GdkmYXJ0SPc7tv9ZYjRAQHpXKC+OPp0v2LmcqRk
 avbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795596467; x=1796201267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVj/9TihgUfNGmo/Zz8zx3rA0ob7zrrtxIhczJjtbek=;
 b=I/41zbuZ3RuO6FBzz1YBlINerTviK/XhkVlqMjX3di6V0upukr9sVR008Ec5UYbbOo
 0l2Hxvm4UVhRMzsdjjl8ryb7nn9EGc/mWpwPverBjRbPui0Q3IzGgRQfYZ6sX2WGQFt4
 xCw/b3+ozDMuutHvfa4sZadYQYoukyWLBDig6PJRbWNkdahSiGdiqaR99TSfdhb8UqGf
 QaHyUe6LenW3F93w8eK3/GqPOCvMPpOem5m5XPeMfog5pB7Ikl8CRdJ/pvTNnXiPsaNL
 ArtHxVXqo6ZzoSY7xvIX3AbjXjN9j8BvWbrFxgm85KY4e/f/x7ia1f0DXm2bHhiTAmhi
 dxSA==
X-Gm-Message-State: APuU4Z/0PMF06qeixzslWyekMxAHE2QsrYQq16bO/ZX4A/1UmeJMgy6Y
 /uF0yOctx9kV4OuClHHW0bsVPSvdbzrDc+NVu+dc75e1fqrYKuDVhuzqLjk0KiGU2f7/pAh+7iW
 iyyu+iJ4=
X-Gm-Gg: AZFdTZfnVNLUAJ2YOc4MBqxJnsiO1FwbNOjWZvWzwAI/66REDx+YMDLFcyIxl9xj+PI
 6PRrWUadxKK5BAFmlGP9QXWi3w0oL5eeIgw+5zXJz31skcU2FRqmr7p8bckysDJ4mGThPmwIf5L
 QSrWcufl068JVhqesQWJFwL2chGohLPq7PwRkLErds8nL1jrj4Y6ydR1JNGwgYVAPjcT1dOzQGC
 jbMET8XpCc8Q8Qkzc+JgqsledtF0L037wYf/4gGjYwZEgbSv5x/Ovj35HKADVv6j0PcBcJN3tyk
 z6mUoeZgjSYL5LVFQ6cQlbdlG+SeFOUykw1Opjk0zZgBpLLCt0Dj9Qa9JKLexeqv2fI6ewodx4R
 GPFpp3u0R9nKDNAr6pFsMt/Njhrf+MbFEHZnZ1y/BSDnTNFou0f5dy38XwnzKd/CapJEQN8vnh0
 Odf+hyh5xdCUvOTzXmIERK4zmB3GhGS7a2cNz9sHRwniwihhKT7SJh/xOTgJApnUl0LP5kNF3jo
 y+sD7TuxJdSba2gi5UacJ0nFrN9D++GRlqsh4s1AU5cbhulBP6PIIbjw86h+BdouoPRkXK4xZns
 i6AgQCGx4RWppiAdV6//BncqJMC1xYk9jdGUCV/Eo5QsFYv/nw==
X-Received: by 2002:a05:600c:3113:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb88816b2bmr368166625e9.27.1795596467342; 
 Wed, 25 Nov 2026 00:47:47 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm34206066f8f.11.2026.11.25.00.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:47:47 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 25 Nov 2026 09:47:45 +0100
Message-ID: <20261125084746.122593-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] build: Build libltp before 'make modules'
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Since 3cb6144e0834, libltp.a is only built on demand when make is
started inside testcases/. 'make modules' runs each module directory in
a sub-make, so on a clean tree the userspace binaries there (acpi,
uaccess, fw_load, init_module, ...) fail to link with
"cannot find -lltp".

Make 'modules' depend on lib-all, as 'test' already does, so libltp.a is
built once before any module directory is entered.

Fixes: 3cb6144e0834 ("build: Build shared libraries once when make runs in testcases/")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0abb5c6b4f67..e2c8bf37bf29 100644
--- a/Makefile
+++ b/Makefile
@@ -222,7 +222,7 @@ MODULE_DIRS :=  $(shell \
 
 
 .PHONY: modules modules-clean modules-install
-modules:
+modules: lib-all
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
 		$(MAKE) -C $(dir) || exit $$?; \
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
