Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58213E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 07:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 938D53E5B60
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 08:33:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AD583E5665
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 08:33:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6ADDE1BE9774
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 08:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733815996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdyje6eJAJytm/tuxzyNWmVx1BFIWvSdlgWSzNwXKyY=;
 b=igHJReqQOWxPcbrWx6+aIJ5NkxaiPmHp5H8+Nt2ORVCb6P8imp5rQval6EkZ1eQwM2Z1xC
 2BeANo+2mJU1BE1f0Z5GaHDVW4PKvope3WZ1KfAi+WzaGaWC2F+AILeRj/p4HOmgjU5iUB
 VQDKOxB58b9IDsPY1AoZxssijXYlOiQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-JzVqIrlePC6mx48yGr5tHQ-1; Tue, 10 Dec 2024 02:33:15 -0500
X-MC-Unique: JzVqIrlePC6mx48yGr5tHQ-1
X-Mimecast-MFC-AGG-ID: JzVqIrlePC6mx48yGr5tHQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ee86953aeaso5185033a91.2
 for <ltp@lists.linux.it>; Mon, 09 Dec 2024 23:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733815993; x=1734420793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdyje6eJAJytm/tuxzyNWmVx1BFIWvSdlgWSzNwXKyY=;
 b=xBnCXzutn7fcHyq0jkMVM6lrJPpree35OIVrtPU5UzoSs63tIo8HYCZqghWrU127Ig
 yJqsN5YI376mmPKMKP7thOIrqjcsGxhN5Nf5lyiYtCt/n49t4kJZeTdX/EjKRLwnieHv
 RdRPlsczATb4yjTKvf1xsWgIHm4MsmZprHBmb54Jdi8sLfwwIB4E4yOde8dwm5aRmNFq
 C0wuEQ9ZRWJJlvd3wLhXefmJ3qaYW+HHYwVZVZOKnKkS/qCEN/mwXg1qOTzIBAQtDh2W
 zLt/6TigYpt+8Dm6psq92gAVELEF097U1+/lwLYKhCogWlE/i5o+aKD7je1I0I2gTrdl
 FW6A==
X-Gm-Message-State: AOJu0Ywzzw60FY0Ydd68pjh2awDcgtQxVD3Hi6Tqmy1911N+ZgjBBGJy
 pZ2/wcLd0hEbdcrbLY+Mnv8m6lIGkN1R8T+VNUWOyT2ssQ4X/Xc/vY2NxzqZTqhhPQ7RH5kO6XR
 XQCZ+ORrqOOc0Kc7gCEaWn1lb3TrDxqfB+OWpC5Vk+hfD+QUL8gQRXiv/9ZLUn1yMYAQOOKE6N4
 G6XdXIGRo9SVrFx+0y5TV36ZD3FvgAmMtTrnGo
X-Gm-Gg: ASbGncuq5V73qio5Wm1mdID2828ZTWQT3Bim/tm93wAbBbWUd+x1vNM41d0aETlXCx1
 ZIaxuBX+a65H/gXNGdhJTP32zaUEmKpJiMfaF
X-Received: by 2002:a17:90b:3807:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2ef6955f870mr23359297a91.6.1733815993119; 
 Mon, 09 Dec 2024 23:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJzUxm6D8YLUCS6XKTQoQCX7Z5CF3j4Q1rH//dNlvAr5aF9BOdIIB/DPHL1/oSNmXMv8T/AeqjuKf+iADlDk8=
X-Received: by 2002:a17:90b:3807:b0:2ee:74a1:fb92 with SMTP id
 98e67ed59e1d1-2ef6955f870mr23359279a91.6.1733815992806; Mon, 09 Dec 2024
 23:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20241206094938.92895-1-pvorel@suse.cz>
 <20241206094938.92895-2-pvorel@suse.cz>
 <CAEemH2fC96s866abHj7mk315GBP3Y1c+uSC-NhuG7P5ia2obKA@mail.gmail.com>
 <20241209101348.GA206052@pevik>
 <CAEemH2dpExk4HqzGEkpC-oBwnc-fRVMnwy0_n4LbfbS9OoJ1oA@mail.gmail.com>
 <20241210065954.GB227882@pevik>
In-Reply-To: <20241210065954.GB227882@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Dec 2024 15:33:00 +0800
Message-ID: <CAEemH2eTJ=Cin8iTx7tn+70xg3U-1OV-POZw6sMLLjc9CUSgmw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oioYQqFEpZAelIKl9lZqVhEYLf85YaxP9mLO65VL7M0_1733815994
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] testcases/lib/run_tests.sh: Check expected
 results
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

T24gVHVlLCBEZWMgMTAsIDIwMjQgYXQgMzowMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBNb24sIERlYyA5LCAyMDI0IGF0IDY6MTTigK9QTSBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgTGksIGFsbCwKPgo+ID4gPiAu
Li4KPiA+ID4gPiBXZSBjb3VsZCBhZGQgYSBibGFuayBsaW5lIHByaW50IGhlcmUgdG8gbWFrZSB0
aGUgb3V0cHV0IGJldHRlcgo+IHJlYWRhYmxlLgo+Cj4gPiA+ID4gICBlY2hvICIiCj4KPiA+ID4g
PiArICAgICAgICAgICAgICAgZWNobyAiKioqIFJ1bm5pbmcgJyR0ZXN0JyAoZXhwOiAkKHRzdF9t
YXNrMmZsYWcKPiAkZXhwKSkKPiA+ID4gKioqIgo+Cj4gPiA+ICsxCj4KPgo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICR0ZXN0Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmM9JD8KPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICBpZiBbICRyYyA9IDEyNyBdOyB0aGVuCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBlY2hvICJUZXN0ICckdGVzdCcgbm90IGZvdW5kLCBtYXliZQo+
IG91dC1vZi10cmVlCj4gPiA+ID4gPiBidWlsZCBhbmQgdW5zZXQgYnVpbGRkaXI/IiA+JjIKPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGV4aXQgMQo+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgIGVsaWYgWyAkcmMgPSAyIC1hICRXSElURUxJU1RfR0lUSFVCID0gMSAtYQo+ID4gPiA+
ID4gIiRHSVRIVUJfQUNUSU9OUyIgXTsgdGhlbgo+Cj4KPiA+ID4gPiBJZiBvbmUgb3IgbW9yZSB2
YXJpYWJsZXMgdXNlZCBpbiB0aGUgY29uZGl0aW9uYWwgdGVzdCBhcmUKPiA+ID4gPiBlaXRoZXIg
dW5zZXQgb3IgZW1wdHksIHRoYXQgd2lsbCBsZWFkIHRvIGludmFsaWQgc3ludGF4Lgo+Cj4gPiA+
ID4gU28gSSB3b3VsZCBzdWdnZXN0IHVzaW5nIFsgLi4uIF0gYW5kICYmOgo+Cj4gPiA+ID4gICBl
bGlmIFsgJHJjID0gMiBdICYmIFsgJFdISVRFTElTVF9HSVRIVUIgPSAxIF0gJiYgWyAtbgo+ICIk
R0lUSFVCX0FDVElPTlMiCj4gPiA+ID4gXTsgdGhlbgo+Cj4gPiA+IEdvb2QgcG9pbnQuIE9yIG1h
eWJlIGp1c3QgcXVvdGU/Cj4KPiA+ID4gZWxpZiBbICIkcmMiID0gMiAtYSAiJFdISVRFTElTVF9H
SVRIVUIiID0gMSAtYSAiJEdJVEhVQl9BQ1RJT05TIiBdOwo+IHRoZW4KPgo+Cj4gPiBUaGlzIGNh
biB3b3JrLCAgYnV0IHVzaW5nIC1hIGNhbiBsZWFkIHRvIGFtYmlndW91cyBvciBoYXJkLXRvLWRp
YWdub3NlCj4gPiBiZWhhdmlvci4gQSBiZXR0ZXIgYXBwcm9hY2ggd291bGQgYmUgdG8gcmVwbGFj
ZSAtYSB3aXRoICYmLgo+Cj4gPiBNYXliZSB0aGUgYmVzdCB3YXkgaXM6Cj4KPiA+IGVsaWYgWyAi
JHJjIiA9IDIgXSAmJiBbICIkV0hJVEVMSVNUX0dJVEhVQiIgPSAxIF0gJiYgWyAtbgo+ICIkR0lU
SFVCX0FDVElPTlMiCj4gPiBdOyB0aGVuCj4KPiBUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMs
IEknbGwgdXNlIHRoaXMuCj4KPiBJIHRob3VnaHQgLWEgdGFrZXMgcHJlY2VkZW5jZSB0byAtbyBs
aWtlIGluIEMsIGkuZS4gWyBmb28gLWEgYmFyIC1vIGJheiBdCj4gaXMgdGhlCj4gZXF1aXZhbGVu
dCBvZiBbIGZvbyBdICYmIFsgYmFyIF0gfHwgYmF6Lgo+Cj4gQnV0IG5vdyBJIHNlZSBpbiBtYW4g
dGVzdCgxKToKPgo+ICAgICAgICAgQmluYXJ5IC1hIGFuZCAtbyBhcmUgYW1iaWd1b3VzLiAgVXNl
ICd0ZXN0IEVYUFIxICYmIHRlc3QgRVhQUjInIG9yCj4gJ3Rlc3QgRVhQUjEgfHwgdGVzdCBFWFBS
MicgaW5zdGVhZC4KPgo+IEkgYWxzbyB3b25kZXIgaWYgYW55IC1hIG9yIC1vIGlzIGFtYmlndW91
cy4gT3IganVzdCBjb21iaW5hdGlvbiBvZiBib3RoLgo+IEJlY2F1c2UKPiB3ZSBoYXZlIHNvbWUg
Ii1hIiBhbmQgIi1vIiB1c2FnZSBpbiB0c3RfdGVzdC5zaC4gU2hvdWxkIHdlIHRyYW5zZm9ybSB0
aGVtPwo+Cj4gICAgICAgICBpZiBbICRUU1RfQlJPSyAtZ3QgMCAtbyAkVFNUX0ZBSUwgLWd0IDAg
LW8gJFRTVF9XQVJOIC1ndCAwIF07IHRoZW4KPiAgICAgICAgICAgICAgICAgX3RzdF9jaGVja19z
ZWN1cml0eV9tb2R1bGVzCj4gICAgICAgICBmaQo+CgpVc3VhbGx5IHRoaXMgd2F5IGlzIG5vdCBy
ZWNvbW1lbmRlZCBiZWNhdXNlIGlmICRUU1RfQlJPSyBpcyB1bnNldCwKdGhpcyBiZWNvbWVzOgog
ICAgaWYgWyAtZ3QgMCAtbyAkVFNUX0ZBSUwgLWd0IDAgLi4uIF07IHRoZW4Kd2hpY2ggbGVhZHMg
dG8gYW4gaW52YWxpZCBlcnJvci4KCkJ1dCBpbiB0aGUgdHN0X3Rlc3Quc2gsIFRTVF9CUk9LIGhh
cyBiZWVuIHNldCB0byAwIGF0IHRoZSBiZWdpbm5pbmcgc28gaXQKY291bGQgYmUgd29ya2VkIGNv
cnJlY3RseSBlYWNoIG9mIHRoZSB0aW1lLiBTbyBmYXIgbm9ib2R5IGNvbXBsYWlucyB0aGVyZQpp
cyBwcm9ibGVtIHdpdGggcnVubmluZyBpdCwgc28gd2UgY2FuIGtlZXAgaXQgbm8gY2hhbmdlLgoK
Cgo+Cj4gICAgICAgICBpZiBbICIkVFNUX05FRURTX1RNUERJUiIgPSAxIC1hIC1uICIkVFNUX1RN
UERJUiIgXTsgdGhlbgo+CgpUaGlzIGlzIHNhZmVyIHRoYW4gYWJvdmUsIHF1b3RpbmcgdmFyaWFi
bGVzIHdpbGwgYmUgaGVscGZ1bC4KCgogICAgICAgICAgICAgICAgcm0gLXIgIiRUU1RfVE1QRElS
Igo+ICAgICAgICAgICAgICAgICBbICIkVFNUX1RNUERJUl9SSE9TVCIgPSAxIF0gJiYgdHN0X2Ns
ZWFudXBfcmhvc3QKPiAgICAgICAgIGZpCgoKPiAgICAgICAgIE5PVEU6IHRoaXMgb25lIEknbSBn
b2luZyB0byBjaGFuZ2UgaW4gdXBjb21pbmcgZml4IG9mIHRoZSBUQlJPSyA9Pgo+IFRXQVJOIGV2
YWx1YXRpb24KPiAgICAgICAgICMgVEJST0sgPT4gVFdBUk4gb24gY2xlYW51cCBvciBleGl0Cj4g
ICAgICAgICBpZiBbICIkcmVzIiA9IFRCUk9LIF0gJiYgWyAiJFRTVF9ET19FWElUIiA9IDEgLW8g
LXoKPiAiJFRTVF9ET19DTEVBTlVQIiAtYSAtbiAiJFRTVF9DTEVBTlVQIiBdOyB0aGVuCj4gICAg
ICAgICAgICAgICAgIHRzdF9yZXMgVFdBUk4gIiRAIgo+ICAgICAgICAgICAgICAgICBUU1RfRE9f
Q0xFQU5VUD0KPiAgICAgICAgICAgICAgICAgcmV0dXJuCj4gICAgICAgICBmaQo+Cj4gS2luZCBy
ZWdhcmRzLAo+IFBldHIKPgo+ID4gPiBLaW5kIHJlZ2FyZHMsCj4gPiA+IFBldHIKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
