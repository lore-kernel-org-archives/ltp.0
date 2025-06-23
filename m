Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E750C77B7C
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750700606; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Z9eMUMAWtuFS0hYetlo8VGYfmYgJcMyhJfsLbhD4u38=;
 b=bZZuJvoDiSol4wUkVPzw6rh5HB9L3zkCJVWAKFp5VTkesfUm+pxOlwbgofmv37YsJ1BII
 mzJ4FBrUspGwtx2DH+g1T7kKbDT6wTshaZllXHEkyfo5y3hTMx4OQSSbUaw7+NawbUxxMST
 Jz1CqJfpUx+nG3ytdffSfSdUvOetCtk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C0B23CCA86
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 19:43:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F353C9982
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:43:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9045D600803
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 19:43:04 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so2209715f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750700584; x=1751305384; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5HRRgrsRKvPTNAl3uuhefewQWla904TPadJ9FWSBv0=;
 b=e7c66F6oO1rE5Lu1frlwBrYiJP4erPE/AIBIlzMFKJYu4C0+4oOQ5brfSo/QtXT4Yt
 yVvNzxqdZPwOjoJ9MCBcSL1NSAns7Ennr5OSOqf7Q7hOPpCO6GpoTwsHA1in56x1kIxs
 bLQn3H0ntBXxw6uVhbTkzhWKwuc61ybVFtmS071xQOKQcmef0u7iuQ+6hp6Y44IYkQbi
 ZzH/xp3i4OcT6IF9njqhFcINq/RcvJdGTb6/cnF+Op+7RMPZr1msf9u6vwsKq6XLSGyo
 /Fvh9Af9n6cMFoR4DfpYrlskjwv6OQgDd3OrqmHfP3MKk+z8zCyvzbl80KKZ/ighPJ51
 xI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700584; x=1751305384;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M5HRRgrsRKvPTNAl3uuhefewQWla904TPadJ9FWSBv0=;
 b=n/4qA+juaOuNCPeCBDLeiig5HZDtd3EacB/XhlQWL74uIMw1vKKK9uZRg06Ulp36RT
 4yisb3Do0jEVYd+ReKslZ2AMtGImzKTy02N+bOa7goZ+t+TEwp6G6FTiDVZqDqgUrLTG
 g8EEfA5jI/qw8lfGaeOClMCXRXsF/Swu52n4e+uSh4s/XpKhLuRYS8xL7q3MqzZo4HYL
 PWiaCiqOrCTOhNBS5XqG0AMTtMtWT6JcBYH9l9m2Ix+ygsP0XoXsME90Y1M+YCp6R9QZ
 U1dPds14ljndpOGmy1kDnyw1Vi922NMluZGseRP1wjLv5+uSxr/1TXUY7jZQx2m5t6ek
 5Y3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3wmyj2eV+FrzKEk70KgKTpFdsmRPDiLd28OdHoSECa+YjsWSNfLUo8wajRFhj4XHEUJc=@lists.linux.it
X-Gm-Message-State: AOJu0YwqwtObIZ0hynQHZV7LFIxDG3ZV4I60kKr6YEteTaMmTqYSWxA6
 USOnh2pKeWYcwQBI+y/CMoZPZMQYRR5w0bb3JWwRwC01b3rO9SdChIBWTMJZ2+jUL+zKCEnQ91W
 xS07M
X-Gm-Gg: ASbGncu5CnGP8Ss6RW5h2t6N21ICV5NH8gZACTtPz3prODIgH5V8C0iLwGmVM79lfUf
 Al0HXy51gUt2bhB+2aYoyyKv+AYvUfNK0y9J9Tm78VJZv4XsIpwC8lc+kl3GALr5nWedH/NQSO/
 c50GcxxM2BdjHqpSvMiBgoYOs7eMyq0o2BwAwv1kDhtf7ggpjTkBD2BSLl32rVZWosNTFHWTqtU
 A1SCVplfh5TL9ECZuXJ3e4wWzXCKxH/1G7Q1OJd1ZBeZ4PMALk3JOWvOulQH7IanKMVyZpExfj+
 nWr8I8U19vwj1Sc6xoNy+wUfr/WyUOfWTTEYlpsILv2fnnx/fw==
X-Google-Smtp-Source: AGHT+IHwa4GpCZUrlvf4p5aY0r/s8CMEbdbeV+dca8CSuTEzjYj18zlngLjBiyzcFAI2KmHq00wIag==
X-Received: by 2002:a05:6000:4a09:b0:3a5:2208:41d9 with SMTP id
 ffacd0b85a97d-3a6d12e074emr10479587f8f.40.1750700583960; 
 Mon, 23 Jun 2025 10:43:03 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3159e0856bcsm8493040a91.49.2025.06.23.10.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:43:03 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 23 Jun 2025 14:42:58 -0300
Message-Id: <DAU3K6ZFMKSW.3102SXZ34WY5B@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250623-conversions-shmt-v4-1-5d877da3ecea@suse.com>
 <ec0768c5-f313-4e86-b79d-033bccf0c4f6@suse.com>
In-Reply-To: <ec0768c5-f313-4e86-b79d-033bccf0c4f6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mem: Convert shmt02 to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1biAyMywgMjAyNSBhdCAyOjM4IFBNIC0wMywgQW5kcmVhIENlcnZlc2F0byB3cm90
ZToKPiBIaSEKPgo+IE1lcmdlZCB3aXRoIGEgc21hbGwgY2hhbmdlIGJlY2F1c2UgSSByZWFsaXpl
ZCBteSBzdWdnZXN0aW9uIHRvIHVzZSAKPiBUU1RfRVhQX0VRX1NUUk4oKSB3YXMgbm90IG1hdGNo
aW5nIExUUCBzdGFuZGFyZHMgKGRhdGEgIT0gc3RyaW5ncykuCj4KPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vc2htdC9zaG10MDIuYyAKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L3NobXQvc2htdDAyLmMKPiBpbmRleCAwMjAwNzRkM2UuLjE2ZDk5YWM3YSAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3NobXQwMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9tZW0vc2htdC9zaG10MDIuYwo+IEBAIC0zNCw3ICszNCwxMiBAQCBzdGF0aWMgdm9pZCBy
dW4odm9pZCkKPgo+ICDCoMKgwqDCoMKgwqDCoCBTQUZFX1NITUNUTChzaG1pZCwgSVBDX1JNSUQs
IE5VTEwpOwo+Cj4gLcKgwqDCoMKgwqDCoCBUU1RfRVhQX0VRX1NUUk4oY3AsIHRzdF9yYW5kX2Rh
dGEsIFNITVNJWkUpOwo+ICvCoMKgwqDCoMKgwqAgaWYgKG1lbWNtcChjcCwgdHN0X3JhbmRfZGF0
YSwgU0hNU0laRSkgIT0gMCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRzdF9y
ZXMoVEZBSUwsICJDb3BpZWQgZGF0YSBjaGFuZ2VkIGFmdGVyIElQQ19STUlEIik7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ICvCoMKgwqDCoMKgwqAgfQo+ICsKPiAr
wqDCoMKgwqDCoMKgIHRzdF9yZXMoVFBBU1MsICJDb3BpZWQgZGF0YSBoYXMgYmVlbiByZWFkIGJh
Y2siKTsKCkFoLCBpbmRlZWQuIFRoYW5rIHlvdSEKCj4gIMKgfQo+Cj4gIMKgc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0gewo+Cj4gLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
