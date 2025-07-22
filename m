Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311C1C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:49:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 958E03CCC5F
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:49:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843143C58D0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:48:44 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7E801400BCF
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:48:43 +0200 (CEST)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-31ca042d3b8so4428673a91.0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753192122; x=1753796922; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDPUUixTj+Is86ImKmSnL7sIjmrqLTtJsc2/2WaEW4s=;
 b=dF4tgfEzasyz4/grEkgydC04qzEx4NCE9XBOHKzRjrhVvicICfntb+HD+bLFmGbqWR
 OOMyTC5tjKoh1ZBjOzwqnOJGhJFRrdS5maL32cT7F7apQH5+5yH6Xi45ktnYjS37NVOd
 YvLriy+9WSS1+ewHm6rYF1BCc7Dy/nIkdnBpjuau39Qa/a5pxspJYoec3lkBVSgtPM96
 +VoeyAQ4DbfBndmZY6h9mzz7I/qm5rgfvrdQZ4/uqvDiv/NfUO3ArebpQjRPJ2YGOFK6
 UaZJLK++RDJQ5sJfQcYyxGr03Gi1Frbhym3i8zOfMyieqT8igLPLBZHqQxMDjMX86PGw
 7xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753192122; x=1753796922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDPUUixTj+Is86ImKmSnL7sIjmrqLTtJsc2/2WaEW4s=;
 b=MKeuFiQBTK0weFEu1+xTyoDJmgFQ5mQEEbSA8Q53f3UdWF0NsbdHdNKWgxdvaQTC9+
 g+PAeYrqdQRzl5htvyTRptEvAT09gEyZAz2I8lShP6MQiZund3zl0hNloUU/DSWOthEC
 xJTkUeRSmYpa3rNj3n1cY4YuWS4HyROyFfeg4Nx/VFwbuoEKFTKaItW/4W8gn0DLu/z9
 Ez07+96R8papneF7PzfAcUBwQOhgk9gEdJJXvp06bZebix3LS1HLKExuB8AdN0OHsCOx
 V/ze7pZfCIywW6k0mTvjsY6rJmRFv84iaPtI/vWtoGgPuShtnAArYpmwUi+G7yBLrBEs
 XCgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViT2I06MYoqxZ+2LbuD4kUGhbk66bIYs01EeuhbsdXzCp4WTPD/4g1Xt3R2dsMArFXKIM=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/Mq5kmPZf+OctARPYJRgxo39iVselMF6XeajeYS2g1ZA3rOPh
 V0Byts5WhcR9Hi/0OklJUqFsM8cVnBI8XFFm3AYE+GeohTt7RRZEKaeKvkGQ6tZ8WUY0BrDYXN7
 CRuFiK8Ojxl37L3UT9NZmUG19P+uNTlM=
X-Gm-Gg: ASbGncseLfMbVDxvBrqD+UvkIID/vLoGdJEW21MvTM/CSzdYwAXcF9ejR/S1uPYlmGE
 meCsmA313bnYrEHxwCcZTcyYwMAdCtFwbWrBuwWCsUiwv2hFB7BseXA0PzZJE+EtcTnyCa63wJk
 0T+WS2xohr/gjxrEjQQUOBaU1ss47KacYo8Dd00yZE5hu8to5f/CdREd9rwWykwuLWxkmsqFmM2
 FYCMcqdk8a4elvfxA==
X-Google-Smtp-Source: AGHT+IG27RjTKM1N5tS51kvu9BwTP4A2GGjBVcotJCmgurcZlsR42ebpb3lKOdpAQZ9b04cj4N2CWkrfBIWvXIV5fs8=
X-Received: by 2002:a17:90b:3b83:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31c9e703722mr36138119a91.15.1753192122187; Tue, 22 Jul 2025
 06:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
 <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
 <20250722134246.GA84869@pevik>
In-Reply-To: <20250722134246.GA84869@pevik>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 09:48:30 -0400
X-Gm-Features: Ac12FXxXCbmpbuT64Bwn85qXNvpOTUg8sqX72Nlp6aU93-zn4k0AIcdYF7maRWY
Message-ID: <CAEjxPJ66s+UsDXAbgewkA+h3Djq31FMb6pBF2NSZiV7LCH_Jmg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgOTo0MuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIFN0ZXBoZW4sIGFsbCwKPgo+ID4gT24gVHVlLCBKdWwgMjIsIDIw
MjUgYXQgOToxOOKAr0FNIFN0ZXBoZW4gU21hbGxleQo+ID4gPHN0ZXBoZW4uc21hbGxleS53b3Jr
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiA+ID4gT24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgODowNuKA
r0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiA+IEhpIEFuZHJl
YSwgYWxsLAo+Cj4gPiA+ID4gWyBDYyBTdGVwaGVuLCB0aGUgZml4IGF1dGhvciBpbiBjYXNlIEkn
bSB3cm9uZyB3aXRoIHJlcHJvZHVjaW5nIG9uIGVuZm9yY2luZz0wIF0KPgo+ID4gPiA+ID4gQWRk
IHRzdF9zZWxpbnV4X2VuYWJsZWQoKSB1dGlsaXR5IGluIHRzdF9zZWN1cml0eS5oIGluIG9yZGVy
IHRvIHZlcmlmeQo+ID4gPiA+ID4gaWYgU0VMaW51eCBpcyBjdXJyZW50bHkgdXAgYW5kIHJ1bm5p
bmcgaW4gdGhlIHN5c3RlbS4KPiA+ID4gPiAuLi4KPiA+ID4gPiA+ICtpbnQgdHN0X3NlbGludXhf
ZW5hYmxlZCh2b2lkKQo+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ICsgICAgIGludCByZXMgPSAwOwo+
ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyAgICAgaWYgKHRzdF9pc19tb3VudGVkKFNFTElOVVhfUEFU
SCkpCj4gPiA+ID4gPiArICAgICAgICAgICAgIHJlcyA9IDE7Cj4KPiA+ID4gPiBJIHdhcyB3b25k
ZXJpbmcgaWYgaXQgdGhlIHRlc3QgcmVxdWlyZSBlbmZvcmNpbmcgb3Igbm90IHRoZXJlZm9yZSBJ
IHJldGVzdGVkIGl0Cj4gPiA+ID4gYW5kIGl0J3MgcmVhbGx5IHJlcHJvZHVjaWJsZSB3aXRoIHBl
cm1pc3NpdmUgbW9kZSwgaS5lLiB3aXRoIGtlcm5lbCBjb21tYW5kIGxpbmUKPiA+ID4gPiBzZWN1
cml0eT1zZWxpbnV4IHNlbGludXg9MSBlbmZvcmNpbmc9MAo+Cj4gPiA+ID4gQmVjYXVzZSBpZiBl
bmZvcmNpbmcgd2FzIHJlcXVpcmVkLCBJIHdvdWxkIGJlIGZvciB1c2luZyB0c3Rfc2VsaW51eF9l
bmZvcmNpbmcoKSwKPiA+ID4gPiB3aGljaCBjaGVja3MgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2Ug
Zm9yIDEgYXMgV2VpIHN1Z2dlc3RlZCBpbiB2MzoKPgo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2x0cC9hSGY4MzlXUzBCUElhNVpxQE1pV2lGaS1DUjY2MDgtc3J2Lwo+Cj4gPiA+ID4g
QEN5cmlsIEBBbmRyZWEsIGp1c3QgY2hlY2tpbmcgaWYgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2Ug
ZXhpc3RzIHdvdWxkIGJlIGZhc3Rlcgo+ID4gPiA+IHRoYW4gbG9vcGluZyAvcHJvYy9tb3VudHMg
KHZpYSB0c3RfaXNfbW91bnRlZChTRUxJTlVYX1BBVEgpKS4gQ2FuIHdlIGp1c3QgbW9kaWZ5Cj4g
PiA+ID4gdGhlIHBhdGNoPwo+Cj4gPiA+IE5vdCBzdXJlIGlmIEkgaGF2ZSB0aGUgZnVsbCBjb250
ZXh0LCBidXQgbW9kZXJuIGxpYnNlbGludXggaGFzIHRoaXMKPiA+ID4gZm9yIGlzX3NlbGludXhf
ZW5hYmxlZCgpOgo+Cj4gPiA+IGludCBpc19zZWxpbnV4X2VuYWJsZWQodm9pZCkKPiA+ID4gewo+
ID4gPiAgICAgICAgIC8qIGluaXRfc2VsaW51eG1udCgpIGdldHMgY2FsbGVkIGJlZm9yZSB0aGlz
IGZ1bmN0aW9uLiBXZQo+ID4gPiAgICAgICAgICAqIHdpbGwgYXNzdW1lIHRoYXQgaWYgYSBzZWxp
bnV4IGZpbGUgc3lzdGVtIGlzIG1vdW50ZWQsIHRoZW4KPiA+ID4gICAgICAgICAgKiBzZWxpbnV4
IGlzIGVuYWJsZWQuICovCj4gPiA+ICNpZmRlZiBBTkRST0lECj4gPiA+ICAgICAgICAgcmV0dXJu
IChzZWxpbnV4X21udCA/IDEgOiAwKTsKPiA+ID4gI2Vsc2UKPiA+ID4gICAgICAgICByZXR1cm4g
KHNlbGludXhfbW50ICYmIGhhc19zZWxpbnV4X2NvbmZpZyk7Cj4gPiA+ICNlbmRpZgo+ID4gPiB9
Cj4KPiBUaGFua3MgZm9yIHlvdXIgcG9pbnRzLiAgWWVzLCB3ZSBhbHNvIGxvb2tlZCBpbnRvIHNl
bGludXggc291cmNlcyBob3cKPiBzZWxpbnV4X21udCBpcyBhc3NpZ25lZC4KPgo+IEZZSSAocHJv
YmFibHkgb2J2aW91cykgd2UgZG9uJ3Qgd2FudCB0byB1c2UgbGlic2VsaW51eCB0byBrZWVwIExU
UCBkZXBlbmRlbmNpZXMKPiBtaW5pbWFsLiBBbHNvLCB3ZSBkb24ndCByZWFsbHkgbmVlZCB0aGF0
IHByZWNpc2UgY2hlY2tzIGFzIGRldGVjdGluZyBwcm9wZXJseSBpbgo+IGNocm9vdCBldGMgd2hp
Y2ggaXMgaW4gdGhlIGxpYnNlbGludXggKGluIHNlbGludXhfaW5pdF9sb2FkX3BvbGljeSgpKS4g
SU1ITyBteQo+IHN1Z2dlc3Rpb24gZm9yIGNoZWNraW5nIGlmIC9zeXMvZnMvc2VsaW51eC9lbmZv
cmNlIGV4aXN0cyAoZm9yIGVuYWJsZWQgU0VMaW51eAo+IHJlZ2FyZGxlc3MgaWYgZW5mb3JjaW5n
IG9yIHBlcm1pc3NpdmUpIG9yIHdoZXRoZXIgdGhlIHZhbHVlIGlzIDEgKGZvciBlbmFibGVkCj4g
U0VMaW51eCBlbmZvcmNlbWVudCkgaXMgZW5vdWdoLgoKSSBndWVzcyBteSBvbmx5IHF1ZXN0aW9u
IGhlcmUgaXMgd2hldGhlciB0aGUgdGVzdHMgYWxsIHJlcXVpcmUgU0VMaW51eAp0byBiZSBlbmZv
cmNpbmcgb3IgaWYgc29tZSBvZiB0aGVtIGFyZSBqdXN0IGV4ZXJjaXNpbmcgU0VMaW51eApmdW5j
dGlvbmFsaXR5IHRoYXQgd291bGQgYWxzbyBwYXNzIHdoZW4gcGVybWlzc2l2ZS4gQW5kIHdoZXRo
ZXIgeW91CmNhcmUgYWJvdXQgdGVzdGluZyB0aGF0IGNhc2UuCgo+Cj4gPiA+IEFuZCBpbml0X3Nl
bGludXhtbnQoKSwgYSBjb25zdHJ1Y3RvciBmb3IgbGlic2VsaW51eCwgZG9lcyB0aGlzOgo+Cj4g
PiA+IHN0YXRpYyB2b2lkIGluaXRfc2VsaW51eG1udCh2b2lkKQo+ID4gPiB7Cj4gPiA+ICAgICAg
ICAgY2hhciAqYnVmID0gTlVMTCwgKnA7Cj4gPiA+ICAgICAgICAgRklMRSAqZnAgPSBOVUxMOwo+
ID4gPiAgICAgICAgIHNpemVfdCBsZW47Cj4gPiA+ICAgICAgICAgc3NpemVfdCBudW07Cj4KPiA+
ID4gICAgICAgICBpZiAoc2VsaW51eF9tbnQpCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm47
Cj4KPiA+ID4gICAgICAgICBpZiAodmVyaWZ5X3NlbGludXhtbnQoU0VMSU5VWE1OVCkgPT0gMCkg
cmV0dXJuOwo+Cj4gPiA+ICAgICAgICAgaWYgKHZlcmlmeV9zZWxpbnV4bW50KE9MRFNFTElOVVhN
TlQpID09IDApIHJldHVybjsKPgo+ID4gPiAgICAgICAgIC8qIERyb3AgYmFjayB0byBkZXRlY3Rp
bmcgaXQgdGhlIGxvbmcgd2F5LiAqLwo+ID4gPiAgICAgICAgIGlmICghc2VsaW51eGZzX2V4aXN0
cygpKQo+ID4gPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiA+IC4uLgo+Cj4gPiA+IFNv
IGluIHRoZSBjb21tb24gY2FzZSB3ZSBkb24ndCBuZWVkIHRvIGNoZWNrIC9wcm9jL21vdW50cyBv
cgo+ID4gPiAvcHJvYy9maWxlc3lzdGVtcywgb25seSBpZiB3ZSBkb24ndCBmaW5kIHNlbGludXhm
cyBvbiBvbmUgb2YgdGhlCj4gPiA+IGV4cGVjdGVkIG1vdW50IGRpcmVjdG9yaWVzICgvc3lzL2Zz
L3NlbGludXggb3IgL3NlbGludXgpLgo+Cj4gPiBBbHNvLCBmb3IgcmVmZXJlbmNlLCB2ZXJpZnlf
c2VsaW51eG1udCgpIGlzIGFzIGZvbGxvd3M6Cj4KPiA+IHN0YXRpYyBpbnQgdmVyaWZ5X3NlbGlu
dXhtbnQoY29uc3QgY2hhciAqbW50KQo+ID4gewo+ID4gICAgICAgICBzdHJ1Y3Qgc3RhdGZzIHNm
YnVmOwo+ID4gICAgICAgICBpbnQgcmM7Cj4KPiA+ICAgICAgICAgZG8gewo+ID4gICAgICAgICAg
ICAgICAgIHJjID0gc3RhdGZzKG1udCwgJnNmYnVmKTsKPiA+ICAgICAgICAgfSB3aGlsZSAocmMg
PCAwICYmIGVycm5vID09IEVJTlRSKTsKPiA+ICAgICAgICAgaWYgKHJjID09IDApIHsKPiA+ICAg
ICAgICAgICAgICAgICBpZiAoKHVpbnQzMl90KXNmYnVmLmZfdHlwZSA9PSAodWludDMyX3QpU0VM
SU5VWF9NQUdJQykgewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHN0YXR2ZnMg
dmZzYnVmOwo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmMgPSBzdGF0dmZzKG1udCwgJnZm
c2J1Zik7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmMgPT0gMCkgewo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoISh2ZnNidWYuZl9mbGFnICYgU1RfUkRP
TkxZKSkgewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNldF9z
ZWxpbnV4bW50KG1udCk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB9Cj4gPiAgICAgICAgICAgICAgICAgfQo+ID4gICAgICAgICB9Cj4KPiA+
ICAgICAgICAgcmV0dXJuIC0xOwo+ID4gfQo+Cj4gSW50ZXJlc3RpbmcsIEkgd2FzIG5vdCBhd2Fy
ZSBvZiBTRUxJTlVYX01BR0lDLgo+Cj4gRm9yIG1lIHdhcyBtb3JlIGluZm9ybWF0aXZlIGhvdyB0
aGUgc2V0dXAgd29ya3MgdG8gc2VlIHNlbGludXhfaW5pdF9sb2FkX3BvbGljeSgpCj4KPiBodHRw
czovL2dpdGh1Yi5jb20vU0VMaW51eFByb2plY3Qvc2VsaW51eC90cmVlL21haW4vbGlic2VsaW51
eC9zcmMvbG9hZF9wb2xpY3kuYwo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPiAuLi4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
