Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CB5C83F07
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724931712; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=dig2Zl53amCIY0FvcMPA5DZAwizVqbDoT69wYiqnIig=;
 b=C1p7A2EV/S/LnhxMPWRyjfLaouW9M+Arcj1btvoqL1pQ48PTQKslwXp7xL1diUe++VRFN
 hF38fgdEfI3cBIW9sXucVX+Bt0WfP3itRSUjTgsYb2CTNPqz144iTYHZWwa3y5E5FHmJKxT
 zbcGeIeiNc03TGiNdh27rHmHJKB1r+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A975D3D2803
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 13:41:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFB9E3CE3C5
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 13:41:32 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8DB3E1A00E10
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 13:41:31 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86859e2fc0so54420666b.3
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724931691; x=1725536491; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jcoiD9z+0VJwxJv48jFEDhafIDjag7FTskYEXv1eUjk=;
 b=gvaOyYz1/qGMi8MY9Lxlcku2O7a1FCpuobxdiQzTZn+5573cZZBjS1sDI4D2kgE8TS
 qFBDpua/dYPiO6Zfkz8mYrRvQeFJ3ibA96x9pOJDjMr2dGBabLmvAfEdpO+uQvB2skpy
 cz9wwutbjW2Z3fP7Gb6JUdjx57Bcaa9Zt7ggezChx0CGAe5a4HWbSg63S4OylmVY2GGf
 57L32VlWGMrlovd0MdgryfXyKtKHtpoRDPEmq5E2sS4B/aPAGNC9C17bPfaZ4gGkU4II
 mMVigq3d81bxUSvbRnzNpl9xyOJpbwRQ9e0zMe3nvXTlZzsC3LRMxWdWqITHgjTSJrFc
 PmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724931691; x=1725536491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jcoiD9z+0VJwxJv48jFEDhafIDjag7FTskYEXv1eUjk=;
 b=dzIJ8zCRclY7sXk4S1doJTMXAOy3AevoIkuWZES1EeVNcDswEQvknGmINuG2PGMJFm
 l+XVEuV1UoC3WO3MI6CAf3b8hvyUtfyc+k94rsB3uUnselK5B5BPcBYl5UvcFXWkVlq3
 GsLNOKYGBCTmUeiSoykn1jqg5M1whyeXpiKgGuyhDe6K6cMKpNqnwa7v5/CnEXGtxC/f
 X++ywnzVT+rKywE2dzYC+8QOBHmokpGlvUrQJcsFdS/r+Ap0LptgzfQwsZLnhtKQicIn
 nQzWp6Vjo28/4z/Velkz7oqSOGxRnq4acyd7LyjqhZnlOhY0HuClW5TmeYGpvL9/t1RA
 2Zhg==
X-Gm-Message-State: AOJu0YzTtLJ1JZWTx8jQ8HpdSYQ7+7W/Gz5x9IIPvGidW2s4rYi21pc9
 iVWIZjgOrZl6E4pJxhcX/36QKovwmqTCY0QbfBFQQf4d24QBYW45jINRQbQQm7dILW/FuN3geI1
 BEA==
X-Google-Smtp-Source: AGHT+IEfw4qb2xRSK/6ss/5IhW0Bh/2RH+2oMgu6clnRa731rJczfpJ0KO506cjw1731+0eDxDaiCQ==
X-Received: by 2002:a17:907:eaa:b0:a86:8368:860a with SMTP id
 a640c23a62f3a-a897f94da74mr170291466b.35.1724931690549; 
 Thu, 29 Aug 2024 04:41:30 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226ccfe84sm609929a12.71.2024.08.29.04.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 04:41:30 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 29 Aug 2024 07:41:24 -0400
Message-Id: <20240829114124.30299-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] hugemmap11.c: Change NORMAL_PATH to current
 working directory
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

Following error will happen on sle-micro system since "/" is read only
tst_test.c:1062: TBROK: open(/ltp_hug9Iy6OR,16578,10247520240) failed: EROFS (30)

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
index 496a814b5..67fca2ddf 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap11.c
@@ -23,7 +23,7 @@
 
 #define P0 "ffffffff"
 #define IOSZ 4096
-#define NORMAL_PATH ""
+#define NORMAL_PATH "./"
 #define MNTPOINT "hugetlbfs/"
 
 static long hpage_size;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
