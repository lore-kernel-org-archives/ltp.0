Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E6FC77B7D
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 06:40:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC063CD679
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 08:40:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DB073C25BE
 for <ltp@lists.linux.it>; Wed, 10 May 2023 08:40:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BADBD1000938
 for <ltp@lists.linux.it>; Wed, 10 May 2023 08:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683700809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gENN6Ewx9wJK9MyaJOMgdOow6fp41krzK5Q14dgKpxA=;
 b=Jqza9QJ3jPkkROEQtmJCmRjlE1TKCDxlyj9KH6bp8aa4vF37Lso65Unvx1GGcnkSnYidog
 ogMrSz0a6Qctxgtv81PNLCaB4rKeKTDMbwQw6L0C/H6Unpu//qA0mLUZgA+kM+O+tTIVcw
 R8rFCN987hKuSQTU03fvmd7eoubyVns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ExMAt72bNB2J8OFcam4grw-1; Wed, 10 May 2023 02:40:07 -0400
X-MC-Unique: ExMAt72bNB2J8OFcam4grw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ac7f9e64ecso35126231fa.3
 for <ltp@lists.linux.it>; Tue, 09 May 2023 23:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683700804; x=1686292804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gENN6Ewx9wJK9MyaJOMgdOow6fp41krzK5Q14dgKpxA=;
 b=SZ1Z7KN5TS5gSoqXxaIZ4bbP82vQXGH9fl+W1u5eyqIyqkoODQq4xNHe/gMOpaO5aR
 NXKn9rwPpe5TuhyUbE5oPDhTn/t46j/lSgVmiCbI4ijNcMYiw8RILuyPRz2uLNEYq1cF
 757AQ4uO3H/sllZQvovyd15I/f3c/+Ay2Jz78M43TrP0/tuwiR4Uj0bE6vKUg3lIX1d6
 Vd1mJnxkrSAA0kMOzLu4P1BNuoGENCjiQAZVTSYEYPTujC0BFAcA/jFQDN5SPbC2fVEh
 zztYgWtG+EudCoqpeotvfyLFnM/3SNi31TRCEaXADs/XVXlMVfFIfyIF/Csjhcki4iok
 196g==
X-Gm-Message-State: AC+VfDzs7P8zRaVDqkXDQmY4qsVput9Nw3cvbyykPWv9jg3o3bTykjGF
 DCv7xjcRP0n1JXfKQiatufa6zxyPrb7BLZq/2zFAyZduEvp5rCtSRtAYCR6Yt4ib62nzKJ4mU9t
 CcOiUI16gu3VnIwSf+Hq5RBlZonTVzey8VWh+dA==
X-Received: by 2002:a2e:a401:0:b0:2a8:ea22:28a8 with SMTP id
 p1-20020a2ea401000000b002a8ea2228a8mr1670690ljn.15.1683700804673; 
 Tue, 09 May 2023 23:40:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tQJlaTcs5ihF0LP3yFJRB86s6ThBVoxz3OOacAP6axS5T5HTTrf2Zl8yZ4NX2dXuCmQ08D5grE9qfsdoak+s=
X-Received: by 2002:a2e:a401:0:b0:2a8:ea22:28a8 with SMTP id
 p1-20020a2ea401000000b002a8ea2228a8mr1670679ljn.15.1683700804333; Tue, 09 May
 2023 23:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
 <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
 <ZFoSZkkjVXQhdEpe@yuki>
In-Reply-To: <ZFoSZkkjVXQhdEpe@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 May 2023 14:39:52 +0800
Message-ID: <CAEemH2fycnWnsMe7sKZn357zj5QZr_Y7+ML0GAAWeQGkASu47g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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

SGkgQ3lyaWwsCgpPbiBUdWUsIE1heSA5LCAyMDIzIGF0IDU6MzTigK9QTSBDeXJpbCBIcnViaXMg
PGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gPiBNb3JlIHdpZGVseSBMVFAgcHJl
LXJlbGVhc2UgdGVzdCB3aWxsIGJlIGRlcGxveWVkIGJhc2Ugb24gUkhFTCBwcm9kdWN0cwo+ID4g
PiBhcyB3ZWxsLgo+ID4gPgo+ID4KPiA+IEkgaGF2ZSBjb21wbGV0ZWQgdGhlIExUUCBwcmUtcmVs
ZWFzZSB0ZXN0IGFnYWluc3QgUkhFTCA4IGFuZCA5LAo+ID4gYWxsIGxvb2tzIGdvb2QgZXhjZXB0
IG9uZSB0ZXN0IHdhcm5pbmcgYXMgYmVsb3csIGJ1dCBJIHN1cHBvc2UKPiA+IGl0J3MgYSB0aW55
IHByb2JsZW0gY2F1c2VkIGJ5IHRoZSBwcGM2NGxlIGNvbmZpZ3VyYXRpb24uCj4gPgo+ID4gVGhp
cyBvbmx5IG9ic2VydmVkIG9uIHBwYzY0bGUgYXJjaDoKPiA+Cj4gPiAzIGNtZGxpbmU9Imh1Z2Vt
bWFwMzIiCj4gPgo+ID4gICAgICA0ICAgICAgICBjb250YWN0cz0iIgo+ID4gICAgICA1ICAgICAg
ICBhbmFseXNpcz1leGl0Cj4gPiAgICAgIDYgICAgICAgIDw8PHRlc3Rfb3V0cHV0Pj4+Cj4gPiAg
ICAgIDcgICAgICAgIHRzdF90ZXN0LmM6MTU1ODogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAw
aCAwMW0gMDBzCj4gPiAgICAgIDggICAgICAgIGh1Z2VtbWFwMzIuYzozNDogVFdBUk46IEZhaWxl
ZCB0byBjbG9zZSBGSUxFCj4gPiAnL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0x
Njc3NzIxNmtCL25yX2h1Z2VwYWdlcycKPiA+ICAgICAgOSAgICAgICAgaHVnZW1tYXAzMi5jOjM1
OiBUQ09ORjogQ2FuJ3QgdXBkYXRlIHRoZSBnaWdhbnRpYwo+IGh1Z2VwYWdlcy4KPiA+Cj4gPiAx
MCBodWdlbW1hcDMyLmM6Njk6IFRXQVJOOiBGYWlsZWQgdG8gY2xvc2UgRklMRQo+ID4gJy9zeXMv
a2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtMTY3NzcyMTZrQi9ucl9odWdlcGFnZXMnOiBF
SU5WQUwgKDIyKQo+Cj4gTG9va2luZyBhdCB0aGUgZmlsZV9wcmludGYoKSB0aGUgdGVzdCB1c2Vz
IGl0IGRvZXMgcHJvZHVjZSBhIHdhcm5pbmcKPiB3aGVuIHdlIGZhaWwgdG8gd3JpdGUgdG8gdGhl
IGZpbGUuCj4KPiBBbHNvIHdlIHNlZW1zIHRvIGJlIHVzaW5nIEZJTEVfUFJJTlRGKCkgZXhhY3Rs
eSBpbiB0aGVzZSB0ZXN0czoKPgo+IHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvY3B1
ZnJlcS9jcHVmcmVxX2Jvb3N0LmMKPiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2Vt
bWFwL2h1Z2VtbWFwMzIuYwo+IHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWdl
dC9odWdlc2htZ2V0MDMuYwo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNudGwvZmNudGwz
My5jCj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYwo+
Cj4gSW4gdGhyZWUgY2FzZXMgd2UgdXNlIHRoZSBGSUxFX1BSSU5URigpIGluIHRoZSB0ZXN0IGNs
ZWFudXAsIHdoaWNoIGRvZXMKPiBub3QgbWF0dGVyLCBzaW5jZSB3ZSBkbyBub3QgYnJlYWsgdGVz
dCBvbiBUQlJPSyB3aGVuIHdlIHJ1biBpbiB0aGUgdGVzdAo+IGNsZWFudXAuCj4KPiBUaGF0IGxl
YXZlcyB1cyBqdXN0IGh1Z2VtbWFwMzIgYW5kIHJlYWRhaGVhZDAyIGluIGJvdGggY2FzZXMgSSB0
aGluawo+IHRoYXQgZ2VuZXJhdGluZyBUV0FSTiBpbiBqdXN0IHBsYWluIHdyb25nLgo+Cj4gU28g
d2hhdCBhYm91dDoKPgo+ICogY2hhbmdpbmcgRklMRV9QUklOVEYoKSB0byBTQUZFX0ZJTEVfUFJJ
TlRGKCkgaW4gdGVzdCBjbGVhbnVwCj4gKiBjaGFuZ2luZyBUV0FSTiB0byBUSU5GTyBpbiBGSUxF
X1BSSU5URigpCj4KPiBJIGd1ZXNzIHRoYXQgd2Ugc2hvdWxkIGhhdmUgYmVlbiB1c2luZyBUSU5G
TyBpbiB0aGUgZmlsZV9mcHJpbnRmKCkgZnJvbQo+IHRoZSBzdGFydC4KPgoKWWVzLCBzdXJlLiBJ
IHRoaW5rIHRoaXMgd2lsbCBiZSBiZXR0ZXIgZm9yIHRoZSBGSUxFX1BSSU5URiBtYWNybyB1c2Uu
ClNob3VsZCB3ZSBjaGFuZ2UgdGhhdCBpbiBhIHNlcGFyYXRlIHBhdGNoIGFmdGVyIHRoZSByZWxl
YXNlPwoKQnV0LCBJIHN1cHBvc2UgdGhhdCB3ZSBzdGlsbCBuZWVkIHRvIGNoZWNrIHRoZSBhdmFp
bGFibGUgbWVtb3J5IGluCmh1Z2VtbWFwMzIsIGJlY2F1c2UgdGhhdCBtaWdodCBiZSB0aGUgcmVh
c29uLCBpcyB1bmFibGUgdG8Kd3JpdGUgdG8gdGhlICcuLi4vbnJfaHVnZXBhZ2VzJyBmaWxlIGV2
ZW4gd2l0aCB6ZXJvLgoKIyBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0x
Njc3NzIxNmtCL25yX2h1Z2VwYWdlcwowCgojIGVjaG8gMCA+L3N5cy9rZXJuZWwvbW0vaHVnZXBh
Z2VzL2h1Z2VwYWdlcy0xNjc3NzIxNmtCL25yX2h1Z2VwYWdlcwotYmFzaDogZWNobzogd3JpdGUg
ZXJyb3I6IEludmFsaWQgYXJndW1lbnQKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
