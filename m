Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0241AC2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 08:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6103E3D12C9
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 10:29:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E36A23C1037
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:28:45 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88044601283
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720772922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0OokuahtLFRzBkMTwSHSStK248Q3a0hGVTEz9F0bFRU=;
 b=YaQv90hyIe8arzs5aSRFuuYz4YGQ2QQcpcZJ0hvTs3K3Y8XovcGLX5wO0JPhZtqPfNUdhB
 b6XHIU9tukm145MXDTKNIWw0bBBYqrCKlku2vYF1zXexHpwzgFymHgIqxZEhuaPLJ5fNNP
 XmUm2HM9qijf6/iMrLvdvkmB4s0xGMY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-V9VVNl0cPqKaXlyxWgYaUw-1; Fri, 12 Jul 2024 04:28:41 -0400
X-MC-Unique: V9VVNl0cPqKaXlyxWgYaUw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-703680ab6e1so1437858a34.1
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720772920; x=1721377720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OokuahtLFRzBkMTwSHSStK248Q3a0hGVTEz9F0bFRU=;
 b=G4cVNwJ4IdBFxzF6BoDfzdJexbYt8GixRHcnk//ICt0UaWwQNbkkuJjJwLRVJPX3YN
 75U9tUllH8B0a69TgiCT3Nl/P36kU2WtDCYS7OveNoW4y6A6e7YRSpgpqvv9lJdgfE1P
 stxbv4MTIRJWZpSYK81BYxYBj8PrhHD3kJR9/kYmMuLTMkbrseaUrtUwVzHq6geeZ63U
 zjBPzxc49z2K94j2B0QaIq7pl0gt57caoevSWvd1U5fdLpcTxn4f8LubxJOh6RKtdOau
 n4BbA71KFoPjUAzfvjNhSmvGiilYCLjE0pk4p81yuNF0Edt2DZtLHAYA+byQxz0p/Utm
 abIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+oq4+TTYkLDLs3h7oscamRuX9AeW8IUUUrmNGM+k/pLipmuhXkRIs1QhkP7/af7G/X0ehE9ydOgJkU6TIjMawdus=
X-Gm-Message-State: AOJu0YzXGZVtrD88aZVZ3bjK47F8qoP1054wt82biyUj/4yo3icgnbi1
 r6Dx02XAQVygN5s2cQPdcSo840Glk21lxpAp4rzDO4kJa9pYV4zW4ITJ/0TJ4/67rYMwJmzPOsb
 aqe2JxjDkh9UEYv0q1RT/0Ye3PWPbG0XdjMO41ijbm4ZkQ/kRzLHd+6tKW4I8CLR8cPNMDRyWL+
 vXXzYsO46CNro0oqiK466+trwh4m0B0CM=
X-Received: by 2002:a05:6359:a20:b0:1a6:b009:503a with SMTP id
 e5c5f4694b2df-1aade0db93emr1005096055d.4.1720772919872; 
 Fri, 12 Jul 2024 01:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVPEGi2OweA6k3Ll157eqbc/LVJ+VhIWsodteq6ecuzKCMmpLXULq76AD+66WkFRGCCyRL+k2vuaKrBRn77Uo=
X-Received: by 2002:a05:6359:a20:b0:1a6:b009:503a with SMTP id
 e5c5f4694b2df-1aade0db93emr1005094555d.4.1720772919534; Fri, 12 Jul 2024
 01:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
 <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
 <CAEemH2eYZ05Fn0ZYhpG16UUzYo=F3GKBpYeRG_X2BUdrLbY8PA@mail.gmail.com>
 <20240712075758.GB103986@pevik>
In-Reply-To: <20240712075758.GB103986@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 16:28:11 +0800
Message-ID: <CAEemH2dbmbFfxre-LbQ+ayf=dDbBD0sg1z4aec0oOu=Xnu9Enw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

SGkgUGV0ciwKCk9uIEZyaSwgSnVsIDEyLCAyMDI0IGF0IDM6NTjigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIEFuZHJlYSwgTGksCj4KPiAuLi4KPiA+ID4+IEZp
cnN0LCB0aGlzIGZhaWxzIGF0IGxlYXN0IG9uIHZhcmlvdXMga2VybmVsIHZlcnNpb25zICh0ZXN0
ZWQ6Cj4gVHVtYmxld2VlZAo+ID4gPj4gNi4xMC4wLXJjNy0zLmc5MmFiYzEwLWRlZmF1bHQsIGFu
ZCBTTEUxNS1TUDQgNS4xNC4yMSB3aXRoCj4gbHNtPWxhbmRsb2NrIGFuZAo+ID4gPj4gRGViaWFu
IDYuNi4xNS1hbWQ2NCk6Cj4KPiA+ID4+IGxhbmRsb2NrMDEuYzo0OTogVEZBSUw6IFNpemUgaXMg
dG9vIHNtYWxsIGV4cGVjdGVkIEVJTlZBTDogRU5PTVNHICg0MikKPgo+ID4gPj4gSXMgaXQgYSBr
ZXJuZWwgYnVnIG9yIGEgdGVzdCBidWc/Cj4KPgo+ID4gPiBZb3UgcHJvYmFibHkgbmVlZCB0byBj
aGVjayB0aGUgYC91c3IvaW5jbHVkZS9saW51eC9sYW5kbG9jay5oYCBoZWFkZXIKPiBmaWxlCj4g
PiA+IGV4aXN0LAo+ID4gPiBhbmQgdG8gc2VlIGlmICdzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9h
dHRyJyBjb250YWlucyB0aGUgbmV3IGZpZWxkCj4gPiA+ICdoYW5kbGVkX2FjY2Vzc19uZXQnLgo+
Cj4gPiA+IElmIG5vdCBleGlzdCBvciBkb2VzIG5vdCBjb250YWluIHRoYXQsIHRoZSB0ZXN0IGRl
ZmluZXMgJ3N0cnVjdAo+ID4gPiBsYW5kbG9ja19ydWxlc2V0X2F0dHInCj4gPiA+IGluIGxhcGkv
bGFuZGxvY2suaCB3aGljaCBjb250YWlucyBoYW5kbGVkX2FjY2Vzc19uZXQgZGlyZWN0bHksIHRo
aXMgaXMKPiA+ID4gbGlrZWx5IHRoZQo+ID4gPiByb290IGNhdXNlIGxlYWQgdGVzdCBmYWlsZWQg
b24geW91ciBib3guCj4KPiA+IEFuZCwgaWYgdGhlIGhlYWRlciBmaWxlIGRvZXMgbm90IGV4aXN0
LCB0aGUgbWFjcm8gY29uZGl0aW9uIHdpbGwgY2hvb3NlCj4gdG8KPiA+IHVzZSAncnVsZV9zaXpl
IC0gMScsCj4gPiBhbmQgdGhhdCBjYXVzZWQgdGhlIEVOT01TRyBlcnJvciBkdXJpbmcgdGVzdCBv
biB0aGUgbmV3ZXIga2VybmVsLgo+Cj4gPiAjaWZkZWYgSEFWRV9TVFJVQ1RfTEFORExPQ0tfUlVM
RVNFVF9BVFRSX0hBTkRMRURfQUNDRVNTX05FVAo+ID4gICAgIHJ1bGVfc21hbGxfc2l6ZSA9IHJ1
bGVfc2l6ZSAtIHNpemVvZih1aW50NjRfdCkgLSAxOwo+ID4gI2Vsc2UKPiA+ICAgICBydWxlX3Nt
YWxsX3NpemUgPSBydWxlX3NpemUgLSAxOwo+ID4gI2VuZGlmCj4KPiA+IFNvIHRvIGtlZXAgdGhl
IGtlcm5lbC1oZWFkZXJzIGFuZCBydW5uaW5nIGtlcm5lbCB2ZXJzaW9uIGNvbnNpc3RlbnQKPiBz
aG91bGQKPiA+IGJlIHJlcXVpcmVkCj4gPiBmb3IgdGhlIGxhbmRsb2NrMDEgdGVzdC4gT3RoZXJ3
aXNlIHRoZSAjaWZkZWYgcG9zc2libHkgd29uJ3Qgd29yawo+IGNvcnJlY3RseS4KPgo+IEZZSSBI
YXZpbmcgaW5jb25zaXN0ZW50IGtlcm5lbCBoZWFkZXJzIGFuZCBydW5uaW5nIGtlcm5lbCB3b3Vs
ZCBiZSBhCj4gcHJvYmxlbSBmb3IKPiBtb3JlIExUUCB0ZXN0cyB0aGFuIGp1c3QgbGFuZGxvY2sw
MSAoYmFzaWNhbGx5IG1hbnkgdGVzdHMgd2hpY2ggaGF2ZQo+IGF1dG90b29scwo+IGNoZWNrKS4g
QnV0IHRoaXMgY2FuIGJlIHByb2JsZW1hdGljIGZvciBzb21lIGRldmVsb3BtZW50IChlLmcuIGxp
bnV4LW5leHQpLgo+IFRoZXJlZm9yZSB3ZSBhdCBsZWFzdCBhc3N1bWUgVUFQSSBoZWFkZXJzIHNo
b3VsZG4ndCBiZSBuZXdlciB0aGFuIHJ1bm5pbmcKPiBrZXJuZWwsIHNlZSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sdHAvWkpQX3FQZUozN0g0cWhFTkB5dWtpLy4KPgoKWWVzLCBJIGFncmVlIG9u
IHRoaXMuCgpBcyBsYW5kbG9jazAxIHVzZXMgdGhlIG1hY3JvIEkgcG9pbnRlZCBvdXQgaW4gdGhl
IGxhc3QgZW1haWwsCml0IGlzIGFsbW9zdCB1bmFibGUgdG8gc2V0IGEgY29ycmVjdCBydWxlX3Nt
YWxsX3NpemUgdy9vCnZhcmlhbnRzIG9mIGtlcm5lbC1oZWFkZXJzLgoKU28gSSBzdGlsbCB0aGlu
ayBqdXN0IHNpbXBseSBzZXQgdGhlICdydWxlX3NtYWxsX3NpemUnIHRvICdzaXplb2YoX191NjQp
IC0KMTsnCndpbGwgbWFrZSBsaWZlIGVhc2llciBidXQgQW5kcmVhIGhhcyBhIGRpZmZlcmVudCBw
ZXJzcGVjdGl2ZSBvbiB0aGF0LgoKQW55d2F5LCBJIHdvdWxkIGxlYXZlIHRoaXMgdG8gQW5kcmVh
IChhbiBleGNlbGxlbnQgYmxhY2stYm94IHRlc3RlcikKZm9yIG1vcmUgc3RydWdnbGluZy4gbG9s
fgoKCgo+ID4gSSBndWVzcyB3ZSBtaWdodCBoYXZlIHRvIHJlc29sdmUgdGhpcyBvbiB0aGUgdGVz
dCBzaWRlLgo+Cj4gVHJ5aW5nIHRvIGNvbXBhcmUgdmVyc2lvbnMgPGxpbnV4L3ZlcnNpb24uaD4g
Y291bGQgYmUgdXNlZDoKPgo+ICNkZWZpbmUgTElOVVhfVkVSU0lPTl9DT0RFIDM5NTAwOAo+ICNk
ZWZpbmUgS0VSTkVMX1ZFUlNJT04oYSxiLGMpICgoKGEpIDw8IDE2KSArICgoYikgPDwgOCkgKyAo
KGMpID4gMjU1ID8gMjU1Cj4gOiAoYykpKQo+ICNkZWZpbmUgTElOVVhfVkVSU0lPTl9NQUpPUiA2
Cj4gI2RlZmluZSBMSU5VWF9WRVJTSU9OX1BBVENITEVWRUwgNwo+ICNkZWZpbmUgTElOVVhfVkVS
U0lPTl9TVUJMRVZFTCAwCj4KPiBXZSBhbHJlYWR5IHVzZSBLRVJORUxfVkVSU0lPTigpIGluIGtk
dW1wIGFuZCBkZXZpY2UtZHJpdmVycyB0ZXN0cy4KPgoKSXQgY291bGQgd29yayBieSBhZGRpbmcg
bW9yZSBrZXJuZWwganVkZ21lbnQgZm9yIHRoZSBtYWNybyBkZWZpbml0aW9uLApidXQgYSBsaXR0
bGUgYml0IG9mIGEgbWVzcyBJTUhPLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
