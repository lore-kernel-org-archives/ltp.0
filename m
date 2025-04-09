Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5B7C36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744216652; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=/lxLbXmOtFJ1mjHn+V+XF9XWx2Lc7gfjamdDwR5Wv84=;
 b=kop8uXoH8krfe5Tr9MWi+GJs71jD2HzS1HA70wGRDMUlMElwTgc4lsg167aQ8yc9cUOaa
 CJCUzYvRAYwwSNk8hl/0A60Dm/bo7M8yqpAyxHwPxzbrIsg/DKF3g2Y6uTgtSLV1lkjtnAE
 /Ebvuo9i3LNG5wYm/2PBEk0GGquPnG0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9C23CB41C
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 18:37:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA713CB400
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:10 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAE06201110
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 18:37:09 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso4405997f8f.1
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744216629; x=1744821429; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DnZcA8ENBrPdnzPbPPFDYnmCDquF/D8mt6D72ZKb9Rs=;
 b=NQziXT58ZJf011VTsNxD9wrv7M+c9lIUR0P/HVediEd7LlVmmdnjQeytVcT41k2xs+
 +2D9xTrqRZwy04bUelUXFc0vN2gKDp834jI/aMtuhwxVGOemPx2sX4M/b6jEiPvFODy4
 YmVAvO6DUYR4NBffgUJwb89ym61ULZ1cXF3z8bRkIMGySZwoUvQS5r0I7cAEgCO8y+rF
 OKvlqiCDJXgGvkAaVFkXxEIQ764y26TdLE8RIwm0rIoGYz8M9TDVvTwwvYPOSR47xnL/
 zYZQZDVL9i5t3rY0kOdcks9xaSl9rzjLbbFpuF6YboIb0+LoU1+IgGYmf2xulEQYKnGQ
 F9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744216629; x=1744821429;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnZcA8ENBrPdnzPbPPFDYnmCDquF/D8mt6D72ZKb9Rs=;
 b=hNi9PPgN0PFag4wVwGlEO0ZSKwHVARzkgMlS5MYXqfbBfA41aCPG3NXFyH4syzbNPC
 QghTEonvDn/BGxZvUZ4z+tX+LlnH8GhRS4fN6SDZLssfkb6NLjJ6TLo2ryb2Ak6R5mua
 zLY+lf3gaqiG/XEdIeVp7kv10Lj/n1evWyYZxi82gxQZoO2je4vaSOCxbEkHY7h3EQHj
 Bfnn25ZNhzHPdR3dRV27wlo1WSPy104/tEpIWmyGHiuNWuPZirGDAxdJG54sOtncilx+
 qNjdZHEBw3qqvcKnEgtNSAw4PY1eiCOh+GpV9P3tv41+viyGaUkoZj3fqSnLKJaCAP45
 Bo7A==
X-Gm-Message-State: AOJu0YyxDm+7z64b93tm8YfthfzDirLtGyJya74/kTK4GROfiQyIyeyl
 /5mrqmoL+7i/nJXx+xROzCD7QM2bKcgM5ujxj5PDtKBOC10uVg/jTHvZijMOZSw=
X-Gm-Gg: ASbGnctA14DzjgV8WyfaWhfKlCBm+Ft0ucq5cDmGsfnomBYU8s8LxK48Ke6zppAQTUe
 O+kx4/nSKD07yHfOe5ke5oceuDfzkqkls/G5PspobTN5+avxTwGB0uRncVQKRnjH+9iQ+jYApHM
 sOdQ+TCrH/PFZuiw2ywTUwbXNgxFKFrGgxVIL1RQ+nQ/qOWd04viacX8k16sUTOs8WMtpEW3QX+
 U909sXjKmyGR829w5bfk8qMzX6INVt06N/7RVegVxunTc7qCh7cBIV4eEh7HznMlN+zbi3+FFH1
 4mFDStOJvoIp6sG62MrGNZODi8kXIg==
X-Google-Smtp-Source: AGHT+IE3pdLOlALjSQT6E5RVWdKXrHlt4MRC24fG2V2tY98Bhezh/KXyEpbGQ1ba39iG5eywBKf5KQ==
X-Received: by 2002:a05:6000:40da:b0:39a:c9ae:9efe with SMTP id
 ffacd0b85a97d-39d87ab721bmr3058994f8f.18.1744216629280; 
 Wed, 09 Apr 2025 09:37:09 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73bb1e4f346sm1596154b3a.131.2025.04.09.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 09:37:08 -0700 (PDT)
Date: Wed, 09 Apr 2025 13:36:54 -0300
Message-Id: <20250409-fix_make_clean-v3-0-a33a84b2be05@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACai9mcC/3WOXQuCMBSG/4rsusWcmrOr/oeEzO0sRzlrUynE/
 97RgoLo6nzA87zvRAJ4C4Hso4k0NvSdf6z7GOMoCWc8YwnPqbH3qpVnqNQFpKNjTBkVdQGaS6G
 LnTyEIcBWdS05biIy8g+dMvFDc6RTYYpEJVqz2nzRM+JXDx5ugw22X6uVi1M10p2AWo2Pv70EZ
 LkxECvgiiDkYURL55BJ8KxlAFp76VSzWFoZevDklYimd9g8PwHgyUz+FwEAAA==
X-Change-ID: 20250327-fix_make_clean-8e57ffe1ce2c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=rbm@suse.com;
 h=from:subject:message-id; bh=1BCLp6aj1FZ92xF+4E1AqtsY3ib4uoAsyIay1q24Yzo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9qIxrKo/Rynwu0iNHRUIrXUpfdAyKv52JW2j4
 Lm5dZlq2qaJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/aiMQAKCRDJC4p8Y4ZY
 pnxrD/4jZOqoGIJUoVL0LJn3tr12jOW+68Df/Y2aHIuqjzlLreqrMmDNa/2V3JcqyaHXtBlX9P4
 NNCOdc1keToVvsD6gQOOWn2F8WypjqvYzX+L1D3xhqk7s2rcTGhiw1zgzZI7XVsdR/VN06GBgbN
 jyx6tH6sALYX8xQ6Jt1Pc+nuWHeK0A2YoEW23R2VME6FKqmgsIkLA33lFvDvq+6Ko0jgQ+w6uYo
 7EsDiov0gMrUQ21Zfa6afkzu+1FIQsyO4RQJuXrUL8MVmAso49TcwKrbIjQShL5ZEnHlnk+XarS
 7iON7txS5lGbdkLgkoYVOu39VhjjqYRNttMvnbdyS52z+XcpnTTuX3jfoElUKavizPw5lvH9spv
 mTr+du23vO1EXNE7cyLzNQHKEfZXOgH6h/+Dd7AK4hrz39l+TLWIUE3UPY55Ak5WkqXecXF7Odz
 oTxtsfveVAF+2ng5TVoyejyriHmrQ3QLoJasuVy2fziy3giIYydjVicrNISHjpSqgXBOhhTDxyF
 r5mPNRGbZ2U1iLBvIzzaK7MTMd86oSpseVbgLy9jxjsxwBt0KLV6y/QGAwE1yC2aYI3M9RP6kAJ
 vJsYIAfur/pMaDbJjtiokcO8JG1Rg769X4WullzLFX8K74ehMLE1g15Ezg09CLOR+3NeBTCXvt0
 lPbTDplqoy+SMyQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] configure: Tidy up removal of generated
 artifacts
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
YW5nZXMgaW4gdjM6Ci0gQWRkZWQgImluY2x1ZGUiIGRpciB0byBleGlzdGluZyBmb3IgbG9vcCBp
bnN0ZWFkIG9mIGFkZGluZyBhIG5ldyAkKE1BS0UpCiAgZGlyZWN0aXZlLgotIEFkZGVkIGl0IGFs
c28gdG8gYG1ha2UgZGlzdGNsZWFuYCB0YXJnZXQuCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI1MDQwOC1maXhfbWFrZV9jbGVhbi12Mi0wLTQ4ZjkzYzNkZDBiZkBz
dXNlLmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBEcm9wcGVkIHRoZSBjb21taXQgdGhhdCBhZGRlZCBm
aWxlcyB0byBhYy1tYWludGFpbmVyLWNsZWFuIHRhcmdldAoJKFRoZXkncmUgYWxyZWFkeSBpbiBB
VVRPTUFLRV9GSUxFUywgdGhhbmtzIFAuIFZvcmVsISkKLSBBZGRlZCAiY29tcGlsZSIgZmlsZSB0
byB0aGUgQVVUT01BS0VfRklMRVMgbGlzdAotIEFkZGVkIG1pc3NpbmcgY2FsbCB0byBpbmNsdWRl
L01ha2VmaWxlIHRvIGFjLW1haW50YWluZXItY2xlYW4gdGFyZ2V0Ci0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDMyNy1maXhfbWFrZV9jbGVhbi12MS0wLThiOWVk
MmE4ZDk2YUBzdXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgyKToKICAgICAgb3Bl
bnBvc2l4OiBNYWtlZmlsZTogQWRkIHRoZSBzdGFuZGFyZCAibWFpbnRhaW5lci1jbGVhbiIgdGFy
Z2V0CiAgICAgIGluY2x1ZGUvTWFrZWZpbGU6IEZpeCBjbGVhbmluZyB0YXJnZXRzCgogaW5jbHVk
ZS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystLQogaW5jbHVkZS9tay9h
dXRvbWFrZS5tayAgICAgICAgICAgICAgICAgIHwgMTAgKysrKy0tLS0tLQogdGVzdGNhc2VzL29w
ZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlIHwgMTAgKysrKysrKysrLQogMyBmaWxlcyBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6IDgw
MDBjOTUwZDZiYTYxYTU0MWE5Mjc4Y2RkYTZkNjgxNDFjMmZjMGQKY2hhbmdlLWlkOiAyMDI1MDMy
Ny1maXhfbWFrZV9jbGVhbi04ZTU3ZmZlMWNlMmMKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8g
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
