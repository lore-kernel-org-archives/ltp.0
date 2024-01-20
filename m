Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C182C47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 06:53:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A4513CD657
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 07:53:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E30E23CB660
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 07:52:57 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 536A8601088
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 07:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705733574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k2tt3fWztt1HStqKxRQXun41tkqAd7o0l1HT2wdm6U4=;
 b=FP4R9KZ5bodmnTP1IVbYNJYCLLvJevANysXk0TfYP5Sq9c1o5hkD+GkKbmgsvTmmqYzsIt
 5PyW2MUs6QNlDmXylEKbf/0Ej1JQ3wYNnXEmmOA4HBhGrV2XC9BtWRqkVmkW709/ZQx7gD
 XSJswZWRMc6piHscGKQvQYk32FsCgHM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--hgll09LP4GsqHI9emaZZw-1; Sat, 20 Jan 2024 01:52:52 -0500
X-MC-Unique: -hgll09LP4GsqHI9emaZZw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bd4ba35a60so2692826b6e.3
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 22:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705733570; x=1706338370;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k2tt3fWztt1HStqKxRQXun41tkqAd7o0l1HT2wdm6U4=;
 b=uAIHXXA452dy5VpzDJUMdsmSyxFUT+JuOwPxyAccWDIqZ7urG7xAspgW1HTn0qnbjc
 yGeZ2+q5cLJQSeZhjBQRBXxJ8sdO1hj4xbAtrxe8ZHhzKdwgfXVuTLEHVuOWCv8IYEDj
 mGCpzx8+LDLGmPmPUk9QWhpG4zeCRvtr6JGGBTmt2YOYA/IMp1PeEyY6nIqccyRHhcBF
 IFxCwT1EqzikDMZVi22edJbVpMZDzusgwiu2GqqXdgNUhETVdc+UvkjDc9sXg5St2Q7c
 fWkw7zs3eThRXK6AGDz4GoI4iH1E+NOg0pH7SA1ePbE2HgwWOJaTE9gg7NUL4iwKWTpE
 HI7Q==
X-Gm-Message-State: AOJu0YwNJeZSE/o7ZqrN3TnPmTTSRW9Db7pQinpe8C0Fkqz8wjpZbmuO
 naMhFWxpz47j4+REHdDsXam00t4lFsWLgMjWXK7OU/aFK+1ipjQ/uTp6QvVrBxDmfff+0zZLuj2
 K5WXdC6Tq6fyrk+EF0WPqPNsZAz1VUS7ySC1lIm8c7tOgKP6u6CTsi1R+kAK8LfGPhcHMEiaz+Y
 Nt/1EWePkANH6glxr6V3I/HqM/iH/zgZ3rpvHg
X-Received: by 2002:a05:6808:18d:b0:3bd:9d8d:8f75 with SMTP id
 w13-20020a056808018d00b003bd9d8d8f75mr1177044oic.69.1705733570460; 
 Fri, 19 Jan 2024 22:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq4pcHQ0dPekknbmuTZfS/LOX5fsgTvpCGeCL4UdBpTBv0jAXvbCCbXWbmAGtD83p0jpHmDAgeslk6XYm4w1Y=
X-Received: by 2002:a05:6808:18d:b0:3bd:9d8d:8f75 with SMTP id
 w13-20020a056808018d00b003bd9d8d8f75mr1177033oic.69.1705733570099; Fri, 19
 Jan 2024 22:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20240120043412.2544860-2-liwang@redhat.com>
 <20240120064033.2547728-1-liwang@redhat.com>
In-Reply-To: <20240120064033.2547728-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Jan 2024 14:52:38 +0800
Message-ID: <CAEemH2cZXX2K3r3TFn5DKu7xJhWShtLZDvf+bmeAPzXTjpavtA@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: Improving test with memory limits and
 swap reporting
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBKYW4gMjAsIDIwMjQgYXQgMjo0MOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gVGhpcyBpcyB0YXJnZXQgdG8gY3JlYXRlIGEgbW9yZSByb2J1c3QgYW5k
IGNvbnRyb2xsZWQgZW52aXJvbm1lbnQgdG8gdGVzdAo+IHRoZSBzd2Fwb24gc3lzdGVtIGNhbGwu
IEJ5IGludHJvZHVjaW5nIG1lbW9yeSBsaW1pdHMgdGhyb3VnaCBjZ3JvdXBzIGFuZAo+IGZpbGxp
bmcgbWVtb3J5IHdpdGggYSBrbm93biBwYXR0ZXJuLCB0aGUgdGVzdCBjYW4gYmV0dGVyIGFzc2Vz
cyBzd2Fwb24KPiBiZWhhdmlvciB3aGVuIHRoZSBzeXN0ZW0gZXhwZXJpZW5jZXMgbWVtb3J5IHBy
ZXNzdXJlLgo+Cj4gQWRkaXRpb25hbGx5LCB0aGUgcmVwb3J0aW5nIG9mICJTd2FwQ2FjaGVkIiBt
ZW1vcnkgYmVmb3JlIHR1cm5pbmcgb2ZmIHRoZQo+IHN3YXAgZmlsZSBwcm92aWRlcyBhIGNsZWFy
ZXIgdW5kZXJzdGFuZGluZyBvZiB0aGUgc3dhcCBzeXN0ZW0ncyBzdGF0ZSBpbgo+IHJlc3BvbnNl
IHRvIHRoZSB0ZXN0IGNvbmRpdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24v
c3dhcG9uMDEuYyB8IDkgKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fw
b24wMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4g
aW5kZXggZTFmZTUwNDU5Li5mYWY0YTgwMDIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiBAQCAtMjAsNiArMjAsNyBAQAo+Cj4gICNkZWZpbmUg
TU5UUE9JTlQgICAgICAgIm1udHBvaW50Igo+ICAjZGVmaW5lIFNXQVBfRklMRSAgICAgIE1OVFBP
SU5UIi9zd2FwZmlsZTAxIgo+ICsjZGVmaW5lIFRFU1RNRU0gICAgICAgICAgICAgICAgKDFVTDw8
MzApCj4KPiAgc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBvbih2b2lkKQo+ICB7Cj4gQEAgLTI5LDEy
ICszMCwxOSBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCj4gICAgICAgICAgICAg
ICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiRmFpbGVkIHRvIHR1cm4gb2ZmIHN3YXBmaWxlLCBzeXN0ZW0KPiByZWJvb3QgcmVjb21t
ZW5kZWQiKTsKPiAgICAgICAgIH0KPiArCj4gKyAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3dhcENh
Y2hlZDogJWxkIEtiIiwKPiBTQUZFX1JFQURfTUVNSU5GTygiU3dhcENhY2hlZDoiKSk7Cj4gIH0K
Pgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICB7Cj4gICAgICAgICBpc19zd2FwX3N1cHBv
cnRlZChTV0FQX0ZJTEUpOwo+ICAgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDApOwo+
ICsKPiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNncm91cC5wcm9jcyIsICIlZCIs
IGdldHBpZCgpKTsKPiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgi
LCAiJWx1IiwgVEVTVE1FTSk7Cj4gKwo+ICsgICAgICAgdHN0X3BvbGx1dGVfbWVtb3J5KFRFU1RN
RU0sIDB4NDEpOwo+CgpPb3BzLCB0aGlzIHBvbGx1dGUgbWVtb3J5IHNob3VsZCBtb3ZlIHRvIHRo
ZSBiZWhpbmQgb2Ygc3dhcG9uLApJIGZvcmdldCB0byBzdWJtaXQgdGhlIGxhc3QgY2hhbmdlcyB3
aGVuIGZvcm1hdHRpbmcgdGhlIHBhdGNoLgoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zd2Fwb24vc3dhcG9uMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBv
bi9zd2Fwb24wMS5jCkBAIC0yNiwxMiArMjYsMTMgQEAgc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBv
bih2b2lkKQogewogICAgICAgIFRTVF9FWFBfUEFTUyh0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwg
U1dBUF9GSUxFLCAwKSk7CgorICAgICAgIHRzdF9wb2xsdXRlX21lbW9yeShURVNUTUVNLCAweDQx
KTsKKyAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3dhcENhY2hlZDogJWxkIEtiIiwKU0FGRV9SRUFE
X01FTUlORk8oIlN3YXBDYWNoZWQ6IikpOworCiAgICAgICAgaWYgKFRTVF9QQVNTICYmIHRzdF9z
eXNjYWxsKF9fTlJfc3dhcG9mZiwgU1dBUF9GSUxFKSAhPSAwKSB7CiAgICAgICAgICAgICAgICB0
c3RfYnJrKFRCUk9LIHwgVEVSUk5PLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJG
YWlsZWQgdG8gdHVybiBvZmYgc3dhcGZpbGUsIHN5c3RlbSByZWJvb3QKcmVjb21tZW5kZWQiKTsK
ICAgICAgICB9Ci0KLSAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3dhcENhY2hlZDogJWxkIEtiIiwK
U0FGRV9SRUFEX01FTUlORk8oIlN3YXBDYWNoZWQ6IikpOwogfQoKIHN0YXRpYyB2b2lkIHNldHVw
KHZvaWQpCkBAIC00MSw4ICs0Miw2IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCgogICAgICAg
IFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNncm91cC5wcm9jcyIsICIlZCIsIGdldHBpZCgpKTsK
ICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkubWF4IiwgIiVsdSIsIFRFU1RN
RU0pOwotCi0gICAgICAgdHN0X3BvbGx1dGVfbWVtb3J5KFRFU1RNRU0sIDB4NDEpOwogfQoKIHN0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
