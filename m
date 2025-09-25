Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56075CAC5A5
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 02:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758765969; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JplMErrdzObgC3U8CJVEKccMqle1jTYydQ0GUUAP3oU=;
 b=bICT+bEvw6/drwoDek3CRI191m8iorwwnB85oOMpgo181F0YiJKY34NL6uevjSC64fkP5
 j2qquLRNLG9eYeKBmplTQ8mKs7NjgMiZvySL+zIxR4oaL039FjsvnDZ2h5nD7YV9Eqwt8BL
 pdfSNWx1JevJVgZQtCGRq254DUkI+pg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3FB3CDC95
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 04:06:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81F213CA50C
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 04:05:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 801F5200042
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 04:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758765944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rDNj1FAUg6icoXS1NvEVC1+wmfmjfDVzzAFZGC8H4TE=;
 b=Tp/NMXXkQ5YFouWQDW0msmzPGqKv75UIk9No5oGkHaaJSNEgI3RKKIYX7xeexeneybvgHr
 aHv3qOHarXyHuyuPniUWy1L+3fIBEvttuYrpmFnFEBoLacQlo+CGmsATWVj7u4Kffr55XD
 QGJzLB7Vg21ZuhoZ5cyhVcmxc4L8Heg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-mqjotUq7PaWsUZDk1OpJrg-1; Wed, 24 Sep 2025 22:05:42 -0400
X-MC-Unique: mqjotUq7PaWsUZDk1OpJrg-1
X-Mimecast-MFC-AGG-ID: mqjotUq7PaWsUZDk1OpJrg_1758765941
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24458345f5dso5550435ad.3
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 19:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758765941; x=1759370741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rDNj1FAUg6icoXS1NvEVC1+wmfmjfDVzzAFZGC8H4TE=;
 b=ja0j1R1yNo8bXnd7JoTtbFldEDQd2CqcuFzvvYbC3/yVS1jMyKyRHGUOFNUiTD+y6X
 Ce7VS83lcikozZsEqCb7Q4dpwC2QfOXHuHviUbBef/ulro0Rd2Bv00eudGrofNWt3Lvb
 0DV6fndBPhF1y0nHa8KaBlK+OfEzw5mtb59BBbtwGs3yFi7E3Aw0naDIMHq9PU1+tSod
 kKSFkB5Ro46enrQenN7xwVp8nrJxHBkxHGkCSLq4qB6HNuLP1JfpnCLZYrdL9DXtpKhG
 DmQ8oK1vqgM7bPpHPfzw830VSZn9Q0hpHiIuJk1AHxRgPaffw0wh3xH1XBEPUPQRYb/u
 mBPQ==
X-Gm-Message-State: AOJu0YwcBQ5qef0fSGZvnd6DeP5TKTCdb3rnVOCPt3GvG32cROB5NbSM
 si99aCHlnHShmODXhfAOo9WegY2yU9zeASN8EO37C7MZHfbss3j+P2oNNT0T4K/7E6jRyUzHoSX
 25edSMSWJhSNO/N03i+uV1nr6fpLc4MQ72+2ilqXHMvZOp8AC6cTnchrRdOQxyo3QCV4JSoRzY2
 cK7M/nflCM1KRkz1bg+ZEfTVMq40o=
X-Gm-Gg: ASbGncubJtagrKA2MykwE9+l8QCCUR/3oISlLOY0TQV7XV/MOVnBBFjM5Q6KHG1mRNF
 D8AsUNBhi6fUGHkj0bxOtihGsgOT2nuBHf8pIsk094B6vplbPrhbs+RCWEzLWDYm//sFzsAxsQA
 J9gSa/VUxVQGQIDx7tbAEH6w==
X-Received: by 2002:a17:903:286:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-27ed4a9286cmr20980845ad.42.1758765941432; 
 Wed, 24 Sep 2025 19:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJigep3XSwPa1O22q7QZSARtBm2qqrruBO4Hx1rTbfVxbnOu41BY4NLome8i0JR40Yg6ewvJcQg13lh+Nj3Sw=
X-Received: by 2002:a17:903:286:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-27ed4a9286cmr20980525ad.42.1758765940952; Wed, 24 Sep 2025
 19:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <aNOuYfhEU160i2gE@yuki.lan> <20250924202923.9202-1-akumar@suse.de>
In-Reply-To: <20250924202923.9202-1-akumar@suse.de>
Date: Thu, 25 Sep 2025 10:05:27 +0800
X-Gm-Features: AS18NWAkQjcX9D5wSGOJrCb8q4nYTkyYPDdyXVhejAUBdqM4_yDuoiZpZvZc4Pg
Message-ID: <CAEemH2ebvUM8suTy2QdKecsNEdJNE+r3h==85815Oi4pjiN4EQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1GTty8ZBMGvdQo2nconmyx-p7-sMnPj-gP0gqLkgiBA_1758765941
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Introduce ioctl_pidfd_get_info_supported()
 function
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgMjUsIDIwMjUgYXQgNDoyOeKAr0FNIEF2aW5lc2ggS3VtYXIgPGFrdW1hckBz
dXNlLmRlPiB3cm90ZToKCj4gQ2hlY2sgaWYgaW9jdGwoUElERkRfR0VUX0lORk8pIGlzIGltcGxl
bWVudGVkIG9yIG5vdAo+IGJlZm9yZSBwcm9jZWVkaW5nIGluIGlvY3RsX3BpZGZkMDUgdGVzdAo+
Cj4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBTdWdnZXN0
ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IEF2aW5l
c2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPgo+CgpUaGlzIHZlcnNpb24gbG9va3MgbXVjaCBtb3Jl
IGVsZWdhbnQuCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0K
PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZC5oIHwgMjggKysr
KysrKysrKysrKysrKysrKwo+ICAuLi4va2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZk
MDUuYyAgICAgfCAgOSArKysrKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pb2N0bC9pb2N0bF9waWRmZC5oCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3Rs
L2lvY3RsX3BpZGZkLmgKPiBpbmRleCA4MTFmOTY5Y2QuLmI3ODVkODA0MyAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkLmgKPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkLmgKPiBAQCAtOSw2ICs5
LDM0IEBACj4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICAjaW5jbHVkZSAibGFwaS9waWRmZC5o
Igo+Cj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpb2N0bF9waWRmZF9nZXRfaW5mb19zdXBwb3J0ZWQo
dm9pZCkKPiArewo+ICsgICAgICAgcGlkX3QgcGlkOwo+ICsgICAgICAgaW50IHBpZGZkLCByZXQ7
Cj4gKyAgICAgICBpbnQgc3VwcG9ydGVkID0gMDsKPiArICAgICAgIHN0cnVjdCBwaWRmZF9pbmZv
IGluZm87Cj4gKwo+ICsgICAgICAgaWYgKHRzdF9rdmVyY21wKDYsIDEzLCAwKSA+PSAwKQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gMTsKPiArCj4gKyAgICAgICBtZW1zZXQoJmluZm8sIDAsIHNp
emVvZihzdHJ1Y3QgcGlkZmRfaW5mbykpOwo+ICsKPiArICAgICAgIHBpZCA9IFNBRkVfRk9SSygp
Owo+ICsgICAgICAgaWYgKCFwaWQpCj4gKyAgICAgICAgICAgICAgIGV4aXQoMTAwKTsKPiArCj4g
KyAgICAgICBwaWRmZCA9IFNBRkVfUElERkRfT1BFTihwaWQsIDApOwo+ICsKPiArICAgICAgIHJl
dCA9IGlvY3RsKHBpZGZkLCBQSURGRF9HRVRfSU5GTywgJmluZm8pOwo+ICsgICAgICAgU0FGRV9X
QUlUUElEKHBpZCwgTlVMTCwgMCk7Cj4gKwo+ICsgICAgICAgaWYgKHJldCAhPSAtMSkKPiArICAg
ICAgICAgICAgICAgc3VwcG9ydGVkID0gMTsKPiArCj4gKyAgICAgICBTQUZFX0NMT1NFKHBpZGZk
KTsKPiArICAgICAgIHJldHVybiBzdXBwb3J0ZWQ7Cj4gK30KPiArCj4gIHN0YXRpYyBpbmxpbmUg
aW50IGlvY3RsX3BpZGZkX2luZm9fZXhpdF9zdXBwb3J0ZWQodm9pZCkKPiAgewo+ICAgICAgICAg
aW50IHJldDsKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9p
b2N0bF9waWRmZDA1LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
cGlkZmQwNS5jCj4gaW5kZXggYzM3OTcxN2IzLi5kMjBjNmYwNzQgMTAwNjQ0Cj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA1LmMKPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDUuYwo+IEBAIC0xNCw3ICsx
NCw3IEBACj4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICAjaW5jbHVkZSAibGFwaS9waWRmZC5o
Igo+ICAjaW5jbHVkZSAibGFwaS9zY2hlZC5oIgo+IC0jaW5jbHVkZSAibGFwaS9pb2N0bC5oIgo+
ICsjaW5jbHVkZSAiaW9jdGxfcGlkZmQuaCIKPgo+ICBzdHJ1Y3QgcGlkZmRfaW5mb19pbnZhbGlk
IHsKPiAgICAgICAgIHVpbnQzMl90IGR1bW15Owo+IEBAIC00OCw4ICs0OCwxNSBAQCBzdGF0aWMg
dm9pZCBydW4odm9pZCkKPiAgICAgICAgIFNBRkVfQ0xPU0UocGlkZmQpOwo+ICB9Cj4KPiArc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsgICAgICAgaWYgKCFpb2N0bF9waWRmZF9nZXRf
aW5mb19zdXBwb3J0ZWQoKSkKPiArICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgImlvY3Rs
KFBJREZEX0dFVF9JTkZPKSBpcyBub3QgaW1wbGVtZW50ZWQiKTsKPiArfQo+ICsKPiAgc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnRlc3RfYWxsID0gcnVuLAo+ICsg
ICAgICAgLnNldHVwID0gc2V0dXAsCj4gICAgICAgICAuZm9ya3NfY2hpbGQgPSAxLAo+ICAgICAg
ICAgLmJ1ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtdKSB7Cj4gICAgICAgICAgICAgICAgIHsm
YXJncywgLnNpemUgPSBzaXplb2YoKmFyZ3MpfSwKPiAtLQo+IDIuNTEuMAo+Cj4KPiAtLQo+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4K
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
