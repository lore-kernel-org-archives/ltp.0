Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C269AC36014
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 09:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743587983; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=PO3qDtplz7CIfsINheJ4C8NXacth1B5y1JJeT0yVDXo=;
 b=LpxIWL4N4EcZn1gZUUdZiYKRL3k7OegrdRWWGDwaJ1RnF3rPNZYoUk/oKQto9giRVWzIv
 aozzx7lMVsPzboGSj5DR5MGkfvhDxR1GyOqC32LZaY8/Dlo/uymuK4T3HUUPxOTI3mGibqg
 bJuCN+AkHXRpouG2NjhDb0wrCDvq9BA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93DF13CB0B0
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 11:59:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6C653CA464
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 11:59:21 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C89BF20006D
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 11:59:20 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so45150125e9.1
 for <ltp@lists.linux.it>; Wed, 02 Apr 2025 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743587960; x=1744192760; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KJg46E6OGt+rUgqbOD9/tkfPohuHU+8ZQ/hTK5VcXNI=;
 b=W+o9TsVFI/1IAlk4WXjz+NVDlG/QUfAxAvfbb+Yx5blWSe4rl1xLE6EhO5B3K4fz2n
 2LRtaZV2xW7slh1N1oy/SCzUD6eI/bhGPnaSR+C1/jo1UL2Adm7eFyBw8kUoWrBU/pxH
 eI/H0G1ouQUyenwaukTHDrM4Zz+aX+6y2RVt6uVAuwcHqsbpWZ3SI16WQ7zP0fzVDtxs
 MZ3FnWAI1VNuaZae7Jsi6DOQrx6CM20NVKJMm3AVlB+3lGaw+CZnvXtKd86zsNKHRwTh
 1icI7WHXszRtKY3q94PPRBKWhUa5BPBCaamsLLOiAfygQMxTraLAeqfpnyAtgYa/Ozih
 gmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743587960; x=1744192760;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJg46E6OGt+rUgqbOD9/tkfPohuHU+8ZQ/hTK5VcXNI=;
 b=Hy9RW0Qd4ZHOj9M5ZzxEkWMZr5bCaCJpl3D22yoWv4lDRmbWZFD+MTtmaK1a2rte6Y
 899IAS6rY0T79XB68NuTaEnRsGdWYWXWBS3w+/JC6/AqKZFbc/XtRw1SsyLL8UmPT/wr
 NuByaSIb5FLJAUkPLXHPx21beuLBFdFWlZY/uXUIQVEkA0b+yD9zGzMc/ONqgwRBulFx
 wDX15vGNP7XzK+CJF8KgANc/7iexYogJFYmgDvkSqJOOCbK6esimaHSOFOQMZAcwLWYp
 iiOk3Xe+5tCTB5DNrJNS/QZ3dWOui4l6lPkht5aUKEJN7QcIy4pUNFZHkxtYBUhKm+2k
 o0Ng==
X-Gm-Message-State: AOJu0YysrCkWiiIGqa2nszfXJ0xxDY67USkRL7DAc7OXDoealHtftlUF
 gEoyudMKSAAvTjPClWYRPBCHZcbp0BqCcDDUnXqHbaZngd7TnO+8td/1eszD/CLoxYcoexe76gX
 y
X-Gm-Gg: ASbGncsxqit92mLDMuVpUC1F+u5du4QDrtIj22rrNEt+XEzyDTlgmL7Cw6ap28G3sqp
 Dgit+s0UitFzYhXdIhaLePI7Q2cibOt5nVdBjrDN3RkDiEvF0V67UQ9mBFZuW2wx7AGSd5hFaUA
 H66RawrUwe6yfY3HVrBaoL1/HWNMNgyuCTTeF/BgGSg/wHSRqxANrZyzWEaruQ9erASsUu/+4pB
 ke+02KUWPGqoAjDJjQ1EijeQCmf1NJ0Hai8YAi85TwFVK2/TSiwgDS2hUyP5RUVqPryYe25HSyj
 fvHgd4yP526AhxfJuvbwYYl3nlMRaPMeCw==
X-Google-Smtp-Source: AGHT+IEFHhCOurUXX8OHws6+NAVm4JBEF/9SfxeVZUZ9TeI6byEu/VicXvfjOxs+eWzzr95J5gF/0Q==
X-Received: by 2002:a05:6000:400d:b0:39c:dfa:e1bb with SMTP id
 ffacd0b85a97d-39c2366a843mr5484408f8f.42.1743587959969; 
 Wed, 02 Apr 2025 02:59:19 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73971063d19sm10861942b3a.90.2025.04.02.02.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 02:59:19 -0700 (PDT)
Date: Wed, 02 Apr 2025 06:58:25 -0300
Message-Id: <20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEEK7WcC/43PzWrEIBQF4FcZXNfif3RWfY9SitFrIzSxaCodh
 rx7dVYhENrlgeN3j3dUIEco6Hq5oww1lpiWFtTTBbnJLh+Ao28ZMcIk4Uxgl5YKudcKnpOP4fb
 +6VesqeLMMMaDAtQef2UI8ecBv761PNoCeMx2cVPnZltWyL04xbKmfHsMqLTX/7xVKSZYe+U1C
 5QMSr+U7wLPLs2on6psrwynCmsKM2TwwrfVjhwUvlf0qcKbEtSoAKgzVIiDIv6niKZYCTCMuv3
 K2oMidwqnp4rsW7wCS4WhRqqdsm3bL4QUytzsAQAA
X-Change-ID: 20250324-conversions-modify_ldt-816329223f6e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=rbm@suse.com;
 h=from:subject:message-id; bh=7TAXbJNFSM6c96JaZ///YZFun2qHpCq/pfOtXrzBLrg=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn7QpzMaFBEvBikjTN2SKdE5LaiSn3MvdXxiZSM
 dqmjVqi8VOJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ+0KcwAKCRDJC4p8Y4ZY
 po/wD/4tG85l8jRcqn4e53VvlinLgm+h0lXp5oqs6oDlgm+yeWuWSVcMEVBETS3LAJJzy8K8cUi
 sXsBh/xMaf1P/tcCGE0LrKJxdqCTybAw/4RNSCkEY2Tp3aEW4WIm3MM7SOWvbqjVyVorj3apg87
 XgwPTT5e6UJnAIYJ1eNCmwsNQvEZPboAezvr3h3y8HFtiwDR2yGwp95UuxZcubU4IjAxMa69XKX
 ioo+YakUWfMfGcIzPTeTzu3WVaJcFcjraBnopTs/caUOs+P3SRu4O98oYNivcdMgztaSJiftSH3
 ThmKOsKuEl6abrOiHN5C95kFsAA8Xo4fYX1KOY7jd5+MLEXIopUIfJNg40qABrY/vcjhUQg8vSV
 VAe77IAGq5bPvvNjAzceUpRlov4DKPWXgbj1aKj9tYn0hx8lodxPz/LvpBCNgUVIkSE1AL7/9WI
 Hli2SzbhZy4i5gCBA0p7ZS09xEexNlo0mEGsBGlJj7/XMKXdrpmf8UG24LVLsEfO2ilr7FNdSiY
 btu3V6rCCRoFwWc96gGjBkVyhsNXLHdulazZeRERheys71hZhGISPt3VcOoSPBT2MB4I0XaHLHe
 0V6nI6wEy/oBFtF4btcrQvzQtEgOez02D/IzcStI1lFntyeFIXthAx/mhuzJmxIF/8yURqcaqC+
 4utFshBIM4yjHHw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] syscalls/modify_ldt: Refactor into new API
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
YW5nZXMgaW4gdjY6Ci0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBpbmNsdWRlcwotIE1hZGUgbW9kaWZ5
X2xkdCB3cmFwcGVycyBzdGF0aWMgaW5saW5lCi0gVXNlZCBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNj
ICpwdHIgaW5zdGVhZCBvZiB2b2lkICpwdHIgaW4gbW9kaWZ5X2xkdCgpCi0gRml4ZWQgbW9kaWZ5
X2xkdDAxIHRlc3QgZGVzY3JpcHRpb24KLSBBZGRlZCBleHBsYW5hdGlvbiBvbiByZW1vdmFsIG9m
ICJhc20vbGR0LmgiIGNoZWNrIGluIGNvbW1pdCBtZXNzYWdlCi0gUmVtb3ZlZCBydW5fY2hpbGQo
KSBpbiBtb2RpZnlfbGR0MDIgLSBpbnN0ZWFkLCByZW1vdmVkIHVudXNlZCAiaW50IHZhbCIKLSBS
ZW5hbWVkICJlbnRyeSIgdG8gImludmFsaWRfZW50cnkiIGluIG1vZGlmeV9sZHQwMQotIExpbmsg
dG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMzEtY29udmVyc2lvbnMtbW9k
aWZ5X2xkdC12NS0wLWZkNmVhMTQ5MTk1NkBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2NToKLSBSZW1v
dmVkIHVubmVjZXNzYXJ5ICNlcnJvcgotIFJlbW92ZWQgY29uc3Qgc3BlY2lmaWVyIGluIGN2ZS0y
MDE1LTMyOTAuYwotIEltcHJvdmVkIG1vZGlmeV9sZHQwMiB0ZXN0IGRlc2NyaXB0aW9uCi0gQWRk
ZWQgcnVuX2NoaWxkKCkgaW4gbW9kaWZ5X2xkdDAyCi0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSAjaW5j
bHVkZSAibGFwaS9sZHQuaCIgaW4gZmlsZXMgdGhhdCBpbmNsdWRlIGNvbW1vbi5oCi0gRXh0ZW5k
ZWQgY292ZXJhZ2UgaW4gbW9kaWZ5X2xkdDAxCi0gTGluayB0byB2NDogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDMyOC1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXY0LTAtYTVlZTdiOGQ4
MmFhQHN1c2UuY29tCgpDaGFuZ2VzIGluIHY0OgotIFJlLWFkZGVkIHRoZSBhc20vbGR0LmggaW5j
bHVkZSBkaXJlY3RpdmUKLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjUwMzI4LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjMtMC1mNmI2ZWUxYzkxNDRAc3VzZS5jb20K
CkNoYW5nZXMgaW4gdjM6Ci0gRHJvcHBlZCB0aGUgc2V0X3RocmVhZF9hcmVhMDEgcGF0Y2ggZm9y
IGEgbGF0ZXIgc2VyaWVzCi0gU3F1YXNoZWQgbW9kaWZ5X2xkdDAzIGNvbW1pdCBpbnRvIG1vZGlm
eV9sZHQwMQotIFJlbmFtZWQgc3RydWN0IHRzdF9jYXNlIHRvIHRjYXNlCi0gUmVtb3ZlZCBmYWxs
YmFjayBkZWZpbml0aW9uIG9mIHN0cnVjdCB1c2VyX2Rlc2MKLSBMaW5rIHRvIHYyOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzI3LWNvbnZlcnNpb25zLW1vZGlmeV9sZHQtdjItMC0y
OTA3ZDRkM2Y2YzBAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjI6Ci0gQWxzbyByZWZhY3RvcmVkIHNl
dF90aHJlYWRfYXJlYTAxCi0gTWVyZ2VkIHNpbXBsZSB0ZXN0cyAoaW5jbHVkaW5nIHRoZSBleGlz
dGluZyBtb2RpZnlfbGR0MDMpIGludG8KbW9kaWZ5X2xkdDAxIGluc3RlYWQgb2Ygc3BsaXR0aW5n
IGl0Ci0gQWRkZWQgU0FGRV9NT0RJRllfTERUKCkgbWFjcm8KLSBSZW1vdmVkIGNoZWNrIHRvIGFz
bS9sZHQuaCBpbiBjb25maWd1cmUuYWMKLSBVc2VkIHRzdF9zeXNjYWxsKCkgaW5zdGVhZCBvZiBz
eXNjYWxsKCkgaW4gbW9kaWZ5X2xkdCgpIEAgbGFwaS9sZHQuaAotIExpbmsgdG8gdjE6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12MS0w
LThkNmQ4MmYxMDc2OEBzdXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAg
ICAgc3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0LmgKICAgICAgc3lzY2FsbHMvbW9k
aWZ5X2xkdDAyOiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHMvbW9kaWZ5X2xk
dDAxOiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKCiBjb25maWd1cmUuYWMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtCiBpbmNsdWRlL2xhcGkvbGR0LmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNiArKysKIHRlc3RjYXNlcy9jdmUvY3ZlLTIw
MTUtMzI5MC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDM3ICstLQogdGVzdGNhc2VzL2N2ZS9j
dmUtMjAxNy0xNzA1My5jICAgICAgICAgICAgICAgICAgICAgfCAgMTIgKy0KIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDUuYyAgICAgICAgICAgIHwgICA1ICstCiB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvLmdpdGlnbm9yZSAgICB8ICAgNSArLQogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L2NvbW1vbi5oICAgICAgfCAgMzAgKysr
CiAuLi4va2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAxLmMgICAgICB8IDI2
NCArKysrKy0tLS0tLS0tLS0tLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9t
b2RpZnlfbGR0MDIuYyAgICAgIHwgMjIxICsrKystLS0tLS0tLS0tLS0tCiAuLi4va2VybmVsL3N5
c2NhbGxzL21vZGlmeV9sZHQvbW9kaWZ5X2xkdDAzLmMgICAgICB8IDEwNSAtLS0tLS0tLQogMTAg
ZmlsZXMgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMoKyksIDUzMyBkZWxldGlvbnMoLSkKLS0tCmJh
c2UtY29tbWl0OiAwYTBhNzdjNDQ0YjU2NDgzYmRkZTUwNDZmZWViNTE4Yzk2ZjVlNGEyCmNoYW5n
ZS1pZDogMjAyNTAzMjQtY29udmVyc2lvbnMtbW9kaWZ5X2xkdC04MTYzMjkyMjNmNmUKCkJlc3Qg
cmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
