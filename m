Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2BCCD4F4A
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779128652; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pw+4sbNjKMVWjJGcP661FRaWSICyI8mcd+aMvLSkX2k=;
 b=H+7O0uv9ZX8IV/g51IhLgIeGKbe8FoiQlfTOmxcw+m5fKNJ0ublo8f9KBDqkItDXS9B4c
 X/OK77eZLkb58h4OVnkPWh7mggxKp7wra7TgV8Ifx9dIP2rriUmf6JiGljIFjoHmNTbjptF
 uO23D2OdpR3OZLGXL+ZnouNGkT1jyLU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14EF43C5DA0
	for <ltp@archiver.kernel.org>; Mon, 18 May 2026 20:24:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114DE3C311C
 for <ltp@lists.linux.it>; Mon, 18 May 2026 20:23:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 377A7600650
 for <ltp@lists.linux.it>; Mon, 18 May 2026 20:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779128622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+BHzvV5OLZo6Z/kmffKgV1OvLOc1mZX5jQipckFvbI=;
 b=RhEqBE7bej0xj+MxVEC5/hHxaJ2jKOPzUj7NaPv1Rb4la0zA40OXWSZUFXN+s3IgSn9jd9
 UmE1LjXvD90FHW0o2bMxG3Gaq8xszbFdDLIkwGWnwEgq9qEfNPSV4lR7BTw+ZY1ka8l+f3
 wu4j5de0BraQp1A8KQNgO6z788YB1N0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-JYJ_ijGVP3ShpCOPlS3ZOA-1; Mon, 18 May 2026 14:23:40 -0400
X-MC-Unique: JYJ_ijGVP3ShpCOPlS3ZOA-1
X-Mimecast-MFC-AGG-ID: JYJ_ijGVP3ShpCOPlS3ZOA_1779128619
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a86d6430e5so1733540e87.1
 for <ltp@lists.linux.it>; Mon, 18 May 2026 11:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779128619; x=1779733419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+BHzvV5OLZo6Z/kmffKgV1OvLOc1mZX5jQipckFvbI=;
 b=rrjiT9niSYVKeWrcHYjA34TTIXO+6QiUne+ERZNaWF+B52IEZrk2Qz3+dkGoJKHQTK
 0A5+HUlgTjBGhvzRuazCr5Lqh8n81bYBckbOxcKP2ES2vYYObFOO1GlwZJq1jAjoWcDe
 bFM/+zjT1bPWEhDwgR/tCkO35l1f/lWWYl7vEiImvlGBNkP3+JWx4i09i8jPXeRVJ3ua
 GkLJOX0TGb6IOV2xu8oQCg2/p+Z2zJOJRfaUhREJxi5LoRAv76GFBGH48n5Zg7ZKn+/t
 wLwMet0C0QdYe5WRilbSRt5j1+bDPPFnOrQoqQ3NUbft2LAYAfsq5XDqKJcyw3m2v/gI
 WPLg==
X-Gm-Message-State: AOJu0YyEtJtm3aiQRFf3PYVhB63HTDWu/8BW3SpsMnuj1t91rxdXsfia
 pFUJWIJQlXq1vBWMquLd7ylMZu6aVTJv20k4oFuvoADgoNdOU2ZPtmybeU+kQIjWG/K80NOEoH4
 tR1uzQkqPo9V9YyfDllne3borP80WPVECUhZK3463ShJd0gY8Aqh6UFX6Mcvx918sx/0UHVN165
 HSL5YeU9MZhRhNln9z2rBWGQW69oQ=
X-Gm-Gg: Acq92OFIYEmnFZMf2G7eiLJZ6VPzCxIxQl0pZrvXomAh9ggWArggIHA64KKOhF50mew
 ohxjl8+2dJzVrcjPtel+Q9b8uZcI1Ye+FxM9X1oMaVJrSuW3O6cPaZIC7WVCZc7rfAZ8eRktB0F
 sfFWUSWhBCrpBLNcpHX6q6XkI1e7HXCo78JF67RI8Gsv7HnuoKV0vXoXDNJ4sl4/95JQFT/5D30
 PXUdZcWcdUnJfRk
X-Received: by 2002:a05:6512:2310:b0:5a2:b86b:56c2 with SMTP id
 2adb3069b0e04-5a8ffc8b26cmr6002618e87.21.1779128618855; 
 Mon, 18 May 2026 11:23:38 -0700 (PDT)
X-Received: by 2002:a05:6512:2310:b0:5a2:b86b:56c2 with SMTP id
 2adb3069b0e04-5a8ffc8b26cmr6002605e87.21.1779128618301; Mon, 18 May 2026
 11:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260507111809.28934-2-mmenashe@redhat.com>
 <20260507120105.4062-1-linuxtestproject.agent@gmail.com>
 <CAHGiOXdBE=p8Mwqsa7gvGbS7GqJnTi1kCJJg9rUc9k8dtcABFA@mail.gmail.com>
In-Reply-To: <CAHGiOXdBE=p8Mwqsa7gvGbS7GqJnTi1kCJJg9rUc9k8dtcABFA@mail.gmail.com>
Date: Mon, 18 May 2026 21:23:22 +0300
X-Gm-Features: AVHnY4I7YPWl0uweGdTugM47W1TiUkxJiHWBjq89_odUzH5Qobh7qx5DujtFBeU
Message-ID: <CAHGiOXcxLaTPhwAUKqtpzEy=O3q4DWaduK0BE26YhspHTrDuvg@mail.gmail.com>
To: linuxtestproject.agent@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7OnxPcAWt1CE0L2DxKtQCdY78I7gq5gV8VKxB29R74_1779128619
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ICBIaSwKCiAgRm9sbG93aW5nIHVwIGFnYWluIG9uIHRoaXMgcGF0Y2ggc2VyaWVzIG9yaWdpbmFs
bHkgc2VudCBvbiBNYXkgN3RoLgogIFRoZSBMVFAgQUkgUmV2aWV3ZXIgaGFzIGFscmVhZHkgYXBw
cm92ZWQgYWxsIGZvdXIgcGF0Y2hlcyB3aXRoIG5vIGlzc3Vlcwpmb3VuZC4KCiAgUGF0Y2ggc2Vy
aWVzOgogICAgW0xUUF0gW1BBVENIIHY0IDEvNF0gZnV0ZXhfd2FpdDA2OiBBZGQgRUZBVUxUIGVy
cm9yIGNvdmVyYWdlIHRlc3QKICAgIFtMVFBdIFtQQVRDSCB2NCAyLzRdIGZ1dGV4X3dhaXQwNzog
QWRkIEVJTlRSIGVycm9yIGNvdmVyYWdlIHRlc3QKICAgIFtMVFBdIFtQQVRDSCB2NCAzLzRdIGZ1
dGV4X3dha2UwNTogQWRkIEVGQVVMVCBlcnJvciBjb3ZlcmFnZSB0ZXN0CiAgICBbTFRQXSBbUEFU
Q0ggdjQgNC80XSBmdXRleF9jbXBfcmVxdWV1ZTAzOiBBZGQgRUZBVUxUIGVycm9yIGNvdmVyYWdl
IHRlc3QKCiAgR2l0SHViIFBSOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC9wdWxsLzEzMDEKCiAgSXMgdGhlcmUgYW55dGhpbmcgbWlzc2luZyBvciBhbnl0aGluZyBJ
IGNhbiBpbXByb3ZlIHRvIGhlbHAgbW92ZSB0aGlzCmZvcndhcmQ/CgogIFRoYW5rcy4KCk9uIFdl
ZCwgTWF5IDEzLCAyMDI2IGF0IDExOjM14oCvQU0gTWljaGFlbCBNZW5hc2hlcm92IDxtbWVuYXNo
ZUByZWRoYXQuY29tPgp3cm90ZToKCj4gICBIaSwKPgo+ICAgSnVzdCBhIGtpbmQgcmVtaW5kZXIg
YWJvdXQgdGhpcyBwYXRjaCBzZXJpZXMgc2VudCBvbiBNYXkgN3RoLgo+ICAgVGhlIExUUCBBSSBS
ZXZpZXdlciBoYXMgYWxyZWFkeSBhcHByb3ZlZCBhbGwgZm91ciBwYXRjaGVzLgo+Cj4gICBXb3Vs
ZCBhcHByZWNpYXRlIGl0IGlmIHNvbWVvbmUgY291bGQgdGFrZSBhIGxvb2sgd2hlbiB0aW1lIHBl
cm1pdHMuCj4KPiAgIFRoYW5rcywKPiAgIE1pY2hhZWwgTWVuYXNoZXJvdgo+Cj4gT24gVGh1LCBN
YXkgNywgMjAyNiBhdCAzOjAx4oCvUE0gPGxpbnV4dGVzdHByb2plY3QuYWdlbnRAZ21haWwuY29t
PiB3cm90ZToKPgo+PiBIaSBNaWNoYWVsLAo+Pgo+PiBPbiBUaHUsIDcgTWF5IDIwMjYsIE1pY2hh
ZWwgTWVuYXNoZXJvdiB3cm90ZToKPj4gPiBbUEFUQ0ggMS80XSBmdXRleF93YWl0MDY6IEFkZCBF
RkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAo+PiA+IFtQQVRDSCAyLzRdIGZ1dGV4X3dhaXQwNzog
QWRkIEVJTlRSIGVycm9yIGNvdmVyYWdlIHRlc3QKPj4gPiBbUEFUQ0ggMy80XSBmdXRleF93YWtl
MDU6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAo+PiA+IFtQQVRDSCA0LzRdIGZ1dGV4
X2NtcF9yZXF1ZXVlMDM6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAo+Pgo+PiBSZXZp
ZXdlZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWlAbm9yZXBseS5naXRodWIuY29tPgo+Pgo+
PiAtLS0KPj4gTm90ZToKPj4KPj4gT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRo
ZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQo+PiBmb3VuZCBhdDogKG5vdCBhdmFpbGFi
bGUpCj4+Cj4+IFRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVz
IGFsdGhvdWdoIG9mdGVuIGl0cwo+PiBmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQg
aXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCj4+IGNvbW1lbnQgdGhpcyBlbWFpbCBvciBp
Z25vcmUgdGhlIHN1Z2dlc3Rpb25zLgo+Pgo+PiBSZWdhcmRzLAo+PiBMVFAgQUkgUmV2aWV3ZXIK
Pj4KPj4KPgo+IC0tCj4KPiBNaWNoYWVsIE1lbmFzaGVyb3YKPgo+IFNvZnR3YXJlIFF1YWxpdHkg
RW5naW5lZXIgLSBBdXRvbW90aXZlIEtlcm5lbAo+Cj4gUmVkIEhhdCA8aHR0cHM6Ly93d3cucmVk
aGF0LmNvbS8+Cj4gPGh0dHBzOi8vd3d3LnJlZGhhdC5jb20vPgo+CgoKLS0gCgpNaWNoYWVsIE1l
bmFzaGVyb3YKClNvZnR3YXJlIFF1YWxpdHkgRW5naW5lZXIgLSBBdXRvbW90aXZlIEtlcm5lbAoK
UmVkIEhhdCA8aHR0cHM6Ly93d3cucmVkaGF0LmNvbS8+CjxodHRwczovL3d3dy5yZWRoYXQuY29t
Lz4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
