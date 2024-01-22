Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36288C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFA733CE229
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:04:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200FA3C9978
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:04:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E606B6000E1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:04:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705914264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FKYK5Xo9MNs4snec0V035mFud85Y8DZwlQCratKZ9FE=;
 b=JPlSPZrAIZZKzCjWbeiSnPAADKJw0FCdnPgJUetzvdztINqKGHYDj/GTxAV1265agKoRzO
 liCoI6l5crPtJ+jqwlXq62ymN2twjuME3RfgdcLi407neokI5aTLwg4d1ngv5qV2S0f1RA
 2G/gnw1Ug++cJH5hnybplxdGpsgyRIg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-CSIclv9TNzCIe_agfjqjjw-1; Mon, 22 Jan 2024 04:04:22 -0500
X-MC-Unique: CSIclv9TNzCIe_agfjqjjw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-290587143d8so2099318a91.0
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914260; x=1706519060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKYK5Xo9MNs4snec0V035mFud85Y8DZwlQCratKZ9FE=;
 b=abPkLFw6bZloPfvPmrY0r/2Kihjyp2G1w/vyD1nHPZ29oiUAKzj9GkdMfF9UiSLaQc
 3oPQ0spjCrDhibG3vyR8mnMHsrSAs7Ab7Fd9JpOs8PmPu+0jq9V/mSR34323672OIClM
 X68P8nV12A+Y51sYD1ugeXrX+lkxfWVnpuJ7io3MnhHX21CYXUm4/x+U7pn/hMiqLEp8
 TBbbNAiA4JKOSGxsIzV4JcHFn32jokjpRY67UOgUd2Wmq0jDOCvf2cuGRobFWIL4jIkz
 e+RgQxS1xDrSzQYQZoD3FLlp7O1NPV6+ZRVSdKpdi7rHB+5aUzSkNWQ1EOzS2LiMC/4i
 fILg==
X-Gm-Message-State: AOJu0YzG7M0HA7pWeuOtybX+2YbRaTSBCTcgOuUWcVaWusQmROp7fOGi
 7IcRjW2/ln3ufTUC93yyNP7LZUXxDeDKvN08CMzre2fQT2uppE4zdPPgIvNBj1wsb19/JA4v+E6
 wUB5sFxkNVDfsHCqcYmdQzDDU4tcHUq69mr1sspGDKifcDyhgiWMY7rEu0t8lfXWbnwjlQYEX8Q
 I5upo0zUWcEPxoCxJj9TrslPljLmHFGr/PWp7s
X-Received: by 2002:a17:90a:9705:b0:290:58a7:1d65 with SMTP id
 x5-20020a17090a970500b0029058a71d65mr4027450pjo.49.1705914260145; 
 Mon, 22 Jan 2024 01:04:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiCz6z/AKReDF9MjMfDpGPSz5uuNk7EhU1i8SuXQv7oXwFm6JFiEq8Byy5FjslaaIyceEkuLvzdz0q0ppSrSw=
X-Received: by 2002:a17:90a:9705:b0:290:58a7:1d65 with SMTP id
 x5-20020a17090a970500b0029058a71d65mr4027441pjo.49.1705914259843; Mon, 22 Jan
 2024 01:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122072948.2568801-4-liwang@redhat.com>
 <20240122084000.GB76754@pevik>
In-Reply-To: <20240122084000.GB76754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 17:04:07 +0800
Message-ID: <CAEemH2dGgpuCYzRjW61+ig-Pc5YRXZ3GFpuRO=HWoR3ynHmyrQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/4] libswap: add Btrfs noCOW attribute setting
 for swap files
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

SGkgUGV0ciwKCk9uIE1vbiwgSmFuIDIyLCAyMDI0IGF0IDQ6NDDigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBUaGUgcGF0Y2ggYWltcyB0byBl
bnN1cmUgc3dhcCBmaWxlcyBvbiBCdHJmcyBmaWxlc3lzdGVtcyBhcmUgY3JlYXRlZAo+ID4gd2l0
aCB0aGUgYXBwcm9wcmlhdGUgRlNfTk9DT1dfRkwgYXR0cmlidXRlLCB3aGljaCBpcyBuZWNlc3Nh
cnkgdG8KPiA+IGRpc2FibGUgQ29XIChDb3B5LW9uLVdyaXRlKSBmb3Igc3dhcCBmaWxlcywgcGVy
dGhlIGJ0cmZzKDUpIG1hbnVhbCBwYWdlLgo+ID4gVGhpcyBjaGFuZ2UgaXMgZ2F0ZWQgYmVoaW5k
IGEga2VybmVsIHZlcnNpb24gY2hlY2sgdG8gZW5zdXJlCj4gY29tcGF0aWJpbGl0eQo+ID4gd2l0
aCB0aGUgc3lzdGVtJ3MgY2FwYWJpbGl0aWVzLgo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIGxpYnMvbGlibHRwc3dhcC9saWJzd2Fw
LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspCj4KPiA+IGRpZmYgLS1naXQgYS9saWJzL2xpYmx0cHN3
YXAvbGlic3dhcC5jIGIvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYwo+ID4gaW5kZXggNjIzZjJm
YjNjLi4wYjFkOWEyMjcgMTAwNjQ0Cj4gPiAtLS0gYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5j
Cj4gPiArKysgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gPiBAQCAtNCw2ICs0LDcgQEAK
PiA+ICAgKiBBdXRob3I6IFN0YW5pc2xhdiBLaG9sbWFuc2tpa2ggPHN0YW5pc2xhdi5raG9sbWFu
c2tpa2hAb3JhY2xlLmNvbT4KPiA+ICAgKi8KPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9mcy5oPgo+
ID4gICNpbmNsdWRlIDxlcnJuby5oPgo+Cj4gPiAgI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlO
Cj4gPiBAQCAtMjMsMTEgKzI0LDM3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBzd2FwX3N1
cHBvcnRlZF9mc1tdID0gewo+ID4gICAgICAgTlVMTAo+ID4gIH07Cj4KPiA+ICtzdGF0aWMgdm9p
ZCBzZXRfbm9jb3dfYXR0cihjb25zdCBjaGFyICpmaWxlbmFtZSkKPiA+ICt7Cj4gPiArICAgICBp
bnQgZmQ7Cj4gPiArICAgICBpbnQgYXR0cnM7Cj4gPiArCj4gPiArICAgICBmZCA9IFNBRkVfT1BF
TihmaWxlbmFtZSwgT19SRE9OTFkpOwo+ID4gKwo+ID4gKyAgICAgaWYgKGlvY3RsKGZkLCBGU19J
T0NfR0VURkxBR1MsICZhdHRycykgPT0gLTEpIHsKPiA+ICsgICAgICAgICAgICAgdHN0X3JlcyhU
RkFJTCB8IFRFUlJOTywgIkVycm9yIGdldHRpbmcgYXR0cmlidXRlcyIpOwo+IEkgZ3Vlc3Mgd2Ug
ZG9uJ3Qgd2FudCB0byBicmVhayBhbGwgdGVzdGluZyBkdWUgaW9jdGwgZmFpbHVyZSwgcmlnaHQ/
Cj4gT3RoZXJ3aXNlIEkgd291bGQgdXNlIFNBRkVfSU9DVEwoKS4KPgoKKzEsIHRoYW5rcy4KCgo+
ID4gKyAgICAgICAgICAgICBjbG9zZShmZCk7Cj4gPiArICAgICAgICAgICAgIHJldHVybjsKPiA+
ICsgICAgIH0KPiA+ICsKPiA+ICsgICAgIGF0dHJzIHw9IEZTX05PQ09XX0ZMOwo+ID4gKwo+ID4g
KyAgICAgaWYgKGlvY3RsKGZkLCBGU19JT0NfU0VURkxBR1MsICZhdHRycykgPT0gLTEpCj4gPiAr
ICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBURVJSTk8sICJFcnJvciBzZXR0aW5nIEZTX05P
Q09XX0ZMCj4gYXR0cmlidXRlIik7Cj4gQW5kIGhlcmUgYXMgd2VsbC4KPgoKKzEKCgo+ID4gKyAg
ICAgZWxzZQo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiRlNfTk9DT1dfRkwgYXR0
cmlidXRlIHNldCBvbiAlc1xuIiwKPiBmaWxlbmFtZSk7Cj4gVGhpcyBpcyByZWR1bmRhbnQgbmV3
IGxpbmUsIHBsZWFzZSByZW1vdmUgXG4gYmVmb3JlIG1lcmdpbmcuCj4KCisxLCBJIHdvdWxkIHNl
bmQgYSBWMiBmb3IgNC80LCBiZWNhdXNlIEkgZm91bmQgYWRkaXRpb25hbCBpc3N1ZQp0aGF0IHRo
ZSAiYnRyZnMiIHNob3VsZCBiZSBhZGRlZCBpbiBzd2FwX3N1cHBvcnRlZF9mc1tdIGFzIHdlbGwu
CgoKPiBuaXQ6IG1ha2UgY2hlY2sgcmVwb3J0cyB2YXJpb3VzIG9mIGZvcm1hdHRpbmcgaXNzdWVz
IChvbiBtYXN0ZXIgdGhlcmUgYXJlCj4gb25seQo+IHR3bykuIFdvdWxkIHlvdSBkYXJlIHRvIGZp
eCB0aGVtPyAoc29tZSBvZiB0aGVtIGFyZSBhZGRlZCBpbiB0aGUgZmlyc3QKPiBjb21taXQpLgo+
CgorMQoKCj4gbWFrZSBjaGVjay1saWJzd2FwCj4gQ0hFQ0sgbGlicy9saWJsdHBzd2FwL2xpYnN3
YXAuYwo+IGxpYnN3YXAuYzo3NTogV0FSTklORzogTWlzc2luZyBhIGJsYW5rIGxpbmUgYWZ0ZXIg
ZGVjbGFyYXRpb25zCj4gbGlic3dhcC5jOjEwMTogV0FSTklORzogcGxlYXNlLCBubyBzcGFjZXMg
YXQgdGhlIHN0YXJ0IG9mIGEgbGluZQo+IGxpYnN3YXAuYzoxMDI6IFdBUk5JTkc6IE1pc3Npbmcg
YSBibGFuayBsaW5lIGFmdGVyIGRlY2xhcmF0aW9ucwo+IGxpYnN3YXAuYzoxMDI6IFdBUk5JTkc6
IHBsZWFzZSwgbm8gc3BhY2VzIGF0IHRoZSBzdGFydCBvZiBhIGxpbmUKPiBsaWJzd2FwLmM6MTAy
OiBXQVJOSU5HOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25hbCBzdGF0ZW1lbnRz
ICg3LAo+IDE1KQo+IGxpYnN3YXAuYzoxMDM6IEVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNl
IHRhYnMgd2hlcmUgcG9zc2libGUKPiBsaWJzd2FwLmM6MTAzOiBXQVJOSU5HOiBwbGVhc2UsIG5v
IHNwYWNlcyBhdCB0aGUgc3RhcnQgb2YgYSBsaW5lCj4gbGlic3dhcC5jOjEwMzogV0FSTklORzog
c3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cwo+ICgxNSwgMjMp
Cj4gbGlic3dhcC5jOjEwNDogRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCB1c2UgdGFicyB3aGVy
ZSBwb3NzaWJsZQo+IGxpYnN3YXAuYzoxMDQ6IFdBUk5JTkc6IHBsZWFzZSwgbm8gc3BhY2VzIGF0
IHRoZSBzdGFydCBvZiBhIGxpbmUKPiBsaWJzd2FwLmM6MTA1OiBFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIHVzZSB0YWJzIHdoZXJlIHBvc3NpYmxlCj4gbGlic3dhcC5jOjEwNTogV0FSTklORzog
cGxlYXNlLCBubyBzcGFjZXMgYXQgdGhlIHN0YXJ0IG9mIGEgbGluZQo+IGxpYnN3YXAuYzoxMDU6
IFdBUk5JTkc6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMK
PiAoMTUsIDIzKQo+IGxpYnN3YXAuYzoxMDY6IEVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNl
IHRhYnMgd2hlcmUgcG9zc2libGUKPiBsaWJzd2FwLmM6MTA2OiBXQVJOSU5HOiBwbGVhc2UsIG5v
IHNwYWNlcyBhdCB0aGUgc3RhcnQgb2YgYSBsaW5lCj4gbGlic3dhcC5jOjEwNzogV0FSTklORzog
cGxlYXNlLCBubyBzcGFjZXMgYXQgdGhlIHN0YXJ0IG9mIGEgbGluZQo+Cj4KPiA+ICsKPiA+ICsg
ICAgIGNsb3NlKGZkKTsKPiA+ICt9Cj4gPiArCj4gPiAgLyoKPiA+ICAgKiBNYWtlIGEgc3dhcCBm
aWxlCj4gPiAgICovCj4gPiAgaW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dhcGZpbGUs
IGludCBzYWZlKQo+ID4gIHsKPiA+ICsgICAgIGxvbmcgZnNfdHlwZSA9IHRzdF9mc190eXBlKHN3
YXBmaWxlKTsKPiA+ICsgICAgIGNvbnN0IGNoYXIgKmZzdHlwZSA9IHRzdF9mc190eXBlX25hbWUo
ZnNfdHlwZSk7Cj4gPiArCj4gPiAgICAgICBpZiAoIXRzdF9mc19oYXNfZnJlZSgiLiIsIHN5c2Nv
bmYoX1NDX1BBR0VTSVpFKSAqIDEwLCBUU1RfQllURVMpKQo+ID4gICAgICAgICAgICAgICB0c3Rf
YnJrKFRCUk9LLCAiSW5zdWZmaWNpZW50IGRpc2sgc3BhY2UgdG8gY3JlYXRlIHN3YXAKPiBmaWxl
Iik7Cj4KPiA+IEBAIC0zNSw2ICs2MiwxNCBAQCBpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFy
ICpzd2FwZmlsZSwgaW50IHNhZmUpCj4gPiAgICAgICBpZiAodHN0X2ZpbGxfZmlsZShzd2FwZmls
ZSwgMCwgc3lzY29uZihfU0NfUEFHRVNJWkUpLCAxMCkgIT0gMCkKPiA+ICAgICAgICAgICAgICAg
dHN0X2JyayhUQlJPSywgIkZhaWxlZCB0byBjcmVhdGUgc3dhcGZpbGUiKTsKPgo+ID4gKyAgICAg
LyogQnRyZnMgZmlsZSBuZWVkIHNldCAnbm9jb3cnIGF0dHJpYnV0ZSAqLwo+ID4gKyAgICAgaWYg
KHN0cmNtcChmc3R5cGUsICJidHJmcyIpID09IDApIHsKPgo+IE1heWJlIHVzaW5nIGp1c3QgZnNf
dHlwZSAobG9uZyksIGkuZS4gYXZvaWQgY29udmVyc2lvbiB0byBjaGFyICogdmlhCj4gdHN0X2Zz
X3R5cGVfbmFtZSgpPyBPciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPwo+Cj4gICAgICAgICBsb25n
IGZzX3R5cGUgPSB0c3RfZnNfdHlwZShzd2FwZmlsZSk7Cj4gICAgICAgICAuLi4KPiAgICAgICAg
IGlmIChmc190eXBlID09IFRTVF9CVFJGU19NQUdJQykgewo+CgpHb29kIHBvaW50LgoKCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiArICAgICAgICAgICAgIGlmICh0c3Rfa3ZlcmNtcCg1
LCAwLCAwKSA+IDApCj4gPiArICAgICAgICAgICAgICAgICAgICAgc2V0X25vY293X2F0dHIoc3dh
cGZpbGUpOwo+ID4gKyAgICAgICAgICAgICBlbHNlCj4gPiArICAgICAgICAgICAgICAgICAgICAg
dHN0X2JyayhUQ09ORiwgIlN3YXBmaWxlIG9uICVzIG5vdCBpbXBsZW1lbnRlZCIsCj4gZnN0eXBl
KTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICAgICAgIC8qIG1ha2UgdGhlIGZpbGUgc3dhcGZpbGUg
Ki8KPiA+ICAgICAgIGNvbnN0IGNoYXIgKmFyZ3ZbMiArIDFdOwo+ID4gICAgICAgYXJndlswXSA9
ICJta3N3YXAiOwo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
