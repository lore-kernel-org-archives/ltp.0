Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DF3C4828D
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 12:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0873CC654
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 13:59:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D3FA3C8921
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 13:59:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CB00600D13
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 13:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707224377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uG1zpb8azeGHfS6fvBjSL4DKxok8+6TTifjw2+0gpo0=;
 b=WjIbHoNVPtZT+E0HxWnCiflI5gbVVZsrPz1Co8fZcU0iQEx7zgbihB32Go6vmsnIMXH2eE
 AnJtEGUuyMwpErCHVAXJm2VXZ/K9IA+SlJSBXN5n+RUpG152vQmU2HV7lXXSglKQT8S2pF
 X2/ugV+WkOsi0GXl4hEdbVzWvce47oY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-2j7JdvCxMaec071a-XUEeA-1; Tue, 06 Feb 2024 07:59:35 -0500
X-MC-Unique: 2j7JdvCxMaec071a-XUEeA-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-46d3d0a0e16so431951137.3
 for <ltp@lists.linux.it>; Tue, 06 Feb 2024 04:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707224375; x=1707829175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uG1zpb8azeGHfS6fvBjSL4DKxok8+6TTifjw2+0gpo0=;
 b=v3yJMnggn4XOEbsILRYpiejuVMAj4Nx1COQ+Wr0z233WaRdZtjgAYnkewC9fqpLhxp
 nJEp67J++YJ7nHEV0bUh7V2mTNEoUkpADCH7jd5HomVSiTgoRly5MyzLnhVU4vZGu5Do
 lA/th31hQ5aq4ZFAIeKvi38LAsfq6BYss9+dQ+pSYp/4lE+OJwtlSo2KXEh1N/GT0yFB
 onbz/arGeVjQoAvEhPzJ2rp1hz4EOM4JAPFU1o0nK9ra1M+niwWnWzosXaLNSkHhBRYW
 fZBQ+cza185+RI8VKkcruQH2c7Rqw0ZIcYrH+7H0qo9PY1wEh/89Xl+X5e5ZEjG+tZZ0
 t27w==
X-Gm-Message-State: AOJu0Yxw66ndzCCNabQjSE25FJvfLS/jfORtJW2A5Z6g0TPe737pZg7S
 CbryltCgfBJHLZ+rPp6qyVugqd+GkvKfBZyHdGLekSKX9wY5OgzLRwd1CXwWALkshpTRLjutjCB
 nh2ZX8Q51DS8X0E1ex4lfGz5rq2uUeY3LjuByBHhQlprGolXJXDq5ShQQiig9PsgI/o/RpsxpVq
 Has27+ougAQSI6B99c+CAcvMc=
X-Received: by 2002:a05:6102:1793:b0:46c:b94c:ee36 with SMTP id
 je19-20020a056102179300b0046cb94cee36mr2723229vsb.20.1707224375191; 
 Tue, 06 Feb 2024 04:59:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhV0jPomlAlFm0c3Go/tHzn56nthGZ3pB+s+qMfAC6irURIkJwJwwfHNMpIRcRPzWf63p9RkZ0+PBJolXML9Q=
X-Received: by 2002:a05:6102:1793:b0:46c:b94c:ee36 with SMTP id
 je19-20020a056102179300b0046cb94cee36mr2723207vsb.20.1707224374854; Tue, 06
 Feb 2024 04:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20240205102653.2789879-1-liwang@redhat.com>
 <20240206115126.GF270992@pevik>
In-Reply-To: <20240206115126.GF270992@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 6 Feb 2024 13:59:18 +0100
Message-ID: <CAASaF6wp7yob+uNwBWVuAz=A=uBiiCutvCLHYm+CKqNWbfuCzQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] process_state: Enhancement of process state
 detection
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

T24gVHVlLCBGZWIgNiwgMjAyNCBhdCAxMjo1MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLCBJYW4sCj4KPiA+IFRoZSBmdW5jdGlvbnMgd2lsbCBiZSBt
b3JlIHJvYnVzdCBhZ2FpbnN0IHByb2Nlc3MgbmFtZXMgd2l0aAo+ID4gdW51c3VhbCBjaGFyYWN0
ZXJzIGFuZCB3aWxsIGNvcnJlY3RseSByZWFkIHRoZSBzdGF0ZSBjaGFyYWN0ZXIKPiA+IGZyb20g
dGhlIC9wcm9jL1twaWRdL3N0YXQgZmlsZS4gVGhpcyBpcyBhIG5lY2Vzc2FyeSBjaGFuZ2UKPiA+
IGJlY2F1c2UgdGhlIHByb2Nlc3MgbmFtZSwgd2hpY2ggaXMgYSBmcmVlLWZvcm0gc3RyaW5nLCBj
YW4KPiA+IGNvbnRhaW4gc3BhY2VzIGFuZCBvdGhlciBjaGFyYWN0ZXJzIHRoYXQgd291bGQgb3Ro
ZXJ3aXNlCj4gPiBkaXNydXB0IHRoZSBzaW1wbGUgcGFyc2luZyBsb2dpYyBvZiB0aGUgb3JpZ2lu
YWwgZm9ybWF0IHN0cmluZy4KPgo+ID4gZS5nLgo+ID4gICQgY2F0IC9wcm9jLzc5MjQ0Mi9zdGF0
Cj4gPiAgNzkyNDQyIChXZWIgQ29udGVudCkgUyAxNjQyMTMgNDM1MSA0MzUxIDAgLTEgNDE5NDU2
MCAuLi4KPgo+ID4gUmVwb3J0ZWQtYnk6IElhbiBXaWVuYW5kIDxpd2llbmFuZEByZWRoYXQuY29t
Pgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiBDYzog
Q2h1bnl1IEh1IDxjaHVodUByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgbGliL3RzdF9wcm9jZXNz
X3N0YXRlLmMgfCA0ICsrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+Cj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9wcm9jZXNzX3N0YXRlLmMg
Yi9saWIvdHN0X3Byb2Nlc3Nfc3RhdGUuYwo+ID4gaW5kZXggMDhhOWQwOTY2Li5jMTUyODNjM2Qg
MTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X3Byb2Nlc3Nfc3RhdGUuYwo+ID4gKysrIGIvbGliL3Rz
dF9wcm9jZXNzX3N0YXRlLmMKPiA+IEBAIC0yMiw3ICsyMiw3IEBAIGludCB0c3RfcHJvY2Vzc19z
dGF0ZV93YWl0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4KPiA+ICAgICAg
IGZvciAoOzspIHsKPiA+ICAgICAgICAgICAgICAgc2FmZV9maWxlX3NjYW5mKGZpbGUsIGxpbmVu
bywgY2xlYW51cF9mbiwgcHJvY19wYXRoLAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIiUqaSAlKnMgJWMiLCAmY3VyX3N0YXRlKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICIlKlteKV0lKmMgJWMiLCAmY3VyX3N0YXRlKTsKPgo+IE9idmlvdXNseSBjb3JyZWN0
LCB0aGFua3MuCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpB
Y2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cgo+Cj4gQnV0IHRoZXJl
IGlzIGFsc28gdGhlIHNhbWUgaXNzdWUgaW4gbGliL3RzdF90aHJlYWRfc3RhdGUuYywKPiBJIGd1
ZXNzIGl0IGFwcGxpZXMgdG8gdGhhdC4gTGksIGNvdWxkIHlvdSBwbGVhc2UgYWxzbyBmaXggaXQg
YmVmb3JlIG1lcmdlPwo+Cj4gQWxzbywgQW5kcmVhLCB5b3UgYWRkZWQgdHN0X3RocmVhZF9zdGF0
ZV93YWl0KCkgYW5kIFRTVF9USFJFQURfU1RBVEVfV0FJVCgpIGZvcgo+IGZ1dGV4X3dhaXR2MFsy
M10gcmVsYXRlZCB0ZXN0cyBbMV0sIGJ1dCBpdCdzIG5vdyBub3QgdXNlZCBhbnl3aGVyZSBkdWUg
SmFuJ3MKPiBjaGFuZ2VzIFsyXSBbM10uIEkgd29uZGVyIGlmIGl0J3Mgc3RpbGwgdXNlZnVsIG9y
IHdoZXRoZXIgd2Ugc2hvdWxkIHJlbW92ZSBpdC4KCkknZCBrZWVwIGl0LCBpdCdzIGEgc21hbGwg
ZnVuY3Rpb24gYW5kIHNvbWVvbmUgY291bGQgZmluZCB1c2VmdWwgZm9yCnNvbWUgbmV3IHRlc3Qu
Cgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sdHAvMjAyMjAyMDkwOTE3NTYuMTcyNDUtMi1hbmRyZWEuY2VydmVzYXRvQHN1c2UuZGUvCj4g
WzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC82YzViMTYxYmMzYmNmNzUzY2JkYTkyOTU0
Y2EzZjQ3Y2IyNjhjNjhmLjE2NjM2NjU2MzcuZ2l0LmpzdGFuY2VrQHJlZGhhdC5jb20vCj4gWzNd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC82YmFjNzAzNWFkYzJjZmM4YWIzODAwZmUxZDJk
MDMyMjNlYzU3ZmY1LjE2NjM2NjIzNDguZ2l0LmpzdGFuY2VrQHJlZGhhdC5jb20vCj4KPiA+ICAg
ICAgICAgICAgICAgaWYgKHN0YXRlID09IGN1cl9zdGF0ZSkKPiA+ICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsKPiA+IEBAIC01NCw3ICs1NCw3IEBAIGludCB0c3RfcHJvY2Vzc19zdGF0ZV93
YWl0MihwaWRfdCBwaWQsIGNvbnN0IGNoYXIgc3RhdGUpCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDE7Cj4gPiAgICAgICAgICAgICAgIH0KPgo+ID4gLSAgICAgICAgICAgICBpZiAo
ZnNjYW5mKGYsICIlKmkgJSpzICVjIiwgJmN1cl9zdGF0ZSkgIT0gMSkgewo+ID4gKyAgICAgICAg
ICAgICBpZiAoZnNjYW5mKGYsICIlKlteKV0lKmMgJWMiLCAmY3VyX3N0YXRlKSAhPSAxKSB7Cj4g
PiAgICAgICAgICAgICAgICAgICAgICAgZmNsb3NlKGYpOwo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGZwcmludGYoc3RkZXJyLCAiRmFpbGVkIHRvIHJlYWQgJyVzJzogJXNcbiIsCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9jX3BhdGgsIHN0cmVycm9yKGVycm5vKSk7Cj4K
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
