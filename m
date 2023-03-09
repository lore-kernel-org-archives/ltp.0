Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FCEC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 13:00:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49FE23CD8BE
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 14:00:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D62F3CB7F8
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 14:00:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 25C571A010FD
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 14:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678366832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SVwYGbrsRrZ83ll76djaG/M/xiVEFbI1ma06921BmZY=;
 b=Sn0hA8KsdDLVYAWJQysZdTczbC8LY7uRiuZhtLSDIS3CgWbXTXN3Rie04k7gxg0z0Bv9Ln
 vrfj2mjt8QQiCZT3dDWd0WZmaKdt19qCliXRMdQgfqg2ydT9iHhRvfXKFPSxmFToGicq68
 +YBQOAAjRrBcAPoRyt1vl8/y57FoFpg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-O7HdP0fiOBmlA7pdTbivfw-1; Thu, 09 Mar 2023 08:00:27 -0500
X-MC-Unique: O7HdP0fiOBmlA7pdTbivfw-1
Received: by mail-wm1-f71.google.com with SMTP id
 az12-20020a05600c600c00b003e8910ec2fdso626896wmb.6
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 05:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678366826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wK6pDNWnl7LiX0+WdC+kJXY4oXJCTfHk+CYeVbTBdC4=;
 b=k2dMYLyuF46WQr+9ibO/18rq/3wiI8Ecm5B6ta2RPyHi7NQ2cb7gj2U+ZiaYKfeOTt
 Hmv/ogyUkyNkyzKnlfbLwuCsWmU3wspWy46B1fzk53pX03IF7FBk3UhPa0F7E8f3oez8
 jtQIt95ooDeS7pKepOeY6eKn0tTh+a7zrVq6sQXg5ZI16nfCj0BkIImSbOXHKLwIfsMq
 rQTDjHZevAqvRWMk3KirxhYpP8CTkJekcHoV2D57YElSAsdAj/hwWnHerj1gv1WKNZDd
 wKDnADZYb5W30adMiLfj4nwXD4yyZQIkZXfe177skrQXzMKRczgPG+bSa3TL6GFhfN9G
 jBIw==
X-Gm-Message-State: AO0yUKUh3e4bcZ33yT1P7xCQvcnvE5FkzNKGc70JAJEL4nKenl8otAlo
 gj7joMrGutI8fODvanedNRu3I0KE3rwlrpNWdFL50QPgseS8pqwZfTTAXd/Qc6e2PQyB8zpbGjT
 zCntBzHioDnpdcnRHmDpnMJEFF4k=
X-Received: by 2002:adf:f88f:0:b0:2cb:8616:d3dd with SMTP id
 u15-20020adff88f000000b002cb8616d3ddmr4822388wrp.7.1678366826561; 
 Thu, 09 Mar 2023 05:00:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/22pK97A0nOMRAlvgQ7RVcduiT5CaWp8GrcfjcRx3iTso8EtCds2RnP2nJsZ64qLS+SJGtPDrUFzO9QtsFB70=
X-Received: by 2002:adf:f88f:0:b0:2cb:8616:d3dd with SMTP id
 u15-20020adff88f000000b002cb8616d3ddmr4822383wrp.7.1678366826198; Thu, 09 Mar
 2023 05:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
In-Reply-To: <Y/yTyk9rYYsPJyVA@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Mar 2023 21:00:14 +0800
Message-ID: <CAEemH2fQBbLnBS6_S4-jj4J7cRVFZLCaPzvxe0Aq6UN37QxUog@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgNzoyNuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBDb21taXQgYjg1N2Y4NzIzZjMwYTRiOTU1NGJmNmIw
ZmY4ZmE1MmZkMDdlOGI2MCB0cmllZCB0byBmaXggYnVpbGQgd2l0aAo+ID4gbGF0ZXN0IGdsaWJj
IHdoaWNoIHByb3ZpZGVzIG1vdW50X2F0dHIgaW4gc3lzL21vdW50LmguIFVuZm9ydHVuYXRlbHks
Cj4gPiB0aGUgZm9sbG93aW5nIGJ1aWxkIGZhaWx1cmUgaXMgc3RpbGwgcmFpc2VkIGJlY2F1c2Ug
c3lzL21vdW50IGlzIG5vdwo+ID4gdW5jb25kaXRpb25hbGx5IGluY2x1ZGVkIGluIGluY2x1ZGUv
bGFwaS9mc21vdW50Lmg6Cj4gPgo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGZzY29uZmlnMDEu
Yzo5Ogo+ID4gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDo1NTo4OiBlcnJvcjog
cmVkZWZpbml0aW9uIG9mICdzdHJ1Y3QKPiBtb3VudF9hdHRyJwo+ID4gICAgNTUgfCBzdHJ1Y3Qg
bW91bnRfYXR0ciB7Cj4gPiAgICAgICB8ICAgICAgICBefn5+fn5+fn5+Cj4gPiBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDoxNDoKPiA+Cj4g
L2hvbWUvYXV0b2J1aWxkL2F1dG9idWlsZC9pbnN0YW5jZS00L291dHB1dC0xL2hvc3QvYXJtZWIt
YnVpbGRyb290LWxpbnV4LWdudWVhYmkvc3lzcm9vdC91c3IvaW5jbHVkZS9zeXMvbW91bnQuaDoy
MTA6ODoKPiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQo+ID4gICAyMTAgfCBzdHJ1Y3Qg
bW91bnRfYXR0cgo+ID4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+ID4KPiA+IEZpeGVzOgo+
ID4gIC0KPiBodHRwOi8vYXV0b2J1aWxkLmJ1aWxkcm9vdC5vcmcvcmVzdWx0cy80ZGJiNzJlMWJm
MDgxYWZkM2NkOTQ0NTcxYjliZWVlZmM3NjA4ODY1Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRmFi
cmljZSBGb250YWluZSA8Zm9udGFpbmUuZmFicmljZUBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBj
b25maWd1cmUuYWMgfCA2ICsrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2Nv
bmZpZ3VyZS5hYwo+ID4gaW5kZXggYzJiMGY0OGU3Li5hNmQ4YWM4MjYgMTAwNjQ0Cj4gPiAtLS0g
YS9jb25maWd1cmUuYWMKPiA+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+ID4gQEAgLTIyNSwxMCArMjI1
LDEwIEBAIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgX19rZXJuZWxfb2xkX3RpbWV2YWwsCj4gc3Ry
dWN0IF9fa2VybmVsX29sZF90aW1lc3BlYywgc3RydWMKPiA+Cj4gPiAgQUNfQ0hFQ0tfVFlQRVMo
W3N0cnVjdCBmdXRleF93YWl0dl0sLCxbI2luY2x1ZGUgPGxpbnV4L2Z1dGV4Lmg+XSkKPiA+ICBB
Q19DSEVDS19UWVBFUyhbc3RydWN0IG1vdW50X2F0dHJdLCwsWwo+ID4gLSNpZmRlZiBIQVZFX0xJ
TlVYX01PVU5UX0gKPiA+IC0jIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+Cj4gPiAtI2Vsc2UKPiA+
ICsjaWZkZWYgSEFWRV9NT1VOVF9TRVRBVFRSCj4gPiAgIyBpbmNsdWRlIDxzeXMvbW91bnQuaD4K
PiA+ICsjZWxpZiBIQVZFX0xJTlVYX01PVU5UX0gKPiA+ICsjIGluY2x1ZGUgPGxpbnV4L21vdW50
Lmg+Cj4gPiAgI2VuZGlmCj4gPiAgXSkKPgo+IEkgd29uZGVyIGlmIHdlIGNhbiBnZXQgdGhpcyB3
aG9sZSBtZXNzIG9mIHR3byBkaWZmZXJlbnQgZmFsbGJhY2sgaGVhZGVycwo+IHNpbXBsaWZpZWQu
IExvb2tpbmcgYXQgdGhlIGdsaWJjIGltcGxlbWVudGF0aW9uIGl0IHNlZW1zIHRvIGluY2x1ZGUK
PiAibGludXgvbW91bnQuaCIgaWYgaXQgZG9lcyBleGlzdC4gU28gbW9zdCByZWFzb25hYmxlIHNv
bHV0aW9uIHdvdWxkIGRvCj4gdGhlIHNhbWUgSSBndWVzcyB3aGljaCB3ZSBkaWQgYmVmb3JlIHRo
ZSBjb21taXQgeW91IHJlZmVyZW5jZS4KPgo+IEBMaSBXYW5nIHdoZXJlIGRvZXMgdGhlIHRoZSBz
eXMvbW91bnQuaCBhbmQgbGludXgvbW91bnQuaCBjb25mbGljdD8gQXMKPgoKSSByZW1lbWJlciBp
biB0aGUgbmV3ZXIgR2xpYmMgdGhhdCBhZGRlZCBuZXcgZGVmaW5pdGlvbnMKKGUuZy4gbW91bnRf
c2V0YXR0ciwgZnNvcGVuKSBzdXBwb3J0IGluIHN5cy9tb3VudC5oIHdoaWNoCmNvbmZsaWN0IHdp
dGggbGludXgvbW91bnQuaC4KClRoYXQncyB0aGUgcmVhc29uIEkgc3VibWl0IHRoZSBwYXRjaCB0
byByZXNvbHZlIGl0IGZvciBzb21lCm1pZGRsZSB2ZXJzaW9uIG9mIEdsaWJjIGV4aXN0cyB0aGUg
cHJvYmxlbS4KCkJ1dCB0aGF0IHByb2JsZW0gbGF0ZXIgcmVzb2x2ZXMgaW4gR2xpYmMgYXMgd2Vs
bCBieToKaHR0cHM6Ly9naXRodWIuY29tL2tyYWovZ2xpYmMvY29tbWl0Lzc3NDA1OGQ3Mjk0MjI0
OWY3MWQ3NGU3ZjJiNjM5Zjc3MTg0MTYwYTYKCgpDaGVjayBteSBGZWRvcmEzNzoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCgokIHJwbSAtcWYgL3Vzci9pbmNsdWRlL3N5cy9tb3VudC5oCmds
aWJjLWhlYWRlcnMteDg2LTIuMzQtNDkuZmMzNS5ub2FyY2gKCiQgZ3JlcCBtb3VudF9hdHRyICAv
dXNyL2luY2x1ZGUvc3lzL21vdW50LmgKI2RlZmluZSBNT1VOVF9BVFRSX0lETUFQICAgICAgICAw
eDAwMTAwMDAwIC8qIElkbWFwIG1vdW50IHRvIEB1c2VybnNfZmQgaW4Kc3RydWN0IG1vdW50X2F0
dHIuICAqLwpzdHJ1Y3QgbW91bnRfYXR0cgogc3RydWN0IG1vdW50X2F0dHIgKl9fdWF0dHIsIHNp
emVfdCBfX3VzaXplKQoKJCBycG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9tb3VudC5oCmtlcm5l
bC1oZWFkZXJzLTYuMS41LTIwMC5mYzM3Lng4Nl82NAoKJCBncmVwIG1vdW50X2F0dHIgIC91c3Iv
aW5jbHVkZS9saW51eC9tb3VudC5oCiNkZWZpbmUgTU9VTlRfQVRUUl9JRE1BUCAweDAwMTAwMDAw
IC8qIElkbWFwIG1vdW50IHRvIEB1c2VybnNfZmQgaW4gc3RydWN0Cm1vdW50X2F0dHIuICovCnN0
cnVjdCBtb3VudF9hdHRyIHsKLyogTGlzdCBvZiBhbGwgbW91bnRfYXR0ciB2ZXJzaW9ucy4gKi8K
CgpmYXIgYXMgSSBjYW4gdGVsbCB0aGUgVUFQSSBsaW51eC9tb3VudC5oIG5ldmVyIGRlZmluZWQg
YW55IGZ1bmN0aW9ucywKPiBqdXN0IGNvbnN0YW50cywgd2hpY2ggc2hvdWxkIGJlIHNvbHZhYmxl
IHdpdGhvdXQgdGhlIGNvbXBsZXggaWZkZWZzLCB3ZQo+IGp1c3QgbmVlZCB0byBjaGVjayBmb3Ig
ZXhpc3RlbmNlIG9mIHRoZSB0eXBlcyBhbmQgZGVmaW5lIHRoZW0gb25seSBpZgo+IG1pc3Npbmcu
Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4gLS0KPiBNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
