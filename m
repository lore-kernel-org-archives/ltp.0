Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38955FED9EC
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 17:01:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874563E4B83
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 18:01:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BC03E4875
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 18:01:28 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EA620600721
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 18:01:27 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-c7413a0e5a0so392041a12.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773766886; x=1774371686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JrJVcEu6UBBVNP4BV2zy484gl5tnQyNEMsFtS/rhUE=;
 b=WiuI+jTmJYXkyKbL7bMLKb8CCAdZD3W/p2IouKsYKAfDfpkRrDVxeNpRlAzHFHdAPv
 qx3XgljeX6ulSol9GZjxR6IuM74JY1ibYO8S8/6t7dsr3wLeWMhH0qBZswE9DiIApJ9O
 yj9uNOgoYujP5T+lGc1BTs7ZlqVW286ch/0pw55+Gw2aI6flboWP6mQ8PE/YtHWptF0t
 5qBE8jBiMUm2/RD5xlHv7u3okKIkt1EJyoxuax1Ub+bnjNnTWQpGNFJTovbXPi6z4KJH
 9yCD3D5wy6pUgoHw/3iCtcVyyH8DVS5crbTly7ZXPS1V6CQDME8U9nNXYuuXfcet6UZd
 v+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773766886; x=1774371686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JrJVcEu6UBBVNP4BV2zy484gl5tnQyNEMsFtS/rhUE=;
 b=FLWAFFQ4aqhQ1c3z0RPLU+ymRaQzBmoY7gHhKFtfOW2kwZ72MYW/SKQq49o1M19lGy
 G+ocseiWdWJYakTS3VVXEVlluAdsjn/d1rVm/vsqzdIpvNBXpVyfteicBbN9CiDRpvJk
 BlnJ86inM51U0YS65fjPKm530GnQetnP68zU7HDA1sawn2ppYZs0seYurSiT6SfS7m/E
 UrFKz/co7/a8x1B48EbS/53cY5lwiU2TTVC2Si3QkfJVoXSXTNHi1Oj9c8o4KpVAk6vl
 sfjh+jaKw/rgVIOaAKnJZpYyEDHzjExm9QnGU1ZT2hkkFF+qWe4cd+ANqSKt+AJQDxHK
 mdlQ==
X-Gm-Message-State: AOJu0YxVhezVvcI7b4thNIvRdUiL87wA3/q6bCdj6la8u+y/pSv8BuxT
 KWjJYWt0PH97x9TbL4MUPtDqgVHaYvMjzkcKd7Y/VPF1HBCLDAIUPJE=
X-Gm-Gg: ATEYQzx9iHC8ItSw1EHvUPzUDHxPNnEJTCrNuH6IFJZHYFrouRoLl6xyuFq8sBBPwQ1
 4nkEmWwUEo+or2Xh1Gf4hV5xaiD91qfj1AY8eBIq0+EHjSxjcI8qb3h14JwUDd0Os9qOekgwYgr
 XLQdPMVcIkUmvYEH4BxzklzaPbYU4CSOh3UBE0mTtI/Jn9qdeXYlTsyZn7oIrGyHbfiesOxAkgo
 EoG2MiO9/LjaE+QeuP7LGGTPXI4pHXQdH5Zls0qzsfRnYiw7E9kdj99YV+5aKL2V99ycJBrN0/b
 pTuOGWPB6sjoBHkSTPMSUBF7+CG1ZI2PDpExEl3Sn8NwqC/aODQ6wVtGnf/elQbR1lxv61vLjge
 Xn0Udb4YhoIALhssQskf9PUNH4beIVERqci0rISzp8PFloVNwKkpiUBIu7eyVJLahtxYkYAj8Me
 DFKai3jHZMh4YumejyFdSBvLcS16F30GwLg6gf7rDxnA==
X-Received: by 2002:a17:902:d487:b0:2b0:6263:6a05 with SMTP id
 d9443c01a7336-2b06e43b9d3mr1524815ad.51.1773766886048; 
 Tue, 17 Mar 2026 10:01:26 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c741e587078sm125206a12.32.2026.03.17.10.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:01:25 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Wed, 18 Mar 2026 02:00:57 +0900
Message-ID: <20260317170058.1229-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b9216e.df0a0220.302919.f339@mx.google.com>
References: <69b9216e.df0a0220.302919.f339@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] inotify: replace strcpy() with snprintf()
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

Is replacing

  static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];

with

  static char fname1[PATH_MAX], fname2[PATH_MAX], fname3[PATH_MAX];

considered sufficient here?

The -Wformat-truncation warning still occurs:

  snprintf(fname2, sizeof(fname2), "%s.rename1", fname1);
  snprintf(fname3, sizeof(fname3), "%s.rename2", fname1);

Since fname1 can already be PATH_MAX bytes long, appending a suffix
like ".rename1" or ".rename2" may exceed PATH_MAX.

Is it acceptable to keep this warning as-is, or should this be handled
differently?

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
