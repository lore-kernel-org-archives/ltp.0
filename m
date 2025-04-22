Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF80DC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745332372; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dWXTKAMWLYXzZGCc4XJXS96rzToZQQHWqClIJbYV6y0=;
 b=BfR2Iq8c2B+DkAXZuelhUp/gBbMytmqcxipPaEiPat1OjlGvBoWtRFPEhK78DLKP5KH/4
 Iwi+GFhRUUqFew3C+c26LLnJ6SNYzzedUQ1GVBXnbnG8apVL/24JIvwbSp5nrLBZpZmxE6L
 YjBx4HhEQQ/jjrzqFnNCzwdyBd0g5rk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 278E03C63E7
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 16:32:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E4C73C2EFA
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 16:32:29 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6835B2009DA
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 16:32:28 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so650428866b.0
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745332348; x=1745937148; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJ1LEtkAK0NKBHMWq+0Z2HDQx3FeA0Z/8nhHJNxjCoo=;
 b=E60nlsbyymTwBEIMyNrKsF57WlPYMXgTPwnX0dEzKLFxi1CoXjeLzATrP6ps8OYmvd
 Rjlg12dFA+eHPk8qagbYaxfb5Ja14wJ2v3Jx9fyYMeplzbv/aDSyPYGAG7y923PCGnBx
 F+xszKH7MeXd0aG9oUJTjSbDrmobPQgyJmbeAa8C6edx6xjS5x0VufpSjDWkzO3h7MaF
 pY/i4ef57P5ESoWkvmvZDW90+N0uFh73lVll8GWmb7Dj7ekwWcfbDIzH9oyYBj47l0+D
 efa3jNdG4MGo4sst3b5g5Rp47yes65lKeYGav5mur/Jyq3JvwOnBCm3lXetcju/fOLHr
 erPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745332348; x=1745937148;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJ1LEtkAK0NKBHMWq+0Z2HDQx3FeA0Z/8nhHJNxjCoo=;
 b=XJLrtr2+aYJp1Jjff8LvwDmwbSBhIVrSR9+SWNmslhc6WVRrerD5BBYNz3twL0Ac+S
 NhObiWjnM8kIEIgCJZlOlLdQJpztHJAqff1ahET/djVGuH08FFd6FtecB/7Lx9IXMKAx
 1OpD+8JjWxxjK1QlSoTJuVAmtD5GAaUgdlQI+hgzvlOdgfVGCZEH0ZEBK8rEItNuYtij
 RC9CmfQTQ8AzjlGJYG+XUkmujm447qGTPbIxcwJ4sQuuhqjV7QPrliI3DvFDc4T5Qg9+
 Rnrw99OhPjG/MWtxSB0vJ+h8ak4wlPWXjUgUE5CebPcAJXko1cltoh/UgK4Gt8up9qvK
 D6vg==
X-Gm-Message-State: AOJu0YwEaJO1PkLOnEemq+FeHAB/4z9NWF8Kl4UbqVifa0Y3GZ5+5CRa
 FRjOx00zRIz9vRJWVp6XrbMP1VdTsOfXTm1abzSzxquVjk0Jb7Aq6HoYtovx06c=
X-Gm-Gg: ASbGncv/pZ2MYbmmBmQMRaAxJQ7i6JzUF7EFM28wYagdYfEWM7YZNdRs+X6PDlib04d
 hOzMquZ0hnxZGV1HStHBIUY8bGGfsHtn9kzXRaBx6RanYv1CUk75oFNfABvlZxt/W9xU5fx7esF
 LxQU7yu14RrLKwPga0ICj+TF01pYTfiYRxHvFrv5s1VCdnHRNd6OLJYbJi60dx1F6nAsb9LTmOe
 5qjwKm5RkEx+HQQdAOdpT0O94F898aD42w5mBOdgc2ZApfmiZ6K4fb+cNQuiqqXAmOZjuz5k212
 wZIrzph5uK1/qOE/e1BlL0byLxkRIQ==
X-Google-Smtp-Source: AGHT+IEUFovcEpjStngVhESEjdPd6a7t9QXTY5tS1sFE8SyYAiVXdzMtAImmv7yJFXYwghiWaV4Dvw==
X-Received: by 2002:a17:907:8688:b0:ac2:a50a:51ad with SMTP id
 a640c23a62f3a-acb74b2c2b8mr1438855266b.14.1745332347638; 
 Tue, 22 Apr 2025 07:32:27 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b0db1273ed0sm7241176a12.12.2025.04.22.07.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 07:32:27 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 22 Apr 2025 11:32:22 -0300
Message-Id: <D9D8OH63B4ZM.EVMSEPDGCSJP@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-3-e08e7463bfaa@suse.com>
 <20250422140211.GB934527@pevik>
In-Reply-To: <20250422140211.GB934527@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/8] syscalls/mknod03: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEFwciAyMiwgMjAyNSBhdCAxMTowMiBBTSAtMDMsIFBldHIgVm9yZWwgd3JvdGU6Cj4g
SGkgUmljYXJkbywKPgo+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21r
bm9kMDMuYwo+Cj4+IEBAIC0xLDI5NiArMSw2NCBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb25seQo+IFRleHQgYmVsb3cgc2hvd3MgIm9yIChhdCB5b3VyIG9wdGlv
bikgYW55IGxhdGVyIHZlcnNpb24iID0+IGl0IHNob3VsZCBiZSBHUEx2MisuCj4gLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPgo+PiAgLyoKPj4gLSAqCj4+IC0g
KiAgIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4s
IDIwMDEKPj4gLSAqCj4+IC0gKiAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQo+PiAtICogICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQo+
PiAtICogICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvcgo+PiAtICogICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJz
aW9uLgo+PiAtICoKPj4gLSAqICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCj4+IC0gKiAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgo+PiAtICogICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKPj4g
LSAqICAgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCj4+
IC0gKgo+PiAtICogICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQo+PiAtICogICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsg
IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKPj4gLSAqICAgRm91bmRhdGlvbiwg
SW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0x
MzAxIFVTQQo+PiArICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hp
bmVzIENvcnAuLCAyMDAxCj4+ICsgKgkwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgo+PiAr
ICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExDIFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1A
c3VzZS5jb20+Cj4+ICAgKi8KPgo+IC4uLgo+PiArLypcCj4+ICsgKiBWZXJpZnkgdGhhdCBta25v
ZCgyKSBzdWNjZWVkcyB3aGVuIHVzZWQgdG8gY3JlYXRlIGEgZmlsZXN5c3RlbSBub2RlIHdpdGgK
Pj4gKyAqIHNldC1ncm91cC1JRCBiaXQgc2V0IG9uIGEgZGlyZWN0b3J5IHdpdGggc2V0LWdyb3Vw
LUlEIGJpdCBzZXQuIFRoZSBub2RlCj4+ICsgKiBjcmVhdGVkIHNob3VsZCBoYXZlIHNldC1ncm91
cC1JRCBiaXQgc2V0IGFuZCBpdHMgZ2lkIHNob3VsZCBiZSBlcXVhbCB0bwo+PiArICogdGhlICJu
b2JvZHkiIGdpZC4KPj4gICAqLwo+IC4uLgo+PiAtI2RlZmluZSBNT0RFX1JXWAlTX0lGSUZPIHwg
U19JUldYVSB8IFNfSVJXWEcgfCBTX0lSV1hPCj4+IC0jZGVmaW5lIE1PREVfU0dJRCAgICAgICBT
X0lGSUZPIHwgU19JU0dJRCB8IFNfSVJXWFUgfCBTX0lSV1hHIHwgU19JUldYTwo+PiAtI2RlZmlu
ZSBESVJfVEVNUAkidGVzdGRpcl8zIgo+PiAtI2RlZmluZSBUTk9ERQkJInRub2RlXyVkIgo+IC4u
Lgo+PiArI2RlZmluZSBNT0RFX1JXWCAwNzc3Cj4+ICsjZGVmaW5lIE1PREVfU0dJRCAyNzc3Cj4K
PiBUaGUgdGVzdCBmYWlscyBvbiBteSBWTSAobGFzdCBtaW51dGUgY2hhbmdlPyk6CgpPb2YsIHll
cyB0aGF0IHdhcyBpbmRlZWQgdGhlIGxhc3QgcGFydCBJIHRvdWNoZWQuLi4KCj4gbWtub2QwMy5j
OjMzOiBURkFJTDogYnVmLnN0X21vZGUgJiBTX0lTR0lEICgwKSAhPSBTX0lTR0lEICgxMDI0KQo+
IG1rbm9kMDMuYzozODogVEZBSUw6IGJ1Zi5zdF9naWQgKDY1NTM0KSAhPSBmcmVlX2dpZCAoNCkK
Pgo+IFdoeT8gU19JU0dJRCBpcyAqbm90KiAyMDAwIGJ1dCAwMjAwMCAob2N0YWwgbnVtYmVyLCAx
NTM1IGluIGRlY2ltYWwpLgo+IEkgYWN0dWFsbHkgZmluZCAoU19JU0dJRCB8IDA3NzcpIHlvdSBo
YWQgaW4gdjIgbW9yZSByZWFkYWJsZSwgYnV0IG1heWJlIGl0J3MKPiBqdXN0IG1lIHdobyBuZWVk
cyB0byBsb29rIHVwIHNldHVpZCBiaXRzICh1bmxpa2UgdHlwaWNhbCByd3ggcGVybWlzc2lvbiBi
aXRzKS4KPgoKQWdyZWVkLCBJJ2xsIGtlZXAgdGhlIG9jdGFscyBvbmx5IGZvciBwZXJtaXNzaW9u
IG1vZGVzLiBHb29kIGNhbGwgOikKCj4+IC1jaGFyICpUQ0lEID0gIm1rbm9kMDMiOwo+PiAtaW50
IFRTVF9UT1RBTCA9IDE7Cj4+IC1jaGFyIG5vZGVfbmFtZVtQQVRIX01BWF07CS8qIGJ1ZmZlciB0
byBob2xkIG5vZGUgbmFtZSBjcmVhdGVkICovCj4+ICsjZGVmaW5lIFRFTVBfRElSICJ0ZXN0ZGly
Igo+PiArI2RlZmluZSBURU1QX05PREUgVEVNUF9ESVIgIi90ZXN0bm9kZSIKPgo+IC4uLgo+PiAr
c3RhdGljIHZvaWQgcnVuKHZvaWQpCj4+ICB7Cj4gLi4uCj4+ICsJc3RydWN0IHN0YXQgYnVmOwo+
Cj4+ICsJU0FGRV9TVEFUKFRFTVBfRElSLCAmYnVmKTsKPiBJIHdvdWxkIGtlZXAgdGhpcyBmaXJz
dCBTQUZFX1NUQVQoKSBpbiB0aGUgc2V0dXAoKSBhcyBpdCB3YXMgaW4gdGhlIG9yaWdpbmFsCj4g
Y29kZS4gV2UgcHV0IHRoaW5ncyBpbiB0aGUgc2V0dXAgd2hpY2ggYXJlIG5vdCByZWxhdGVkIHRv
IHRoZSB0ZXN0aW5nIGFuZCB0aHVzCj4gaXQncyBhIHdhc3RlIG9mIHRpbWUgdG8gcmVwZWF0IHRo
ZW0sIGUuZy4gb24gcmVwZWF0ZWQgcnVuOgo+ICMgLi9ta25vZDAzIC1pMjAwMAo+CgpBY2suCgo+
PiArCVRTVF9FWFBfRVFfTEkoYnVmLnN0X21vZGUgJiBTX0lTR0lELCBTX0lTR0lEKTsKPiBBbHNv
IHRoaXMgb3JpZ2luYWwgdGVzdCBzaG91bGQgcXVpdCAtIHVzZSB0c3RfYnJrKFRCUk9LKS4KPgo+
IE5PVEU6IGFmdGVyIEN5cmlsJ3MgY2hhbmdlIFsxXSBpcyBtZXJnZWQsIGl0IHdpbGwgbm90IG5l
ZWQgdG8gYmUgdHN0X2JyayhUQlJPSyksCj4gYnV0IGl0IG1ha2VzIHNlbnNlIHRvIHVzZSBUQlJP
SyAoaW5zdGVhZCBvZiBURkFJTCkgaW4gdGhlIHRlc3Qgc2V0dXAgYW55d2F5LgoKSSdsbCB0YWtl
IGEgbG9vayEKCj4KPiBUaGUgcmVzdCBMR1RNLgo+CgpUaGFua3MgZm9yIHJldmlld2luZywKLQlS
aWNhcmRvLgoKCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsxXSBodHRwczovL3BhdGNod29y
ay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjUwNDA0MTQzNDIzLjE2MjY4LTEtY2hy
dWJpc0BzdXNlLmN6LwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
