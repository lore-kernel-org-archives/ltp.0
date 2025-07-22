Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2844DC83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:32:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81F3B3CCCD5
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:32:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB53F3C58D0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:18:21 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BB96600A7D
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:18:21 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-31393526d0dso3770579a91.0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753190299; x=1753795099; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEeXCGOODZC7aRv3RU4bBqjeFEswXN0Dj+1HG7cmRXQ=;
 b=AmCxaKBJvLCeq+w/uWvL4dinWy5/B9RXpHyGI+2GlY2y00IpCtMDjGTWbmM9oaJgxB
 APqOa6zwqzUoZ+TP7m1GZSG98J+KegkwjACbhjxkvqVPnu998kpMLg1k/hzwpkBAmBQ4
 8o0ZF+8rZrjIZA149jPUBziuN52J9Az35fld05ItNnmBZh/g9aWQMsEjufL9jftU5nCB
 QU9wyowS97AahlcHEZAogopqy/1RxO9EvZQqvV9+ghN1wT7u+kp8jCK5YxrifNqNQefi
 6hdggQ6GZ2wlwIwlqH2EUo1TQLz35iMNV+NEPDqueIDJhHzR8vUED4KQOz3klUWzQuqT
 7STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753190299; x=1753795099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEeXCGOODZC7aRv3RU4bBqjeFEswXN0Dj+1HG7cmRXQ=;
 b=J2IZudGzRU2cXAYbnANScbvEtt/sWOqjIktz6DAT9B/5iFVXZF+PuDd5A/F+3whQ+R
 909NokD72TyGDPIZzBjt8uO4M59U4TI6cQpjOTyrZb2wt7FqkxTW1AMgSn7wiCLHs9Fj
 VfJWaSHHYdK6UBlQzFSPI3bp8OzsQKoZVopFsdTHn568kGQEtn0JXH572Wl+fmYgu9Ax
 GazV38DIB2AFB133a4pAn4u+bdAeCpVsrUKfxWX4XJC4cZ5tKiNum7mYVTrSUx8RSPip
 4HAc+ccgmaalPyeStDUhoZO1lZTNWbeu1g6JCKs0AG8uplYQq/lWPdsl6tuR7XDwjWvn
 rzJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgh3YUQdw2hAF05FyDd7tV44JKUs22rbSOm1G2rBYjxfX7KtP72E23HsR5RtIdJ6rI2H4=@lists.linux.it
X-Gm-Message-State: AOJu0YzIjyek7gvjclbi7qYPf06gfOuGdJ1wIurfcyNtWmE0QjJDpwlT
 lVbMa0djV+9uvmxmUDM3oX9AVJAhgXYKHAfU+bqVqxp9TEIcTN0pN11SVqZiMj7xI9EYVGBb7Dw
 g5+Si0LGfEH1LssXpmiDHQ+5g+3jsugo=
X-Gm-Gg: ASbGncuoGXfTY1dodKTJQKryUfMd88njmhNtJ2hFacQ8bL0xaO9x7iDPiq6oPmzIwwp
 Gbf7LgVGFKxjQDtoGqP4apO9LZEynXiS57HZdvJXL5wqAI1gKx0Nd7LaRbnQK0OhgE+REoQ5QVX
 4BlulnZB6SZWRNraCB5ILjGQqFRdxPIamzEfx/2Sb1WxYC89KEWmeTVRSOPjF2xjIabR4ZUlMsk
 +IUX/U=
X-Google-Smtp-Source: AGHT+IFtls9xip3OkKsN5G6tSID46f4bBnuPYBNziKaPjc49x6urJfFhsU8cV9nK8hdINQIv2Bz/lHePq+TPlpSNdwo=
X-Received: by 2002:a17:90b:4a8d:b0:311:eb85:96f0 with SMTP id
 98e67ed59e1d1-31cc25e80b9mr25681472a91.29.1753190299246; Tue, 22 Jul 2025
 06:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
In-Reply-To: <20250722120635.GB22975@pevik>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 09:18:07 -0400
X-Gm-Features: Ac12FXx9I-En97iGRCaT64y_SBV8CaxYnupMJT_ZA-c9qxgtw69HOxef8divPTM
Message-ID: <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 22 Jul 2025 15:32:02 +0200
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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

T24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgODowNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFuZHJlYSwgYWxsLAo+Cj4gWyBDYyBTdGVwaGVuLCB0aGUgZml4
IGF1dGhvciBpbiBjYXNlIEknbSB3cm9uZyB3aXRoIHJlcHJvZHVjaW5nIG9uIGVuZm9yY2luZz0w
IF0KPgo+ID4gQWRkIHRzdF9zZWxpbnV4X2VuYWJsZWQoKSB1dGlsaXR5IGluIHRzdF9zZWN1cml0
eS5oIGluIG9yZGVyIHRvIHZlcmlmeQo+ID4gaWYgU0VMaW51eCBpcyBjdXJyZW50bHkgdXAgYW5k
IHJ1bm5pbmcgaW4gdGhlIHN5c3RlbS4KPiAuLi4KPiA+ICtpbnQgdHN0X3NlbGludXhfZW5hYmxl
ZCh2b2lkKQo+ID4gK3sKPiA+ICsgICAgIGludCByZXMgPSAwOwo+ID4gKwo+ID4gKyAgICAgaWYg
KHRzdF9pc19tb3VudGVkKFNFTElOVVhfUEFUSCkpCj4gPiArICAgICAgICAgICAgIHJlcyA9IDE7
Cj4KPiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgdGhlIHRlc3QgcmVxdWlyZSBlbmZvcmNpbmcgb3Ig
bm90IHRoZXJlZm9yZSBJIHJldGVzdGVkIGl0Cj4gYW5kIGl0J3MgcmVhbGx5IHJlcHJvZHVjaWJs
ZSB3aXRoIHBlcm1pc3NpdmUgbW9kZSwgaS5lLiB3aXRoIGtlcm5lbCBjb21tYW5kIGxpbmUKPiBz
ZWN1cml0eT1zZWxpbnV4IHNlbGludXg9MSBlbmZvcmNpbmc9MAo+Cj4gQmVjYXVzZSBpZiBlbmZv
cmNpbmcgd2FzIHJlcXVpcmVkLCBJIHdvdWxkIGJlIGZvciB1c2luZyB0c3Rfc2VsaW51eF9lbmZv
cmNpbmcoKSwKPiB3aGljaCBjaGVja3MgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2UgZm9yIDEgYXMg
V2VpIHN1Z2dlc3RlZCBpbiB2MzoKPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9hSGY4
MzlXUzBCUElhNVpxQE1pV2lGaS1DUjY2MDgtc3J2Lwo+Cj4gQEN5cmlsIEBBbmRyZWEsIGp1c3Qg
Y2hlY2tpbmcgaWYgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2UgZXhpc3RzIHdvdWxkIGJlIGZhc3Rl
cgo+IHRoYW4gbG9vcGluZyAvcHJvYy9tb3VudHMgKHZpYSB0c3RfaXNfbW91bnRlZChTRUxJTlVY
X1BBVEgpKS4gQ2FuIHdlIGp1c3QgbW9kaWZ5Cj4gdGhlIHBhdGNoPwoKTm90IHN1cmUgaWYgSSBo
YXZlIHRoZSBmdWxsIGNvbnRleHQsIGJ1dCBtb2Rlcm4gbGlic2VsaW51eCBoYXMgdGhpcwpmb3Ig
aXNfc2VsaW51eF9lbmFibGVkKCk6CgppbnQgaXNfc2VsaW51eF9lbmFibGVkKHZvaWQpCnsKICAg
ICAgICAvKiBpbml0X3NlbGludXhtbnQoKSBnZXRzIGNhbGxlZCBiZWZvcmUgdGhpcyBmdW5jdGlv
bi4gV2UKICAgICAgICAgKiB3aWxsIGFzc3VtZSB0aGF0IGlmIGEgc2VsaW51eCBmaWxlIHN5c3Rl
bSBpcyBtb3VudGVkLCB0aGVuCiAgICAgICAgICogc2VsaW51eCBpcyBlbmFibGVkLiAqLwojaWZk
ZWYgQU5EUk9JRAogICAgICAgIHJldHVybiAoc2VsaW51eF9tbnQgPyAxIDogMCk7CiNlbHNlCiAg
ICAgICAgcmV0dXJuIChzZWxpbnV4X21udCAmJiBoYXNfc2VsaW51eF9jb25maWcpOwojZW5kaWYK
fQoKQW5kIGluaXRfc2VsaW51eG1udCgpLCBhIGNvbnN0cnVjdG9yIGZvciBsaWJzZWxpbnV4LCBk
b2VzIHRoaXM6CgpzdGF0aWMgdm9pZCBpbml0X3NlbGludXhtbnQodm9pZCkKewogICAgICAgIGNo
YXIgKmJ1ZiA9IE5VTEwsICpwOwogICAgICAgIEZJTEUgKmZwID0gTlVMTDsKICAgICAgICBzaXpl
X3QgbGVuOwogICAgICAgIHNzaXplX3QgbnVtOwoKICAgICAgICBpZiAoc2VsaW51eF9tbnQpCiAg
ICAgICAgICAgICAgICByZXR1cm47CgogICAgICAgIGlmICh2ZXJpZnlfc2VsaW51eG1udChTRUxJ
TlVYTU5UKSA9PSAwKSByZXR1cm47CgogICAgICAgIGlmICh2ZXJpZnlfc2VsaW51eG1udChPTERT
RUxJTlVYTU5UKSA9PSAwKSByZXR1cm47CgogICAgICAgIC8qIERyb3AgYmFjayB0byBkZXRlY3Rp
bmcgaXQgdGhlIGxvbmcgd2F5LiAqLwogICAgICAgIGlmICghc2VsaW51eGZzX2V4aXN0cygpKQog
ICAgICAgICAgICAgICAgZ290byBvdXQ7Ci4uLgoKU28gaW4gdGhlIGNvbW1vbiBjYXNlIHdlIGRv
bid0IG5lZWQgdG8gY2hlY2sgL3Byb2MvbW91bnRzIG9yCi9wcm9jL2ZpbGVzeXN0ZW1zLCBvbmx5
IGlmIHdlIGRvbid0IGZpbmQgc2VsaW51eGZzIG9uIG9uZSBvZiB0aGUKZXhwZWN0ZWQgbW91bnQg
ZGlyZWN0b3JpZXMgKC9zeXMvZnMvc2VsaW51eCBvciAvc2VsaW51eCkuCgo+Cj4gS2luZCByZWdh
cmRzLAo+IFBldHIKPgo+ICsrKyBsaWIvdHN0X3NlY3VyaXR5LmMKPiBAQCAtMTA3LDcgKzEwNyw3
IEBAIGludCB0c3Rfc2VsaW51eF9lbmFibGVkKHZvaWQpCj4gIHsKPiAgICAgICAgIGludCByZXMg
PSAwOwo+Cj4gLSAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoU0VMSU5VWF9QQVRIKSkKPiArICAg
ICAgIGlmIChhY2Nlc3MoU0VMSU5VWF9TVEFUVVNfUEFUSCwgRl9PSykgPT0gMCkKPiAgICAgICAg
ICAgICAgICAgcmVzID0gMTsKPgo+ICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlNFTGludXggZW5h
YmxlZDogJXMiLCByZXMgPyAieWVzIiA6ICJubyIpOwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
