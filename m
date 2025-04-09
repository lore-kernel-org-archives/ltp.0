Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474AFC36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744205123; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=NHkg7UC2j5GbokGtuDaFaC640A0bZkco4B5eQenx+eU=;
 b=DxumM9vQK1A/E6Qd65s4wWPGm642njKHvZ7YbNgxJRIHOwRN3HCHcww7AY3QOQih0v1YV
 XHZ6OG6heoZbCTbhIZSte9iNMYOVop+ubv1RXa9eCMsC61p6oWAlIL2DHGRhhWCsBK67DGV
 8AtwOUfOTimOwQcxE2jIQceZB3/kjFc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89B5B3CB40B
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 15:25:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A65D93CB3FD
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 15:25:01 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 07C0F1A00CBE
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 15:25:01 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso12845569a12.2
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744205100; x=1744809900; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImsUmu9s18BA73CSw1qSw7wkPHh6Czm73JLlZ4W0Rsg=;
 b=W1rEADsWnZ4s9x9BEgUy1qIeH1sQmWLU+owSt08gM83R1abOufyJv8sLgz1dDnxpOD
 eO/BMoOL9jJpTVfGSg3iDRt0vxVycWyXmoGyKrrSlH9TlNKPTgHxnV2t0SLa+3QcYaO3
 iqklLGjNsNwW9AqVP1dPX82p6Hau4CFKi09qWmDrZ7V2TySsJSx+ZCjAfzUFholL6dpx
 Dyc+H28f0iWEOZDzxiCvW5dVPDdddz1tYklQr1MGsGD0tn4Qe6mpImvgTa4gJgkPLakQ
 G1M4ac7IKekH0fBGOAKmzIDTfeW5Lmh3nQ42J44/sI0xoc2Jh3lVDnRXY9c37I/q4rOh
 Z2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744205100; x=1744809900;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImsUmu9s18BA73CSw1qSw7wkPHh6Czm73JLlZ4W0Rsg=;
 b=wDwhfR01eysOPy8cJrqaIZJgfNAN9tmEy0ucko6NRzeKYdOr+7sBKMaOWzYCEnkLu0
 dm0wYpCaY4xVojsCNwgXsVfcRGagy/ZSEfEesayxO013Dj7RcR0Y0FC97xiJPCqHygbn
 oC+ZU7AIepnmlakLH7Q7cKmrYNr8ggKwBPNM3bIHBp6JHAfR+NSoSbgLtr4nsqe21NJV
 cq+BRQR66RIuItcFCFMDKS/I5pAZZ/QzmbI5YexcvEyoc0LKt8mj5ScsOZC4O08Bf/Pt
 R0jgj9AIZQVXzPOQojiZq2PFWi+lAqy0KrQd93QQY25X8SCXm5LptdBAaPZ3vEIRKrJe
 63RQ==
X-Gm-Message-State: AOJu0YzqEk1FDl/vYUndyiraBYe5IGMvX1T60KxwFeMOxWIC5c/B/JhK
 E7+2wmE7QYSjFckcVepxUcfOccSFVEHu9rehrRCGqOt5vNzhg9EDjCNFLD/ubX0=
X-Gm-Gg: ASbGncsJoGD3ehZ01RmPWUgRsR1jslfNnT21zbGVzJG363d6hVDAA3LkSkpPs0mfgrE
 XHTz+jSRNaPaQqaeTKsIlGOXImsmgP1yt4XebIFX4bSExpz72QIy/BS5IWnSmM7ukRMnIXJAYv+
 o0LJlEOUAvBIR1J0FQ2im7hbBJSlK8T6ulBZ44OZFGWmFfnZUxHIZm2e0qZaDS02t/pPiFKb3Hc
 v7FGDG24mLIPJ+NO1cGIKdw/lwhgR4WvoVGBvwtGKoemQ3LsN6nPq3Vdbv5VLfRHTZrk05zXG7a
 w5ve4JpjeIq2r5ESIwZtPD0fity2fA==
X-Google-Smtp-Source: AGHT+IE0Ecp3FzTeW0Fl3+BlRT88cdEdZKOLNXtUzvkXvqan3nJq6ApgPyniJpUk2enVfn95l/Qnzw==
X-Received: by 2002:a17:907:3f9a:b0:abf:d4a9:a096 with SMTP id
 a640c23a62f3a-aca9b719f53mr254650266b.37.1744205100338; 
 Wed, 09 Apr 2025 06:25:00 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-72e73d717c1sm161949a34.25.2025.04.09.06.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:24:59 -0700 (PDT)
Date: Wed, 09 Apr 2025 10:24:52 -0300
MIME-Version: 1.0
Message-Id: <20250409-fixes-distclean_circ_dep-v1-1-f8e6dc92bbd2@suse.com>
X-B4-Tracking: v=1; b=H4sIACN19mcC/x3M0QqCQBCF4VeRuW5hNY3sVSJkdnbMgdpkRiIQ3
 92xyw/Of1YwVmGDW7WC8ldMPsVRnyqgCcuTg2Q3NLHpYhv7MMqPLWSxhV6MZSBRGjLP4dyN19R
 ivvR1Bs9n5f/W6/vDndA4JMVC03H4RltYYdt2B/m20IMAAAA=
X-Change-ID: 20250409-fixes-distclean_circ_dep-35f8b4ad691d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=rbm@suse.com;
 h=from:subject:message-id; bh=/bHESzI/DKcKsZvJoWC9GGxQvIt5Iw5Q9d2MFcyqM6U=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn9nUo+2bvELboINVYta0yozy1ST00j5uNH5qvN
 wxw1ayP+I2JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/Z1KAAKCRDJC4p8Y4ZY
 po5qD/9Ro+3m+psdOpAzdzzu07l0DGUhMjpt49IjfTgHj0qQEZcova/j0w6mIUw6eF8Eugg5HFs
 AIaZi62iiTc1FbPGRfQi45bBELe0/zaEmQrCuse4s/x5BESZFW0dmnvNJxU59n+li6hEXJnxOVU
 sBN43UctjSCVIymWRtnF22i6vtLMEOEkf6NifEqsPwCShDqtQL57BbggQSI9pfgu0hWVeX81C9q
 RwOQp3NqrEbF1FYP3vlkbZfsDRmlFc1JJzlWRdRGf6cEGKoEqmxcCL5ZUYpuOFKlmJmNWSbRUV5
 xVULb7dwapu9Yz9S0CKBpx+lBaHqqs1SMFTT/BBlMXXxBZxtNlOT2zQEd1Xhffnc30+hNiuKasx
 epqQIZtYr9nekkjBUxTWo+CmFj7LMybt6lFjr0zFPsHE3jS0xvmA3bN2ro/6GkaqS3LJlxTYcdr
 /ABjPYLqTvHchnD5jE1QCmNW+ew7Ryw3zdRsZZR52Ps1Kmt1tdf58PpvW6pPZql7cVzdmIB1yoS
 MMUf4DcHFr98HeV5I3GoDw715GQzGlwwF4Qxp02BSI3a8dQBWBPaer6bjFZLpzD4wJKYJhE4Ap2
 7x8k8CFsdXOpmFETCGupIdTwxw9Q6ZJk7pPCxF3Awe/Rht6lkgYb0kBzPEw8N/SFjTzgiUA8nb2
 2xgw4gexsVvATGA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Makefile: Fix circular dependency in distclean target
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCldoZW4gY2FsbGluZyB0
aGUgYG1ha2UgZGlzdGNsZWFuYCB0YXJnZXQsIHdlIHNlZSB0aGlzOgoKbWFrZTogQ2lyY3VsYXIg
aW5jbHVkZS1jbGVhbiA8LSBkaXN0Y2xlYW4gZGVwZW5kZW5jeSBkcm9wcGVkLgoKRml4IGl0IGJ5
IGFkZGluZyBkaXN0Y2xlYW4gdG8gSU5DTFVERV9DTEVBTl9SREVQX1NVQkpFQ1QgZmlyc3QgY29u
ZGl0aW9uCmZpbHRlci4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1A
c3VzZS5jb20+Ci0tLQogTWFrZWZpbGUgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmls
ZQppbmRleCA1MDY2Nzg5MzQ5ODM3ZWQ3NGQ3MGZkNTBhOTBkNjQ3MmYwOTY2NjAxLi5lYWI0MGRh
OGE2Yjk3OTU0MGM1ZmU4ZGQyNGQxN2UyM2ZiY2IwMTQyIDEwMDY0NAotLS0gYS9NYWtlZmlsZQor
KysgYi9NYWtlZmlsZQpAQCAtOTYsOCArOTYsOCBAQCAkKGZpbHRlci1vdXQgaW5jbHVkZS1jbGVh
biwkKENMRUFOX1RBUkdFVFMpKTo6CiAKICMgSnVzdCBsaWtlIGV2ZXJ5dGhpbmcgZGVwZW5kcyBv
biBpbmNsdWRlLWFsbCAvIC1pbnN0YWxsLCB3ZSBuZWVkIHRvIGdldCByaWQKICMgb2YgaW5jbHVk
ZSBsYXN0IHRvIGVuc3VyZSB0aGF0IHRoaW5ncyB3b24ndCBiZSBtb25rZXkgc2NyZXdlZCB1cC4g
T25seSBkbwotIyB0aGlzIGlmIHdlJ3JlIGludm9raW5nIGNsZWFuIG9yIGEgc3ViY2xlYW4gZGly
ZWN0bHkgdGhvdWdoLgotaWZuZXEgKCQoZmlsdGVyIGNsZWFuLCQoTUFLRUNNREdPQUxTKSksKQor
IyB0aGlzIGlmIHdlJ3JlIGludm9raW5nIGNsZWFuLCBkaXN0Y2xlYW4gb3IgYSBzdWJjbGVhbiBk
aXJlY3RseSB0aG91Z2guCitpZm5lcSAoJChmaWx0ZXIgY2xlYW4gZGlzdGNsZWFuLCQoTUFLRUNN
REdPQUxTKSksKQogSU5DTFVERV9DTEVBTl9SREVQX1NVQkpFQ1QJOj0gJChDTEVBTl9UQVJHRVRT
KQogZWxzZQogaWZuZXEgKCQoZmlsdGVyICVjbGVhbiwkKE1BS0VDTURHT0FMUykpLCkKCi0tLQpi
YXNlLWNvbW1pdDogODAwMGM5NTBkNmJhNjFhNTQxYTkyNzhjZGRhNmQ2ODE0MWMyZmMwZApjaGFu
Z2UtaWQ6IDIwMjUwNDA5LWZpeGVzLWRpc3RjbGVhbl9jaXJjX2RlcC0zNWY4YjRhZDY5MWQKCkJl
c3QgcmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
