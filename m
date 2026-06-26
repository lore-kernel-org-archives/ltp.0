Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D847BCDE008
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782465244; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=P8sJyFLS1Q/Pp9w2EA70LKVtcCcepi4etBKiVRHSnuw=;
 b=imleVMCdV71JcYtpRus9om+FXKlQrHIy7DhbhNAyK0De6QC7p5IXzmPnSDwgzO5ZOpEvS
 gXf4AG6J1qN77F98ux5VsxnT3QC8k9/cDMNV/VPFsZvvrPyve+WzNVck/xHCsGw6C87ghEw
 OAq5besudZVEkZvCFn9phcfo1X/vn44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6C0C3CD6B2
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:14:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E04223CD6B2
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:13:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E76E51A00368
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:13:42 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso3889545e9.1
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782465222; x=1783070022; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jF9nxh979uLTv1rfM1t9RESVSq0WTwLc/CuYyDdgM0E=;
 b=KoFdtaWO4pf2ki8ehd+2eSwZKUSfM6y5AK/U5jNWjUbKin1memU8VjBMjAgDa2ueJJ
 5o2mgtZyf/hS8Y2v79GByuzNS1wwBVA73pk72Wh3b5zPdH/HtInBgttZNd4GS4a7SL1l
 EV6OoeatO7NLRVRDMHOpvYY4sVeYaep+9gA7u1iyNrSDwkgcPCDMg8K5EogFKIOX8Om7
 LsB0PH4d1rhR97zFutFTygg5ijwLquFVPrJmCGf+2oxmfldY/TvGRxkA/EXpG1KhtiS7
 t0m/Zs7dCJTc9kjK/ubNoC3lDRDv2OKbZ3sJUqoJ9b2gKENUawFBTivih/zC686lNwcp
 YbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465222; x=1783070022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF9nxh979uLTv1rfM1t9RESVSq0WTwLc/CuYyDdgM0E=;
 b=nd2rAyxX0N7Y9kOoS86OoeunvRcsGJApbiGFJryfsBp6ovwft5J+H72igmzQ9SHiO9
 9LKrNBDtPvbDT5q8HUarMfif1JFg+5+yFmZNVVBljqDVELGkPcBmpOPTEJtMj/FZQOUU
 SLTJAUB4ikiwxY4ZgZbkMeuYp3il0N1r+uLJxgPvrAAlzNU7PIj+pZy3gGhd4MmjPGvf
 l6C4Zwzcr951cRnfbKIIu3NQiw3ukLlIyaR4FWa+HjB9nr6j+gWtuw2WXENOC8hHthZu
 /ZO8/OPaBYIc06kML8nLWZukSNZz4Rwd83xVyVzvtXDDcF3swBYLS+1ezGywP3I1RUv4
 X7lA==
X-Gm-Message-State: AOJu0YwD/vjrsKS6fhT+cjivzECUj8gCk4t3qnADieU6KR/X7j0TW7Yg
 Xs2PZ2DL8AP/OC04k0oSuLK2ySvbPt/zH6H7hR1ddKJ4N5aSQKx1LA/OHWOM+4sORgKVvjZ/45d
 ATnY=
X-Gm-Gg: AfdE7ck72YFf07ORmg72Zhyn2lC0lPxfAlLdW3fs9iVSOEUJEkAFiAREA5xgVa9Jpk8
 B4JWFA4kTkLOi8LhXN5ElSy+XrcSFcaSm2mSCuOv3LI0dTMXbOxxHWH+QQL+slv6NKP+XKFrQ4Z
 0kflWxNi3FsZH+bWpqg3O2Zi/EJkmbBAzHGiE7Xm9Fr/4euAwTzGR20VV/BWWgci+dVqk9EZJjK
 si3v6HdnOCMmjJDlzD8lp7JR2bdzwg4zxdpqtqjwBte9S7WHo/HLoM57NGbME6QlE/a18x+bOxT
 EDTGijZ3lIDPsbNfw66i8D20vRSF6GlRpYt5GncTL/kMgk5fBzSqh82zRtA8MeuzsM3v8KI5s1f
 sVX8Ryl7vFwDhhXNSavEqTAO+gXWzfcabp4oQJjgGMZfca5CuFtrvQ0VtSBDrY4T3xNb5PS8Ft9
 iq1v6OHkXt4Ls=
X-Received: by 2002:a05:600c:1d0b:b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-492668a0a5cmr81904575e9.31.1782465222193; 
 Fri, 26 Jun 2026 02:13:42 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-46e95f3d71fsm6889000f8f.12.2026.06.26.02.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:13:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Jun 2026 09:13:36 +0000
Message-ID: <20260626091338.15509-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] set_mempolicy05: Require CONFIG_NUMA using
 .needs_kconfigs
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

When CONFIG_NUMA is disabled in the kernel, the set_mempolicy system
call is not compiled and returns -ENOSYS.

Declare CONFIG_NUMA in the .needs_kconfigs field of struct tst_test.
This ensures that the test cleanly skips (TCONF) on kernels built without
NUMA support, preventing false TFAIL results.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 7481dcd8d..e9c521df2 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -115,6 +115,10 @@ static struct tst_test test = {
 		"ppc",
 		NULL
 	},
+	.needs_kconfigs = (const char *const []) {
+		"CONFIG_NUMA",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "cf01fb9985e8"},
 		{"CVE", "2017-7616"},
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
