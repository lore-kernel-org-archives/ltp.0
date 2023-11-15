Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29193C07548
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 06:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912453CE468
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 07:04:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F1B33CC268
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 07:04:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2356D60071A
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 07:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700028279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9j+SUhbeD2pIXSXtuP1uQRz3aU9XW7ApX83eQjgQjZc=;
 b=f9KmELfb2xfWN675kmbBu1FVnwAmJwg9tSD8oXr51N2NKynD7ubG27i9N03nZIvNKX3EL/
 pyNqoG0Ge4AKQFm4hNWJkfNY0H7wldmBIgdPbzhB4wYtIPjLp1IrD2JFyEC8SywxtbsThr
 pfkwPvf0x/7yYd92jcY+4XONpeee34o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ObPGV90WMx2Izw2MB93WpA-1; Wed, 15 Nov 2023 01:04:37 -0500
X-MC-Unique: ObPGV90WMx2Izw2MB93WpA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507f20a111fso301500e87.0
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 22:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700028275; x=1700633075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9j+SUhbeD2pIXSXtuP1uQRz3aU9XW7ApX83eQjgQjZc=;
 b=bHa+jxd4B9y+UisNDMUJHqBQUTziT4XlvOGfNha8jS4JCLKLUwiKDD5EVcW+fsad0t
 TKIRjt8+W6o8Kaz9/cFjpcWKxffHDGL3UlHq9hL7J//obcuZke7ls2xLa9WAcOXUK/sd
 hM8eKrYLoq7R7iM6NPzpmbM3I/PRBcvgfn6ATGe1LRh7hnYNt0JE5keGZOrjr5PCwERR
 BdeSVVjFATT/IpyMpXMF++8DbxsMhMH8GkuKfMuiIi9ZSeaHtj/8vAEn2mA+AHISa1Ye
 8jAY/pDdIFuf9yGflYtZrCBu9UY96+Dn1yu/aC511Ow3+EcUOwEwlgzNCsyeuWRMAIMh
 ReGw==
X-Gm-Message-State: AOJu0YyqiiPCBpEHg6hPui9gG3mzfPo9XWaHNCQNv0Dy8daRqM5hi9Nk
 aZ0b62KzG4FNR031TQRDGCvXsHmN8IJTWyVIYMgxlc7+J8lmaPJUwxKXBGZ88rWaGAveJJbpWF7
 hXKfeFdTdi1Y0rmz4iBBljp8v9JpZMf/k+p3nTAZX
X-Received: by 2002:ac2:5a1c:0:b0:509:366b:a01c with SMTP id
 q28-20020ac25a1c000000b00509366ba01cmr1443934lfn.14.1700028275161; 
 Tue, 14 Nov 2023 22:04:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcAKLedDKMF6QMuAWXxFsrldbSHr9e1i9hkaCB+pebc4Fo7yZrk6qs4wy/BwkghZGfls/fBIpLUYcwO1ESjWc=
X-Received: by 2002:ac2:5a1c:0:b0:509:366b:a01c with SMTP id
 q28-20020ac25a1c000000b00509366ba01cmr1443923lfn.14.1700028274574; Tue, 14
 Nov 2023 22:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20231031015301.355147-1-wangxuewen@kylinos.cn>
In-Reply-To: <20231031015301.355147-1-wangxuewen@kylinos.cn>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Nov 2023 14:04:22 +0800
Message-ID: <CAEemH2c9=SSWk97s8br=ZidJ6oK2hMyxadwFHn-unP7wvWqhAA@mail.gmail.com>
To: wangxuewen@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugemmap24: loongarch:Add __longarch__ for
 compatibility with Loongarch
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

SGkgWHVld2VuLAoKSSB0aGluayB0aGlzIGlzIGR1cGxpY2F0ZWQgd2l0aCBhbm90aGVyIG9uZSwg
Y2FuIGRvdWJsZSBjaGVjayB5b3VyIHBhdGNoPwpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2x0cC9jb21taXQvNjczOGZiNDg4ZDA1ODcxZjI4YjIwNDIzOWQ0NWMzMGNkYjA1
YTM3OQoKT24gVHVlLCBOb3YgMTQsIDIwMjMgYXQgNTo1MOKAr1BNIDx3YW5neHVld2VuQGt5bGlu
b3MuY24+IHdyb3RlOgoKPiBGcm9tOiB3YW5neHVld2VuIDx3YW5neHVld2VuQGt5bGlub3MuY24+
Cj4KPiBUaGlzIGFsbG93cyBmb3IgYSBsb3dlciBhZGRyZXNzIGJyYW5jaCBvbiB0aGUgTG9uZ2Fy
Y2ggcGxhdGZvcm0uCj4KPiAuL2h1Z2VtbWFwMjQKPiB0c3RfaHVnZXBhZ2UuYzo4MzogVElORk86
IDQgaHVnZXBhZ2UocykgcmVzZXJ2ZWQKPiB0c3RfdGVzdC5jOjE1NjA6IFRJTkZPOiBUaW1lb3V0
IHBlciBydW4gaXMgMGggMDBtIDMwcwo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVz
ZSBzbGljZV9ib3VuZGFyeTogMHgyMDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFw
MjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHgzMDAwMDAwMDAwMDog
RUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9i
b3VuZGFyeTogMHg0MDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDog
VElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHg1MDAwMDAwMDAwMDogRUlOVkFMCj4g
KDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTog
MHg2MDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNh
bid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHg3MDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1
Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHg4MDAwMDAw
MDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBz
bGljZV9ib3VuZGFyeTogMHg5MDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQu
Yzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHhhMDAwMDAwMDAwMDogRUlO
VkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3Vu
ZGFyeTogMHhiMDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElO
Rk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHhjMDAwMDAwMDAwMDogRUlOVkFMCj4gKDIy
KQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHhk
MDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0
IHVzZSBzbGljZV9ib3VuZGFyeTogMHhlMDAwMDAwMDAwMDogRUlOVkFMCj4gKDIyKQo+IGh1Z2Vt
bWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHhmMDAwMDAwMDAw
MDogRUlOVkFMCj4gKDIyKQo+IGh1Z2VtbWFwMjQuYzo2NDogVElORk86IGNhbid0IHVzZSBzbGlj
ZV9ib3VuZGFyeTogMHgxMDAwMDAwMDAwMDA6IEVJTlZBTAo+ICgyMikKPiBodWdlbW1hcDI0LmM6
NzI6IFRGQUlMOiBjb3VsZG4ndCBmaW5kIDIgZnJlZSBuZWlnaGJvdXIgc2xpY2VzOiBFSU5WQUwg
KDIyKQo+Cj4gU2lnbmVkLW9mZi1ieTogd2FuZ3h1ZXdlbiA8d2FuZ3h1ZXdlbkBreWxpbm9zLmNu
Pgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFw
MjQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDI0LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAv
aHVnZW1tYXAyNC5jCj4gaW5kZXggMTU4YTAzMDEwLi40MzFkYzFiYmYgMTAwNjQ0Cj4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMKPiArKysg
Yi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMjQuYwo+IEBA
IC0zMCw3ICszMCw3IEBAIHN0YXRpYyBpbnQgaW5pdF9zbGljZV9ib3VuZGFyeShpbnQgZmQpCj4g
ICAgICAgICB1bnNpZ25lZCBsb25nIHNsaWNlX3NpemU7Cj4gICAgICAgICB2b2lkICpwLCAqaGVh
cDsKPiAgICAgICAgIGludCBpOwo+IC0jaWYgZGVmaW5lZChfX0xQNjRfXykgJiYgIWRlZmluZWQo
X19hYXJjaDY0X18pCj4gKyNpZiBkZWZpbmVkKF9fTFA2NF9fKSAmJiAhZGVmaW5lZChfX2FhcmNo
NjRfXykgJiYgIWRlZmluZWQoX19sb29uZ2FyY2hfXykKPiAgICAgICAgIC8qIHBvd2VycGM6IDFU
QiBzbGljZXMgc3RhcnRpbmcgYXQgMSBUQiAqLwo+ICAgICAgICAgc2xpY2VfYm91bmRhcnkgPSAw
eDEwMDAwMDAwMDAwOwo+ICAgICAgICAgc2xpY2Vfc2l6ZSA9IDB4MTAwMDAwMDAwMDA7Cj4gLS0K
PiAyLjM0LjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
