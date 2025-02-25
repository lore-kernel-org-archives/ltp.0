Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FF9C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740498287; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zr+AsjZBmaJTjlbIG2voO4/Bhmijc5jIzQTj+zG2YlI=;
 b=eo/66VdtYz2kDEoAyrYSQ9fBGQ8qGfkssDBMgWSDBMCNeY5eupDDHn+Qn/Sl6qwV/BiRf
 zIq8Zh8xod5vX28Nw4JXlIOeXGDxfinXUoHbyHUONkboEeSyrwx35vtg3qSlTU5VxOHfpux
 kr0DzOx58CIidRmkP1pRyC+NTe+u+3Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C27B3C9C74
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 16:44:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB4223C9ACE
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:44:26 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 32D3B100DECC
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 16:44:26 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso900229166b.3
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740498265; x=1741103065; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6b2DrzEcmcUJUceZF6sI/DRcqKoTjpoQ9PmHnHk+GlQ=;
 b=GXywcDJA7l0YphoJkaXlEHQQJLKVq0Zq8WtO9lkyysrA8xj5/pz6PJ8u/sUce5P0OH
 L4rUn2Ivrc8qPsom5rFoW/K50rgGPzADv1V6dvLxohSXlJiwJtSAkreNGI/V9GXOzbEt
 jfDJT3fWyfClYupP0iRJfat345ZE14FWWCws3dMjc3JdoJPqknf2KWdyY4WeC1abpO6V
 3uXjw3iM6V32h4YVYv7lvyIev3MJbP2/oUmscv0E2b7bIP2VYh3MkTQk4qk4A1dVr/cH
 ptikcvsdlurEWz1jNXmL4XDhQ7e4UtLrBGdWIyLWooH64/vpNu2v3D+7w7a1LKRfxNiM
 UDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740498265; x=1741103065;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6b2DrzEcmcUJUceZF6sI/DRcqKoTjpoQ9PmHnHk+GlQ=;
 b=YInehFe36PGNu6p7REVfceR4XIfoG6jFRMpPO2x5QBJbdlKFv+ioE0iadsr2vejM5/
 3xKVYZuNqGaz7q0xBxfqET/RVS//j9dwKM2jb7oXUSr0Zl4h9gjdb+W6Lv2OpwZwMbCH
 /vYMMcBD9VgwUVHfcirsUXHU6A1QeIzGOdndWsXtNq9n/Gu5SvI1pBSn89hGE8xrH86U
 23W0bMJPWyBB9mxN0ZKG3B3SOSvkUlzhQkWBnHP7qHzN2EKfDTquC+iHfQBICdrmoNzm
 cUk5lw6hqR6w973W/MeZI5j9FWtNFJz3CILKYi7KqLEemkMSi7zrLRxAo7++ETqMENRv
 /6Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxdX+LvYTsElA6CApVfSK8vaa17vvvzLqu4OzSz2bLuyeVVX16TH1YOHIKYrw+CoPSk4g=@lists.linux.it
X-Gm-Message-State: AOJu0YxLFqSlnes0a6XcuQ+2pyC/aGDA1D7+BsiUGmzJ5NyOK7iotB5Y
 uTsYwg3hHmpuRq9ve9V+y0bH8PvNV19Ee3riYzINQ9nhZXGYPRie5WnGc714EabksCxCI07xRbF
 q
X-Gm-Gg: ASbGncsgdR+4oXoqUL80r+xBTX4gOoIpjzke+ajc5J86EJjftEhbOiMuC33D85mT8u5
 /gXKkoXSB3puLpc/lvX1PjU5ufEepDbzeY26o1p0MggWeXRFjUJrAoPyQIpsjZMRO23Uc7waF6r
 wVZDboL+PuQNLJKv8Y97khTQEYFwBzhbaonQBgZExUtP11upYjUyUMgyLZxWeoMMH/1p+8ehcf5
 6ecxM/Q3lLNPawjTFnEW5QqAQiVnP2zn6398gx7uDHr9c5cR7I5R8KkGs4KHj5W+/weLcxFwrBD
 8KOrC9oq/igmSbs=
X-Google-Smtp-Source: AGHT+IEltlnHD4DEKbeB0Nyclq5qwJUThzVavUeQUxCIXHjRv1PnoYSvxxF4buabvPs0YF8WbfwaDQ==
X-Received: by 2002:a17:907:96ab:b0:ab6:db3e:2649 with SMTP id
 a640c23a62f3a-abc0d9ca19emr1450077966b.14.1740498265542; 
 Tue, 25 Feb 2025 07:44:25 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2fceb05f913sm8697288a91.25.2025.02.25.07.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 07:44:25 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 25 Feb 2025 12:44:21 -0300
Message-Id: <D81N53167CCA.10KD9DYLMQMMA@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1
References: <20250224-disable_virt_other_getrusage04-v1-1-bcb433af9635@suse.com>
 <9bdb73d0-dd51-445e-bdc9-d201d81fe72f@suse.cz>
In-Reply-To: <9bdb73d0-dd51-445e-bdc9-d201d81fe72f@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getrusage04: Disable for VIRT_OTHER
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

T24gVHVlIEZlYiAyNSwgMjAyNSBhdCAxMjowOSBQTSAtMDMsIE1hcnRpbiBEb3VjaGEgd3JvdGU6
Cj4gSGksCj4gSSB0aGluayBpdCdkIGJlIGJldHRlciB0byBjaGFuZ2UgdGhlIGNvbmRpdGlvbiB0
byB0aGlzOgo+Cj4gaWYgKHRzdF9pc192aXJ0KFZJUlRfQU5ZKSkKPiAgICAgIHRzdF9icmttKFRD
T05GLCAuLi4pOwo+Cj4gT3RoZXJ3aXNlIHdlJ2xsIHBsYXkgZW5kbGVzcyB3aGFjay1hLW1vbGUg
d2l0aCBmdXR1cmUgdmlydCBlbnZpcm9ubWVudHMuCgpCdXQgaWYgYHN5c3RlbWQtZGV0ZWN0LXZp
cnRgIG91dHB1dHMgImFtYXpvbiIsIHdvdWxkbid0IHRoYXQgdHJhbnNsYXRlCnRvIFZJUlRfT1RI
RVIgWzFdPyBpLmUuIFRoZSBnb2FsIGlzIHRvIGFsc28gc2tpcCBvbiBWSVJUX09USEVSLCB1bmxl
c3MKd2UgaW52ZXJ0IHRoZSBsb2dpYy4KClsxXTogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRl
c3QtcHJvamVjdC9sdHAvYmxvYi9hMWFlYmZkNGQ5OWQ1ZGExMjgzNGRhZTUyMTU4MTVmZjhkODI5
OTVjL2xpYi90c3RfdmlydC5jI0wxMDAKPgo+IE9uIDI0LiAwMi4gMjUgMTc6MjYsIFJpY2FyZG8g
Qi4gTWFybGnDqHJlIHdyb3RlOgo+PiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1
c2UuY29tPgo+PiAKPj4gVGhpcyB0ZXN0IGlzIGtub3duIHRvIGJlIHVuc3RhYmxlIHVuZGVyIHNv
bWUgZW52aXJvbm1lbnRzIHN1Y2ggYXMgaW4gdGhlCj4+IGNvbnRleHQgb2YgYSBjbG91ZCBpbnN0
YW5jZSB3aXRoaW4gQVdTIChhbmQgb3RoZXIgcHJvdmlkZXJzIGFzIHdlbGwpLCB3aGljaAo+PiBv
dXRwdXRzICJhbWF6b24iIGZvciBgc3lzdGVtZC1kZXRlY3QtdmlydGAgYW5kIHRoZXJlZm9yZSBm
YWxscyBpbnRvIHRoZQo+PiBWSVJUX09USEVSIGNhdGVnb3J5Lgo+PiAKPj4gU3VnZ2VzdGVkLWJ5
OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMgfCA4ICsrKysrLS0tCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDQuYwo+PiBp
bmRleCBiMDNiYzU0OWJkODM1YjMzYWNhYTAyNjkzNzA2MjU1ZTg4Y2JlNGY4Li4wZTIyZTJlZTlk
YWRmYjFjMDVkZjQ0MjVjNjViMDRiMjU3OWUxNjQ5IDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwNC5jCj4+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTA0LmMKPj4gQEAgLTE5OCw5ICsx
OTgsMTEgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPj4gICB7Cj4+ICAgCXRzdF9zaWcoTk9G
T1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7Cj4+ICAgCj4+IC0JaWYgKHRzdF9pc192aXJ0KFZJ
UlRfWEVOKSB8fCB0c3RfaXNfdmlydChWSVJUX0tWTSkgfHwgdHN0X2lzX3ZpcnQoVklSVF9IWVBF
UlYpKQo+PiAtCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgIlRoaXMgdGVzdGNhc2UgaXMgbm90IHN1
cHBvcnRlZCBvbiB0aGlzIgo+PiAtCQkgICAgICAgICIgdmlydHVhbCBtYWNoaW5lLiIpOwo+PiAr
CWlmICh0c3RfaXNfdmlydChWSVJUX1hFTikgfHwgdHN0X2lzX3ZpcnQoVklSVF9LVk0pIHx8Cj4+
ICsJICAgIHRzdF9pc192aXJ0KFZJUlRfSFlQRVJWKSB8fCB0c3RfaXNfdmlydChWSVJUX09USEVS
KSkKPj4gKwkJdHN0X2Jya20oVENPTkYsIE5VTEwsCj4+ICsJCQkgIlRoaXMgdGVzdGNhc2UgaXMg
bm90IHN1cHBvcnRlZCBvbiB0aGlzIgo+PiArCQkJICIgdmlydHVhbCBtYWNoaW5lLiIpOwo+PiAg
IAo+PiAgIAlCSUFTX01BWCA9IGd1ZXNzX3RpbWVyX3Jlc29sdXRpb24oKTsKPj4gICAKPj4gCj4+
IC0tLQo+PiBiYXNlLWNvbW1pdDogYTFhZWJmZDRkOTlkNWRhMTI4MzRkYWU1MjE1ODE1ZmY4ZDgy
OTk1Ywo+PiBjaGFuZ2UtaWQ6IDIwMjUwMjI0LWRpc2FibGVfdmlydF9vdGhlcl9nZXRydXNhZ2Uw
NC1jOWRiMmFhOWU2OWMKPj4gCj4+IEJlc3QgcmVnYXJkcywKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
