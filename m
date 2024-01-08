Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA7AC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:08:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64973CD366
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:08:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2793B3C05DA
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 10:07:53 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10E91200C24
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 10:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704704846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/gSx3GlWOrP3SG8t/v+FE7gR1mof/sT+E/jWDjykAQ=;
 b=RrOR1esLX0cPPTXV7fWgTA5G3TBl5slMjCEFcJLEzBqA+AaiHzBIzjGLs0Dns9sKTjZnfb
 TBu0aKUMiYcEYfc8Mt35j5iQ0NYoNXuRTONWo2cnpeGHTJZyLlRl1cYcoJ4M1j8nU9u+I8
 Yr8eLsn/3GQHsH5RQYLaA2Yz/VEil0U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-UY2ysq6HNd6hJ57nuZnwag-1; Mon, 08 Jan 2024 04:06:11 -0500
X-MC-Unique: UY2ysq6HNd6hJ57nuZnwag-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2cd022a1f84so12126211fa.1
 for <ltp@lists.linux.it>; Mon, 08 Jan 2024 01:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704704769; x=1705309569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/gSx3GlWOrP3SG8t/v+FE7gR1mof/sT+E/jWDjykAQ=;
 b=Sv2oc6nsS5ZWmRga40ghUeusSTxl2X2IF1bXrHwN28xKFOX3I+gGfA4cOEVf+1HfGr
 Ag6cuF6SqT2FRYUEI4X8liFDk3umdwrMkOObOuj++MRTVHOMJsUc7QKEk0qFRqu0Phvz
 arB6YEBnL9uZQYT/0266gcj8+cLwNk5452z5+5Z56F8TYa4qG/SyZPOjZPkK3ErKiDwf
 4MqYeYYhKf6yix7SDKqBKFbVGmgLzoVjI2dw9LBC1PphAop+Qqi3jHaJPiOBVbpRAc/h
 uABAsVOmFEFDLR9sAArGuG4C58Yg115W3DKG42SXQFtdJMeThvrY9fvJnDEo1V+U6BAx
 sPTg==
X-Gm-Message-State: AOJu0YyNf/fSdk3OkERkbcrjvMLrCY7zMMoJ7DvFVCL3e5aM6/BxHU/U
 +/Gx6xUnvSxJ9SYlH+nFFJwx3pYvpra15OcCRThEAzKk4gTfELR0mO8PRx3CqgYPgfj4ylAulSC
 tmx+hv8VoEhxBMSENmwl6wh4/o4LYMx2K54vyVYSQfkIv8LG4RTw=
X-Received: by 2002:a2e:2413:0:b0:2cc:df3f:9f83 with SMTP id
 k19-20020a2e2413000000b002ccdf3f9f83mr1164815ljk.64.1704704769426; 
 Mon, 08 Jan 2024 01:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdQosnTFBuAyM+ZW2nHV6eQZ5gZJre5wpS/JKng8BIwgq2gRYxewDeXCJmKiyUlQ/EZg+fRTp0edHq5wseVyw=
X-Received: by 2002:a2e:2413:0:b0:2cc:df3f:9f83 with SMTP id
 k19-20020a2e2413000000b002ccdf3f9f83mr1164809ljk.64.1704704769076; Mon, 08
 Jan 2024 01:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20240105002914.1463989-1-pvorel@suse.cz>
In-Reply-To: <20240105002914.1463989-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Jan 2024 17:05:57 +0800
Message-ID: <CAEemH2fACYL_NoYYHQw=TzQu_4zDEBUhBjT_m=vgLmd3hNry=w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] lapi/fsmount.h: Fix headers conflict
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

T24gRnJpLCBKYW4gNSwgMjAyNCBhdCA4OjI54oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBnbGliYyBkb2MgWzFdIG1lbnRpb25zIGNvbmZsaWN0IGJldHdlZW4gPGxp
bnV4L21vdW50Lmg+IGFuZAo+IDxzeXMvbW91bnQuaD4uIEJlY2F1c2UgPGxpbnV4L2ZzLmg+IGlu
Y2x1ZGVzIDxsaW51eC9tb3VudC5oPiBpdCdzIGVhc3kKPiB0byBnZXQgPGxpbnV4L21vdW50Lmg+
IG1vdW50ZWQgaW5kaXJlY3RseS4KPgo+IFByb2JsZW0gd2FzIGZpeGVkIG9uIGdsaWJjIDIuMzc6
Cj4gNzc0MDU4ZDcyOSAoImxpbnV4OiBGaXggc3lzL21vdW50LmggdXNhZ2Ugd2l0aCBrZXJuZWwg
aGVhZGVycyIpCj4gYW5kIGl0IGdvdCBiYWNrcG9ydGVkIHRvIGdpdCB0cmVlIGZvciAyLjM2IGFu
ZCB0byBzb21lIGRpc3Ryb3MuCj4gQnV0IGl0IHN0aWxsIGZhaWxzIGZvciBvbGRlciBnbGliYy4K
Pgo+IFRoZXJlZm9yZSBpbmNsdWRlIDxzeXMvbW91bnQuaD4gb25seSBpZiA8bGludXgvbW91bnQu
aD4gbm90IGFscmVhZHkKPiBpbmNsdWRlZC4KPgo+IFsxXSBodHRwczovL3NvdXJjZXdhcmUub3Jn
L2dsaWJjL3dpa2kvU3luY2hyb25pemluZ19IZWFkZXJzCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiBDaGFuZ2VzIHYxLT52MjoKPiAqIFJlYWxs
eSBmaXggdGhlIGlubHVzaW9uLgo+Cj4gVGVzdGVkOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9wZXZp
ay9sdHAvYWN0aW9ucy9ydW5zLzc0MTYzNjM1MjQKPgo+ICBpbmNsdWRlL2xhcGkvZnNtb3VudC5o
IHwgMTEgKysrKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvZnNtb3VudC5oIGIvaW5j
bHVkZS9sYXBpL2ZzbW91bnQuaAo+IGluZGV4IDA3ZWI0MmZmYS4uYTk0OTFhMTZkIDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvbGFwaS9mc21vdW50LmgKPiArKysgYi9pbmNsdWRlL2xhcGkvZnNtb3Vu
dC5oCj4gQEAgLTEsNiArMSw2IEBACj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCj4gIC8qCj4gLSAqIENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0
LCAyMDIxLTIwMjIKPiArICogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2plY3QsIDIwMjEt
MjAyNAo+ICAgKiBDb3B5cmlnaHQgKGMpIDIwMjAgTGluYXJvIExpbWl0ZWQuIEFsbCByaWdodHMg
cmVzZXJ2ZWQuCj4gICAqIEF1dGhvcjogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJv
Lm9yZz4KPiAgICovCj4gQEAgLTExLDEyICsxMSwxMSBAQAo+ICAjaW5jbHVkZSAiY29uZmlnLmgi
Cj4gICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgo+ICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cj4g
LSNpbmNsdWRlIDxzeXMvbW91bnQuaD4KPgo+IC0jaWZuZGVmIEhBVkVfRlNPUEVOCj4gLSMgaWZk
ZWYgSEFWRV9MSU5VWF9NT1VOVF9ICj4gLSMgIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+Cj4gLSMg
ZW5kaWYKPiArI2lmICFkZWZpbmVkKEhBVkVfRlNPUEVOKSAmJiBkZWZpbmVkKEhBVkVfTElOVVhf
TU9VTlRfSCkKPiArIyBpbmNsdWRlIDxsaW51eC9tb3VudC5oPgo+ICsjZWxzZQo+ICsjIGluY2x1
ZGUgPHN5cy9tb3VudC5oPgo+CgpUaGlzIG5hcnJvd3MgZG93biB0aGUgdXNhZ2UgY29uZGl0aW9u
cyBvZiB0aGUgc3lzL21vdW50LmggaGVhZGVyLApJIGFtIG5vdCBzdXJlIGlmIHRoZSBiZW5lZml0
cyBhcmUgbW9yZSwgYnV0IGl0IHNlZW1zIHN0cmljdCBhbmQgc2FmZS4gU286CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKCj4gICNlbmRpZgo+Cj4gICNpbmNsdWRl
ICJsYXBpL2ZjbnRsLmgiCj4gLS0KPiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
