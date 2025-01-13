Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000B4C02180
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736805814; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=m8mgnUBJpbnhsw4DJPkvMc+d38VIk/fxJk2r3CmgfFA=;
 b=TtQtxwaY5XtwaOgLVDp7gtlZ/Cq0J2gAAY9xjGIHIf+B1gEP0nqgOgm1hwicmpQVP5874
 cX7bQZth74/22wAxSC4Oqtvn2W7jAdBMsOUQ8QYzTeLDfV02dB0MvXXPvBy3NCQCsivDPIM
 utmDrTo0xHqoYfY+4e2+mEbjrhHE4yo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6648D3C7994
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 23:03:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 760173C286F
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:03:12 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F8521BE673F
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 23:03:12 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so1002552366b.3
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736805792; x=1737410592; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rcTmE5xqh5gaEdltFqxYimaddb6vq3LA8KWbXhRg3FM=;
 b=LQL7oKc99s4K4L12aO/4AoB7cEWgeU7IiDdgREav6qjjgQvV/2W/A7cu7cdg6shj9f
 v1BhV3kFDXqsPoUwylrrTInw+mUjOdYhOZCdgOrCffXJw6cjs1VNfl4CUEoSoh1T3TEQ
 lFt2oUZpHCIhkRz62o8bs2DYCitjUnR6PUbJwb2uNz0ncKMO5jXYxI195zIpgJ3uRmiN
 Q165LtNi6GqME1ryrNyTomFkALQOxJdDynFDANEYV5PCw0QVY1uaEGRq3tL+V3fc2aHw
 CVorSmzUjY+0a6oel9wH5PFi1bcK3AOi524MFtcWNWZFyAofVPIZCG80CFcLTXRgZPe+
 B5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736805792; x=1737410592;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcTmE5xqh5gaEdltFqxYimaddb6vq3LA8KWbXhRg3FM=;
 b=CHAXswasZga9fAQXglLroBuWruADoMsGaq9mvu2ynRgl1L4vRGbo+6v3P8bY1HiS9q
 Ql+evlKVWAtBq9piS+RpD0uGGqCqCtJlla/QxdGzaKm7yaGX1bfUK1glxlWbXwlA1irQ
 FqwFAcs2JOjexWy3tcfXd7ZyGNjzgHswnQ2GM+9fz48B8ces3Tj8zH0NUFwgZoxlrbMR
 OoNulao+evDsQFykvtR8UOTjdCwjoirbL+cGlHNlhmOOuDB0gRINd4RGMhaesPtvl9xi
 LNeOSMM4+46VSl8FRYc9YwL/sQO+EkToLfokWJdGkprYPLYXT7g/CgikDBd9EvpyCQDv
 7RfA==
X-Gm-Message-State: AOJu0YzwIUJMObDnZ3EfFdYhnTAnDhgRqFs+geoFBB7unFq40e9gvINy
 rIeKqlzXExZRN2aGA1nISrToOE23QqBwSh9jYW7t2TtTQAfL0LGSUXJUQU+V3X3BXJRUunYRq5+
 i
X-Gm-Gg: ASbGncvSYpo+19m8fQwnG2HPXgqQS/Llejz5zlwuazarX9urKWbK+dK6Yb26G5P3AF3
 RMd8WKbUJt6p+CRwgvX1hk0jqHrqSXkWvIKV3bUPZWvguAab6JSf9rImAx4MKNdnIWgDR8qcsWN
 uS3f9JIf9SXCvL10tWOlahPuUg0IbG9AVyuDBy5HbeHDo3EpWPGDDC13f5SXJd/oR6V0/mc4gFc
 rgsaeWydg+YdzsTQNuZnZZEhE7OBujv2j52Sos0hA==
X-Google-Smtp-Source: AGHT+IHUJCQRvHpvi/mikayHMwGo52Fm/H7vFSpUetPjtPRPgIXetITdj3qBA84UibgqJdUFSDN5aQ==
X-Received: by 2002:a17:907:948d:b0:a9a:9df:5580 with SMTP id
 a640c23a62f3a-ab2ab6fd625mr2087479366b.19.1736805791712; 
 Mon, 13 Jan 2025 14:03:11 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f88277b354sm3988249eaf.38.2025.01.13.14.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 14:03:09 -0800 (PST)
Date: Mon, 13 Jan 2025 19:02:55 -0300
MIME-Version: 1.0
Message-Id: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
X-B4-Tracking: v=1; b=H4sIAI6NhWcC/x3MQQrCQAxA0auUrA10Yt14FRFJZjJtFk4lESmU3
 t3R5Vv8v0OomwZchx1cPxa2to50GiAv3GZFK91AI13GlM7IpTxkwry2ajNOVYiqFC1E0JuXa7X
 t/7vdu4VDUZxbXn6XJ8dbHY7jC4Ier2J4AAAA
X-Change-ID: 20250113-add_b4-config-4fb22fbded22
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=rbm@suse.com;
 h=from:subject:message-id; bh=DvN04ZC6tXuHRZXZ+gfshj6sjYoiv34OcGBQIo0YrYI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhY2ZbUoFngv+0jOYs0Cqe7nlCKlpPBkdd4AKc
 0nLW/fkyrSJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4WNmQAKCRDJC4p8Y4ZY
 ppuZD/0TbikG8tGCEm8E8GFzj2K5gtb1GhlMSruQmVaTY5BVOlwiY6dnqzPbDhodNQOl4AdC6FR
 DUX7V5h3RqbMYeXJ2v156BLq5ahpNxm589pvVk0L9LpnlCvbhlsiN+1Qze7Pe4ieRDMvy/m2U66
 1h+09R4ReCrByamNQnVCWbA6TuGWhtBktO6I/2ACFl3FhpFIe0dwIREeX7HqHBSRWfg9XtvKnei
 L2Zaaev7ZQ44TZFujUc3pnhoSgdZtHH5mGpQqF2WuFuZ7zn1iaK2mviSJsVMrhD0u4sCQD+Zxyi
 hmaNDklzBP5eP/pcCST8HY6GT3GTh1BF+zxPosQHQliq+CdwxSwKqt5X6RVIE5Yym8QN8eo7uhx
 r5ZDSjPE/gVa1bjkkcME5gEWVvr++zcsB6HMaaCV6if+kqCmMdNrnObxdnBT8ZsTeuV1PndvCqK
 7YbZ7sMB7j0zBB6wBtG/oAbayoHbVrZ+rFay+/0A2TIJcbmb/alc5ekgi/qTT/QiPNmCst4nJuK
 o2/0pyxHyOyO9KAxWsdpTvkQbwD6tcGDfolqToB+VW7XZxBhrBSDDXeU30zBxNYBFYGMMVioK9L
 fYr37KUVXII6T5O+WQ3Bv7Ywru9n+B8sByL4oBg4EDJTBrF5WhLnDydqPhq3jiNAdfXrMUT2Pr0
 TeohxUEJaLLMteQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add .b4-config file
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This file configures the `b4` tool which some contributors might use.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 .b4-config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..2efdf2273240dcf57bd5cab174ff6c7a1952dd5b
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,6 @@
+# Configuration for the `b4` tool
+# See https://b4.docs.kernel.org/en/latest/config.html
+[b4]
+    send-series-to = Linux Test Project <ltp@lists.linux.it>
+    pw-url = https://patchwork.ozlabs.org/
+    pw-project = ltp

---
base-commit: 7aea2cea9ad5d9e1586112a57948c7f85dc12970
change-id: 20250113-add_b4-config-4fb22fbded22

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
