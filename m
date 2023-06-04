Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01392C77B73
	for <ltp@archiver.kernel.org>; Sun,  4 Jun 2023 09:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F243CCC0C
	for <ltp@archiver.kernel.org>; Sun,  4 Jun 2023 11:51:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2980F3CB881
 for <ltp@lists.linux.it>; Sun,  4 Jun 2023 11:51:23 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4821E600705
 for <ltp@lists.linux.it>; Sun,  4 Jun 2023 11:51:23 +0200 (CEST)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6261367d2f1so29624706d6.3
 for <ltp@lists.linux.it>; Sun, 04 Jun 2023 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685872282; x=1688464282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYzanZ3RY4epTMb+rA9DzLCzNCNbAajOhuDfDo/mPuc=;
 b=SolBnglG+hyGPA6JLFWlosgaSKzQxj+klsUFo/+pGnxK3gyt49nNSZ5EZ+RT6zstvi
 nfWIzvZ/rKZmg9EVOoGqtkRpG56QER/drAT4csLwan5aTAAbHKzwBJCPSdo+YiQKot0Q
 YVq9+w16ArLqkmjnyw4rSekH4RTgXCiMlX5uI5iyQi5wM/gaUMW/sMXH6rH92xN7oBsj
 FyoLgLRO/0AIikn8iCHmeeND/QHSStR+eRVUtI4Zz4QdsQLUSZZKW8Le52jNnGphz+/b
 uZQuZAbLKXQI7jMl5hofDrqY4Z4xgi/ShMpxCGVCIVwm7Xg8q7lz/rN1iIKL4TruVo3Q
 6oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685872282; x=1688464282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYzanZ3RY4epTMb+rA9DzLCzNCNbAajOhuDfDo/mPuc=;
 b=X+JWIA1dU+7w7qnDfILup2y2ZxoRqwtQrfMHViRBK0oeo5Qu5s6W176d6ZyB34oIBe
 AH09aa/Zls2X8CxpxpYgRbOwuGIz2PcTypPuDa3pFfgUTjafFSqu+ZYN2EuidxcIBvRk
 SZ1E5JO9TDkog4fBF5mwTLFikq/pwjpG0092Cw6YQBZCA+LNIPmP+Vvg6WjWvcqCkR0j
 sGlO/iCluMJ+eMbDAoRks4oa6z+hHSycA1g3TpJCBLu6ZYkFNM8jjwz+03WAix+Ie8Sg
 EAUQIW0YUNjpfdJ4ZAhmlkkGz0WOcl0HfX0ISXATS0FtawtIJro9hJMYgV7VThps5YCt
 MQiw==
X-Gm-Message-State: AC+VfDwD8NVYwZNqyT/pQL5/GiZja5naY+25S7kuKsl4qUfj0sdpCSzx
 HzCHnvo+EWgs55I4oRwyPVAtjiF2kMw=
X-Google-Smtp-Source: ACHHUZ7sAWyv4WhpgflXCJDwijSNKBJT2znDTX+fFWa8JRd3yLGcce+2N7lh3xq/95OjmYtWmp855Q==
X-Received: by 2002:a05:6214:cce:b0:623:638e:aa20 with SMTP id
 14-20020a0562140cce00b00623638eaa20mr4444280qvx.51.1685872282058; 
 Sun, 04 Jun 2023 02:51:22 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a0caa15000000b0061b2a2f949bsm3141335qvb.61.2023.06.04.02.51.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 02:51:21 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  4 Jun 2023 17:51:17 +0800
Message-Id: <20230604095117.3543342-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] SAFE_MOUNT: print debug info about mounting operation
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

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 lib/safe_macros.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index af6dd0716..a66285a0e 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -898,7 +898,24 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const void *data)
 {
 	int rval = -1;
+	char cdir[PATH_MAX], mpath[PATH_MAX];
 
+	if (!getcwd(cdir, PATH_MAX)) {
+		tst_resm(TWARN | TERRNO, "Failed to find current directory");
+		return 0;
+	}
+
+	rval = snprintf(mpath, PATH_MAX, "%s/%s", cdir, target);
+	if (rval < 0 || rval >= PATH_MAX) {
+		tst_resm(TWARN | TERRNO,
+			 "snprintf() should have returned %d instead of %d",
+			 PATH_MAX, rval);
+		return 0;
+	}
+
+	tst_resm_(file, lineno, TINFO,
+		"Mounting %s to %s fstyp=%s flags=%x",
+		source, mpath, filesystemtype, mountflags);
 	/*
 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
 	 * the kernel's NTFS driver doesn't have proper write support.
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
