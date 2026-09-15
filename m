Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB8CC88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789486679; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5YFdjobUaDnWvJklT1ztSMIDg9PW/7cHb1rDCGQKhOo=;
 b=D3Po2Jv+TUtxctWci/w4xXsIIF8nDUO00Xgm+yXryv8i46PmMP4QcW0hmv/3V6RFGSXHP
 7pkHTR9JSzVSTK6H2qXdvvUc/rUkp3qHgVRSM6OkA3DY5+Zf2iTEzdVj+LfcjlZmewaNDc9
 bquCF63UnPgN4nLjRYC8DJPRTi5r484=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A18443E8CCD
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 17:37:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 610483E8CC1
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 17:37:40 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F1331A009B2
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 17:37:39 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so2715645e9.2
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789486659; x=1790091459; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AG1quDXKwFcKGv/rOvogAqxgZy7rR7uTXdCF4r7Rk24=;
 b=Uc+V2AvoZClevbn2E5b64ELCmHlgd+x4OClfQDMOVOIV5nsB3m4pxAFkVndrQ/ZC/W
 YSpX4SexkKdl9E9VsPdfgDhxyYpLMGCAA/cLOk3BSeKG63Yic0DRbV2JbVcgMwAg/niS
 o2X8XammsFnZ95GEGeFyTgQ9xrT9cF7JErEOFZAq/IzeWL1sAAhD3xATwziCDjKU3fou
 XemCXYNIDfzMqJ9JfeWjtHS1HLJ9fhR+7Hl3fl6hdspbPtAR/QCd3SkaWWKTd6PJdpck
 4u98xZ5FPw+2CJOjbpLRMtQOGxDH+zi1TS9izbGIC9YaaXK9fplqvztQtGyrHH+Xxt7k
 hJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486659; x=1790091459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AG1quDXKwFcKGv/rOvogAqxgZy7rR7uTXdCF4r7Rk24=;
 b=HwkKvVSr65MrImxftyaeoWm9/OS+1ooZB4CZmotnNyW8J7L8QCcMX8MQl+60MVhwB5
 udQYg8gm7yD9qzA8idrJ95eqKRv3VZvU92bVKqqTIyfJpP9WwVEzq5jcEmwOZ8HU0dwV
 CikLoAgrwXZr3qKpxbMalWpXS53v3wTJXZxLFbjUFutLN18xmjKitK6dkRl0IOmcAzrb
 MQD5LiYziAFmb93A2ocXMvxRR7rUiLh4P6ctpeQ8eBwCjzn8FZpTBRzfPvjeDkDLZT4O
 Le8wvlimZz1YYgAJd2bQxAx/Wl3tQLocwtDwD2+x46qf5/dmp/bReZqG3dwU4fApQfjj
 uhRg==
X-Gm-Message-State: AFuF++mZtVCn489K6e2xPmBNSG5fdtPXICP1QFwu47pAqtyWyojMYl/F
 D2D7Xg0RGDKrglSNObI302vWCsKqoTD2IC+EbVQz+I2mZ0ydxFUc4UD8ZG46Oo6GKy4p5JU6lDN
 /EGPRMng=
X-Gm-Gg: AYBFou1keR/544w/8V2Kr8ZOpeAv++SWn2KQW8hXgdBbc8X7mBx/hSEscRGgWtKnDJx
 aqRA27Fjw64ZsYyE2QZCYsJYl6lZXIQD1dDDQnnVxHC8WvP4glJOyEH+urpbF4DoPYvxHVBqy8N
 z78hEFp6aj+wCSSBjpCmWsmFeFg2Grjct48crYDtqDbZFzJYx8c4o+fOlX7a4rlCp9DIV4eInvR
 zUludcCcwuC6F3XA3SgMVKaoCkicipBRqdxCFB+hFqctjI7UDYH77G8pr4NzC68PBJTovr3+PX2
 OiEKasy7fx/IKLQNdjRQuxAeuaY3I36yd9WP/xkf/vCcMGu/VPZ78QzX5Gz0wv3snBKYtphWBpZ
 ONk3QwuOWiK1z1sOmNk4k9zb8TdkfSOirCj7Z0kDEeYsA00XpprGLJftrUX87FDiTsT+ro8kK6+
 7mLEdIwZ2lg4kVt9NlCiUPm+vbm5jAoJJewuviG1+yBTQWPvaslI9SA7ky
X-Received: by 2002:a05:600c:3145:b0:49e:74c6:d973 with SMTP id
 5b1f17b1804b1-49e822c5633mr23436815e9.31.1789486658871; 
 Tue, 15 Sep 2026 08:37:38 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b12385sm3127975e9.14.2026.09.15.08.37.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:37:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 15 Sep 2026 17:37:37 +0200
Message-ID: <20260915153738.78189-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] uevent0[123]: make check fixes
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

- use tabs
- use "(foo *)" instead of "(foo*)"
- remove multiple blank lines

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/uevents/uevent01.c | 4 ++--
 testcases/kernel/uevents/uevent02.c | 2 +-
 testcases/kernel/uevents/uevent03.c | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/uevents/uevent01.c b/testcases/kernel/uevents/uevent01.c
index f5fe099d8ed0..28143a4b93e5 100644
--- a/testcases/kernel/uevents/uevent01.c
+++ b/testcases/kernel/uevents/uevent01.c
@@ -57,10 +57,10 @@ static void verify_uevent(void)
 		tst_brk(TBROK, "Failed to find free loop device");
 
 	snprintf(ev_msg, sizeof(ev_msg),
-	         "change@/devices/virtual/block/loop%i", dev_num);
+		"change@/devices/virtual/block/loop%i", dev_num);
 
 	snprintf(ev_dev_path, sizeof(ev_dev_path),
-	         "DEVPATH=/devices/virtual/block/loop%i", dev_num);
+		"DEVPATH=/devices/virtual/block/loop%i", dev_num);
 
 	snprintf(ev_dev_minor, sizeof(ev_dev_minor), "MINOR=%i", dev_num);
 	snprintf(ev_dev_name, sizeof(ev_dev_name), "DEVNAME=loop%i", dev_num);
diff --git a/testcases/kernel/uevents/uevent02.c b/testcases/kernel/uevents/uevent02.c
index f3d2ebc87a74..fd526ddb1c5a 100644
--- a/testcases/kernel/uevents/uevent02.c
+++ b/testcases/kernel/uevents/uevent02.c
@@ -102,7 +102,7 @@ static void generate_tun_uevents(void)
 		.ifr_name = "ltp-tun0",
 	};
 
-	SAFE_IOCTL(fd, TUNSETIFF, (void*)&ifr);
+	SAFE_IOCTL(fd, TUNSETIFF, (void *)&ifr);
 
 	SAFE_IOCTL(fd, TUNSETPERSIST, 0);
 
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 42d629a4ae8e..8c8a464af5f6 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -209,7 +209,6 @@ static void verify_uevent(void)
 	snprintf(dev_name1, sizeof(dev_name1),
 		"DEVNAME=input/%s", handler1);
 
-
 	snprintf(add_msg_event2, sizeof(add_msg_event2),
 		"add@%s/%s", sysname, handler2);
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
