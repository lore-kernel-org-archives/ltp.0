Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E1C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 06:42:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58223D213B
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 08:42:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B2AA3D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:41:55 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A829C6008C3
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723617712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQdUOpwpcL0Qh9OxAkJMAe0moM4UAiUeseJYhKX5+vw=;
 b=TDEozlNDtUZcRdr9iJI/wo2vprrbDea0RaWyJWLuSbL0Yp4sV9nDNZNQCYq/nvSa0ngLJZ
 19e/04Ko/gfT4puIFy6n205QAvpfczUMtslz6Z+vnBws7i60FbHfIoIWXXfSyNFQVcMtpO
 BUFTvHk1UCIFrI6mIgzONjnyid57vvQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-DixIh2xINpSnaLd0tpYJ2w-1; Wed, 14 Aug 2024 02:41:50 -0400
X-MC-Unique: DixIh2xINpSnaLd0tpYJ2w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6886cd07673so146100787b3.3
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 23:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723617710; x=1724222510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQdUOpwpcL0Qh9OxAkJMAe0moM4UAiUeseJYhKX5+vw=;
 b=tQqE02Zab23y+GJlCIMRrDi2bCpR39dCE89WRi3f0WAQUxhl8f/62WK0aaq6+3HKPA
 nyNJyW9+TZ1BIfbbE0r/uAegU05aWCNDOLzI0maOvvBvNPJe1usV7rEI3g/8SRBFTDIv
 ksAyBXX9uighdU5fulb9VcK+g+I5QcCrNCktn6gSpVDT1nX2GgWqIBpD/Z8V9zxEclqf
 /XoGFmvxqGkt3L9WboM3BHJfmqBztLDZ6P0r0K6MtJDp45C/ets/ouSmU8P78VdTARCP
 GNNV8AY4+w0t+wpxq0DZLFt5yE6dF/H4B/Vf6UTwqCfecVHLHgqDEH3wVzzDHfz2Ew5a
 aDgw==
X-Gm-Message-State: AOJu0YyYGP6JXH7SUTl2KedG7HdVpp84tK1jyrdKu3AdqJ5e/FT/6RXO
 beLlel9o/xKbkv19j0GecAJnauZODWaDX/5KhQUc8p9IMU/NuUIBATWFou9EYmWiDofloShlB+x
 Gie+vdVCJnRWfW+1N1oD+vln5s+JMSBAyLkTkqvVgPseiN4vkE72VUBQh9VG9eA8eS7WDbo9B7v
 JBkLqUELohF8fqOxcPCl9B+Xw=
X-Received: by 2002:a05:690c:2a93:b0:664:c541:60e5 with SMTP id
 00721157ae682-6ac99eb04f8mr16308067b3.36.1723617710272; 
 Tue, 13 Aug 2024 23:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0ngWNCOjJb6ZVTs2I6uqIOQ52UTKkXC6mav1q0XjM5MO7vZS+XygsXew/5GcJ5yO7qlq0+OFOOUKBm5NvU9Y=
X-Received: by 2002:a05:690c:2a93:b0:664:c541:60e5 with SMTP id
 00721157ae682-6ac99eb04f8mr16308017b3.36.1723617709977; Tue, 13 Aug 2024
 23:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
In-Reply-To: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Aug 2024 14:41:37 +0800
Message-ID: <CAEemH2fMVJ6KCZoFOp=aj28JFB62aE0Bfpixm1E=XGZbact-eQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/execve04,
 creat07: skip for kernels 6.11 and later
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

T24gTW9uLCBBdWcgMTIsIDIwMjQgYXQgNjozMuKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gVGhlIGJlaGF2aW91ciBpcyBhbGxvd2VkIHNpbmNlIGNvbW1p
dDoKPiAgIDJhMDEwYzQxMjg1MyAoImZzOiBkb24ndCBibG9jayBpX3dyaXRlY291bnQgZHVyaW5n
IGV4ZWMiKQo+IHRoYXQgbGFuZGVkIGluIDYuMTEtcmMxLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NyZWF0
L2NyZWF0MDcuYyAgIHwgMTAgKysrKysrKysrKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2V4ZWN2ZS9leGVjdmUwNC5jIHwgMTAgKysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2NyZWF0L2NyZWF0MDcuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jcmVhdC9jcmVh
dDA3LmMKPiBpbmRleCA3YmQzMmFiNGQzMjguLmYxNTdlMWE4ZmJiMiAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NyZWF0L2NyZWF0MDcuYwo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvY3JlYXQvY3JlYXQwNy5jCj4gQEAgLTQ3LDcgKzQ3LDE3IEBAIHN0
YXRpYyB2b2lkIHZlcmlmeV9jcmVhdCh2b2lkKQo+ICAgICAgICAgU0FGRV9XQUlUUElEKHBpZCwg
TlVMTCwgMCk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKyAgICAg
ICBpZiAoKHRzdF9rdmVyY21wKDYsIDExLCAwKSkgPj0gMCkgewo+ICsgICAgICAgICAgICAgICB0
c3RfYnJrKFRDT05GLCAiU2tpcHBpbmcgdGVzdCwgd3JpdGUgdG8gZXhlY3V0ZWQgZmlsZSBpcyAi
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgImFsbG93ZWQgc2luY2UgNi4xMS1yYzEuXG4iCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgIjJhMDEwYzQxMjg1MyAoXCJmczogZG9uJ3QgYmxvY2sg
aV93cml0ZWNvdW50Cj4gZHVyaW5nIGV4ZWNcIikiKTsKPiArICAgICAgIH0KPiArfQo+ICsKPiAg
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsgICAgICAgLnNldHVwID0gc2V0dXAs
Cj4gICAgICAgICAudGVzdF9hbGwgPSB2ZXJpZnlfY3JlYXQsCj4gICAgICAgICAubmVlZHNfY2hl
Y2twb2ludHMgPSAxLAo+ICAgICAgICAgLmZvcmtzX2NoaWxkID0gMSwKPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9leGVjdmUvZXhlY3ZlMDQuYwo+IGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9leGVjdmUvZXhlY3ZlMDQuYwo+IGluZGV4IDNiYWM2NDJlNTQxMi4u
N2JiZmVjZTg1OTA2IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXhl
Y3ZlL2V4ZWN2ZTA0LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V4ZWN2ZS9l
eGVjdmUwNC5jCj4gQEAgLTY1LDcgKzY1LDE3IEBAIHN0YXRpYyB2b2lkIGRvX2NoaWxkKHZvaWQp
Cj4gICAgICAgICBleGl0KDApOwo+ICB9Cj4KPiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAr
ewo+ICsgICAgICAgaWYgKCh0c3Rfa3ZlcmNtcCg2LCAxMSwgMCkpID49IDApIHsKPiArICAgICAg
ICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlNraXBwaW5nIHRlc3QsIHdyaXRlIHRvIGV4ZWN1dGVk
IGZpbGUgaXMgIgo+ICsgICAgICAgICAgICAgICAgICAgICAgICJhbGxvd2VkIHNpbmNlIDYuMTEt
cmMxLlxuIgo+ICsgICAgICAgICAgICAgICAgICAgICAgICIyYTAxMGM0MTI4NTMgKFwiZnM6IGRv
bid0IGJsb2NrIGlfd3JpdGVjb3VudAo+IGR1cmluZyBleGVjXCIpIik7Cj4gKyAgICAgICB9Cj4g
K30KPiArCj4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiArICAgICAgIC5zZXR1
cCA9IHNldHVwLAo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X2V4ZWN2ZSwKPiAgICAgICAg
IC5mb3Jrc19jaGlsZCA9IDEsCj4gICAgICAgICAuY2hpbGRfbmVlZHNfcmVpbml0ID0gMSwKPiAt
LQo+IDIuNDMuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
