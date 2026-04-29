Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B6FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777457597; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FOZra/PLjT2YKkfy5ey/dhqEysI81FJnYgE2b37pH8s=;
 b=bUBXYsUHyMk2ubL/sGrU8BLK2JgRPEwp1zrAdlGXhv4hZ1Fpoe/KXVCJIPa84ENGOUSSC
 pCs9uHx9yq4DVq8pX9cxynWBNGt1S0V2K+BkrvwUitd5ByggvVBRrWMcztStzDulTVkJLyD
 o0ZrsW2wh5Z7p0sCYFMSDwmvvkawzHg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38EB13E2D48
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:13:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2793E1A9F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:12:52 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 59A331A00920
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:12:52 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so167285565ad.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777457570; x=1778062370; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=g2Sxeg6YgaqcxBDNY5o1Np5oxhNKj6kqTqdRq+c/4II=;
 b=wdbEbCYd03FzfE0sCCywkdYMP/EEzikCu/f7UYoh1d+jEZoPjyeXfI99i6LNaOuq2K
 USHSd0Jo6OhzC8rPPTifKKtjLM+hraOHH00FbPJaZ+aegT4T5M/QYFfm0TOK6gVpYkUs
 qjylRiESSdbj2cqwUopMJlzlcaWc0e1th64rdXGvE3OP3GBTtO2rm4/xjbJuRV0Gh3WI
 UVGA84jW4EBx4/zohd3FXmIdojAaRQILBIjD2iigdqPqn24ewrQHs69yL28afULeFLdi
 haLmtzdMLwtCTZFh3CckXEgPkETWmH3Wb+uqfxwgagFUY3XhGI3uSLVkJLAT3XM6otTV
 347w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777457570; x=1778062370;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2Sxeg6YgaqcxBDNY5o1Np5oxhNKj6kqTqdRq+c/4II=;
 b=K+z73spJVXSsoSnoF2uFaUAX5zBXbp2Gry0qIizZSUIwR5HZ+mlwUFrZORKVlXTvaa
 0oohWHDoZDGZ4OFOl5yHseNyu1bSbVHVW3cMtmrDqnf1Gx+mZemPF/ShnEf3STvuKsio
 6lJxjVkQL8UiSLkiIWTy+ycV8rur0htZph7qIkM5E2bFrURgrcOi+rTnFh/27PcytE9G
 ENwjoYNZ4UNgEBzVUBf9l3xlYaNcMAVEnM3LnnPtir8SaEIxKL3kwzkmZV2XIXLaHd1C
 IwX6abJ5kJjeHynX/Hyx9KKXGkP/P+NP/vhtPZm3QPJdqmgH62sWDy15PxV4Ucjzih0d
 uRew==
X-Gm-Message-State: AOJu0YxzZwgi+XxguKtB9YXZBo2tHmxcU3DOvZ/PaCMzxyJTtO+S/jTv
 jBgcGxZIFTdVMOohWHYQBf8DpYsYQvN8XUMt1f/i45ie/5HFgviT53mNk82ylH8ALlX22XOqy6W
 5//AS3yBD84DUJ+a/m55v6RGNTzUQUrXlGRGa9URfWpUI2WdRP2ZfIgrtLC43vszP/5oD7QrV2l
 54IXc7GpnOUvvF8ebUsxKQxsvcMw==
X-Received: from pgdj5.prod.google.com ([2002:a05:6a02:5205:b0:c76:3f60:53ff])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d85:b0:3a1:5cce:ca8d
 with SMTP id adf61e73a8af0-3a39c28db89mr8666866637.51.1777457570045; Wed, 29
 Apr 2026 03:12:50 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:12:44 +0800
In-Reply-To: <69f1d73a.050a0220.3c19ab.a437@mx.google.com>
Mime-Version: 1.0
References: <69f1d73a.050a0220.3c19ab.a437@mx.google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429101244.3309913-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/userfaultfd04: Require CONFIG_USERFAULTFD=y
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>, camann@suse.com, rbranco@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test fails with TBROK on systems where CONFIG_USERFAULTFD is not
enabled because SAFE_USERFAULTFD calls tst_syscall(__NR_userfaultfd)
which fails (e.g., returning ENOSYS or EOPNOTSUPP), and SAFE_USERFAULTFD
calls tst_brk(TBROK) for errors other than EPERM.

Fix this by adding CONFIG_USERFAULTFD=y to .needs_kconfigs, so that
the test is skipped with TCONF on kernels without userfaultfd support.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/userfaultfd/userfaultfd04.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
index 4eb811e45..a84117964 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
@@ -98,4 +98,8 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USERFAULTFD=y",
+		NULL
+	}
 };
-- 
2.54.0.545.g6539524ca2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
