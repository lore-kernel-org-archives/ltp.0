Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D17EC00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 06:26:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D95D3CA334
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 08:25:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8073CA31F
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 08:25:48 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9698110009EB
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 08:25:47 +0200 (CEST)
Received: by mail-pj1-x102e.google.com with SMTP id e19so14893559pju.1
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 23:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=CWqS/s6+XqPX7dX4jDDsfefSapNnTFUTSwY3ONPaz5A=;
 b=JFJlQhO/0ei8pi8wMb2gfVV6AacWGUdNLegyeX6i2vOVAnN1ZxIr4a/szBm6kDzdij
 YJGtzP2sSWejWhWL8Het73ea26x1568mb85HCs/jx16ZUywYzC20dPZCWpZ7uAWfRk0t
 B+avkwFqTEv/+J+WLgqzJjrBo6eMUcTkJopMq/7EZVHy5lIlD5aLWm1m47mHAh0uxSHs
 OJCuBQ1xnU4K0DWQiMz8KzsciUMuIJwdtil66RJmXdz/8L3fZhJIaiUAyGw4TP57qbYO
 sALinUl+JNScSNP3FLzRaXkuSyLkN0T61xRB4ErLC8QUeS5OlAHeDPloxJfj0ir0sKEY
 6BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=CWqS/s6+XqPX7dX4jDDsfefSapNnTFUTSwY3ONPaz5A=;
 b=FLq+vjnlfiud9ivVcF0Q+mPScTnHRVBNyoVqSVaeYTaptmZYzmHhHZUdb2VdxKIctH
 N7Xdyf5sHIJyIIm7mYHlGQiscZbxelWnxBFbmep66MBXnFPrPuzx2eMPOI9hROIHnKFK
 sTVNUB8svfoHZnBKfdCBwtfX4h9Ndr3s1negZZqxcRXBZc134ownMUdXJBV6puA0R5Ax
 E2nm2idQ8jI6owwobEhMwl8up59sIoZShVFs2K7u/xVKo390rTHFmjJWKGCOhfBnZH8Y
 I+5zEk6pbKr8QJZ9jx9aCTP2QrLEg2rG8IFCgxBd4HOfGDSM35cmEnY0KV96TZw3PDPo
 qTNw==
X-Gm-Message-State: ACgBeo0ws9mekKv17y/qQwnFQo92YHo7tDnQd19ifkR3flb6RmWsX0as
 gngTXqagTyHujU87m23fGcPu2e7G6vvspg==
X-Google-Smtp-Source: AA6agR7rVhGZKT4Sf8Jk9FJmEV9xowTNolr9DsMBObzGbPEHUwiDR4qtX5a/tkVN7HQmRK18+EzLjQ==
X-Received: by 2002:a17:903:2694:b0:173:146c:f757 with SMTP id
 jf20-20020a170903269400b00173146cf757mr1607807plb.113.1661322345348; 
 Tue, 23 Aug 2022 23:25:45 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::6b6a])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b0016d2d0ce376sm11705503plx.215.2022.08.23.23.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Aug 2022 23:25:44 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 23 Aug 2022 23:25:42 -0700
Message-Id: <20220824062542.1695530-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rt-migrate: Use int instead of pthread_t for thread
 IDs
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
Cc: Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

pthread_t is opaque, but create_fifo_thread() returns integer therefore
on musl where thread_t is not integer, this fails to compile e.g.

| rt-migrate.c:450:14: error: incompatible integer to pointer conversion assigning to 'pthread_t' (aka 'struct __pthread *') from 'int' [-Wint-conversion]
|                 threads[i] = create_fifo_thread(start_task, (void *)i,
|                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Align the types used to fix the problems.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/realtime/func/rt-migrate/rt-migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
index 3e6c82a2f..97ab604c7 100644
--- a/testcases/realtime/func/rt-migrate/rt-migrate.c
+++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
@@ -394,7 +394,7 @@ static void stop_log(int sig)
 
 int main(int argc, char **argv)
 {
-	pthread_t *threads;
+	int *threads;
 	long i;
 	int ret;
 	struct timespec intv;
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
