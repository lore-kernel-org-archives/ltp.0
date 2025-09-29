Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA2CAC5B5
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759145417; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xPdtHwLc1wMj066UqCo6s3bvxo8kj3omOCQAvPx1rBw=;
 b=iY+zQf8BUivGKUBXiiNaOFJCeWBMY1yxTbSYIl3SEJEyRDonkFjxQ64+z2QiKbBU1nU5h
 1ufBdVqM0CkKzyc4Nq4tkuoJi2fc/WL1guZb8Ts+uCVMMAWdLmDaE+91AR1WRCTHw5UnCTS
 s/W6ga8SNNimVi4Ho9MdOrqxo+Hgqxg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EBB43CE1BC
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 13:30:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0253CDBB5
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 13:29:54 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1AE3720009D
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 13:29:54 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b30ead58e0cso850739366b.0
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759145393; x=1759750193; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/vMdwNBMbeebcyuV6MBS/w2b+mePnGezSNEIgOxONEg=;
 b=fmVIqBYHEpahuRin1DkAltdX4vLctVnd455dQYcj1mzIFI/KAOkHNa26NVxiBAhbru
 ROpL1xrS/TWlBt4JjqDRRp04MJtB+S5i5M+JiLT4OBtewJn1oE1iY2sN0+leS1r4MY6u
 NDpjY7SYu6BzwwrKiUlaeNuNhAzkS93SZAteZfpanaU0FMQIkiRG4KZydFORHBUdxqyk
 O+z7k/KcLHD+fVfmNoYvXLItkTdz9fSRvWLAqkvEFHWARrHOyRUOLwyHq0rgJ3Lqd+FH
 9XYUFf7uId3fw8FEjO9I+gZpH1/KAT7bCHcYec0gytdnMYtPHFEAImtf4dtxuhRIW4pk
 wnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759145393; x=1759750193;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vMdwNBMbeebcyuV6MBS/w2b+mePnGezSNEIgOxONEg=;
 b=LRJSjPAORO7aQZbZb+7S1DPSpH2TTsfQUWJWqOmG9L9x+OW3BJieE5kbfpFp5ZGjDl
 2AjUFA8YnkzAkbvtBrKtP3WwYTJLrTdWx9n2cqn3J+Z9FESc6Zx7XIOmcRxL48ZptQSJ
 ZcQwwQbhhNvHZEPaDYCxvVC8V7brEIgeT76Jt4HKryp80EDk/kFfP2w2GseM/YqY8tFM
 L22vo0UCoJRJGLdm4hcJmW7qxaJCqH4mpDoJdJSy8uttAtWlGVa0Wos5AuLkLJrT9IGi
 +fFqnt6Ua/CDfXTikWzSJX4HBdcPYQ8E5PML0h+rN1MdjVGTl8EnwLcgbtcVRE++98WH
 Sy9w==
X-Gm-Message-State: AOJu0Yx1qVUZRmlsv1js+SYFjHQL3LUDm0X4PyBVC+LMXbP2685ZSgTn
 2zMKutV3PQxs8Ax/MlN7XJoMh1YzE1t1IXwRQo6c4yOiaX2Zx1Gc/U5lWCn4+gU6lGzr7x816RJ
 vShI=
X-Gm-Gg: ASbGncvPqMOc/QWGEaVeNFfT1LyHIJPNBOcsKA5k62DyI6xSXm1dg2HWGQCFj/0lYX4
 /Y1hPYdwhZe9y6TYza8oMUB7RDhkLUtIdyzGNO9Ls9bWdy8wKEKKIfjUurW0iR6bkA0MaLZaDrC
 Pm6wH1E3cqWsQOMWSLG8rEsVHy+ZO9/piFvjBQSWrhZhwFYXtzpHiprLDBxW9ZWM/JwKPGyy+Mi
 FloLzkeg+qqOAzDA1CIrM41o1kCInAMvCP2oOMTfX+8ngfBfzVkZVrjSfyHCVXsjh14wGpj4FLy
 /hOMPdL00hwkX5d7OPdtoBOgH7edxlB8UGwQJ5iIiKXcnqOwmJQDrnRJNl5H5Cmyvv8np107FnQ
 g6vJLpwTh5Wlc3Repnom6E7DFLSYJn0lnlmAeSwYygMlO1M5CIhlNFg==
X-Google-Smtp-Source: AGHT+IG3T8KmFxaoytNDmFtIQL13YhmqQaRHHUUEKfOMhedbnS3nNxkEDS84zW0vgrOowSnoGoSJDg==
X-Received: by 2002:a17:907:7203:b0:b3e:9868:16a with SMTP id
 a640c23a62f3a-b3e98685b4emr393701366b.25.1759145393250; 
 Mon, 29 Sep 2025 04:29:53 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b3a835ca898sm477829566b.60.2025.09.29.04.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 04:29:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 29 Sep 2025 11:29:46 +0000
Message-ID: <20250929112950.24420-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mount08.c: Add min_kver for test case
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/mount/mount08.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
index fb2b28736..1c454cab4 100644
--- a/testcases/kernel/syscalls/mount/mount08.c
+++ b/testcases/kernel/syscalls/mount/mount08.c
@@ -63,6 +63,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mntpoint = MNTPOINT,
+	.min_kver = "6.12",
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d80b065bb172"},
 		{}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
