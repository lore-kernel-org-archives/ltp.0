Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A767C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 06:51:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E6153D1AB8
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:51:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EA473D0CCC
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 08:50:44 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2ECDC1000224
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 08:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721199040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kKagqoNnCq/Hft9nXeOvYpEjUl3hpmrO5kej4XmyrZQ=;
 b=cxX1gm0tgxoAGwg+wBOePA+xPoZdUAOBCjRlS5zwnBbwwilzTRVh49ngoul2dpeUiAVxsB
 MRfuul7vpnyQrSdFOSxjMb7LEKqDDqdxvhcaNvekHJwWAW3M4JaziK/2CMw7rA/e0Vk5r0
 sq/LQfTcpMUA9qBFn2lNX49vWlmBgW8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-86VZGeQGPtaTOP9H90h49A-1; Wed, 17 Jul 2024 02:50:37 -0400
X-MC-Unique: 86VZGeQGPtaTOP9H90h49A-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-79455e21c82so1960233a12.1
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 23:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721199035; x=1721803835;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKagqoNnCq/Hft9nXeOvYpEjUl3hpmrO5kej4XmyrZQ=;
 b=Pz4QGz6D6j6WzBQkd132HmELjnRJYZ33/QocOvSZ83xHhv1/7cOzprr2WE/lzkyerR
 Ic/Xd6Al0+55mS2QLfgv1gMqi2Co/xRqppwb2TVPHY79Y04tBpY70oN+2fQMsxlt1NV7
 WVOSdqg2VtARJ7QzKHb6LhwqtpPZApuIdndKdOXG2Lx912DTQBY4wYbgCbex3GfdgzRe
 dy7CJo3S8ATFi0jsGl+dVRUPTP2MZ3ueOYoGsiXze8ShsWkpPsuct8UD2mmYu/40TEkS
 LfbbksiuwTp5oO1/pQFrzMhj+5rJHBeT5/svxSiACtfRg19qHt2SPH9evUk2UVVIuPId
 ngzQ==
X-Gm-Message-State: AOJu0YxP1mv2RWIk9mbHIIxo0hyciq7qyBYd2vWTBLtyw7DTdehyeoR8
 jd+cUKmWH2Lyjz/7+3wKZ9iPo1X9Iv4EARfTvXRgC/EULqupelE9bqjfXs4N7z+01PSXM/cgVwg
 +FlmoOkjOrg7JTqis84jpfXMuEA3fIY3vHOJGilOitoFYIdJhBGtJWHw6Fy0KEfpqHlyLXcGa9m
 Lzh713HnkfGjGf9F4cH2fCR6FN1Irbop16Cw==
X-Received: by 2002:a05:6a20:9190:b0:1c2:8cf4:7664 with SMTP id
 adf61e73a8af0-1c3fdd00827mr1027385637.31.1721199034790; 
 Tue, 16 Jul 2024 23:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaWXoKW5ENml7pkj85+2DhRj7whAqzUU1xvYi71HxS7LZAmW/JXJUy88ie28T0/AG1CMayS9F3wDjD1u6TcAY=
X-Received: by 2002:a05:6a20:9190:b0:1c2:8cf4:7664 with SMTP id
 adf61e73a8af0-1c3fdd00827mr1027370637.31.1721199034241; Tue, 16 Jul 2024
 23:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240705031502.9041-1-liwang@redhat.com>
In-Reply-To: <20240705031502.9041-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2024 14:50:21 +0800
Message-ID: <CAEemH2cHK_DMKJ6wPVb0P==CgEvmCsPQLMH=+BytNUpWT=_FFQ@mail.gmail.com>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsIEFsbCwKCkFueSBjb21tZW50cyBvbiB0aGlzIG1ldGhvZD8KCk9uIEZyaSwgSnVs
IDUsIDIwMjQgYXQgMTE6MTXigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6
Cgo+IFRoZSBnb2FsIGlzIHRvIGFkZCBtb3JlIHJvYnVzdCBtZW1vcnkgbGVhayBkZXRlY3Rpb24g
YnkgcGVyaW9kaWNhbGx5Cj4gc2FtcGxpbmcgbWVtb3J5IGF2YWlsYWJpbGl0eSBkdXJpbmcgdGhl
IHRlc3QgcnVuIGFuZCBjaGVja2luZyBmb3IKPiBzaWduaWZpY2FudCBkZWNyZWFzZXMgaW4gYXZh
aWxhYmxlIG1lbW9yeS4KPgo+IFRvIGF2b2lkIGZhbHNlIHBvc3RpdmU6Cj4gICBwZXJmX2V2ZW50
X29wZW4wMy5jOjk1OiBURkFJTDogTGlrZWx5IGtlcm5lbCBtZW1vcnkgbGVhayBkZXRlY3RlZAo+
Cj4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gLS0tCj4gIC4u
Li9wZXJmX2V2ZW50X29wZW4vcGVyZl9ldmVudF9vcGVuMDMuYyAgICAgICB8IDMyICsrKysrKysr
KysrKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wZXJmX2V2
ZW50X29wZW4vcGVyZl9ldmVudF9vcGVuMDMuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9wZXJmX2V2ZW50X29wZW4vcGVyZl9ldmVudF9vcGVuMDMuYwo+IGluZGV4IDdkZDMxZDNkMi4u
MWFhYjQzZTgyIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGVyZl9l
dmVudF9vcGVuL3BlcmZfZXZlbnRfb3BlbjAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL3BlcmZfZXZlbnRfb3Blbi9wZXJmX2V2ZW50X29wZW4wMy5jCj4gQEAgLTI2LDYgKzI2
LDcgQEAKPiAgY29uc3QgaW50IGl0ZXJhdGlvbnMgPSAxMjAwMDAwMDsKPiAgc3RhdGljIGludCBm
ZCA9IC0xOwo+ICBzdGF0aWMgaW50IHJ1bnRpbWU7Cj4gK3N0YXRpYyBpbnQgc2FtcGxlOwo+Cj4g
IHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiBAQCAtNzcsMjIgKzc4LDQxIEBAIHN0YXRp
YyB2b2lkIGNoZWNrX3Byb2dyZXNzKGludCBpKQo+Cj4gIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+
ICB7Cj4gLSAgICAgICBsb25nIGRpZmY7Cj4gKyAgICAgICBsb25nIGRpZmYsIGRpZmZfdG90YWws
IG1lbV9hdmFpbCwgbWVtX2F2YWlsX3ByZXY7Cj4gICAgICAgICBpbnQgaTsKPgo+IC0gICAgICAg
ZGlmZiA9IFNBRkVfUkVBRF9NRU1JTkZPKCJNZW1BdmFpbGFibGU6Iik7Cj4gKyAgICAgICBzYW1w
bGUgPSAwOwo+ICsgICAgICAgZGlmZl90b3RhbCA9IDA7Cj4gKwo+ICsgICAgICAgbWVtX2F2YWls
X3ByZXYgPSBTQUZFX1JFQURfTUVNSU5GTygiTWVtQXZhaWxhYmxlOiIpOwo+ICAgICAgICAgdHN0
X3RpbWVyX3N0YXJ0KENMT0NLX01PTk9UT05JQyk7Cj4KPiAgICAgICAgIC8qIGxlYWsgYWJvdXQg
MTAwTUIgb2YgUkFNICovCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaXRlcmF0aW9uczsgaSsr
KSB7Cj4gICAgICAgICAgICAgICAgIGlvY3RsKGZkLCBQRVJGX0VWRU5UX0lPQ19TRVRfRklMVEVS
LCAiZmlsdGVyLDAvMEBhYmNkIik7Cj4gICAgICAgICAgICAgICAgIGNoZWNrX3Byb2dyZXNzKGkp
Owo+IC0gICAgICAgfQo+Cj4gLSAgICAgICBkaWZmIC09IFNBRkVfUkVBRF9NRU1JTkZPKCJNZW1B
dmFpbGFibGU6Iik7Cj4gKyAgICAgICAgICAgICAgIC8qCj4gKyAgICAgICAgICAgICAgICAqIEV2
ZXJ5IDEyMDAwMDAgaXRlcmF0aW9ucywgY2FsY3VsYXRlIHRoZSBkaWZmZXJlbmNlIGluCj4gbWVt
b3J5Cj4gKyAgICAgICAgICAgICAgICAqIGF2YWlsYWJpbGl0eS4gSWYgdGhlIGRpZmZlcmVuY2Ug
aXMgZ3JlYXRlciB0aGFuIDEwICoKPiAxMDI0ICgxME1CKSwKPiArICAgICAgICAgICAgICAgICog
aW5jcmVtZW50IHRoZSBzYW1wbGUgY291bnRlciBhbmQgbG9nIHRoZSBldmVudC4KPiArICAgICAg
ICAgICAgICAgICovCj4gKyAgICAgICAgICAgICAgIGlmICgoaSAlIDEyMDAwMDApID09IDApIHsK
PiArICAgICAgICAgICAgICAgICAgICAgICBtZW1fYXZhaWwgPSBTQUZFX1JFQURfTUVNSU5GTygi
TWVtQXZhaWxhYmxlOiIpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRpZmYgPSBtZW1fYXZh
aWxfcHJldiAtIG1lbV9hdmFpbDsKPiArICAgICAgICAgICAgICAgICAgICAgICBkaWZmX3RvdGFs
ICs9IGRpZmY7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChkaWZmID4gMjAgKiAx
MDI0KSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzYW1wbGUrKzsKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJNZW1BdmFpbGFibGUg
ZGVjcmVhc2VkIGJ5Cj4gJWxkIGtCIGF0IGl0ZXJhdGlvbiAlZCIsIGRpZmYsIGkpOwo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0KPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgbWVtX2F2
YWlsX3ByZXYgPSBtZW1fYXZhaWw7Cj4gKyAgICAgICAgICAgICAgIH0KPiArICAgICAgIH0KPgo+
IC0gICAgICAgaWYgKGRpZmYgPiA1MCAqIDEwMjQpCj4gLSAgICAgICAgICAgICAgIHRzdF9yZXMo
VEZBSUwsICJMaWtlbHkga2VybmVsIG1lbW9yeSBsZWFrIGRldGVjdGVkIik7Cj4gKyAgICAgICBp
ZiAoKHNhbXBsZSA+IDUpIHx8IChkaWZmX3RvdGFsID4gMTAwICogMTAyNCkpCj4gKyAgICAgICAg
ICAgICAgIHRzdF9yZXMoVEZBSUwsICJMaWtlbHkga2VybmVsIG1lbW9yeSBsZWFrIGRldGVjdGVk
LCB0b3RhbAo+IGRlY3JlYXNlOiAlbGQga0IiLCBkaWZmX3RvdGFsKTsKPiAgICAgICAgIGVsc2UK
PiAgICAgICAgICAgICAgICAgdHN0X3JlcyhUUEFTUywgIk5vIG1lbW9yeSBsZWFrIGZvdW5kIik7
Cj4gIH0KPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
