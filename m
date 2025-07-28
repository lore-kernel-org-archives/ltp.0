Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C7C87FC9
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753712628; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=2iVw1uMiC+o15Fa8ouBU1IyQLRZVhuf5Z12JQXSkwvk=;
 b=T5bb8647A9uqr5ilIg+mc+GaZ5qknRVbLxfP+9sAwTu0HoIbyzJBe8hl0vt7IBrj8qETe
 pi5sIfi9SGKlzk8MzBes26LMAGeOYOHl+Rd85HqQMrfKN6emzG+N/cWXX8jOCauaDDCm4at
 WGupBWp5QVGSyvMFdGF3s22I8MfjROs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740F03C9336
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 16:23:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22A0F3C6391
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:23:26 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 025AC10008F6
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:23:25 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b77673fd78so2091290f8f.0
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753712605; x=1754317405; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sDO8M5ga8yQsCQPgGGpS9LB39in3iVxSDvRSDrnhM1g=;
 b=CnrjXd2g5R8QQ6VxGsv+dxdL0l3v0H5XTsYNUvCTOERNyvNyUJO3tPmZBcWpjbzlEW
 6wiwJGtGgkeWtCU3igx6giOxSy6Ltzt00f3vJpdGr/HHqWh7W3VGCyk4w8iNWUIYafxi
 q4LbX/+jBVjwhi31osyXdI7UpKs19wi5ZjIbbRdcnwqm7/F1QcLZUcNF5M+yzxjdi3jg
 lzrLPrLSAC/eOVVd2TBV2sI1HMjt13CtbPossP/JT7zspjSIxMo4hhSh/X3yHHtMnX47
 aGzKaYoY7jrNnWjnEW3MO67rgb3utCq3tSmtusaueBsaT6tgXQrjhOMQiBdn+MpdXa0D
 yE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712605; x=1754317405;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDO8M5ga8yQsCQPgGGpS9LB39in3iVxSDvRSDrnhM1g=;
 b=WoVNw9hv2WlkHDV07cpIBRXNXI18G/3NY5c+scktskC1Bxg1VFVxcGd5COZ+mX8Kkm
 KOC+brrxCZf1VDEN1Rskq0NNsM8k1WnlQuAtmXwvk3Z/qihp6KqGsSk6UJThre0GfyFX
 SOTTEtVlw1z5VmEjc2BR6K37FIMcPjLIQ0wRCXnqtitt8XwcPTxPgf/FaghHusGpQej7
 bNFmXYj4d6aLvfDvNQ1KUZuKNQIk/J2JpZIwa4xUvW6Pk8BZi501OPyyvTnvuyGrMfTF
 3/CImE3vV5X0nzZMNrCi2qRM3gH0nQYHEaLw9H3orop+EFx9sFyxwjAtfAREmc+8g6Yf
 B+8w==
X-Gm-Message-State: AOJu0Ywfk81glORue/gT+EFUy3GqnZtP29I3jQjU8kUpRNZIRg9rknGi
 GifiwjLBrp6OFGRCKcsS1R36NnfMdTaO8psFOKNzm9sKqTPyLgFDU1EkZEYindsCND1N6X4hYyg
 DD/Q9
X-Gm-Gg: ASbGncuHkQbLqvcYYRbXN/fphkWbzOGxzre6ysP48JlulgWNWK7eTEnTpIkKmTYS6Lw
 FDx9SmiiW4lTSgGqltqHDFGc3Iaui8JOp6XSraINSUkpb2M3t4tsNmQNbUF8ywmggrjHRejepAh
 fAUhSNMIJV8kJCAducbAdcMdRzCihxYiZkKO1SuqyCaq4DrRw21jnU23EOMVtaa37/V+sUzgV6/
 RtXkRdoF3GhmvBCeeu2V5x6ApIgoRe2ur1yBx0jcB/Qb+UfBxrLhXviW8F3A37CdHr0FO9pd5F7
 P+yPjuxEgM/Ij+WGr8VgAEYxC92Phyv8B4EIfvp0Cklqkue+Ym92JtPUuC/Z6l/0+9c+k5vrccp
 0LulZxzX0GA==
X-Google-Smtp-Source: AGHT+IEsEy2Jui7zqzG28Sdn+VpXLDiuhsGEFy8mKP9/BCRN6HvSOPMjbN/DBMw5tD5FZx9hZmGclg==
X-Received: by 2002:a05:6000:2f88:b0:3b7:8ba2:97e6 with SMTP id
 ffacd0b85a97d-3b78ba29be6mr1187967f8f.37.1753712604872; 
 Mon, 28 Jul 2025 07:23:24 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7640b8b0beesm5715824b3a.125.2025.07.28.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:23:24 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:23:17 -0300
MIME-Version: 1.0
Message-Id: <20250728-fixes-munmap04-v2-1-17813370a0ee@suse.com>
X-B4-Tracking: v=1; b=H4sIANSHh2gC/3WNQQ6CMBBFr0Jm7Zi2UEVW3sOwaMsgXbSQDhAN4
 e4W9i5f8v5/GzAlTwxNsUGi1bMfYwZ1KcANJr4JfZcZlFBa3FWNvf8QY1hiMJOoUChRl05r4W4
 W8mhKdBp582ozW8OENpnohuMmGJ4pHeLgeR7T9wyv8tD/NlaJEqlU1EvZ6UdlnrwwXd0YoN33/
 Qek61C5xAAAAA==
X-Change-ID: 20250728-fixes-munmap04-02083c550c6b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=rbm@suse.com;
 h=from:subject:message-id; bh=UOPWwqnbgg/0tzLgaR/nOawOMNnNSxKeiM3gXYeyySA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoh4fZPqxSgRCVVCEAKGsUx5SwsPYnMyAxnmgKT
 aftE/olj+WJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaIeH2QAKCRDJC4p8Y4ZY
 pkGHD/484PoTvjHW5zYqI0duBXSY80mlZnPgJq20g2G4OSvvzS3jtN8r1X4YmO7GXF7c+e5/D4U
 ezU6d4zDddcMUOmmjG3g2NvAd/WPV0PFyiOp6rNRC1oNbRR7Oh4fww0fMnbdt6xt5TqT9R2G0BB
 uoqtrE3igb5bY/9uFwZOcHzkAqZgJOXElF+igk2OMfETEOV+o1ljzXcvckF6cPSZWuEGAtuGlR7
 MioeK4/7clPv+b0mq60sJ6HeH3Z9IUbsFe1NO30dMSNyU9RW1uQnaehzGT3ybnzLYQwyxWJ94Iq
 Sg4rEBX2aT9rTJ3SRj2MU4qnrH/adieEp29B5khbYFEjo4O1z3bBS15FWWFWJyqDJmSiFwAAD54
 SdNK8/cDLY10pQJ7LE6UjwU0hk/hCf9IgqrsWg8BCH4A00qeJOef/1JVq1YQ14aO9XE5rkCPkJl
 k34Lh//nYAPdXlfQ0GFt2PGECW+dAHo9kE4HC5dpcdubVAWKA6y1wowP8b6mHB/FepVaS/NNc8n
 jhjgOzEwBtBubjNf2OdB/dTEdeYywkXN/wt57QmQ/amqDtSdXvy4+h02fB/hL/JYYnedouuqYRe
 ncuU8dxnzBa6n8LQdzBXwmko/NCDhB6ijjyJhALHyMklWa/S/gFN0t+obuwtD4dwS17XY5s5wgd
 e+zx8KiyvN8Dytg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/munmap04: Check errno while trying to
 exhaust VMA count
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkluIHRoZSBsb29wIHRo
YXQgZXhoYXVzdHMgdGhlIGFtb3VudCBvZiBWTUFzIHdlIG11c3QgY2hlY2sgbm90IG9ubHkgZm9y
Ck1BUF9GQUlMRUQgcmV0dXJuIGZyb20gbW1hcCgpIGJ1dCBhbHNvIGlmIHRoZSBlcnJvciB3YXMg
RUVYSVNULiBJbiB0aGF0CmNhc2UsIGtlZXAgcmV0cnlpbmcgd2l0aCBpbmNyZWFzaW5nIGFkZHJl
c3Nlcy4gV2hpbGUgYXQgaXQsIGFkZCBhIHNhbml0eQpjaGVjayBpZiBubyByZWdpb25zIHdlcmUg
bWFwcGVkLgoKU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KU2ln
bmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNoYW5n
ZXMgaW4gdjI6Ci0gRURJVE1FOiBkZXNjcmliZSB3aGF0IGlzIG5ldyBpbiB0aGlzIHNlcmllcyBy
ZXZpc2lvbi4KLSBFRElUTUU6IHVzZSBidWxsZXRwb2ludHMgYW5kIHRlcnNlIGRlc2NyaXB0aW9u
cy4KLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzI4LWZpeGVz
LW11bm1hcDA0LXYxLTEtZTMyZWYxMWQ1OTRhQHN1c2UuY29tCi0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYyB8IDcgKysrKystLQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tdW5tYXAvbXVubWFwMDQuYwppbmRleCBlMDQ2ZDE3YTc1ZjhmNzVjNWIxMWQ1NjljMzNk
YTQxZDdhZGM3ZDA5Li5hZWI5MDUyODZlOWQ0MjE0YWM2NDIzZWYyNmU5NTcwNjc0YjYwNTMwIDEw
MDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKQEAgLTQwLDE0
ICs0MCwxNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQogCQkJICAgICB2bWFfc2l6ZSwgUFJP
VF9OT05FLAogCQkJICAgICBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMgfCBNQVBfRklYRURf
Tk9SRVBMQUNFLAogCQkJICAgICAtMSwgMCk7CisJCWlmIChwID09IE1BUF9GQUlMRUQgJiYgZXJy
bm8gPT0gRUVYSVNUKQorCQkJY29udGludWU7CiAJCWlmIChwID09IE1BUF9GQUlMRUQpCiAJCQli
cmVhazsKIAkJbWFwc1ttYXBfY291bnQrK10gPSBwOwogCX0KIAogCWlmIChtYXBfY291bnQgPT0g
TUFQX01BWF9DT1VOVCkKLQkJdHN0X2JyayhUQlJPSywgIk1hcHBlZCBhbGwgJWQgcmVnaW9ucywg
ZXhwZWN0ZWQgbGVzcyIsCi0JCQltYXBfY291bnQpOworCQl0c3RfYnJrKFRCUk9LLCAiTWFwcGVk
IGFsbCAlZCByZWdpb25zLCBleHBlY3RlZCBsZXNzIiwgbWFwX2NvdW50KTsKKwlpZiAobWFwX2Nv
dW50ID09IDApCisJCXRzdF9icmsoVEJST0ssICJNYXBwZWQgMCByZWdpb25zIik7CiAKIAl0c3Rf
cmVzKFRJTkZPLCAiTWFwcGVkICVkIHJlZ2lvbnMiLCBtYXBfY291bnQpOwogfQoKLS0tCmJhc2Ut
Y29tbWl0OiA2YWY2MTk1NTJjZTc2NzYxNzFlNDdiODg5NjRmZmI1YjA4NDk5YjM2CmNoYW5nZS1p
ZDogMjAyNTA3MjgtZml4ZXMtbXVubWFwMDQtMDIwODNjNTUwYzZiCgpCZXN0IHJlZ2FyZHMsCi0t
IApSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
