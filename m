Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAAEEB64D7
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 12:30:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67AFD3CBEFE
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 14:30:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109B73CB67C
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 14:30:12 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F0C5A140097D
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 14:30:11 +0200 (CEST)
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-bcde2b13fe2so530613276.3
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686918611; x=1689510611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsVm603uRWJyZSIAWYZBVf4Mhzum8dhi/mqMDn2hjUc=;
 b=fZglppOz6VP4VVIz3nR6ifWEVzzjE9E4aMIMTSZZswaQHFCSpJSSvGImHD3XlLyV30
 sKG38TMDvVdA+DXPQCq4klGKJ9pThrc+a7L8IlxEjQFlCEXd9VarIKlyeS83uQiVwhyu
 oG/jkoZcMdtcsZj2LqQLfwn7gvyCTDxAIJ906NTWkKywb9REO5oxe7uWp7ORwn2LaCtk
 MIzQoIiHxosga8qHB9OT5QpwHze2WfCKJ+7xaMEd1BeibAuAUZ1CnWs6gyMpJshi8s/n
 v7MPJa1OwLOBHiJPPOv8mV/mtra60bMEvcU6bp3v/6AhF9QDaW4XIWHZ3VBotfrUzCD4
 asSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686918611; x=1689510611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GsVm603uRWJyZSIAWYZBVf4Mhzum8dhi/mqMDn2hjUc=;
 b=FY6NTwTCd9ukGcd85O8uw/w2KcWLJXIhAyJo2x8XMZInGZlqqNDFpboHCMiWN6a1WD
 fYBJhez0TePA2ksOiaaUOpQ1G1ZYzCNKIsfdtBwRGs57w2niGUUne8sRKi5wWvuR2FBY
 LDMZ9skH426gN2Pp4T+l/fJOd63E7TYvlWV+QdADfAFSeHUmg7H8a1vkkrZFdt7MzcN6
 oUtEBEpEl237qUoQAgw9JYBefvmC+25LU6/Yj6QcX6gN78EBVMCIMiJXLOUing6hEQ/w
 AP1QUcnBwRleWYO6Pr1K9S9qtFSGZWP20+fSE3j3CgHWdCxjsMoL8ZWVADtsi2FQBSYB
 HL+A==
X-Gm-Message-State: AC+VfDzA+mETeKrGEHURWa4d5ylH05rr927/wPkvUdpjWaAjftROcuvy
 MnnQpfjnV2Q4WUxmSpC9G/MVcNHq8Cr/SVgpDF3JcIN/
X-Google-Smtp-Source: ACHHUZ6FsNDhHamtdP0Ol0HyH5NTL+hjIyD07scr0Nc3WAt6aoSFzs2MVPIiellQd6dgSQ3dHM3/bMxCKVtt6pHvpvg=
X-Received: by 2002:a25:d711:0:b0:be4:9f84:d1bb with SMTP id
 o17-20020a25d711000000b00be49f84d1bbmr1096134ybg.11.1686918610704; Fri, 16
 Jun 2023 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230615075307.157688-1-liwang@redhat.com>
In-Reply-To: <20230615075307.157688-1-liwang@redhat.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 16 Jun 2023 20:29:59 +0800
Message-ID: <CADJHv_uHkMiWf3kgp0A4tM2VYNH3-N9xcvCjjQEk1M18zo2Now@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_fill_fs: drop safe_macro from fill_flat_vec
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
Cc: Shizhao Chen <shichen@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMTUsIDIwMjMgYXQgMzo1M+KAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IExUUCBmc19maWxsIGlzIHRyeWluZyB0byBzcGF3biBuQ1BVUyB0aHJl
YWQgdG8gY3JlYXRlIGNvcnJlc3BvbmRpbmcKPiBzdWJkaXJlY3RvcmllcyBhbmQgY29tcGxldGVs
eSBmaWxsIHRoZW0uIEJ1dCBpbiB0aGUgaW52b2tlIGZ1bmN0aW9uCj4gdHN0X2ZpbGxfZnMoLCBU
U1RfRklMTF9CTE9DS1MpIC0+IGZpbGxfZmxhdF92ZWMoKSB3aGljaCBoYXMgU0FGRV9NQUNST3MK
PiB0byBicmVhayB0aGUgb3BlbiBiZWhhdmlvciBvbmNlIGZzIGlzIGZpbGxlZCB3aXRoIEVOT1NQ
QyByZXR1cm4uCj4KPiBUaGUgZmFpbHVyZSBsaWtlIHRoZXJlIGFyZW4ndCBlbm91Z2ggZnJlZSBp
bm9kZXMgaW4gdGhlIGZpbGVzeXN0ZW0gZm9yCj4gdGhlIHRzdF9mc19maWxsIHRlc3QgcHJvZ3Jh
bSB0byBjcmVhdGUgaXQncyBzZXQgb2YgIkFPRiIgZGF0YSBmaWxlcy4KPgo+ICAgNDEwOCAgdHN0
X3Rlc3QuYzoxNjM0OiBUSU5GTzogPT09IFRlc3Rpbmcgb24geGZzID09PQo+ICAgNDEwOSAgdHN0
X3Rlc3QuYzoxMDk0OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggeGZzIG9wdHM9
JycgZXh0cmEgb3B0cz0nJwo+ICAgNDExMCAgZnNfZmlsbC5jOjEwODogVElORk86IFJ1bm5pbmcg
OTggd3JpdGVyIHRocmVhZHMKPiAgIDQxMTEgIHRzdF9maWxsX2ZzLmM6Nzc6IFRCUk9LOiBvcGVu
YXQoODk8L21udC90ZXN0YXJlYS9sdHAtd0dnMFhOU0hjci9MVFBfZnNfWEx4ckxoL21udHBvaW50
L3RocmVhZDg0PiwgJ0FPRicsIDEwMSwgNjAwKTogRU5PU1BDICgyOCkKPiAgIDQxMTIgIHRzdF9m
aWxsX2ZzLmM6Nzc6IFRCUk9LOiBvcGVuYXQoODc8L21udC90ZXN0YXJlYS9sdHAtd0dnMFhOU0hj
ci9MVFBfZnNfWEx4ckxoL21udHBvaW50L3RocmVhZDgzPiwgJ0FPRicsIDEwMSwgNjAwKTogRU5P
U1BDICgyOCkKPiAgIDQxMTMgIHRzdF9maWxsX2ZzLmM6Nzc6IFRXQVJOOiBvcGVuYXQoODU8L21u
dC90ZXN0YXJlYS9sdHAtd0dnMFhOU0hjci9MVFBfZnNfWEx4ckxoL21udHBvaW50L3RocmVhZDgy
PiwgJ0FPRicsIDEwMSwgNjAwKTogRU5PU1BDICgyOCkKPiAgIDQxMTQgIHRzdF9maWxsX2ZzLmM6
Nzc6IFRXQVJOOiBvcGVuYXQoMzwvbW50L3Rlc3RhcmVhL2x0cC13R2cwWE5TSGNyL0xUUF9mc19Y
THhyTGgvbW50cG9pbnQvdGhyZWFkODE+LCAnQU9GJywgMTAxLCA2MDApOiBFTk9TUEMgKDI4KQo+
Cj4gVGhpcyBwYXRjaCBpcyBqdXN0IHRvIGNvbnZlcnQgdGhlIGZpbGxfZmxhdF92ZWMoKSB0byBp
Z25vcmUgRU5PU1BDIGxpa2UKPiBmaWxsX3JhbmRvbWUoKSBpbiBvcGVuaW5nIHN1YmRpcmVjdG9y
aWVzLgoKTG9va3MgZ29vZCB0byBtZS4gVGhhbmtzIGZvciBmaXhpbmcgaXQhCgpNdXJwaHkKPgo+
IFJlcG9ydGVkLWJ5OiBTaGl6aGFvIENoZW4gPHNoaWNoZW5AcmVkaGF0LmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiBDYzogRGF2ZSBDaGlubmVyIDxk
Y2hpbm5lckByZWRoYXQuY29tPgo+IENjOiBSaWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBl
QHN1c2UuY29tPgo+IC0tLQo+ICBsaWIvdHN0X2ZpbGxfZnMuYyB8IDIxICsrKysrKysrKysrKysr
KysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9saWIvdHN0X2ZpbGxfZnMuYyBiL2xpYi90c3RfZmlsbF9mcy5j
Cj4gaW5kZXggYjlkMjk3NTVhLi4yNDNlYjI3OWYgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9maWxs
X2ZzLmMKPiArKysgYi9saWIvdHN0X2ZpbGxfZnMuYwo+IEBAIC03MywxMiArNzMsMjkgQEAgdm9p
ZCBmaWxsX3JhbmRvbShjb25zdCBjaGFyICpwYXRoLCBpbnQgdmVyYm9zZSkKPgo+ICB2b2lkIGZp
bGxfZmxhdF92ZWMoY29uc3QgY2hhciAqcGF0aCwgaW50IHZlcmJvc2UpCj4gIHsKPiAtICAgICAg
IGludCBkaXIgPSBTQUZFX09QRU4ocGF0aCwgT19QQVRIIHwgT19ESVJFQ1RPUlkpOwo+IC0gICAg
ICAgaW50IGZkID0gU0FGRV9PUEVOQVQoZGlyLCAiQU9GIiwgT19XUk9OTFkgfCBPX0NSRUFULCAw
NjAwKTsKPiArICAgICAgIGludCBkaXIsIGZkOwo+ICAgICAgICAgc3RydWN0IGlvdmVjIGlvdls1
MTJdOwo+ICAgICAgICAgaW50IGlvdmNudCA9IEFSUkFZX1NJWkUoaW92KTsKPiAgICAgICAgIGlu
dCByZXRyaWVzID0gMzsKPgo+ICsgICAgICAgZGlyID0gb3BlbihwYXRoLCBPX1BBVEggfCBPX0RJ
UkVDVE9SWSk7Cj4gKyAgICAgICBpZiAoZGlyID09IC0xKSB7Cj4gKyAgICAgICAgICAgICAgIGlm
IChlcnJubyA9PSBFTk9TUEMpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzKFRJ
TkZPIHwgVEVSUk5PLCAib3BlbigpIik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
Owo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBU
RVJSTk8sICJvcGVuKCVzLCAlZCkgZmFpbGVkIiwgcGF0aCwgT19QQVRIIHwgT19ESVJFQ1RPUlkp
Owo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIGZkID0gb3BlbmF0KGRpciwgIkFPRiIsIE9fV1JP
TkxZIHwgT19DUkVBVCwgMDYwMCk7Cj4gKyAgICAgICBpZiAoZmQgPT0gLTEpIHsKPiArICAgICAg
ICAgICAgICAgaWYgKGVycm5vID09IEVOT1NQQykgewo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHRzdF9yZXMoVElORk8gfCBURVJSTk8sICJvcGVuYXQoKSIpOwo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybjsKPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICB0c3Rf
YnJrKFRCUk9LIHwgVEVSUk5PLCAib3BlbmF0KCVzLCAlZCwgMDYwMCkgZmFpbGVkIiwgZGlyLCBP
X1BBVEggfCBPX0RJUkVDVE9SWSk7Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgU0FGRV9DTE9T
RShkaXIpOwo+Cj4gICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IGlvdmNudDsgaSsrKSB7Cj4g
LS0KPiAyLjQwLjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
