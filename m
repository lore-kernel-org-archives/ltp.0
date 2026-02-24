Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8FAF3C9BC
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 17:02:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 520043E10D6
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 18:02:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D58D33CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:02:40 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FDCE200B2C
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 18:02:40 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a95bfdb31eso24384895ad.3
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771952558; x=1772557358; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJBvyghComosO9Up0b9d0GfQvYqS2Kfk9Z+A/XJ7HY4=;
 b=Gc6ZMJK1omkNrrmVNOgFUeyaKHSf9Kz03mQSQq6dMKWaNFga7DdKYNTegAXL6zPoJq
 I1orksoNyPho9O5KqFUZBD9gddsIM6w8vAofZlVKD+uPhZtkJSRNceYoBva72ZuybNuv
 1YWEPUyjUM81SQT1FAZGn5MCSq0u9TSvSnEaorHur/6fwNbzW7/tHNUMoHrTaP0eBSIb
 C1Js2GlFHtxqzbncPcKqVI8DpImQFwBwG77Dk94MAhdZ89e+5VAneN7KQ3SqzVYlItXe
 Ow46GwZHUU0XtwJGy2XPx3I805jJKCiqD1Flpq6P4kUw9Ip0tjGL+F0gTV/KUXmIw2s4
 5iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952558; x=1772557358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJBvyghComosO9Up0b9d0GfQvYqS2Kfk9Z+A/XJ7HY4=;
 b=auGbxSBenfFQXYmPQWdR/+JLQKrQqjnzY/0caHFwXoNO6fiYJ1ME8raFlZssgMdUtp
 gwESBLax9IyGMmEUyTTIabs1LTIvs4sa92Xv1Jbh7Ia1Y0mQpI0B3pXw4miDtvAt80jj
 gAdV3c25L9TYiubWgO84k6nseBSujD4x9ZLCVIKBonuOxf9YeSDZ3UUPR6W2WcTB101m
 e5TZ8HZ5M5eSa1rXRwiydS1hBQclYy4rsLztSE4lV9pe491R+WtkEqlYDVuPmbZ8Cv4R
 SB1S7/xUBjJ9xgAoCl78zxxy1xIFvu2CJSklzUH4LDzGzYr2rj3qg0CQyBAvGfnNzf+M
 G5BQ==
X-Gm-Message-State: AOJu0YwN7sBGzJR+F5f5CnjCAw6xPtxgzqyqiN+BhXDOv36MRv4OuMgM
 oucNwi9qISomO8bTff/oo0DwYmA33gZ/07s59TEHUu8ZXEw5PJUtFMwnE3QsBudIaw==
X-Gm-Gg: ATEYQzytAoko/t4gtrR+K1zGM8lavaDps+GKz/NjriCAcGkqgQh5ebrzTcP7m3kwpe/
 NcFovnV+JzD9N6xUpfEXe4Y30h/KCIjM/8SH9dd2caoW9rttuCv7T17VMQuyj8DTHzDnMkG2Rl+
 +SL+L8FAsZPJumPAC6a7OxsBcj6r2MiXsT2LzlVM1bdoQGLbK2FHiiLly235KlZAeItWB0wt+cl
 wG/PbDoduLP8eSWGityxNX+bte/r2YEghYDuAOcjIdnIiFExgWYSCIcJtTM12oUmq/rG1TFfwaD
 ByO+gIlorJ5ZLzJUiSjQptP3XC+8BIGJFpdbAQY4NQpjBhLFhlT4dnDnAJbgQj+fXAQVSV+99LH
 lgcxST28clypgryuzrOcT3wBE6PUrX2NhqY0vvnAbVmSIQ2rhUQwO8yoYXCKk4BNXSxy3Br0K7b
 1AZIYDW8WvvibkzazxL5bPb/Zj/6rEYdNx7vYPsN5HJw==
X-Received: by 2002:a17:902:ecc6:b0:2aa:d7a7:8084 with SMTP id
 d9443c01a7336-2ad74419486mr126692905ad.6.1771952558095; 
 Tue, 24 Feb 2026 09:02:38 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75044c72sm113744095ad.86.2026.02.24.09.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:02:37 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz
Date: Wed, 25 Feb 2026 02:02:04 +0900
Message-ID: <20260224170212.46294-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ3EWrWQCy7LeSTa@yuki.lan>
References: <aZ3EWrWQCy7LeSTa@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] poll: add basic POLLHUP semantics test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thanks for the review.

You're right, I missed that. Sorry for the extra work.

Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
