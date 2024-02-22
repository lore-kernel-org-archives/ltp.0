Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84075C48BEB
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 03:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708571501; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gqIPwQVW92TnmmvXo2euKMs6VC5An6HEl/RXzn8IB6M=;
 b=qf5/6hYwx6n+974sa3GQZqkeAMEDYZccaNTbn8W+GEwgvFhPkFFPvdlLS6SAMhz6Kgo+y
 8F2q7n5EEJjLFX0+RPJAVUFiulqw8ReS67bQbPdVNVBqlVFmNIa6+NVoRlu3RlcndfKZOSS
 JTfUpO+Jgp/xTJzZD604eY4adPJf1Gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE14B3D11BB
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 04:11:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86CB83D11B8
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:10:49 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC3E7208F70
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:10:48 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso43262f8f.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 19:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708571448; x=1709176248; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+MWmp2m+BJfcOq/LA6K4CWYgIjQaFv0j3B0XPzUTFs=;
 b=Mq9+gpBs6qZk+X6WdAG8hlfyOldGvLNnRcAGZUY+XDp7Iv8s6xcB42BWF4Yr2CY5Ip
 5JjnRYrADzxOYikjktNMoH67ovBcGRR0iQKGXRdU8GkZNT3emQebephFL3Uc07+gTf2D
 KrOCHzj2+BWOyS8n+1CTXhD6ABmDpRk26hWRNvqqRBBs/GhDjvbAtmSPyPOq8cSh7XBk
 iQEH3h2T6STwcDYEFOtZGNpPrMGOhSdWdf2jX6qYrEeHRgjV2npvCGauqJT1bBUe9ZKt
 nz8CqYa0wC8lX0zNf2CACChMVrbTBFFSA2Omec0ATMFyt3SA7jY3/2K7XJCQ1GIpHRYk
 PINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708571448; x=1709176248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+MWmp2m+BJfcOq/LA6K4CWYgIjQaFv0j3B0XPzUTFs=;
 b=AMfQJD4trJi3pU6MA29uKuYlEDqMNjuasBmAqqXWipFNwLI6GvqnTIJWoZ99H8xrpd
 wnUPhptZ7yq7ExJ/3NBp4q/T993fcSbbf6YSYGnaE0Zv0CEmmB5cLZMuKWcoZmi8aqta
 wjDvFsirbRYKfLi0I0gaQcTesZeutDaADAbdiCofdQyczws+qhF7X4Ozefv89XYW0KYn
 D5HxCDPlt7vac69+jtVbOTFbOLNrWBGEq7uWPL6zXoc0V3++koMSqoJbTT/uwFpsec76
 UU/x8YHuJsxtqhnfTJiOcSi6pyqOltsE4iXPexYsrBCkkMhhp4n6KgrZ+ZuZtQnGe2ki
 Sbow==
X-Gm-Message-State: AOJu0YwmEQQEB5F1LFlPKALsM/ai55OLafbZwv7w4529WMj/JvbqYcpT
 HR/8x/dfMPbok923/MDLZdulHB28UYv64/txaKzh345kMSABwAemUdquZ0YGjYHoZq36BczImEr
 u+A==
X-Google-Smtp-Source: AGHT+IGjGBLxcycDM2ysE04Yx0Ypte1KvtQma2rr7c2tVbVU/9yrWkAZGICZLvkXZ/5fOLn3t0y3+A==
X-Received: by 2002:a5d:5f48:0:b0:33d:93fa:bfdf with SMTP id
 cm8-20020a5d5f48000000b0033d93fabfdfmr72143wrb.28.1708571447735; 
 Wed, 21 Feb 2024 19:10:47 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001db45855530sm8825546plb.290.2024.02.21.19.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 19:10:47 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 22:10:18 -0500
Message-Id: <20240222031018.12281-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240222031018.12281-1-wegao@suse.com>
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/2] statx07.c: set umask to 0
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

When system's default umask is 0077, this will trigger following issues:
statx07.c:108: TFAIL: statx() with AT_STATX_DONT_SYNC for mode 644 600

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 4dbf83e18..227c33c96 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -116,6 +116,8 @@ static void setup(void)
 	int ret;
 	char server_path[BUFF_SIZE];
 
+	umask(0);
+
 	cwd = tst_get_tmpdir();
 
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
