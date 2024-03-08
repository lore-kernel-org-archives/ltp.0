Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFFCC54798
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 02:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709865225; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4EO0iEVaHdhgXUHy6DCLl/TnaZJTwRqov3alct11q4o=;
 b=douMi8pLMDredHL2UwlZT5GnuDWZWxNWs1gsOltlw0mWcyweQ7I008tt7OAn7S7grc/5I
 Z0n2BENZy/Ou/pdVSk0KELtjSqwj1I7/7y7F4YQyO1nMM3oIaxEl2c9yWMdiCjLodU/h2PS
 qCyB73nRJ28s55S4KWY34OuHDJjAD7I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18A423D1C19
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 03:33:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D9D03CB8D1
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 03:33:23 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0EC4600A1B
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 03:33:22 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso589805f8f.0
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 18:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709865201; x=1710470001; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EiD5vJ99bnsZocl0Vqj+hhjQTzULB58Gf7R/G1e7Blo=;
 b=REzWjkaihMsU2DjssS0tq6ADtj/VtRfTlASBYEGmqJDlhRHHZTPLjMcLvKAdqck65I
 3fc8dDYM6G7E0xa7GTbhkbSSbz13zMjmCyIaWVaMogPaaJfNtmg6yrnqLZUDlwmavzGg
 kNr9Qbf7n/AV+jVrL+IRTkNR4WD846Ze888Wyz5axlnplv7ZL5oZ4UK/LYbaBdIzBPH+
 d74I9Wq+aCCRiNqOYjr2KV6DgLxIGT300Efxjm3pP2zQwCs+zCZSw9l/dUb4HyPQALTN
 euqA4o/dvCsMbi1FmxacDxWs6qyYP9MJNQ3ukdTCkIZtJBBh05vu+V8NK8p9/vFQyG/Z
 BxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709865201; x=1710470001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EiD5vJ99bnsZocl0Vqj+hhjQTzULB58Gf7R/G1e7Blo=;
 b=OVDsuLX9TBH7e7QywzHfVDjFwGZ0jdEUyobmVzitUbhbt+6qA1d8GoUSpVMNae4eD1
 v95hWL7JUxARu4bP8n1D2pfDc8TD50ABE2KtAsDOpr4YtSIumb3FMzMZAneuPJ6YB4i3
 WrIGNScPPy0ZSsG1G3WbOfrQWKWlOeJirxwMoPz6h7kayGzDSGYbUydg+BYXI31KgfyN
 wBIRYHVieGkNwyJ298+qY7KFYTL3OKU7S2FjA7uXrxs8V0033Gqo+RwXYoimUEL68pa1
 oPTlfBmzBLG7WPhT5bSAD1AMPIEk1NdGoKvIcKRcwTo3BdGNzBN/IaKPGIdzEDPmENcb
 OU9Q==
X-Gm-Message-State: AOJu0YxDxtzNR90XiqCLG30M2FsD0JNxIhFRK3794uMD0ljLbUs9hZNm
 uRf9KYDAAZScmp+GFbox98S8CmYC9sa9yEX3zKSwML9p235pTjBRyyYTRS5p5b3u/rKE+NRLBPQ
 =
X-Google-Smtp-Source: AGHT+IHhpmC8526Y7ZQVRsLsdNd/jRWlt7KA+2vnjRV7rh2cuiDiBQe6/S89U9gwcFhdVgqHhRP6Cg==
X-Received: by 2002:adf:b649:0:b0:33e:1f2a:d88a with SMTP id
 i9-20020adfb649000000b0033e1f2ad88amr15414620wre.69.1709865201594; 
 Thu, 07 Mar 2024 18:33:21 -0800 (PST)
Received: from localhost ([81.95.8.245]) by smtp.gmail.com with ESMTPSA id
 bx33-20020a5d5b21000000b0033cf4e47496sm216607wrb.51.2024.03.07.18.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:33:21 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu,  7 Mar 2024 21:33:12 -0500
Message-Id: <20240308023312.25449-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] memcontrol03: Using clean page cache to avoid
 dependency on IO rate
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

Bad IO situation(storage bandwidth ~10MB/sec) will lead background
writeback has uncertain progress for dirty page. So system can not
reclaim enough memory for new process and finally lead a unexpected
OOM.

memcontrol03.c:218: TPASS: Expect: (A/B/E memory.current=0) ~= 0
memcontrol03.c:116: TPASS: Child 1918 killed by OOM
memcontrol03.c:224: TPASS: Expect: (A/B memory.current=52588544) ~= 52428800
memcontrol03.c:129: TFAIL: Expected child 1944 to exit(0), but instead killed by SIGKILL

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 9c6c808e0..9903ba82b 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -201,6 +201,7 @@ static void test_memcg_min(void)
 		sleep(1);
 	}
 
+	sync();
 	alloc_anon_in_child(trunk_cg[G], MB(148), 0);
 
 	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
@@ -217,6 +218,7 @@ static void test_memcg_min(void)
 	TST_EXP_EXPR(values_close(c[2], 0, 1),
 		     "(A/B/E memory.current=%ld) ~= 0", c[2]);
 
+	sync();
 	alloc_anon_in_child(trunk_cg[G], MB(170), 1);
 
 	SAFE_CG_SCANF(trunk_cg[B], "memory.current", "%ld", c);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
