Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5FAC7EE23
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 09:57:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A4383CCB21
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 11:57:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64EFD3CBCFB
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:57:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2643A600216
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685959031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KCV+eWw1ILp5Q1oaQePydrQHgPC6zgF+Uo30bGnkkIM=;
 b=WJnugS6xcPXKNURYBDfAJPuVP0FRNr4oTo9+u8bcVWq68Hdkeg6vLd4K5+UxHnUHQi4QgS
 nn7SUEmkWfnSQ08IwXmJgO7WAdppVM9Y+gYox41AQcNbZN96PDYx61apGFpCsTEAYb29Sv
 R6Qr6dAUtLBfte4uuZKbn8JNue+ZktQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-yCb5MMGNPHaYrtWN4BphBQ-1; Mon, 05 Jun 2023 05:57:10 -0400
X-MC-Unique: yCb5MMGNPHaYrtWN4BphBQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1a3a25012so19501231fa.1
 for <ltp@lists.linux.it>; Mon, 05 Jun 2023 02:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685959028; x=1688551028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KCV+eWw1ILp5Q1oaQePydrQHgPC6zgF+Uo30bGnkkIM=;
 b=FSUtnZg2xQzGupPJKwT3KUDpCOpj6z8QFSJwgxIBAhMGQ1Su5QuiC5cgPWI0bCQONa
 NW+dRoPHrHbpTp6VEk7DVN24hXEYLES9/ha0GceBYsk09xdiUVLnsIaJlgnrjp3RmISD
 giMAY/o7mbZjvuAk6j6Jls1MYI1t9RzUpxcIWKD2JpL0iPdsQSl1ncOSYaeMS6x2B4la
 JettG6MCKGDJWUXhwi8cNfmc4GLEo3LPS+IBfOb1iDK7mqvZT231rfsKerfjRXk2fUF+
 ry8hj28wzaEcCJyNgsv/qN4QfhCKQFztPnPRldDrarSSveRoYTalM0CP3fO8NAITB8ps
 y5PQ==
X-Gm-Message-State: AC+VfDxB0kklziTHkoCHuCvy4U/1cODkKHLoS1+d87fkpMYr8BN23XaU
 oONAPuJvF+omSgqcl8OXN3VMLoqEKeOr/bdP06r+QKc0HGDR8xIHl5/Vl204kQmSU4Utsio2xY2
 jqkG1cORoWL30ZyiN6KrXD+Bd1yI=
X-Received: by 2002:a2e:b53c:0:b0:2b1:eb93:bef2 with SMTP id
 z28-20020a2eb53c000000b002b1eb93bef2mr59469ljm.5.1685959028777; 
 Mon, 05 Jun 2023 02:57:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZEvUWIAHKIZlrGAsO4Xlhe0UG5Diqbqz5BXZHNS4kU9icoalL3HO1bDQCqBdNh/ZmFlMU0Ir9GWpwfqKlxtw=
X-Received: by 2002:a2e:b53c:0:b0:2b1:eb93:bef2 with SMTP id
 z28-20020a2eb53c000000b002b1eb93bef2mr59462ljm.5.1685959028434; Mon, 05 Jun
 2023 02:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230604095117.3543342-1-jencce.kernel@gmail.com>
 <233a0f31-e4de-de65-4752-d43cb1ae3c1f@suse.cz>
In-Reply-To: <233a0f31-e4de-de65-4752-d43cb1ae3c1f@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Jun 2023 17:56:56 +0800
Message-ID: <CAEemH2ftudd3aAjkMYFQLx8Yy5cV4ne=sF2U7_Av5iZ=DxmS3A@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: print debug info about mounting
 operation
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

T24gTW9uLCBKdW4gNSwgMjAyMyBhdCA0OjQw4oCvUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6PiB3cm90ZToKCj4gSGksCj4KPiBPbiAwNC4gMDYuIDIzIDExOjUxLCBNdXJwaHkgWmhv
dSB3cm90ZToKPiA+IFNpZ25lZC1vZmYtYnk6IE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdt
YWlsLmNvbT4KPiA+IC0tLQo+ID4gICBsaWIvc2FmZV9tYWNyb3MuYyB8IDE3ICsrKysrKysrKysr
KysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIvbGliL3NhZmVfbWFjcm9zLmMKPiA+IGluZGV4
IGFmNmRkMDcxNi4uYTY2Mjg1YTBlIDEwMDY0NAo+ID4gLS0tIGEvbGliL3NhZmVfbWFjcm9zLmMK
PiA+ICsrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4gPiBAQCAtODk4LDcgKzg5OCwyNCBAQCBpbnQg
c2FmZV9tb3VudChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+IHZvaWQgKCpj
bGVhbnVwX2ZuKSh2b2lkKSwKPiA+ICAgICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKQo+ID4g
ICB7Cj4gPiAgICAgICBpbnQgcnZhbCA9IC0xOwo+ID4gKyAgICAgY2hhciBjZGlyW1BBVEhfTUFY
XSwgbXBhdGhbUEFUSF9NQVhdOwo+ID4KPiA+ICsgICAgIGlmICghZ2V0Y3dkKGNkaXIsIFBBVEhf
TUFYKSkgewo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzbShUV0FSTiB8IFRFUlJOTywgIkZhaWxl
ZCB0byBmaW5kIGN1cnJlbnQKPiBkaXJlY3RvcnkiKTsKPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IDA7Cj4KPiBZb3UgcmV0dXJuIHN1Y2Nlc3Mgd2hlbiBub3RoaW5nIHdhcyBtb3VudGVkLiBUaGF0
IGlzIGNsZWFybHkgd3JvbmcuCj4gRWl0aGVyIGNhbGwgdHN0X2Jya21fKC4uLiBUQlJPSyAuLi4p
IGlmIHRoZSBmYWlsdXJlIGlzIHNvIHNlcmlvdXMgdGhhdAo+IHRoZSB0ZXN0IGNhbm5vdCBjb250
aW51ZSwgb3IgZG9uJ3QgcmV0dXJuIGF0IGFsbC4KPgo+ID4gKyAgICAgfQo+ID4gKwo+ID4gKyAg
ICAgcnZhbCA9IHNucHJpbnRmKG1wYXRoLCBQQVRIX01BWCwgIiVzLyVzIiwgY2RpciwgdGFyZ2V0
KTsKPgo+IFRoZSBDIGxpYnJhcnkgaGFzIGEgZnVuY3Rpb24gZm9yIHJlc29sdmluZyBwYXRoczog
cmVhbHBhdGgoKS4gUGxlYXNlIHVzZQo+IHRoYXQuCj4KCgorMSwgZ29vZCBwb2ludC4gcmVhbHBh
dGgoKSBpcyBtb3JlIGNvbnZlbmllbnQsIHdlIGRvbid0Cm5lZWQgdG8gYWRkaXRpb25hbGx5IGNv
cHkgc3RyaW5nIHRvIHRoZSBhYnNvbHV0ZSBwYXRoLgoKQE11cnBoeSwgaWdub3JlIG15IHByZXZp
b3VzIGNvbW1lbnRzIHBsei4KCgoKPgo+ID4gKyAgICAgaWYgKHJ2YWwgPCAwIHx8IHJ2YWwgPj0g
UEFUSF9NQVgpIHsKPiA+ICsgICAgICAgICAgICAgdHN0X3Jlc20oVFdBUk4gfCBURVJSTk8sCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICJzbnByaW50ZigpIHNob3VsZCBoYXZlIHJldHVybmVk
ICVkIGluc3RlYWQgb2YKPiAlZCIsCj4gPiArICAgICAgICAgICAgICAgICAgICAgIFBBVEhfTUFY
LCBydmFsKTsKPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7Cj4KPiBSZXR1cm5pbmcgaGVyZSBp
cyBhbHNvIHdyb25nLgo+Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICB0c3RfcmVzbV8oZmls
ZSwgbGluZW5vLCBUSU5GTywKPiA+ICsgICAgICAgICAgICAgIk1vdW50aW5nICVzIHRvICVzIGZz
dHlwPSVzIGZsYWdzPSV4IiwKPiA+ICsgICAgICAgICAgICAgc291cmNlLCBtcGF0aCwgZmlsZXN5
c3RlbXR5cGUsIG1vdW50ZmxhZ3MpOwo+ID4gICAgICAgLyoKPiA+ICAgICAgICAqIERvbid0IHRy
eSB1c2luZyB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIgd2hlbiBtb3VudGluZyBOVEZTLAo+IHNp
bmNlCj4gPiAgICAgICAgKiB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIgZG9lc24ndCBoYXZlIHBy
b3BlciB3cml0ZSBzdXBwb3J0Lgo+Cj4gLS0KPiBNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNl
LmN6Cj4gU1cgUXVhbGl0eSBFbmdpbmVlcgo+IFNVU0UgTElOVVgsIHMuci5vLgo+IENPUlNPIElJ
YQo+IEtyaXppa292YSAxNDgvMzQKPiAxODYgMDAgUHJhZ3VlIDgKPiBDemVjaCBSZXB1YmxpYwo+
Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
