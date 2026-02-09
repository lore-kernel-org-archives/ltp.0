Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2DAE7E0D9
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770665334; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=xSeU6kjUNVUzAG6HT0HXdRrh33Va6rnfzo9OWwXAU/o=;
 b=RUOasDhjHdiIRinKw/nepLoH/1jHp0jeaaKEFBuP5jV4ooz6y+5W32eKlIpHbgZGm9Cj1
 vEFAHPO/JKIOXK4dfLtcBTYgthf/4Q/JHaSGrw5QCHgfphj3jAe+0VbEziJQ285p/FIEs8G
 RsVgyqzooq5XMNJI140x9Miyn774M4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F2E3C4C25
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 20:28:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1733C9F78
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 20:28:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36F751400268
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 20:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770665306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gRorFVdt+H68e07fYB1YcSF/+cm89BGxrtHdES/H1rQ=;
 b=YHQbzagM8iy4WzdAYe9WycwscXktJHK0fcF9RTg9KbdVDSVWXA1b+9rLmM/C5epvTW9aDl
 8bJGWZ4Wx5EN1vuwyQmTnZP2iO/dDsl+TA2P9FKMN7sFT8iSqdIcFKazSPSib4qRuJMbxM
 oJCtvKMp/4+9/M2ufWnppw//uDEhNGo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-aHZBLZTUMOOGvaADuMc3Ow-1; Mon, 09 Feb 2026 14:28:24 -0500
X-MC-Unique: aHZBLZTUMOOGvaADuMc3Ow-1
X-Mimecast-MFC-AGG-ID: aHZBLZTUMOOGvaADuMc3Ow_1770665303
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6b315185aso1591968785a.2
 for <ltp@lists.linux.it>; Mon, 09 Feb 2026 11:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770665303; x=1771270103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRorFVdt+H68e07fYB1YcSF/+cm89BGxrtHdES/H1rQ=;
 b=sk0IPfC+Kuqgl/qvbSGxLhq+TraSe+GnMf66RnQmkRV1J9LfjGqk7aWB28t2rwa90R
 n3gPGA8XKCdcI5PaCQKZbyVAEn/8P1SnQhYxLJDk4yinkBxFhtSnMYDHs1M/VL7Gv79V
 fabrWHFsLIvOO8+lPGRK7wHv/xZh7JaCa9oMOR5kG8oeoSPe/PUdQdP22iHfS4+e9wzl
 AU0CgELFuOY6md+6rIErzLb4K5UHS/W8Hs84tbud4Ldf3eymRLI3h/6uHYY9HSTsf0Db
 /n/gLPAYVnjDZYwg9RuuMfHjrMwPzckq0tePqpqEMUKTlJwU8GTQRxJ9gWwkkkogUsK/
 dT8w==
X-Gm-Message-State: AOJu0YyD/DBcoRAvvgT6xkBSelaRSIZL4qcA8iiwh9Sz/asux9SOTBcF
 UjpYOLB9dGcocz4Sch/h2MTWOY77Vn8DbsDVp2qzVlj+qVzn38QQIlILt96SyHVENcg85Xg4lup
 XSTwn5Qf5E1U5XST403ZBGV7UbHvexO6IUxikY3aEzhO73CJSnZsdAL3LGdkAGyElWm6VEBE9cf
 +K/JFUDISfJLGuc4fv6CW98YrlKQ9dvWTZ+5oI
X-Gm-Gg: AZuq6aI/8MP9xR9Yo6v+uU3x93a1oQDUOXsKSV0Or4TZrOkqQPCsg9G2DcTHphTnfwP
 MHwGgdx8tW/WbyxMBCbmRW2we6/yPxPtls7j0IU2ZvjJuQWDTQv21/VKhxIaEtUxZKpiLIUEW0+
 Ew2mhcJtnLznNJObDeClXHJhwpXRspwZEhSuCk/149P62BAsjfY+Q8k1IYCpwV41/2oAqZMCNgL
 ji/fEIB/O4X1VsO01XlvZIgCBUPsUTOUtqzrOxzUvgvgUxQTNcBf3xhoJ4gvpA5Q2FBDvSgNLwY
 f7PKgbeNjNSC+rpptdjOgLJH4qhr6Kc/kbaXmc+CR+I/0uNRLTIYC+1LjK1NozArwzZYwnB5Lo1
 TO3HIkI2iFgTgPpkFN5uofwZ7Z6cCBiReuwM=
X-Received: by 2002:a05:620a:3948:b0:8ca:2a05:6d00 with SMTP id
 af79cd13be357-8caef7e1c2amr1806039085a.32.1770665303542; 
 Mon, 09 Feb 2026 11:28:23 -0800 (PST)
X-Received: by 2002:a05:620a:3948:b0:8ca:2a05:6d00 with SMTP id
 af79cd13be357-8caef7e1c2amr1806036385a.32.1770665303161; 
 Mon, 09 Feb 2026 11:28:23 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9eea0c0sm880077285a.42.2026.02.09.11.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:28:22 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon,  9 Feb 2026 14:28:10 -0500
Message-ID: <20260209192812.2763299-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dn55XYg1HMiLYqQcqGpBdpPo3INESf0gHue5K-G07KY_1770665303
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Harden parallel worker execution for cachestat02.
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
