Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014FC433EF
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 02:23:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45FC611CE
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 02:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A45FC611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13E83CA0CB
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 04:23:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE44C3C7591
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 04:23:08 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A9FA1000926
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 04:23:08 +0200 (CEST)
Received: by mail-qk1-x734.google.com with SMTP id b65so38769601qkc.13
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBYwgtkDRrCo56B7pHHXdAcCo5ZMZcU+JypLeScVn44=;
 b=F6KxrM6uRkqC6DmH4bgiEj4JUBnxn7r4pKqCI73wSn3ji216yc6oecTX4n10V3BQMr
 kVLQM6V6L/qD0zQ5Djve7YlIkNNVEa201v2a+nd2mJgNLS1G+j+Vabwfpr6XLVHZQ8+w
 HcNWo2c2R8LLxl6h0w5okrvxXryLAsUs9zwdZdKBCnSGKXNtVSvYHOQ9ruvLMzQAbloe
 Sn4SzXSw/En33C3R7olacD6hZufY1wv61MJMdOAPbXxRpmv8I6CQponKJq9rqZtsUO51
 CO6ZAk8gtdmGTYn+0j3klF2NF6RTP6OU2ega0eHJfv8swOxPuuTuET6HhpwoDS/9orcj
 eMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBYwgtkDRrCo56B7pHHXdAcCo5ZMZcU+JypLeScVn44=;
 b=B/tVi0xEnUMwdKbrBH7C77CCNA23HY8GVjcZuLmgH0YQt+UhvmXbSgf8bEAzEDU5TF
 1Fe4JHFbk29QdSkfL6xwwaQUTLRN/QRkWIVoLxlFxnhIFPNOzFb7nZynZTP4N0CC5h9/
 lTtMwWDnHJb39BfVvl8W9LlqwgdPIHQfRU0JTL18WKtCE8qMsok8b0jclk5HPRLP08o3
 UdT/FIgs9q5qYuxwNx7CGPidJM4wTbYsDTEVR92YEvs8FC4Ab/7So5eXppU6kLkTyc1m
 Ss7C+wsCxjiNw92ohnGzKR2Or6gUCJnGMrBUVAwKanWRtIg4ME5EoeR1Q0oOQ2NQC8AA
 wklw==
X-Gm-Message-State: AOAM532MhZoSV2ktifTQJ10CPDPA04t6Kt0ky6Qdd1qX0o7cRqygLFeQ
 ezsvlKQ8i/1CBqatHArA9vfRJhxSnFnOJw==
X-Google-Smtp-Source: ABdhPJwMH3LAGZplGYN09zVgH17akmfXs9biwoSIaWDSD/QjA0o2fN4Xz3X1MRlLWpNEEWxrqP4esg==
X-Received: by 2002:a05:620a:53d:: with SMTP id
 h29mr3166195qkh.395.1632795787197; 
 Mon, 27 Sep 2021 19:23:07 -0700 (PDT)
Received: from maple.netwinder.org (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id c139sm14269205qkg.2.2021.09.27.19.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 19:23:06 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: ltp@lists.linux.it
Date: Mon, 27 Sep 2021 22:18:50 -0400
Message-Id: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: fix MemAvailable parsing
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

The amount of available memory was not being returned correctly, which
resulted in tests being executed when they should have been skipped.

Fixes: 8759f4 ("lib: adjust the tmpfs size according to .dev_min_size and MemAvailable")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 lib/tst_memutils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 69077861f..90911da56 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -65,9 +65,9 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 
 long long tst_available_mem(void)
 {
-	long long mem_available;
+	long long mem_available = 0;
 
-	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
+	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lld",
 		&mem_available)) {
 		mem_available = SAFE_READ_MEMINFO("MemFree:")
 			+ SAFE_READ_MEMINFO("Cached:");
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
