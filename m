Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BC3C83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751903112; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7H06qjZ4ML6TZUE3pAgIhcD9LnsG8HP1emD9MofAByU=;
 b=elvpz4xsEoRFEFyORbV5sw0w/Rigr94prSTKeXtPwSgR9DO+chRiqsPcSXg2AqM1EEE47
 4MvuAm3Q4J6do+8h+PqNhbKsj8LuDQ/GRQTlfTeApjsxPMeZKPcbULcKfhFJ1PaWUKMorC2
 P4XVe9DbK/rjSV9NpXtmCQhxlnk0+bc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D052E3C9E07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:45:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F11D3C282E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:44:50 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 12A2D600715
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:44:49 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso1482995f8f.0
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751903088; x=1752507888; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vNMUPBd3PvfWBMJfwunOjnEH7XGMVH4hM/4GLFO0Sys=;
 b=dZHTT+YafZWm6VsGfoHCBrDD7m12+4XFzDWYBUbz4M0sGUOZvmGgqs+UQRWLCQKw2h
 1XnQ3yjItjbVCYoIdK9/bxW48D7uO/KvuWnoB57BaMagqb1IU+gwxYsoEkvRjhq1GWrp
 sQIvIjKiEII7S4/kuqbl55Ith+QRsrDnHqFW3AOjavTiyRTLjyZ1VrAgbQjed3961rEp
 2DmtnbTlzh/nVQ6JpYz76tecA+19ACE0DtBIHTg1wVPRW4Vi/EMTlQEzFOTPu1uMCWGz
 TXm4byJeXZoRZ/dcMqQJ9aoG8kMf3Qufu/oAVw83CGMhhjaqg+eUai6+/jH4zV3EdiVJ
 FBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751903088; x=1752507888;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vNMUPBd3PvfWBMJfwunOjnEH7XGMVH4hM/4GLFO0Sys=;
 b=ENHIzbFY7VJFZQ94NQL9RUPDUaSGrPcGK+qz+h+s2mneWlNGJMsQPdy5SGgQ6FcKsQ
 A8ln0c8E0VyqVHtel+7q01zdjqYyeBDAU3l82hS8CySNZaZHWHWMuwRGyfpdJC4EbPyI
 WEzoeeM7dmR+EYd1C1c62R1o9Lrv0cf2NfZIXUIlIzpBJlf5YGLraZASFnF+yYFc6dWg
 skBQtg+g62e1xZoIP2gMBEe+4agft6v8w/p236v0NxxE3Jd5wvGSlbcjlW8Tns4rA97C
 j0s6U6e7O1lHBo0m7tn4X9RlCbG+7/dZakn6pIGhxQfWAijinMmNNwKYB4KhOGExgabs
 tMqg==
X-Gm-Message-State: AOJu0YwARiAK2M+CSmEAJh9xbDw5hrcXxgOGW9ULqexvbZoJhpVLZGu6
 1//Acghf6n7RSZlyWUkYnK2ZneNcEtH6qbHmFtKYEYmYIW95A5hyqEFnBT24AoYjtks=
X-Gm-Gg: ASbGnctZVte04Q+ErBeySXQYSXUXyz9Xfcg4ifyUU5RdYQE03eiOBn+MXo8JbEKfMFv
 W4fK0FOn2rl6EEzrKvUEYfIYEqALcoFDQ6aTQ9B3dtGlUoY8yp/PO+m7S+ZG1m3BVHmmHQm0xhh
 eyblLDLQqLctjTJ5xruX8V6TD1+sEi14xQX6Zsm4LMbIPLbzxgDRsbxn+tR9B1V2oedt2szjBBR
 2EHS/z1KBXcHiHaSilmjmooArkiCDP6Vod8LANMbbde42T415kCVXBLx4f3/DNpmU1Y1BXduSXH
 koo8v9tJ7zfQKwZvJO3s0BFjvs9znN94TUubwsF4xapXttT/RPRvPj174pee
X-Google-Smtp-Source: AGHT+IGcrIfCj2rmWVfglAVK0WlOUExvFRPMUEaVCBjspoOJH7m0EaPWEu6sgizypi2D1k9GVXNlBw==
X-Received: by 2002:a05:6000:4b1e:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b49aaa1405mr6021948f8f.47.1751903088339; 
 Mon, 07 Jul 2025 08:44:48 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4a9949fbe79sm65546471cf.31.2025.07.07.08.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 08:44:47 -0700 (PDT)
Date: Mon, 07 Jul 2025 12:44:42 -0300
Message-Id: <20250707-conversions-munmap-v4-0-0977b2338550@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGrra2gC/33NzQrCMBAE4FeRnI1sk/7pyfcQD5t0tTk0LVkNS
 um7m/RURDwOzHwzC6bgiMVpN4tA0bEbfQrlfidsj/5O0nUpCwWqgga0tKOPFHKN5fD0A05Smxr
 V8Yao6lak4RTo5l4rermmbJBJmoDe9pkakB8UcrF3/BjDez2PRa7//YmFBKmho1Z11RGgPPOT6
 WDHQeSbqLZC+VNQSTBoNQJiUTTmS9Bbofkp6CRArVWlG6xt222EZVk+hIPwc1ABAAA=
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=rbm@suse.com;
 h=from:subject:message-id; bh=fJ0bWBwQ9H3a72A8O8uYw+Uvq+N12o3kpBRkgce0UEI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoa+trK5k3S95eL6Ux46wN9/EYO+hzz8dmq5yLo
 4KiD/w4NMOJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGvrawAKCRDJC4p8Y4ZY
 pkLXD/41T6u8denJrTGG7t/S8Po8NN6dXoVSC/+NiDJV+CJtEZLS7qaEgbaNKAOaUTAu1qjF561
 lMZrGAHx1wT7ZkNULLa/sngVYF5axziqGTfRg8awm5xdlvO8ok6qk2g5YgR8jBxGZM3MGqwIwrA
 ZeOSNk/R1TsKRHbSoCRxF3iBw+X3CBmx5GHb/9nWyi7DfBcDzm+oCWB3rUqSBzw5zwvEWlsU2qX
 DXdgGM3mE89JkbUNRGcqbT+PR2LUfNERg+KSxDf3LWTEMBbR/Cvai24YpcCpfvVrjwdMH0gwVB2
 1nem/u16tJezfyeBiT8PtF6/10Zh82C2x/hhz+OW9IdH7x5N+Qq4QW0Burv/moxtMc2oPNpdcnP
 AVz6ySytrtnty/8cMCV5DkZBuXS7C5kuwK/ffWKA5mMalP64mOSLSdNxQXBk/d5QVate8lW2oEv
 kFKQmbf0eehCYJ7FtHKgH4ulXw6U4Rk1vQN8KcB+sHXPsfiUOw4aZ0KiF/oLWKLN4oFd9S+G1c7
 8tq95euDmpMEKoiGcoiKIhZziH+sGMwyctYB5lWWCzmLnglHjrY5yKnJmWLvJh2CscVmii4VQph
 tlex5cDkYI2uszvq082HmOJCGjpbC74W11jP70sdYlAjOZb0cFxI4cdHYtt3bWSGZH9TC0aGsLU
 NGWDq7fbxdfoHVA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] syscalls: munmap: Convert to new API
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
YW5nZXMgaW4gdjQ6Ci0gbXVubWFwMDE6IFNldCBtYXBfYWRkciB0byBOVUxMIGFmdGVyIHVubWFw
cGluZwotIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDctY29u
dmVyc2lvbnMtbXVubWFwLXYzLTAtMDYzMjUzN2E2YzhkQHN1c2UuY29tCgpDaGFuZ2VzIGluIHYz
OgotIFN0b3BwZWQgdXNpbmcgIm1hcHBlZCIgdmFyaWFibGUKLSBTaW1wbGlmaWVkIGNsZWFudXAo
KSBpbiBtdW5tYXAwMQotIFJlbW92ZWQgdW5uZWNlc3NhcnkgY29tbWVudHMKLSBMaW5rIHRvIHYy
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA0LWNvbnZlcnNpb25zLW11bm1hcC12
Mi0wLWJhYzNhMGFhMTE3YkBzdXNlLmNvbQoKQ2hhbmdlcyBpbiB2MjoKLSBtdW5tYXAwMzogVXNl
IHN0YXRpYyB2YXJpYWJsZXMgZm9yIHNwZWNpZmljIHRlc3QgY2FzZXMKLSBtdW5tYXAwMTogVXNl
IGZvcmsoKSBpbnN0ZWFkIG9mIHNpZ25hbHMKLSBPdmVyYWxsIGNvbW1lbnQgY2xlYW51cAotIExp
bmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDMtY29udmVyc2lvbnMt
bXVubWFwLXYxLTAtMzBkZTgyZDU5MDA0QHN1c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOo
cmUgKDMpOgogICAgICBzeXNjYWxsczogbXVubWFwMDE6IENvbnZlcnQgdG8gbmV3IEFQSQogICAg
ICBzeXNjYWxsczogbXVubWFwMDI6IE1ha2UgaXQgYSB2YXJpYW50IG9mIG11bm1hcDAxCiAgICAg
IHN5c2NhbGxzOiBtdW5tYXAwMzogQ29udmVydCB0byBuZXcgQVBJCgogcnVudGVzdC9zeXNjYWxs
cyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlIHwgICAxIC0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbXVubWFwL211bm1hcDAxLmMgfCAyNzcgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDIuYyB8IDI1MiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5t
YXAwMy5jIHwgMTY5ICsrKysrLS0tLS0tLS0tLS0tCiA1IGZpbGVzIGNoYW5nZWQsIDExNiBpbnNl
cnRpb25zKCspLCA1ODQgZGVsZXRpb25zKC0pCi0tLQpiYXNlLWNvbW1pdDogMTZjZDY3ZWYxZjg1
ZTZiMTRjMTgyZmE0OTYzMmE1MDE0NTYwZWRmYQpjaGFuZ2UtaWQ6IDIwMjUwNzAzLWNvbnZlcnNp
b25zLW11bm1hcC0zYjZhMjlmYWEyNjgKCkJlc3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFy
bGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
