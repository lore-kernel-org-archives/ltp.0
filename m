Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E109CE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 06:53:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D62C3C1C38
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 07:53:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0435D3C1C38
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:53:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20E86101B14E
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736405610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDdtH7vsaLzAGDUxcl1OPlVYKEUqSepN8YOZpjlRDfc=;
 b=UwUxvZ2cLjhrn15t5Rfxh9hF2P1wCufPecI4pNkUkR73P8gkgR7C+gpzYOgzAXECEPdXrt
 sLCoFu52M30DwABFohFkhPYZr0qaBHJ+mwBPr8iwxFkIBgTFu71VEYIG5ObRM88o3L0wWr
 w1WDqngwzYoVPv96aOUa8spn2mHOP6Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494--uy07MscNE2vq7Dq1EhkRA-1; Thu, 09 Jan 2025 01:53:26 -0500
X-MC-Unique: -uy07MscNE2vq7Dq1EhkRA-1
X-Mimecast-MFC-AGG-ID: -uy07MscNE2vq7Dq1EhkRA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so53384766b.0
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 22:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736405605; x=1737010405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDdtH7vsaLzAGDUxcl1OPlVYKEUqSepN8YOZpjlRDfc=;
 b=ONSMgxSZlMEQ/unCAuRIQjX7ymqg058rLfjxNYZ4K+mpHHIB+/O11T+x+FmiF/XEzY
 sc/gv0SSiKcwMOv3Rm7AhBeZ6Ez4GuaSGewOliT7hm5HqJnrVm5poTAd6PSnmQBipbg6
 Pnxu19f3mICjqiwx8zVBG2w9kXSvtlk6t2m6BZ6dved4Fh3pnnsVtajFJaFEWr4K8PcG
 fw6pguTmZv0DitDrO9TcR5vk138j04a86oHxeDVNmEqUX9cmYN29xozMsJoEMTOVsvCm
 6VzXkZ4zATqm2BLRw85D9jAlaHmkFgmDKeEeVJCQgGSWeDcdfagddOlUDsZfoiSk+r7F
 Q3EQ==
X-Gm-Message-State: AOJu0YymyigEi3/mO1sa34kfevoRV5XAuOsBWNIIu+d6rOqqvhowUxNW
 BDBJd07durlsMpVO1V7dqx55QYUd/r8i0bE3Mxh/31zBGGe5y6KokJnfyQDWsN2CAL3zl7dlVYd
 oFlC1nz2a4XZjzlB+2qM4c2e6pjbR1FQRWpJfGW+M7suK1fhaDhP5RV0rbblqzulNgvbSimYktl
 T0MidH4K3/fNse4zD6cxhF0Vw=
X-Gm-Gg: ASbGnctVt+zbL23k8bibwWT2Ghi0892XpPLUQTMRkJz/5SCq//R39N0t/iHklSI7zk6
 UFSifsSJDw4iA62EgmHPIQlKnFK6ae3FivDhs8Xo=
X-Received: by 2002:a17:906:ef0e:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab2ab74ba27mr508335266b.36.1736405605461; 
 Wed, 08 Jan 2025 22:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6JIaT6gOnALHlFbc9UTEOotcuzzbJpS6YXflsIJ2swyAITm7IuQ6manYGUdBtoxsJEq/cihKz5Htk8B4X9pw=
X-Received: by 2002:a17:906:ef0e:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab2ab74ba27mr508332366b.36.1736405604998; Wed, 08 Jan 2025
 22:53:24 -0800 (PST)
MIME-Version: 1.0
References: <31564d54-4fea-4450-997d-45e14c4957f4.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
 <CAEemH2cFissakwU4N7s+XPLrWvZu4Do5nsEZ8aFohP7zA-TVyg@mail.gmail.com>
In-Reply-To: <CAEemH2cFissakwU4N7s+XPLrWvZu4Do5nsEZ8aFohP7zA-TVyg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 14:53:11 +0800
X-Gm-Features: AbW1kvY-dheLFkdGXIIk-cLWk-S57gIRRlTdpKfndfwB30WOVZViVyzenKDqjX4
Message-ID: <CAEemH2en_XSqBn7Ar=E=WwMtOkdDgR1ebxnEUmr8A8hbeCN2Uw@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dhAzBs7oJtgk9oD-BZHVCB56cwULZPWoEk_i8mBdvPc_1736405606
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it,
 Richard Palethorpe <richard.palethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmluLAoKQ291bGQgeW91IGhlbHAgcmVzZW5kIGEgbmV3IHBhdGNoIHZlcnNpb24gYmFzZWQg
b24gdGhlIHJldmlldyBjb21tZW50cz8KKGFuZCByZWJhc2UgdGhlIGNvZGUgdG8gdGhlIGxhdGVz
dCBicmFuY2ggdG8gYXZvaWQgcGF0Y2ggY29uZmxpY3QgZXJyb3JzKQoKSXQgbWFrZXMgYSBsb3Qg
b2Ygc2Vuc2UgdG8gbWVyZ2UgeW91ciB3b3JrIGJlZm9yZSB0aGUgbmV3IExUUCByZWxlYXNlLgoK
CgpPbiBXZWQsIERlYyAyNSwgMjAyNCBhdCA3OjM44oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiBIaSBKaW4sCj4KPiBPbiBUaHUsIERlYyAxOSwgMjAyNCBhdCAyOjA5
4oCvUE0gSmluIEd1b2ppZSA8Z3VvamllLmppbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4+IFYyOgo+
PiAqIENoYW5nZSB0aGUgZXhwZWN0ZWQgZXZlbnRzIGluIEYgZGVwZW5kaW5nIG9uIG1lbW9yeV9y
ZWN1cnNpdmVwcm90Cj4+Cj4+IEluIFBhdGNoIHYxWzFdLCB0aGUgcm9sZSBvZiByZWN1cnNpdmVf
cHJvdGVjdGlvbiBpbiBjZ291cCB2MiB3YXMgbm90Cj4+IGNvbnNpZGVyZWQuCj4+Cj4+IEJ5IGNh
cmVmdWxseSByZWFkaW5nIHRoZSBhbGdvcml0aG0gaW4gdGhlIGtlcm5lbCBmdW5jdGlvbgo+PiBl
ZmZlY3RpdmVfcHJvdGVjdGlvbigpLiBXaGVuIG1lbW9yeV9yZWN1cnNpdmVwcm90IGlzIGVuYWJs
ZWQsIGEKPj4gc3ViZ3JvdXAgd2l0aCB1c2FnZSA+IDAgY2FuIGdldCB1bmNsYWltZWQgZ3JlYXRl
ciB0aGFuIDAuCj4+Cj4+IFRoZSBwdXJwb3NlIG9mIGRvaW5nIHRoaXMgc2hvdWxkIGJlIHRvIGFj
aGlldmUgdGhlIGVzc2VudGlhbCBwdXJwb3NlCj4+IG9mIHJlY3Vyc2l2ZV9wcm90ZWN0aW9uOiB0
aGUgc3VtIG9mIGFsbCBzdWJncm91cHMnIHVucHJvdGVjdGVkIHZhbHVlcwo+PiBpcyBlcXVhbCB0
byBwYXJlbnQncyB1bnByb3RlY3RlZCB2YWx1ZXMuCj4+Cj4+IEV2ZW4gdGhvdWdoIHRoZSBkb2N1
bWVudGF0aW9uIGRvZXMgbm90IGdpdmUgYW4gZXhwbGljaXQgZGVzY3JpcHRpb24KPj4gZm9yIHJl
Y3Vyc2l2ZV9tZW1vcnlwcm90LCBpdCBsb29rcyBsaWtlIHRoZSBrZXJuZWwncyBwcm9jZXNzaW5n
Cj4+IGFsZ29yaXRobSBpcyByZWFzb25hYmxlLgo+Pgo+PiBCYXNlZCBvbiB0aGUgaWRlYSBvZiBb
Ml0sIFBhdGNoIHYyIGlzIHJld3JpdHRlbiB0byBkZXRlcm1pbmUgd2hldGhlcgo+PiBtZW1vcnlf
cmVjdXJzaXZlcHJvdCBpcyBlbmFibGVkLgo+Pgo+PiBPbiBkaXN0cmlidXRpb25zIHdpdGggbWVt
b3J5X3JlY3Vyc2l2ZXByb3QgZW5hYmxlZCBieSBkZWZhdWx0IChmcm9tCj4+IFVidW50dSAyMi4w
NCB0byAyNC4xMCksIHJ1bm5pbmcgdGhpcyBwYXNzZXM6Cj4+Cj4+IG1lbWNvbnRyb2wwNC5jOjIw
ODogVFBBU1M6IEV4cGVjdDogKEMgb29tIGV2ZW50cz0wKSA9PSAwCj4+IG1lbWNvbnRyb2wwNC5j
OjIxMTogVFBBU1M6IEV4cGVjdDogKEMgbG93IGV2ZW50cz05NjYpID4gMAo+PiBtZW1jb250cm9s
MDQuYzoyMDg6IFRQQVNTOiBFeHBlY3Q6IChEIG9vbSBldmVudHM9MCkgPT0gMAo+PiBtZW1jb250
cm9sMDQuYzoyMTE6IFRQQVNTOiBFeHBlY3Q6IChEIGxvdyBldmVudHM9OTY2KSA+IDAKPj4gbWVt
Y29udHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoRSBvb20gZXZlbnRzPTApID09IDAKPj4g
bWVtY29udHJvbDA0LmM6MjE0OiBUUEFTUzogRXhwZWN0OiAoRSBsb3cgZXZlbnRzPTApID09IDAK
Pj4gbWVtY29udHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoRiBvb20gZXZlbnRzPTApID09
IDAKPj4gbWVtY29udHJvbDA0LmM6MjExOiBUUEFTUzogRXhwZWN0OiAoRiBsb3cgZXZlbnRzPTg3
NCkgPiAwCj4+Cj4+IFsxXSBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAy
NC1Ob3ZlbWJlci8wNDA5NDYuaHRtbAo+PiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
LzIwMjIwMjIyMTQ0NTExLkdBMTIwMzdAYmxhY2tib2R5LnN1c2UuY3ovCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEppbiBHdW9qaWUgPGd1b2ppZS5qaW5AZ21haWwuY29tPgo+PiBTdWdnZXN0ZWQtYnk6
IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBhbGV0aG9ycGVAc3VzZS5jb20+Cj4+IFN1Z2dlc3RlZC1i
eTogTWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+Cj4+IC0tLQo+PiAgaW5jbHVkZS90
c3RfY2dyb3VwLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsrCj4+ICBsaWIv
dHN0X2Nncm91cC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysr
KysrKysrCj4+ICB0ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2ww
NC5jIHwgIDIgKy0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfY2dyb3VwLmggYi9pbmNsdWRl
L3RzdF9jZ3JvdXAuaAo+PiBpbmRleCBkMjNhOGU2NTIuLjA2OGZmODMwNiAxMDA2NDQKPj4gLS0t
IGEvaW5jbHVkZS90c3RfY2dyb3VwLmgKPj4gKysrIGIvaW5jbHVkZS90c3RfY2dyb3VwLmgKPj4g
QEAgLTI1Niw0ICsyNTYsNiBAQCBpbnQgc2FmZV9jZ19vY2N1cnNpbihjb25zdCBjaGFyICpmaWxl
LCBjb25zdCBpbnQKPj4gbGluZW5vLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
Y2hhciAqY29uc3QgZmlsZV9uYW1lLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qg
Y2hhciAqY29uc3QgbmVlZGxlKTsKPj4KPj4gK2ludCB0c3RfY2dfbWVtb3J5X3JlY3Vyc2l2ZXBy
b3Qoc3RydWN0IHRzdF9jZ19ncm91cCAqY2cpOwo+PiArCj4+ICAjZW5kaWYgLyogVFNUX0NHUk9V
UF9IICovCj4+IGRpZmYgLS1naXQgYS9saWIvdHN0X2Nncm91cC5jIGIvbGliL3RzdF9jZ3JvdXAu
Ywo+PiBpbmRleCA2MDU1MDE1ZWIuLjllM2IyMWVkMCAxMDA2NDQKPj4gLS0tIGEvbGliL3RzdF9j
Z3JvdXAuYwo+PiArKysgYi9saWIvdHN0X2Nncm91cC5jCj4+IEBAIC03Niw2ICs3Niw4IEBAIHN0
cnVjdCBjZ3JvdXBfcm9vdCB7Cj4+ICAgICAgICAgaW50IHdlX21vdW50ZWRfaXQ6MTsKPj4gICAg
ICAgICAvKiBjcHVzZXQgaXMgaW4gY29tcGF0YWJpbGl0eSBtb2RlICovCj4+ICAgICAgICAgaW50
IG5vX2NwdXNldF9wcmVmaXg6MTsKPj4gKwo+PiArICAgICAgIGludCBtZW1vcnlfcmVjdXJzaXZl
cHJvdDoxOwo+Pgo+Cj4gSSBwcmVmZXIgdG8gbW92ZSBpdCB1cCB0byBwdXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgbnNkZWxlZ2F0ZS4KPgo+Cj4KPj4gIH07Cj4+Cj4+ICAvKiBDb250cm9sbGVyIHN1
Yi1zeXN0ZW1zICovCj4+IEBAIC01OTIsNiArNTk0LDcgQEAgc3RhdGljIHZvaWQgY2dyb3VwX3Jv
b3Rfc2Nhbihjb25zdCBjaGFyICpjb25zdAo+PiBtbnRfdHlwZSwKPj4gICAgICAgICB9Cj4+ICAg
ICAgICAgZm9yICh0b2sgPSBzdHJ0b2sobW50X29wdHMsICIsIik7IHRvazsgdG9rID0gc3RydG9r
KE5VTEwsICIsIikpIHsKPj4gICAgICAgICAgICAgICAgIG5zZGVsZWdhdGUgfD0gIXN0cmNtcCgi
bnNkZWxlZ2F0ZSIsIHRvayk7Cj4+ICsgICAgICAgICAgICAgICByb290LT5tZW1vcnlfcmVjdXJz
aXZlcHJvdCB8PQo+PiAhc3RyY21wKCJtZW1vcnlfcmVjdXJzaXZlcHJvdCIsIHRvayk7Cj4+Cj4K
Pgo+IFdoeSBub3QgZGVmaW5lIGEgc2luZ2xlIHZhcmlhYmxlIG1lbW9yeV9yZWN1cnNpdmVwcm90
IHRvIHNhdmUgdGhlIHZhbHVlCj4gYW5kIG1vdmUgdGhlIHJvb3QtPm1lbW9yeV9yZWN1cnNpdmVw
cm90IGFzc2lnbm1lbnQgdG8gdGhlICJiYWNrcmVmIiBwYXJ0Pwo+IChqdXN0IGxpa2Ugd2hhdCB3
ZSBkaWQgZm9yIG5zZGVsZWdhdGUpCj4KPgo+Cj4+ICAgICAgICAgfQo+Pgo+PiAgICAgICAgIGlm
IChyb290LT52ZXIgJiYgY3RybF9maWVsZCA9PSByb290LT5jdHJsX2ZpZWxkKQo+PiBAQCAtNzE4
LDYgKzcyMSw3IEBAIG1vdW50Ogo+PiAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgIk1v
dW50ZWQgVjIgQ0dyb3VwcyBvbiAlcyIsIG1udF9wYXRoKTsKPj4gICAgICAgICAgICAgICAgIHRz
dF9jZ19zY2FuKCk7Cj4+ICAgICAgICAgICAgICAgICByb290c1swXS53ZV9tb3VudGVkX2l0ID0g
MTsKPj4gKyAgICAgICAgICAgICAgIHJvb3RzWzBdLm1lbW9yeV9yZWN1cnNpdmVwcm90ID0gMTsK
Pj4KPgo+IFRoaXMgaXMgY29tcGxldGVseSB3cm9uZywgYXMgdGhlIGZpcnN0IG1vdW50IG9wZXJh
dGlvbiBtYXkgZmFpbCwKPiB3aGlsZSBDR3JvdXBWMiBmYWxscyBiYWNrIHRvIHRoZSBkZWZhdWx0
IG1vdW50IGFuZCBzdWNjZWVkcy4KPgo+IEhlbmNlIHdlIHNob3VsZCByZW1vdmUgdGhlIGxpbmUg
aGVyZSwgYXMgdHN0X2NnX3NjYW4oKSBoZWxwcwo+IHRvIGF1dG9tYXRpY2FsbHkgZGV0ZWN0IGFu
ZCBzZXQgInJvb3QtPm1lbW9yeV9yZWN1cnNpdmVwcm90Igo+IHRvIHRoZSBjb3JyZWN0IHZhbHVl
Lgo+Cj4KPgo+PiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+PiAgICAgICAgIH0KPj4KPj4gQEAg
LTE1MDksMyArMTUxMywxMSBAQCBpbnQgc2FmZV9jZ19vY2N1cnNpbihjb25zdCBjaGFyICpjb25z
dCBmaWxlLAo+PiBjb25zdCBpbnQgbGluZW5vLAo+Pgo+PiAgICAgICAgIHJldHVybiAhIXN0cnN0
cihidWYsIG5lZWRsZSk7Cj4+ICB9Cj4+ICsKPj4gK2ludCB0c3RfY2dfbWVtb3J5X3JlY3Vyc2l2
ZXByb3Qoc3RydWN0IHRzdF9jZ19ncm91cCAqY2cpCj4+ICt7Cj4+ICsgICAgICAgaWYgKGNnICYm
IGNnLT5kaXJzX2J5X2N0cmxbMF0tPmRpcl9yb290KQo+PiArICAgICAgICAgICAgICAgcmV0dXJu
Cj4+IGNnLT5kaXJzX2J5X2N0cmxbMF0tPmRpcl9yb290LT5tZW1vcnlfcmVjdXJzaXZlcHJvdDsK
Pj4gKyAgICAgICByZXR1cm4gMDsKPj4gK30KPj4gKwo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9tZW1jb250cm9sMDQuYwo+PiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMKPj4gaW5kZXggMWI4ZDExNWY4
Li45ZTlkNmFiNmUgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMv
bWVtY2cvbWVtY29udHJvbDA0LmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVy
cy9tZW1jZy9tZW1jb250cm9sMDQuYwo+PiBAQCAtMjA3LDcgKzIwNyw3IEBAIHN0YXRpYyB2b2lk
IHRlc3RfbWVtY2dfbG93KHZvaWQpCj4+Cj4+ICAgICAgICAgICAgICAgICBUU1RfRVhQX0VYUFIo
b29tID09IDAsICIoJWMgb29tIGV2ZW50cz0lbGQpID09IDAiLCBpZCwKPj4gb29tKTsKPj4KPj4g
LSAgICAgICAgICAgICAgIGlmIChpIDwgRSkgewo+PiArICAgICAgICAgICAgICAgaWYgKGkgPCBF
IHx8ICgoaSA9PSBGKSAmJgo+PiB0c3RfY2dfbWVtb3J5X3JlY3Vyc2l2ZXByb3QobGVhZl9jZ1tG
XSkpKSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIFRTVF9FWFBfRVhQUihsb3cgPiAwLAo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiglYyBsb3cgZXZlbnRzPSVs
ZCkgPiAwIiwgaWQsIGxvdyk7Cj4+ICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+PiAtLQo+PiAy
LjM0LjEKPj4KPj4gLS0KPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCj4+Cj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
