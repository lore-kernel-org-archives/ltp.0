Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E8DC021AA
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 02:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04D623C58DF
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 03:08:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0543C239D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 03:08:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24E0D23A28D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 03:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740017303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFWqx8vODfVykcfeAOHvGySdUNPVWm5r09PYOZGxbDA=;
 b=eUXTR7r7SmOVhkXhZVGEBMeLsuDSYyHaaVY+1V9lNK1QNVpZGxMFcdpLkAShPJ9FHqcr7M
 xqfRqCU8lxGR+mwuPKu08m1FffpSNcjX0BQKSMgkkrFdGgFFugdM6D6y68HKhIxvtTMwgC
 /nJls+mTpIlN0/GOhN8b+7cOfwABc2M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ye7fHiW5NhuaDYuzrm4p_g-1; Wed, 19 Feb 2025 21:08:20 -0500
X-MC-Unique: ye7fHiW5NhuaDYuzrm4p_g-1
X-Mimecast-MFC-AGG-ID: ye7fHiW5NhuaDYuzrm4p_g_1740017299
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc1c7c8396so1173323a91.0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740017299; x=1740622099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFWqx8vODfVykcfeAOHvGySdUNPVWm5r09PYOZGxbDA=;
 b=CvjkvAK3wMcV3qt9iL5AAIiuE5g35SeJyvzvnoMVmUoiM1HQ8ceZpOzOWS556IW+B/
 U08Fa+QoLqK/1FU5tvscRVbKaKsYSzxrLlrr3yYuZGyuvgAeDLrkaNYl1jw+BxDn3+vs
 ieflRYtF6vExDqB/Ut7dtubHjIsE9cLMF49RY6H5m1XUZjgan5+uMG6HECaUe/E4+gIY
 aiOXgxlyEsMqivGjwLP0C5NKfiDMtREFSTh6weI2PVEYx/Q6J85L/bOqDafk35UBX/9r
 qR6u3hryxhpsQggpjHbZYWOFzPZ3WFRsogMumHHNFkeXHjpJfVSuVjzwWxw8DVIlievz
 faWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTzoB/1Hh/oET55dOKEBtDrZd5beGGgjlD7DdZIjtllIGXpf0r/2GSt6hftOwLvnAoXxE=@lists.linux.it
X-Gm-Message-State: AOJu0YyKMPYjbFwUG6rC7e0jABRiaZs9a68X1oRuJMinSgJwzLcfzbp0
 5yp6mcz2eKk+Fd0qQvx6wJ3vvAp3PUi1h/ykT8KNcPPTKqg5lgFDO3BpfPmSSFWB58sgwmdxktO
 gzRfT6zlOEz7ZMzGtqPc5OlRNe0uXSGUnuV85zt4UXVQyvDXK/Day4WPNUVNS3rFiIBPxK5Ajun
 r0vBvv1If55/l0O9o2M1KAB+8=
X-Gm-Gg: ASbGncvnOI+0abShkauyN0c6KITgAT9/aN+mh4QkRtm9LYQ1/iMP8JYjOMByN2Hkwv3
 JVaeNKXb+X3gPRw0SeEBuXXKxrb922U4B43ybxjAj8B8RTgZ4FZxYp9kJ4gHXThk=
X-Received: by 2002:a17:90b:384d:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2fc40f22d33mr31204514a91.20.1740017299444; 
 Wed, 19 Feb 2025 18:08:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf4iLTnGxsHLWD3jGsnXI5mbOB7rl9TySW49zqGMCWdwm+lCXRCekBCtk0+mG98nbTxhFifwBJD77vpBnAiIE=
X-Received: by 2002:a17:90b:384d:b0:2ee:5edc:4b2 with SMTP id
 98e67ed59e1d1-2fc40f22d33mr31204485a91.20.1740017299072; Wed, 19 Feb 2025
 18:08:19 -0800 (PST)
MIME-Version: 1.0
References: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
 <20250219064804.1313358-1-chwen@redhat.com> <20250219164449.GB2590174@pevik>
In-Reply-To: <20250219164449.GB2590174@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2025 10:08:07 +0800
X-Gm-Features: AWEUYZlTbYE6wjWv1TZnZoVd4WbaHVDF8_5kFjTvmtdvA8iCuXocGDUJAKi4H_w
Message-ID: <CAEemH2fOu4FeMMEQmVWDi+tSQEVzPK0-b8-yZONt137ix8Ttkw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3-QSDPwmPvtNl2IIYxChBU0kcgL7-qhmy72Jh7mWlwo_1740017299
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp@lists.linux.it, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMjAsIDIwMjUgYXQgMTI6NDXigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIENodW5mdSBXZW4sCj4KPiBCZXNpZGVzIEFuZHJlYSdzIGNvbW1l
bnRzLCB0aGVyZSBhcmUgb3RoZXIgdGhpbmdzIHRvIGltcHJvdmUuCj4KPgo+ID4gVGhlIHRlc3Qg
ZW5zdXJlcyB0aGF0IHRoZSBwcm9jZXNzIGdldHMgdGhlIGNvcnJlY3Qgc2lnbmFscyBpbiB0aGUK
PiBjb3JyZWN0IG9yZGVyOgo+Cj4gPiBGaXJzdCwgaXQgc2hvdWxkIGdldCBTSUdYQ1BVIGFmdGVy
IHJlYWNoaW5nIHRoZSBzb2Z0IENQVSB0aW1lIGxpbWl0NjQuCj4gPiBUaGVuLCBpZiB0aGUgQ1BV
IHRpbWUgZXhjZWVkcyB0aGUgaGFyZCBsaW1pdCwgaXQgc2hvdWxkIHJlY2VpdmUgU0lHS0lMTAo+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBjaHVuZnV3ZW4gPGNod2VuQHJlZGhhdC5jb20+Cj4gPiAtLS0K
PiA+IENoYW5nZXMgaW4gdjI6Cj4gPiAtIFJvbW92ZSB0ZXN0IGRlc2NyaXB0aW9ucyBhbmQgdHJh
aWxpbmcgbGluZSBhcyBzdWdnZXN0ZWQgYnkgUmljYXJkbyBCLgo+IE1hcmxpw6hyZQo+ID4gLSBB
ZGRlZCAyMDI1IGNvcHlyaWdodCBhcyBzdWdnZXN0ZWQgYnkgUmljYXJkbyBCLiBNYXJsacOocmUK
PiA+IC0gVHJpbSBkb3duIGluY2x1ZGUgZmlsZXMgYXMgc3VnZ2VzdGVkIGJ5IFJpY2FyZG8gQi4g
TWFybGnDqHJlCj4gPiAtIENyZWF0ZSBuZXcgbGFwaS9yZXNvdXJjZS5oIHJlc2lkaW5nIHN0cnVj
dCBybGltaXQ2NCBhcyBzdWdnZXN0ZWQgYnkKPiBBbmRyZWEKPiA+IC0gTW92ZSBzZXRybGltaXRf
dTY0KCkgc3lzY2FsbHMgZGVmaW5pdGlvbnMgaW50byBsYXBpL3Jlc291cmNlLmggYXMKPiBzdWdn
ZXN0ZWQgYnkgQW5kcmVhCj4gPiAtIFNraXAgIFNBRkVfKiB2YXJpYW50cyBhcyBzdWdnZXN0ZWQg
YnkgQW5kcmVhCj4gPiAtIHVzZSB0c3RfYnVmZmVycyB3aGVuIHBhc3NpbmcgdGhlIHBvaW50ZXJh
cyBzdWdnZXN0ZWQgYnkgQW5kcmVhCj4gPiAtIExpbmsgdG8gdjE6Cj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjUwMjE4MDIzMTA3LjEyMDg5OTAtMS1jaHdlbkByZWRoYXQuY29tLwo+
ID4gLS0tCj4gPiAgaW5jbHVkZS9sYXBpL3Jlc291cmNlLmggICAgICAgICAgICAgICAgICAgICAg
IHwgIDI2ICsrKysKPiA+ICAuLi4va2VybmVsL3N5c2NhbGxzL3NldHJsaW1pdC9zZXRybGltaXQw
Ny5jICAgfCAxMjcgKysrKysrKysrKysrKysrKysrCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNTMg
aW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xhcGkvcmVzb3Vy
Y2UuaAo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Nl
dHJsaW1pdC9zZXRybGltaXQwNy5jCj4KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvcmVz
b3VyY2UuaCBiL2luY2x1ZGUvbGFwaS9yZXNvdXJjZS5oCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NAo+ID4gaW5kZXggMDAwMDAwMDAwLi4zMzEwYmM5MzQKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsr
KyBiL2luY2x1ZGUvbGFwaS9yZXNvdXJjZS5oCj4gPiBAQCAtMCwwICsxLDI2IEBACj4gPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ICsvKgo+ID4gKyAq
IENvcHlyaWdodCAoYykgMjAyNSBSZWQgSGF0IEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiA+
ICsgKiBBdXRob3I6IENodW5mdSBXZW4gPGNod2VuQHJlZGhhdC5jb20+Cj4gPiArICovCj4gPiAr
Cj4gPiArI2lmbmRlZiBMQVBJX1JFU09VUkNFX0hfXwo+ID4gKyNkZWZpbmUgTEFQSV9SRVNPVVJD
RV9IX18KPiA+ICsKPiBUaGVyZSBzaG91bGQgYmUgYXQgdGhlIHRvcAo+Cj4gI2luY2x1ZGUgImNv
bmZpZy5oIgo+IG90aGVyd2lzZSAjaWZuZGVmIEhBVkVfU1RSVUNUX1JMSU1JVDY0IGlzIGFsd2F5
cyBmYWxzZS4KPgo+ID4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UKPiA+ICsKPiA+ICsjaW5jbHVkZSAi
bGFwaS9zeXNjYWxscy5oIgo+Cj4gVGhpcyBzaG91bGQgaW5jbHVkZSBzb21lIGhlYWRlciwgSSBn
dWVzczoKPiAjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+Cj4KPiBiZWNhdXNlIHRoZXJlIGlzIGFs
cmVhZHkgYSBjaGVjay4KPiBBQ19DSEVDS19UWVBFUyhbc3RydWN0IHJsaW1pdDY0XSwsLFsKPiAj
ZGVmaW5lIF9MQVJHRUZJTEU2NF9TT1VSQ0UKPiAjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+Cj4g
XSkKPgo+IE5PVEU6IHdlIHByZWZlciB0byB1c2VzIGxpYmMgaGVhZGVycyBpbnN0ZWFkIG9mIGtl
cm5lbCBoZWFkZXJzIGlmIHBvc3NpYmxlCj4gKGUuZy4gbm90IHVzaW5nIDxsaW51eC9yZXNvdXJj
ZS5oPikgZHVlIGxpYmMgYW5kIGtlcm5lbCBoZWFkZXJzIGNvbmZsaWN0cy4KPiBodHRwczovL3Nv
dXJjZXdhcmUub3JnL2dsaWJjL3dpa2kvU3luY2hyb25pemluZ19IZWFkZXJzCj4KPiA+ICsKPiA+
ICsjaWZuZGVmIEhBVkVfU1RSVUNUX1JMSU1JVDY0Cj4gPiArc3RydWN0IHJsaW1pdDY0IHsKPiA+
ICsgICAgICAgIHVpbnQ2NF90IHJsaW1fY3VyOwo+ID4gKyAgICAgICAgdWludDY0X3QgcmxpbV9t
YXg7Cj4gPiArfTsKPiA+ICsjZW5kaWYKPiA+ICsKPiA+ICtzdGF0aWMgaW50IHNldHJsaW1pdF91
NjQoaW50IHJlc291cmNlLCBjb25zdCBzdHJ1Y3QgcmxpbWl0NjQgKnJsaW0pCj4gPiArewo+ID4g
KyAgICAgICAgcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfcHJsaW1pdDY0LCAwLCByZXNvdXJjZSwg
cmxpbSwgTlVMTCk7Cj4gSSBzdXBwb3NlIHVzaW5nIHJhdyBzeXNjYWxsIGlzIHJlYWxseSBuZWVk
ZWQsIHJpZ2h0Pwo+CgpZZXMsIHVzaW5nIHRoZSByYXcgc3lzY2FsbCBmb3IgcHJsaW1pdDY0IGlz
IG5lY2Vzc2FyeSBpbiB0aGlzIGNhc2UuCgpGcm9tIHdoYXQgSSBrbm93LCBDaHVmdSBpcyB3b3Jr
aW5nIG9pbiBhbiBlbnZpcm9ubWVudCB3aGVyZSBnbGliYydzCndyYXBwZXIgbWlnaHQgaW50ZXJm
ZXJlLCB1c2luZyB0c3Rfc3lzY2FsbChfX05SX3BybGltaXQ2NCwgLi4uKSBlbnN1cmVzCnRoYXQg
dGhlIHJhdyBzeXNjYWxsIGlzIGV4ZWN1dGVkIHdpdGhvdXQgcmVseWluZyBvbiBnbGliYyBiZWhh
dmlvci4KCkBjaHV3ZW4sIHRoaXMgbmV3IGNhc2UgaXMgcXVpdGUgc2ltaWxhciB0byBzZXRybGlt
aXQwNi5jLCBtYXliZSB3ZQpjYW4gY29tYmluZSBpbnRvIG9uZSBhbmQgdXNlIC50ZXN0X3Zhcmlh
bnRzIHRvIHRyYXZlcnNlIGFsbCBzeXNjYWxscy4KZS5nLiBzeXNjYWxscy9zdGltZS9zdGltZV92
YXIuaC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
