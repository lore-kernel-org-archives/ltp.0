Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F611C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783502011; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yE5LvA65xCtKdRtg1czknzIW1i4JDDVBFdGIZGvWfyA=;
 b=UsmoseFAPw5k+3FBae0aTlIQMm5K3rFFjuwNhONlJm5UDgQb3Z/Cn7inGN6Kws5DO6/lm
 iYRd47/MYaxBx7cZE8nsZQ/ybMOMu1KA73m2cBydntDPlksNFKDBRPlredT2IX3fGv5P+Fd
 PzTVSrrxRXRcuFm3ARmBhfgSL8Urib4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 562D83E2A1A
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:13:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D4483E2A14
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:12:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBA072009AA
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:59 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso1540835e9.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783501919; x=1784106719; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NIVO0geCKSeDw9eCUg/iz3p/HlIfig0whwHzn8P9PMs=;
 b=SFmGrLjcoInr7LXEaUJNL0N6DaQTkaSqXU8YGEp9ekMZUabzY0BHlSgdLmzlgTvun4
 adx/LtgGhf0ZiZhiDB8Yublfv4HTSoX5jVaglGRw7mEF5n9u1yEdrpAbHyQ0p/yk29eR
 slzBh6fU+mvquOO0zjqZ2Xtcl8c/hiGHItJrYMUCiE9EB4Q0smj+xBJ+esMmebQhZt6L
 RMXz6yVjpDJsh5AVS4XFbHrwpsLuxyc166Xc4oHVkQglgHnlyRtnhC5LMTIjqxIUInEV
 2EIFbEioLkPVTCCltmeIkoTl4QBpM1DnOkz1z0/S9QSXZKMI0SD49edGK/HjlzZXfpId
 4qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501919; x=1784106719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NIVO0geCKSeDw9eCUg/iz3p/HlIfig0whwHzn8P9PMs=;
 b=ID6gOukpdWcdyr+vI64OmZIOTV4l6ugjrFsKmbPFySeeeQ16JN4OB1AuBPS16PZUtM
 5p1FsVtIQMm6cnMbz7ok8eAuLtDFSJ9A0v8OCPQmuxl0mGpaG6AkPyKDWgEvq9tPXjZZ
 mbiyWda5KzVnYN+YTo4PM2j/ZMw3hrzCt7bVWGEXClPGCkrsdXLZbZX9B7Aw6e/0gINf
 h7y9RauDtNj2d1x22g1a5obS9jS+RERznxHSMdNxjU+ZLQmL1QEVa/S9aS9MuYlrodEQ
 Kv/QM2KUwpGucDJfnzizHmiffLFdOC3SkufvfPoC57rU9Pgj3w47lbOSSyM7pTh+OBSs
 EO7w==
X-Gm-Message-State: AOJu0YzBnKCDvz4jWFsAZwKULvPhqYZWiL59qWQz4qRwUBBJ7MDc//ya
 Fpp996oikaEDE+nFd7ldCPoclPwq1xr/cZn4YEPbHytyo+uBkMM0dcjjaQM+GMeGtKh4N6eR4lX
 PBiCqtks=
X-Gm-Gg: AfdE7ckpVnihT+wZs2V1odNsRvXSu1QXzTxIaWUBNrARu1RcmF5BjU2UNWmND/zXGjx
 xWoJ/19/LHjV8mHJ+xsVoRHC8jR7MtUhlH0MvA9snC+pmtQHM25BBSq3l3DpSLpFaogi/cYI+BK
 XaYtj+/WedxM2vcxZNnALJ2ccUfU8+tF1FJE6LOuCF0gqX4nB0x/zNLVY4YpBKi0XXTKZ3szn1u
 84oZwLl9/8S1qOhvhvCoJ/6WTBpp3B02NsfkmSgYdoevRyT+y3aBxrUiFELrUGANrjd44QOJW5V
 Zx/SmeS1cSBwIZEQcvbYmoTJ7N9OY5jZE6b2yK8IkQ4n9/N/Lbc5+I57P7YUnxw/aYkp7rUE+PX
 pyrCPHIuAGrJgqI/0rnp8XI9TxybJDub7f0RKGGHGTpH4F4blS1C+U4IsMuvU04/cyV5EJR5WSX
 AmmW8eqQsLwA==
X-Received: by 2002:a05:600d:848c:10b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-493e7e89d8fmr5085085e9.31.1783501919208; 
 Wed, 08 Jul 2026 02:11:59 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f3677asm111042315e9.4.2026.07.08.02.11.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:11:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:11:54 +0200
Message-ID: <20260708091154.999385-5-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708091154.999385-1-avinesh.kumar@suse.com>
References: <20260708091154.999385-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] syscalls/cachestat01: Use SAFE_FSYNC() instead of
 fsync()
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Success of fsync() is not checked. Use SAFE_FSYNC() instead so that a
failed synchronization is reported instead of being silently ignored.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index 1db530ffe9e5..1ba0f9888f0f 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -42,7 +42,7 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 		SAFE_WRITE(0, fd, page_data, page_size);
 
 	if (use_sync)
-		fsync(fd);
+		SAFE_FSYNC(fd);
 
 	cs_range->off = 0;
 	cs_range->len = page_size * num_pages;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
