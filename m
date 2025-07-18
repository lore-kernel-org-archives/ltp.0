Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE3CC83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752842981; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WiV9wkLT4xiKuGK9YEzWv571MoWKFkEdAQTXDydzQ30=;
 b=YVnKL3IsS37RnhSjO32BZrw6my2P+BxIcPbtnaf0GittQRRdsz9YEJOqRagHKcoKRdK+O
 SWu2+6QxijtqUeUW/2rJkiLAGuBk+mspSENdCbtvp2nd4LYOlQTbx44MwCpunZUavdJvdF0
 PkLUYPpziEnkYjKCExNoTVcaXjGwvUI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AB493CC62C
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 14:49:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695C53CC61C
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 14:49:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9CB2B60073B
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 14:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752842955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nS9UWD3m1Sqf0gJSCjTe0FG95u/0EKqi9D7FAa5o+0g=;
 b=MqxXY3F0wCUgNtcnHkRWIAwydHq+40IerCzV0zmlMv7vFhBgROE4yjimCx1UXAdrVogj32
 VwbsTKGgc0M60vjaGEjBRWOBmxJPPAPanpktMMwjuPva1LAzifusxvx4zNPqDlDv40VyEt
 9MSAI9SObMHNai54FIf1R45dIDcXe5U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-2VS6pEY9Oqu39p02MyVoLw-1; Fri, 18 Jul 2025 08:49:13 -0400
X-MC-Unique: 2VS6pEY9Oqu39p02MyVoLw-1
X-Mimecast-MFC-AGG-ID: 2VS6pEY9Oqu39p02MyVoLw_1752842953
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31366819969so2040543a91.0
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 05:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752842952; x=1753447752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nS9UWD3m1Sqf0gJSCjTe0FG95u/0EKqi9D7FAa5o+0g=;
 b=lnNQJMoOtyv9z0sikZyVk2tw+5imEP6HDyHRDETwx8KJ2k8Nhejg9XUeTuvqzhKdVl
 37JILEZXzvVq9dE8x18lkiZOtdbfwnJ3vS/TLozK7yl1j7Fy5atugi6pupa07DE1cLuD
 r/0HUvzdw0ASR8z7S30OVBAbVxE+bep20MQ6iczxIvlmuy5g65NkJPD1tPRiluxQQlF2
 4vN05fB705k1RpodnCnxYU8SbXew92rrG9CJHDMpOXmqN67IdmEBRDz45UHhmh7qm2xY
 AANgY/ag1TJmHRf7z+lHKyNNTbKVtw9ckvnbHXzbMcqNsD0F1O+oNUa9ywJMq/DI0R0S
 Ts2g==
X-Gm-Message-State: AOJu0YxPxhjQElw+6R+DDDWzzEGHdeZ2HHTw/j7j8RBHs4NA7Ev8l/H7
 +s6ukz9ybep4X7otBJiuO/byKrL+DTHTBKEULILOvmbfpFWRt7rsilQ/7FGy40rbq4UfEYPz2ps
 c+lW/eytKWjcHo5RynpzTKlgv0JQYQNm55dSCMclk/rzkJeyuoDQEKTd21nrT6fBnkQ9Y/b2Edb
 DT/u38y3a4HBiMrESwML7nfi/ixIk=
X-Gm-Gg: ASbGnctmglZjctBpJCP3LOEVBdsAoTEASRo96A6AVqaeu95xEDQvlG86J5WnhCXQ86w
 ddnuLOf9QGtZpGeIZRNGoRhKkVGuhvnmZ1GwK0fJ96vxLFBVw3x0zTyW4OWrFS7+PI7FGINCup8
 FU8injaLHfA1DNG63BsBF86w==
X-Received: by 2002:a17:90b:180f:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-31c9e6fb9b9mr16687093a91.8.1752842951620; 
 Fri, 18 Jul 2025 05:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErp2zoLR9mpJDKq1s7meI+o74luvi5k/R9gkUcuDaFc+uz3uic21I6tjdHZ8PdUpG4dbAws+nJspwkdcj24io=
X-Received: by 2002:a17:90b:180f:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-31c9e6fb9b9mr16687061a91.8.1752842951211; Fri, 18 Jul 2025
 05:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250718090523.1411073-1-pvorel@suse.cz>
 <CAEemH2eeyE4Lt5HEXSoQVo9fVmgyJxQgZau29gMOTibDSXHDxw@mail.gmail.com>
 <20250718103119.GA1414439@pevik>
In-Reply-To: <20250718103119.GA1414439@pevik>
Date: Fri, 18 Jul 2025 20:48:59 +0800
X-Gm-Features: Ac12FXydyNaMgxE7dhSj9ykPYiSlucEPKLLFTd05ZSTFGNwqk88y7dSGsXNBJ2U
Message-ID: <CAEemH2eJC09dOOyKkWsze5w6LgsdkT49CHVCQUO+g8saWuB80w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fsJdJNpH8vdQY_7Lq2GDgddq2mJQUVRUo-8AD9jNRSE_1752842953
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] getrlimit03: Simplify TCONF code
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Steve Muckle <smuckle@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgMTgsIDIwMjUgYXQgNjozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIGFsbCwKPgo+IFsgQ2MgYWxzbyBTdGV2ZSBdCj4KPiA+IEhp
IFBldHIsCj4KPiA+IE9uIEZyaSwgSnVsIDE4LCAyMDI1IGF0IDU6MDXigK9QTSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gRU5PU1lTIGNoZWNrcyBhZGRlZCBpbiBm
YWM3ODNiNWQ2IGFuZCBkMDcxZGUwMmU4IGFyZSB2ZXJib3NlLCB1c2UKPiA+ID4gdHN0X3N5c2Nh
bGwoKSB0byBoYW5kbGUgRU5PU1lTLgo+Cj4gPiA+IEFsc28gY2hlY2sgZm9yIF9fTlJfZ2V0cmxp
bWl0IGNhdXNlZCBUQ09ORiBtZXNzYWdlIGJlaW5nIHByaW50ZWQgbW9yZQo+ID4gPiB0aW1lcyAo
UkxJTV9OTElNSVRTID0+IDE2IG9uIHg4Nl82NCksIHdoaWNoIGlzIGFsc28gZml4ZWQgYnkgdXNp
bmcKPiA+ID4gdHN0X3N5c2NhbGwoKS4KPgo+ID4gPiBCZWNhdXNlIGl0IHNob3VsZCBiZSBzYWZl
IHRvIG5vdCB1c2Ugc3BlY2lmaWMgZXJybm8gdmFyaWFibGVzIHJlbW92ZQo+ID4gPiBlcnJub19s
IGFuZCBlcnJub191bC4KPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPiA+ID4gLS0tCj4gPiA+IEhpIGFsbCwKPgo+ID4gPiBAVGllemh1IGNhbiB5b3Ug
cGxlYXNlIHRlc3QgdGhpcyBwYXRjaD8KPiA+ID4gQExpIEhvcGUgSSBkaWQgbm90IG92ZXJsb29r
IGFueXRoaW5nLgo+Cj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgo+Cj4gPiA+ICAuLi4v
a2VybmVsL3N5c2NhbGxzL2dldHJsaW1pdC9nZXRybGltaXQwMy5jICAgfCAyMyArKysrLS0tLS0t
LS0tLS0tLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxOSBkZWxl
dGlvbnMoLSkKPgo+ID4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9n
ZXRybGltaXQvZ2V0cmxpbWl0MDMuYwo+ID4gPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
Z2V0cmxpbWl0L2dldHJsaW1pdDAzLmMKPiA+ID4gaW5kZXggODQ2ZWYzY2VkNi4uYTJkZDBjYTc5
YyAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQv
Z2V0cmxpbWl0MDMuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJs
aW1pdC9nZXRybGltaXQwMy5jCj4gPiA+IEBAIC03Nyw3ICs3Nyw3IEBAIHN0cnVjdCBybGltaXRf
dWxvbmcgewo+Cj4gPiA+ICBzdGF0aWMgaW50IGdldHJsaW1pdF91bG9uZyhpbnQgcmVzb3VyY2Us
IHN0cnVjdCBybGltaXRfdWxvbmcgKnJsaW0pCj4gPiA+ICB7Cj4gPiA+IC0gICAgICAgcmV0dXJu
IHN5c2NhbGwoX19OUl9nZXRybGltaXRfdWxvbmcsIHJlc291cmNlLCBybGltKTsKPiA+ID4gKyAg
ICAgICByZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9nZXRybGltaXRfdWxvbmcsIHJlc291cmNlLCBy
bGltKTsKPiA+ID4gIH0KPgo+ID4gPiAgY29uc3QgbG9uZyBSTElNX0lORklOSVRZX0wgPSBMT05H
X01BWDsKPiA+ID4gQEAgLTkwLDcgKzkwLDcgQEAgc3RydWN0IHJsaW1pdF9sb25nIHsKPgo+ID4g
PiAgc3RhdGljIGludCBnZXRybGltaXRfbG9uZyhpbnQgcmVzb3VyY2UsIHN0cnVjdCBybGltaXRf
bG9uZyAqcmxpbSkKPiA+ID4gIHsKPiA+ID4gLSAgICAgICByZXR1cm4gc3lzY2FsbChfX05SX2dl
dHJsaW1pdCwgcmVzb3VyY2UsIHJsaW0pOwo+ID4gPiArICAgICAgIHJldHVybiB0c3Rfc3lzY2Fs
bChfX05SX2dldHJsaW1pdCwgcmVzb3VyY2UsIHJsaW0pOwo+Cj4KPiA+IEkgZ3Vlc3MgYXQgbGVh
c3Qgd2Ugc2hvdWxkIGF2b2lkIHVzaW5nIHRzdF9zeXNjYWxsKCkgaW4gZ2VybGltaXRfbG9uZywK
PiA+IGJlY2F1c2UgaXQgd2lsbCBtaXNzIChicmVhayB3aXRoIFRDT05GKSB0aGUgbmV4dCBnZXRy
bGltaXRfdWxvbmcgdGVzdHMKPiA+IHdoZW4gcnVubmluZyBhbiBhYXJjaDMyIHVzZXIgYmluYXJ5
IG9uIDY0Yml0IGtlcm5lbDoKPiA+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvY29tbWl0L2ZhYzc4M2I1ZDY2MzFlZmE3MGQyZWEzMjU3MTQyNzYzZDk0NGJhMzIK
Pgo+IFRoYW5rcywgSSBkaWQgbWlzcyB0aGUgcG9pbnQgb2YgdGhpcyBjb21taXQgd2hlbiBJIGxv
b2tlZCBpbnRvIGl0IGVhcmxpZXIuCj4gUmVhZGluZyBhZ2FpbiB0aGUgY29kZSBhbmQgY29tbWl0
IG1lc3NhZ2VzIG9mIGJvdGggY29tbWl0cy4KPgo+IEkgc3VwcG9zZSB5b3UncmUgcmlnaHQgaXQn
cyBzYWZlIHRvIHF1aXQgZ2V0cmxpbWl0X3Vsb25nKCkgdmlhCj4gdHN0X3N5c2NhbGwoKQo+IGJl
Y2F1c2UgaXQncyBlaXRoZXIgb2xkIGFyY2ggd2hpY2ggaGFzIGFsd2F5cyBnZXRybGltaXQoKSBz
eXNjYWxsIG9yIG5ldwo+IGFyY2gKPiB3aGljaCBoYXMgYWx3YXlzIHVnZXRybGltaXQoKSBzeXNj
YWxsLiBJbiB0aGF0IGNhc2Ugd2UgY2FuIGxlYXZlIHRoZSBjb2RlCj4gYXMgaXMKPiBvciBhZGQg
dHN0X3N5c2NhbGwoKSB0byBnZXRybGltaXRfdWxvbmcoKSArIGV4cGxhbmF0aW9uIGF0IGdlcmxp
bWl0X2xvbmcoKQo+IHdoeQo+IHRzdF9zeXNjYWxsKCkgaXMgbm90IHVzZWQuCj4KClRoYXQncyBy
aWdodCwgYW5kIEkgYW0gZmluZSB3aXRoIGJvdGggd2F5LgoKCj4gQW5kIGlmIEknbSB3cm9uZyBh
bmQgaXQncyBub3Qgc2FmZSB0byBxdWl0IGdldHJsaW1pdF91bG9uZygpIHdpdGgKPiB0c3Rfc3lz
Y2FsbCgpLAo+IHRoZW4gd2Ugc2hvdWxkIHJlbW92ZSB0ZXN0LnRjbnQgPSAxIGFkZGVkIHJlY2Vu
dGx5LgoKCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gPiAgfQo+ID4gPiAgI2VuZGlmCj4K
PiA+ID4gQEAgLTE0NywxMiArMTQ3LDEwIEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQg
cmVzb3VyY2UpCj4KPiA+ID4gICAgICAgICBzdHJ1Y3QgcmxpbWl0X3Vsb25nIHJsaW1fdWw7Cj4g
PiA+ICAgICAgICAgaW50IHJldF91bDsKPiA+ID4gLSAgICAgICBpbnQgZXJybm9fdWw7Cj4KPiA+
ID4gICNpZmRlZiBTSUdORURfR0VUUkxJTUlUCj4gPiA+ICAgICAgICAgc3RydWN0IHJsaW1pdF9s
b25nIHJsaW1fbDsKPiA+ID4gICAgICAgICBpbnQgcmV0X2w7Cj4gPiA+IC0gICAgICAgaW50IGVy
cm5vX2w7Cj4gPiA+ICAjZW5kaWYKPgo+ID4gPiAgICAgICAgIGVycm5vID0gMDsKPiA+ID4gQEAg
LTE2MSwxNSArMTU5LDggQEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCByZXNvdXJjZSkK
Pgo+ID4gPiAgICAgICAgIGVycm5vID0gMDsKPiA+ID4gICAgICAgICByZXRfdWwgPSBnZXRybGlt
aXRfdWxvbmcocmVzb3VyY2UsICZybGltX3VsKTsKPiA+ID4gLSAgICAgICBlcnJub191bCA9IGVy
cm5vOwo+ID4gPiAtICAgICAgIGlmIChlcnJub191bCA9PSBFTk9TWVMpIHsKPiA+ID4gLSAgICAg
ICAgICAgICAgIHRzdF9yZXMoVENPTkYgfCBURVJSTk8sCj4gPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICIlcyBub3QgaW1wbGVtZW50ZWQiLAo+IF9fTlJfZ2V0cmxpbWl0X3Vsb25nX3N0cik7
Cj4gPiA+IC0gICAgICAgICAgICAgICB0ZXN0LnRjbnQgPSAxOwo+ID4gPiAtICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ID4gPiAtICAgICAgIH0KPgo+ID4gPiAtICAgICAgIGlmIChjb21wYXJlX3Jl
dHZhbChyZXNvdXJjZSwgcmV0X3U2NCwgZXJybm9fdTY0LCByZXRfdWwsCj4gZXJybm9fdWwsCj4g
PiA+ICsgICAgICAgaWYgKGNvbXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191
NjQsIHJldF91bCwgZXJybm8sCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fTlJf
Z2V0cmxpbWl0X3Vsb25nX3N0cikgfHwKPiA+ID4gICAgICAgICAgICAgY29tcGFyZV91NjRfdWxv
bmcocmVzb3VyY2UsIHJsaW1fdTY0LnJsaW1fY3VyLAo+ID4gPiBybGltX3VsLnJsaW1fY3VyLAo+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAicmxpbV9jdXIiKSB8fAo+ID4gPiBA
QCAtMTgzLDE0ICsxNzQsOCBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNl
KQo+ID4gPiAgI2lmZGVmIFNJR05FRF9HRVRSTElNSVQKPiA+ID4gICAgICAgICBlcnJubyA9IDA7
Cj4gPiA+ICAgICAgICAgcmV0X2wgPSBnZXRybGltaXRfbG9uZyhyZXNvdXJjZSwgJnJsaW1fbCk7
Cj4gPiA+IC0gICAgICAgZXJybm9fbCA9IGVycm5vOwo+ID4gPiAtICAgICAgIGlmIChlcnJub19s
ID09IEVOT1NZUykgewo+ID4gPiAtICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiB8IFRFUlJO
TywKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgIl9fTlJfZ2V0cmxpbWl0KCVkKSBub3Qg
aW1wbGVtZW50ZWQiLAo+ID4gPiBfX05SX2dldHJsaW1pdCk7Cj4gPiA+IC0gICAgICAgICAgICAg
ICByZXR1cm47Cj4gPiA+IC0gICAgICAgfQo+Cj4gPiA+IC0gICAgICAgaWYgKGNvbXBhcmVfcmV0
dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191NjQsIHJldF9sLAo+IGVycm5vX2wsCj4gPiA+
ICsgICAgICAgaWYgKGNvbXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191NjQs
IHJldF9sLCBlcnJubywKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIl9fTlJfZ2V0
cmxpbWl0IikgfHwKPiA+ID4gICAgICAgICAgICAgY29tcGFyZV91NjRfbG9uZyhyZXNvdXJjZSwg
cmxpbV91NjQucmxpbV9jdXIsCj4gcmxpbV9sLnJsaW1fY3VyLAo+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJybGltX2N1ciIpIHx8Cj4gPiA+IC0tCj4gPiA+IDIuNTAuMAo+Cj4K
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
