Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AB4D2D0FE
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768311054; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TYrnyf+2ZdI/7c9i8MCONvUafpC4vR76MZgVWcErXHk=;
 b=E6G0s3gGRXHjtryUqMPA+v4APxVm+DFC5u1jUxJkcYICdvFCV2rYu56hzbdxSCF8b3wrK
 EqxBrl90o6psl03sVtQcATybFRfvtmQRCmnPINrjM+DR6TKyH6/NbSxma+EN2UWrBV8m7Zr
 R7eV4chSmB9tJLTdatBb8EOS/Y2kFE4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12A4A3C682B
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 14:30:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF4CE3C59D2
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 14:30:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F621600833
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 14:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768311028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEt3qXi1UcX5RpjuCTAlIti53mO1VBatcm0xmIsVJNA=;
 b=Py/h7DZHun6z3nQMewTO6ah5k2sGwkho1HsT+HFtZ0iXEZWfd1fhaTJAjR8yZUDyZTmZdB
 sbhrvHbsyWVQbE+FkwdwomA+Tfva87lmNA2jrZMYNdtF3Cteq62+vbJLVem8D3o2ODlxnE
 GeK/mSMNkzo5hVqFGwSiE+JlksxG+sI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-5RcuMhqGPn6MnQHk88Cobg-1; Tue, 13 Jan 2026 08:30:27 -0500
X-MC-Unique: 5RcuMhqGPn6MnQHk88Cobg-1
X-Mimecast-MFC-AGG-ID: 5RcuMhqGPn6MnQHk88Cobg_1768311026
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso4776998f8f.0
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 05:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768311026; x=1768915826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VEt3qXi1UcX5RpjuCTAlIti53mO1VBatcm0xmIsVJNA=;
 b=s66KWQZjjrpov7G8/JV98aTVWR3oLTD1f+5qIsDh+g69DmuGl0cixF0D/grvgFC6jY
 aAdOQXnjQ2kMcFAyCdpPj6svKUpMXDbDQWO9QaSITVgmCKKQpb2NUn1+COkCDzTpSW7f
 IVW58J0oH5m/cTb3QlKQPNuEbX8S4wgvU4FUk6RbMOuFTrj+DS7+yjJQ2FKfonXmFYnB
 VvVJSQ4U12ZD4hA7C8eGdZA0uTGvAQ5YV+dYdypIrWLwu2aGlhl/v1zO9RCvSY/KymWV
 tEHRvkDMQAI7uQzqEw5LA57kHzCb5oSDwFU7uoOsv44MF0cjmiLAEyMW7Bjh4B+Jh2C3
 5/ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2vfaTU7gAtwWBX62PrnBFTw1tH/Rt9VX3Zn5E7mX+afGjzYI9GkKWt1BlZhp1C7apcA8=@lists.linux.it
X-Gm-Message-State: AOJu0Yy99ydsI+JtYXI2V88i+3JfMvwP9fLUy6jvmC+WQS03fc+7xgsw
 0ZubW8o4a8TdwOaTe/r8tij2UT7MovNu0nWIOY7tqsKx0POKjxfBbVrrkOb71ZyXK+nRZq+/tZA
 XTWE63f2GhQGsM6RtmvTAC0BCb8a2xRWSy9wzHAuuRykC02MsUQcUlojYfeKy0v/RazrytEz98I
 HN/PxNjaN+4kAhjDVilU9VaYLXv/E=
X-Gm-Gg: AY/fxX7aHk2g3ov0Dx9wpHiGrK7wNZlWoGTJ9qrgGdH0eBYyDO7GICD2PL0o8covPAL
 FfjP1t4IuuPBX36XGTkZcx56TaVVpK+VMyRTpqAqOSeaOSJToFrw33WUi3rOKlGUBaYNX0L9Suf
 LtR/tug4ySt803HDSZ5NmMnoymY6MUAZh2DtwRI+B6Rk4UO2ZKd04/0tfGg0nAQyjjbQ==
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr28859894f8f.19.1768311025778; 
 Tue, 13 Jan 2026 05:30:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN3l0kWG1FFmiMNXFFzm8hvw8d2QUd++hXa2Pq9WdDQsUZYd1WENRQx2/n5EEfJZedTQsPp/EVOpYwcfuJiXc=
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr28859860f8f.19.1768311025386; Tue, 13 Jan 2026
 05:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
In-Reply-To: <20260113115148.GA314748@pevik>
Date: Tue, 13 Jan 2026 14:30:08 +0100
X-Gm-Features: AZwV_QhwMeweKa3lbZrFLEmC1ZTR59IfXTkXI1VLdHLKshUeBsbnXPf4iAry7hw
Message-ID: <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4mXc2z0EbdaT09XwjN4W29Xs4nQgMUK9ULEfItLgYu0_1768311026
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gMTMsIDIwMjYgYXQgMTI6NTHigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IEhpIEFuZHJlYSwgQWxsLAo+Cj4gPiBPbiBNb24sIEphbiAxMiwg
MjAyNiBhdCA4OjU54oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbT4KPiA+IHdyb3RlOgo+Cj4gPiA+IEhpIQo+Cj4gPiA+IEkgZ2VuZXJhbGx5IGFncmVlIHdp
dGggdGhpcyBhcHByb2FjaCwgYnV0IEkgaGF2ZSB0aGUgZmVlbGluZyB3ZSBhcmUKPiA+ID4gbWl4
aW5nIG5hbWluZyBhIGJpdCBoZXJlLiBGb3IgaW5zdGFuY2UsIHdlIGhhdmUgaGVhZGVycyBsaWtl
IGlwY21zZy5oCj4gPiA+IHRoYXQgaGFzIG5vIGZ1bmN0aW9ucyBzdGFydGluZyB3aXRoIHRzdF8q
LCB3aGlsZSB0c3RfbnVtYS5oIGRvZXMuIEFsc28sCj4gPiA+IHRoZSB0c3RfKiBwcmVmaXggZm9y
IGZpbGVzIGhhcyB0aGUgY2xlYXIgZ29hbCB0byBzdGF0ZSB3ZSBhcmUgaW1wb3J0aW5nCj4gPiA+
IHNvbWUgTFRQIGZ1bmN0aW9uYWxpdGllcyBpbnNpZGUgdGhlIHRlc3RzIGNvZGUuCj4KPiA+ID4g
U2FpZCBzbywgSSB3b3VsZCByYXRoZXIgcmVuYW1lIGFsbCBMVFAgbGlicmFyaWVzIGFzIHRzdF8q
LmggYW5kIHRvCj4gPiA+IHJlbmFtZSBmdW5jdGlvbnMgaW5zaWRlIHRoZW0gd2l0aCB0c3RfKiBw
cmVmaXguIEluIHRoaXMgd2F5LCB3ZSBrbm93Cj4gPiA+IGF0IHRoZSB2ZXJ5IGZpcnN0IGxvb2ss
IHdoZW4gYSBsaWJyYXJ5IGlzIGltcG9ydGVkIGZyb20gTFRQIGFuZCBub3QKPiA+ID4gZnJvbSBv
dGhlciBzb3VyY2VzLgo+Cj4gJ3RzdF8nIHByZWZpeCBpcyBvbmx5IGZvciAqbmV3KiBDIEFQSS4g
VGhhdCdzIHdoeSBpcGNtc2cuaC9saWJzL2lwYy9saWJpcGMuYwo+IGRvbid0IHVzZSBpdC4gSSB3
b3VsZCBwcmVmZXIgdG8ga2VlcCB0aGF0IHdheSAobm90IHVzZSAndHN0XycgZm9yIGxlZ2FjeSBD
IEFQSQo+IGxpYnJhcnkgc291cmNlKS4KPgo+IFRoYXQncyB3aHkgSSBxdWl0ZSBsaWtlIExpJ3Mg
YXBwcm9hY2ggKEknbSBvayBpZiBsaWJzLyBzb3VyY2VzJyBoZWFkZXJzIHdpbGwKPiBoYXZlICds
aWInIHByZWZpeCBpbnN0ZWFkIG9mICd0c3RfJyksIGFsdGhvdWdoIEkgbGlrZWQgbW9yZQo+IGxp
YnMvc2lnd2FpdC9zaWd3YWl0LmMgdGhhbiBsaWJzL3NpZ3dhaXQvbGlic2lnd2FpdC5jLgo+Cj4g
PiBJIGluZGVlZCB0aG91Z2h0IGFib3V0IGFsbCB1c2UgdHN0XyogZm9yIHRob3NlIGdsb2JhbCBo
ZWFkZXIgZmlsZXMuCj4gPiBCdXQgdG8gZGlzdGluZ3Vpc2ggbGliLyB3aXRoIGxpYnMvIEkgZmlu
YWxseSBmZWVsIHRoYXQgbGlicy8gaXMgbm90IHRoZQo+ID4gY29yZSBMVFAgQVBJCj4gPiBhbmQg
c29tZXRpbWVzIGJ1aWx0IG9ubHkgd2hlbiB0aGV5IGFyZSBuZWVkZWQsIGlmIHdlIHJlbmFtZSBh
bGwgdGhlc2UKPiA+IGhlYWRlciBmaWxlIHdpdGggdHN0XyogdGhhdCB3aWxsIG1pc2xlYWQgcGVv
cGxlIHRvIGZpbmQgdGhlICouYyBmaWxlIGluCj4gPiBsaWIvLCB3aGljaAo+ID4gaXMgbm90IHRo
ZSByaWdodCBwbGFjZS4KPgo+ID4gU28gaW4gbXkgcGF0Y2gsIGtlZXAgZGVmaW5lIHRzdF8qIG9u
bHkgZm9yIHRoZSBjb3JlIExUUCBBUEksIGFuZCBsaWIqIHByZWZpeAo+ID4gcmVzZXJ2ZSBmb3Ig
bGlicy8gdGhhdCB3aWxsIGJlIGNsZWFyIGF0IGEgZ2xhbmNlLgo+Cj4gKzEKPgo+ID4gT3IsIGlm
IGdvIHdpdGggdHN0XyouaCBmb3IgYWxsIChhbmQgcmVuYW1lIGZ1bmN0aW9ucyB3aXRoIHRzdF8q
KSwgSSB0aGluawo+ID4gdGhlIGxpYnMvIHNob3VsZCBiZSBtZXJnZWQgaW50byBsaWIvLgo+Cj4g
SSBkb24ndCB0aGluayB0aGlzIHdvdWxkIGJlIGdvb2QuIEl0IHdvdWxkIHJlcXVpcmUgYWxzbyBj
aGFuZ2luZyBhIGJ1aWxkIHN5c3RlbSwKPiB0b3VjaCB0b28gbWFueSBmaWxlcy4gQW5kIEkgZG9u
J3QgZXZlbiBzZWUgYSBiZW5lZml0IGZvciBhIHN1Y2ggY2hhbmdlLgoKSSdkIGtlZXAgdGhlbSBz
ZXBhcmF0ZSBmcm9tIGNvcmUgbGlicmFyeS4gRm9yIG5vbi1jb3JlIGxpYnJhcmllcywgSSdkIGdv
IHdpdGgKc29tZXRoaW5nIG1vcmUgZGlzdGluY3QsIGxpa2UgImx0cCIgcHJlZml4IGZvciBmaWxl
IGFuZCBmdW5jdGlvbiBuYW1lcy4KCldoZW4gSSBsb29rIGF0ICJsaWJudW1hLmgiIEknZCBoYXZl
IHRvIHRoaW5rIGZvciBhIGJpdCBpZiB0aGlzIGlzCmhlYWRlciBmcm9tIG51bWEtZGV2ZWwKb3Ig
TFRQLiAibHRwbnVtYS5oIiBzZWVtcyAodG8gbWUpIG1vcmUgY2xlYXIgdGhhdCBpdCdzIG5vdCBM
VFAgY29yZQpub3IgbnVtYS1kZXZlbC4KCm15IDIgY2VudHMsCkphbgoKPgo+IEtpbmQgcmVnYXJk
cywKPiBQZXRyCj4KPiA+IEBDeXJpbCwgUGV0ciwgYW55IGNvbW1lbnRzPwo+Cj4gSSBhbHNvIHdv
bmRlciBDeXJpbCdzIGFuZCBKYW4ncyBvcGluaW9uLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
PgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
