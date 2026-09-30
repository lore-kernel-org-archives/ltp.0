Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D07C9830E
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790740456; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VCILAFl3CBFPsFiskQPN34mmJkV24i3npdUwvyXTQX0=;
 b=d8PLl6T84gXNg2pXrFFHepez5qmpdf86nAxPsVTmO5LWwIpHBoJ54WjeRRbC93mtRxwsX
 Pa1VH5KUemwAsmsMeJuv4/sHn8Dv3Qltc8k/rjeB45fLaE7D6FUaFLZBznA+rdCx+2XZnf+
 NynRtsz+gkG3s87mGJQYoCu2VjEoMWo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 179613EAA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 05:54:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 546233E5833
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:38 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A3F731000465
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:53:37 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so19986195e9.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790740417; x=1791345217; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3hoTY8FkzZCTc4viSDL1kdH/2rOCLSZUuSXdTxrGlQ=;
 b=Y9GxGBbsji79eX96gcwiAUUiJp7514b1AW8XetKuFK9YJAQ6SyN60naTv/XoQS6Q3I
 dhkH3Ym+95iysFhIOhipJ7nmnDc253PrzgAQCw8VpCx5xYdhMFwcyjHQdtGWH0hbNJsL
 5A5b6e1PAB+MbxPv45xrkOKMrKq3dyzrzSxvK+/tNcYUA4btTJLZb4GUcHMkZNgTUklA
 NFY7uKfiVV91GAemLILMhuAaEay/aykh0pB8X0+d2JrTfmK1c73fhl6sLRFmjrxFU2nV
 OI4XLHoaj9/cyI+Ri1jQaWmEPdvkxU9K+skbU2JeHVwx4FUIVqXeSuhEmKPXDtQt61OI
 X7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790740417; x=1791345217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3hoTY8FkzZCTc4viSDL1kdH/2rOCLSZUuSXdTxrGlQ=;
 b=yuox9VO9pidE+u7/SrwWvNfmwgGAOJaozSrfczW9Wi19Th6E+ACuifzyHM+ofOxiXE
 Q1MGE2fHQFL8fQchCj2WJ+ThOudMoFKSImKm2tBSb9Vu1Pl4XMaI2JpcW1aqXuZG3wJ7
 OcsXWLAfubwCr8pd0PC5Grqor8WvWN8lLZOtGnSCLClHfgyJeiR/60HwRWFgXtYerAaZ
 ME4symvh4KeArjM0D2N+r08uKvrjm3Z8+QlBUfu8cATvCkIbwNmpqJfoADEaHwrByz2B
 nxjzrURWzLiz7pz+0G2nERDNW1PrjONIGDzwS0F9EJb7en+f/3UleoXxs+KNeJhPf2t8
 GqdQ==
X-Gm-Message-State: AFuF++nFLvFFNGRFe9pIkMIIPOgvQn+0IcQqqCVxPQ+vZwFR0hsT5Dxn
 dTomdfro3C2pDnjX+ptvWNnP0N61JXvW+MEMqObANWu0pBZUJvePxCiH4+1dZTp6Uq/cFSJmREJ
 w694=
X-Gm-Gg: AYBFou1wKD2iRHJNZWcE7vMy9O0ddwt9ZimpBXZUHn/EZyZecq68ScvYOoCLHpSqUwa
 UWajjeR/cA5HAqSvDqb2QgEhtNdeCoqOeIAhUpEvwCTgepw26XkpyT+bb0qD1I2Gu4VvIbbDOeP
 8zcNCJFzRkOoAIzFbxQ6S1U4Osatfsbhr9DHCDlUf4Wcdu3y1gDNcmFVtrl7v7Kh9+Efhx3GRh4
 15qDYBEX83uQhn0C4KBpboK4s6fiVmLWu16jvX7hPMe22bvSX4Bd2f9FfdUgl5mNLBxyqhq1oJq
 u8sQveQInwHn28pW1vmj7/c9XvTc7pUXu3CEMAkRkj2nqitF3Drjhe0k8slKmVIf7MwROWUwCuo
 Fcb00Fgmun2soTP++kIYPi/gAIJpnNkNI4WWgenWBHsfylbJJp8nI9puko+qm/zKtF9pMjf8ici
 cjC8C8yoTtIUO9OzZ4bM/5E5YjVGu7YnWXTdrmWaNaTv4ZUXIGe0YEeW5syfS7jumeIIr/TmtFX
 W3cEdn+TR4qW2F3SoXdWjI+Erq+HULLxntHPUY5ys2Pj7ZBQBIJSg==
X-Received: by 2002:a05:600c:c494:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-4a015026ea9mr17754345e9.15.1790740416995; 
 Tue, 29 Sep 2026 20:53:36 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a017713a43sm16854115e9.11.2026.09.29.20.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 20:53:36 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 30 Sep 2026 03:53:14 +0000
Message-ID: <20260930035332.3360-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930035332.3360-1-wegao@suse.com>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu() helper
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
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add bind_to_current_cpu() to memcontrol_common.h to allow memcg tests
to bind the test process to a single CPU.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../controllers/memcg/memcontrol_common.h     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
index 495f924a0..0f5021c0d 100644
--- a/testcases/kernel/controllers/memcg/memcontrol_common.h
+++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
@@ -52,4 +52,31 @@ static inline void alloc_anon(const size_t size)
 	free(buf);
 }
 
+static inline void bind_to_current_cpu(void)
+{
+	int cpu = sched_getcpu();
+	size_t mask_size;
+	cpu_set_t *mask;
+
+	if (cpu < 0)
+		tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
+
+	tst_res(TINFO, "Binding test process to CPU %d", cpu);
+
+	mask = CPU_ALLOC(cpu + 1);
+	if (!mask)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
+
+	mask_size = CPU_ALLOC_SIZE(cpu + 1);
+	CPU_ZERO_S(mask_size, mask);
+	CPU_SET_S(cpu, mask_size, mask);
+
+	if (sched_setaffinity(0, mask_size, mask) < 0) {
+		CPU_FREE(mask);
+		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
+	}
+
+	CPU_FREE(mask);
+}
+
 #endif /* MEMCONTROL_COMMON_H__ */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
