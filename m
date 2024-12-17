Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF18FE7717F
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 02:41:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7033EC6CE
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 03:41:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D223EC6B6
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 03:40:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 082CA670E17
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 03:40:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734403252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5oXldeyPwT9mLB4vSo80QXgIayp3FkXPYberd92dSw=;
 b=dTNH9D+kTcMFl1hXeRxAm7t4rFb0PzuK9sS0hnxJe0N8Gp+KAYC8ioROLZ8/XsLJgExvL4
 c2dqJD1LS6gDXFF/49DZbZiHAdX7Cdlo9EWnAGphvVXnRiKFwE5PSpZ9eaDv8gQ+CdLvzd
 8zdjNWEdpur43jv95ZO7R80N0Ujb1Bo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-BU61gUKgNvijKXyLb2rOfQ-1; Mon, 16 Dec 2024 21:40:51 -0500
X-MC-Unique: BU61gUKgNvijKXyLb2rOfQ-1
X-Mimecast-MFC-AGG-ID: BU61gUKgNvijKXyLb2rOfQ
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-216717543b7so74941875ad.0
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 18:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734403249; x=1735008049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5oXldeyPwT9mLB4vSo80QXgIayp3FkXPYberd92dSw=;
 b=gCQlpSxpVlP69XfN9YLa99dx94GoH37tkR0t0JxreH++UqsSgR2bJSBHnrWjfNdC8n
 QW/8L5eNGOLuAnyHy7DDmwPm3P9IJyALetOSdz/t5RBFB/JQ9HGhDFqoqKtBe5hoDA5B
 r00H8QH7bh9rixa93CkiL2FDFsv+gL/GkMvQPPKEy+1Kn0/ZYldRA56M/DiPY9bwomYQ
 PMOIbicV1FE0N6mbG4SMC6fL4+Ty6ZQCDp5yjqR0PDuDL9ObZrGxNnnb9ZPowDEdS03p
 OY+VYyeFT/Xd5JikdymvTJQzepgI3U2SOJ/WoVvWeYuuzeMU5gR/PC049hP+rz+BgQjP
 Lu7w==
X-Gm-Message-State: AOJu0YysmXmZ9ZeOUIm2WV24r/pL3oNrXy/7RZ/xAxEpf49qJo1gHuHl
 8R5flTAA7l/x1j23LzXSY13Jaw5w4nE2rGpOzLQsioiJX/RlNH4zNsUkuQwRiEwjKCmhmdzS2tS
 4o6+/JsYlW49SezZCgUrU4XxLAuX5Uh9tdntYpbYiuAvzWqwDTl5fBZBoujuLKrJRw+EOXLRdKM
 MPQ4T73awcn+3eSyJYKt7BdLYdSH2QfTach6Bc
X-Gm-Gg: ASbGnctmvmv32Tuehl0FxIXg7PmuEDQ7ycfDZbRtfu4iWk1V+DDSuN5h8CAWUwvDcir
 kOqb6SQZ7aCFWPbrSoFMiUaIawMp35kF1Pz3czx4=
X-Received: by 2002:a17:902:c951:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-218929ce33cmr203303075ad.26.1734403249105; 
 Mon, 16 Dec 2024 18:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz65lAaUnsJf7wnX5VI5VMrAwP0ryQM+VF94dmU0f/W1J6giYalZXbRvtc+GgjuN2gm8isoNDO3WOCCnnbifg=
X-Received: by 2002:a17:902:c951:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-218929ce33cmr203302845ad.26.1734403248697; Mon, 16 Dec 2024
 18:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik>
 <CAEemH2dRjvTkvmJ1tXGq9FXbKZETjhAbe90s4-ayCzygc5jonQ@mail.gmail.com>
 <20241216122848.GA587325@pevik>
In-Reply-To: <20241216122848.GA587325@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Dec 2024 10:40:36 +0800
Message-ID: <CAEemH2dy9xdTTjHX=6UbzTX=Erydh6-etEQzZ4QF4u9DvqFZAA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pRiYq2HW_LnTydVI0G-C0mhPmVH9ZoC7STnq95YDPHc_1734403251
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

T24gTW9uLCBEZWMgMTYsIDIwMjQgYXQgODoyOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiAuLi4KPiA+ID4gPiArLyoKPiA+ID4gPiArICogTGlz
dCBvZiBrZXJuZWwgY29uZmlnIG9wdGlvbnMgdGhhdCBtYXkgZGVncmFkZSBwZXJmb3JtYW5jZSB3
aGVuCj4gPiA+IGVuYWJsZWQuCj4gPiA+ID4gKyAqLwo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IHRz
dF9rY29uZmlnX3ZhciBzbG93X2tjb25maWdzW10gPSB7Cj4gPiA+ID4gKyAgICAgVFNUX0tDT05G
SUdfSU5JVCgiQ09ORklHX1BST1ZFX0xPQ0tJTkciKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJ
R19JTklUKCJDT05GSUdfTE9DS0RFUCIpLAo+ID4gPiA+ICsgICAgIFRTVF9LQ09ORklHX0lOSVQo
IkNPTkZJR19ERUJVR19TUElOTE9DSyIpLAo+ID4gPiA+ICsgICAgIFRTVF9LQ09ORklHX0lOSVQo
IkNPTkZJR19ERUJVR19SVF9NVVRFWEVTIiksCj4gPiA+ID4gKyAgICAgVFNUX0tDT05GSUdfSU5J
VCgiQ09ORklHX0RFQlVHX01VVEVYRVMiKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19JTklU
KCJDT05GSUdfREVCVUdfUEFHRUFMTE9DIiksCj4gPiA+IERvZXMgQ09ORklHX0RFQlVHX1BBR0VB
TExPQyBpdHNlbGYgcHJvbG9uZyB0aGUgcnVuPyBJc24ndCBpdCB0aGF0IG9ubHkKPiB3aGVuCj4g
PiA+IGRlYnVnX2d1YXJkcGFnZV9taW5vcmRlcj0uLi4gb3IgZGVidWdfcGFnZWFsbG9jPS4uLiBp
cyBzZXQ/Cj4KPiA+IEdvb2QgY2F0Y2guCj4KPiA+IEkgZ3Vlc3MgdGhhdCB3b24ndCBpbXBhY3Qg
dGhlIGtlcm5lbCBwZXJmb3JtYW5jZSBpZiBub3Qgc2V0IGFueQo+ID4gb2YgdGhlIHBhcmFtZXRl
cnMsIGJlY2F1c2UgZnJvbSB0aGUgZG9jIGl0IGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQuCj4KPiA+
ICAgIldoZW4gQ09ORklHX0RFQlVHX1BBR0VBTExPQyBpcyBzZXQsIHRoaXMgcGFyYW1ldGVyCj4g
PiAgIGVuYWJsZXMgdGhlIGZlYXR1cmUgYXQgYm9vdCB0aW1lLiBJbiBkZWZhdWx0LCBpdCBpcyBk
aXNhYmxlZC4KPiA+ICAgLi4uLgo+ID4gICBpZiB3ZSBkb24ndCBlbmFibGUgaXQgYXQgYm9vdCB0
aW1lIGFuZCB0aGUgdGhlIHN5c3RlbSB3aWxsIHdvcmsKPiA+ICAgbW9zdGx5IHNhbWUgd2l0aCB0
aGUga2VybmVsIGJ1aWx0IHdpdGhvdXQgQ09ORklHX0RFQlVHX1BBR0VBTExPQy4iCj4KPiA+IFNv
IEkgd291bGQgbGlrZSB0byByZW1vdmUgQ09ORklHX0RFQlVHX1BBR0VBTExPQyBmcm9tCj4gPiB0
aGUgZGV0ZWN0aW5nLgo+Cj4gT3IgbWF5YmUgdG8gZGV0ZWN0IGlmIGRlYnVnX3BhZ2VhbGxvYyBr
ZXJuZWwgY21kbGluZSBpcyBzZXQgd2l0aAo+IHRzdF9rY21kbGluZV9wYXJzZSgpPwo+CgpPaywg
bGF0ZXIgd2UgY2FuIGRvIHRoYXQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBieSBhZGRpbmcgYSBzbG93
X3BhcmFtc1tdLgpVc2luZyBhbm90aGVyIGZ1bmN0aW9uIGxpa2UgdHN0X2hhc19zbG93X3BhcmFt
KCkgc2hvdWxkIGJlIHNpbWlsYXIgd2l0aAp0aGlzIG1ldGhvZCBqdXN0IGRldGVjdGluZyB0aGUg
c2xvdyBrY21kbGluZXMuCgoKCj4KPiBPVE9IIHdlIHJ1biB3aXRoIGRlYnVnX3BhZ2VhbGxvYz1v
biBvbmx5IHN5c2NhbGxzIGFuZCBzb21lIGxvbmcgcnVubmluZwo+IHRlc3RzCj4gKGUuZy4gYmlu
ZDA2KSBhcmUgZXZlbiBzbGlnaHRseSBmYXN0ZXIgdGhhbiB3aGVuIHJ1bm5pbmcgd2l0aG91dCBp
dC4gQnV0Cj4gdGhhdAo+IG1heSBiZSBhZmZlY3RlZCBieSBRRU1VIGhvc3QuIFRoZXJlZm9yZSBs
ZXQncyBza2lwIENPTkZJR19ERUJVR19QQUdFQUxMT0MKPiB1bnRpbAo+IEkgZmluZCBhIHRpbWUg
dG8gdGVzdCBob3cgaXQgYWZmZWN0cyB0aGUgcnVudGltZS4KPgoKVGhhbmtzLCBJIGRvbid0IHRo
aW5rIGl0J3MgaGVscGZ1bCB0byBkZXRlY3QgY29uZmlndXJhdGlvbnMgdGhhdCBhcmUgbm90CmFs
d2F5cyBlbmFibGVkLiBXZSB0eXBpY2FsbHkgdGVzdCB0aGUgZ2VuZXJhbCBvciBkZWJ1ZyBrZXJu
ZWwgaW4gdGhlCnByb2R1Y3RpdmUgZW52aXJvbm1lbnQgYnV0IGRvIG5vdCBvZnRlbiB0ZXN0IHdp
dGggc3BlY2lmaWMgZGVidWcKa2VybmVsIGNvbmZpZ3VyZXMuCgpCdXQgSSBrZWVwIGFuIG9wZW4g
bWluZCBpZiB3ZSBuZWVkIHRvIGFkZCBtb3JlIGZpbmUtZ3JhaW5lZCB0ZXN0aW5nCmNvbnRyb2xz
IGluIHRoZSBmdXR1cmUuCgoKCj4KPiA+ID4KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL3Y1LjIvYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMuaHRtbAo+Cj4gPiA+IEkgd291
bGQgbmVlZCB0byBydW4gdGhlIHRlc3Qgd2l0aCB0aGVzZSB0byBzZWUgdGhlIGRpZmZlcmVuY2Uu
Cj4KPgo+ID4gQW55IG5ldyBmb3VuZD8KPgo+IEknbSBzb3JyeSBJIGhhdmVuJ3QgdGVzdGVkIHll
dC4gRmVlbCBmcmVlIHRvIG5vdCB0byB3YWl0IGFuZCBtZXJnZS4gSSdsbAo+IHRyeSB0bwo+IGRv
IGl0IHNvb24uCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KPiA+ID4gPiArICAgICBUU1Rf
S0NPTkZJR19JTklUKCJDT05GSUdfS0FTQU4iKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19J
TklUKCJDT05GSUdfU0xVQl9SQ1VfREVCVUciKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19J
TklUKCJDT05GSUdfVFJBQ0VfSVJRRkxBR1MiKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19J
TklUKCJDT05GSUdfTEFURU5DWVRPUCIpLAo+ID4gPiA+ICsgICAgIFRTVF9LQ09ORklHX0lOSVQo
IkNPTkZJR19ERUJVR19ORVQiKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19JTklUKCJDT05G
SUdfRVhUNF9ERUJVRyIpLAo+ID4gPiA+ICsgICAgIFRTVF9LQ09ORklHX0lOSVQoIkNPTkZJR19R
VU9UQV9ERUJVRyIpLAo+ID4gPiA+ICsgICAgIFRTVF9LQ09ORklHX0lOSVQoIkNPTkZJR19GQVVM
VF9JTkpFQ1RJT04iKSwKPiA+ID4gPiArICAgICBUU1RfS0NPTkZJR19JTklUKCJDT05GSUdfREVC
VUdfT0JKRUNUUyIpCj4gPiA+ID4gK307Cj4gPiA+ID4gKwo+ID4gPiA+ICtpbnQgdHN0X2hhc19z
bG93X2tjb25maWcodm9pZCkKPiA+ID4gPiArewo+ID4gPiA+ICsgICAgIHVuc2lnbmVkIGludCBp
Owo+ID4gPiA+ICsKPiA+ID4gPiArICAgICB0c3Rfa2NvbmZpZ19yZWFkKHNsb3dfa2NvbmZpZ3Ms
IEFSUkFZX1NJWkUoc2xvd19rY29uZmlncykpOwo+ID4gPiA+ICsKPiA+ID4gTWF5YmUgaGVyZSBU
SU5GTyBtZXNzYWdlICJjaGVja2luZyBmb3Igb3B0aW9ucyB3aGljaCBzbG93IHRoZQo+IGV4ZWN1
dGlvbj8KPiA+ID4gT3IgcHJpbnQgaXQgKG9uY2UpIG9ubHkgaWYgb3B0aW9uIGRldGVjdGVkPyBC
ZWNhdXNlIGl0J3Mgbm90IG9idmlvdXMKPiB3aHkKPiA+ID4gd2UgYXJlCj4gPiA+IGRldGVjdGlu
ZyBpdC4gT3IgYWZ0ZXIgc2VhcmNoaW5nIHByaW50IHdoYXQgd2UgZGlkICg0eCBwcm9sb25nZWQK
PiBydW50aW1lKS4KPgo+Cj4gPiBBZ3JlZSwgdGhlIHJlc3QgY29tbWVudHMgYWxsIGxvb2sgZ29v
ZC4KPgo+ICsxCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
