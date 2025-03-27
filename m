Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C59C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 09:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 302193C9DF2
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 10:11:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83C4B3C070D
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 10:11:37 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F27131000B52
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 10:11:36 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so108430666b.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743066696; x=1743671496; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rD/YoNzFMib7c+MTG+0S2Cinp8NGiqIXs0g32dZvNwc=;
 b=SnEFD9HUqhHGYe/kKLhni9ZU2+KXL09uoWdIVHWlzEirL+XhAV4iajecIlyOlX+lwN
 I6hw/p6T3O2bEXcYni51/gokI2VTLr6KmHC9/txrTOCJw8Pj53n4lVqXmaxs56ggrDz0
 nY30CwoFH5agV5tMF44B/e6SbyplPi7H5y14A7RpwqGjg+UeG3VAs1NI9njufL3BO0Vx
 gpKqLHGkZa5BmtTQkUGa1UHFfd2lpMScKtxW7I1Z6xpD4wFqTTP3w6C3720QBE+xAP+9
 Fx3deRTd98ugey0pPZeZCcO8VCEpkz7jFufSJBw0j8VUt0svqx1CEJ5oLuZ2jD2QgdqQ
 tkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743066696; x=1743671496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rD/YoNzFMib7c+MTG+0S2Cinp8NGiqIXs0g32dZvNwc=;
 b=RbvpL0SgKWVwpnjiKQZOdtsQNrJlu+lVvWh1Jc9dVulVeJD+uxDn2iiLKguJ4gPvh/
 4sMTe2NUNg5y3CSIco41YV7L5PLpN3eszW/qKhcgrpQptQYH2j7qYJ9Le/dd3ZeiYOEP
 nyxbgKOnw3iCjO57OO8u0tT6Hw9uSADVRJFKb2W9tcgTOGgAHMvsLDDRtksmcnJFKZHb
 SNJsUPWR57Fzg52bwqrdQNSyrApgqsa0GIaWkaW1ypHfnnrhVMGSe5UoX0eDYVHSBysg
 Sd9phQU1uXKeXtP7xfu/skNuPokAEyYw6/DudD581GamHTJr9AcYk1BzNjqo/gLMwnN6
 7VuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqBLMdQjuqb6X1rlpIe5si8wMlUhBQxHlZ4R6E3jRomcPPg6ZtoLrnoXtH5o1nbbpQOc8=@lists.linux.it
X-Gm-Message-State: AOJu0Ywi9Mc9c8JC+QWh0UI712b/Isdv0pYc2sHN769mGbsT/qnn61js
 e2nTJ9GWg7+f4AbEgyZyd08TEITsxal/+y0mm/IlzgrQRXlzLvypAEu3mLgfrpZCfDXs9q9IYoF
 bNQmVN750I/UKLhToJjGV9qQfnA8=
X-Gm-Gg: ASbGncvs30BJiXfq7OPztDDJ5k3nmJVuwDFGk0IRb9J4q8cUurhRC12W0Us284Gm1By
 y1f+0wHMy3t7YZ1ISPaVnR/gSrwQ54F6wNrx6fBa02MWSbWrj1uUTuxx4GCT1qONQnR1Ze4SLrk
 cSAf7P+O1DjisdG7geWY7CeChSCQ==
X-Google-Smtp-Source: AGHT+IE5dVGqEvQ0yzi4OMZHPpJQJZY/u6LWUjhOWnkhW7LEMyW8GvFblvkxZh1D3ARLvY5Jec5FAXbSot4+RZJlUBo=
X-Received: by 2002:a17:907:9301:b0:ac2:898f:ba50 with SMTP id
 a640c23a62f3a-ac6fae48ae9mr250922266b.7.1743066695874; Thu, 27 Mar 2025
 02:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-3-amir73il@gmail.com>
 <xpozkmxhtqd3lamf7n2dk43z6eey5ettmdw3vayykmjrv5dqgt@zeewki7ibawg>
In-Reply-To: <xpozkmxhtqd3lamf7n2dk43z6eey5ettmdw3vayykmjrv5dqgt@zeewki7ibawg>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 10:11:23 +0100
X-Gm-Features: AQ5f1JoXyDRFDawGXU18koyfPOUEiE0lgApm3BoTJao2P359ZSqYMCZ8D1viLlo
Message-ID: <CAOQ4uxgW8rFNLOXMOQzXMrGXtsVvX6QHKMc8tPrnibra_cCAZA@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify24: print range info for pre-content
 events
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

T24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgNDowNOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gV2VkIDE5LTAzLTI1IDIwOjI3OjQxLCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToKPiA+IHJhbmdlIGluZm8gaXMgZXhwZWN0ZWQgb25seSBmb3IgcHJlLWNvbnRlbnQgZXZlbnRz
Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNv
bT4KPgo+IEp1c3Qgb25lIG5pdCBiZWxvdy4gT3RoZXJ3aXNlIGZlZWwgZnJlZSB0byBhZGQ6Cj4K
PiBSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPgo+ID4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyNC5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMKPiA+IGluZGV4IDUzOWY3
NDEzNy4uMmQyNDc5YjM5IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkyNC5jCj4gPiBAQCAtMzM5LDYgKzMzOSw3IEBAIHN0YXRpYyB2
b2lkIHRlc3RfZmFub3RpZnkodW5zaWduZWQgaW50IG4pCj4gPiAgICAgICAgKi8KPiA+ICAgICAg
IHdoaWxlICh0ZXN0X251bSA8IEVWRU5UX1NFVF9NQVggJiYgZmRfbm90aWZ5ICE9IC0xKSB7Cj4g
PiAgICAgICAgICAgICAgIHN0cnVjdCBmYW5vdGlmeV9ldmVudF9tZXRhZGF0YSAqZXZlbnQ7Cj4g
PiArICAgICAgICAgICAgIHN0cnVjdCBmYW5vdGlmeV9ldmVudF9pbmZvX3JhbmdlICpyYW5nZTsK
PiA+Cj4gPiAgICAgICAgICAgICAgIGlmIChpID09IGxlbikgewo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIC8qIEdldCBtb3JlIGV2ZW50cyAqLwo+ID4gQEAgLTM2Nyw2ICszNjgsNyBAQCBzdGF0
aWMgdm9pZCB0ZXN0X2Zhbm90aWZ5KHVuc2lnbmVkIGludCBuKQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgIHRlc3RfbnVtLS07Cj4gPgo+ID4gICAgICAgICAgICAgICBldmVudCA9IChzdHJ1Y3Qg
ZmFub3RpZnlfZXZlbnRfbWV0YWRhdGEgKikmZXZlbnRfYnVmW2ldOwo+ID4gKyAgICAgICAgICAg
ICByYW5nZSA9IChzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfaW5mb19yYW5nZSAqKShldmVudCArIDEp
Owo+ID4gICAgICAgICAgICAgICAvKiBQZXJtaXNzaW9uIGV2ZW50cyBjYW5ub3QgYmUgbWVyZ2Vk
LCBzbyB0aGUgZXZlbnQgbWFzawo+ID4gICAgICAgICAgICAgICAgKiByZXBvcnRlZCBzaG91bGQg
ZXhhY3RseSBtYXRjaCB0aGUgZXZlbnQgbWFzayB3aXRoaW4gdGhlCj4gPiAgICAgICAgICAgICAg
ICAqIGV2ZW50IHNldC4KPiA+IEBAIC0zODYsNiArMzg4LDIyIEBAIHN0YXRpYyB2b2lkIHRlc3Rf
ZmFub3RpZnkodW5zaWduZWQgaW50IG4pCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAodW5zaWduZWQgaW50KWV2ZW50LT5waWQsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAodW5zaWduZWQgaW50KWNoaWxkX3BpZCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGV2ZW50LT5mZCk7Cj4gPiArICAgICAgICAgICAgIH0gZWxzZSBpZiAoZXZlbnQtPm1h
c2sgJiBMVFBfUFJFX0NPTlRFTlRfRVZFTlRTKSB7Cj4KPiBZb3Ugc2hvdWxkIHByb2JhYmx5IGNo
ZWNrIGhlcmUgdGhhdCB0aGUgZXZlbnQtPmxlbiBpcyBzdWZmaWNpZW50bHkgbGFyZ2UgdG8KPiBj
b250YWluIHRoZSByYW5nZSBpbmZvLiBPdGhlcndpc2UgJ3JhbmdlJyBtaWdodCBwb2ludCBiZXlv
bmQgdGhlIGVuZCBvZgo+IGV2ZW50IGFuZCByZXN1bHQgaW4gb2RkIGJlaGF2aW9yLi4uCj4KClJp
Z2h0LiBmZWVsIGZyZWUgdG8gdXNlIHRoZSBhbWVuZGVkIHZlcnNpb24gYmVsb3cKCgoKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSG9uemEKPgo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChyYW5nZS0+aGRyLmluZm9f
dHlwZSAhPSBGQU5fRVZFTlRfSU5GT19UWVBFX1JBTkdFKSB7Cj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiZ290IGV2ZW50OiBtYXNrPSVsbHggcGlkPSV1IGZkPSVkICIKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIihleHBlY3RlZCByYW5nZSBpbmZv
KSIsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBs
b25nIGxvbmcpZXZlbnQtPm1hc2ssCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICh1bnNpZ25lZCBpbnQpZXZlbnQtPnBpZCwKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZXZlbnQtPmZkKTsKCiAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChldmVudC0+ZXZlbnRfbGVuIDwgc2l6ZW9mKCpldmVudCkgKwpzaXplb2YoKnJhbmdlKSB8fAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UtPmhkci5pbmZvX3R5cGUgIT0gRkFOX0VW
RU5UX0lORk9fVFlQRV9SQU5HRSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRz
dF9yZXMoVEZBSUwsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZ290
IGV2ZW50OiBtYXNrPSVsbHggcGlkPSV1Cmxlbj0lZCBmZD0lZCAiCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiKGV4cGVjdGVkIHJhbmdlIGluZm8pIiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcpZXZlbnQt
Pm1hc2ssCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQg
aW50KWV2ZW50LT5waWQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
dW5zaWduZWQgaW50KWV2ZW50LT5ldmVudF9sZW4sCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBldmVudC0+ZmQpOwoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
