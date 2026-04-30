Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2592FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777551163; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=/vovDKPKGjpzOqr+2Qu37MN/RfH92ieItC6Paa2vKos=;
 b=K8iZYqJdcZMGWbcYWqvDhCNlrvu+7ASCZqlH2J/CTkFOttSO3T6g/QlqEW3D1y5WRLr7P
 0IldpcG0MBrmVUNNXrKzkTycdgrwmJ78VPNLSJy8Q7VCH5oDXxpQdIpBKb84YC/me1XJe+g
 eqiXMTEp7C6W/5RuSDhRB1b/YEUjOCk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43CF03E65B1
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:12:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01E2A3CBDB2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:12:19 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC38C1A00EFB
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:12:18 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso485925f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777551138; x=1778155938; darn=lists.linux.it;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0Q1tsdKTHFH+vuoNBimxc1E8+/MCsun1UIfdnViVJw=;
 b=Ti2YCljOySzN3Y10y1wNYVuTKtsDqhiUnQATEXVmonHSSy+2rtlJ79Foesx8NM16qb
 O9cfqeKGxMUDuiWtJdz6yYJVOyfrOF5cqPc/a4/ZRIPieDhLbJFFJ42ifNNLGKCUpG4R
 vySXS+fdPIbZBULYx2x6yfuH4d5jDA2uM7zER7EJyqZ/7AZNtzEZ7GdKtUtC9Tcu7IXd
 L965MBqtUfpBGYoEtXla7Bzr21O/E6XYW54IrZg7Aq4/wX0s9Syp14tlWWBYupcIVdjz
 TY3gNA5B4hZHEaA9vfw6IBvmqvFbikx1UVaDX12FUGHF5uJzzQvmjqEDuY9euIw6axlu
 GGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777551138; x=1778155938;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C0Q1tsdKTHFH+vuoNBimxc1E8+/MCsun1UIfdnViVJw=;
 b=mcuKIGtO7JCcUq84W+cmcRBP/WkWyXK80KoqmJvtEvcWZ7vZQNGqDcSPoT0cWz2Kmw
 gQVpIu1Tmy+CmmA6K99QfXBRsWKX0M95Y+I2c6d9zPpcA0K2YyFAA7K+KLmbTPV0Cevs
 ev+g1CAbxemXWSXFu7tLpywVHUHMSao/+fEHDjBS37tMTpxDN8GUEkwmWA3nKhw1EkDJ
 HqncB2LvFfh0pe4Px6r541g70Tg1meVCdOBdSKVj9s8axri4dhP7yvA9rPQzhZdgggal
 Hzgx1fv6W5HVBfKmjzTUhriR0/PWSVuuQ3WGaH/V/VQdzW4fjMxYQ3IoD05rRfOQgZKV
 UrNg==
X-Gm-Message-State: AOJu0YxVbxoSjja+h0DJdNX/951oQvLMotgdbPmc7G7QRbrvxj8g6YIl
 PW19A7+LD57SRIMVjfitOJAGkuv2w5PHeizXPmYgtXtX7A6PGiGzMC9GZ4RkXOvRwRM=
X-Gm-Gg: AeBDieuHYtJT4OdpMJdUYgbkjKkEINlkH4ver2bVuo8qKKs4sGtLnUAiqDkXDmo0Bej
 6Wlwa8BG0E+M2Tkn1C02URHk53Cc9cbGM34N5z8yEuY8Uf0qG0yMQjLQGWvvqlVFD+F5zjPNGLX
 tx9ohj5ix107kqy6EGMxqoJP6zqcCF5M9Zki0bBKBnsDVXHMeLUaPdHIzpVRjwSjP4wPXthITM9
 AAzWmzJJq1ryJ4kiXY6d4SzWW3Ho/UWH8H2bMnsyh2CzYMOpn1QWJbyGcWFwiGA+WWXRbPXbj1n
 BBVAnHcU/QGOs+0dEDi7Xo5qbdgF3KEE9iK5I96IovUWGcpC9SV2mhRFkplvC2sNBewQ4fB8I1f
 mFcZJJCo3gYxFcgsZGXTtIi12EcQ5kQFTX2/klIpctJh0M3g9/An1jO20mxOEuTt/Ue/iK7Uq/E
 iqnWYxxtMKxTCzzBt50eOD4lg+NQvL9mxJ1QxGxU8+LgaTTjkjVLHZ1tbjb3F1vahm8lWSW9SGd
 K9buuSkIwHpwslV
X-Received: by 2002:a05:6000:1867:b0:43e:a9ba:b194 with SMTP id
 ffacd0b85a97d-4493f1307b6mr4632189f8f.34.1777551138078; 
 Thu, 30 Apr 2026 05:12:18 -0700 (PDT)
Received: from ?IPV6:2401:4900:88d6:a675:2691:5d4e:58a0:eb9b?
 ([2401:4900:88d6:a675:2691:5d4e:58a0:eb9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b120bdefsm13123308f8f.0.2026.04.30.05.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 05:12:17 -0700 (PDT)
Message-ID: <25466194-da79-4ddf-96be-f0429afd61c1@suse.com>
Date: Thu, 30 Apr 2026 14:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>
References: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
Content-Language: en-US
In-Reply-To: <20260430-cve-2026-31431-v1-1-7fdc16c25785@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cve-2026-31431: Add page cache corruption
 reproducer
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiArc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gK3sKPiArCWludCBmaWxlX2Zk
Owo+ICsJdWludDhfdCByZWFkYmFja1tPVkVSV1JJVEVfU0laRV07Cj4gKwo+ICsJZmlsZV9mZCA9
IFNBRkVfT1BFTihURVNURklMRSwgT19SRE9OTFkpOwo+ICsJdHJ5X2NvcnJ1cHQoZmlsZV9mZCk7
Cj4gKwlTQUZFX0NMT1NFKGZpbGVfZmQpOwo+ICsKPiArCWZpbGVfZmQgPSBTQUZFX09QRU4oVEVT
VEZJTEUsIE9fUkRPTkxZKTsKPiArCVNBRkVfUkVBRCgxLCBmaWxlX2ZkLCByZWFkYmFjaywgc2l6
ZW9mKHJlYWRiYWNrKSk7Cj4gKwlTQUZFX0NMT1NFKGZpbGVfZmQpOwo+ICsKPiArCWlmIChtZW1j
bXAocmVhZGJhY2ssIG9yaWdpbmFsLCBPVkVSV1JJVEVfU0laRSkgIT0gMCkKPiArCQl0c3RfcmVz
KFRGQUlMLCAiUGFnZSBjYWNoZSB3YXMgY29ycnVwdGVkIHZpYSBBRl9BTEcgc3BsaWNlIik7Cj4g
KwllbHNlCj4gKwkJdHN0X3JlcyhUUEFTUywgIlBhZ2UgY2FjaGUgd2FzIG5vdCBjb3JydXB0ZWQi
KTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsJaW50IGZkOwo+
ICsKPiArCWZkID0gU0FGRV9PUEVOKFRFU1RGSUxFLCBPX1dST05MWSB8IE9fQ1JFQVQgfCBPX1RS
VU5DLCAwNjQ0KTsKPiArCVNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkLCBvcmlnaW5hbCwg
T1ZFUldSSVRFX1NJWkUpOwo+ICsJU0FGRV9DTE9TRShmZCk7Cj4gK30KCndoZW4gcnVubmluZyBt
b3JlIHRoYW4gMSBpdGVyYXRpb24gKGkuZS4gLWkyKSBvbiBhIHZ1bG5lcmFibGUga2VybmVsLCB0
aGUKCmZpcnN0IGl0ZXJhdGlvbiBpc8Kgb3ZlcndyaXRpbmcgdGhlIHBhZ2UgY2FjaGUgd2l0aCBQ
V05ELCBhbmQgc3Vic2VxdWVudAoKaXRlcmF0aW9ucyBhcmUgc3RhcnRpbmcgd2l0aMKgwqBhIGNv
cnJ1cHRlZCBmaWxlIGFscmVhZHksIHdlIG5lZWQgdG8gbW92ZQoKdGhlIHNldHVwIHBhcnQgYWxz
byB0byBydW4oKSBhbmQgd2UgY2FuwqBkcm9wIHNldHVwKCkuCgoKd2l0aCB0aGF0OgpUZXN0ZWQt
Ynk6IEF2aW5lc2ggS3VtYXIgPGF2aW5lc2gua3VtYXJAc3VzZS5jb20+Cgo+ICsKPiArc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLnRlc3RfYWxsID0gcnVuLAo+ICsJLnNldHVw
ID0gc2V0dXAsCj4gKwkubmVlZHNfdG1wZGlyID0gMSwKPiArCS50YWdzID0gKGNvbnN0IHN0cnVj
dCB0c3RfdGFnW10pIHsKPiArCQl7ImxpbnV4LWdpdCIsICJhNjY0YmYzZDYwM2QifSwKPiArCQl7
IkNWRSIsICIyMDI2LTMxNDMxIn0sCj4gKwkJe30KPiArCX0sCj4gK307Cj4KPiAtLS0KClJlZ2Fy
ZHMsCkF2aW5lc2gKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
