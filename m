Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ED9E9A048
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771509057; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=VJd3P+BqzcohO6inaMVdCNDTJU/1Y/+s879FxS25F38=;
 b=QEFiPdgc/z22Tfr/TJKMHkGQyayX3JYB/kRXm2UA9wLtpMVHOjKvp8YvykEbeDP1kEpUS
 r/DcDPWZRZzBzLXEg0Q6EfCI9wAdJlzoZ0z4/SInVOhTQduUfurAJCP57+r2KZz5QWJvV04
 SGxtrlQ6rLzH+dZ5naEGVl199NqVDOY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 135B53D074D
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 14:50:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 438393D0740
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 14:50:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 617C71A002C6
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 14:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771509030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GLoEOe/mOOsSKOBOLkrd4xxSn4nFF5yikdbT9k4xYGw=;
 b=i+tN7cOfvFJqUEm9QN6w4BI2XFfVagI7xoXN9Klccc0TXQMvxc08+4GvMuIAWoBRmll35c
 Xw4oZuGO5GWPHKy9Tz/D2yUpP1LPuAyE1/3j4WBuoJG9UI+i9TMDkLAW2aeusBipcI3glB
 1Iuj3td6nHinVT3Y9dZqf9irmcRMv38=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Cn_gz2AAODCV3BL3WtFkOA-1; Thu, 19 Feb 2026 08:50:29 -0500
X-MC-Unique: Cn_gz2AAODCV3BL3WtFkOA-1
X-Mimecast-MFC-AGG-ID: Cn_gz2AAODCV3BL3WtFkOA_1771509029
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cb52a9c0eeso1238712885a.2
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 05:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771509029; x=1772113829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLoEOe/mOOsSKOBOLkrd4xxSn4nFF5yikdbT9k4xYGw=;
 b=MtS+wiPrH9MJ5E/mjExWkRGMQrBITFmfcQz5UZ5cYOyf2HKmg3q4gnCPLlEC+gAiNS
 OBcWnr+amDbv6gpxEiuL4MZl0v9UgJV956CRpmvYNVEwVdlCdpnf6WdGe3b4Ijl578Xb
 /kKh/VaJi00EZF1MdAYQWMohu+sg4XKpx0D6VoMMa+L1HGrWdsw/frn54ELcVw2ect/w
 y60e+8APIuQyZEk4oCaIo1IjoDF7a2cmIxGgzUUYoHnV/237nCshrv/sZoSe3qLN87sc
 hisDZ3J+9TWRUY8OtDnqmTKclop6fhSnORV8/VqdNozf76DAF31oe/Mw3mdReXp5nLe+
 LwJw==
X-Gm-Message-State: AOJu0YxCkDpAVJSOD/4FRlNsMeJXd3uwvotl4zs2IAB9tvpfk7EQBVDl
 NXX+DrOovLUcSBFq7PzqBcwvq/gZjp+uzIrG7FUtc9TBh7HvnY/xK+FO26pnAEUwlHEpueY8hQ7
 ZGS+hCcP1Fsw89y8HrFAoqg4uQXM7dAR0XRkpiiHrQmXagEyT2ljswxmiDo2mYAttYVxqIxtetw
 kaUv7LQjcVPIlSQDt29D1/2Y6knndOIigevt0y
X-Gm-Gg: AZuq6aL02J/MzzPnFbK1F8TIixC2TccoCx/uvu4hXKZhqYzlTuIbvNkblyHqusuaL2X
 +izGBrR5ZKWYA47fpqpGbF3rzeBZ2qE/Dnso1CvNJoW6iiJcOEdO8v2xY2m/nr7bterI0+4c0DX
 P4z78yOgxrYjukhBMI9UG/eydFZMJZLF+vYBJlzhpx7qZJrypXNfCWCRJGvMCVrZBeanV58v3OB
 VjGAaIksclj0FVfM8VMBwuEcGpDyKDQFtCrBG0nTe8zMEfagH9CNHjO7gqUPEiCEesAA7K2I6EA
 1tFH4mLcNV6fw91gG0fw5D6ePLFA8KQTKW+I6hPUikBBF2NfhjrZ0sG90bPKsvE6sOdxa/zrw6u
 5tu8UMJDjhqlS7AG6qnfq8HgIeN+L3KIMNUxSTxEBbzvHdPo=
X-Received: by 2002:a05:620a:700f:b0:8c7:16fb:ed45 with SMTP id
 af79cd13be357-8cb4bf96a37mr2148712485a.27.1771509028757; 
 Thu, 19 Feb 2026 05:50:28 -0800 (PST)
X-Received: by 2002:a05:620a:700f:b0:8c7:16fb:ed45 with SMTP id
 af79cd13be357-8cb4bf96a37mr2148709185a.27.1771509028203; 
 Thu, 19 Feb 2026 05:50:28 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cc7bbcdsm215026976d6.9.2026.02.19.05.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 05:50:27 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 19 Feb 2026 08:50:01 -0500
Message-ID: <20260219135019.1140234-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E8QlXSCWkdfrHDqBj8HFDjVzOivucI5dRtosNLtJs4k_1771509029
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cachestat02: Harden parallel worker execution.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This does not happen all the time but when running in parallel
sometimes one of the test instances will throw an error:
TFAIL: cs->nr_cache + cs->nr_evicted (297) != num_pages (512)

When LTP runs several instances of the cachestat tests in parallel, they share resources:
cachestat02: Uses a fixed shm name "myfile.bin". All instances use the same POSIX shared memory object.
That leads to:
Races on creation/removal of the same file/shm.
cachestat() reporting stats for a shared or partially overwritten file instead of the one the current process wrote.
nr_cache + nr_evicted not matching num_pages because the measured range is not the one written by this process.

The change is to create a unique file/shm space for each instance using the pid of each cachestat() process.
Harden parallel worker execution for cachestat02.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/cachestat/cachestat02.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
index 72428ee83..d6505c4a4 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat02.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -17,10 +17,9 @@
 #include <stdlib.h>
 #include "cachestat.h"
 
-#define FILENAME "myfile.bin"
-
 static int page_size;
 static char *page_data;
+static char shm_name[64];
 static struct cachestat *cs;
 static struct cachestat_range *cs_range;
 
@@ -32,7 +31,8 @@ static void test_cached_pages(const int num_pages)
 
 	memset(cs, 0, sizeof(struct cachestat));
 
-	fd = shm_open(FILENAME, O_RDWR | O_CREAT, 0600);
+	snprintf(shm_name, sizeof(shm_name), "/cachestat_%d.bin", getpid());
+	fd = shm_open(shm_name, O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (fd < 0)
 		tst_brk(TBROK | TERRNO, "shm_open error");
 
@@ -53,7 +53,7 @@ static void test_cached_pages(const int num_pages)
 	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, num_pages);
 
 	SAFE_CLOSE(fd);
-	shm_unlink(FILENAME);
+	shm_unlink(shm_name);
 }
 
 static void run(void)
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
