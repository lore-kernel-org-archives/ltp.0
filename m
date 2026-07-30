Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF9CC55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785418707; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=xSBbey/p9VFzJHyNQ5NrwBvC6+GzKlKoq2DJQJBOxZ8=;
 b=IJPzbyVELzXnawV9i2Qg67CalMmeYWDwLmJ1Zvy346MPxyMwrL1zwnAEM6wWjWaQw+aOh
 f1ktdIcqsARaQZwt53EpvuQos1JuxESRmHKyxHAEsJ3o8Dzjx498hoyKowsz4hqhW1grBm6
 5CkdgwTNOLQwR8cGVw+SAIWJtBKVHuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22A423E7254
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:38:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D9B33E1C9D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:38:06 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7671A60042A
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:38:06 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso9910775e9.2
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785418686; x=1786023486; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RYOf+8y0ImB9lRp4DIBfBJeYGSTMt/dRqA6S9s2bz8g=;
 b=fK+lshtfAy/hx9E4/xXMTsvmL5dhnBV9P8zuM8AgqApUi3v/iLJJxfTrZ/Bl7zm6Fl
 +Xl85BVQAdVlCHaQ0P4GDq8WWXid2MkUajuqtgPGF/nv1P55UzJo7bd8cp8BOyXjYj3L
 X5Dk1WnSUJMJYa5ndwcv7PE2PLSytffbMtvbc6rlUVZClvPD6/oAReom9Q/euk2qxq5b
 fvHvvmqLf6NzfbqBD15eGJttSx49fBtCA46ebWihsukqgoO5IglLnikdIS7BGgrOUOpp
 /Yz/Km4K5UhmRsGwqTDBpJjH7Frb+bPoBrUlyC7jAvlA1tVkMMtwO8PMxnT1tipzKUpP
 vpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418686; x=1786023486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RYOf+8y0ImB9lRp4DIBfBJeYGSTMt/dRqA6S9s2bz8g=;
 b=AiyevMLJvmBuOWepUMotFJOhJsulg7FGu97VFlMqN7eMCxaD6a4b7CJnxwqHLWbmKY
 LgXQEm4rBVOlSbqWsLtluzSV4C9otRihoVGPXUoZH/PrHWYcLoC7v49FIu5dqsOW+YGR
 9gEOv8qk2UEiFrneMJSgJL/ZXwh4BmqrPmwfcWe6zCj1vOqDHSG1aKBaqZw1itXzOJoJ
 k+jJ1PR1kDo64rROINwfs5wfUttxkvXWOeIDMjQO4hoyG83MruhdfW15qAo+OTrRB0ou
 b9Fm0rbPRJyzl0/aI8ublOAXIydRv2lxcIUPDAupBHTGZ5C3y+pY4z4OaiQZ5jOztjrr
 568Q==
X-Gm-Message-State: AOJu0YzClZoxMpQsYKqPcfPG9zKPpBdXbqL0FdMU/Yt8ZSMua4nt2J5z
 mOf9uQTLZJVktoK7ht8bPV6sfo1ZbjPYvlF8Sh3PBxzuv4DvGEv/gTIj44Vp+754nLMbWOO0P5O
 E29r+3KQ=
X-Gm-Gg: AR+sD13mT+YfHcqpy9bvCM47BWHRzTKDUdHTKkPgo1Gph/7p3G25bw1VWRyVyp3LQQW
 8ijPGjt2EE+A9JG4/hK5VACRNV8TQaiPu9/VW/fUEXgN1k+8rILzqyYET+khrN0iOT1iR1czEB+
 EiaIZuWypLYfflNYzYZcvjTkfGe/qYfpSz7TCk0LI4gHoQXbQkudHcZpIydNk3p1zfW5LPpgySj
 IillMkwY9ghJBmiKaifA6CUMRY0XhIZ+IQjaESWqaUeLf3QNJ4yimFjQste9zU9+WTbuSA9H3lz
 ZyzVT42geqRyyQP9Ig89HPIEKKrfKE8ho+fK+jxl+jDd6puA+YFn7FuEZn3MVM4mW5ENWj718uq
 ciEFbGCVG2mIuoHklQHMEKCQoOcYw7ACPIeNStkZok44ZCkHYZujtJXMDovU8X8IFT0Tss1cha1
 6W6oVYjhbwg8ajs6WQohXYkqeknT6dYrbRtAkalSLPXCETmfo=
X-Received: by 2002:a05:600c:3154:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-49804c15481mr7845835e9.7.1785418685762; 
 Thu, 30 Jul 2026 06:38:05 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8940da6sm6242563f8f.32.2026.07.30.06.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 15:37:58 +0200
Message-ID: <20260730133804.131074-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inode01: increase dev_min_size to fit the peak usage
 in parallel scenario
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

The parallel scenario keeps every worker's tree on the device at the same
time. On exfat each object costs a full cluster and mkfs.exfat defaults to
32K cluster size for a volume above 256M, causing ENOSPC on a 300M device.
Increase the dev_min_size to 512M.

tst_test.c:1985: TINFO: === Testing on exfat ===
tst_test.c:1291: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1303: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_inoLqT9T5/mntpoint fstyp=exfat flags=0
inode01.c:241: TINFO: Testing single-process small tree (depth=3 fanout=4 repetitions=100 workers=1)
inode01.c:228: TPASS: Created and verified 28 objects in mntpoint/inode.5827
inode01.c:241: TINFO: Testing parallel larger trees (depth=6 fanout=6 repetitions=8 workers=5)
inode01.c:61: TBROK: write(3,0x7ffcea2c2370,73) failed: ENOSPC (28)
tst_test.c:478: TINFO: Child process reported TBROK killing the test
inode01.c:64: TBROK: mkdir(mntpoint/inode.5832/00001457/00001701/00001862/00001890/00001907/00001911, 0777) failed: ENOSPC (28)

Fixes: 8ea955383e00 ("inode: convert to new API and merge into a single test")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/fs/inode/inode01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 219238553562..de88f4c8c969 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -256,7 +256,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_root = 1,
-	.dev_min_size = 300,
+	.dev_min_size = 1024,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.timeout = 300,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
