Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9395C47DAF
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 12:27:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 631723CBDFD
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 13:27:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98C583C62C0
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 13:26:50 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F4F81BC2F15
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 13:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705667207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9ztUBseJgqaWS72yawiR3TarTHBkwdnh54MxRNBkho=;
 b=B57QOUTxcCnoMaLwkS/1jg/zrmv0nOC++L04McBKHL/clShzZnSfs6aLYtt4vm1nQvOF0q
 Q/wbCaNMWJuoWgWx47UUeF3tVMGDbFhsn/Nsoaj0amZg0uPc5NjNqRY5yGiSoVFOdf3d82
 w73D9qCUjgqs03wd0mCy0Q+V9JBGBtc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-dm9bWTu8OPecmpYDyV2TDw-1; Fri, 19 Jan 2024 07:26:46 -0500
X-MC-Unique: dm9bWTu8OPecmpYDyV2TDw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29045a73796so778439a91.1
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 04:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705667205; x=1706272005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9ztUBseJgqaWS72yawiR3TarTHBkwdnh54MxRNBkho=;
 b=diOL9Y7a6SKpnFjc+UlGPXpcZgTtp/CDVBuMjUL7QSpdGIGltTXnFvoMSXncGTxz7X
 LFek4636CWUQC/0HVDX4nhq5owLnqXXc9GunnXDC3Y0GpQdQRjhEm8zZDTjKTFW3PGE8
 TzQAacWJPEKApYCVjLW9g26l3Ek+FIuZsGp4J7LHtQQM8jLas2J+rSEc4yK0w5x7P2rR
 q29OzKrnVJtFla2G1mjY8Cl+iHmG6oEOcNz6m//YWt7gnmidlZZelqoWVttcfSjFQJNW
 4FLDr/YtnCpyw3dUBbzaNQCbH2v8fKG6TStLzaz5VDMJ9VBZ4AP6DvSHVmYDhRcHosnw
 +NYg==
X-Gm-Message-State: AOJu0YyI4Ch6wEQZbt7HEzrbjZ20mWSJ3nfDUi1yo/kuXu5pJAeHYDfz
 IIvPdyROKyEeXx4uho/LXdiI9rVKsP/+LiAJcHL6qWZKZH8T8MRM5gWKJ3qYdJBu2sGEwNrWo5U
 +xApnNpSjIqLWgRRdOzy+ORrjxCC01dmNt3SyyaDFK/1V0/qrWvn3nlRtNmvWEcGnDsOoesHo9F
 aYNE3orjZL7qUzzou5wJE1U2k=
X-Received: by 2002:a17:90b:1dcf:b0:290:44b5:22dd with SMTP id
 pd15-20020a17090b1dcf00b0029044b522ddmr1149719pjb.40.1705667205092; 
 Fri, 19 Jan 2024 04:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG10PnOBEdaIo0rKTNJoAL4Y6RvDasaIeUQJobKxhjpeVp6+m8S/H/+wmCU49dWkoLODU+vjqHXEnrxLesKNHM=
X-Received: by 2002:a17:90b:1dcf:b0:290:44b5:22dd with SMTP id
 pd15-20020a17090b1dcf00b0029044b522ddmr1149702pjb.40.1705667204604; Fri, 19
 Jan 2024 04:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-2-pvorel@suse.cz> <ZapgEnqfXwdL7_Pu@yuki>
In-Reply-To: <ZapgEnqfXwdL7_Pu@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jan 2024 20:26:32 +0800
Message-ID: <CAEemH2dAvum4rHr1FpX7Tcii=U9gph+eHGW3rfYzev3S88Cfrg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] swapon01: Test on all filesystems
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMTksIDIwMjQgYXQgNzo0MuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUZXN0IG9uIGFsbCBmaWxlc3lzdGVtcyB0byBpbmNy
ZWFzZSBjb3ZlcmFnZS4gIGJ0cmZzIGFuZCB0bXBmcwo+ID4gY3VycmVudGx5IGRvZXMgbm90IHN1
cHBvcnQgc3dhcCBmaWxlLCBidXQga2VlcCBpdCBpbiBjYXNlIHRoaXMgZ2V0Cj4gPiBjaGFuZ2Vk
IGluIHRoZSBmdXR1cmUuCj4gPgo+ID4gVGVzdGluZyBvbiBhbGwgZmlsZXN5c3RlbXMgdXN1YWxs
eSByZXF1ZXN0cyByb290LCBidXQgd2UgZG9uJ3QgcmVxdWlyZQo+ID4gaXQgd2l0aCAubmVlZHNf
cm9vdCA9IDEuIEJ1dCB1c2luZyBzd2Fwb24oKSByZXF1aXJlcyBpdCBhcyB3ZWxsLCB0aHVzCj4g
PiBrZWVwIGl0IGRlZmluZWQuCj4gPgo+ID4gQWxzbyBkZXRlY3QgdGhlIHN1cHBvcnQgb24gdGhl
IHNhbWUgZmlsZSBhcyB3aGljaCBpcyBiZWluZyB0ZXN0ZWQuCj4KPiBGb3IgdGhlIHByZXZpb3Vz
IGl0ZXJhdGlvbiBvZiB0aGlzIHBhdGNoIExpIHdhc24ndCBzdXJlIGlmIHRoaXMgYWRkcwo+IGVu
b3VnaCB2YWx1ZSBzaW5jZSB0aGVyZSBpc24ndCB0b24gb2YgZmlsZXN5c3RlbSBzcGVjaWZpYyBj
b2RlIGludm9sdmVkCj4gdW5sZXNzIHdlIGFjdHVhbGx5IHN0YXJ0IHdyaXRpbmcgdG8gdGhlIHN3
YXBmaWxlLgo+CgpZZXMsIGlmIHRlc3Rpbmcgd2l0aCBhbGxfZmlsZXN5c3RlbXMsIG9ubHkgbWFr
ZV9zd2FwZmlsZSBwcm9jZXNzIG1ha2VzCnNlbnNlIElNTy4KVGhlIHJlc2V0IHN3YXBvbigpIG9w
ZXJhdGlvbiBkb2VzIHRoZSBzYW1lIHRoaW5nIHRvIHRoZSBrZXJuZWwuCgoKCj4KPiBBbmQgYXMg
dGhlIHBhdGNoIGlzIEkgd291bGQgYWdyZWUgd2l0aCB0aGF0LiBXaGF0IG1heSBtYWtlIHNlbnNl
IEkgdGhpbmsKPiBpcyB0byByZXF1aXJlIGNlcnRhaW4gZmlsZXN5c3RlbSB0byBzdXBwb3J0IHN3
YXAsIGkuZS4gZmFpbCB0aGUgdGVzdCBpbgo+IHRoZSBjYXNlIHRoYXQgd2UgaGF2ZW4ndCBtYW5h
Z2VkIHRvIGNyZWF0ZSBhbmQgZW5hYmxlIHRoZSBzd2FwZmlsZSB3aGVyZQo+IGl0J3Mgc3VwcG9z
ZWQgdG8gd29yay4gVGhhdCB3b3VsZCBndWFyZCBhYm91dCBhY2NpZGVudGFsIGJyZWFrYWdlcywg
YXMKPiBpdCBpcyB0aGUgdGVzdCB3b3VsZCBub3QgY2F0Y2ggdGhlc2UgYmVjYXVzZSBpdCB3b3Vs
dCBUQ09ORiBpbiB0aGUKPiBzZXR1cC4KPgoKKzEKClRoaXMgc291bmRzIHJlYXNvbmFibGUsIGxv
b2tzIGxpa2Ugd2UgbmVlZCBhIHdoaXRlbGlzdCB0byBndWFyYW50ZWUKdGhvc2UgZmlsZXN5c3Rl
bXMgdGhhdCBzdXBwb3J0IHN3YXBmaWxlLCBvdGhlcndpc2UgaXQncyBlYXN5IHRvIG1pc3MKc29t
ZSBmYWxzZSBuZWdhdGl2ZXMgd2l0aCByZXBvcnQgVENPTkYgYnkgaXNfc3dhcF9zdXBwb3J0ZWQo
KS4KCgoKPgo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4g
PiAtLS0KPiA+IElNSE8gaXQncyBub3QgYSBiaWcgc2xvd2Rvd24gdGh1cyBJIGtlZXAgYnRyZnMg
YW5kIHRtcGZzLgo+ID4gVGhleSBtaWdodCBnZXQgc3VwcG9ydCBvbmUgZGF5Lgo+ID4KPiA+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jIHwgMTcgKysrKysrKysr
KystLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fw
b24vc3dhcG9uMDEuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDEuYwo+ID4gaW5kZXggYjVjM2YzNTljLi42YjdmOTZjZjcgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiBAQCAtOSw2ICs5LDkgQEAK
PiA+ICAgKiBDaGVja3MgdGhhdCBzd2Fwb24oKSBzdWNjZWRzIHdpdGggc3dhcGZpbGUuCj4gPiAg
ICovCj4gPgo+ID4gKyNkZWZpbmUgTU5UUE9JTlQgICAgICJtbnRwb2ludCIKPiA+ICsjZGVmaW5l
IFNXQVBfRklMRSAgICBNTlRQT0lOVCIvc3dhcGZpbGUwMSIKPiA+ICsKPiA+ICAjaW5jbHVkZSA8
dW5pc3RkLmg+Cj4gPiAgI2luY2x1ZGUgPGVycm5vLmg+Cj4gPiAgI2luY2x1ZGUgPHN0ZGxpYi5o
Pgo+ID4gQEAgLTE4LDE0ICsyMSwxNCBAQAo+ID4KPiA+ICBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dh
cG9uKHZvaWQpCj4gPiAgewo+ID4gLSAgICAgVEVTVCh0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwg
Ii4vc3dhcGZpbGUwMSIsIDApKTsKPiA+ICsgICAgIFRFU1QodHN0X3N5c2NhbGwoX19OUl9zd2Fw
b24sIFNXQVBfRklMRSwgMCkpOwo+ID4KPiA+ICAgICAgIGlmIChUU1RfUkVUID09IC0xKSB7Cj4g
PiAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAiRmFpbGVkIHRvIHR1cm4g
b24gc3dhcGZpbGUiKTsKPiA+ICAgICAgIH0gZWxzZSB7Cj4gPiAgICAgICAgICAgICAgIHRzdF9y
ZXMoVFBBU1MsICJTdWNjZWVkZWQgdG8gdHVybiBvbiBzd2FwZmlsZSIpOwo+ID4gICAgICAgICAg
ICAgICAvKndlIG5lZWQgdG8gdHVybiB0aGlzIHN3YXAgZmlsZSBvZmYgZm9yIC1pIG9wdGlvbiAq
Lwo+ID4gLSAgICAgICAgICAgICBpZiAodHN0X3N5c2NhbGwoX19OUl9zd2Fwb2ZmLCAiLi9zd2Fw
ZmlsZTAxIikgIT0gMCkgewo+ID4gKyAgICAgICAgICAgICBpZiAodHN0X3N5c2NhbGwoX19OUl9z
d2Fwb2ZmLCBTV0FQX0ZJTEUpICE9IDApIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICB0c3Rf
YnJrKFRCUk9LIHwgVEVSUk5PLCAiRmFpbGVkIHRvIHR1cm4gb2ZmCj4gc3dhcGZpbGUsIgo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBzeXN0ZW0gcmVib290IGFmdGVyIGV4ZWN1
dGlvbiBvZiBMVFAgIgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInRlc3Qgc3Vp
dGUgaXMgcmVjb21tZW5kZWQuIik7Cj4gPiBAQCAtMzUsMTMgKzM4LDE1IEBAIHN0YXRpYyB2b2lk
IHZlcmlmeV9zd2Fwb24odm9pZCkKPiA+Cj4gPiAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+
ICB7Cj4gPiAtICAgICBpc19zd2FwX3N1cHBvcnRlZCgiLi90c3Rzd2FwIik7Cj4gPiAtICAgICBt
YWtlX3N3YXBmaWxlKCJzd2FwZmlsZTAxIiwgMCk7Cj4gPiArICAgICBpc19zd2FwX3N1cHBvcnRl
ZChTV0FQX0ZJTEUpOwo+ID4gKyAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDApOwo+ID4g
IH0KPiA+Cj4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gLSAgICAgLm5l
ZWRzX3Jvb3QgPSAxLAo+ID4gLSAgICAgLm5lZWRzX3RtcGRpciA9IDEsCj4gPiArICAgICAubW50
cG9pbnQgPSBNTlRQT0lOVCwKPiA+ICsgICAgIC5tb3VudF9kZXZpY2UgPSAxLAo+ID4gKyAgICAg
Lm5lZWRzX3Jvb3QgPSAxLCAvKiBmb3Igc3dhcG9uKCkgKi8KPiA+ICsgICAgIC5hbGxfZmlsZXN5
c3RlbXMgPSAxLAo+ID4gICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3N3YXBvbiwKPiA+ICAgICAg
IC5zZXR1cCA9IHNldHVwCj4gPiAgfTsKPiA+IC0tCj4gPiAyLjQyLjAKPiA+Cj4KPiAtLQo+IEN5
cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
