Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE44CD98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 05:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781587516; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sFizBpcJhIq0qtFXskHrhGUPnsz6KIlINADMe4uF+EU=;
 b=GmUSyG/HF7bJXl4WswHblaM0BHiEKNPdm1K+O6iT2rWkSJape6+KJA91M4Sj7LCaVJkxQ
 EhLPNFjNQV5LqqoB6doiZHoTPezPoqaNjHjgakC+ntJCOXo+wgLZTrniHi2gKCJtGbUOVwm
 dDirtRXJSDZC74iWsfHf32pwxIP4hMw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A45F33E222E
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:25:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 999313E111E
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:56 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA31860049F
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:55 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso36051775e9.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 22:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781587495; x=1782192295; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIP0bzxakjYuGnngIJVpfFpUChBZqttJs1+IQJ73gaE=;
 b=L+DBqriSCIjvR9x8sHAJxJwdQsurU28UEifkwNXo1shqsJawNE3o9+1tUDWvSiuPua
 R/KBY2c/rSGUR0UZ7zqedIdv+LO8IViEcrdupqWkzibRxMMZoIso/MD6dTEdNWKnHcs7
 k60wUt21Z8tOE/+VTYtXFYBHlZOSJoBGh1cfEBZqVrfnXzCTredEwTZMrTe0elaldk8H
 3ZHsd94pSNAF4G0IK+fAol2sPMKFwlRWBZ4vWPIAlDod1ryJ1jVNd2fHUZmPsxQkpKjJ
 gbimT0sZYFbA8ceRXdUsanw87sG/C1FvwpJFWrbST3HjfAj4fVIOsMUVMEOoHiD8Mimp
 8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781587495; x=1782192295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zIP0bzxakjYuGnngIJVpfFpUChBZqttJs1+IQJ73gaE=;
 b=oApwsGBLqfpQPSRHJyNut4fmp6d2VR788W03OlaKiJfV4nHh5/jOGIu+BdVUxAgclS
 4jz4Iffds2mV4GznbjIW/I2siSVxWkd8aZbmGivp60h+L37uxe8JM5/uCx9xBAQBZM3p
 udXDpkuTOUahR6HyfISyeeT12aQAqTJX8Lu05CHl70HgJA0IFNg3tITsIZckrvOW9VAG
 Dc1xyM4uc8FXG9zoYYVbqbQRWDEHT8V70KIgmU8TMn+mROAkrlSMnmGFkmfW1AaRO1n5
 NjCXnnfoOihGZqN42MUUV7poYPguBvfGCPVuezTCfz7ZfIDfDuaPYP7+9+u3ICQ8jKaQ
 vQKQ==
X-Gm-Message-State: AOJu0Yy8FXfB/RGDnC0pAb0+wNG3X8PUCIe10kJ37+uKBS1ZJRLLtHp5
 E0pw37/LPcN+9jrsHQfQWyZpj3bPcYxFs7gcnjEeeULT54SbICHSYrBZEGJsngASv16kVfb3v+Z
 TJR4=
X-Gm-Gg: Acq92OFMZKQ9MI8BwR/0cEalkvqKQJq/WWVDWxMPGcoezJE6qeZ2Xhn5g2ThaWWw1yI
 DytQZlllww8QIKNpZe4aLxR4tulKucRDWtxHQB+dTYScuI5v/ZWMu8dxzZVIx3Hbici3FHuuW0a
 ZK1bKIJNHtQodF+U5l3u1fEIotU+CJMEo/TpDjMkuVDBbvkWAk1GjxJGUE9LDHvSXMEWns6g0W6
 wNZXaRvkyO4Gx7tmvH6x+niZcvH8FN2vdStsQMEP9u00aIQx7WeyB0hHLSik15rbq5InwiWytQZ
 Tbe3TVw57hnIY4NoZR3nvy6nDmPDLUZgvB6MavwOj+Jh+TrO3KdH27P1XAmPmDLZDgtZhkMIPbh
 YJajrXQCb9wl4Az5e1bJ1rOguvo+XmOHyTjI1MfDVLD/P4ExdkrBZj+oTQElSD11AuJx4bYkAKT
 40R+/MiZXEgi4=
X-Received: by 2002:a05:600c:6d8b:b0:492:1e36:bb03 with SMTP id
 5b1f17b1804b1-4922011dfd7mr141188855e9.36.1781587495218; 
 Mon, 15 Jun 2026 22:24:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490ea95b274sm398967175e9.1.2026.06.15.22.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:24:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 05:24:18 +0000
Message-ID: <20260616052452.8353-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616014747.8220-2-wegao@suse.com>
References: <20260616014747.8220-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] connect01: Convert to new API
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

v5->v6:
- Removed the manual fd_server = -1
- Improved Commit Body

Wei Gao (2):
  connect01: Convert to new API
  connect01: Add negative tests

 testcases/kernel/syscalls/connect/connect01.c | 400 ++++++------------
 1 file changed, 138 insertions(+), 262 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
