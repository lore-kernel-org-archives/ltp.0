Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1483C4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 09:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EE8C3CE2A2
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:45:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018033C2969
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:45:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39A4D687237
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 10:44:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699263898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FJXWR3yERgM5dhISWwSUvJtceb34pqfL1TLNnykmVss=;
 b=Ngrxftk3JM9dyaX2sIvrnNAQ/19piHy3nQIfUERZfjfNv2gSCEwv7DtSLfxh6llJaxyECp
 6yEyJocFvPq1qxHgn0W9BAkslUJJavSCL8Yp1gFMw/NxrX1cDeBAtBT4xPfDYpWtr+UHTZ
 6PBaS7nmvTexT4/uZZoS5CDnoTvBqWs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-wtDik-FTPUWpbLjPOhmdvw-1; Mon, 06 Nov 2023 04:44:56 -0500
X-MC-Unique: wtDik-FTPUWpbLjPOhmdvw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5094490b607so4350170e87.0
 for <ltp@lists.linux.it>; Mon, 06 Nov 2023 01:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699263894; x=1699868694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJXWR3yERgM5dhISWwSUvJtceb34pqfL1TLNnykmVss=;
 b=bzsvPpbOAu0aXafrtDfToDPUu4mlnVsCQGUBuR67GL0iuyblBrqgZdE/h/k/tFtiNb
 U5B9x8DlodCIzDsotrS7Dh7ry1FwXYLV5AplgPjaJAQ7T3SZ3+gaHweqW3GgrlfeoaeB
 nGhOIVubJgne4W5FYE2KJNXOUzEyUjxbjoZkkvejRq1uygNlGcP7YeGMbgR0RL9hPomH
 NQmWsrCbqm7MVNnXZCceI99viQCwAXFafTtqrUmHJgb9uDI9qNywSqDa/pcycTwfje7v
 5k4T/4jkXp1dekmmy5OyK73iKTxlpuu8BdEzfx8dz6vF6lp4iRVMGus7qX+aq55B3fI9
 cjmg==
X-Gm-Message-State: AOJu0YyM3ph0J1AjPy+TKE3uwEMhkFZhk6EqydjpdfkKPM3nb7Ywqha1
 4Nkk+K5Ca1U+nB4gl5AML2UrpmDGzqgO4tdsRrTnJXybsCWBnDgkZXrCYf+yPwOSz5SJMojVIsi
 v0000NpcIy9FKQs66QoJvU9D5qaE=
X-Received: by 2002:ac2:44da:0:b0:507:a1df:1408 with SMTP id
 d26-20020ac244da000000b00507a1df1408mr19514168lfm.55.1699263894654; 
 Mon, 06 Nov 2023 01:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkPWB8Wv0nyRX0K1RP/eYk0UZW+rnSResHfVlEuex5OKN0MWKV6KxD84EGQcyRFkkbfSE/YKQYAEHtHRm/2yU=
X-Received: by 2002:ac2:44da:0:b0:507:a1df:1408 with SMTP id
 d26-20020ac244da000000b00507a1df1408mr19514160lfm.55.1699263894262; Mon, 06
 Nov 2023 01:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
 <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
 <20231103091439.GA1026385@pevik>
In-Reply-To: <20231103091439.GA1026385@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Nov 2023 17:44:42 +0800
Message-ID: <CAEemH2ewUHBC17LL+4OXd8AZqciGrRqo4Ty+Hik2KcXP+t4fNA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIEZyaSwgTm92IDMsIDIwMjMgYXQgNToxNOKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSBQZXRyLAo+Cj4gPiBPbiBUaHUsIE5vdiAyLCAy
MDIzIGF0IDU6MjHigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+
ID4gSGkgTGksCj4KPiA+ID4gPiBUaGlzIGlzIGJhc2Ugb24gUGV0ZXIncyBwYXRjaDoKPiA+ID4g
PiAgIENJOiBSZUFwbGFjZSBDZW50T1MgNyB3aXRoIG9wZW5TVVNFIExlYXAgNDIuMiwgVWJ1bnR1
IHhlbmlhbAo+Cj4gPiA+ID4gQ2k6IGh0dHBzOi8vZ2l0aHViLmNvbS93YW5nbGk1NjY1L2x0cC9h
Y3Rpb25zL3J1bnMvNjcyOTM3OTU2NQo+Cj4gPiA+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPgo+Cj4gPiBUaGFua3MhCj4KPgo+ID4gPiBBVE0gd2UgaGF2ZSAxOCBq
b2JzLCBJTUhPIHdlIHNob3VsZCBub3QgYWRkIG1vcmUgd2l0aG91dCByZW1vdmluZwo+IG90aGVy
cwo+ID4gPiBqdXN0IHRvCj4gPiA+IGhhdmUgcmVhc29uYWJsZSBDSSBydW50aW1lLgo+Cj4KPiA+
IFlvdXIgY29uY2VybiBtYWtlcyBzZW5zZSwgYnV0IEkgaGF2ZSBubyBpZGVhIHdoaWNoIG9uZSBj
b3VsZCBiZSByZW1vdmVkLgo+Cj4gSSB3b25kZXIgaWYganVzdCBhZGRpbmcgQ2VudE9TIDkgd291
bGQgYmUgZW5vdWdoLiBCZWNhdXNlIGluIENJIHdlIHRlc3QKPiBqdXN0Cj4gY29tcGlsYXRpb24u
IFRoZSBwb2ludCBvZiB0aGUgcHVibGljIENJIGlzIHRvIHRlc3QgdGhlIG9sZGVzdCBkaXN0cm9z
LAo+IG5ld2VzdAo+IGRpc3Ryb3MgYW5kIHNvbWV0aGluZyBpbiBiZXR3ZWVuLCB0aGF0IHNob3Vs
ZCBjb3ZlciB0aGUgbW9zdCBvZiBjb21waWxhdGlvbgo+IHByb2JsZW1zIChubyBuZWVkIHRvIHRl
c3QgKmFsbCogdXNlZCBkaXN0cm9zIHRvIGJlIHNhZmUpLgo+IEJ1dCBzdXJlLCBib3RoIGNhbiBz
dGF5IGlmIHlvdSB3YW50LiBUaGUgcnVudGltZSBpcyBzdGlsbCByZWFzb25hYmxlLgo+IE5PVEU6
IEkgZGlkIG5vdCBjYXJlIG11Y2ggaW4gY2FzZSBvZiBpcHV0aWxzLCB3aGljaCBoYXZlIG11Y2gg
ZmFzdGVyIGJ1aWxkCj4gdGhhbgo+IExUUC4KPgo+IElmIHdlIHdhbnQgdG8gYWRkIGJvdGggQ2Vu
dE9TIDggYW5kIDksIHdlIGNvdWxkIHJlbW92ZSBzb21lIG9mCj4gZGViaWFuOm9sZHN0YWJsZSAo
YnVsbHNleWUpCj4gKHNpbWlsYXIga2VybmVsKS4KPgo+IEFuZCwgd2UgY291bGQgYWRkIGp1c3Qg
b3BlblNVU0UgTGVhcCA0Mi4yLCB3aGljaCBoYXMgb2xkZXIgZ2xpYmMgYW5kIGdjYwo+IHRoYW4K
PiBVYnVudHUgMTYuMDQgTFRTIHhlbmlhbC4gRm9yIHN1cmUgdGhlcmUgYXJlIG1vcmUgcGVvcGxl
IHdoaWNoIHVzZSB4ZW5pYWwKPiB0aGFuCj4gb2xkIExlYXAgNDIuMiwgYnV0IGFzIEkgc2FpZCwg
dGhlIGdvYWwgaXMgdG8gdGVzdCB0aGUgb2xkZXN0IGRpc3RybyB3ZQo+IG1haW50YWluZXJzIHJl
YWxseSBjYXJlIGFib3V0IChhbmQgZG8gbm90IGhhdmUgZXh0cmEgd29yayBmb3Igbm90aGluZywK
PiB3aGljaCBpcwo+IElNSE8ga2VlcGluZyBDZW50T1MgNyBjb21waWxhYmxlKS4KPgo+IFdEWVQ/
Cj4KCllvdXIgZXhwbGFuYXRpb24gaXMgcXVpdGUgdXNlZnVsLCB0aGFua3MhCgpJJ20gZmluZSB0
byByZW1vdmUgdGhlIENlbnRPUzggYnVpbGQgaW4gdGhpcyBwYXRjaCwKc2hvdWxkIEkgcmVzZW50
IHRoZSBuZXcgcGF0Y2ggb3IgcHVzaCBpdCBkaXJlY3RseT8KCgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
