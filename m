Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3E0C4345F
	for <ltp@archiver.kernel.org>; Sat, 20 Apr 2024 01:57:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9924A3CFDAD
	for <ltp@archiver.kernel.org>; Sat, 20 Apr 2024 03:57:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28E853CFBB5
 for <ltp@lists.linux.it>; Sat, 20 Apr 2024 03:57:41 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFC7F10004BD
 for <ltp@lists.linux.it>; Sat, 20 Apr 2024 03:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713578259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUt3C62SqTLCX2I6sByXlEj+ASSg5B6rIy37ukaOuQc=;
 b=ERr+j9QchVw0fW9X6WgFoaALGdVt40QvpSYrplNfrxB1ljwXjBFWGAirRd4e7RfMdsY/Of
 2w/Xf35pNTM1etoqCRKxNJ2PTYgH5dNIw01Z5UT35rPtTTKLyAt8uoCphijOMZTFab7mT6
 9hnUbEwKHO9ZYYSNJTfSVmfOoOQyoGQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-mYUFho2CM_e4mTfsQCUZ3A-1; Fri, 19 Apr 2024 21:57:37 -0400
X-MC-Unique: mYUFho2CM_e4mTfsQCUZ3A-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5aa2faa7115so4635127eaf.2
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 18:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713578257; x=1714183057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUt3C62SqTLCX2I6sByXlEj+ASSg5B6rIy37ukaOuQc=;
 b=umDAkBovqyFDsBeKGYGvHDv72OH/pPTCpwG+0FTxwLiHuoH2aas0hLx1uNw25oA8Uv
 C+tV7YeaI49pYDtnZIdp9C75I/gNLU99a8suIXSyDuIv2YrBhcdQf2qsinSkbqsBMB5A
 8AhKyQhyc8tjQSQLVr+4HaseecxUlVdO+erJuGIg9u2OK1iiQd2uMfwQSYBDMC9px8y9
 ageZGX5rBORL/Lgx54CqR0XLNy47klmT9s/a2RJT4RkSn2IHEoJ9Fkqjprve+Z9DY6pT
 jnnk4mcsvrVEyhW/UE5Aglj5+6GZwnMrrFcyVt6Prt1iRNA8nFKVOyuoS4ELltiX/Moo
 RBNg==
X-Gm-Message-State: AOJu0Yw+o4VdVCCTaQwBcMclzbE/abf1bspu806Bp7o8RunEefzt2/D5
 FT8myZJBV8fWd/Yr9FPtLo6gkSXIwkN8/M6tykTX5AQTAf2tf9nLi30wAqiSyKxv/QbFs7uNovw
 kwvfaL/ODhiNoQnCD6ybvAPsJIG09zesEySAYYTcGgaj5SAGGRzn+we+3UGYsZV0Gg63FaV2GKP
 C+1Nv2h6zG5wxk1F95kE933qw=
X-Received: by 2002:a05:6358:d09b:b0:17f:58cb:2ce8 with SMTP id
 jc27-20020a056358d09b00b0017f58cb2ce8mr4220482rwb.17.1713578256887; 
 Fri, 19 Apr 2024 18:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8/b2KCk8AmY8Kx/C6YUijh7OY26Z61EqeXkPZIne3QvqhSd/obf1pHHxvHxXdqnhDnPutVVjRsvjmrwnCXhE=
X-Received: by 2002:a05:6358:d09b:b0:17f:58cb:2ce8 with SMTP id
 jc27-20020a056358d09b00b0017f58cb2ce8mr4220470rwb.17.1713578256472; Fri, 19
 Apr 2024 18:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240419124221.207445-1-pvorel@suse.cz>
In-Reply-To: <20240419124221.207445-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Apr 2024 09:57:24 +0800
Message-ID: <CAEemH2ezChbMHZHMsxed9ioWSQOuSF7pLkkNsodryoTsgW1zww@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] doc: Bump minimal supported kernel to 4.4
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgMTksIDIwMjQgYXQgODo0MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gYW5kIHJlbW92ZSBSSEVMLTcuOSBNYWlwbyBmcm9tIHRoZSBsaXN0Lgo+
Cj4ga2VybmVsIDMuMTAgd2FzIHN1cHBvcnRlZCBieSBDZW50T1MgNyBidWlsZCwgd2hpY2ggd2Fz
IHJlbW92ZWQgaW4KPiAzNjA5MjcwODAuIEFGQUlLIGFsbCBkaXN0cm9zIHdoaWNoIHVzZSAzLjEw
IGtlcm5lbCAob3Iga2VybmVsIDwgNC40KQo+IGJ5IFNVU0UvUkhFTC93aGF0ZXZlciBkaXN0cm8g
YXJlIHVzaW5nIG9sZGVyIExUUCAoaW5jbHVkaW5nIFJIRUwtNy45Cj4gTWFpcG9pKS4gVGh1cyB3
ZSBzaG91bGQgbm90IGNsYWltIHdlIGFyZSBidWlsZCB0ZXN0aW5nIDMuMTAuCj4KPiA0LjQgaXMg
a2VwdCBiZWNhdXNlIGlzIHN0aWxsIHVzZWQgZm9yIG9sZCBTTEVTIDEyLVNQMyAoNC40IGJhc2Vk
KS4KPgo+IFRoaXMgdXBkYXRlIGlzIHNhZmUgZm9yIHVwc3RyZWFtIHN0YWJsZSByZWxlYXNlcyAo
dGhlIG9sZGVzdCBzdGFibGUKPiBrZXJuZWwgaXMgNC4xOSkuCj4KPiBVcGRhdGUgYWxzbyBvbGQg
ZG9jcyB0byBwcmV2ZW50IHVzZXJzIC8gc2VhcmNoIGVuZ2luZXMgZ290IGNvbmZ1c2VkLgo+Cj4g
Rml4ZXM6IDM2MDkyNzA4MCAoImRvYy9zdXBwb3J0OiBVcGRhdGUgdGhlIG9sZGVzdCB0ZXN0ZWQg
ZGlzdHJvcyIpCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4K
ClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+IEhpIGFsbCwK
Pgo+IE5PVEU6IGlmIHdlIGFjayB0aGlzLCB3ZSBjb3VsZCByZW1vdmUgdmFyaW91cyBjaGVja3Mg
Zm9yIDMueCBrZXJuZWxzOgo+CgorMQoKCj4gJCBnaXQgZ3JlcCAna3ZlcmNtcCgzJwo+IHRlc3Rj
YXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwX3hhdHRyL2Nncm91cF94YXR0ci5jOgo+ICAg
ICAgdGtleXNbaV0uZ29vZCA9IHRzdF9rdmVyY21wKDMsIDE1LCAwKSA8IDA7Cj4gdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBfeGF0dHIvY2dyb3VwX3hhdHRyLmM6ICAgICAgICAg
ICAgICAgaWYKPiAoaGllciAhPSAwICYmIHRzdF9rdmVyY21wKDMsIDE1LCAwKSA8IDApCj4gdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDQuYzogICAgICBpZiAo
dHN0X2t2ZXJjbXAoMywKPiAxNSwgMCkgPCAwKSB7Cj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9yZWN2L3JlY3YwMS5jOiAgICAgICAgICAgICAgICAgICAgICAgIGlmCj4gKCh0c3Rfa3ZlcmNt
cCgzLCAxNywgMCkgPCAwKQo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVjdmZyb20vcmVj
dmZyb20wMS5jOiAgICAgICAgICAgICAgICAgICAgICAgIGlmCj4gKCh0c3Rfa3ZlcmNtcCgzLCAx
NywgMCkgPCAwKQo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVjdm1zZy9yZWN2bXNnMDEu
YzogIGlmICgodHN0X2t2ZXJjbXAoMywgMTcsIDApCj4gPCAwKQo+IHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcmVuYW1lYXQyL3JlbmFtZWF0MjAxLmM6ICAgICAgaWYKPiAoKHRzdF9rdmVyY21w
KDMsIDE1LCAwKSkgPCAwKSB7Cj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZW5hbWVhdDIv
cmVuYW1lYXQyMDIuYzogICAgICBpZgo+ICgodHN0X2t2ZXJjbXAoMywgMTUsIDApKSA8IDApIHsK
PiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NjaGVkX2dldGF0dHIvc2NoZWRfZ2V0YXR0cjAx
LmM6ICAgICAgaWYKPiAoKHRzdF9rdmVyY21wKDMsIDE0LCAwKSkgPCAwKQo+IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc2NoZWRfZ2V0YXR0ci9zY2hlZF9nZXRhdHRyMDIuYzogICAgICBpZgo+
ICgodHN0X2t2ZXJjbXAoMywgMTQsIDApKSA8IDApCj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zY2hlZF9zZXRhdHRyL3NjaGVkX3NldGF0dHIwMS5jOiAgICAgIGlmCj4gKCh0c3Rfa3ZlcmNt
cCgzLCAxNCwgMCkpIDwgMCkKPiB0ZXN0Y2FzZXMvbmV0d29yay9uZXRzdHJlc3MvbmV0c3RyZXNz
LmM6ICAgICAgICBpZiAoYnVzeV9wb2xsID49IDAgJiYKPiB0c3Rfa3ZlcmNtcCgzLCAxMSwgMCkg
PCAwKQo+Cj4gJCBnaXQgZ3JlcCBUU1RfTUlOX0tWRVI9LjMKPgo+IHRlc3RjYXNlcy9rZXJuZWwv
Y29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9yZWdyZXNzaW9uX3Rlc3Quc2g6VFNUX01JTl9LVkVS
PSIzLjE4Igo+IHRlc3RjYXNlcy9uZXR3b3JrL2J1c3lfcG9sbC9idXN5X3BvbGxfbGliLnNoOlRT
VF9NSU5fS1ZFUj0iMy4xMSIKPiB0ZXN0Y2FzZXMvbmV0d29yay90Y3BfY2MvZGN0Y3AwMS5zaDpU
U1RfTUlOX0tWRVI9IjMuMTgiCj4gdGVzdGNhc2VzL25ldHdvcmsvdGNwX2Zhc3RvcGVuL3RjcF9m
YXN0b3Blbl9ydW4uc2g6VFNUX01JTl9LVkVSPSIzLjciCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0
cgo+Cj4gIC4uLi9TdXBwb3J0ZWQta2VybmVsLC1saWJjLC10b29sY2hhaW4tdmVyc2lvbnMuYXNj
aWlkb2MgICB8IDIgKy0KPiAgZG9jL3VzZXJzL3N1cHBvcnRlZF9zeXN0ZW1zLnJzdCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgOCArLS0tLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kb2Mvb2xkL1N1cHBv
cnRlZC1rZXJuZWwsLWxpYmMsLXRvb2xjaGFpbi12ZXJzaW9ucy5hc2NpaWRvYwo+IGIvZG9jL29s
ZC9TdXBwb3J0ZWQta2VybmVsLC1saWJjLC10b29sY2hhaW4tdmVyc2lvbnMuYXNjaWlkb2MKPiBp
bmRleCA1MTFiOWUxNGIuLjI1MmI3YTRiZSAxMDA2NDQKPiAtLS0gYS9kb2Mvb2xkL1N1cHBvcnRl
ZC1rZXJuZWwsLWxpYmMsLXRvb2xjaGFpbi12ZXJzaW9ucy5hc2NpaWRvYwo+ICsrKyBiL2RvYy9v
bGQvU3VwcG9ydGVkLWtlcm5lbCwtbGliYywtdG9vbGNoYWluLXZlcnNpb25zLmFzY2lpZG9jCj4g
QEAgLTU0LDcgKzU0LDcgQEAgZGlzdHJpYnV0aW9uIHlvdSBtYXkgYXMgd2VsbCByZWNvbnNpZGVy
IHlvdSBsaWZlIGNob2ljZXMuCj4gIDEuMyBNaW5pbWFsIHN1cHBvcnRlZCBrZXJuZWwgdmVyc2lv
bgo+ICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+IC1NaW5pbWFsIHN1
cHBvcnRlZCBrZXJuZWwgdmVyc2lvbiBpcyAzLjEwLgo+ICtNaW5pbWFsIHN1cHBvcnRlZCBrZXJu
ZWwgdmVyc2lvbiBpcyA0LjQuCj4KPiAgMS40IFN1cHBvcnRlZCBsaWJjCj4gIH5+fn5+fn5+fn5+
fn5+fn5+fgo+IGRpZmYgLS1naXQgYS9kb2MvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMucnN0Cj4g
Yi9kb2MvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMucnN0Cj4gaW5kZXggNjIyMGE5NmUwLi44Mjc3
NGMyZWYgMTAwNjQ0Cj4gLS0tIGEvZG9jL3VzZXJzL3N1cHBvcnRlZF9zeXN0ZW1zLnJzdAo+ICsr
KyBiL2RvYy91c2Vycy9zdXBwb3J0ZWRfc3lzdGVtcy5yc3QKPiBAQCAtNiw3ICs2LDcgQEAgU3Vw
cG9ydGVkIHN5c3RlbXMKPiAgS2VybmVsIHZlcnNpb24KPiAgLS0tLS0tLS0tLS0tLS0KPgo+IC1N
aW5pbWFsIHN1cHBvcnRlZCBrZXJuZWwgdmVyc2lvbiBpcyAqKjMuMTAqKi4KPiArTWluaW1hbCBz
dXBwb3J0ZWQga2VybmVsIHZlcnNpb24gaXMgKio0LjQqKi4KPgo+ICBPbGRlc3QgdGVzdGVkIGRp
c3RyaWJ1dGlvbnMKPiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gQEAgLTM4LDEyICsz
OCw2IEBAIE9sZGVzdCB0ZXN0ZWQgZGlzdHJpYnV0aW9ucwo+ICAgICAgICAtIDEwLjIuMQo+ICAg
ICAgICAtIDExLjAuMQo+Cj4gLSAgICAqIC0gUkhFTC03LjkgTWFpcG8KPiAtICAgICAgLSAzLjEw
Cj4gLSAgICAgIC0gNC44LjUKPiAtICAgICAgLSAyLjE3Cj4gLSAgICAgIC0gXC0KPiAtCj4gIE9s
ZGVyIGRpc3RyaWJ1dGlvbnMgYXJlIG5vdCBvZmZpY2lhbGx5IHN1cHBvcnRlZCwgd2hpY2ggbWVh
bnMgdGhhdCBpdAo+ICBtYXkgb3IgbWF5IG5vdCB3b3JrLiBJdCBhbGwgZGVwZW5kcyBvbiB5b3Vy
IGx1Y2suIEl0IHNob3VsZCBiZSBwb3NzaWJsZQo+ICB0byBjb21waWxlIGxhdGVzdCBMVFAgZXZl
biBvbiBzbGlnaHRseSBvbGRlciBkaXN0cmlidXRpb25zIHRoYW4gd2UKPiAtLQo+IDIuNDMuMAo+
Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
