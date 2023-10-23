Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062F5C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 13:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C793CECE9
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 15:53:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08AD3C84B5
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:53:00 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 678F51000431
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:53:00 +0200 (CEST)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc44736f2so22773691cf.3
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698069179; x=1698673979; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qtIZCrtkgdQ8d0ol2XRXNMO1YfwS6jdqVRwOGmwQi8=;
 b=QU1ST6z+e9ZuEf3B/2pVeuZB7XXpoO2hyKsjbpR2R+fNF+ERv9fKraz8tIYNVGl0b8
 WU5SpCX9hJt4tNVqNymKsydg1fy5FUIcBJ6uMZk11nMirhHs55dzOoIIRp92ofzodPwN
 xZpAge3PpNJ3SL8nieY5tF4ICmWdIpfMBFML6sxtWd209NfbbmVSqoc7OtDG6zMLDnFm
 1fDWM4c+QjOdERYjEuuBqNuAzTa9RcoVpjsQchOB8qPdPI/UnX6jn9icKf4UFtCkum99
 Mdf/VRrmIBvDM/ZwP2o1LrteFlLnAin7TmHirlGmB8KbCQ4FxnHXlgdYj9V/kFvFpGUq
 TqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698069179; x=1698673979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qtIZCrtkgdQ8d0ol2XRXNMO1YfwS6jdqVRwOGmwQi8=;
 b=WT3aKHGy3J+6aPlTnIOgGh8QyR58g9nAXhOfeEk8XXsNsTBfiSGox1iCM20h+FGYFv
 AkZ3garDoFo8xgYGzyuSGGBZMHsXjgvmcvZDQhRJK58B29aIWZ/Y7yXn8vd7QCo6r28P
 PCFEvxiVcnjJNGxdpZbTZlwgygNWg2PVC9/41gOsew0QPKpvNoUYdXaEq73/xcnHVglE
 ZHngRbltvXwWXQluBC+f1bIgKnn24ztOZdFxkocRyhLCtRFF4gTPRETdxs24lK6Nm1Fa
 nY3vFnO20ZD+nj7aqg//0O7QoFHaOCLJtCIRYWChjbNSycBqXsiMZyHlpb/9NguNzV3R
 WqqA==
X-Gm-Message-State: AOJu0Yx23tH2KxKKpIfV4bti75vMSjtOlTfiljQYE1EVGJqXfVD1jNWR
 zpHCyBtGizd1JUai8kS2WnLwFnmEJoztfAHstq7ET1lv
X-Google-Smtp-Source: AGHT+IGF1BO0CFqggWQQ9SrziH7g3gT0waI21cDNZWfOTsqsG3l6fGjR3JVJj+4h31fwJViOyaSDjMjxaG4HFn4RKHQ=
X-Received: by 2002:a05:6214:2aa6:b0:66d:27ac:a595 with SMTP id
 js6-20020a0562142aa600b0066d27aca595mr11900893qvb.23.1698069179012; Mon, 23
 Oct 2023 06:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-3-mdoucha@suse.cz>
 <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
 <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
In-Reply-To: <5f74b10f-2a97-9cdc-69c0-5e90f1d5d986@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Oct 2023 16:52:47 +0300
Message-ID: <CAOQ4uxh+JDVXEipwF2XCe=5RRTk22HZB65_BeKNEM6Vm0okPcw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported
 init flags
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMzo1MeKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBPbiAyMC4gMTAuIDIzIDE4OjA1LCBBbWlyIEdvbGRzdGVpbiB3
cm90ZToKPiA+IE9uIEZyaSwgT2N0IDIwLCAyMDIzIGF0IDY6MDfigK9QTSBNYXJ0aW4gRG91Y2hh
IDxtZG91Y2hhQHN1c2UuY3o+IHdyb3RlOgo+ID4+Cj4gPj4gVGVzdCBjYXNlIDggb2YgZmFub3Rp
ZnkxNCB1c2VzIGluaXQgZmxhZ3Mgc3VwcG9ydGVkIG9ubHkgb24ga2VybmVsIDUuOSsKPiA+PiBi
dXQgZG9lcyBub3QgcHJvcGVybHkgY2hlY2sgZm9yIHRoZWlyIHN1cHBvcnQuIFJld3JpdGUgZmFu
b3RpZnkgZmVhdHVyZQo+ID4+IGNoZWNrcyB1c2luZyBuZXcgaGVscGVyIGZ1bmN0aW9uLgo+ID4+
Cj4gPj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+ID4+
IC0tLQo+ID4+Cj4gPj4gQ2hhbmdlcyBzaW5jZSB2MToKPiA+PiAtIEFkZGVkIEZBTl9DTEFTU18q
IGNvbnN0YW50cyB0byBzdXBwb3J0IGNoZWNrIGluIHNldHVwKCkKPiA+PiAtIEFkZGVkIGxvbmdl
ciBwYXRjaCBkZXNjcmlwdGlvbgo+ID4+Cj4gPj4gQ2hhbmdlcyBzaW5jZSB2MjogTm9uZQo+ID4+
Cj4gPj4gSSdkIHJhdGhlciBub3Qgc3F1YXNoIHRoaXMgcGF0Y2ggc28gdGhhdCBpdCBjYW4gYmUg
cmV2ZXJ0ZWQgd2l0aG91dAo+ID4+IHBvdGVudGlhbGx5IGJyZWFraW5nIG90aGVyIHRlc3RzLgo+
ID4+Cj4gPj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQu
YyB8IDE1ICsrKysrKysrKy0tLS0tLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gPj4gaW5kZXggNDU5NjUxMWYwLi4wYmI3ODkx
ODggMTAwNjQ0Cj4gPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTE0LmMKPiA+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MTQuYwo+ID4+IEBAIC00NSw4ICs0NSw4IEBACj4gPj4KPiA+PiAgIHN0YXRpYyBp
bnQgcGlwZXNbMl0gPSB7LTEsIC0xfTsKPiA+PiAgIHN0YXRpYyBpbnQgZmFub3RpZnlfZmQ7Cj4g
Pj4gLXN0YXRpYyBpbnQgZmFuX3JlcG9ydF90YXJnZXRfZmlkX3Vuc3VwcG9ydGVkOwo+ID4+ICAg
c3RhdGljIGludCBpZ25vcmVfbWFya191bnN1cHBvcnRlZDsKPiA+PiArc3RhdGljIHVuc2lnbmVk
IGludCBzdXBwb3J0ZWRfaW5pdF9mbGFnczsKPiA+Pgo+ID4+ICAgc3RydWN0IHRlc3RfY2FzZV9m
bGFnc190IHsKPiA+PiAgICAgICAgICB1bnNpZ25lZCBsb25nIGxvbmcgZmxhZ3M7Cj4gPj4gQEAg
LTI0Niw5ICsyNDYsOCBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1iZXIp
Cj4gPj4gICAgICAgICAgdHN0X3JlcyhUSU5GTywgIlRlc3QgY2FzZSAlZDogZmFub3RpZnlfaW5p
dCglcywgT19SRE9OTFkpIiwgbnVtYmVyLAo+ID4+ICAgICAgICAgICAgICAgICAgdGMtPmluaXQu
ZGVzYyk7Cj4gPj4KPiA+PiAtICAgICAgIGlmIChmYW5fcmVwb3J0X3RhcmdldF9maWRfdW5zdXBw
b3J0ZWQgJiYgdGMtPmluaXQuZmxhZ3MgJiBGQU5fUkVQT1JUX1RBUkdFVF9GSUQpIHsKPiA+PiAt
ICAgICAgICAgICAgICAgRkFOT1RJRllfSU5JVF9GTEFHU19FUlJfTVNHKEZBTl9SRVBPUlRfVEFS
R0VUX0ZJRCwKPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZhbl9yZXBvcnRfdGFyZ2V0X2ZpZF91bnN1cHBvcnRlZCk7Cj4gPj4gKyAgICAgICBpZiAodGMt
PmluaXQuZmxhZ3MgJiB+c3VwcG9ydGVkX2luaXRfZmxhZ3MpIHsKPiA+PiArICAgICAgICAgICAg
ICAgdHN0X3JlcyhUQ09ORiwgIlVuc3VwcG9ydGVkIGluaXQgZmxhZ3MiCj4gPgo+ID4gc3VnZ2Vz
dCB0byBwcmVzZXJ2ZSB0aGUgaW5mb3JtYXRpb24gcHJpbnRlZCBieQo+ID4gRkFOT1RJRllfSU5J
VF9GTEFHU19FUlJfTVNHLCB5b3UgY2FuIHVzZSB0Yy0+aW5pdC5kZXNjCj4gPiB0aGUgZm9yIHRo
ZSBmbGFnIG5hbWUgc3RyaW5nLgo+Cj4gdGMtPmluaXQuZGVzYyBnZXRzIHByaW50ZWQgYnkgdGhl
IFRJTkZPIG1lc3NhZ2UgYXQgdGhlIHN0YXJ0IG9mIHRoZQo+IHBhdGNoIGNodW5rLiBUaGUgcmV0
dXJuIHZhbHVlIGZyb20gZmFub3RpZnlfaW5pdF9mbGFnc19zdXBwb3J0ZWRfb25fZnMoKQo+IGlz
IG5vdCBwcmVzZXJ2ZWQgYW55d2hlcmUgYnkgdGhlIG5ldyBmYW5vdGlmeV9nZXRfc3VwcG9ydGVk
X2luaXRfZmxhZ3MoKQo+IGhlbHBlciBmdW5jdGlvbiBzbyBJIGhhdmUgbm90aGluZyB0byBwYXNz
IGFzIHRoZSBzZWNvbmQgYXJndW1lbnQgb2YKPiBGQU5PVElGWV9JTklUX0ZMQUdTX0VSUl9NU0co
KS4KPgoKT0suCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
