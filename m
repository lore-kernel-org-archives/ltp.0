Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8066DCDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 08:28:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B6BF3CEE08
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 10:28:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D41B3CD133
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:28:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C583D1400B9D
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697444924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E32s/nA1w43XX63tP8Htlxpvmg1AgOrN6mWhQHKD8UM=;
 b=EUo6AvBNSuWnQjl89wFgGNZyWRXyGnunGYTCLZd5w3LPHLNDtN8XHkLsQi44QO4QfhNVag
 FpdHQ5EehxlA9XntNQIbgTzZeJVXcuFAfmV3oSzczm9dSqKBMynXcOTw8WRgjq52cz6iMH
 DyaiHNKzVQyexFhmKvnlv4T4qn/QSzA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-t7MfdH1XPKCqkLp1W2htIw-1; Mon, 16 Oct 2023 04:28:41 -0400
X-MC-Unique: t7MfdH1XPKCqkLp1W2htIw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079a8c68c6so2612242e87.1
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697444920; x=1698049720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E32s/nA1w43XX63tP8Htlxpvmg1AgOrN6mWhQHKD8UM=;
 b=ced0+PjrNSVo5Ha+MoPrxf07mogrMFQeUjKKN0lKhytI3J4eVgTpGMXe3GCH0Rh23r
 HZVxasZJOgLD0KD8UaXpCugD7YRPWe8KPMGwGsWO81MtAhKEVIqawNfptN+pHYgDDn3z
 wRsvVDDWDZ7Hye0JwSbWYeXcTJgT0Uolvtdw1CXv86xdK7NSsxDGJaDLRH9S5EZuKL3M
 8ID/jlLgqtmmVyKKoKPSITr8LiKW+/+ChuKG54mUCpEZdrGqvnxwKCNgH6qPwAao0T1O
 dyDlJZ2S/1hbgbZLInNXjFKRPjV7D0umkO1nbwsjfW8qQdeofLb9vIydpybRgvtD09Sf
 GCmg==
X-Gm-Message-State: AOJu0YzzoXNPasn19rCxs2ymOMuvPYJtCdUOXwJzQhgGBBnZisbusDkz
 3Y54C4xFuLqJGp+eLAqCDdEHJj9S5Fr9RTGvQ+r+A/NMIs8uHgJEvDt5twFMNf9H4yKdFnk0S62
 yEP5Du4ONNP5i7NZXyYNimJB42mY=
X-Received: by 2002:a05:6512:102a:b0:503:9c2:e44e with SMTP id
 r10-20020a056512102a00b0050309c2e44emr22414693lfr.55.1697444919884; 
 Mon, 16 Oct 2023 01:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZkuHeKflExWTMeQEmzKTI0DGvj5rJLu/dLelpEDAJt+UmS7GO0h4vxgIuRFxIcYUHgb1csNPQfsbeStglbD0=
X-Received: by 2002:a05:6512:102a:b0:503:9c2:e44e with SMTP id
 r10-20020a056512102a00b0050309c2e44emr22414684lfr.55.1697444919527; Mon, 16
 Oct 2023 01:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <20231013123056.GC733568@pevik>
 <CAEemH2es0i-=V5W=2ZhZnN7OOq9BnFkkkSPyU1EUDWj0XHu1WA@mail.gmail.com>
 <20231013135031.GA740264@pevik>
In-Reply-To: <20231013135031.GA740264@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 16 Oct 2023 16:28:27 +0800
Message-ID: <CAEemH2cmETdFX61d+6OFNmhTEBoVFJ7zZegofNvQA8=ZvJJyUA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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

SGkgUGV0ciwKCk9uIEZyaSwgT2N0IDEzLCAyMDIzIGF0IDk6NTDigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+Cj4gSGkgTGksCj4KPiB0aGFua3MgZm9yIHlvdXIgaW5w
dXQhCj4KPiA+ID4gSGkgYWxsLAo+Cj4gPiA+IG1heWJlIC5tb2Rwcm9iZSBpcyB0b28gc2hvcnQg
bmFtZSwgYnV0IEknbSBub3Qgc3VyZSB3aGF0IHdvdWxkIGJlCj4gYmV0dGVyLgo+ID4gPiBNYXli
ZSAubW9kcHJvYmVfbW9kdWxlID8KPgo+Cj4gPiAubW9kcHJvYmVfbW9kdWxlIHNvdW5kcyBiZXR0
ZXIuCj4gKzEKPgo+ID4gQWxzbywgSSB0aGluayB0aGF0IG1heWJlIHdlIGNhbiBzdXBwb3J0IG1v
ZHByb2JlIHNvbWUKPiA+IHRoaXJkLXBhcnR5IG1vZHVsZXMgKHdyaXR0ZW4gYnkgdXNlcnMpIGlu
IHRlc3QgY2FzZSwgdGhlcmUgYXJlCj4gPiBhIGZldyBtYW5hZ2VkIGJ5IHNoZWxsIHNjcmlwdHMs
IGJ1dCBpZiAubW9kcHJvYmVfbW9kdWxlCj4gPiBtYW5hZ2VzIHRoZW0gdW5pZnkgaW4gQywgaXQg
d291bGQgYmUgbmljZSBmb3IgdGVzdCB2YXJpZXR5Lgo+Cj4gKzEuIEFsc28gSSBwbGFuIHRvIG1v
dmUgc29tZSBvZiB0aGUgTFRQIGtlcm5lbCBtb2R1bGVzIC0gdGVzdHMgd2hpY2ggdXNlCj4ga2Vy
bmVsCj4gbW9kdWxlcyBmcm9tIExUUCAoZS5nLiBkZWxldGVfbW9kdWxlLCBpbml0X21vZHVsZSwg
Li4uKXRvIEtVbml0IG9yCj4ga3NlbGZ0ZXN0ICh0bwo+IHNvbHZlIHByb2JsZW0gd2l0aCBzaWdu
ZWQgbW9kdWxlcyByZXF1aXJlZCBieSBkaXN0cm8ga2VybmVscywga2VybmVsCj4gbW9kdWxlcwo+
IGZyb20gTFRQIGFyZSB0aGVuIHVudGVzdGFibGUgb24gbG9ja2Rvd24pLiAgQnV0IG1heWJlIHRo
ZXNlIG1vZHVsZXMgY2FuCj4gc3RheSBpbgo+IExUUCBhbmQgYWxzbyBiZSBhZGRlZCB0byBLVW5p
dC4KPgoKWWVzLCB0aGV5IGNhbiBzdGF5IGluIExUUCwgYmVjYXVzZSB3ZSBkbyBoYXZlICcuc2tp
cF9pbl9sb2NrZG93bi9zZWN1cmVib290Jwp0byBhdm9pZCB0aGUgdW5zaWduZWQgbG9hZGluZyBl
cnJvci4KCgoKPiBCdXQgdGhlc2UgbW9kdWxlcyB1c2UgdHN0X21vZHVsZV9leGlzdHNfKCkgYW5k
IFNBRkVfT1BFTigpLiBTbyB5b3UgbWlnaHQKPiBtZWFuCj4gM3JkIHBhcnR5IG1vZHVsZXMgbGlr
ZSBudmlkaWEgb3Igb3RoZXIgcHJvcHJpZXRhcnkgbW9kdWxlcywgcmlnaHQ/Cj4KCkhtbSwgIGZv
ciBzdXJlIHdlIGNhbid0IHNhdGlzZnkgYWxsIHNpdHVhdGlvbnMsIGJ1dCBhdCBsZWFzdCB0aGVy
ZSBjb3VsZCBiZQphCnNlcGFyYXRlIHdheSB0byB1c2UgaW5pdC9maW5pdF9tb2R1bGUoKSB3aXRo
b3V0IC4nbW9kcHJvYmVfbW9kdWxlJy4KCkJ1dCBmb3IgdHN0X21vZHVsZV9sb2FkL3VubG9hZCwg
SSB0aGluayB0aGV5IGNvdWxkIGJlIGludGVncmF0ZWQgd2l0aGluCi5tb2Rwcm9iZV9tb2R1bGUg
d2hhdGV2ZXIgbG9hZGluZyBieSBgaW5zbW9kYCBvciBgbW9kcHJvYmVgLgoKCgo+Cj4gVGhlbiwg
c29tZSBvZiB0aGUgdGVzdHMgaW4gdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy8gbWln
aHQgYmUKPiBvYnNvbGV0ZSBvcgo+IGFsc28gYmUgbW9yZSBzdWl0YWJsZSBpbiBrc2VsZnRlc3Qg
b3IgS1VuaXQgb3IgZWxzZXdoZXJlLgo+Cj4gLi4uCj4gPiA+ID4gKyAgICAgaWYgKHRzdF90ZXN0
LT5tb2Rwcm9iZSkgewo+ID4gPiA+ICsgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZTsKPiA+
ID4gPiArICAgICAgICAgICAgIGludCBpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgICAgICAgICAg
IGZvciAoaSA9IDA7IChuYW1lID0gdHN0X3Rlc3QtPm1vZHByb2JlW2ldKTsgKytpKSB7Cj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgIC8qIG9ubHkgbG9hZCBtb2R1bGUgaWYgbm90IGFscmVh
ZHkgbG9hZGVkICovCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmICghbW9kdWxlX2xv
YWRlZChuYW1lKSAmJgo+ID4gPiB0c3RfY2hlY2tfYnVpbHRpbl9kcml2ZXIobmFtZSkpIHsKPgo+
ID4gPiBBbHNvIHdlIGNvdWxkIG1ha2UgaXQgaW5kZXBlbmRlbnQgb24gbW9kdWxlcy5idWlsdGlu
IChOaXhPUyBiYXNlZAo+IHByb2JsZW0gLQo+ID4gPiBtaXNzaW5nIHRoZXNlIGZpbGVzKS4gSS5l
LiB3ZSB3b3VsZCBrZWVwIG9ubHkgbW9kdWxlX2xvYWRlZCgpLCByZW1vdmUKPiA+ID4gdHN0X2No
ZWNrX2J1aWx0aW5fZHJpdmVyKCkuIEJ1dCB0aGVuIHdlIGNvdWxkIG5vdCBydW4gcm1tb2QgLyBt
b2Rwcm9iZQo+IC1yLAo+ID4gPiBvciB3ZSB3b3VsZCBoYXZlIHRvIGlnbm9yZSBpdCdzIGV4aXQg
Y29kZSAocm1tb2Qgb24gYnVpbHRpbiBtb2R1bGUpCj4gZmFpbHMuCj4KPgo+ID4gT3Igd2UgYWRk
IG9uZSBzdGVwIHRvIGRldGVjdCBtb2R1bGVzLmJ1aWx0aW4gZmlsZSwgaWYgbm8sCj4gPiB0aGVu
IGp1c3QgcHJpbnQgYSBXYXJuaW5nIGF0IHVubG9hZCBpbiBmYWlscz8KPgo+IFVubG9hZGluZyBz
aG91bGRuJ3QgYmUgcHJvYmxlbSBzaW5jZSBpdCdzIGluIGNsZWFudXAgKHRodXMgVEJST0sgPT4g
VFdBUk4pLgo+IEJ1dCBJJ2xsIHRlc3QgaXQuCj4KPiBPciBkbyB5b3UgbWVhbiB0aGF0IG9uIG1p
c3NpbmcgbW9kdWxlcy5idWlsdGluIHdvdWxkIHRlc3QgaXRzZWxmIGJlCj4gd29ya2luZyBhcwo+
IG1vZHVsZSBpcyBwcmVzZW50ZWQgKGhhdmUgd2FybmluZyBvbiB0aGF0IG1vZHVsZXMuKiBmaWxl
cyBhcmUgbWlzc2luZyBhbmQKPiB3YXJuaW5nIG9uIHJtbW9kPykuCj4KCk5vLCBJIGRpZG4ndCB0
aGluayBzbyBkZWVwbHk6KS4KCgoKPgo+IFdvdWxkIHlvdSBkbyBpdCBmb3IgYm90aCAubW9kcHJv
YmVfbW9kdWxlIGFuZCAubmVlZHNfZHJpdmVycz8gT3IganVzdCBvbmUKPiBvZiB0aGVtPwo+CgpN
YXliZSBib3RoLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
