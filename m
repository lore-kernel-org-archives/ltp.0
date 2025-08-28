Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527CBCA0EED
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 10:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756376655; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=3G9LZtq7u0+HLonJYwH8Bd3kCZ9cnn7EjZjG+63kpA4=;
 b=bxLySVO+SfLWco1ZjaoEEn8dh9lWnaAIBz+6DtW11vE5v2xdqHfdLHetQpVkAgjRYIrCq
 3hiDxETnAHIi/xwON9a1v42kCAXwiumQkQ/PkBG4+ywtJX1VoscP1jIf+B7BROia/dkFwPv
 pV72lUz1FLwt7M8kWlZMQd+IFFIs15A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7151B3C8330
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 12:24:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E1463C246E
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:23:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81CD260055B
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:23:53 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e238so368425f8f.1
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756376633; x=1756981433; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oBj0R0xmtq/oJ+hySCm0VdpzXLrJPjXRNL1c/gqaWew=;
 b=AcssBJj7rRmlWXCzEPVOS4u6Xo+6REwtBq5wmQAeyqWNtEmxdrcAP6iEMnOXHDJcYg
 nbyWt59Z7h46hfIvNiksdg+wV2wcUdLb59zn9yKyEYcGSxMKTkkuB76UAyAiRwrPvn/F
 c7l+UZmkGMvoiGtK810U7a2/DackKLs2IKGQPyd0AvP8RMUM8NHE8bbNeD7dj8ng4Sxj
 4VN993EuLCUPhbv5xQFh6G1/MHwAA0fDELZd8XLuBUB9UnF7cnIb2jpZcN3MLV9RXxRF
 BRbZk3KfVPxaPp7dWKmH3qlCtewgI/QAGU50zeU8HZOgKwpP0Iz5NKes5KdBXLmdj6WG
 XWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756376633; x=1756981433;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBj0R0xmtq/oJ+hySCm0VdpzXLrJPjXRNL1c/gqaWew=;
 b=Kkyla7tEWWy5TCDykCm9niBZu5qLe2OjlOYbUpJZspQ0xTsczeOxfHefaji12jxg2Z
 clAQ4/y3APqqwW81vRu8NzdiUVzrV1haRQiISM7wnEGEZzNtL8K821xBOIclnKll9glN
 dqwxvzAmHI2f3BlHBQLOiaRmdoxc2jHX7bsAsPcXMHLKZV7V2NAx91115f3wGawntqHD
 c8p0hD4USfvxJwyqszLWAHY2BApn5mRRVVx7yqyHtC1SyKa/AKPuD6pHF4J3842t6Vkl
 5aaJ47kaP9w+Rp4SGAqS3V14SkQcygWLCOCrBjAT73E/f0KJq01fGAtGnFx/JM1ghs0z
 SnmQ==
X-Gm-Message-State: AOJu0Yy7tMJsh0nBW9GEIyrOVtU6Z5rpHtCZ9+j+pUeMNkIeeDliv+Oh
 JGjNQB0IFntTw1pL2/drFFy8Kvb0IvSZHDhrhXGdmCXGtqlr9Y/QSOj9oa5ptBkSx1udDgdH5Xe
 9gR0b2Aw=
X-Gm-Gg: ASbGnctQ6ZHE2ZRc9XEl3AFEEjk7EhjDj5/8fij9mKIbb/CWeHfT9JPka9yHiekScQM
 eV349ceYvnS0v7RpiacFdXbw7+8Ndgw5Ww8gsoTOpNoJaV64USCWSoL/wnJ9tnPHxoJhAqXl5H7
 w8qFIA1bEBcxmeXiuzFb+fO9QcVkhu5O+M0fW07XXxzwA68VmlnbLcGwxBUi2+/rThJAKO516kx
 npvCCMij3mUWC1+y/2RaHYZpmkHt7IB6jnTzrswERBI2PBE7L8eyjaQSbkWcKirTn/FrjrfnKKt
 r5DGwzkSuSisdatgiJeUGcmN0Ohk6ulT6LTaJPS3OfDIssyxKOSsM29Pf1NBmQZRqMAXyjT5seU
 9S/5/c9Smv+IfbeHL6Eak
X-Google-Smtp-Source: AGHT+IF2w+h0hCJ6pQOk6bFj0O7zTzycx0xLHpWb7f/FVo74+x9C79nvHLUD6MssBeI2CKXjfT0rFg==
X-Received: by 2002:a05:6000:290d:b0:3cb:e6cc:3d84 with SMTP id
 ffacd0b85a97d-3cbe6cc6949mr6711934f8f.63.1756376632529; 
 Thu, 28 Aug 2025 03:23:52 -0700 (PDT)
Received: from localhost ([177.94.120.255])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-5442d8c7dc4sm2103740e0c.7.2025.08.28.03.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 03:23:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:23:43 -0300
Message-Id: <20250828-conversions-lchown-v4-0-60dd9a0145f3@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC8usGgC/33NwU5DIRAF0F9pWEsDQ3l9uvI/jIsBhj6SFgxTU
 dO8fxe6aWMalze599yLYKqJWLxsLqJSS5xK7mH3tBF+wXwgmULPAhRYtVcgfcmN6qixPPqlfGU
 5B+ftbKJWbhZ9+FEppu8r+vbes0Mm6SpmvwzqhHymOopL4nOpP9fzpkf935+mpZLo9xicwWh1e
 OVPpq0vJzFuGtyEWU0PBeiC2Vn7rCJFRPojmDsB7EPBdAECTNqZQGCmO2Fd11+8M49vUAEAAA=
 =
X-Change-ID: 20250702-conversions-lchown-8dbc583f10b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=rbm@suse.com;
 h=from:subject:message-id; bh=aWQnTZn5A3fRsEHTAj6HRLdil+wilYqnvleTb+aT/ZI=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosC4y+8jR2Y7upntidT8MILFfwfvW/1aOft26t
 Yks6KxyDi6JAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLAuMhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKblrA//Uf+QI9gBKrdF2ez0Q35zjRwECCEqaoc
 CU7Zw/9WDqP7aVDHtS+JUVrYyLd6iMGB07R5T3qfYMT93yUNtF+gF1IA6B6kETTyjCijR3VAtyI
 jwsGCmZglmvAWaZ1PgOf5Lyp/CLCKzIyzGr8PcAhnnGbdVnuAJKqZMAgzW5aVhCHrkFhFbXatOe
 JAWIrb7YkHFHlLtauvk6GJyPf3QQWYjLoDADCusQP5vYHD9vgnmwepc0sfEhhGg/r3Oi1yoNMpU
 K2QatUCuVrp272ZbhMz8RlnUgGl5GwVL7OSDzJrsLAjs0VQtnyhx0Oa3ssVn+0q/tIZMTldq1da
 QaiowqycSC7D9UQc/fb0Fer9FGgCbiLY2SxqJOgDy560pMMAkbJctvg/LTsB8yRA8Y6hjYUhuLW
 Gg9YmLS7Tn53k/n2Qi+j6Pkx2XY2eTjSc4BC8xdi7VOyGtOO9YOUUTVTTkULov7h91KnUOdC+l7
 4qYuu/IGblRLxAB2BeFkfas51BpOJJNAst9X0lesvh+GK0PzRhCy4bPqlEnV5GD+/2znRpcUG8a
 BtrHXbj8E1O0t8wluwYBzJiuujlyStsw6K3kaujbn8quAWcRkfEEdXyOf8hvfRnlhceMhYK1p+B
 nDfFei5dDIi6ttOsB59evHP5/++sS2//vo0Zy1nRqik88BxUhpd8=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] syscalls: lchown: Convert to new API
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
YW5nZXMgaW4gdjQ6Ci0gTWVyZ2VkIGxjaG93bjAzIGludG8gbGNob3duMDIKLSBMaW5rIHRvIHYz
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwODI1LWNvbnZlcnNpb25zLWxjaG93bi12
My0wLTJkMjYxYjNkZTIzNkBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MzoKLSBQcm9wZXJseSB1c2Vk
IGJ1ZmZlciBndWFyZHMKLSBSZWJhc2VkCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDgwNi1jb252ZXJzaW9ucy1sY2hvd24tdjItMC0zNDU1OTBmZWZhYWVAc3Vz
ZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gSm9pbiB0ZXN0X2Nhc2VfdCBzdHJ1Y3RzIGFuZCBhcnJh
eXMgZGVmaW5pdGlvbnMKLSBTaW1wbGlmeSBvdmVyYWxsIGJ5IHJlbW92aW5nIHVubmVlZGVkIGNv
bW1lbnRzCi0gVXNlIG9jdGFsIHBlcm1pc3Npb24gbW9kZXMKLSBVc2UgU0FGRV9UT1VDSCB3aGVu
IHBvc3NpYmxlCi0gbGNob3duMDE6IFJlbW92ZWQgdW5uZWVkZWQgdXNlIG9mIGdldGV1aWQoKSBh
bmQgZ2V0ZWdpZCgpCi0gbGNob3duMDI6IE1lcmdlZCBhbGwgc2V0dXAgaW50byBhIHNpbmdsZSBm
dW5jdGlvbgotIGxjaG93bjAzOiBBZGRlZCB0ZXN0IGRlc2NyaXB0aW9ucyBhbmQgdXNlZCBzbnBy
aW50ZigpIGluc3RlYWQgb2Ygc3RyY3B5KCkKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjUwNzAyLWNvbnZlcnNpb25zLWxjaG93bi12MS0wLWFjN2FkYjNhZjUxZEBz
dXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICg0KToKICAgICAgbGliOiBBZGQgU0FG
RV9MQ0hPV04KICAgICAgc3lzY2FsbHM6IGxjaG93bjAxOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAg
ICAgc3lzY2FsbHM6IGxjaG93bjAyOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6
IGxjaG93bjAzOiBNZXJnZSBpbnRvIGxjaG93bjAyCgogaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5o
ICAgICAgICAgICAgICAgICAgICB8ICAgMyArCiBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oICAg
ICAgICAgICAgICAgICAgIHwgICAzICsKIGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMTkgKysKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sY2hvd24vLmdpdGln
bm9yZSB8ICAgMiAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9NYWtlZmlsZSAg
IHwgICA1IC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAxLmMgfCAx
OTEgKysrLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xjaG93bi9sY2hv
d24wMi5jIHwgMzU4ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbGNob3duL2xjaG93bjAzLmMgfCAxNTMgLS0tLS0tLS0tLS0tCiA5IGZpbGVz
IGNoYW5nZWQsIDE1NyBpbnNlcnRpb25zKCspLCA1NzkgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNv
bW1pdDogYmU5N2QyNzQ0ZTdmZDhiMTNmYTlmNzljMDJhMjkxZmRhMzQyYzQ5YgpjaGFuZ2UtaWQ6
IDIwMjUwNzAyLWNvbnZlcnNpb25zLWxjaG93bi04ZGJjNTgzZjEwYjgKCkJlc3QgcmVnYXJkcywK
LS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
