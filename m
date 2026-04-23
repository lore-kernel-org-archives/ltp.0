Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253FEFAD3EF
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 02:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776911544; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=L/XuuSsY48R/wckjTJhCC+riNcenCzkfI/AJqrT3bnA=;
 b=VEAcGzNrZAjSm7TMVQhgQpRiyxz4kJJR/rDoMzwF/RXLU8L4Qz+4/IybF5dtWKruHATpG
 rr3VmT2DOhi+PJC6R8gh+UcRu97xVXtZtioL36qgEGGhjNdv/VX2DQDXyBdbzvIVfNw0dwX
 fzNKiZIZUrXLrZ2a6wY8HAyWu/aXSoY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4D703E6FDC
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 04:32:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8F73E28DF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:32:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BED7D1000421
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:31:59 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso35173075e9.1
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776911519; x=1777516319; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mrMcXkRGk8K3kIcnZZkMrbJOMCEZpSFoA6Wuix9fMHg=;
 b=eD7wTGATEwKcTqNYRk62z3Ps4ljwbhjiDqJnXWmSWFlTCguL/qO4ASLKi7PkbWq4yu
 vwk/DMRJyYHbboFyO4OTDgRD2faH+Y1h9Mw6xbLkh/0xDZiadKKimuiu43jLac02WfLq
 yBUHDBsMEirLD/4Txg697cCOq1GatMWABRd5QTTuWLS7i6+9NOAwXYrcxGPWqf2uCZvW
 5okrM0ccaqjKcmal3lXKPduECcSBNJngBflpG7kDRWd6PCum8I9pWsnaYhhvgUaMDn2a
 7LUgu4ihffxejYhZ/9e+Mk4iNt6VFueq9vc4+hnoAMC7t1+yUmXsHK0Z7543xJM4pOl/
 wusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911519; x=1777516319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrMcXkRGk8K3kIcnZZkMrbJOMCEZpSFoA6Wuix9fMHg=;
 b=pAiHyJ8HZoaWXILdjJgylKka+wko1n8C3qldB+einysO107Qls2I9uRMSBlai+/9I/
 Bn9pwW7I4ZjAdK4O4UM91xfAlPHMYKWpzTYsy4z6cO2LGSXXDFNb3oFffPvtGPf0R2Z/
 Zo4gGsR9qbn1pXRNwYo5DX2J0nr8dbElc2Cx1zRZDSwOzrqBJG1sLvf+ybdBaDE2TBur
 IebUHH5yyObt8/m4Pr9XQt74gQm/NiJjnReMwuNbLqTphcGda6w9XJtVQjiYZIIHImFO
 AOl+NelYoxcbkDHb5JwoETi53yce4lmBteiVdXr3uOGFDVqwAiz83QF64+w71I/u/q6G
 YPyQ==
X-Gm-Message-State: AOJu0YxokNf3YH1kTWBSO5zS/dPPc4m5gbUpdDPYjtM9gRtki2bks+wS
 X2O8gGjGIBvX7fRFtKH389CozkKVjzbDDn4ccgGoer+SnFiEAwUR+l5xeEbddGlOsZzDPSYh2G8
 7jAw=
X-Gm-Gg: AeBDieum03/GXCTzvf7zNUiYibYZHl+aMo68N9xDAW/c+r3zBS3P/DQqh73g9CofxSw
 IoX4a9ezY3V/6CdWwTCPGKMQUAotMwk9tW7YMBxoWRkzCSqGZA3ZTweKwJtxdwuKJ+2NMs8sU/l
 d+oHFFTKhPv5V/PCz4E/loW/yG2F88Z9LDW8Dz1wb7S2OKsGD7j5FHpUNxK1XrwF1xemvMqVPuq
 ca0X6zd8dqX9AGFYSKqfIBV+w1tCQHumDOUIhjNPjZvz0DWbT0xklfsyBpWhHdxq4zWJYmVWUg4
 oTZj5fggzZY3EItFLFrNtOaw/UGDANUFGEwonAjBjkxBUQcmcaJs9jEBhwwQr7AXvW8qtFwvcgZ
 D+b7qL+i9E60bSCjFQUCFMGnnDvTkOH88P9MP2wImox9H3fBRX1nCWRp/5jmwwdZy4OyhKtPXko
 TgaapyPyGjGqEGBYg0Jt+Sjw==
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488fb73b2a3mr298243355e9.5.1776911518923; 
 Wed, 22 Apr 2026 19:31:58 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488fb735d3dsm332842685e9.2.2026.04.22.19.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 19:31:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 02:31:34 +0000
Message-ID: <20260423023141.28151-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] cve: icmp_rate_limit: set icmp_msgs_burst within
 network namespace
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

When network namespaces are used, the kernel resets network sysctls to
their default values. This makes the global .save_restore for
icmp_msgs_burst ineffective for tests that enter a new network
namespace (e.g. via tst_setup_netns() or manual unshare).

Moving the sysctl configuration into the child namespace ensures the
test always runs with the expected burst value of 50, regardless of the
kernel defaults (which were increased to 10000 in newer versions).

Fixes: 8e919bfb2ab0 ("cve: icmp_rate_limit: Make sure icmp_msgs_burst = 50")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/cve/icmp_rate_limit01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 78480cea6..5193c5dfd 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -62,6 +62,8 @@ static void setup(void)
 	/* Do NOT close this FD, or both interfaces will be destroyed */
 	childns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
 
+	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
+
 	/* Configure child namespace */
 	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
 	NETDEV_ADD_ADDRESS_INET("ltp_veth2", htonl(DSTADDR), NETMASK,
@@ -255,7 +257,6 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
-		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
