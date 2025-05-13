Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2283AC3ABC9
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 03:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747107890; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0mmLDgJSw8OiYor5DdFkBi/18J9fafltup5li+ymTq0=;
 b=h+ibO18UjNHZYt7KKAurrgObAkVf8V4Hx6AmtpBuVwvI1QOiBNqwAFPHmqgtmyKPfRtpU
 58EyTPJjd153DlnIcbyOhHSzfVyZGyy75caik20hwrfYwnDD+/BFVNHqjVhdxLWA25lBpPD
 ML4cO6vkpKs1iMCTaeA3N5HeMjqfm0Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 105BF3CC2E8
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 05:44:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7C03CB29D
 for <ltp@lists.linux.it>; Tue, 13 May 2025 05:44:29 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B40A060098C
 for <ltp@lists.linux.it>; Tue, 13 May 2025 05:44:28 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a0b6773f8dso4247212f8f.1
 for <ltp@lists.linux.it>; Mon, 12 May 2025 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747107868; x=1747712668; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oEckHm4+Yl8UqEoXnTue5zTY982r/oiR/PFkooWIkkQ=;
 b=awB9ydTHRV/vf/Qvd/RC5NpFeHkaU87LztAD2EsRvrhSE5Wv25aEkD8kgDaHSc6PvL
 3+H+AugC1PJVU4Wp4aO/8LZrP1nkBArfijlkTR5O7NPeSmKxKHPkNT0xwEWu79ViqQF3
 B7UHURqXcTeH7Gp4aEczee0iCb7GV7AZ6xem4RIaYImK3WM1DOkfVX0+n/8l/akAI0ks
 PWBPh0Lc8TTr34QXwuGd2p9DXmnKuefZHukh66FUZkt50tW0M/lUyg7DSBk3uGSMkh9a
 M9GFgktO9xyUSV90Jyac9unUEKyaUfc2nxUUPIBkNm5eTeJjQw43h3W8TUey4VQbJzXU
 N7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747107868; x=1747712668;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEckHm4+Yl8UqEoXnTue5zTY982r/oiR/PFkooWIkkQ=;
 b=I3PZIzsAEEO+dDTmYBu7K3XSKLQ+jfmjrTj2B89+pbbLGoggzTY0YS0BtClahIG0dS
 zNQkNCaPNWXAFxDC55cgU2Rk1OtTerr8ZVR8WlH5K0D24KptX0hhaB6fRVeG4G749c9Z
 iCydKQ0eIPYZa4h3viSYkg6ImiGJdLM/0iQjxUJ7nm7mQfcDVybiMUSrFLTXchnEMJn1
 JK0usSGjSbnnjngSoB5FLXJVJ3dQLW4WD9GNbbZaRKJO9fo6vgF3N9s6+hhV7KmWmmUm
 rKH6vccG27t6uEobnqhLNJuxD2ZtCIFaEaIwLr1m8+0qPtu2FgPxkyqQ3vpgpSKVXHbz
 jhdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBx1Pggz3sIW6FeFQ0rAI/knN9OA/YkBSO6o1yfacrQ35dRkPoWGjqc+UjfrzU0UVIFNE=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+iv9hhAkwzbMmrnPPmvzQDcdpq+It5NLNmitudog0WJlR04xO
 SYS1Nrh6jitZe2/NAx7sIvXjVoK7xjKXyjRTt97EgSP/Y1BBOSJL42ykvombFg==
X-Gm-Gg: ASbGncu3zkVbP1hs3BxqQHoGNJenwxVO0xEjCz0FGyOqhmgvz9MDuj4U60TbkOYknpM
 tLLHyjyG0YPn+Uq1KcVEq1ucSSSA0Xtekpvht8NFnqwT6FfYLUxDKLSyMr78RMf4eu4i+DZV+0H
 3p4TWyVzDg4Fy0zFzefBohHH7Cf/4vecAF4ZH2+6Wc5OmBxwp31tYFVKTyJFlrtj1W/t91QmHEB
 /nj1hgMO2DrV5JMPPrOPOR1pHBM7uky1BLXwdQVXFtV6tCeezIaGetloxtqq/k/bQhWFjiLN9y+
 YB4Z3N4xqJRFBCvPaa3wxVqAE/meCkbvUxY4dL7/jMO/dxZ9F88O21MPtCe7+g==
X-Google-Smtp-Source: AGHT+IH02SfLsocYcTj8igXgsmBx0YY58884CEkGbqj6lSA9rulEbXG1KocLGCCJvsew1U20eVx4Qg==
X-Received: by 2002:a05:6000:4006:b0:39e:cbe3:17c8 with SMTP id
 ffacd0b85a97d-3a1f6427a7emr11638027f8f.12.1747107867849; 
 Mon, 12 May 2025 20:44:27 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828f97asm70268955ad.193.2025.05.12.20.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 20:44:27 -0700 (PDT)
Date: Tue, 13 May 2025 11:44:07 -0400
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgMTA6NDM6NTVBTSArMDIwMCwgSmFuIFN0YW5jZWsgd3Jv
dGU6Cj4gSXMgYW55b25lIGVsc2Ugc2VlaW5nIHRoaXMgdGVzdCBmYWlsaW5nIG9uIHJlY2VudCA2
LjE1LXJjNSBrZXJuZWxzPwo+IAo+ID09PT0gbW1hcDIyID09PT0KPiBjb21tYW5kOiBtbWFwMjIK
PiB0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3RtcC9MVFBfbW1hekNVTE5OIGFzIHRt
cGRpciAodG1wZnMgZmlsZXN5c3RlbSkKPiB0c3RfdGVzdC5jOjE5Mzg6IFRJTkZPOiBMVFAgdmVy
c2lvbjogMjAyNTAxMzAtMjUzLWc0YTBlM2E4ZmEKPiB0c3RfdGVzdC5jOjE5NDI6IFRJTkZPOiBU
ZXN0ZWQga2VybmVsOgo+IDYuMTUuMC0wLnJjNS4yNTA1MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0
OC54ODZfNjQgIzEgU01QCj4gUFJFRU1QVF9EWU5BTUlDIEZyaSBNYXkgIDkgMTU6MTc6MzEgVVRD
IDIwMjUgeDg2XzY0Cj4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNv
bmZpZwo+ICcvbGliL21vZHVsZXMvNi4xNS4wLTAucmM1LjI1MDUwOWc5YzY5Zjg4ODQ5MDQuNDcu
ZWxuMTQ4Lng4Nl82NC9idWlsZC8uY29uZmlnJwo+IHRzdF90ZXN0LmM6MTc1ODogVElORk86IE92
ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDA1bSA1NHMKPiBtbWFwMjIuYzo1NTogVEZBSUw6
IE1BUF9EUk9QUEFCTEUgZGlkIG5vdCBkcm9wIG1lbW9yeSB3aXRoaW4gdGhlIHRpbWVvdXQgcGVy
aW9kLgo+IAoKSSBoYXZlIHRlc3RlZCByYzUvNiBhbmQgYm90aCBnaXZlIHBhc3MgcmVzdWx0LgoK
dW5hbWUgIC1yCjYuMTUuMC1yYzYtZzYyNzI3N2JhN2MyMwogLi9tbWFwMjIKdHN0X3RtcGRpci5j
OjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYUxISks0VCBhcyB0bXBkaXIgKHRtcGZzIGZp
bGVzeXN0ZW0pCnRzdF90ZXN0LmM6MTk0MTogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0y
NTYtZ2I5ODdiOGFjNQp0c3RfdGVzdC5jOjE5NDU6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE1
LjAtcmM2LWc2MjcyNzdiYTdjMjMgIzMgU01QIFBSRUVNUFRfRFlOQU1JQyBUdWUgTWF5IDEzIDEx
OjE1OjM5IEVEVCAyMDI1IHg4Nl82NAp0c3Rfa2NvbmZpZy5jOjcxOiBUSU5GTzogQ291bGRuJ3Qg
bG9jYXRlIGtlcm5lbCBjb25maWchCnRzdF90ZXN0LmM6MTc2MTogVElORk86IE92ZXJhbGwgdGlt
ZW91dCBwZXIgcnVuIGlzIDBoIDAxbSAwMHMKbW1hcDIyLmM6NTk6IFRQQVNTOiBNQVBfRFJPUFBB
QkxFIHRlc3QgcGFzcy4KClN1bW1hcnk6CnBhc3NlZCAgIDEKZmFpbGVkICAgMApicm9rZW4gICAw
CnNraXBwZWQgIDAKd2FybmluZ3MgMAoKCgp1bmFtZSAgLXIKNi4xNS4wLXJjNQogLi9tbWFwMjIK
dHN0X3RtcGRpci5jOjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYXVMbHNtaSBhcyB0bXBk
aXIgKHRtcGZzIGZpbGVzeXN0ZW0pCnRzdF90ZXN0LmM6MTk0MTogVElORk86IExUUCB2ZXJzaW9u
OiAyMDI1MDEzMC0yNTYtZ2I5ODdiOGFjNQp0c3RfdGVzdC5jOjE5NDU6IFRJTkZPOiBUZXN0ZWQg
a2VybmVsOiA2LjE1LjAtcmM1ICM0IFNNUCBQUkVFTVBUX0RZTkFNSUMgVHVlIE1heSAxMyAxMToz
ODoxNCBFRFQgMjAyNSB4ODZfNjQKdHN0X2tjb25maWcuYzo3MTogVElORk86IENvdWxkbid0IGxv
Y2F0ZSBrZXJuZWwgY29uZmlnIQp0c3RfdGVzdC5jOjE3NjE6IFRJTkZPOiBPdmVyYWxsIHRpbWVv
dXQgcGVyIHJ1biBpcyAwaCAwMW0gMDBzCm1tYXAyMi5jOjU5OiBUUEFTUzogTUFQX0RST1BQQUJM
RSB0ZXN0IHBhc3MuCgoKPiAKPiAKPiBPbiBXZWQsIE1heSA3LCAyMDI1IGF0IDU6MjXigK9QTSBD
eXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4gSGkhCj4gPiBQdXNo
ZWQgd2l0aCBhIG1pbm9yIGNoYW5nZSwgdGhhbmtzLgo+ID4KPiA+IFdlIHNob3VsZCBjaGVjayBp
ZiB0aGUgYWRkciBpcyB2YWxpZCBiZWZvcmUgd2UgYXR0ZW1wIHRvIHVubWFwIGl0IGluIHRoZQo+
ID4gc2V0dXAoKSBzbyBJJ3ZlIGFkZGVkOgo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21tYXAvbW1hcDIyLmMKPiA+IGluZGV4IGJmZWY1NTllNC4uMGU1ODlkZmFiIDEwMDY0NAo+ID4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMi5jCj4gPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIyLmMKPiA+IEBAIC03Miw4ICs3Miwx
MyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+ICAgICAgICAgdm9pZCAqYWRk
ciA9IG1tYXAoMCwgMSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIE1BUF9BTk9OWU1PVVMgfCBNQVBfRFJPUFBBQkxFLCAtMSwgMCk7Cj4gPiArCj4g
PiAgICAgICAgIGlmIChhZGRyID09IE1BUF9GQUlMRUQgJiYgZXJybm8gPT0gRUlOVkFMKQo+ID4g
LSAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJNQVBfRFJPUFBBQkxFIG5vdCBzdXBwb3J0
Iik7Cj4gPiArICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIk1BUF9EUk9QUEFCTEUgbm90
IHN1cHBvcnRlZCIpOwo+ID4gKwo+ID4gKyAgICAgICBpZiAoYWRkciA9PSBNQVBfRkFJTEVEKQo+
ID4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJtbWFwKCkgTUFQX0RS
T1BQQUJMRSBmYWlsZWQiKTsKPiA+ICsKPiA+ICAgICAgICAgU0FGRV9NVU5NQVAoYWRkciwgMSk7
Cj4gPiAgfQo+ID4KPiA+Cj4gPiAtLQo+ID4gQ3lyaWwgSHJ1YmlzCj4gPiBjaHJ1YmlzQHN1c2Uu
Y3oKPiA+Cj4gPiAtLQo+ID4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCj4gPgo+IAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
