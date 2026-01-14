Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB9D29FE3
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768386801; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QEMZ0wudwNkJCQl4jjMccUrTgEUDwtSEYw8aoA0W73k=;
 b=cHCwvfINX/Bd7e3sN3CYEpPmLpujoU/5/dqlkPZZF+XzFmffXw1PRkolQzb2pt3LMIryL
 qzIhsr9e+WfT8DPY0lQAV/uODjANugMvD+/NB0b/g/rMWLcgG8j7izfdEgQT6BnBr/HGSqs
 zbylX9OiU4oCHw4gYwYA8llgHtyFKcw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662F13C9956
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 11:33:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EE9D3C71B6
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 11:32:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71E1F1000465
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 11:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768386775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4SxEzlSLinqZOpL94AjB7CM3AnBTkM+Ud3U5Sck+bA=;
 b=DE0d71fEr6a4NVHaWfxTY9k8yWnaTePcceNboCASOuNAqeUZ2o3TFIhnIlFmOMPEULCXE5
 k5R7K95tIIpbhNxhbtEVMznHj4ns0+IUtjw7iff9ooGSCXks9OfB4sE1QQI9YW5HxeEQng
 bs8QeJYBvO9mrCajgGkVLBDlaPeLN+U=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-HOadkh6kNaWU4PoEkENezw-1; Wed, 14 Jan 2026 05:32:52 -0500
X-MC-Unique: HOadkh6kNaWU4PoEkENezw-1
X-Mimecast-MFC-AGG-ID: HOadkh6kNaWU4PoEkENezw_1768386771
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1233b81a92dso49417c88.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 02:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768386771; x=1768991571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4SxEzlSLinqZOpL94AjB7CM3AnBTkM+Ud3U5Sck+bA=;
 b=qrMJVjHrF7DaQ0xQQngWq//2DMAPSgJZwhQ9nLIeu1H6loG9bKxKhq4HmbdH5UNvi+
 eFjUbKrDAu+O0DD5/9YjFjEHWgGWF4tuPb6IOyFUfcnp85m3AEmAYqdehDU/KD5xcobp
 TEDLzaKDWecaB+ZLclfmuCElarp1O7cGWlJEjYcEuLjKQNQa+WcSIqdiP1hd4m4W9q8q
 swXFHUJGgzbU8iAXyqbn7HcFdcXOaHeQ2ZzshaqWDnHjAyGp+7Q9u+ZqcG2n6ZCl1pCE
 WLukuQ+sqc/hRgIt6WF3zTQTWT77/VC3Sa4xeqMD+9+iXNYf++3rPHN4bUMzbyZzlAhr
 2mrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbyGVH5ZuVgQK1/AwAQ4qiR0AG9uh6O6EeMs5l7xSVRYB8b4nEqOyA9NUI5yBJ+DYNqmU=@lists.linux.it
X-Gm-Message-State: AOJu0YxHGlyg0PlSfjgIXosB9ClovmDKJ7/wm8yBDN74ctjitsl614xL
 WqQu9xeJnyj/4Dq/424tm1lsGEs8KpNhB94kzaD9RwhDFZcQgKqk+Ax0QbcUAeZIcaIUGDdu7pU
 d2iTksBAhlLU9eTm/pnby2v1nvLGDV4hb6pmSW+1bMsm1MzE4BcmXmzJjvP46NKXu0g3w/vKFY3
 Xyc731bgKG/oqh653E17HSqEZ+m4I=
X-Gm-Gg: AY/fxX4BZpb2Fm2xrbY+WfudD6hxovM1ZCsSKTepZlqXBJfGR0/yD9l935mPCb4Dp0O
 ihQATu2ss3shUFZj6yGlmwdh+oT1S5JOBao8/eqWbTE9w3XDxGEl8kfpLVruMJn4iCNHl9FA7W4
 jPQpCc/94HkMpvrOn64f9SYgt/s5IvmbW+7QiTqo4Sf/Za3Ao1UCy3NY8eiekOndbJfnA=
X-Received: by 2002:a05:7022:23aa:b0:11b:9b9f:427c with SMTP id
 a92af1059eb24-1232b61f87dmr6760626c88.13.1768386770897; 
 Wed, 14 Jan 2026 02:32:50 -0800 (PST)
X-Received: by 2002:a05:7022:23aa:b0:11b:9b9f:427c with SMTP id
 a92af1059eb24-1232b61f87dmr6760587c88.13.1768386770083; Wed, 14 Jan 2026
 02:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <20260114085116.GB334250@pevik>
In-Reply-To: <20260114085116.GB334250@pevik>
Date: Wed, 14 Jan 2026 18:32:38 +0800
X-Gm-Features: AZwV_Qi4Si03cGupj3vVdnJUFt9NGASYrY37zycpZ3YFl0_4kBA2J2uWlaFAeo4
Message-ID: <CAEemH2e1MVNjLJR+_h9Bvkk3b0roVxhtJRvedFhxH4ckzhW==A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KGp_tOyus08-Gq9Kh_t3BgpgZwA1uPSeizrV4qQNFoo_1768386771
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMTQsIDIwMjYgYXQgNDo1MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gPiA+IEknZCBrZWVwIHRoZW0gc2VwYXJhdGUgZnJvbSBjb3JlIGxp
YnJhcnkuIEZvciBub24tY29yZSBsaWJyYXJpZXMsIEknZCBnbwo+ID4gPiB3aXRoCj4gPiA+ID4g
c29tZXRoaW5nIG1vcmUgZGlzdGluY3QsIGxpa2UgImx0cCIgcHJlZml4IGZvciBmaWxlIGFuZCBm
dW5jdGlvbiBuYW1lcy4KPgo+Cj4gPiBUaGFua3MhCj4KPiA+ID4gPiBXaGVuIEkgbG9vayBhdCAi
bGlibnVtYS5oIiBJJ2QgaGF2ZSB0byB0aGluayBmb3IgYSBiaXQgaWYgdGhpcyBpcwo+ID4gPiA+
IGhlYWRlciBmcm9tIG51bWEtZGV2ZWwKPiA+ID4gPiBvciBMVFAuICJsdHBudW1hLmgiIHNlZW1z
ICh0byBtZSkgbW9yZSBjbGVhciB0aGF0IGl0J3Mgbm90IExUUCBjb3JlCj4gPiA+ID4gbm9yIG51
bWEtZGV2ZWwuCj4KPgo+ID4gR29vZCBwb2ludCwgYnV0IHRoZSBsdHAqIHByZWZpeCBzb3VuZHMg
dG9vIHNlcmlvdXMgdG8gbWUuIEFueXRoaW5nIHdpdGgKPiA+IHRoZSBsdHAqIHByZWZpeCBpbnNp
ZGUgYW4gTFRQIG1ha2VzIG1lIHRoaW5rIGl0J3MgY3JpdGljYWwgaW5mb3JtYXRpb24uCj4KPiAr
MQo+Cj4gPiBQZXJoYXBzIHdlIGNhbiB1c2UgYSBsaWdodHdlaWdodCBuYW1lIGZvciB0aGUgZXh0
cmEgbGlicy86Cj4KPiA+IGVzdF8qOiBleHRyYSB0ZXN0IGxpYnJhcnkKPiA+IHhzdF8qOiBleHRl
bmVkIHRlc3QgbGlicmFyeQo+ID4gbHN0Xyo6IGx0cCB0ZXN0IGxpYnJhcnkKPgo+ID4gSSBwcmVm
ZXIgdG8gdXNlIGxzdF8qLCB3aGljaCBpcyBub3Qgb25seSBkaWZmZXJlbnQgZnJvbSB0c3RfKiwg
YnV0IGFsc28KPiA+IGltcGxpZXMKPiA+IHRoaXMgaXMgbHRwIHRzdF8gdGhpbmdzLgo+Cj4gPiBX
aGF0IGRvIHlvdSB0aGluaz8gb3IgYW55IGJldHRlciBwcmVmaXg/Cj4KPiBHaXZlbiB0aGF0IGlu
Y2x1ZGUgImxpYmZvby5oIiBzaG91bGQgYmUgbG9jYWwgaGVhZGVyIGFuZCBpbmNsdWRlIDxmb28u
aD4gc2hvdWxkCj4gYmUgaGVhZGVyIGZyb20gL3Vzci9saWIqIEkgd291bGQgYmUgb2sgd2l0aCBl
aXRoZXIga2VlcCB0aGluZ3MgYXMgdGhleSBhcmUgb3IKPiB1c2UgdGhlIG9yaWdpbmFsIExpJ3Mg
cHJvcG9zYWwuCj4KPiBGb3IgbWUgcGVyc29uYWxseSBpcyBtb3JlIHVzZWZ1bCB0byBrbm93IHdo
ZXRoZXIgaGVhZGVyIGNhbiBiZSB1c2VkIGluIHRoZSBvbGQKPiBBUEkgKGkuZS4gInRzdF8iIHBy
ZWZpeCBtZWFucyBzb3VyY2UgaXMgY29udmVydGVkIGluIHRoZSBuZXcgQyBBUEkpIHRoYW4gd2hl
dGhlcgo+IGhlYWRlciBpcyBmcm9tIGV4dHJhIGxpYnJhcnkuCgpXZWxsLCB3ZSBtaWdodCBzdWJj
b25zY2lvdXNseSB0aGluayB0aGF0IGxpYmZvby5oIG1lYW5zIGFuIG9sZGVyIHZlcnNpb24sCmJ1
dCB3ZSBjYW4gY2hhbmdlIHRoYXQgbWluZHMuIFNvbWV0aGluZyBsaWtlICJsc3RfIiBjYW4gYWxz
byBiZSB1c2VkIGluCm9sZGVyIEFQSXMgKGFuZCBpbXBsaWVzIGV4dHJhIGxpYnMvKS4KCkZ1cnRo
ZXJtb3JlLCBJIGJlbGlldmUgdGhlc2UgYWRkaXRpb25hbCAnbGlicy8nIGRpcmVjdG9yaWVzIHdp
bGwgY29udGludWUgdG8gYmUKZGV2ZWxvcGVkIGFuZCBleGlzdCBsb25nLXRlcm07IHdlIGN1cnJl
bnRseSBoYXZlIG5vIHBsYW5zIHRvIG1pZ3JhdGUgdGhlbQp0byB0aGUgY29yZSBBUEksICBzbyBl
eHBsaWNpdCBuYW1pbmcgYmVjb21lcyBjcnVjaWFsIGZvciBtYWludGVuYW5jZS4KCkJ5IG5vdywg
dGhlIHNpdHVhdGlvbiBpcywgaW5sY3VkZS8gY29udGFpbnMgZGlmZmVyZW50IHByZWZpeCBoZWFk
ZXIgZmlsZXM6CiAgJ2x0cF8nLCAnb2xkXycsICdsaWInOiBtZWFudCBvbGQgTFRQIEFQSSwgYnV0
IHNob3VsZCBldmVudHVhbGx5IGJlIGRyb3BwZWQuCiAgdHN0XzogbWVhbnQgdGhlIG5ldyBjb3Jl
IExUUCBBUEkuCgpOZXh0LCBJIGhvcGUgdGhhdCB3ZSBvbmx5IGtlZXAgdHdvIHByZWZpeGVzIGlu
IExUUCBBUEk6CiAgdHN0XzogbmV3IGNvcmUgTFRQIEFQSQogIGxzdF86IGV4dHJhIChub24tY29y
ZSkgTFRQIEFQSQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
