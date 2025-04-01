Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AFDC36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743504341; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=oksvO/czLkazAsT65TTt8WYsLJ7sEGQQli6Lrh9a7qQ=;
 b=W9tFgmEpzIVZDj9g2rPAzgVFO2ssZrNB1v+7qYeJmejdol4rIhfOgR3aLMjbAd7TS+kWR
 X6DOtcrglXwcWbrolxVnYqq5pgn2ZhAYXxut0zh8UOIxAZrCpYsACL66XepL3Vw/Nyv2Vm7
 BS7TmQyy2gt+qR/U63V24dmgs5TKJ3Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612153CAE88
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:45:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id E5BED3CAE6F
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:45:19 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with UTF8SMTPS id 6A3C2600859
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:45:18 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1106116f8f.0
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743504318; x=1744109118;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ulCADcJZ7laxXnqlaE+WB3EyLzdy+QWOyHPkc/RsPWA=;
 b=VEy43Hl+BDAvDiBEphJnMuYDAwWyX1ww+Cc9RAXAHWGVvc4B9QRWwgTR0T4aows/AQ
 wzv+dsmPs8c4fDOIFBGK6w2ek/1RP46300a7Yz5velle5EuYZ8VE6wLZb4n/MGgBHlwy
 2GhzgAxXqHOzdcuVujC+PqGgbqGglLZZdmE+skR3z+XwHa9F3l00snfsgm9g/veo0yvl
 Iedj5telirQF6tbTeNTNPrDqFs+cy9dw/PemhgsO6iV1tYJdmRPTXs2yM1CNNSet8M3h
 XoVFwDmMkfbXA+thIJqGpdDao2I59MryPFWP9+AfyM9zpOOfQEkn6n5Qck559uWxn7PC
 oUgg==
X-Gm-Message-State: AOJu0Yzk5zkmO8v5G8orsUcWI6Ui4S3ETvNQzR200Jrx7/1lyqeSeTOG
 kcB1daS0Gin5UU0wUZ9+gYMWagScUhwFc7jLhUJYIlI+Gfg8tLLCz9AcN50+1vM=
X-Gm-Gg: ASbGncvE5hdQwTT769Vgvi1nt0kO3WJ3NfDoiQ3MHS7RU2TIbg80fHpXM4AK5/iDR98
 8GQFc0qCh0WCFRWf6r0UugW0bJ184MNFx9I9DkXis3FxV7PhAsjaXEtTcQp/alFgZYeB6v788a3
 SpGWrmgKEEmhXQWhv0q2RxN9p6aExFpv/VEsw3t8Gbx5Ox+lEZYJPxGu4F+AGRUdnWjREUx8OY3
 zoNrm1HovgRLPJuxsemeL0zZZ5LT01i9SzkmuV3+QJjwNCUUL0spaPJsWyhmDTPHvUlEM2YlHDw
 vC7WhEWY3RnVKL2xph5oY3n7V/032827O1WBZZV43VUp
X-Google-Smtp-Source: AGHT+IHUUZEVTZbS5KOUbpBntTVC6EsTxGaQbx9vTlgrgEwVtfdUglugzczEwm8AgHU7UYZD2N/z+g==
X-Received: by 2002:a05:6000:18a5:b0:38f:3e1c:211d with SMTP id
 ffacd0b85a97d-39c120deb39mr8204224f8f.14.1743504317499; 
 Tue, 01 Apr 2025 03:45:17 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b69d996sm7813042a12.22.2025.04.01.03.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 03:45:15 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 01 Apr 2025 07:45:09 -0300
Message-Id: <D8V8P2B13X9V.3BKKO7VMRPQTG@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
 <20250331-conversions-modify_ldt-v5-1-fd6ea1491956@suse.com>
 <20250401102909.GB345164@pevik>
In-Reply-To: <20250401102909.GB345164@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gUGV0ciEKCk9uIFR1ZSBBcHIgMSwgMjAyNSBhdCA3OjI5IEFNIC0wMywgUGV0ciBWb3Jl
bCB3cm90ZToKPiBIaSBSaWNhcmRvLCBBbmRyZWEsCj4KPj4gKysrIGIvaW5jbHVkZS9sYXBpL2xk
dC5oCj4+IEBAIC0wLDAgKzEsMzQgQEAKPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCj4+ICsvKgo+PiArICogQ29weXJpZ2h0IChjKSAyMDI1IFNVU0UgTExD
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+ICsgKi8KPj4gKwo+PiArI2lm
bmRlZiBMQVBJX0xEVF9IX18KPj4gKyNkZWZpbmUgTEFQSV9MRFRfSF9fCj4+ICsKPj4gKyNpbmNs
dWRlICJjb25maWcuaCIKPj4gKyNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4+ICsjaW5jbHVk
ZSA8YXNtL2xkdC5oPgo+PiArCj4+ICtzdGF0aWMgaW50IG1vZGlmeV9sZHQoaW50IGZ1bmMsIHZv
aWQgKnB0ciwgdW5zaWduZWQgbG9uZyBieXRlY291bnQpCj4gRllJIGlmIHRoaXMgaW4gYSBoZWFk
ZXIgaXQgc2hvdWxkIGJlICdzdGF0aWMgaW5saW5lJy4gVGhhdCB3b3VsZCBiZSB3b3J0aCB0byBm
aXguCj4KPiBXZSBoYXZlIGEgbG90IG9mICdzdGF0aWMgaW5saW5lJyBpbiBsYXBpIGhlYWRlcnMu
IElNSE8gdGhpcyBpcyBhIGdvb2QgYXBwcm9hY2gKPiBmb3IgdGhlc2UgZmVhdHVyZSBzcGVjaWZp
YyBzeXNjYWxscywgYWx0aG91Z2ggTWFydGluIERvdWNoYSB0cmllZCB0byBnZXQgcmlkIG9mCj4g
c29tZSBzdGF0aWMgaW5saW5lIChtb3ZpbmcgdGhlbSB0byBDIGZpbGVzIGluIGxpYi8pIHRvIGF2
b2lkIGNvbXBpbGF0aW9uIHByb2JsZW1zLgo+Cj4gQnV0IGFnYWluLCB0aGlzIGlzIHdvcnRoIGZv
ciBzb21lIGdlbmVyaWMgZmlsZXMgbG9uZyBlbm91Z2ggZS5nLgo+IGxpYi90c3RfbmV0bGluay5j
IG9yIGxpYi90c3RfbmV0ZGV2aWNlLmMuCj4KPiBBbHNvIHN0YXRpYyBpbmxpbmUgbWFrZXMgY29k
ZSB0byBncm93LCBidXQgYWRkaW5nIG5ldyBDIHNvdXJjZSB0byBMVFAgbGlicyBtYWtlcwo+IElN
SE8gYmlnZ2VyIGNvZGUgc2l6ZSBpbmNyZWFzZSAoYmVzaWRlcyB3ZSBkb24ndCBjYXJlIGFib3V0
IExUUCBzaXplIGFueXdheSwKPiBvdGhlcndpc2Ugd2Ugd291bGQgY2hhbmdlIGxpbmtpbmcgc2lt
aWxhciB0byBidXN5Ym94IC0gc2luZ2xlIGJpbmFyeSBwcm92aWRpbmcKPiBtYW55IGZ1bmN0aW9u
cykuCgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgYWRkcmVzcyB5b3VyIHBvaW50cyBp
biB0aGUgbmV4dCByZXZpc2lvbiA6KQoKPgo+PiArewo+PiArCXJldHVybiB0c3Rfc3lzY2FsbChf
X05SX21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPj4gK30KPj4gKwo+PiArc3Rh
dGljIGludCBzYWZlX21vZGlmeV9sZHQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVu
bywgaW50IGZ1bmMsCj4+ICsJCQkgICB2b2lkICpwdHIsIHVuc2lnbmVkIGxvbmcgYnl0ZWNvdW50
KQo+PiArewo+IEFuZCBoZXJlIGFzIHdlbGwuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4+
ICsJaW50IHJ2YWw7Cj4+ICsKPj4gKwlydmFsID0gbW9kaWZ5X2xkdChmdW5jLCBwdHIsIGJ5dGVj
b3VudCk7Cj4+ICsJaWYgKHJ2YWwgPT0gLTEpCj4+ICsJCXRzdF9icmtfKGZpbGUsIGxpbmVubywg
VEJST0sgfCBURVJSTk8sCj4+ICsJCQkgIm1vZGlmeV9sZHQoJWQsICVwLCAlbHUpIiwgZnVuYywg
cHRyLCBieXRlY291bnQpOwo+PiArCj4+ICsJcmV0dXJuIHJ2YWw7Cj4+ICt9Cj4+ICsKPj4gKyNk
ZWZpbmUgU0FGRV9NT0RJRllfTERUKGZ1bmMsIHB0ciwgYnl0ZWNvdW50KSBcCj4+ICsJc2FmZV9t
b2RpZnlfbGR0KF9fRklMRV9fLCBfX0xJTkVfXywgKGZ1bmMpLCAocHRyKSwgKGJ5dGVjb3VudCkp
Cj4+ICsKPj4gKyNlbmRpZiAvKiBMQVBJX0xEVF9IX18gKi8KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
