Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D8D21694
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 12:42:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0E83C6728
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 14:42:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68AC83C5ACF
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:42:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2FA81016567
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 14:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728996131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYbRejQqH8AFrn3NEltTxtfx2m40rL6G8o/X6sjV+R0=;
 b=Zcad3HWENo9E3RJjLKPuxCVZRYHDI66q2ODTqIjeWubwV+rx4OdlBvpmAADfWaXDdXyuJr
 gOQI2VUEkzU7UngH+6MYlzg01SVxvmsTUJ78aI2KikHjI9yVQW12/bDtVTn4wytuTosjAQ
 GtSxpUXiDRG3X78XB7Tw2uxNygH1kd8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-qJyJcRwvM7O5uUXVaJLHTA-1; Tue, 15 Oct 2024 08:42:10 -0400
X-MC-Unique: qJyJcRwvM7O5uUXVaJLHTA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e1159159528so9065009276.1
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 05:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728996130; x=1729600930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYbRejQqH8AFrn3NEltTxtfx2m40rL6G8o/X6sjV+R0=;
 b=nmdgNUiykFm7X6lFxOlzD5HKcTSLUpxJuY5OynWnkxIQoXXVcfa27mG372VSanYFEO
 Zu4F41oq8EnZh0TZ3HIeSOAeaYsrXp56z/KTDBDx7ea5wQOUsTG4RQQZm9VYJBrG6/2B
 3WAL5mMX0UDAe89ZbnhKEA7/AFKoE9/VqT67YsrgZg8A/eMQ1qkfLbXLLgfMVuO44LmM
 P0DcByAkZEMAG8ZkskmmCbNM0xEXpZka4xhAXbFhwSAhAueBY4CNoCip2P4GJ4ft31Bs
 n3J1e+Sk+SMlAWrSqvP5aK3KcKzlYdgvqbCKitZgehSc5qA7+7KeyxTi7Dgji5nETd74
 14Iw==
X-Gm-Message-State: AOJu0YxgqTejeDIVmQJgLe8Zvea4sFR7pe2hjBsgKOjPE8a+J18PZ+Kf
 Rwf4rtWkJa2Gmbz0qxO7VklYikLpR53Ee1zhjqxMxiNi2S97Lq2q8vA0xHu/p89xmhlwwjuoTZ7
 dVoBGqWzFSZ0NHdtRJ49tCPfKuhrfjzJlW+yT4GDMR9NXp+HWhB04w5A+17vLhqQF8UgJ5XWFMu
 VHETTfzk9VcPZvAfjVdN9Gip4=
X-Received: by 2002:a05:6902:989:b0:e28:e723:e334 with SMTP id
 3f1490d57ef6-e2977514901mr244847276.24.1728996130054; 
 Tue, 15 Oct 2024 05:42:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9imGFGveMlaTiQiwRb69E8wiBwxCVThI5/gaMebB+r14SwEWgrjEdbfG92CKVhCxfTe8TiRSGumLJPkUJVkI=
X-Received: by 2002:a05:6902:989:b0:e28:e723:e334 with SMTP id
 3f1490d57ef6-e2977514901mr244829276.24.1728996129586; Tue, 15 Oct 2024
 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
 <Zw5bCxNMuCz4aKWC@yuki.lan>
In-Reply-To: <Zw5bCxNMuCz4aKWC@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2024 14:41:53 +0200
Message-ID: <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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

T24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMjowOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpz
dGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N0YXRtb3VudC9zdGF0bW91bnQwNy5jIHwgOSArKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXRtb3VudC9zdGF0bW91bnQwNy5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0bW91bnQvc3RhdG1vdW50MDcuYwo+ID4gaW5kZXggMGNj
ODM0Mjk4NzJmLi41OGZjYzIwYWNjZTcgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N0YXRtb3VudC9zdGF0bW91bnQwNy5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3N0YXRtb3VudC9zdGF0bW91bnQwNy5jCj4gPiBAQCAtMjAsMTAgKzIwLDEw
IEBACj4gPiAgc3RhdGljIHN0cnVjdCBzdGF0bW91bnQgKnN0X21vdW50Owo+ID4gIHN0YXRpYyBz
dHJ1Y3Qgc3RhdG1vdW50ICpzdF9tb3VudF9udWxsOwo+ID4gIHN0YXRpYyBzdHJ1Y3Qgc3RhdG1v
dW50ICpzdF9tb3VudF9zbWFsbDsKPiA+ICtzdGF0aWMgc3RydWN0IHN0YXRtb3VudCAqc3RfbW91
bnRfYmFkOwo+ID4gIHN0YXRpYyB1aW50NjRfdCBtbnRfaWQ7Cj4gPiAgc3RhdGljIHVpbnQ2NF90
IG1udF9pZF9kb250X2V4aXN0ID0gLTE7Cj4gPiAgc3RhdGljIHNpemVfdCBidWZmX3NpemU7Cj4g
PiAtc3RhdGljIHNpemVfdCBidWZmX3NpemVfaW52YWxpZCA9IC0xOwo+ID4KPiA+ICBzdHJ1Y3Qg
dGNhc2Ugewo+ID4gICAgICAgaW50IGV4cF9lcnJubzsKPiA+IEBAIC05MCwxMiArOTAsMTIgQEAg
c3RydWN0IHRjYXNlIHsKPiA+ICAgICAgIH0sCj4gPiAgICAgICB7Cj4gPiAgICAgICAgICAgICAg
IEVGQVVMVCwKPiA+IC0gICAgICAgICAgICAgImludmFsaWQgYnVmZmVyIHNpemUiLAo+ID4gKyAg
ICAgICAgICAgICAiYnVmZmVyIGNyb3NzZXMgdG8gUFJPVF9OT05FIiwKPiA+ICAgICAgICAgICAg
ICAgJm1udF9pZCwKPiA+ICAgICAgICAgICAgICAgMCwKPiA+ICAgICAgICAgICAgICAgMCwKPiA+
IC0gICAgICAgICAgICAgJmJ1ZmZfc2l6ZV9pbnZhbGlkLAo+ID4gLSAgICAgICAgICAgICAmc3Rf
bW91bnQKPiA+ICsgICAgICAgICAgICAgJmJ1ZmZfc2l6ZSwKPiA+ICsgICAgICAgICAgICAgJnN0
X21vdW50X2JhZAo+ID4gICAgICAgfSwKPiA+ICAgICAgIHsKPiA+ICAgICAgICAgICAgICAgRUZB
VUxULAo+ID4gQEAgLTEzOSw2ICsxMzksNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3Qg
PSB7Cj4gPiAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsKPiA+ICAgICAg
ICAgICAgICAgeyZzdF9tb3VudCwgLnNpemUgPSBzaXplb2Yoc3RydWN0IHN0YXRtb3VudCl9LAo+
ID4gICAgICAgICAgICAgICB7JnN0X21vdW50X3NtYWxsLCAuc2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
c3RhdG1vdW50KX0sCj4gPiArICAgICAgICAgICAgIHsmc3RfbW91bnRfYmFkLCAuc2l6ZSA9IDF9
LAo+Cj4gV2l0aCB0aGlzIHdlIGNyZWF0ZSBhIG1hcHBpbmcgd2hlcmUgUFJPVF9OT05FIGlzIGJl
Zm9yZSB0aGUgYnVmZmVyLCBub3QKPiBhZnRlciBpdAoKQXJlIHlvdSBzdXJlPwoKMTcwMTkgMDg6
MzI6MjMgd3JpdGUoMiwgInRzdF9idWZmZXJzLmM6NTc6IFwzM1sxOzM0bVRJTkZPOiAiLi4uLCA2
NikgPSA2NgoxNzAxOSAwODozMjoyMyBtbWFwKE5VTEwsIDgxOTIsIFBST1RfUkVBRHxQUk9UX1dS
SVRFLApNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDNmZjk0Zjc1MDAwCjE3
MDE5IDA4OjMyOjIzIG1wcm90ZWN0KDB4M2ZmOTRmNzYwMDAsIDQwOTYsIFBST1RfTk9ORSkgPSAw
CgpzdF9tb3VudF9iYWQ6IDB4M2ZmOTRmNzVmZmYKKC9wcm9jL3NlbGYvbWFwcykKLi4uCjNmZjk0
ZjJlMDAwLTNmZjk0ZjMwMDAwIHJ3LXAgMDAwMmUwMDAgZmQ6MDMgNjcxMTA5MTEKICAvdXNyL2xp
Yi9sZDY0LnNvLjEKM2ZmOTRmNzUwMDAtM2ZmOTRmNzYwMDAgcnctcCAwMDAwMDAwMCAwMDowMCAw
CjNmZjk0Zjc2MDAwLTNmZjk0Zjc3MDAwIC0tLXAgMDAwMDAwMDAgMDA6MDAgMAozZmY5NGY3NzAw
MC0zZmY5NGY3YjAwMCBydy1wIDAwMDAwMDAwIDAwOjAwIDAKM2ZmZmJhNWEwMDAtM2ZmZmJhN2Iw
MDAgcnctcCAwMDAwMDAwMCAwMDowMCAwICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtzdGFj
a10KM2ZmZmJhOWYwMDAtM2ZmZmJhYTEwMDAgci0tcCAwMDAwMDAwMCAwMDowMCAwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFt2dmFyXQozZmZmYmFhMTAwMC0zZmZmYmFhMzAwMCByLXhwIDAw
MDAwMDAwIDAwOjAwIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW3Zkc29dCgo+LCBzaW5j
ZSBndWFyZGVkIGJ1ZmZlcnMgYXJlIHByaW1hcmlseSBndWFyZGluZyBhYm91dCBvZmYtYnktb25l
Cj4gYXQgdGhlIHN0YXJ0IG9mIHRoZSBidWZmZXIuCgpJJ2QgZXhwZWN0IGdvaW5nIG92ZXIgZW5k
IG9mIGJ1ZmZlciB0byBiZSBhIGxvdCBtb3JlIGNvbW1vbi4KCj4gVGhlcmUgaXMgYSBjYW5hcmF5
IGFmdGVyIGFmdGVyIHRoZSBhbGxvY2F0ZWQKPiBidWZmZXIgdGhhdCB3aWxsIHBvdGVudGlhbHkg
YmUgcmV3cml0dGVuLCBidXQgdGhhdCB3b3VsZCBiZSBkZXRlY3RlZAo+IG9ubHkgYXQgdGhlIHRl
c3QgZXhpdC4KPgo+IElmIEkgcmVtbWViZXIgY29ycmVjdGx5IHRoZSBtYXBwaW5ncyB3aWxsIGxv
b2sgbGlrZToKPgo+IHwgUFJPVF9OT05FIHxfIENBTkFSWSBCWVRFUyB8Cj4gICAgICAgICAgICAg
IF4KPiAgICAgICAgICAgICAgQW5kIHRoaXMgaXMgb3VyIDEtYnl0ZSBidWZmZXIuCgoKCgoKPgo+
IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
