Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129ACE7A8B
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 02:32:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EB303CDE61
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 04:32:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39D83C9A2B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 04:32:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97054100093A
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 04:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695609122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pU4O/dBgRVqrBFAjxjb9emE+CrD72n4Sg1jePbkQ1hQ=;
 b=FPx1WNHcKZ+girrf9hHRyT+t55e2g1WpBkr9DTNHouENNRRZNXRKmsy2CyG49Y5vJxwYg7
 S4qKXtCzZjrioOHKIuFK4SRK7Q1dfH7Qx76T2LL+XxHX8/y+RG1C1aFUc5iA09e3QLzHf1
 t24oA9rmj2smOpIiyPunOD+J/u+b9QY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-v5_crb90MsuW2DwsjjB9Ew-1; Sun, 24 Sep 2023 22:31:59 -0400
X-MC-Unique: v5_crb90MsuW2DwsjjB9Ew-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c001029f99so68984801fa.0
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 19:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609118; x=1696213918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pU4O/dBgRVqrBFAjxjb9emE+CrD72n4Sg1jePbkQ1hQ=;
 b=R/FGLOk8PLzifvyjTAsbl95FIu/Kb/4gAQ6kXNPA44WtRfle5SZsL32fB0r+KWlZgD
 Wwivw0bHSF/Bql1dJq0eiF5tdggJbCiOaw4GJsC2uCcXkvWA4f1s8HLeGp3gDcLWB+l3
 k7XUB2aIsXfZzVg7vx2d/tYFyGR8i3E2MtLhEKHJBfzmUQjcnTggn2AnDDUW6qggRbTM
 gRj/pkpiKqikC7pD+eIyyoUVvZZUlZ9d3uaSMwinx9H+gIid+/vSAfddhM+236y9s3at
 Dcrv2grBnThONH/GKwRSqjrYab6C2fLybv/FQTIhKxk7X1B0tk9s6cDMFEzWu1hxQu9x
 biBw==
X-Gm-Message-State: AOJu0YxGImvcU88FMMY7N87Kmh6RSesIxiFEgqO2tKNb6BUBjvntdgLh
 3t+5VT/NCsED+PLHF+O5DKhz+rp6kfWJetHLNEkcfYPAzZQax6H1tBcaGcGuqjUE9bVqUKvvnHc
 n72JgsJIenxLwqm9lOcSJ4oqrnOA=
X-Received: by 2002:a05:6512:250b:b0:503:a82:b371 with SMTP id
 be11-20020a056512250b00b005030a82b371mr4646251lfb.4.1695609118085; 
 Sun, 24 Sep 2023 19:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGON9YssDoRzZH6IZGlRdXTmJz5ZhQdo19yjR/hgiap+zNKDvsKge2ark6TVT79cXJdNlQIn6n18pHj9agbwj4=
X-Received: by 2002:a05:6512:250b:b0:503:a82:b371 with SMTP id
 be11-20020a056512250b00b005030a82b371mr4646237lfb.4.1695609117703; Sun, 24
 Sep 2023 19:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
 <CAEemH2ektE-0Fdu49_4xN5wtq9=jPehHXDVrAPSG3FZ763rTDw@mail.gmail.com>
 <20230924211413.GA688740@pevik>
In-Reply-To: <20230924211413.GA688740@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Sep 2023 10:31:46 +0800
Message-ID: <CAEemH2du9Or2y84qF8uHWAO8_+jLfvV+1b6iwBkBdd4abUiZ3A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgNToxNOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEhpIFBldHIsCj4KPiAuLi4KPiA+ID4gLTEuIFRh
ZyB0aGUgZ2l0Cj4gPiA+ICsxLiBSZWxlYXNlIGV2ZSB3b3JrCj4gPiA+ICstLS0tLS0tLS0tLS0t
LS0tLS0tCj4gPiA+ICsKPiA+ID4gK2EuIENvbGxlY3RpbmcgdGhlIChtdXN0IGhhdmUpIHBhdGNo
IGxpc3QgZm9yIG5ldyByZWxlYXNlCj4gPiA+ICtiLiBSZXZpZXdpbmcgYW5kIG1lcmdpbmcgdGhl
IHBhdGNoIGxpc3Qgb2YgKGEuKQo+ID4gPiArYy4gV2lkZWx5IHRlc3RpbmcsIGV4cGxpY2l0bHkg
cG9zdCByZXN1bHRzCj4gPiA+ICtkLiBUaW55IGZpeCBhY2NvcmRpbmcgdG8gcmVsZWFzZSB0ZXN0
aW5nCj4gPiA+ICtlLiBXcml0aW5nIHJlbGVhc2Ugbm90ZQo+ID4gPiArCj4gPiA+ICsyLiBUYWcg
dGhlIGdpdAo+ID4gPiAgLS0tLS0tLS0tLS0tLS0KPgo+ID4gPiArVXNlICcuL3Rvb2xzL3RhZy1y
ZWxlYXNlLnNoJyBzY3JpcHQsIHdoaWNoIGNyZWF0ZXMgdGhlIHRhZyBhbmQgcHVzaAo+IGl0IHRv
Cj4gPiA+IGdpdGh1Yi4KPiA+ID4gIFtzb3VyY2Usc2hdCj4gPiA+ICAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4g
PiAtY2QgbHRwCj4gPiA+IC1lY2hvIFlZWVlNTUREID4gVkVSU0lPTgo+ID4gPiAtZ2l0IGNvbW1p
dCAtcyAtbSAnTFRQIFlZWVlNTUREJyBWRVJTSU9OCj4gPiA+IC1naXQgdGFnIC1hIFlZWVlNTURE
IC1tICdMVFAgWVlZWU1NREQnCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj4gPiBXaGF0IGFib3V0IGFk
ZGluZyB0aG9zZSBtYW51YWwgc3RlcHMgaW50byB0YWctcmVsZWFzZS5zaCBhcyBjb2RlCj4gY29t
bWVudHM/Cj4gPiBUaGF0J2QgYmUgaGVscGZ1bCB0byBwZW9wbGUgd2hvIG5ldmVyIGRvIHJlbGVh
c2Ugd29yayB0byB0cnkgdGhhdCBmaXJzdAo+ID4gdGltZS4KPgo+IEdvb2QgcG9pbnQsIG1ha2Vz
IHNlbnNlLgo+IEkgc3VwcG9zZSB5b3UgbWVhbiB0byBicHV0IHRoZW0gYXQgdGhlIHRvcCBsaWtl
IHRoaXM6Cj4KCgpZZXMsIGV2ZW4gbG9va3MgdmVyYm9zZSwgYnV0IHdpbGwgYmUgaGVscGZ1bCB0
byBwZW9wbGUgd2hvIG5ldmVyIGRvIHJlbGVhc2UKd29yay4KCgoKPgo+ICMhL2Jpbi9zaAo+ICMg
Q29weXJpZ2h0IChjKSAyMDIzIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ICMgQ3JlYXRl
IHRhcmJhbGxzIGFuZCBtZXRhZGF0YSBmb3IgdXBsb2FkaW5nIGFmdGVyIHRhZ2dpbmcgcmVsZWFz
ZS4KPiAjIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvTFRQ
LVJlbGVhc2UtUHJvY2VkdXJlCj4gIyBlY2hvIFlZWVlNTUREID4gVkVSU0lPTgo+ICMgZ2l0IGNv
bW1pdCAtcyAtbSAnTFRQIFlZWVlNTUREJyBWRVJTSU9OCj4gIyBnaXQgdGFnIC1hIFlZWVlNTURE
IC1tICdMVFAgWVlZWU1NREQnCj4gc2V0IC1lCj4gLi4uCj4gQmVjYXVzZSB0aGVyZSBhcmUgY29t
bWVudHMgYXQgdGhlIHRvcCBvZiBlYWNoICJzZWN0aW9uIiAoZS5nLiAjIGdpdCBjbG9uZQo+IChs
b2NhbCkpCj4KPiAuLi4KPiA+ID4gLWNkIC4uCj4gPiA+IC1naXQgY2xvbmUgbHRwIGx0cC1mdWxs
LVlZWVlNTURECj4gPiA+IC1jZCBsdHAtZnVsbC1ZWVlZTU1ERAo+ID4gPiAtIyBVcGRhdGUgbWNl
LWluamVjdCBzdWJtb2R1bGUKPiA+ID4gLWdpdCBzdWJtb2R1bGUgaW5pdAo+ID4gPiAtZ2l0IHN1
Ym1vZHVsZSB1cGRhdGUKPiA+ID4gLSMgR2VuZXJhdGUgY29uZmlndXJlIHNjcmlwdAo+ID4gPiAt
bWFrZSBhdXRvdG9vbHMKPiA+ID4gLSMgUHJlcGFyZSB0aGUgYXJjaGl2ZXMKPiA+ID4gLWNkIC4u
Cj4gPiA+IC10YXIgLWNqZiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIuYnoyIGx0cC1mdWxsLVlZWVlN
TUREIC0tZXhjbHVkZSAuZ2l0Cj4gPiA+IC10YXIgLWNKZiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIu
eHogbHRwLWZ1bGwtWVlZWU1NREQgLS1leGNsdWRlIC5naXQKPgo+ID4gSSBzdWdnZXN0IGFkZGlu
ZyB0aGVzZSBpbnRvIGNyZWF0ZS10YXJiYWxscy1tZXRhZGF0YS5zaCBjb21tZW50cyBhcyB3ZWxs
Lgo+Cj4gIyBnaXQgY2xvbmUgbHRwIGx0cC1mdWxsLVlZWVlNTUREICYmIGNkIC0KPiAjIGdpdCBz
dWJtb2R1bGUgdXBkYXRlIC0taW5pdAo+ICMgbWFrZSBhdXRvdG9vbHMKPiAjIGNkIC4uCj4gIyB0
YXIgLWNqZiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIuYnoyIGx0cC1mdWxsLVlZWVlNTUREIC0tZXhj
bHVkZSAuZ2l0Cj4gIyB0YXIgLWNKZiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIueHogbHRwLWZ1bGwt
WVlZWU1NREQgLS1leGNsdWRlIC5naXQKPiAjIHNoYTI1NnN1bSBsdHAtZnVsbC1ZWVlZTU1ERC50
YXIueHogPiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIueHouc2hhMjU2Cj4KPiAoQWRkaW5nIGFsbCBj
aGVja3N1bXMgd291bGQgbG9vayB0byBtZSBxdWl0ZSB2ZXJib3NlICg2IGxpbmVzKSwgYnV0IEkg
Y2FuCj4gYWRkCj4gdGhlbS4pCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
