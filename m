Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64017C74A44
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 09:42:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59EF3CB7ED
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 10:42:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 923983C08AA
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 10:42:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96AA81000A58
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 10:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678441343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEywUBh9NKg8Qo7Un6k/O9ASNXV2OKr92XAt/oFIxks=;
 b=Pq6uYTBLKH2o9fF8IkumlY+SxR0meLSjuoX/EB3z8WkXxmac2Nwo7kVoSszAf07jjcJeCz
 VKBrBH31kXbr7q1OPJfm8SDYLNxvCzs6LojDM/Jb15w4x5RxB89AJ75GnRfUf8reQfZgx/
 dvGSImiu1eRXxTU+10IQgSIBXBdu6G0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295--DQvjD8JPfuJEhkxoWUVAA-1; Fri, 10 Mar 2023 04:42:21 -0500
X-MC-Unique: -DQvjD8JPfuJEhkxoWUVAA-1
Received: by mail-wr1-f72.google.com with SMTP id
 x3-20020a5d6503000000b002c8c421fdfaso942940wru.15
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 01:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678441340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uEywUBh9NKg8Qo7Un6k/O9ASNXV2OKr92XAt/oFIxks=;
 b=Nuo4Vh2edutndzoynkwzc8zOr8wvcFQwroDshiZfJi8cQh0MuPKJuGChGwIcdiPpk9
 6/hWRlz6z+4fzWKI/szMsNc8oDAjCQqXe4JoeedvvbOXDBiqV3HYHrJC/QRlpt0XdVv5
 DWQdMwPhLaWQe/WlZcVMoCJa2HEXMH+Q7DjliVeWrIBb7W4O0DaH5/1EYc0DssY3ENwE
 G+lce5bd0rDUh8x0WLamZVjZx9jdi5rjSf2LcdcMCGtbAhtTIT7EZIjxKQO1n7d0AtRz
 86Gs7ujx8XR3iYjCNjz0Yt8C/VW2M3+SLAZ8ZwFaCQYyGEQWuwN624PmkHx2F+W6o+or
 6Sag==
X-Gm-Message-State: AO0yUKUOUIj64Uuql1bOuAH/CQr13vcoJgqGh7kFThq4qibV3kapzAfO
 GP5lwNpo6B8aSk8JIOJpJ1Ba9QXE5JAsi7r9+rUS+S0+UjyCarqxo66rX3C2S0cQSsA3E1gqGyu
 bMTMLbktXOQREXQSx6rv/sq/k+EM=
X-Received: by 2002:adf:f64f:0:b0:2c7:1210:fe57 with SMTP id
 x15-20020adff64f000000b002c71210fe57mr4870913wrp.8.1678441340646; 
 Fri, 10 Mar 2023 01:42:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+xSD31XM1+6+h3ILNWmEDQTWbUFXKPwZ+9paw8Q+l/4qkgd2/+73hT5Fy3H6VfHFe3G/sDDvzI4UW1njS/Xg4=
X-Received: by 2002:adf:f64f:0:b0:2c7:1210:fe57 with SMTP id
 x15-20020adff64f000000b002c71210fe57mr4870907wrp.8.1678441340287; Fri, 10 Mar
 2023 01:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
 <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
 <20230310093117.GA8713@pevik>
In-Reply-To: <20230310093117.GA8713@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Mar 2023 17:42:08 +0800
Message-ID: <CAEemH2eBqt1_ZTY3GCRfgx4EQdWiJJepA_wVGpSg6=pYubHddw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: ltp@lists.linux.it, Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgNTozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgYWxsLAo+Cj4gLi4uCj4gPiA+IEkgd29uZGVyIGlmIHdlIGNhbiBn
ZXQgdGhpcyB3aG9sZSBtZXNzIG9mIHR3byBkaWZmZXJlbnQgZmFsbGJhY2sKPiBoZWFkZXJzCj4g
PiA+IHNpbXBsaWZpZWQuIExvb2tpbmcgYXQgdGhlIGdsaWJjIGltcGxlbWVudGF0aW9uIGl0IHNl
ZW1zIHRvIGluY2x1ZGUKPiA+ID4gImxpbnV4L21vdW50LmgiIGlmIGl0IGRvZXMgZXhpc3QuIFNv
IG1vc3QgcmVhc29uYWJsZSBzb2x1dGlvbiB3b3VsZCBkbwo+ID4gPiB0aGUgc2FtZSBJIGd1ZXNz
IHdoaWNoIHdlIGRpZCBiZWZvcmUgdGhlIGNvbW1pdCB5b3UgcmVmZXJlbmNlLgo+Cj4KPiA+IFRo
aXMgaXMgaW5kZWVkIGNvcnJlY3QgaWYgb25seSBmYWNlIHRoZSBsYXRlc3QgR2xpYmMsIGJ1dCB0
aGF0IG1pZ2h0IGhhdmUKPiA+IHByb2JsZW1zIHdoZW4gYnVpbGRpbmcgTFRQIG9uIGEgbWlkZGxl
IHZlcnNpb24gb2YgR2xpYmMvS2VybmVsLWhlYWRlcnMuCj4gPiBUaGUgYnVnIEkgbWVudGlvbmVk
IGluIHRoZSBsYXN0IGVtYWlsIHdhcyBmaXhlZCBzaW5jZSBnbGliYy0yLjM3fjQyNi4KPiBEbyB5
b3Uga25vdyB3aGljaCBleGFjdCBjb21taXQgaGFzIGZpeGVkIGl0PyBJdCdkIGhlbHAgdXMgdG8g
cmVhbGl6ZSB3aGVuCj4gdGhpcwo+IGZpeCBpcyBub3QgbmVlZGVkIGFueSBtb3JlIChpdCdkIGJl
IGdvb2QgdG8gcHV0IGl0IGludG8gdGhlIGNvbW1pdAo+IG1lc3NhZ2UpLgo+CgpJIG1lYW4gdGhp
cyBjb21taXQ6Cmh0dHBzOi8vZ2l0aHViLmNvbS9rcmFqL2dsaWJjL2NvbW1pdC83NzQwNThkNzI5
NDIyNDlmNzFkNzRlN2YyYjYzOWY3NzE4NDE2MGE2CgoKCj4KPiA+IEBGYWJyaWNlLCB3aGF0IGtp
bmQgb2YgdmVyc2lvbiBvZiBHbGliYy9LZXJuZWwtaGVhZGVycyBkbyB5b3UgdXNlPyBhbmQKPiA+
IHdoaWNoIHBsYXRmb3JtPwo+Cj4KPiBodHRwOi8vYXV0b2J1aWxkLmJ1aWxkcm9vdC5vcmcvcmVz
dWx0cy80ZGJiNzJlMWJmMDgxYWZkM2NkOTQ0NTcxYjliZWVlZmM3NjA4ODY1L2NvbmZpZwo+IGFy
Y2g6IGFybQo+ICMgQnVpbGRyb290IDIwMjMuMDItcmMxLTIyLWdhMzllMzI4YmIyIENvbmZpZ3Vy
YXRpb24KPiA9PiAyLjM2LTgxLWc0ZjRkN2ExM2VkZmQyZmRjNTdjOWQ3NmUxZmQ2ZDAxN2ZiNDc1
NTBjCj4ga2VybmVsIGhlYWRlcnMgNS4xMC4KPiBTcGVjaWZpYyBCdWlsZHJvb3QgdG9vbGNoYWlu
Lgo+Cj4gPiBCdHcsIHRoaXMgcGF0Y2ggYnVpbGRzIExUUCBzdWNjZXNzZnVsbHkgaW4gQ0k6Cj4g
PiAgIC0gaHR0cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL2FjdGlvbnMvcnVucy80Mzgw
NzM5NDcwCj4gQnVpbGRyb290IG9mdGVuIGZvdW5kcyBwcm9ibGVtcyBmb3IgZW1iZWRkZWQgZm9s
a3MsIGJlY2F1c2UgdGhleSB1c2UKPiBkaWZmZXJlbnQKPiB0b29sY2hhaW4gdGhhbiB0cmFkaXRp
b25hbCBsaW51eCBkaXN0cm9zLgo+Cj4gPiBBbmQgSSBtYW51YWxseSB0cmllZCB3aXRoIGZlZG9y
YS1yYXdoaWRlL2ZlZG9yYTM0LzM1LzM3LzM4IGFsbCBsb29rcwo+IGdvb2QuCj4gVGhhbmtzIGZv
ciBjaGVja2luZy4KPgo+ID4gTWF5YmUgd2UgY2FuIGp1c3QgYXBwbHkgdGhpcyBwYXRjaCB0byBr
ZWVwIGV2ZXJ5dGhpbmcgd2l0aCBubyBiaWcKPiBjaGFuZ2VzLgo+Cj4gPiBAQ3lyaWwsIFBldHIs
IHdoYXQgZG8geW91IHRoaW5rPwo+IFVubGVzcyB0aGVyZSBpcyBhIHNpbXBsZSB3YXkgdG8gaW1w
cm92ZSB0aGluZ3MsIEknbSBmb3IgbWVyZ2luZyB0aGlzLgo+Cj4KCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
