Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E68C30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:12:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474623D3CC4
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:12:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC9053D3CC4
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:12:07 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E332A1416ED7
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720077125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cEtfv4LAniOpUvQSNwiyX8JtrRvGXhdj26mDd4AtKgE=;
 b=dWZLPopDDXqzInEQO4OsqTY+/7rLr12IzRvD9P7aZLhatFo2ORmgrcenEbbGW5simkduBe
 ijhd8BJPIVld1zUddJMjIk+Q5yFmbCj0J3Y9inJAhgEQXAM/FhKwFBTBrf/JiU+OPHN2Ff
 9Eb4vWLeiooXOW6Oej4hBXVjGLRzm+s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-CW5WwuztOjC_Pom9ReFzVQ-1; Thu, 04 Jul 2024 03:12:02 -0400
X-MC-Unique: CW5WwuztOjC_Pom9ReFzVQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c79f32200aso406361a91.1
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077121; x=1720681921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cEtfv4LAniOpUvQSNwiyX8JtrRvGXhdj26mDd4AtKgE=;
 b=cJogUs/cao2WdmN5xauoBoCiZThy80JeVGt2w0MO7cGYl4wteGZGL8HNp8RloM1Cs6
 t4kAXlrfGzp3RgUDR2j1XhqSfGMSsAd5NeKl1SuVUPM52sRxvjcTSWktNtbJibSb+A5c
 ie5vt8vCT8EyF3sauDotjjZwJ//1ztzFL/F9fd0tPSCsSsEbmk9Lm23Tnt6T7w+w1CCV
 Z5TBqLov0Em1OZHr+Oj1LWSt8e6Cd/3LLGfSkzBjf8ZhPVyzqQ/VYJQLBbT6MUGIAxL1
 pMZ1/vcp180yk/z+LLhe3m1yzn77Zd2emga8zh9Zw6BT3Jyi/H9xDFJ/TVMJncvBIAgF
 an1w==
X-Gm-Message-State: AOJu0YxzFSs5r0vSL1t3OI/EK6ahSaCJgVab2l1QSLcwKqIe92HspP3z
 qtUABOwyPBUmWgvea22bZPhBRw4Ut+DpOuTSXLZxNhIVNlwEsMajwnEvuPOr/LV2JJaiK7oDx5T
 KoWUXhEGshfMdOE5zA3Lo1FaX68rk8AsloJNioZdotUlpXbvOmk9vYVD3DPWclRcycSFvBhSWsr
 XJSBWB6lhfvm4sAAaYsWXDfs4uBVk/y1mYIVHs
X-Received: by 2002:a17:90a:17c8:b0:2c9:784b:4a30 with SMTP id
 98e67ed59e1d1-2c99c6b8eadmr637832a91.31.1720077120598; 
 Thu, 04 Jul 2024 00:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYeSCfWuaxlCvL+gIZeZvRZyoKdZXhQT5wgUuT+0rmjJfNv8ZqsjO7iY8cYx/V8YT5OaI2zIbDI63ORWr5j8w=
X-Received: by 2002:a17:90a:17c8:b0:2c9:784b:4a30 with SMTP id
 98e67ed59e1d1-2c99c6b8eadmr637817a91.31.1720077120068; Thu, 04 Jul 2024
 00:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-2-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-2-e27d9953210d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 15:11:48 +0800
Message-ID: <CAEemH2dwnBO+UQKSfXeAsOOog_1_H3qbrKQkUGZCcHNwnnfWpQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/5] Fix TST_EXP_EXTR() stringification
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgMiwgMjAyNCBhdCAxMDoxNeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBGb2xsb3cgdGhlIFRTVF8qIG1hY3JvcyBzdGFu
ZGFyZHMgd2hlbiBpdCBjb21lcyB0byBzdHJpbmdpZmljYXRpb24gb2YKPiB0aGUgZXhwcmVzc2lv
bnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgot
LS0KPiAgaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaCAgICAgICAgICAgICAgIHwgNSArKystLQo+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazA0LmMgfCA2ICsrKy0tLQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oIGIvaW5jbHVkZS90c3RfdGVzdF9tYWNy
b3MuaAo+IGluZGV4IDIyYjM5ZmIxNC4uN2E0NDNjODAzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUv
dHN0X3Rlc3RfbWFjcm9zLmgKPiArKysgYi9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oCj4gQEAg
LTM0MCw4ICszNDAsOSBAQCBjb25zdCBjaGFyICp0c3RfZXJybm9fbmFtZXMoY2hhciAqYnVmLCBj
b25zdCBpbnQKPiAqZXhwX2VycnMsIGludCBleHBfZXJyc19jbnQpOwo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICZ0c3RfZXhwX2Vycl9fLCAxLCAjI19fVkFfQVJHU19fKTsKPiAgICAgIFwKPiAg
ICAgICAgIH0gd2hpbGUgKDApCj4KPiAtI2RlZmluZSBUU1RfRVhQX0VYUFIoRVhQUiwgRk1ULCAu
Li4pCj4gICAgICBcCj4gLSAgICAgICB0c3RfcmVzXyhfX0ZJTEVfXywgX19MSU5FX18sIChFWFBS
KSA/IFRQQVNTIDogVEZBSUwsICJFeHBlY3Q6ICIKPiBGTVQsICMjX19WQV9BUkdTX18pOwo+ICsj
ZGVmaW5lIFRTVF9FWFBfRVhQUihFWFBSLCAuLi4pCj4gICAgIFwKPiArICAgICAgIHRzdF9yZXNf
KF9fRklMRV9fLCBfX0xJTkVfXywgKEVYUFIpID8gVFBBU1MgOiBURkFJTCwgIkV4cGVjdDogIgo+
ICAgIFwKPiArICAgICAgICAgICAgICAgIFRTVF9GTVRfKFRTVF8yXyhkdW1teSwgIyNfX1ZBX0FS
R1NfXywgI0VYUFIpLAo+IF9fVkFfQVJHU19fKSk7Cj4KPiAgI2RlZmluZSBUU1RfRVhQX0VRXyhW
QUxfQSwgU1ZBTF9BLCBWQUxfQiwgU1ZBTF9CLCBUWVBFLCBQRlMpIGRvIHtcCj4gICAgICAgICBU
WVBFIHRzdF90bXBfYV9fID0gVkFMX0E7IFwKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mb3JrL2ZvcmswNC5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zv
cmsvZm9yazA0LmMKPiBpbmRleCBiMGM2YmViZTAuLjQxM2NkNWViNCAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazA0LmMKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazA0LmMKPiBAQCAtMjksNyArMjksNyBAQCBzdGF0aWMg
dm9pZCBydW5fY2hpbGQodm9pZCkKPgo+ICAgICAgICAgVFNUX0VYUF9FWFBSKHN0cmNtcChFTlZf
VkFMMCwgdmFsKSA9PSAwLAo+ICAgICAgICAgICAgICAgICAiJXMgZW52aXJvbiB2YXJpYWJsZSBo
YXMgYmVlbiBpbmhlcml0ZWQgYnkgdGhlIGNoaWxkIiwKPiAtICAgICAgICAgICAgICAgRU5WX0tF
WSkKPiArICAgICAgICAgICAgICAgRU5WX0tFWSk7Cj4KPiAgICAgICAgIHRzdF9yZXMoVElORk8s
ICJVbnNldCAlcyBlbnZpcm9uIHZhcmlhYmxlIGluc2lkZSBjaGlsZCIsIEVOVl9LRVkpOwo+Cj4g
QEAgLTcyLDcgKzcyLDcgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gICAgICAgICB9IGVsc2Ug
ewo+ICAgICAgICAgICAgICAgICBUU1RfRVhQX0VYUFIoc3RyY21wKEVOVl9WQUwwLCB2YWwpID09
IDAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIiVzIGVudmlyb24gdmFyaWFibGUgaXMgc3Rp
bGwgcHJlc2VudCBpbnNpZGUKPiBwYXJlbnQiLAo+IC0gICAgICAgICAgICAgICAgICAgICAgIEVO
Vl9LRVkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgRU5WX0tFWSk7Cj4gICAgICAgICB9Cj4K
PiAgICAgICAgIFRTVF9DSEVDS1BPSU5UX1dBS0VfQU5EX1dBSVQoMCk7Cj4gQEAgLTg1LDcgKzg1
LDcgQEAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gICAgICAgICBlbHNlIHsKPiAgICAgICAgICAg
ICAgICAgVFNUX0VYUF9FWFBSKHN0cmNtcChFTlZfVkFMMCwgdmFsKSA9PSAwLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICIlcyBlbnZpcm9uIHZhcmlhYmxlIGRpZG4ndCBjaGFuZ2UgaW5zaWRl
IHBhcmVudCIsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgRU5WX0tFWSkKPiArICAgICAgICAg
ICAgICAgICAgICAgICBFTlZfS0VZKTsKPiAgICAgICAgIH0KPiAgfQo+Cj4KPiAtLQo+IDIuNDMu
MAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
