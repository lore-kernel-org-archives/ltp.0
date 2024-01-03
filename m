Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970FC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 14:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FAB33CE784
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:38:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA5823C05DA
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 15:38:05 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 592F9600D28
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 15:38:05 +0100 (CET)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d4a980fdedso24990255ad.1
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292683; x=1704897483; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+87+emoJgV8a6XlQBvlGtkuffurT9822ZwbKfsuK+E=;
 b=HpE2EdFvExT2NWR9w8n6CXsJ3Fqx8Omi3eolSL1vsLKGsThrujdjqVtj297gsRWy6G
 x70oVYrJktCOVTqFsMWj1Oy9FrZvytvYoevLnbV52vmTAo30ftaXkMSGrJf1giN8OMM2
 eNGdblNxP1CAyFE6Z8WJavjBqAcZdmzuBjHW519ZOxgwRvDO/ZNho0JWsUUQQFRvPQEd
 BzbAuFZAb2ecJNOPXGwgz3assLwnFYwSBKPakd6BJUwB5S34tEP6SlVzV4cgEH0sC+eF
 R0aS0wdLWslmUHZrbZ/oLjK71XGu/d8x+oqB2kJqC1S4P9ejrpbsttIHonzt78t71/8o
 RHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292683; x=1704897483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+87+emoJgV8a6XlQBvlGtkuffurT9822ZwbKfsuK+E=;
 b=LN+XBsbCvaz7t2z2YVjcrZeZCIBFpa+zTfsx6aC+Qg/5OyY5RLhTPh6tf4dljO81fW
 676QS/xTBQ6R1m359Gak2H4B9pse09ywsdF6s6FoJOT9oIjqj0+FMH7apDWJpgvVSxna
 CRO9JJR1cAMBuM+cOw0W5gZYj25Ts474sUb67+o8mPhfU+WnxtBXCqKwnnIrt7DZdUtk
 CTN3YVr/iixg3SGJ5iSqMVbxkglLNkKC4jvplzxfiHMuxjyXhf5EyoKfLAdtaFq92ulD
 pvdOgVdjgyNQ/DKz6E0Uyuc8STlxqlHV7mmJPqssTYUdgyyhINdaFR63C1HVmByZeaVn
 hD5w==
X-Gm-Message-State: AOJu0YxSkkZIIWSw5naVE5l2gqFCDmMy7PpnSMnIEfTYOVNvLkh5r6Ys
 5Dh7YTsgELUqmM97M0ab3HveZWwPGSU=
X-Google-Smtp-Source: AGHT+IErl8SQ9dojm2BuVDhzGx6z7X5BhebLvXEUEefNMC3d/R6UgDBJRKILeY6RElMr2QtCYWUqfQ==
X-Received: by 2002:a05:6a20:4a29:b0:195:fada:935 with SMTP id
 fr41-20020a056a204a2900b00195fada0935mr11755166pzb.77.1704292683513; 
 Wed, 03 Jan 2024 06:38:03 -0800 (PST)
Received: from localhost.localdomain ([106.51.184.189])
 by smtp.gmail.com with ESMTPSA id
 fc29-20020a056a002e1d00b006da5f797249sm7283456pfb.130.2024.01.03.06.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 06:38:03 -0800 (PST)
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Wed,  3 Jan 2024 09:37:56 -0500
Message-Id: <4539c6a95e948dd4e7f81a018b10051fa90970c7.1704292236.git.subramanya.swamy.linux@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] read_all :catch alignment faults while reading sys
 entries seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc
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
Cc: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

---
 testcases/kernel/fs/read_all/read_all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 95e3ca275..ddc48edd8 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -251,7 +251,7 @@ static void read_test(const int worker, const char *const path)
 	worker_heartbeat(worker);
 	/*
 	 * This could catch any alignment faults while reading sys entries
-	 * seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
+	 * seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
 	 * in chunks of 8 bytes 128 times
 	 */
 	char check_buf[7];
@@ -263,7 +263,7 @@ static void read_test(const int worker, const char *const path)
 			break;
 	}
 
-	count = read(fd, buf, sizeof(buf) - 1);
+	count = pread(fd, buf, sizeof(buf) - 1, 0);
 	elapsed = worker_elapsed(worker);
 
 	if (count > 0 && verbose) {
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
