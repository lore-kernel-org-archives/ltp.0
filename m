Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11F9C282C6
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740768553; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=ac5uW7DIn8z4ziIY47QeC0SVDp7Xz1lvZyQEl/LWKDA=;
 b=oORBTDtlOWy7OS+7JoBOf8QimJac+B8KBwJyYz4krAjksxnli9lZC0KxJ3UbnDpedK4m4
 nHFtKsI9vIowUMxunAmIJeewC+GVwwfsfV52ieXIUQ3VJ1qY0saYAaQwX2jNf7CZakL0LR6
 CY23VKGCA7VDg/YUa6d4h4C98iYevxU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1B123C9EE0
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 19:49:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6276F3C9ECB
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 19:48:52 +0100 (CET)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A1589142179F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 19:48:51 +0100 (CET)
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2feb8d29740so2922361a91.1
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740768530; x=1741373330; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QMBBS6L3ZtxZfCo1O65ckU7ZaqWeJPueJY4vrHARHpk=;
 b=I8RQySetZFhRp0mAbYoXT+WRs7QZ7aAgcGgXBHN7DymbJWdrWmbZGI4IP+xFAAZQG9
 0abWyLtkrRxre80TnkI+E5/NltNyGp988KYrPrBStELqjPuZBieOtKxiVFZe09WPd4S+
 biRNXpT6RRbl1Xi1QlFt0v/mibd6aWVdek3P7nh84aoqj6Q5ycrAoOWTftGTQmffuNgt
 DQBFZ1V8XGH+/WM0CjdkCG518yKK6GlSfu8o6QBB9jbBFsHfiiVSPzIhtlybK6s6av5j
 45qeEha2dTzywOE8vv9pbYgG7kSV/Ux7Zs9mdPBgKJgYUNTVZPlG6w6gD7TrrRIS5Doy
 r40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740768530; x=1741373330;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QMBBS6L3ZtxZfCo1O65ckU7ZaqWeJPueJY4vrHARHpk=;
 b=dVOEvJJajqBQK8Ym27USixA9/+vCkvSkP8fUGDMXjpWawTtIu0kCj2OfD2ThsiJjjK
 fEQqCycaeRN8BibHZf3x+piRveiH4mv6S77a1wipBOYJlQ5CRS8oo/AsqIJgAXdr1lAU
 BWPupa+W7+EDV/BJ+q4Dt+YhCTsHrmOHPt5IOO0OdKXuH+8wgyP3zHmtBq6A8b330RNC
 Y9vLnKxpYz35lCMrPe904WqpxnkzHggKmdJHuUxb1k03E7mxs6jakdyRdgFUakcravry
 dgl9pbQ49soSFj6wcap+Ra9J5fYKmPibNgyvOs1ShIncxHNrzcpeL70IiLMOD1hsKJew
 xvlw==
X-Gm-Message-State: AOJu0YxTKe4moPXZAF26IVizGdwQ4t6eq49W5EINYq5hqBHA5Lzuampf
 THUfwizOo2GNlGjgPqn20xaxPSlucf6I/MotgAXwV7YSLgbFZGK5GWKedOmCW0jhuWDDfyNsPmg
 jiVW+BAckeSBxLYZ4GGZx/KpMco3uwOzgrgTVrU1oXZvIcaPtyu4jteO73rRGtMMC5wVwkHW4EB
 s+kR0nG7QK6BQpfGX8Si+9M8PL4cA=
X-Google-Smtp-Source: AGHT+IHUZJrKdgIFrtV972V3auXAvoibsxKUflblRYSv7arWxN8JSl8NbuS0MrD5p7ehDSSIE7fma5BOpq4=
X-Received: from pjbdj8.prod.google.com ([2002:a17:90a:d2c8:b0:2fc:3022:36b4])
 (user=edliaw job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4990:b0:2ee:a04b:92ce
 with SMTP id 98e67ed59e1d1-2febac08d73mr5936641a91.32.1740768529662; Fri, 28
 Feb 2025 10:48:49 -0800 (PST)
Date: Fri, 28 Feb 2025 18:48:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228184834.1330657-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] input_common.h: Add retry loop for event device
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Android has a delay between the entry in /proc/bus/input/devices and the
path /dev/input/eventN becoming accessible.  Add a retry loop to account
for this.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/input/input_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/input/input_common.h b/testcases/kernel/input/input_common.h
index 0ac1624b3..5b1755771 100644
--- a/testcases/kernel/input/input_common.h
+++ b/testcases/kernel/input/input_common.h
@@ -29,7 +29,7 @@ static inline int open_event_device(void)
 			memset(path, 0, sizeof(path));
 			snprintf(path, sizeof(path), "/dev/input/%s", device);
 
-			if (!access(path, F_OK)) {
+			if (!TST_RETRY_FUNC(access(path, F_OK), TST_RETVAL_EQ0)) {
 				tst_res(TINFO, "Found event device: %s", path);
 				break;
 			}
-- 
2.48.1.711.g2feabab25a-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
