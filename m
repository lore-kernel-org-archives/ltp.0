Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A25C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754514504; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=brgLZggEaO2HckJWqvwy1KqXIbSoM+O4JUQErd7/yz8=;
 b=TX+1tDvzWh4R5JomL46A3CwloDfeKKIbKBxliGYUFWNUulGNQ/eziIWys9zHRIyxm9SKG
 q1JqaZGTbnNgOj3+DW+fIwyZPj8zXP1HNuBzGeFxBe8hKXNG9stwjzt2uiWdzwavi217WEU
 Vj/aHP3xZDaoyQW/8nFegqvj+yztWS8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D811C3C840D
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 23:08:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418023C840D
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:08:04 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD1331A00366
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 23:08:03 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so162023f8f.1
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754514483; x=1755119283; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G4Zo/0qRC6FsmBJiuVvHfWygQ91mBfQXkfvCDkgABHI=;
 b=ZhL+WpxE1YWCF9ZezZ1DUas8jE6nS9Dhg3Ev+OnIqp/o/MtnX9ox33reLcrVsKqlde
 BlJ/OBiaqvEEdyDziz7TQUBVxgC6xP+0wFPeDhUufLmCxHvYfG7EyAGXq1Rk4XXLrFOp
 K7HJLeFU4HYPf6PcWUJoataGP8UUVYqCP+vpX0rbKBohiToge2YWf3w0LFv0RaY8811D
 mBTS0Nc3PXUXXa7j5cbkigyN6YjbeoQ7Yfk29iZaKnYzJ4ZvtpU+hETalsRcYQBYsxjU
 YzUvu3liDRWurdcXwYs5/2PDrDfNAqL8t7WQsDPxv3nbgL6QOgfXBgO8OH5AL+EVyRmf
 e/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754514483; x=1755119283;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4Zo/0qRC6FsmBJiuVvHfWygQ91mBfQXkfvCDkgABHI=;
 b=GDDdhaJ58Yct+g/IUnKebRdrmQfogDeF/LopDHvrR2m9SqrHqXavteWZriU6RJkcBi
 GEreIeNr7G1zhbGclRBRUWsxpjpSD36weJLrwZ+YsdOxqAutQNSxA1/BWOiEqcmwThF+
 mAq79L2ccuNfawKktzz/r2by/5e/TgBG21U47gAAkHyyzHUqNctFw2x8ir2f11xO2MQ1
 UNjflgQDEK+S2uSZHvNceYbPiUJYRGgdbB8+0IktDlLQhBcD5PWff9iItMb1VouKYSVq
 mblpALysHCb1kDPqMjykMjTxSiRssoeqef/hzu0+9UyivXzzhN0+8Cn/O7YtcpTl6iQW
 7w2Q==
X-Gm-Message-State: AOJu0Yw8Hksk6zaqcvh5r/qJw+TNaaEZBAqJTZIMoMhGosQe6Mk2752X
 bODcLeJ9+NQWaGzi7sPqWh9WIgiomk8mtPeVoj2vy+IYqXGysjeTz/N775HUfgzutDMncy7mTFh
 e73fwqhc=
X-Gm-Gg: ASbGncstqhX8ngOgGNZCXANoWZ1VflMlSy3PAujeN/UzbYtOlUX2BFcc7s2OS7+ZiX2
 HfhRGNP/YZoAcQI+Lt+ycrZIS3Atx0P3Lbci1bKBdnxl3IEV9FuBzFeKO2977qaRAO2BCpGLyPx
 TENeiyWkHJ9HT6KaHdk4PgRyQio4ZMA2nxijt8oEuFQVEH+JatW4YvLAVJUSkz5wThoCqEEdtOK
 OCQoUR6HfxO5x5QMGnr2kSMj5B4RWSmAg69ZVdeMx4Zi8LDPnnv/mxJcgpoNOIBmNv09ggFkGl0
 aviu+oOIFJBkfhHT1usmaObOYrrkJNYEZ6Ot+STQzUYi1iGd1uiVcotp0r4mrJBGWFkvVjbeylJ
 mh6parbqPEg==
X-Google-Smtp-Source: AGHT+IEjmJ9JRNNEaVrxWcdpzVXb5coWorbFSdp1bdlm+6HivunvrlMF/bc2YsGVr+3jB3Mu1Bcxiw==
X-Received: by 2002:a05:6000:2c0a:b0:3b7:9b81:73f6 with SMTP id
 ffacd0b85a97d-3b8f420f046mr3974169f8f.54.1754514482881; 
 Wed, 06 Aug 2025 14:08:02 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4fc0d42b8c6sm3838264137.13.2025.08.06.14.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:08:02 -0700 (PDT)
Date: Wed, 06 Aug 2025 18:07:45 -0300
Message-Id: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACHEk2gC/32NQQ7CIBBFr9KwFgM0TRtX3sN0McBUSCwYpqKm4
 e5CD+DyJe+/vzPC5JHYpdtZwuzJx1BBnTpmHIQ7cm8rMyXUIEahuIkhY2oa8Ydx8R34ZLUZpn6
 RQk+sDp8JF/85ore5sgZCrhME41pqBdowNdF52mL6HudZNv3vT5ZccDAjWN3DMkh7pRfh2cSVz
 aWUH9u25OfMAAAA
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=rbm@suse.com;
 h=from:subject:message-id; bh=Z6iikE6lDEl/lv+gVFldjX9PBfO4yzeUbpk+hU61tDw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBok8Qu/bwDa2a/xbj3Mq2qgKdTvyUNuXm4hWaB8
 3Bsu3drN/KJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaJPELgAKCRDJC4p8Y4ZY
 pt/DD/9dzH+J+DrKwySRzb3qPxohvGx2cER1cC/jpk8LwHKY84Y9EpIQqVCc/z5BhXskfz0sYEx
 NVgFEtEnUEbsYDZiWZ95YGLbwFI/jVloWBfiloR2HEQ8oQzL6GHFm15fM/DlVxLGQzalsyeR49C
 ngB2BiHr0Qf7bAPbpUF7SiNElQIWQtiZx0FloR8r9oOM0zY2iGRwGdda5FzUekje4tDBEyKngnG
 +LwLBIlOQD+khAfmuVUy/8bakeb4X3AIcddQIRRZv5FbmFxX93LMnBvQ2rETFudTE4q7r/fMqGT
 3qqg2nXd0XTdQUWalVgBfu7NT3cL3XzxLiPeFLZn8KObLe2ipMSywZ4U69e9e5wmv3LR54pbsmR
 7Gtuou6tqTd6Me6RhVkH0A9JIk01GfB35SYGlkusZ2HxXyugOMHfeZe6EyLpV/nVY6hFEroolIO
 X2FoL1f14ZIwCUyvaUJzBZ6spE8xXpWAobTAGkzmKRtLZkh+nX7duD6p28IBwn4QV5D7jjDrcQ0
 QKav/AMBqNZLr4hj9HuHUS2xp+3DbEzh2N6lFJgBNm139+ULd86E2yhsmpZA99j0joDD3GqjEmb
 TxwiCqLaa4aV4d/hFlQJCjLlIfQO4drPZGlMC95O0tI2YAAVeb/r6/SjSczMLtapDkoFl//2DF9
 bc48fb+/pgemESQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] syscalls: lchown: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjI6Ci0gSm9pbiB0ZXN0X2Nhc2VfdCBzdHJ1Y3RzIGFuZCBhcnJheXMgZGVmaW5p
dGlvbnMKLSBTaW1wbGlmeSBvdmVyYWxsIGJ5IHJlbW92aW5nIHVubmVlZGVkIGNvbW1lbnRzCi0g
VXNlIG9jdGFsIHBlcm1pc3Npb24gbW9kZXMKLSBVc2UgU0FGRV9UT1VDSCB3aGVuIHBvc3NpYmxl
Ci0gbGNob3duMDE6IFJlbW92ZWQgdW5uZWVkZWQgdXNlIG9mIGdldGV1aWQoKSBhbmQgZ2V0ZWdp
ZCgpCi0gbGNob3duMDI6IE1lcmdlZCBhbGwgc2V0dXAgaW50byBhIHNpbmdsZSBmdW5jdGlvbgot
IGxjaG93bjAzOiBBZGRlZCB0ZXN0IGRlc2NyaXB0aW9ucyBhbmQgdXNlZCBzbnByaW50ZigpIGlu
c3RlYWQgb2Ygc3RyY3B5KCkKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUwNzAyLWNvbnZlcnNpb25zLWxjaG93bi12MS0wLWFjN2FkYjNhZjUxZEBzdXNlLmNvbQoK
LS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICg0KToKICAgICAgbGliOiBBZGQgU0FGRV9MQ0hPV04K
ICAgICAgc3lzY2FsbHM6IGxjaG93bjAxOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2Fs
bHM6IGxjaG93bjAyOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IGxjaG93bjAz
OiBDb252ZXJ0IHRvIG5ldyBBUEkKCiBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggICAgICAgICAg
ICAgICAgICAgIHwgICAzICsKIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAgICAgICAgICAg
ICAgICAgfCAgIDMgKwogbGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAxOSArKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vTWFrZWZpbGUgICB8
ICAgNSAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9sY2hvd24wMS5jIHwgMTkx
ICsrKystLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93
bjAyLmMgfCAzMjggKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9sY2hvd24vbGNob3duMDMuYyB8IDE3MCArKysrLS0tLS0tLS0tLQogNyBmaWxl
cyBjaGFuZ2VkLCAxNzAgaW5zZXJ0aW9ucygrKSwgNTQ5IGRlbGV0aW9ucygtKQotLS0KYmFzZS1j
b21taXQ6IGU1OWM2MGZmNDRiZmM1MGEzNjA4MzhjYzI4MTllNjkzZjM3NDFkNzUKY2hhbmdlLWlk
OiAyMDI1MDcwMi1jb252ZXJzaW9ucy1sY2hvd24tOGRiYzU4M2YxMGI4CgpCZXN0IHJlZ2FyZHMs
Ci0tIApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
