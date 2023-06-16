Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB0EB64D7
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 12:28:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7203CC889
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 14:28:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8EE3CB67C
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 14:27:56 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03179200980
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 14:27:56 +0200 (CEST)
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-bd5f59fb71dso583328276.3
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686918475; x=1689510475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZIOeZQxRinJkYETFW7PV8FVIlGuGC79GHDg0uovKEo=;
 b=hqtG3tuomyLU6f7k7InXeywLNdnKYhtPATcTNfIHo/b01F1QjIkTxffwNDH0mIEPuQ
 hWOvi7jOdpLZ+NxpJPRyYL+iBH0+djQ8lk1D0J/I1pRV68J7J6KFA6HI5NWiN9/b9Kyl
 5aiyYGs2a3zyS2lTt6GTFSjPSlvr3zGlABTs5ymqDFBDizoHpkcSosxce6PiV69nIw/P
 XtpWwThHGWuRrvrLisZi9YYImyTF8CqM8TINdCxP32+oNtGXHT1dTaJfiyRQNufzOwU2
 6prtFp8K4qB119lboWqfCfkTN3pVIWPHgkHT3K1BuChjwatysFDK5IR76OFOl0m2ahug
 2clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686918475; x=1689510475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZIOeZQxRinJkYETFW7PV8FVIlGuGC79GHDg0uovKEo=;
 b=cWERt97jlE9sP73O7ve/rv8zpAayrQEkhRrH7AgDzUPEEZf6klDn2cPrqHx5aZJm4c
 8FdrveVfkqcVd0MxsT9ekSbOIvwmbHeE3D7RZs6gMSc+taTehjwfgrY2GJoYtetr82ez
 dO6KkWX3BKUlyw9ZJ1XdJ3+sCWyAl2GfSGitXcVQWFHIt7PKW5rYOJyI8vn16Muw3dg5
 lcOqy2+76H2jHe2knA6tE+Atgki7xoFKbG22wT6NsLcEcurrDP2eIqECxTJ+Tf5DwXNn
 IfyWp0ydLM6m0NPzyQ5GxcPMmQqgldemyp59tuYxyyDm6cBCnEZK4FIPf8QNw3qhz1N7
 uYOQ==
X-Gm-Message-State: AC+VfDzstc8KgXmBy00jKuC+/ZI0/dJMFMItRgwiD4nmrYxyGBoS7KAR
 /Y6qvre/cV4D18ZH2pphrCDE0YiMWEmmR99q5szZIUug
X-Google-Smtp-Source: ACHHUZ5Y5eSZ4tAV3PGZKeVqvdfRBEQRa9InDZhse+Py4ggjWVedRmtKgHivjD0NY4uxHbL5eUNh8mp8ekI0DswdwKQ=
X-Received: by 2002:a25:ad44:0:b0:bcc:bf43:b969 with SMTP id
 l4-20020a25ad44000000b00bccbf43b969mr1996816ybe.65.1686918474748; Fri, 16 Jun
 2023 05:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230615012445.4184243-1-jencce.kernel@gmail.com>
 <CAEemH2f2Rrco5fSMsmezY5sUJtM2vZpm619d5+v6Kjyhwcm1CQ@mail.gmail.com>
 <2ee08acc-2b36-99ca-b891-0928a92ed4df@suse.cz>
 <CAEemH2fy7gOBTB+idU051oQ1xR6vG=JH-L3a+wscXAJdMiZcTQ@mail.gmail.com>
In-Reply-To: <CAEemH2fy7gOBTB+idU051oQ1xR6vG=JH-L3a+wscXAJdMiZcTQ@mail.gmail.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 16 Jun 2023 20:27:43 +0800
Message-ID: <CADJHv_s7F-LrvCo4tHf_VmxREoz4T18ah7-r2CHbwf6zRj0NzQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info
 about the operation
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

TXkgYmFkLi4gSSBzaG91bGQgaGF2ZSBjaGFuZ2VkIGl0IHRvIFRJTkZPfFRFUlJOTy4uIFRoYW5r
cyBhbGwhCgpPbiBGcmksIEp1biAxNiwgMjAyMyBhdCA1OjIz4oCvUE0gTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIEZyaSwgSnVuIDE2LCAyMDIzIGF0IDQ6Mzji
gK9QTSBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+IHdyb3RlOgo+Pgo+PiBPbiAxNi4g
MDYuIDIzIDQ6NTAsIExpIFdhbmcgd3JvdGU6Cj4+ID4gT24gVGh1LCBKdW4gMTUsIDIwMjMgYXQg
OToyNOKAr0FNIE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4+
ID4KPj4gPj4gTWFrZSB0aGUgc291cmNlIGFuZCB0aGUgdGFyZ2V0IHRvIG1vdW50L3Vtb3VudCB2
aXNpYmxlLiBJdCdzCj4+ID4+IGdvb2QgZm9yIGRlYnVnZ2luZy4KPj4gPj4KPj4gPj4gU2lnbmVk
LW9mZi1ieTogTXVycGh5IFpob3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPgo+PiA+PiAtLS0K
Pj4gPj4gdjM6Cj4+ID4+ICAgIEFwcGx5IHN1Z2dlc3Rpb25zIGZyb20gTGkgYW5kIE1hcnRpbi4g
VGhhbmtzIHZlcnkgbXVjaCEKPj4gPj4KPj4gPj4gICBsaWIvc2FmZV9tYWNyb3MuYyB8IDE3ICsr
KysrKysrKysrKysrKysrCj4+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykK
Pj4gPj4KPj4gPj4gZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIvbGliL3NhZmVfbWFj
cm9zLmMKPj4gPj4gaW5kZXggYWY2ZGQwNzE2Li4yNmY5MTM2YWYgMTAwNjQ0Cj4+ID4+IC0tLSBh
L2xpYi9zYWZlX21hY3Jvcy5jCj4+ID4+ICsrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4+ID4+IEBA
IC04OTgsNyArODk4LDE2IEBAIGludCBzYWZlX21vdW50KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0
IGludCBsaW5lbm8sCj4+ID4+IHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPj4gPj4gICAgICAg
ICAgICAgICAgIGNvbnN0IHZvaWQgKmRhdGEpCj4+ID4+ICAgewo+PiA+PiAgICAgICAgICBpbnQg
cnZhbCA9IC0xOwo+PiA+PiArICAgICAgIGNoYXIgbXBhdGhbUEFUSF9NQVhdOwo+PiA+Pgo+PiA+
PiArICAgICAgIGlmIChyZWFscGF0aCh0YXJnZXQsIG1wYXRoKSkgewo+PiA+PiArICAgICAgICAg
ICAgICAgdHN0X3Jlc21fKGZpbGUsIGxpbmVubywgVElORk8sCj4+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICJNb3VudGluZyAlcyB0byAlcyBmc3R5cD0lcyBmbGFncz0lbHgiLAo+PiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2UsIG1wYXRoLCBmaWxlc3lzdGVtdHlwZSwgbW91
bnRmbGFncyk7Cj4+ID4+ICsgICAgICAgfSBlbHNlIHsKPj4gPj4gKyAgICAgICAgICAgICAgIHRz
dF9yZXNtXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAo+PiA+Pgo+
PiA+Cj4+ID4gRm9yZ2V0IHRvIG1lbnRpb24gdGhhdCwgdGhpcyBzaG91bGQgYmUgdHN0X2Jya21f
KC4uLCBUQlJPSyB8IFRFUlJOTywgLi4uKSwKPj4gPiBJIG1hbnVhbGx5IGZpeCBpdCBhbmQgcHVz
aGVkLgo+Pgo+PiBJIHRob3VnaHQgbXkgcmV2aWV3IG9mIHRoZSB2MiBwYXRjaCB3YXMgY2xlYXIg
ZW5vdWdoIHRoYXQgYm90aCBicmFuY2hlcwo+PiBvZiB0aGlzIGNvbmRpdGlvbiBzaG91bGQgY2Fs
bCB0c3RfcmVzbV8oLi4uIFRJTkZPIC4uLikuIFRoZXJlIGlzIG5vCj4+IHJlYXNvbiB0byBmYWls
IHRoZSB0ZXN0IGhlcmUuCj4KPgo+IEFoLCBzb3JyeSBmb3Igb3Zlcmxvb2tpbmcgdGhhdC4gSSBz
YXcgaGVyZSB0aGF0IHVzZWQgdHN0X3Jlc21fKCAuLi5UQlJLIC4uLikKPiB3aGljaCBpcyBub3Qg
dGhlIGNvcnJlY3QgdXNhZ2UuIFNvIEkgZ3Vlc3MgaGUgbWlnaHQgd2FudCB0c3RfYnJrbV8oKSwK
PiBidXQgYW55d2F5IHlvdSBhcmUgcmlnaHQuIExldCdzIGZpeCBpdCBpbiBhIHNlcGFyYXRlIHBh
dGNoLgo+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
