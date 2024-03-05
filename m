Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D85EC54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 04:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709611344; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7QpHNJdBUEWhUsqD4iJ+Kzesyz3MKdo+MyAFBe+oIks=;
 b=bw0ai0wUu9BaC54enFmwCav6UlDv0eLbWzz8U5tSfxkjjysRLBEKq9h/90Y4LXk/apHjN
 JHrtLqj9YQdNjM2XnVdSfqq4Es2bqCE2qqQj0m7iZjMTqwF9FGOmPB/XijAJRZo9PLtcho1
 55g/cbgfby9BRUi5Uh2YCYqmkYyYxuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29BA23D0D19
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 05:02:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 979B43CE0C2
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 05:01:59 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6630114002C4
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 05:01:58 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e2774bdc7so2943415f8f.0
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709611318; x=1710216118; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cc5PKKxgJ/tSSEYN6wSL7cK6OySLzFlWpVP60OpXRBY=;
 b=G7LxIDGw01AfQvhYRxwPOY0vAIUQRLn8uC3RTRKlytyG43coo4TJk0JO0HvD6X7lQf
 SpeLVg2SThPbhoTfzTKgsIkb5zjRQFfUnEbYTiXGsvLsqaECxux/RNG9Tx9oYB4Wn7Kw
 v83ojuX/71PYFmk0ztaCwGYlclawHo3jtOt3BGvLrXCujhob6fPiXYpKbySl+Wfp69c0
 oaLcBeXs/M/s7IvaQgbuD4XZAdiMMhzDRbtDYLt8pX/3+Tt9wdI9HFi+cHBWXyDXvpe5
 3Cbap0DRaoY+a86Ht67ZyIL9quif0izBO/CjZbcocWcc6v1tatMZB7w6k6k4kWm4Eihe
 FB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709611318; x=1710216118;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cc5PKKxgJ/tSSEYN6wSL7cK6OySLzFlWpVP60OpXRBY=;
 b=aKOqMkzAHzkh3eTPlb88/Esnnauwb1vYfO0FMfBdGdm1XTKWqkIWrYUkXR3lWPDWaa
 0BinLJfWLhOENjgNQJpXS1x1Ja8W7XMNC3To3nJ0jtAQTOQ4H9YtN9uWSMqKae0aJmUq
 ZqIoKQlZ43ZJj4rGROK1ZITJR6Ra3u4vQvJNjIoPTS+aAJ2EnfNf8apypfJ35BSt4NmL
 g4U+F4H98s3buZn5po3sy/DFn95afPHiyO88oZWSrnrVkoi7lBBLqmnL+U5Qcvucl1gw
 lu5PLusj/QO1cj9FZA6007//TwpmdQYKcdFhA8whAbwkd704KpZOkRBlxov9aL5x+aHn
 9ESA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3vbgMW7NeAALNFDT3ZskH+JbF/riejXfL+vjTxJ1IE4/zSUcL3wgF4KZ06GLQnhg/xKTzE6qhaDp0WaNf7voavgo=
X-Gm-Message-State: AOJu0Yw3YZNawxxM4AT19Nsh5N0iGJ47SGlJkM/5+tZYbb6nWCBK0WnY
 wT+4ouz7V2Uw+rBYkcIy9A4frvAbXROzOwm5q07gtAiftFPDWwe91DJUMDCD6g==
X-Google-Smtp-Source: AGHT+IFvwGlh/lpdk6eWNZEKaKugLiZ2WiNKUmqGilrWe8wiYg+0GOm300swi/gtt/jdSKO+k/7lkg==
X-Received: by 2002:a5d:6906:0:b0:33e:4c34:cba9 with SMTP id
 t6-20020a5d6906000000b0033e4c34cba9mr9373wru.50.1709611317670; 
 Mon, 04 Mar 2024 20:01:57 -0800 (PST)
Received: from wegao.81.247.47 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 bp3-20020a5d5a83000000b0033e431950c5sm3117149wrb.97.2024.03.04.20.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 20:01:57 -0800 (PST)
Date: Mon, 4 Mar 2024 23:01:50 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <ZeaZLq4tsazFvxuW@wegao.81.247.47>
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
 <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
 <c7f1510a-adf5-49b8-9f0e-45ad259be38d@fujitsu.com>
 <CAEemH2e1yeu9yL2CbW3z0rVov67Oty_em0HmTrj86SUe0wMATw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e1yeu9yL2CbW3z0rVov67Oty_em0HmTrj86SUe0wMATw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMDQsIDIwMjQgYXQgMDY6MDQ6MDhQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBNb24sIE1hciA0LCAyMDI0IGF0IDU6MTnigK9QTSBZYW5nIFh1IChGdWppdHN1KSA8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4KPiB3cm90ZToKPiAKPiA+IEhpICBMae+8jAo+ID4KPiA+
ID4KPiA+ID4KPiA+ID4gT24gU3VuLCBNYXIgMywgMjAyNCBhdCA5OjE04oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3oKPiA+ID4gPG1haWx0bzpwdm9yZWxAc3VzZS5jej4+IHdyb3RlOgo+
ID4gPgo+ID4gPiAgICAgSGkgV2VpLCBYdSwKPiA+ID4KPiA+ID4gICAgICA+IEhpICBXZWkKPiA+
ID4KPiA+ID4gICAgICA+ID4gSSBlbmNvdW50ZXIgYSBkZWFkIGxvb3Agb24gZm9sbG93aW5nIGNv
ZGUgaW4gb3VyIHRlc3Qgb24gcHBjNjQKPiA+ID4gICAgIG1hY2hpbmU6Cj4gPiA+ICAgICAgPiA+
IHdoaWxlICgoYyA9IGZnZXRjKGZwKSkgIT0gRU9GKQo+ID4gPgo+ID4gPiAgICAgID4gPiBJIHRo
aW5rICIvcHJvYy9zd2FwcyIgaXMgbm90IG5vcm1hbCBmaWxlIGFuZCBjYW4gbm90IGdldCBFT0Yg
aW4KPiA+ID4gICAgIHNvbWUgc2l0dWF0aW9uLAo+ID4gPiAgICAgID4gPiBzbyBpIHVzZSBmZ2V0
cyBhIGxpbmUgYW5kIGNhY3VsYXRlIHN3YXAgZGV2IG51bWJlci4KPiA+ID4KPiA+ID4gICAgIEkg
Z3Vlc3MgdGhlIHByb2JsZW0gaGFzIGJlZW4gZml4ZWQgYnkgYW5vdGhlciBwYXRjaCBbMV0sIHRo
dXMKPiA+ID4gICAgIGNsb3NpbmcgaXQgaW4KPiA+ID4gICAgIHBhdGNod29yay4gUGxlYXNlIGxl
dCBtZSBrbm93IGlmIG5vdC4KPiA+ID4KPiA+ID4KPiA+ID4gU2VlbXMgbm90LCB0aGUgcGF0Y2gg
WzFdIGJlbG93IGlzIG1haW5seSB0byBjb3VudCB0aGUgZnJlZSBkaXNrIHNpemUuCj4gPiA+Cj4g
PiA+IEJ1dCBXZWkncyB3b3JrIGhlcmUgaXMgdG8gY2FsY3VsYXRlIHN3YXAtZGV2IG51bWJlcnMg
Y29ycmVjdGx5Cj4gPiA+IChlc3BlY2lhbGx5IGdldCByaWQgb2YgRU9GIGFmZmVjdGlvbiB0byBz
b21lIGRlZ3JlZSkuCj4gPiA+Cj4gPiA+IFh1IFlhbmcsIHdoYXQgZG8geW91IHRoaW5rPyBvciBk
aWQgSSBtaXNzIGFueXRoaW5nIGhlcmU/Cj4gPiA+Cj4gPiA+Cj4gPgo+ID4gSSBzdGlsbCB0aGlu
ayB3ZSBjYW4gdXNlIHRoZSBzYW1lIHdheSBpbiBpcGMgbGlicyB0byBnZXQgcmlkIG9mIHRoZSBF
T0YKPiA+IHByb2JsZW0gaW5zdGVhZCBvZgo+ID4gc2VhcmNoaW5nICJkZXYiIGtleXdvcmQuIFdl
IGp1c3QgZG9uJ3QgbmVlZCB0byAgY2FsY3VhbHRlICIvcHJvYy9zd2FwcyIKPiA+IGhlYWRlci4K
PiA+Cj4gCj4gU291bmRzIGdvb2QgdG8gbWUuIEF0IGxlYXN0IGl0IGNvdW50cyByaWdodCBsaW5l
cy4KPiAKPiBJdCdkIGJlIGdyZWF0IHRvIGhhdmUgYSBwYXRjaCBieSB0aGF0IHdheS4KPiAKPiAK
PiAKPiA+Cj4gPiBpbnQgZ2V0X3VzZWRfc3lzdmlwYyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLCBjb25zdCBjaGFyCj4gPiAqc3lzdmlwY19maWxlKQo+ID4gewo+ID4gICAgICAg
ICBGSUxFICpmcDsKPiA+ICAgICAgICAgaW50IHVzZWQgPSAtMTsKPiA+ICAgICAgICAgY2hhciBi
dWZbQlVGU0laRV07Cj4gPgo+ID4gICAgICAgICBmcCA9IHNhZmVfZm9wZW4oZmlsZSwgbGluZW5v
LCBOVUxMLCBzeXN2aXBjX2ZpbGUsICJyIik7Cj4gPgo+ID4gICAgICAgICB3aGlsZSAoZmdldHMo
YnVmLCBCVUZTSVpFLCBmcCkgIT0gTlVMTCkKPiA+ICAgICAgICAgICAgICAgICB1c2VkKys7Cj4g
Pgo+ID4gICAgICAgICBmY2xvc2UoZnApOwo+ID4KPiA+ICAgICAgICAgaWYgKHVzZWQgPCAwKSB7
Cj4gPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgImNhbid0IHJlYWQgJXMgdG8gZ2V0
IHVzZWQgc3lzdmlwYyByZXNvdXJjZQo+ID4gdG90YWwgYXQgIgo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIiVzOiVkIiwgc3lzdmlwY19maWxlLCBmaWxlLCBsaW5lbm8pOwo+ID4gICAgICAg
ICB9Cj4gPgo+ID4gICAgICAgICByZXR1cm4gdXNlZDsKPiA+IH0KPiA+Cj4gPiBCdXQgd2UgZG9u
J3QgZ2V0IHRoZSBhY3R1YWwgcmVhc29uLCBJIHN0aWxsIHdvbmRlciB3aHkgdGhpcyBkZWFkbG9v
cAo+ID4gZXhpc3RzIG8gcHBjYzY0IGluc3RlYWQgb2YKPiA+IG90aGVyIGFyY2hpdGVjdHVyZShp
ZSB4ODZfNjQpLgo+ID4KPiAKPiBPaywgSSB0aGluayB3ZSBjYW4ganVzdCBhcHBseSB5b3VyIHN1
Z2dlc3RlZCBtZXRob2QgdG8gc2VlIGlmIHRoYXQgZGVhZGxvb3AKPiBkaXNhcHBlYXJzLgo+IApI
aSBQZXRyLCBYdSwgTGkgCkRlYWRsb29wIHdpbGwgZGlzYXBwZWFyIGlmIHlvdSB1c2UgZmdldHMs
IGZnZXRjIGNhbiBub3QgZ2V0IEVPRiBvbiBwcGM2NC4oU3VzcGVjdCBhbiBidWcpClNvIGVpdGhl
ciB1c2UgbXkgcGF0Y2ggb3IgWHUncyBzdWdnZXN0aW9uIGJvdGggY2FuIHdvcmsuCgo+IAo+IAo+
IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+IAo+IC0tIAo+IE1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
