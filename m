Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9C8C71157
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 06:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750746273; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=X3XY3WBd4fPtqYQ/xMCz862aeqiISUO9iaq9ElnKJF8=;
 b=GOrp9LFeAo/HP1gl21Y4j3xuzN3I1qwbosZ5zNuiOHZ0X4Ip+40QDLatp+Cp+dQSY9JRd
 UkmUOAOe8jAwtm/q8q+2dgr1dOrmZGqn7yR0PWWBobgW941GdxwgllO9i5rlcmXsjD6ik16
 44PkKnzsuRLe7UaER8L0h4xT17/Ag8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EB943CCAA8
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 08:24:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7CCF3CA334
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 08:24:12 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8C0901A010DF
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 08:24:11 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso24049f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750746251; x=1751351051; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bpvyeEKxnStDx5RKtFDaMG855LCZxOgRH/pTgMDU6Ik=;
 b=XAByYrSRJtnGGuJuoyzlTh/0zrVk/BuYs9XX2aVoDt9YqmGP9+jfOY9WJCrPTcH6Cz
 hlokyZBeWVyBlYk5xX0h1zt+gJN8IPpsoPS32aNn/NuDwUhxMHDCoAfIYbHV/PP4N2I5
 WmsS6stXkDxSkiaD8hxBbMUS2EqoHPXnSKPty3UV8kjj5WhdGaYjEFX41vWosYtWY0oZ
 C1UdsIhxY/EyKR0dGYVGSwUCtgplZA7qZSfFPUsHkwrHFwo9fkbmD48L12GmW9xOjMIU
 bKRdL3FsO+MPTeIPUQBVMHbEDYeZK/N5fH4fyLoc4ZYv5rO7bapanYAARmvvbQ1FYmQQ
 NWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750746251; x=1751351051;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bpvyeEKxnStDx5RKtFDaMG855LCZxOgRH/pTgMDU6Ik=;
 b=UzWxSVnbofaoEMeM8fsXaUROsZblcJuPCGzOjEZxzAvv4iC4P1cBq/LnwT9heOI3NY
 0dtKu/XS/E5+vM8LNxJLJ0aAAJjGFM8TZLXadxLOzgooVt5dNBeH9qZNtPF4IfjAyeA3
 OSWNtWLIW4paJeqBvabeayMAGDsIqokoHOuGKTNdPV7AD7WhTIj0Obi2X7gCOudoF6wt
 1pY4aX9ulkKF+2oJC4eqcKRPPmu4DZlC+pTXZ0Y+dJyh8Nloet7XYJMvggnJP0HGCfd2
 +fjPraxrpFd8qUrZ+bNSH2fVNPK0YCQk0ILyL8ZwQzaW2ZndIPDc6yXhaG9Rl127oD0s
 N03w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPsNJqQ+6pzSCbuocMeER4YeUiZMYpmuGKiAdB3b2DEh7nreRaBAIB41eS+L0H1ykVMY0=@lists.linux.it
X-Gm-Message-State: AOJu0YwgHcUpDoWq985Yk76J+wOfKgJgFFtAVf7jum5J3trap3HFRenh
 zaL5M+QdbAMpafCzlUFcpm2287gnr6uZYUur2uQrIMtQj7VSVYd0dW9AQMzbi61cxw==
X-Gm-Gg: ASbGncsZNbc4xTvFb1LELlBYpOs6YLg2oYuzDiRHqDGMPylT7wap513kH+71zcq3CX5
 E+A6A1HYeoEM1dAhQeiArRAZP6z+4dxcmdwUnSX7B6MwYIwIkxLljVCMOUy2oZIQMQFlz/oL6Hl
 Uy6Hew0BBhmmCmUp8ZFEDvrCeLQlygJsS6tBXWj24LVWH03Zj6sUsd891y0AScM068LwVisglFP
 u4V8LS4zdme2bGt/LygDFhDbERhSVRW/uCgWUok8UZq1TSox2amIdT08FYehEUcaK2+fYjzdRJa
 4vEvemuR+KgXQCaG3AS0HNIABlAM24+Uo0MiNBO7xUg1YpAALnPLbpa5sKlWMw==
X-Google-Smtp-Source: AGHT+IH0OQ1fkaywwI91t6In68NEiF+foggSD/OlYsh1ETxDNJo6K2OZXtjJOBSs7FlD+X/yic4SfA==
X-Received: by 2002:a05:6000:4284:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a6d13315c2mr13333136f8f.56.1750746250843; 
 Mon, 23 Jun 2025 23:24:10 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83cdf90sm99452345ad.62.2025.06.23.23.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 23:24:10 -0700 (PDT)
Date: Tue, 24 Jun 2025 14:23:40 -0400
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <aFrtLNvHWhm6jGGf@MiWiFi-CR6608-srv>
References: <20250623073717.338178-1-amir73il@gmail.com>
 <aFrUhlpMX-MmUIDg@MiWiFi-CR6608-srv>
 <CAOQ4uxjjb7MsUJzfWsEQbKhbdraownkhaZL41zJi3yxeyNN3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjb7MsUJzfWsEQbKhbdraownkhaZL41zJi3yxeyNN3qg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10,
 fanotify23: fix cleanup of vfs_cache_pressure
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMjQsIDIwMjUgYXQgMDc6NDE6NDZBTSArMDIwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6Cj4gT24gVHVlLCBKdW4gMjQsIDIwMjUgYXQgNjozOeKAr0FNIFdlaSBHYW8gPHdlZ2Fv
QHN1c2UuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEp1biAyMywgMjAyNSBhdCAwOTozNzox
N0FNICswMjAwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiA+ID4gQXZvaWQgc2V0dGluZyB2ZnNf
Y2FjaGVfcHJlc3N1cmUgdG8gemVybyBpZiB0ZXN0IHdhcyBub3QgcnVuCj4gPiA+IGJlY2F1c2Ug
a2VybmVsIGRvZXMgbm90IHN1cHBvcnQgZmFub3RpZnkuCj4gPiA+Cj4gPiA+IFJlcG9ydGVkLWJ5
OiBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4KPiA+ID4gTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDI1MDYyMjIxNTE0MC5HWDE4ODA4NDdAWmVu
SVYvCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+Cj4gPiA+IC0tLQo+ID4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTEwLmMgfCA4ICsrKystLS0tCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYyB8IDggKysrKy0tLS0KPiA+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTAuYwo+ID4gPiBpbmRleCBj
Y2I0ZjU1ZGYuLjJkMzM0MTZmMyAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMKPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMKPiA+ID4gQEAgLTEwMiw3ICsxMDIsNiBA
QCBzdGF0aWMgaW50IGlnbm9yZV9tYXJrX3Vuc3VwcG9ydGVkOwo+ID4gPiAgI2RlZmluZSBEUk9Q
X0NBQ0hFU19GSUxFICIvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXMiCj4gPiA+ICAjZGVmaW5lIENB
Q0hFX1BSRVNTVVJFX0ZJTEUgIi9wcm9jL3N5cy92bS92ZnNfY2FjaGVfcHJlc3N1cmUiCj4gPiA+
Cj4gPiA+IC1zdGF0aWMgaW50IG9sZF9jYWNoZV9wcmVzc3VyZTsKPiA+ID4gIHN0YXRpYyBwaWRf
dCBjaGlsZF9waWQ7Cj4gPiA+ICBzdGF0aWMgaW50IGJpbmRfbW91bnRfY3JlYXRlZDsKPiA+ID4g
IHN0YXRpYyB1bnNpZ25lZCBpbnQgbnVtX2NsYXNzZXMgPSBOVU1fQ0xBU1NFUzsKPiA+ID4gQEAg
LTkyNSw3ICs5MjQsNiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gPiAgICAgICBTQUZF
X01LRElSKE1OVDJfUEFUSCwgMDc1NSk7Cj4gPiA+ICAgICAgIG1vdW50X2N5Y2xlKCk7Cj4gPiA+
Cj4gPiA+IC0gICAgIFNBRkVfRklMRV9TQ0FORihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiJWQiLCAm
b2xkX2NhY2hlX3ByZXNzdXJlKTsKPiA+ID4gICAgICAgLyogU2V0IGhpZ2ggcHJpb3JpdHkgZm9y
IGV2aWN0aW5nIGlub2RlcyAqLwo+ID4gPiAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKENBQ0hFX1BS
RVNTVVJFX0ZJTEUsICI1MDAiKTsKPiA+ID4gIH0KPiA+ID4gQEAgLTkzOSw4ICs5MzcsNiBAQCBz
dGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiA+ICAgICAgIGlmIChiaW5kX21vdW50X2NyZWF0
ZWQpCj4gPiA+ICAgICAgICAgICAgICAgU0FGRV9VTU9VTlQoTU5UMl9QQVRIKTsKPiA+ID4KPiA+
ID4gLSAgICAgU0FGRV9GSUxFX1BSSU5URihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiJWQiLCBvbGRf
Y2FjaGVfcHJlc3N1cmUpOwo+ID4gPiAtCj4gPiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBtYXhf
ZmlsZV9tdWx0aTsgaSsrKSB7Cj4gPiA+ICAgICAgICAgICAgICAgY2hhciBwYXRoW1BBVEhfTUFY
XTsKPiA+ID4KPiA+ID4gQEAgLTk3Miw2ICs5NjgsMTAgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVz
dCB0ZXN0ID0gewo+ID4gPiAgICAgICAgICAgICAgIFRFU1RfQVBQLAo+ID4gPiAgICAgICAgICAg
ICAgIE5VTEwKPiA+ID4gICAgICAgfSwKPiA+ID4gKyAgICAgLnNhdmVfcmVzdG9yZSA9IChjb25z
dCBzdHJ1Y3QgdHN0X3BhdGhfdmFsW10pIHsKPiA+ID4gKyAgICAgICAgICAgICB7Q0FDSEVfUFJF
U1NVUkVfRklMRSwgTlVMTCwgVFNUX1NSX1RDT05GfSwKPiA+ID4gKyAgICAgICAgICAgICB7fQo+
ID4gPiArICAgICB9LAo+ID4gPiAgICAgICAudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3RhZ1td
KSB7Cj4gPiA+ICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiOWJkZGE0ZTljZjJkIn0sCj4g
PiA+ICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiMmYwMmZkM2ZhMTNlIn0sCj4gPiA+IGRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gPiA+
IGluZGV4IDI2YzllODdmYi4uMzZjNzc3OWRhIDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+ID4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+ID4gPiBAQCAtMzUsNyAr
MzUsNiBAQAo+ID4gPiAgI2RlZmluZSBEUk9QX0NBQ0hFU19GSUxFICIvcHJvYy9zeXMvdm0vZHJv
cF9jYWNoZXMiCj4gPiA+ICAjZGVmaW5lIENBQ0hFX1BSRVNTVVJFX0ZJTEUgIi9wcm9jL3N5cy92
bS92ZnNfY2FjaGVfcHJlc3N1cmUiCj4gPiA+Cj4gPiA+IC1zdGF0aWMgaW50IG9sZF9jYWNoZV9w
cmVzc3VyZTsKPiA+ID4gIHN0YXRpYyBpbnQgZmRfbm90aWZ5Owo+ID4gPgo+ID4gPiAgc3RhdGlj
IHVuc2lnbmVkIGxvbmcgbG9uZyBldmVudF9zZXRbRVZFTlRfTUFYXTsKPiA+ID4gQEAgLTIzNCw3
ICsyMzMsNiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFOX01BUktfRklMRVNZU1RFTSwKPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZBTl9BVFRSSUIs
IE1PVU5UX1BBVEgpOwo+ID4gPgo+ID4gPiAtICAgICBTQUZFX0ZJTEVfU0NBTkYoQ0FDSEVfUFJF
U1NVUkVfRklMRSwgIiVkIiwgJm9sZF9jYWNoZV9wcmVzc3VyZSk7Cj4gPiA+ICAgICAgIC8qIFNl
dCBoaWdoIHByaW9yaXR5IGZvciBldmljdGluZyBpbm9kZXMgKi8KPiA+ID4gICAgICAgU0FGRV9G
SUxFX1BSSU5URihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiNTAwIik7Cj4gPiA+ICB9Cj4gPiA+IEBA
IC0yNDMsOCArMjQxLDYgQEAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ID4gPiAgewo+ID4g
PiAgICAgICBpZiAoZmRfbm90aWZ5ID4gMCkKPiA+ID4gICAgICAgICAgICAgICBTQUZFX0NMT1NF
KGZkX25vdGlmeSk7Cj4gPiA+IC0KPiA+ID4gLSAgICAgU0FGRV9GSUxFX1BSSU5URihDQUNIRV9Q
UkVTU1VSRV9GSUxFLCAiJWQiLCBvbGRfY2FjaGVfcHJlc3N1cmUpOwo+ID4gPiAgfQo+ID4gPgo+
ID4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiBAQCAtMjU5LDYgKzI1
NSwxMCBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiA+ICAgICAgICAgICAg
ICAgey50eXBlID0gImV4dDIifSwKPiA+ID4gICAgICAgICAgICAgICB7fQo+ID4gPiAgICAgICB9
LAo+ID4gPiArICAgICAuc2F2ZV9yZXN0b3JlID0gKGNvbnN0IHN0cnVjdCB0c3RfcGF0aF92YWxb
XSkgewo+ID4gPiArICAgICAgICAgICAgIHtDQUNIRV9QUkVTU1VSRV9GSUxFLCBOVUxMLCBUU1Rf
U1JfVENPTkZ9LAo+ID4gPiArICAgICAgICAgICAgIHt9Cj4gPiA+ICsgICAgIH0sCj4gPiA+ICB9
Owo+ID4gPgo+ID4gPiAgI2Vsc2UKPiA+ID4gLS0KPiA+ID4gMi40My4wCj4gPgo+ID4gRm9yIG1l
IHRoaXMgcGF0Y2ggbW9yZSBsb29rcyBsaWtlIGFuIGltcHJvdmVtZW50IGluc3RlYWQgb2YgYSBm
aXguCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guCj4gPgo+IAo+IEl0IGlzIGEgZml4IHRvIHRo
ZSBwcm9ibGVtIHJlcG9ydGVkIGJ5IEFsIFZpcm8gaW4gdGhlIGxpbmtlZCBtZXNzYWdlLgpUaGFu
a3MsIGFmdGVyIGNoZWNrIGVtYWlsIGNhcmVmdWxseSwgaSBndWVzcyB0aGUgdGhlIHRlc3Qgc2tp
cCBpbml0aWFsCm9sZF9jYWNoZV9wcmVzc3VyZSBpbiBzZXR1cCBidXQgZG8gd2lydGUgMCB0byBv
bGRfY2FjaGVfcHJlc3N1cmUgaW4KY2xlYW51cCB0cmlnZ2VyIHRoZSBpc3N1ZS4KPiAKPiBUaGFu
a3MsCj4gQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
