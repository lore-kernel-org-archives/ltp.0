Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290D8EB64DD
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 03:19:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0513E3CBEF6
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 05:19:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEA0A3CB6EA
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 05:19:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 541E2600F31
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 05:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691637542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DHWc1sa+BWeQsYTBRapll7GueFav2tG0o/0a6VVO4Y=;
 b=WIC5nXgBBdvAF5ipP+tvIVEn03Cm7R4twihtuLJiUczqvKTsNUP3xoofX2ZV4RkMb36SbL
 YZTzN481x91j1lZo+df36MCmvc8RTAX/VC9bcbkX/322q91hgy1XiOXdWwAzPc1FXu9sTj
 WWzM5DRmJ/OnPwI5AXNR1YbXnacVl8w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-fXAL3bNoPTakRTbcFslA5g-1; Wed, 09 Aug 2023 23:18:59 -0400
X-MC-Unique: fXAL3bNoPTakRTbcFslA5g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9cd6a555aso4412881fa.3
 for <ltp@lists.linux.it>; Wed, 09 Aug 2023 20:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691637536; x=1692242336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5DHWc1sa+BWeQsYTBRapll7GueFav2tG0o/0a6VVO4Y=;
 b=Es3c0eNpckkIsiQvsZlZfU9eMAPSBLR2SwmG/sLCyBM7Zrymj9taXC1kxOrahBFMag
 FP+BJrfZPU3Ysw1ZDY8FiOm7xM+wTsoS0WQFPivJjbuusukZpJ2Edj98r7hlkp6Y05qa
 kyg7Jztb6/sTqZSf3OgO5yIvra7sQ7FuJycCPYrxqZ0ffUIwP9RX/jgaV4dXebNK1G5Y
 QDmxQX1hXq9OPLRrlOnAku1VB8//ymtgMuvi8I2TdIKSB6wJFtlf1cxjSv99BCscOb5G
 T3m6gU+VTR3eCIHDFbX/rSA6X4hcnwXj6BkcMic4qRnntVoF2A0mxdto9HPQ/YiDXTPJ
 c52A==
X-Gm-Message-State: AOJu0YxQ3OygLc22p471vHlmH1rIpJQLHrDR0H35++gzx85WgokX3iBI
 osiB3LZTW/Mo6w7bZjACCtLpY+DsuwNtjBE5t9g73YeTag0+dpKFnUGvaIXuUEvvRcaSH7/9bB2
 sG97pcw/1yEgoRTxVFqSP2K3R+6berr4fAI7cip0U
X-Received: by 2002:a2e:7013:0:b0:2b9:ef0a:7d4b with SMTP id
 l19-20020a2e7013000000b002b9ef0a7d4bmr843985ljc.31.1691637536157; 
 Wed, 09 Aug 2023 20:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0oXHOx4kG17SxqwMNauQZv9tzD9SbfW1o8riumJq72wJGNTCHZOBxutLthcBfuXp9zDQr5hI+18q2nEnklaE=
X-Received: by 2002:a2e:7013:0:b0:2b9:ef0a:7d4b with SMTP id
 l19-20020a2e7013000000b002b9ef0a7d4bmr843975ljc.31.1691637535787; Wed, 09 Aug
 2023 20:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230808124445.980419-1-liwang@redhat.com>
 <x49edkd4qia.fsf@segfault.boston.devel.redhat.com>
 <CAEemH2dEQYSr2dF2XY4Njv37g6dyqxkFOmaY_bZZSKG1MeKsgg@mail.gmail.com>
 <x491qgc492y.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x491qgc492y.fsf@segfault.boston.devel.redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Aug 2023 11:18:44 +0800
Message-ID: <CAEemH2cbV-oW22-WpZWnh6-ke2dtTQmO5KEOdGw+i2ftARm+yQ@mail.gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] io_uring: enable I/O Uring before testing
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

T24gV2VkLCBBdWcgOSwgMjAyMyBhdCA5OjQ24oCvUE0gSmVmZiBNb3llciA8am1veWVyQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgo+Cj4g
PiBIaSBKZWZmLAo+ID4KPiA+IFRoYW5rcyBmb3IgY29tbWVudHMuCj4gPgo+ID4gT24gVHVlLCBB
dWcgOCwgMjAyMyBhdCA5OjE34oCvUE0gSmVmZiBNb3llciA8am1veWVyQHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4KPiA+PiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgo+ID4+Cj4g
Pj4gPiBHaXZlbiB0aGF0IHRoZSB1cHN0cmVhbSBrZXJuZWwgaXMgZ29pbmcgdG8gaW50cm9kdWNl
IGlvX3VyaW5nX2Rpc2FibGVkCj4gPj4gPiBrbm9iIHdoaWNoIGRpc2FibGVzIHRoZSBjcmVhdGlv
biBvZiBuZXcgaW9fdXJpbmcgaW5zdGFuY2VzCj4gc3lzdGVtLXdpZGUuCj4gPj4gPgo+ID4+ID4g
VGhlIG5ldyBzeXNjdGwgaXMgZGVzaWduZWQgdG8gbGV0IGEgdXNlciB3aXRoIHJvb3Qgb24gdGhl
IG1hY2hpbmUKPiA+PiA+IGVuYWJsZSBhbmQgZGlzYWJsZSBpb191cmluZyBzeXN0ZW0td2lkZSBh
dCBydW50aW1lIHdpdGhvdXQgcmVxdWlyaW5nCj4gPj4gPiBhIGtlcm5lbCByZWNvbXBpbGF0aW9u
IG9yIGEgcmVib290Lgo+ID4+ID4KPiA+PiA+IFNlZToKPiA+Pgo+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9pby11cmluZy9wYXRjaC8yMDIzMDYzMDE1MTAwMy4zNjIyNzg2
LTItbWF0dGVvcml6em9AZ29vZ2xlLmNvbS8KPiA+PiA+Cj4gPj4gPiBXaXRob3V0IHRoaXMgcGF0
Y2gsIExUUC9pb191cmluZyB0ZXN0IGNvbXBsYWluczoKPiA+PiA+Cj4gPj4gPiAgIGlvX3VyaW5n
MDEuYzo4MjogVEZBSUw6IGlvX3VyaW5nX3NldHVwKCkgZmFpbGVkOiBFUEVSTSAoMSkKPiA+PiA+
ICAgaW9fdXJpbmcwMi5jOjIxMzogVEJST0s6IGlvX3VyaW5nX3NldHVwKCkgZmFpbGVkOiBFUEVS
TSAoMSkKPiA+Pgo+ID4+IEp1c3QgdG8gYmUgY2xlYXIsIHdpdGggdGhlIGFib3ZlIGtlcm5lbCBw
YXRjaCBhcHBsaWVkIGlvX3VyaW5nIGlzCj4gPj4gZW5hYmxlZCBieSBkZWZhdWx0LiAgWW91IHNo
b3VsZG4ndCBuZWVkIHRvIHNldCB0aGUgc3lzY3RsIHBhcmFtZXRlcgo+ID4+IHVubGVzcyBpb191
cmluZyBpcyBleHBsaWNpdGx5IGRpc2FibGVkIGJ5IHRoZSBhZG1pbmlzdHJhdG9yICh0aGF0IGNh
biBiZQo+ID4+IGFjY29tcGxpc2hlZCB2aWEgdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUsIHN5c2Zz
LCBvciB2aWEgc3lzY3RsLmNvbmYpLgo+ID4+Cj4gPgo+ID4gWWVzLCBidXQgaXQgd29uJ3QgYmUg
aGFybWZ1bCB0byBzZXQgdGhlIHBhcmFtZXRlciBldmVuIGlmIGl0J3MgZW5hYmxlZCBieQo+ID4g
ZGVmYXVsdCwKPiA+IExUUCB1c2VzIHNhdmVfcmVzdG9yZSBmaWVsZCB0byBtYW5hZ2Ugc3lzZnMg
a25vYiB1bmlmaWVkLCBpdCBndWFyYW50ZWVzCj4gdGhlCj4gPiB0ZXN0cyBjYW4gcmVhbGx5IGdl
dCBwZXJmb3JtZWQgd2hhdGV2ZXIgaW9fdXJpbmcgaXMgZW5hYmxlZCBvciBkaXNhYmxlZC4KPiA+
Cj4gPiBJIHdvdWxkIGtlZXAgdGhlIHBhdGNoIGFzIGl0IGlzIHVubGVzcyB5b3UgaW5zaXN0IG9y
IG90aGVycyBoYXZlIGFuCj4gPiBvYmplY3Rpb24uCj4KPiBJIGFncmVlIHdpdGggdGhlIHBhdGNo
LiAgSSBqdXN0IHRoaW5rIHRoZSBkZXNjcmlwdGlvbiBzaG91bGQgYmUgdXBkYXRlZCwKPiBhcyBp
dCBpbXBsaWVzIHRoYXQsIHdpdGhvdXQgdGhlIHBhdGNoLCB0aGUgdGVzdCB3aWxsIGZhaWwuICBU
aGlzIGlzIG5vdAo+IHRoZSBjYXNlIGZvciBhbiB1cHN0cmVhbSBrZXJuZWwuCj4KCkFoLCBzb3Jy
eSBmb3IgdGhlIHVuY2xlYXIgZGVzY3JpcHRpb24sIEkgYWN0dWFsbHkgd2FzIG5vdCBtZWFuIHRo
YXQuCmFueXdheSwgSSByZXdyb3RlIGl0IGFuZCBwdXNoZWQuCgpUaGFua3MgZm9yIHlvdXIgcmV2
ZWl3LCBKZWZmLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
