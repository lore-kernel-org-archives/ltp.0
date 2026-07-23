Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE24BC531CB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784800234; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lZPnuj8wct0FHY8YZRu2qQgHL628EMyNIz2iKBJnRuw=;
 b=YDdTKR3uFVFpgjB3p/a45F04Hc/EjiG9ay+Wy4Qqr72Q0UXO1AWIXRM4jJ+e42KqtcK7C
 a/UZsZapR+729dI8wpANJt9j2mZ3NnPFtzKtSPO97c4zQkZ3HA7804cAdDH2GV5wquCFc6P
 2Cti4aab+8TDWHyNQMTUyiHLYgn9XWc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F20F3E23BD
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:50:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41F393E2BD6
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F007F1A0081C
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:54 +0200 (CEST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B3D173F678
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784800193;
 bh=e608FKIJ0JX+ThIFgiPVSB9Xv3XECkV0iiT8wXNpz5s=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=i3aJDJHTv2V1MUHimU0HfzDbgKugrQTsaneEIj2H/1SllZUfKzQkoss1Za1INVLFB
 8NkhlSwQKlSNBIBi827SLmN4pNe5Yg0ar3jqtNRobmU9LH8alzXhdT7kknhfMJFfYP
 FC62TyW10VGjlzXQrddHJfD+YGLTMPEOIfmJ/CaWHjXhliLye22UixA7Fatwil54vZ
 bnL1Uuo/XcSU7J9B7ORbNdftw9PboRLbj+jZYxm6T5bjGQv5ejD2X7FdlQfEmI9Xy3
 vEU9XrOWrz02JbK18tqHmZaEBgO4JcV+scMqa9/VKeY5fzayjtwrMbCEb37K/VEfH4
 5vdS2/hkGKEwC1ZnGkNm/omQmarH5/oSN+ODn3gKEwUJJIlYC2BFPgSV2DIkRzulCW
 MLOrfgIO1d3q6HNvnAlpNuTefWmPXOeNbyO9DYzm/SeZCZeXzrECAFb7jSvPCyzYqw
 OASYj7/+T2Utlj5hDVyZ6iVLUG7UoU3wde/S24xMW3yn+6tymGNfQqLkDWWvATAplx
 S2wgoGFViA2VEX4g5nud0po0p7iewTdnWIFR5f9LqGOnruIRTxQB/qIovfnlxv1Fsx
 RSDSfeDWijyLVKcPHXBXAZ8E4hQ3Oj6GffdKo4MZYUUIz1ZohCcoEZSugQVh7IJTHc
 K+VhsWO3uoGrN2COxw4LDUH4=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so4582785e9.3
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 02:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800193; x=1785404993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e608FKIJ0JX+ThIFgiPVSB9Xv3XECkV0iiT8wXNpz5s=;
 b=VaNnu+FYHNNexb6NYONadk29Tsl74rJUGIl7lFTzCDMZ6SldzOmuG22l/qQoYVh0Ev
 RF+Ne7toRBwsHL3yc/6RbOZVxVPJM+hm9P2HwWi2WRRBu+Oh9J/IqBfGR5W8RTYipYDE
 xXF8wQqxhAheJfWvgt6Nt55kRfobPcAZtL9jWPCRRN0geZzJ2O0rwVmeuPvKVNKO4FA5
 clyiYxBu5p26dYBE/KyL+9CvpkFtDySeWqQjQn/Sn0kRCMJXZGv4PueLVlgQR6m/lNxj
 H6tidLDPpwDmZJgkORCTooAhcSZck8oLwi3tEPJrNYgl26Y/f8PO/rdgSOn3XPVdc3b1
 7h9w==
X-Gm-Message-State: AOJu0YxZ6Kl5aJy7xnIqzHZPS39VRP6zJpPwZQTOnFmp8+tdMWaDZrdK
 EtQKTHQKhJrZR8YloYiH5F0n+z7jTdD7btRediWYV/822KkE4ReyRIiJtFuer/kD56a5AjaGKHw
 I94If60bdV4StILHINMEjy2IB/Cr4syp+YKPQLtz63+ZQttTANiG/7WFeZ4kWc4QnQoeUEN8Pwc
 JJ
X-Gm-Gg: AR+sD115WXm6Qv8ZnDuwOVNd+H0SoSCtDrLaTMRkZZnLSNZA2zWOuzuRO5UTdqraHX/
 fQtysMQ7rFaZpwNMldMy/Tvg6buu68PzeIoslGdadVABORJBhGtOzLq6/00+jlyoKZd/8alb3AZ
 JYWkslFU3FhrrmxchCq4EOFK8NJMuZPLWXxm+k3kkUlqLj11VPNAJdom8VkN7dEnO1EGP4RdkJW
 BuYcp//1kb8Uie4J+6B+tF6dGeVJvMAxeraBv3/pm0YdsxyY80aMBpM/4zusn9RxVjokozNiFPg
 LE8SCSG5m9C4RVxYH2YwXZ/snPtJY+6YhjH73IB90umZqCXQZIy/4dLvep+bpGaP4C4UgGoDI+9
 s/X2YyoGkBHYMfkfsEeuI3OgsDy3WXKirCQzGaeChYnEQTf6vX8FynkYcxang
X-Received: by 2002:a05:600c:2104:b0:495:4589:707 with SMTP id
 5b1f17b1804b1-49573cc2e94mr17430005e9.5.1784800193270; 
 Thu, 23 Jul 2026 02:49:53 -0700 (PDT)
X-Received: by 2002:a05:600c:2104:b0:495:4589:707 with SMTP id
 5b1f17b1804b1-49573cc2e94mr17429775e9.5.1784800192849; 
 Thu, 23 Jul 2026 02:49:52 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm196600555e9.8.2026.07.23.02.49.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:49:52 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Jul 2026 11:49:46 +0200
Message-ID: <20260723094947.2639934-2-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723094947.2639934-1-kuba.pawlak@canonical.com>
References: <20260723094947.2639934-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] lib: tst_rtctime: close RTC fd on the ioctl()
 error path
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
From: Kuba Pawlak via ltp <ltp@lists.linux.it>
Reply-To: Kuba Pawlak <kuba.pawlak@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_rtc_ioctl() opens the RTC device with SAFE_OPEN() but returns -1 on
an ioctl() failure without closing the descriptor, leaking it on every
failed call. The RTC character device is exclusive-open, so a leaked fd
makes the next tst_rtc_ioctl() open fail with EBUSY.

This was mostly latent because the failure path was rarely taken, but it
is now hit routinely on RTCs that reject RTC_SET_TIME (e.g. Qualcomm PMIC
RTCs returning -ENODEV). Close the fd on the error path and preserve
errno so callers can still inspect the ioctl() failure reason.

Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
---
v3: drop the errno save/restore around SAFE_CLOSE(); a successful close()
    does not clobber errno, and SAFE_CLOSE() breaks the test on failure.

 lib/tst_rtctime.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/tst_rtctime.c b/lib/tst_rtctime.c
index c62ac73..99c16ec 100644
--- a/lib/tst_rtctime.c
+++ b/lib/tst_rtctime.c
@@ -117,11 +117,12 @@ int tst_rtc_ioctl(const char *rtc_dev, unsigned long request,
 
 	ret = ioctl(rtc_fd, request, rtc_tm);
 
-	if (ret != 0)
+	if (ret != 0) {
+		SAFE_CLOSE(rtc_fd);
 		return -1;
+	}
 
-	if (rtc_fd > 0)
-		SAFE_CLOSE(rtc_fd);
+	SAFE_CLOSE(rtc_fd);
 
 	return 0;
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
