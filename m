Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458DEC8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751289222; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=EFgy+LTNlhGrVvdQzR2kW47GHTK7ckJddUHoE4AfmgM=;
 b=REUKhPbJNN5/InLGbl87891HK+encyZBzdXrwsZajq15kYmuNBewxTC7nvbgjgus9G96g
 xJXcoU/qxjFNp2pTqEkvz5pCu/MBP11GD/LOJJTJTE3ZaeBsW3GSK/hrYNDW42Q7jpNeSmv
 Oq7btXAMJwQF365SUr7Svf1f8/Qvv1g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C5AA3C5A90
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:13:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC16C3C5A1C
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9EF7D1000B66
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:13:20 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so2833151f8f.2
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751289200; x=1751894000; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RguHHujnMHK9976cEGt42ZYk6CY5+b3oK4UQAkLMa8Q=;
 b=c+H3kwBKIP+Q/+5U9oOe3E2jg+w5Gy3JtJRbDp3P9Bqi59CK9aH6yfS2hVm074oVKm
 HHZFOTuvmwkld9OhPX0lLipIBB/80n8/SAXLUxX6okjr0zIwn1QSDG7SQV/Nz+Yf4+Gw
 T/TXY8LXk++aku6eOfyxvxU3eXAVdk0RVnjGMWL4YNtNV61i/+CaRulkv6hn1hCRYwMt
 denfsXGJW/9JebfRJBx733ZXk0h/LLMbY4tK+AU4Pp1ejSRP/OlBV8oc/OM0Kno4kmBr
 u/YYddlBvmW2oyuawJ9K0AcnkhA/UKjMSHlDIFwQosmTxp1O4PYwR4ktgZEU8RbYegTq
 9qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289200; x=1751894000;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RguHHujnMHK9976cEGt42ZYk6CY5+b3oK4UQAkLMa8Q=;
 b=QAfi0naCpleApxyRhZJELOE8pE29mB7ecktsoldY8+lIoo2gEuY1DY+ynqKgvnjYSD
 dwPQHc7Er/2SL5Ph/9tYdDaqTW8heeAuVh+wEZC7UdG+XUL0Rr00/cBo8/tXofLs/BpY
 AcWjF1JIWABagHfM/YU8OunX5IT3N8yjL1cRK7vKkJDfDBEYjhg6ECgd0RfmcOfNZJ72
 DGe8oKeNeJ9FN7BexQ6RZ9tkzWaCOtBdnHYl3GSLtF7M2l0D/ur3PGbXYYZsYZxZPJQ8
 rzyXUhBKooBQl1pF6rHw/yvirvTr8GHBb51SkVSGurdyzEVz/T3KdHDsNrjNNP2v7LYW
 eWdQ==
X-Gm-Message-State: AOJu0Yw8N7PZvvSA6mRQf72fnDZ2nxn79XNwsLljp+OzeFaBPwnk/eNx
 VZ5EbPudk6H4jPkNwsd4bsmv0D9RnGYVTq9JQadQXfLCQtKCUlpylJ/LYbpRGCn9EEV1e2Ju2jK
 0WMQd
X-Gm-Gg: ASbGncuKTt1FIrlaf5av81KWTqbk9KJHjVaRWAC3VQfl9xh/KsSoFV4C57XD30PBvUK
 6yELglKvkJ60egc3WhFvbc979R/V0hLfvoTb9iNHlOPaeuLRBKypvZxWTg2Ca54zAj60Dk6TEat
 UkAokv4R3BSMy5PS6//+BOBC/eku5zQzX6+1md9tQUZRRoRCpc/GHp+GzAgQFRBRBRUB9cJwurN
 E+QY0sdVQ1ocQVy4Pix8ygE4LABK6cY99tV3FmHYpdMxc4jlpMf33Bw/oE2R4cC8/kNPNu08gBB
 WRzsJ+nx8GAx5E5p/0nEO9gJPSlZSodj6trm1Yz9bUW/UqMPnQ==
X-Google-Smtp-Source: AGHT+IFTi6S/lzWSDSRRiz662+Ck9bAbRicoJ4EpLYBTDhT4Wtlwocvted5YlBWhDzXu4LkBmSpOlw==
X-Received: by 2002:a05:6000:2b02:b0:3a4:d452:fff with SMTP id
 ffacd0b85a97d-3a8fe1ded18mr8175268f8f.17.1751289199846; 
 Mon, 30 Jun 2025 06:13:19 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 af79cd13be357-7d443201735sm591919985a.57.2025.06.30.06.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 06:13:19 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:13:07 -0300
Message-Id: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGONYmgC/32NQQ6DIBBFr2JYdxpE1NCV92hcAB0LC6FhLGljv
 HvBA3T5kvff3xlh8kjs1uwsYfbkYyggLg2zTocngn8UZoKLng9iBBtDxlQ1AnLrBp1UPUqj7Lh
 IVmavhIv/nMn7XNhoQjBJB+tqaNW0Yaqi87TF9D2vc1v1Py+5BQ69kFIJ1RreDRO9Ca82rmw+j
 uMH6UX/GMgAAAA=
X-Change-ID: 20250627-conversions-shmt-3495e4b9c7f4
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668; i=rbm@suse.com;
 h=from:subject:message-id; bh=JUqGJGU4B/aVJZMXT55hlXUPE3D4wcIvoStep/Pu8rM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoYo1qIJKj6Ug/xG4v484mrhPApzBKHMLhBazkQ
 0u53mhYCFaJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGKNagAKCRDJC4p8Y4ZY
 pgrKD/9+gWzjeIohvYCj0xkj1mX/oYJcqrSQBADYQ9DGdVvjffPx3JaiyffsRorWT1NsIv+VDEh
 fgkNuGqtlNvJ7hTcrSs39TYYIMWu6ZDZ8jo2q66rAnljttc92WhT7a3to+axvK6YkVDMkqAN8/2
 d7w6n+jmXCYTDR4MuE3mGplmXEUpmgNqTdbENVIaiswLTDIY/TYNrIasRqSak8YmQJWDOcQJoz7
 yrcsSESar6v7V8nmaPHszmPKcFFjvoSLQYTxIWlO87JpWziW1nOiUsCn2o6b2WTeztGRRSb7pZ8
 +BtRX1aCpJfJk5tS1XELJpuWefyoJmR0yQ2GhkPSCZwzltehcxVV4fF8OHu2V02QmzQYz+icfU3
 Ghb1F0IEfc7S/kkrfm9/5x5AZAwAC5gklX2+Nh1ZpZZCbiRSrciZJl2iQYsleYpgMnLxEGoAPvt
 2Y5/DLzZmN8bhLTzVSlgiVeIhXBVWXG/8vx78NFH4WRRXh9QrXeR/5VOprvW0JCKrIWnlgPEmnT
 feRQ4RC+Yzqsi5g/dOXJlyw4MaPmK3KlGlIOTog5VHas7FMkfqVP1H/Q8W8rr69hPbp/QQHkKNa
 ie4gbCkHe4VLgnOns0xZCQHHNCkj2q+vic5wAgIAnvKCv2ayLHJNSxA49ItIuwiUY90M2IeDUTw
 U2qQ4027p09ds3g==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/9] mem: shmt: Convert to new API
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
YW5nZXMgaW4gdjI6Ci0gQmV0dGVyIGhhbmRsaW5nIG9mIGNoaWxkcmVuIHByb2Nlc3NlcwotIEFk
ZGVkIGRvX3NobV9jeWNsZSgpIHRvIHNobXQxMAotIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTA2MjctY29udmVyc2lvbnMtc2htdC12MS0wLTUyNDQ5MjkxYjAzNkBz
dXNlLmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICg5KToKICAgICAgbWVtOiBzaG10MDI6
IE1ha2Ugc3VyZSBtZW1vcnkgaXMgbm8gbG9uZ2VyIGFjY2Vzc2libGUgYWZ0ZXIgY2hpbGQgZXhp
dHMKICAgICAgbWVtOiBzaG10MDM6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBtZW06IHNobXQw
NDogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIG1lbTogc2htdDA1OiBDb252ZXJ0IHRvIG5ldyBB
UEkKICAgICAgbWVtOiBzaG10MDY6IFJlbW92ZSBpbiBmYXZvciBvZiBzaG10MDQKICAgICAgbWVt
OiBzaG10MDc6IENvbnZlcnQgdG8gbmV3IEFQSQogICAgICBtZW06IHNobXQwODogQ29udmVydCB0
byBuZXcgQVBJCiAgICAgIG1lbTogc2htdDA5OiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgbWVt
OiBzaG10MTA6IENvbnZlcnQgdG8gbmV3IEFQSQoKIHJ1bnRlc3QvbW0gICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZSAgICB8ICAg
MSAtCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L01ha2VmaWxlIHwgICA0ICstCiB0ZXN0Y2Fz
ZXMva2VybmVsL21lbS9zaG10L3NobXQwMi5jIHwgIDI1ICsrKy0tCiB0ZXN0Y2FzZXMva2VybmVs
L21lbS9zaG10L3NobXQwMy5jIHwgMTMzICsrKystLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNl
cy9rZXJuZWwvbWVtL3NobXQvc2htdDA0LmMgfCAyMTQgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3NobXQwNS5jIHwgMTMxICsr
KystLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA2LmMg
fCAyMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogdGVzdGNhc2VzL2tl
cm5lbC9tZW0vc2htdC9zaG10MDcuYyB8IDEzOCArKysrKy0tLS0tLS0tLS0tLS0tLS0tLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDguYyB8IDEyNSArKysrKy0tLS0tLS0tLS0tLS0t
LS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA5LmMgfCAyMTAgKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDEw
LmMgfCAxOTMgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEyIGZpbGVzIGNoYW5n
ZWQsIDI0OSBpbnNlcnRpb25zKCspLCAxMTQ2IGRlbGV0aW9ucygtKQotLS0KYmFzZS1jb21taXQ6
IDBjOTljNzkxNWYwMjlkMzJkZTg5M2IxNWIwYTIxM2ZmM2RlMjEwYWYKY2hhbmdlLWlkOiAyMDI1
MDYyNy1jb252ZXJzaW9ucy1zaG10LTM0OTVlNGI5YzdmNAoKQmVzdCByZWdhcmRzLAotLSAKUmlj
YXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
