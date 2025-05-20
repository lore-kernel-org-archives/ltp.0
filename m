Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECE0C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747745220; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=aN9r1w88aD1N6VNTxqOCxKDulGELWvW6uzH3wRlLuxA=;
 b=fAbyscSc4rZeSw2sGOvPS6G+Hm0rwG0xz1uT4b5KpqEVT2PJ2ytcI0dMocd3kCYtrp8d4
 2llutQs/+Er3zJC7GXM9xptIAOHljZvkFb+U+pf4l2Nvyr7zFMDmFgfI23K0l/xRWLU5rNS
 M8yYx5wMB2pc5QiA6bolWyC2xC+Jaw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FFB13CC773
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 14:47:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9ED013CC3E1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 14:46:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7348D10000C0
 for <ltp@lists.linux.it>; Tue, 20 May 2025 14:46:37 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso54830865e9.2
 for <ltp@lists.linux.it>; Tue, 20 May 2025 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747745197; x=1748349997; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8r3lD7JoC+9oPSYjHXyxxhsIB5GRcH77Oa6k3GUozU=;
 b=S+bJABvX+uTVwfGHB6IyTdn9lQy3JPkPyo0fhegtSv1auo3k+SoI10TsnHuiWtvCms
 vDwNr7n07s7tqZ/8BeVAeMhuJGv5u0k/Qt4tFpCAbOeTnALRHagrD32PTf/q70a7kn5z
 76PYU+an6FubQfFSQov/kRWbGTYjj5EvctBq+dth6SgDwXJyVFP/g71qW/W31KaaeNXX
 TbXZO+SLZykYUMgLnbraDRRQgQDioREhuuM34Fm/2wo5L9DQKu3FC6eQnnipp35K346z
 jywc4J9zGOoLWyqakG+P1w+7AKAkH0lepnz8cyOIyuOuga3s10rgRRb8WMzTpLazGS4h
 CgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745197; x=1748349997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8r3lD7JoC+9oPSYjHXyxxhsIB5GRcH77Oa6k3GUozU=;
 b=rBw7yvZXKj2JtfCTKU+HhQHDcXPrVR24zyyPHpraC43+M5snkSdoTEJDn57QMa1ool
 vU7unHD5cTGND+QjhFO1L0e9Au12DKzS4+/KU/gWx0bLcv8+yBVJop0/euhxmPcUH1Xs
 UVPG7MTrejpMB3/9EVYoJsOLEbNrX8cWjDaojpJWVP61P+AhmcrCvxQLvNLxR/Btcxy0
 oH8w56VedHeckmDdbh5c42fzVszFaUBv80UzaRUrTLuFmOKOtvKwih4raWnyDct9H2Kf
 x1un+U1BHxJNJYI+3+/2a33XkMmRHtkJcpOd7oOmltgvQEA3hwTG/xnnWvSQPyzegdug
 ZAMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtK2Gxfy6oiARlhN/Px7sTV3hB8Dn4ilT06JAzUMLOSsEln+Qy5U5PnuCn2HGXcxqcYtU=@lists.linux.it
X-Gm-Message-State: AOJu0YyKcf1a90KUxymi6aFqn6gLF5Tkh5kA0ra8dNT8nKITdoSGCwn+
 Z2kkjIzzexI/QIVEnv1oA8fsBHOf1wSP55PcUl8FbmFclvSLBG2JvBjY+TbsfXeRCDg=
X-Gm-Gg: ASbGnctkD7TB9Khhlvkl4ejOnZZOOiLY9y6rAR+YViV61L091zNqsPWV7Up6Xq+qtWu
 ksSN/i+36EG6E2+InX410Kp35HZ873Z5wBdpoiDGWsCasaQeFGseGUI4/ZL5QduFitEeNt8rznd
 M3EJcBVHSOY299QNioEMsruF+NzenZnDqV+TMYppw62V0ANYYc0poIpG2Bf2El2OpPLwfHTKZTA
 /neYo2mZQ0j9RJ39yd5YBixFH6PtFLPluEftwt3lPrOcyNil715w4w0pjzuJZNA0k10I7uokUiy
 +yIuzIkg0rvBFb2DbP40p61H4wVZb1MuduSBNy9XXswPDw7G+FeaDYHmFeZqIw==
X-Google-Smtp-Source: AGHT+IHHF39GCnMgFpxe4V8ZzMujClzby5MjZYyVZnJqYCZJuhCI1c+GXNDUN0HXWxGjerkx2PMkxA==
X-Received: by 2002:a05:600c:a0b:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-442ff03c666mr108117205e9.33.1747745196826; 
 Tue, 20 May 2025 05:46:36 -0700 (PDT)
Received: from [10.232.133.20] ([88.128.90.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78b2f19sm28945875e9.32.2025.05.20.05.46.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:46:36 -0700 (PDT)
Message-ID: <cea8a040-a624-4370-991d-73a521400d1f@suse.com>
Date: Tue, 20 May 2025 14:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <20250425-conversions-mknod-v4-2-222e0d2e7ef1@suse.com>
Content-Language: en-US
In-Reply-To: <20250425-conversions-mknod-v4-2-222e0d2e7ef1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/8] syscalls/mknod02: Use relative path to
 avoid use of SAFE_CHDIR
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbT4KCk9uIDQvMjUvMjUgMjA6MDYsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3Jv
dGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFJldmll
d2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBSaWNh
cmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IC0tLQo+ICAgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMgfCA0ICstLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbWtub2QvbWtub2QwMi5jCj4gaW5kZXggODlkZDFkODc0MDIzNGI3ODg1NTRlNjI1ZTY5MzY5
M2I5NTQ0NDBjYy4uYmQ0NzZmZmY3OWNkZGU5MDczZGQ0OTY2NGY2ZmQzMjAzMWY5ZDk2NiAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDIuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMi5jCj4gQEAgLTIwLDcg
KzIwLDcgQEAKPiAgICNkZWZpbmUgTU9ERV9TR0lECTAyMDAwCj4gICAKPiAgICNkZWZpbmUgVEVN
UF9ESVIgInRlc3RkaXIiCj4gLSNkZWZpbmUgVEVNUF9OT0RFICJ0ZXN0bm9kZSIKPiArI2RlZmlu
ZSBURU1QX05PREUgVEVNUF9ESVIgIi90ZXN0bm9kZSIKPiAgIAo+ICAgc3RhdGljIHN0cnVjdCBz
dGF0IGJ1ZjsKPiAgIHN0YXRpYyBzdHJ1Y3QgcGFzc3dkICp1c2VyX25vYm9keTsKPiBAQCAtMzcs
MTQgKzM3LDEyIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gICAKPiAgIHN0YXRpYyB2b2lk
IHJ1bih2b2lkKQo+ICAgewo+IC0JU0FGRV9DSERJUihURU1QX0RJUik7Cj4gICAJVFNUX0VYUF9Q
QVNTKG1rbm9kKFRFTVBfTk9ERSwgTU9ERTEsIDApLCAibWtub2QoJXMsICVvLCAwKSIsIFRFTVBf
Tk9ERSwgTU9ERTEpOwo+ICAgCj4gICAJU0FGRV9TVEFUKFRFTVBfTk9ERSwgJmJ1Zik7Cj4gICAJ
VFNUX0VYUF9FUV9MSShidWYuc3RfZ2lkLCAwKTsKPiAgIAo+ICAgCVNBRkVfVU5MSU5LKFRFTVBf
Tk9ERSk7Cj4gLQlTQUZFX0NIRElSKCIuLiIpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
