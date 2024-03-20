Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDE5C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 13:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 537E13CFFB0
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 14:26:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C62093CD943
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 14:25:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5BB71400331
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 14:25:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710941141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tgqud+a5Ac/Kwv5nmL2DznCevA/9CY9Hc3LGP5Sfplc=;
 b=iOwWtgBns5hyz/IU7szsjEHfjFYYZdjoNlJ6XOQARNSJv2ZM+78toSRfT8MlgRH+t01kq1
 sP+Bz3ncwWTRx/YYJkK1Q8eMEUAygK+qKZrYiGA2vZ7r39nO65gF0KGShj3AeZSwMkr7oF
 BLoDsUkKE2Dx6rCpWcpyH0BziOT4Tjo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Ij3b8eGyMMWrgWlGxsCPlQ-1; Wed, 20 Mar 2024 09:25:40 -0400
X-MC-Unique: Ij3b8eGyMMWrgWlGxsCPlQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6e681587cb8so2835849a34.1
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710941139; x=1711545939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tgqud+a5Ac/Kwv5nmL2DznCevA/9CY9Hc3LGP5Sfplc=;
 b=OxcR7tkSXnyS9dsuEqgzB8YBDCYQXMv7BhzWYARFZfhHU3bp5uj1ofgWW4zpcJ/Kgo
 SoBEKy6sEWtaXIYxclvOAEh73zh318RgB1GISKqDqEF+Y+oJGRS+pA+Iyhx31rrkTezF
 maMavZF2EOZtlek+9mizknCAhU82pgel+eO3WPQi6fouf6plXU87iQ9x6bB6sTMmjeVy
 K6YL31FJkWrvQJeEJEpa7qrlJm0ZQPQXGi4Jc4W0xaMGy1/GUMIgmxc0dLnUtwSmV9GL
 5fRERArhZvs3S4o8Tshvlk9SdJuyv/aeeQHSHzphzGRZuEYvYUaOtZCeTicTNj0ik8MG
 kewA==
X-Gm-Message-State: AOJu0Yyapoer6uPdTlCXTFpnJ8l/IL+rUfWPNnHOOMlYNwKkUvAmKiMF
 Ms6tGffDz2kkQ+SN6phYZ6ksKLOFqlPTpU+SyKxsglvdOiOmsV21nBKm56V16qafNeQykV6yzHe
 fdWwJyRaFX9hF8o3Ytre/z2Mbr9ExdDExunnenTYM+5cefJ/9G7z7uEWb8KRz3g5h3cYtTXN+WB
 +YfRHBTlqjgw19yh+dWCejSvtMthLlpFEYtA==
X-Received: by 2002:a05:6808:11cb:b0:3c3:8645:6948 with SMTP id
 p11-20020a05680811cb00b003c386456948mr5378199oiv.16.1710941139335; 
 Wed, 20 Mar 2024 06:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFBL1Q05UihQrYPmDVdyTOwVbtCPWC7hy/7NlVTTHbOdP+U5UCjchBviSNzMN7VSZnahUbXeNCUoxTADsr4So=
X-Received: by 2002:a05:6808:11cb:b0:3c3:8645:6948 with SMTP id
 p11-20020a05680811cb00b003c386456948mr5378185oiv.16.1710941139064; Wed, 20
 Mar 2024 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-2-chrubis@suse.cz>
In-Reply-To: <20240320095927.19973-2-chrubis@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Mar 2024 14:26:15 +0100
Message-ID: <CAASaF6zEUC6D6zGcgKXorcrOFEXeMxvuDXUcgC7VX6L978Lshw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: Add test for splicing from
 /dev/zero and /dev/full
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

T24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMTE6MDHigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBCb3RoIG9mIHRoZXNlIGRldmljZXMgcHJvZHVjZSB6ZXJvZXMg
d2hlbiByZWFkLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2Uu
Y3o+Cj4gLS0tCj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlLy5naXRpZ25vcmUgfCAg
MSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlL3NwbGljZTA4LmMgfCA4OCAr
KysrKysrKysrKysrKysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCsp
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9z
cGxpY2UwOC5jCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lz
Y2FsbHMKPiBpbmRleCA0ZWQyYjU2MDIuLjA4ODlmNThhMSAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0
L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0xNTE3LDYgKzE1MTcsNyBA
QCBzcGxpY2UwNCBzcGxpY2UwNAo+ICBzcGxpY2UwNSBzcGxpY2UwNQo+ICBzcGxpY2UwNiBzcGxp
Y2UwNgo+ICBzcGxpY2UwNyBzcGxpY2UwNwo+ICtzcGxpY2UwOCBzcGxpY2UwOAo+Cj4gIHRlZTAx
IHRlZTAxCj4gIHRlZTAyIHRlZTAyCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3BsaWNlLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGlj
ZS8uZ2l0aWdub3JlCj4gaW5kZXggODhhOGRmZjc4Li45NDUzY2Y5M2EgMTAwNjQ0Cj4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zcGxpY2UvLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlLy5naXRpZ25vcmUKPiBAQCAtNSwzICs1LDQgQEAK
PiAgL3NwbGljZTA1Cj4gIC9zcGxpY2UwNgo+ICAvc3BsaWNlMDcKPiArL3NwbGljZTA4Cj4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlL3NwbGljZTA4LmMgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwOC5jCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLmNkZDUxYjY2Ywo+IC0tLSAvZGV2L251bGwKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwOC5jCj4gQEAgLTAs
MCArMSw4OCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiArICog
VGVzdCBmb3Igc3BsaWNpbmcgZnJvbSAvZGV2L3plcm8gYW5kIC9kZXYvZnVsbC4KPiArICoKPiAr
ICogVGhlIHN1cHBvcnQgZm9yIHNwbGljaW5nIGZyb20gL2Rldi96ZXJvIGFuZCAvZGV2L2Z1bGwg
d2FzIHJlbW92ZWQgaW46Cj4gKyAqIGM2NTg1MDExYmMxZCAoInNwbGljZTogUmVtb3ZlIGdlbmVy
aWNfZmlsZV9zcGxpY2VfcmVhZCgpIikKPiArICoKPiArICogQW5kIGFkZGVkIGJhY2sgaW46Cj4g
KyAqIDFiMDU3YmQ4MDBjMyAoImRyaXZlcnMvY2hhci9tZW06IGltcGxlbWVudCBzcGxpY2UoKSBm
b3IgL2Rldi96ZXJvLCAvZGV2L2Z1bGwiKQo+ICsgKi8KPiArCj4gKyNkZWZpbmUgX0dOVV9TT1VS
Q0UKPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICtzdGF0aWMgaW50IGZkX3plcm87Cj4g
K3N0YXRpYyBpbnQgZmRfZnVsbDsKPiArCj4gK3N0YXRpYyB2b2lkIHRlc3Rfc3BsaWNlKHVuc2ln
bmVkIGludCBieXRlcywgaW50IGRldl9mZCkKPiArewo+ICsgICAgICAgaW50IHBpcGVmZFsyXTsK
PiArICAgICAgIGNoYXIgYnVmW2J5dGVzXTsKPiArICAgICAgIHNpemVfdCBpOwo+ICsgICAgICAg
aW50IGZhaWwgPSAwOwo+ICsKPiArICAgICAgIG1lbXNldChidWYsIDB4ZmYsIHNpemVvZihidWYp
KTsKPiArCj4gKyAgICAgICBTQUZFX1BJUEUocGlwZWZkKTsKPiArCj4gKyAgICAgICBUU1RfRVhQ
X1BPU0lUSVZFKHNwbGljZShkZXZfZmQsIE5VTEwsIHBpcGVmZFsxXSwgTlVMTCwgc2l6ZW9mKGJ1
ZiksIDApKTsKCkJvdGggbG9vayBnb29kIHRvIG1lLCBqdXN0IGN1cmlvdXMgaWYgeW91IG1lYW50
IHRvIGNoZWNrIFRTVF9SRVQKYWdhaW5zdCBzaXplb2YoYnVmKSBoZXJlCmFzIHlvdSBkaWQgaW4g
c3BsaWNlMDkuCgo+ICsKPiArICAgICAgIGlmICghVFNUX1BBU1MpCj4gKyAgICAgICAgICAgICAg
IGdvdG8gcmV0Owo+ICsKPiArICAgICAgIFNBRkVfUkVBRCgxLCBwaXBlZmRbMF0sIGJ1Ziwgc2l6
ZW9mKGJ1ZikpOwo+ICsKPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaXplb2YoYnVmKTsgaSsr
KSB7Cj4gKyAgICAgICAgICAgICAgIGlmIChidWZbaV0pCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZmFpbCsrOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIGlmIChmYWlsKQo+ICsgICAgICAg
ICAgICAgICB0c3RfcmVzKFRGQUlMLCAiTm9uLXplcm8gYnl0ZXMgc3BsaWNlZCBmcm9tIC9kZXYv
emVybyIpOwo+ICsgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRQQVNTLCAi
QWxsIGJ5dGVzIHNwbGljZWQgZnJvbSAvZGV2L3plcm8gYXJlIHplcm9lZCIpOwo+ICsKPiArcmV0
Ogo+ICsgICAgICAgU0FGRV9DTE9TRShwaXBlZmRbMF0pOwo+ICsgICAgICAgU0FGRV9DTE9TRShw
aXBlZmRbMV0pOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB2ZXJpZnlfc3BsaWNlKHVuc2lnbmVk
IGludCBuKQo+ICt7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgYnl0ZXMgPSAxMDA5ICogbjsKPiAr
Cj4gKyAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3BsaWNpbmcgJXUgYnl0ZXMgZnJvbSAvZGV2L3pl
cm8iLCBieXRlcyk7Cj4gKyAgICAgICB0ZXN0X3NwbGljZShieXRlcywgZmRfemVybyk7Cj4gKyAg
ICAgICB0c3RfcmVzKFRJTkZPLCAiU3BsaWNpbmcgJXUgYnl0ZXMgZnJvbSAvZGV2L2Z1bGwiLCBi
eXRlcyk7Cj4gKyAgICAgICB0ZXN0X3NwbGljZShieXRlcywgZmRfZnVsbCk7Cj4gK30KPiArCj4g
K3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiArICAgICAgIGZkX3plcm8gPSBTQUZFX09Q
RU4oIi9kZXYvemVybyIsIE9fUkRPTkxZKTsKPiArICAgICAgIGZkX2Z1bGwgPSBTQUZFX09QRU4o
Ii9kZXYvZnVsbCIsIE9fUkRPTkxZKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgY2xlYW51cCh2
b2lkKQo+ICt7Cj4gKyAgICAgICBpZiAoZmRfemVybyA+IDApCj4gKyAgICAgICAgICAgICAgIFNB
RkVfQ0xPU0UoZmRfemVybyk7Cj4gKwo+ICsgICAgICAgaWYgKGZkX2Z1bGwgPiAwKQo+ICsgICAg
ICAgICAgICAgICBTQUZFX0NMT1NFKGZkX2Z1bGwpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKyAgICAgICAudGVzdCA9IHZlcmlmeV9zcGxpY2UsCj4gKyAg
ICAgICAudGNudCA9IDksCj4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiArICAgICAgIC5jbGVh
bnVwID0gY2xlYW51cCwKPiArICAgICAgIC5taW5fa3ZlciA9ICI2LjciLAo+ICt9Owo+IC0tCj4g
Mi40My4yCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
