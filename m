Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185BFC43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783501993; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mYL5pp5Lzk8zlT8QEvwLB3w79Q4m+YF/Hsvw5U4LGCI=;
 b=e0ZflneocwpdJyvTG0/1hgWa0qZ0AOPUzrgDgICA/n5/gQQrtbWg20ltlVkZ6L4CR9Wik
 PIY/NWM/anlGFY++b7JD+PAibPSLlHtRnT1ujHhos1EgBA6MWhAJmSxU+KTfTw7J0m7D1HM
 0CjC9yEu1WRyoD246esLS7yoxyP4kdI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DEC53E29ED
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:13:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4551A3E29EF
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:59 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D923C6005F0
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:58 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47362928f65so375771f8f.2
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783501918; x=1784106718; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKO2AsNwS8Rrovb5jFWxbJsFwmiX9kuxZSAe/7hlC4s=;
 b=YvUOdWsLD31XjEifFDDHu2aoRzV0wcNFJKPmXxp4Y3G4Al/AjGk14dw0WHVhVXk3MX
 tTIhFDzr5jFLScIX67CpcIqDr91kup3LJZX1HWtmB0GZS6nOS7wXUfB4j8JpnQM5a347
 hKkVYzYqqgE3swpBU1vsEeUbS4kNqd2UcfpJ4b7HGMrzPXsr2V++7QZTmrQgzLu4ORjR
 JbIHbJ+8EW/G3NifzDPeMWQ6SaawJ2JI5EqqyXOb69OSy7DPFUV+yFnDkk0YwFAeaiTB
 o89gxPHNIUH/4eg77VMfPJ3frpRzUgmN8HGRGokT+gcTpJnYGrkh0Fi7v9OmfFmdONpv
 GO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501918; x=1784106718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lKO2AsNwS8Rrovb5jFWxbJsFwmiX9kuxZSAe/7hlC4s=;
 b=gohVZZucY5/Q8w7brhjPWGSWUMWGBW08pH73yYRBlrskC6ylDAnMNgub6D7LI5qrLO
 sJHfiXUrZaXsPFHuzY4sNHljpJeqXLlTS4ZaE6TFtPChnOO5Iy9b9TI3+P10g9s1haaj
 riTb6zjm2Rf7PfmEW+/4c3Uj2zZQ2yKWAeZl0tHB2rC1dJYVRNORkAUFf8woNaTfU7ik
 dhYZEHpgrLLk9WkCy4wJ2fQohzSd44uBF1zxVbpKO2QuTwm4v1OnK1E9BOzmQQtW40KP
 fibhEjAhgRmsgq4qVQJWI02+mJWu6CVh01Op/wV+VXn7Wawh5QDgmKZowXG3ETs7dy8Z
 lghw==
X-Gm-Message-State: AOJu0Yyo6O+Jdk0xyKUCLBPNitwTYilnXdcNiK6Q8wUmQk+hklTm30Sy
 NT6q8+ZOvdTeVd1rnDjTjG2AOA58I3e2ZSyuaq+SZQZlDx0712gzA8WqFOtTQvmsA1FtU5A75Ur
 6ejni6cQ=
X-Gm-Gg: AfdE7ckWyYqBzK1zuenmYx6555tFwH57WIuxmgnvgHy44sQjsNl/XKYhHHWTkDtia5H
 BUOJYjzm+rKWmy05pRLEynZbncwrkQnVehCavwhN+Zc2+HUzjAD5PcEmF9vfq1SKWfgJa5ymvlA
 cTKM35zxmuGoYqNdG/gRX1IX7aBF1f6jfLj3BMXepDp3kry8zdfPEWVzklt9+fskjk+owZm6zsM
 lw5jyMS6GNnmt2XaF1KdUdIDYMYr5V64q0jQfA7gvD8kmFPKGd4GPGlO4QmwD+Ma5jlz55HlVOy
 LL288al0PYvwDyjCPAWrK+MV0WIAaj9W2lxyuZfx212/8vB5A2Oouf6MTn770z9ZI+1wuceeHwJ
 O7M40v4XUIuLUJarazCXw2zzvlQR9PfVeB04V05AOnOW0YjGjZHBx53llJcdqQwG7W81TmPifPe
 Y=
X-Received: by 2002:a05:6000:4028:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47df0797e0bmr1762338f8f.30.1783501918239; 
 Wed, 08 Jul 2026 02:11:58 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm45658847f8f.4.2026.07.08.02.11.57
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:11:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:11:53 +0200
Message-ID: <20260708091154.999385-4-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708091154.999385-1-avinesh.kumar@suse.com>
References: <20260708091154.999385-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] syscalls/cachestat01: Add spaces around '<<'
 operator
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

$ make check-cachestat01
CHECK testcases/kernel/syscalls/cachestat/cachestat01.c
cachestat01.c:75: CHECK: spaces preferred around that '<<' (ctx:VxV)

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index 7cc72cc1bf21..1db530ffe9e5 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -72,7 +72,7 @@ static void setup(void)
 	page_size = (int)sysconf(_SC_PAGESIZE);
 
 	for (num_shift = 0; num_shift <= 15; num_shift++) {
-		if ((1lu<<num_shift) * page_size / 1024 >= tst_device->size) {
+		if ((1lu << num_shift) * page_size / 1024 >= tst_device->size) {
 			tst_res(TINFO, "Limiting num_shift to %i", num_shift);
 			break;
 		}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
