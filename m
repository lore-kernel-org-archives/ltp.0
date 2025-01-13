Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB5AE77188
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 02:48:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420A43C7718
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 03:48:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B41B3C06C1
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 03:47:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC3A6601548
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 03:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736736467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPXxAcnbKbTiv2RGqWJLm/o0xYiYc1CWXLOPI1jbncs=;
 b=DT3tJ1e/4/DEhmzwHFMgRciu6Otfcmj3LHi9ApMplRdpwsz7gcpKqEoQaG7a3e3DOyeJ2e
 XcAWO+7yRsUAR6f7O7AWPlLfGNLtAW4q73O66lTXuWYuGYbHmxmkWqA33Jlzl8xFn6JwAa
 QNKeJUj/6bMfNhIKBpI2aPOddaWkRwg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-AN5982ysM9203YKm-_QkPw-1; Sun, 12 Jan 2025 21:47:45 -0500
X-MC-Unique: AN5982ysM9203YKm-_QkPw-1
X-Mimecast-MFC-AGG-ID: AN5982ysM9203YKm-_QkPw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso6872938a91.3
 for <ltp@lists.linux.it>; Sun, 12 Jan 2025 18:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736736464; x=1737341264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NPXxAcnbKbTiv2RGqWJLm/o0xYiYc1CWXLOPI1jbncs=;
 b=hpQ6whdEEP2n/FhSiKoBLqkLh25g5bjccO1mzAFfgqFyBpcCTvbpU43gYXPk9QWA3f
 y4v9ltISiT1wGlZwhdeQBklTiACOk8B8q3MURruJMyTg20kOosVZDWpLZavtduUyJ+wK
 zyvLOsJv3QMNrCcIbaL/vIHqAnzzulrhR7YHdngw4nrpkPfqzD7mnwktczZ28NqMFmfL
 4BrMGe6L7ywBgJ4n2M0Kw64Xmme7Z9r80U2iUgkNMzwl0DnlYFleF3xbfIfK6G8JUQ9X
 EmGyUARrwxb680d8LN8af4LSl0RbsgChJUiA+N7SE+FtUalpdVbcSpfPd7PGDPY92ewj
 Apdg==
X-Gm-Message-State: AOJu0Yw10N/VGlYHI/+EnukWlHw61OGmbMLVBpAG35j9IYGAu/VgQDyz
 u/bKG15iTa/eCgz5wwbSAi17nERWh+3JTApAPgJYdXWI/e0Y/lUatoZIIXrW9/h/HUuGdyZ2a8V
 bBb/VHJlUaYLN7IcYiW+OTUWRcSwd+Mm+Rta2yIuh99IFHWH1b05JXCUnMKCRUjMgnGrwP/Na22
 z1WH5960P0ExOzagZrW3I91KU=
X-Gm-Gg: ASbGncsnXqxGhy+jxju8ul3CysQW/eIFAEHlOQWZp7eD9AgLOAO0ZOOl5lBHOv1EDy7
 xMAX25FKUcfm8BPuZmNQ3LidCBJ0AhvLDAlnIzhw=
X-Received: by 2002:a17:90b:534b:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f548f1cb1bmr29851903a91.24.1736736464498; 
 Sun, 12 Jan 2025 18:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoXgP7MXaLqGISlMXnBgBMsE29enJOqeKAznb1F1pwyw7Sy/M8BrWxribLa+O404NCDmSSEFZ5caEyEqUTSAg=
X-Received: by 2002:a17:90b:534b:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f548f1cb1bmr29851883a91.24.1736736464200; Sun, 12 Jan 2025
 18:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20250109130032.50480-1-liwang@redhat.com>
 <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
 <20250110171304.GB413134@pevik>
In-Reply-To: <20250110171304.GB413134@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Jan 2025 10:47:31 +0800
X-Gm-Features: AbW1kvba1DL7QFNtaic8YIOwl4DcvR3-udT1FNrooltNOEMqIYp0MzRKvs36G9Y
Message-ID: <CAEemH2evyoXnbN+Jnfp1uCtrGwP9-heDVM1trouQAtjz-k1Npw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wIIXxZK-rgaGglIiNrcreBnHN4ay927U8Y1AyFL8jTM_1736736464
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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

T24gU2F0LCBKYW4gMTEsIDIwMjUgYXQgMToxM+KAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gV2UgaGF2ZSBzb21lIHdhcm5pbmdzIGR1
ZSB0aGlzIGNoYW5nZToKPiAtICAgICAgIGludCBtYXhfcnVudGltZTsKPiArICAgICAgIHVuc2ln
bmVkIGludCBydW50aW1lOwo+Cj4gdHN0X3Rlc3QuYzogSW4gZnVuY3Rpb24g4oCYdHN0X3JlbWFp
bmluZ19ydW50aW1l4oCZOgo+IHRzdF90ZXN0LmM6MTY5MTozMDogd2FybmluZzogY29tcGFyaXNv
biBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mCj4gZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKAmHVu
c2lnbmVkIGludOKAmSBhbmQg4oCYaW504oCZIFstV3NpZ24tY29tcGFyZV0KPiAgMTY5MSB8ICAg
ICAgICAgaWYgKHJlc3VsdHMtPnJ1bnRpbWUgPiBlbGFwc2VkKQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCj4gdHN0X3Rlc3QuYzogSW4gZnVuY3Rpb24g4oCYc2V0X292
ZXJhbGxfdGltZW91dOKAmToKPiB0c3RfdGVzdC5jOjE3MjA6MzA6IHdhcm5pbmc6IGNvbXBhcmlz
b24gb2YgdW5zaWduZWQgZXhwcmVzc2lvbiBpbiDigJg8IDDigJkgaXMKPiBhbHdheXMgZmFsc2Ug
Wy1XdHlwZS1saW1pdHNdCj4gIDE3MjAgfCAgICAgICAgIGlmIChyZXN1bHRzLT5ydW50aW1lIDwg
MCkgewo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4KPiBJIHN1cHBv
c2Ugd2UgZG9uJ3QgbmVlZCB0aGlzIGNoZWNrIGFueSBtb3JlOgo+Cj4gICAgICAgICBpZiAocmVz
dWx0cy0+cnVudGltZSA8IDApIHsKPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInJ1
bnRpbWUgbXVzdCB0byBiZSA+IDAhICglZCkiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJl
c3VsdHMtPnJ1bnRpbWUpOwo+ICAgICAgICAgfQo+Cj4gYmVjYXVzZSBUU1RfVU5MSU1JVEVEX1RJ
TUVPVVQgaXMgbm93IHRlc3RlZCBhZ2FpbnN0IHRzdF90ZXN0LT50aW1lb3V0Lgo+Cj4gQ291bGQg
eW91IHBsZWFzZSBmaXggaXQgYmVmb3JlIG1lcmdlPwo+Cj4gPiA+ICB0aW1lb3V0OiBEZWZpbmVz
IHRoZSBtYXhpbXVtIHRpbWUgYWxsb3dlZCBmb3IgdGhlIGVudGlyZSB0ZXN0LAo+IGluY2x1ZGlu
Zwo+ID4gPiAgICAgICAgICAgc2V0dXAsIGV4ZWN1dGlvbiwgYW5kIGNsZWFudXAsIHdoZW4gbm8g
ZXhwbGljaXQgcnVudGltZSBpcwo+IHNldC4KPiA+ID4gICAgICAgQnV0IGlmIGEgcnVudGltZSBp
cyBleHBsaWNpdGx5IGRlZmluZWQgYW5kCj4gdHN0X3JlbWFpbmluZ19ydW50aW1lKCkKPiA+ID4g
ICAgICAgaXMgdXNlZCwgdGhlIHRpbWVvdXQgYXBwbGllcyBvbmx5IHRvIHRoZSBzZXR1cCBhbmQg
Y2xlYW51cAo+IHBoYXNlcywKPiA+ID4gICAgICAgYXMgdGhlIHJ1bnRpbWUgY29udHJvbHMgdGhl
IHRlc3QgZXhlY3V0aW9uIGR1cmF0aW9uLgo+Cj4gPiA+ICBydW50aW1lOiBUaGUgbWF4aW11bSBy
dW50aW1lIG9mIHRoZSB0ZXN0J3MgbWFpbiBleGVjdXRpb24gbG9vcCwgdXNlZAo+ID4gPiAgICAg
ICAgICAgaW4gdGVzdHMgdGhhdCBjYWxsIHRzdF9yZW1haW5pbmdfcnVudGltZSgpLiBJdCBlbnN1
cmVzIHRoZQo+ID4gPiAgICAgICBtYWluIGV4ZWN1dGlvbiBydW5zIGZvciBhIGZpeGVkIGR1cmF0
aW9uLCByZWdhcmRsZXNzIG9mIGtlcm5lbAo+ID4gPiAgICAgICBjb25maWd1cmF0aW9uIChlLmcu
LCBkZWJ1ZyBrZXJuZWwpLgo+Cj4gSWYgSSBsb29rIGNvcnJlY3RseSBhdG0gd2UgaGF2ZSBub25l
IHRlc3RzIHdpdGggYm90aCAudGltZW91dCBhbmQgLnJ1bnRpbWUuCj4KPiBJTUhPIG9ubHkgdGVz
dHMgd2l0aCB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSBvciBmdXp6eSBzeW5jIHNob3VsZCB1c2UK
PiAucnVudGltZS4KPgo+IFdoZW4gSSBjaGVjazoKPgo+ICQgZ2l0IGdyZXAgLWwgLWUgdHN0X3Jl
bWFpbmluZ19ydW50aW1lIC1lIHRzdF9mdXp6eV9zeW5jLmggJChnaXQgbG9nCj4gLS1vbmVsaW5l
IC0tcHJldHR5PSJmb3JtYXQ6IiAtLW5hbWUtb25seSAtMSkgfHdjIC1sCj4gNjAKPgo+ICQgZ2l0
IGdyZXAgICdcLnJ1bnRpbWUnICQoZ2l0IGxvZyAtLW9uZWxpbmUgLS1wcmV0dHk9ImZvcm1hdDoi
IC0tbmFtZS1vbmx5Cj4gLTEpIHx3YyAtbAo+IDYwCj4KPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMi5jIHVzZXMgLnJ1bnRpbWUgYnV0IChhcwo+IEN5cmls
Cj4gbm90ZWQpIHlvdSB3YW50ZWQgdG8gYWRkIGl0IC50aW1lb3V0IChJIGFsc28gdGhpbmsgaXQg
c2hvdWxkIHVzZSAudGltZW91dCkuCj4KPiBCdXQgdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9jZnMt
c2NoZWR1bGVyL3N0YXJ2YXRpb24uYyBjYWxscwo+IHRzdF9yZW1haW5pbmdfcnVudGltZSgpIGJ1
dCBpdCdzIHdpdGhvdXQgLnJ1bnRpbWUuIERvbid0IHdlIHdhbnQgdG8gc2V0IGl0Pwo+CgpObywg
dGhlIC5ydW50aW1lIGlzIGJlaW5nIHNldCBieSB0c3Rfc2V0X3J1bnRpbWUgaW4gdGhlIHNldHVw
LAp0aGF0IGlzIGJhc2VkIG9uIHRoZSBDUFUgY2FsaWJyYXRlIGFuZCBrZXJuZWwgY29uZmlncyBt
ZWFzdXJlbWVudC4KClNvLCBpdCdzIHVubmVjZXNzYXJ5IHRvIHNldCBhIHZhbHVlIGluIHRoZSB0
c3RfdGVzdC0+cnVudGltZSBhZ2FpbiwKaXQgd2lsbCBiZSByZXNldCBpbiB0aGUgc2V0dXAgYW55
d2F5LgoKVGhlIHJlc2V0IGNvbW1lbnRzIGFsbCBzb3VuZCBnb29kIHRvIG1lLiBUaGFua3MhCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
