Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B26DC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745920926; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gKlP9AfKBbTwtYWRHo0GTnwcexvWzx0EJQaB3MEDCEc=;
 b=dnjuc+6f8c1eDa5nnqLEXf1Sf04+Yi29FjfJnuUZH6ssVh87vGiBjzkCHzMHhE2uMzavi
 u03N5AlDbaAZumKHvH8HVtdq8dapmF09tdSNKmy3wb1LRL/E6tP4KixAxSAYhppO3OML/Wc
 HLHeakRid+abM9DuZfzzTw9RyymovH0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E38E53CBC0E
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 12:02:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4E9F3CBBA6
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:01:46 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DD8910007C0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:01:45 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso8598087a12.0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745920904; x=1746525704; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/ht22VMaxeImsTYv/gHYI4ytt8Mi4ITt0jCfwhJVHU=;
 b=cA0pNTcOE6eo9hYlERhgbj4GD05WigwM8g4kIJquFdgx7hXgKdduYLQGqXgP6Bn7Fb
 lPPmjt9+FgIr0MogE70KAEp3D6o2X4SntI69y5BKKLK8agWzMIbFY85qLjiWrMUSRUsz
 3XwJZ+Na9YaEPn926jRkQpaKvGSvzPWI9pDXkDvzbIKjfx2ydNjH0rNQQP5FGKG+BiWN
 ic6pZWHxaVQACiYxAYXSz9TF9U18P9rVTPD7yQQmgyaRepPNSW99GDs88BEXnWMqaKKe
 DFyaNp35Bi24IpOEJaKuUjQkndDKQL9LbR+7jLtqXjgrNfo9j4kt/3tYBrMRRXQ2iXXh
 TfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745920904; x=1746525704;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P/ht22VMaxeImsTYv/gHYI4ytt8Mi4ITt0jCfwhJVHU=;
 b=FrNcDAHkbDHcMgJIyc1TkGtzsIi4QvkT5dBwTdTi9XYjSpTHiWAoQkr0S+nw8ItbS0
 FlULxH+3Ref7ArQbBU1HOVtrKlPanzU4t4Dj13il7q3PQ+7vCm3E03v8MFh2Z9qcZhMm
 riXFSywE/Pyp24OleE44s99X3ew5kJfijegV6fdryQBGwWeOdKa9tybc0luAliOgrwei
 7iYPQ14JDMK3pje0peeaon+lW2Sn3gKzlC/pse3emtWGSVkdso/rqJ0fvezJJ+DxOZJD
 QYnDeEu0r+y9W/RhL4aWCI1p58z9Vj9gtlu8ZZjX8BpRK9UjGIWngFFMeTJQ9zmO8qAI
 dRAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6IXRZBvzOrLk8KOTu3f6eljw8f7OIBUZWKXwZUsJDbAQWGUgUKtXrUXsUetwT3oASDM8=@lists.linux.it
X-Gm-Message-State: AOJu0YwNLSpsUKxH39liQehwPWIGF4RzoxMTAqfcIn4tFIzlM/5gtS0Z
 9kMB4OUGGbGplfWYPSFN1jJfJrSl11bxvCq6ln5zyVYuslqsPnmVBKJI2RlkUQ4=
X-Gm-Gg: ASbGncuwvevm2Qe/Q/B1ZJdCB0XI31hqugH+4Nuzfx6ztAFY4mI/2tszJ3UYsqgLX7D
 MWZmhCAZ23UnZbPQinc49OQEsiVpzZMYHACke0rULYbw0wsJro7yXVwJnUfyM2jDG3bs4W32YKu
 HbyWhcv56PYUiDFooo67cRBLKU+mmgLdKoBFCCtBSiREk2kPsbsfBhiEgr1S/bGK/kWh1+U+t0K
 /ndL+RTOVtoIfxyuBvdxVJTo6jcBSTMfQBC58uJ5OJI26IxO773SbmiPjuClh5Fg4mhB3+hN2Zn
 WivhUeMFpCfU9STOFR/hLfsgHh/3IQ==
X-Google-Smtp-Source: AGHT+IGQCK7batCa/S1EdBC79xo12oZXqCrI+rLP4l/IqcDkBlFEK788VqxH453hJsoLCXV0EbT8Uw==
X-Received: by 2002:a17:907:da9:b0:ac1:ea29:4e63 with SMTP id
 a640c23a62f3a-acec4cb12d1mr287168666b.26.1745920904477; 
 Tue, 29 Apr 2025 03:01:44 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db50e74dfsm98559735ad.124.2025.04.29.03.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 03:01:44 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 29 Apr 2025 07:01:38 -0300
Message-Id: <D9J1AZYGUQJH.1COS1CN0FO9QB@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
 <20250408-conversions-modify_ldt-v8-1-7bdba108f64a@suse.com>
 <9f41e34d-3bfe-4baf-84e0-bce28e39091b@suse.com>
In-Reply-To: <9f41e34d-3bfe-4baf-84e0-bce28e39091b@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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

SGkgIQoKT24gVHVlIEFwciAyOSwgMjAyNSBhdCA0OjQwIEFNIC0wMywgQW5kcmVhIENlcnZlc2F0
byB3cm90ZToKPiBIaSBSaWNhcmRvLAo+Cj4gT24gNC84LzI1IDEzOjI2LCBSaWNhcmRvIEIuIE1h
cmxpw6hyZSB3cm90ZToKPj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNv
bT4KPj4KPj4gQWRkIGEgd3JhcHBlciB0byBtb2RpZnlfbGR0IGFuZCBhIGZhbGxiYWNrIGRlZmlu
aXRpb24gdG8gc3RydWN0IHVzZXJfZGVzYywKPj4gd2hpY2ggYXJlIG5lZWRlZCBpbiBhIGZldyB0
ZXN0cyBhbmQgc2hvdWxkIGJlIHJldXNlZC4KPj4KPj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6Pgo+PiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
acOocmUgPHJibUBzdXNlLmNvbT4KPj4gLS0tCj4+ICAgaW5jbHVkZS9sYXBpL2xkdC5oICAgICAg
ICAgICAgICAgICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+
ICAgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgICAgICAgICAgIHwgMjYgKystLS0tLS0t
LS0tLS0tCj4+ICAgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1My5jICAgICAgICAgIHwgIDYg
KystLQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDUuYyB8ICA1ICsr
LQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0
LmgKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMC4uY2ZiOTg4ODM2MzNiNDA0OGJhYmI5M2M4M2YwOWM2YjQxM2Mw
MDRmNgo+PiAtLS0gL2Rldi9udWxsCj4+ICsrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaAo+PiBAQCAt
MCwwICsxLDU4IEBACj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcgo+PiArLyoKPj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIu
IE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+PiArICovCj4+ICsKPj4gKyNpZm5kZWYgTEFQSV9M
RFRfSF9fCj4+ICsjZGVmaW5lIExBUElfTERUX0hfXwo+PiArCj4+ICsjaW5jbHVkZSAiY29uZmln
LmgiCj4+ICsjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+PiArCj4+ICsjaWZkZWYgSEFWRV9B
U01fTERUX0gKPj4gKyNpbmNsdWRlIDxhc20vbGR0Lmg+Cj4+ICsjZWxzZQo+PiArc3RydWN0IHVz
ZXJfZGVzYyB7Cj4+ICsJdW5zaWduZWQgaW50IGVudHJ5X251bWJlcjsKPj4gKwl1bnNpZ25lZCBp
bnQgYmFzZV9hZGRyOwo+PiArCXVuc2lnbmVkIGludCBsaW1pdDsKPj4gKwl1bnNpZ25lZCBpbnQg
c2VnXzMyYml0IDogMTsKPj4gKwl1bnNpZ25lZCBpbnQgY29udGVudHMgOiAyOwo+PiArCXVuc2ln
bmVkIGludCByZWFkX2V4ZWNfb25seSA6IDE7Cj4+ICsJdW5zaWduZWQgaW50IGxpbWl0X2luX3Bh
Z2VzIDogMTsKPj4gKwl1bnNpZ25lZCBpbnQgc2VnX25vdF9wcmVzZW50IDogMTsKPj4gKwl1bnNp
Z25lZCBpbnQgdXNlYWJsZSA6IDE7Cj4+ICsjaWZkZWYgX194ODZfNjRfXwo+PiArCXVuc2lnbmVk
IGludCBsbSA6IDE7Cj4+ICsjZW5kaWYgLyogX194ODZfNjRfXyAqLwo+PiArfTsKPj4gKyNlbmRp
ZiAvKiBIQVZFX0FTTV9MRFRfSCAqLwo+PiArCj4+ICtzdGF0aWMgaW5saW5lIGludCBtb2RpZnlf
bGR0KGludCBmdW5jLCBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCj4+ICsJCQkgICAgIHVu
c2lnbmVkIGxvbmcgYnl0ZWNvdW50KQo+PiArewo+PiArCXJldHVybiB0c3Rfc3lzY2FsbChfX05S
X21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPj4gK30KPj4gKwo+PiArc3RhdGlj
IGlubGluZSBpbnQgc2FmZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sIGludCBmdW5jLAo+PiArCQkJCSAgY29uc3Qgc3RydWN0IHVzZXJfZGVzYyAqcHRyLAo+
PiArCQkJCSAgdW5zaWduZWQgbG9uZyBieXRlY291bnQpCj4+ICt7Cj4+ICsJaW50IHJ2YWw7Cj4+
ICsKPj4gKwlydmFsID0gbW9kaWZ5X2xkdChmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4+ICsJaWYg
KHJ2YWwgPT0gLTEpCj4+ICsJCXRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8s
Cj4+ICsJCQkgIm1vZGlmeV9sZHQoJWQsICVwLCAlbHUpIiwgZnVuYywgcHRyLCBieXRlY291bnQp
Owo+PiArCWVsc2UgaWYgKHJ2YWwpCj4+ICsJCXRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sg
fCBURVJSTk8sCj4+ICsJCQkgIm1vZGlmeV9sdGQoJWQsICVwLCAlbHUpIGludmFsaWQgcmV0dmFs
ICVpIiwgZnVuYywgcHRyLAo+PiArCQkJIGJ5dGVjb3VudCwgcnZhbCk7Cj4KPiBUaGUgTFRQL0tl
cm5lbCBjb2RpbmcgY29udmVudGlvbiBpcyB0aGF0IGEgc3RhdGVtZW50IHVzaW5nIG1vcmUgdGhh
biBvbmUgCj4gbGluZSBuZWVkcyB0byBiZSBzdXJyb3VuZGVkIGJ5IGJyYWNlczogCj4gaHR0cHM6
Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRt
bCNpbmRlbnRhdGlvbgo+IFRoZSByZXN0IGxvb2tzIG9rLgoKSSB0aG91Z2h0IGJyYWNlcyB3ZXJl
IG5vdCBuZWNlc3NhcnkgZm9yIHNpbmdsZSBzdGF0ZW1lbnRzIGJsb2NrcywgaXQKZG9lcyBub3Qg
bWVudGlvbiBtdWx0aS1saW5lIHNpbmdsZSBzdGF0ZW1lbnRzLiBDaGVja3BhdGNoLnBsIGRvZXMg
bm90CnNheSBhbnl0aGluZzoKCiQgYjQgcHJlcCAtLWNoZWNrCkNoZWNraW5nIHBhdGNoZXMgdXNp
bmc6CiAgL21udC9leHQvc3JjL2xpbnV4L2x0cC9jb252ZXJzaW9ucy9tb2RpZnlfbGR0L3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtcSAtLXRlcnNlIC0tbm8tc3VtbWFyeSAtLW1haWxiYWNrCiAtLXNo
b3dmaWxlIC0tbm8tdHJlZSAtLWlnbm9yZSBDT05TVF9TVFJVQ1QsVk9MQVRJTEUsU1BMSVRfU1RS
SU5HLEZJTEVfUEFUSF9DSEFOR0VTCi0tLQril48gMjNlNzg0MzE5MjdkOiBzeXNjYWxscy9tb2Rp
ZnlfbGR0OiBBZGQgbGFwaS9sZHQuaAogIOKXjyBjaGVja3BhdGNoLnBsOiBpbmNsdWRlL2xhcGkv
bGR0Lmg6MTogV0FSTklORzogSW1wcm9wZXIgU1BEWCBjb21tZW50IHN0eWxlIGZvciAnaW5jbHVk
ZS9sYXBpL2xkdC5oJywgCnBsZWFzZSB1c2UgJy8qJyBpbnN0ZWFkCiAg4pePIGNoZWNrcGF0Y2gu
cGw6IGluY2x1ZGUvbGFwaS9sZHQuaDoxOiBXQVJOSU5HOiBNaXNzaW5nIG9yIG1hbGZvcm1lZCBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllciB0YWcgaW4gbGkKbmUgMQril48gMjYwMTY4MTBlMTdmOiBz
eXNjYWxscy9tb2RpZnlfbGR0MDI6IFJlZmFjdG9yIGludG8gbmV3IEFQSQogIOKXjyBjaGVja3Bh
dGNoLnBsOiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvY29tbW9uLmg6MTog
V0FSTklORzogSW1wcm9wZXIgU1BEWCBjb21tZW50IHN0eWxlCiBmb3IgJ3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbW9kaWZ5X2xkdC9jb21tb24uaCcsIHBsZWFzZSB1c2UgJy8qJyBpbnN0ZWFk
CiAg4pePIGNoZWNrcGF0Y2gucGw6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW9kaWZ5X2xk
dC9jb21tb24uaDoxOiBXQVJOSU5HOiBNaXNzaW5nIG9yIG1hbGZvcm1lZCBTUERYLUwKaWNlbnNl
LUlkZW50aWZpZXIgdGFnIGluIGxpbmUgMQril48gOWQzM2RiMjllNDNiOiBzeXNjYWxscy9tb2Rp
ZnlfbGR0MDE6IFJlZmFjdG9yIGludG8gbmV3IEFQSQotLS0KU3VjY2VzczogMSwgV2FybmluZzog
NCwgRXJyb3I6IDAKCj4KPiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNl
cnZlc2F0b0BzdXNlLmNvbT4KClRoYW5rcyBmb3IgcmV2aWV3aW5nLAotCVJpY2FyZG8uCgoKPgo+
IC0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
