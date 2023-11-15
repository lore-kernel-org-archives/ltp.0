Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC843C07548
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 07:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C810B3CE48A
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 08:43:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35F3E3CB364
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 08:43:41 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9ECFD2005EF
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 08:43:38 +0100 (CET)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28099d11c49so1406931a91.1
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1700034217;
 x=1700639017; darn=lists.linux.it; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oapRXslUldY74vND3ZbgLSRX0gO0F2Lv+V1gKgyjXZg=;
 b=GmRM68BLiD0S0gG1rYJMF5bxzWX/RuXeqRDuxrWluMsr7/LH0TsbGTv+BxVZi85DLe
 R2Jdd1fMt+VvYu/V+9VFzCo4aKzDjUjkZjQSRmulFKG1SwhWSvTYtmhotrGH6MxBFuhK
 dXIz1Cdm0d1QbmHCvlBKvAAAbz+zm9n/L5kyTogyNmftCF74isVgiNUV0k42tZ4kQLZf
 cS58wzqPPQPzanM9a3F8+MHDYh6PAXkH630QjLYMYNbbkYtKH2utFyL+FwY/80A+gbeF
 +o5C/YOxMQdoORwXQQPqP/b3JKmQbVWY7kk7xBvolGvLX9MUBfF/0A7Pw4kPwem5B3f3
 Rs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700034217; x=1700639017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oapRXslUldY74vND3ZbgLSRX0gO0F2Lv+V1gKgyjXZg=;
 b=BGvCC+Ujw10lLvGHrnJAuVpIRIeG8yHGnqf/5gpz7JHTSn1xtCpCRDuVMUnMaVpqfv
 bZBsCe0uTZJWw7o5O/Rg0BmruTnoIdJhp8nyfX8OBXnbSz5YW98UvwlcRS7gNQIxg/9E
 UIAwf28j9drwvPfB/ds4pjOMBGUHbDkGQtktoWAD2xpKijft1rsPj1BWi+ayuHVygfi9
 BeJrO3nlTnhnXI9c72JykLIjd/11GwYXbrU4p6emHIr36D6PC8bNbu+LjPaxDp/vrFVu
 7Rjlf/lQmodrf+FZJ6TtJZ65j2/JKjJJKMRdu3Xb5H+Q5av4lxh/52b1KGf++Wa9Vo1b
 j5RQ==
X-Gm-Message-State: AOJu0Yy2Vx+lByzSeEb9xbAQuwMvhtvfmgskXP3XE1GF8aiQYxfk4yEb
 C6wzi65Km9VO6T+BhD30pa8mW3dpanhPXNWRE/p/rQ==
X-Google-Smtp-Source: AGHT+IEsSMoySH43AV9WJm+aL/WjLRqv4NQPV4KzBZ2uDifPebDVEXBwFUQIfkSkIceb122//LBmkbrKtioOgyXSJ28=
X-Received: by 2002:a17:90a:6395:b0:27d:32d8:5f23 with SMTP id
 f21-20020a17090a639500b0027d32d85f23mr4490469pjj.2.1700034217018; Tue, 14 Nov
 2023 23:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20231114123140.1144-1-mdoucha@suse.cz>
 <20231114123140.1144-6-mdoucha@suse.cz>
 <20231114153907.GA2357693@pevik>
In-Reply-To: <20231114153907.GA2357693@pevik>
From: =?UTF-8?B?5rKz5Y6f6aKv5aSq?= <souta.kawahara@miraclelinux.com>
Date: Wed, 15 Nov 2023 16:43:00 +0900
Message-ID: <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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

SGkgTWFydGluLCBQZXRyLgoKCjIwMjPlubQxMeaciDE15pelKOawtCkgMDozOSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej46Cj4KPiBIaSBNYXJ0aW4sCj4KPiAuLi4KPiA+ICsrKyBiL3Rlc3Rj
YXNlcy9uZXR3b3JrL2lwdGFibGVzL25mdDAyLmMKPiAuLi4KPiA+ICsvKiBDaGFpbiBjcmVhdGlv
biBhbmQgZGVsZXRpb24gY29uZmlnICovCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0c3RfbmV0
bGlua19hdHRyX2xpc3QgbmV3Y2hhaW5fY29uZmlnW10gPSB7Cj4gPiArICAgICB7TkZUQV9UQUJM
RV9OQU1FLCBUQUJOQU1FLCBzdHJsZW4oVEFCTkFNRSkgKyAxLCBOVUxMfSwKPiA+ICsgICAgIHtO
RlRBX0NIQUlOX05BTUUsIENIQUlOTkFNRSwgc3RybGVuKENIQUlOTkFNRSkgKyAxLCBOVUxMfSwK
PiA+ICsgICAgIHtORlRBX0NIQUlOX0lELCAmY2hhaW5faWQsIHNpemVvZihjaGFpbl9pZCksIE5V
TEx9LAo+Cj4gVW5mb3J0dW5hdGVseSB0aGUgY3VycmVudCBvbGRlc3QgZGlzdHJvcyAoTGVhcCA0
MiBhbmQgVWJ1bnR1IEJpb25pYykgYXJlIHRvbyBvbGQKPiBmb3IgTkZUQV9DSEFJTl9JRCwgTkZU
QV9SVUxFX0NIQUlOX0lELCBjb3VsZCB5b3UgcGxlYXNlIGFkZCB0aGVtIHRvIExBUEk/CgpJdCB3
YXMgdGhlIHNhbWUgb24gUkhFTDggKGFuZC9vciBvdGhlciBjbG9uZSBPUykuCgpBbmQsIEkgd291
bGQgbGlrZSB0byBzZWUgdGhpcyB0ZXN0IGFkZGVkIHRvIHJ1bnRlc3QvY3ZlIGFuZCAuZ2l0aWdu
b3JlLgoKPiArICAgICAgIGlmICh0c3RfdGFpbnRfY2hlY2soKSkgewo+ICsgICAgICAgICAgICAg
ICB0c3RfcmVzKFRGQUlMLCAiS2VybmVsIGlzIHZ1bG5lcmFibGUiKTsKPiArICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ICsgICAgICAgfQoKTm90IGEgcHJvYmxlbSB3aXRoIHRoZSB0ZXN0IGl0c2Vs
ZiBidXQsIElmIFRBSU5UX1cgd2FzIGFscmVhZHkgc2V0LAp0aGUgdGVzdCByZXBvcnQgVFBBU1Mg
YnkgbWlzc3Rha2UuCkJlbG93IHBhdGNoIG1hc2tzIFRBSU5UX1cgaWYgdGhhdCB0YWludCBmbGFn
IHdhcyBzZXQgYmVmb3JlIHRlc3Qgc3RhcnRlZC4KCmNvbW1pdCBkZTliNWMyNjM2MjA0YWIwNmRi
YjNjN2RjNTcyOTZkNzNhYzU3MmFjCkF1dGhvcjogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhh
dC5jb20+CkRhdGU6ICAgVHVlIEFwciAyMSAxNDoxNTo0OCAyMDIwICswMjAwCgogICAgbGliOiB0
c3RfdGFpbnQ6IElnbm9yZSBXQVJOIHRhaW50IGZsYWcgaWYgYWxyZWFkeSBzZXQKCiAgICBUaGlz
IGNvbW1pdCBjaGFuZ2VzIHRoZSBsaWJyYXJ5IHNvIHRoYXQgaXQgaWdub3JlcyB0aGUgdGFpbnQg
d2FybiBmbGFnCiAgICBpZiBpdCB3YXMgc2V0IHByaW9yIHRvIHRoZSB0ZXN0IHJ1bi4gSXQgdHVy
bnMgb3V0IHRoYXQgdGhlIHdhcm4gdGFpbnQKICAgIGZsYWcgaXMgbm90IHdlbGwgZGVmaW5lZCBh
bmQgY291bGQgYmUgZWFzaWx5IHNldCBvbiBhIGZyZXNobHkgYm9vdGVkCiAgICBrZXJuZWwgZm9y
IGV4YW1wbGUgd2hlbiBidWdneSBCSU9TIGlzIGRldGVjdGVkLgoKICAgIE90aGVyIHJlY2VudCBl
eGFtcGxlIGlzIGRpc2FibGluZyBpcCBmb3J3YXJkIG9uIGt2bSBndWVzdHM6CiAgICAgIGh0dHBz
Oi8vZ2l0aHViLmNvbS9jb250YWluZXJzL2xpYnBvZC9pc3N1ZXMvNTgxNQogICAgICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYTQ3YjZhM2ItYzA2NC0yZjUzLTdjZjYtZDBkMDcyMGU5
ZDk5QHJlZGhhdC5jb20vCgogICAgU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+CiAgICBTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0
LmNvbT4KICAgIENjOiBDaGFuZyBZaW4gPGN5aW5AcmVkaGF0LmNvbT4KICAgIFJldmlld2VkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCmRpZmYgLS1naXQgYS9saWIvdHN0X3RhaW50
LmMgYi9saWIvdHN0X3RhaW50LmMKaW5kZXggYTVkYmY3N2QyLi40OTE0NmFhY2IgMTAwNjQ0Ci0t
LSBhL2xpYi90c3RfdGFpbnQuYworKysgYi9saWIvdHN0X3RhaW50LmMKQEAgLTgyLDkgKzgyLDE0
IEBAIHZvaWQgdHN0X3RhaW50X2luaXQodW5zaWduZWQgaW50IG1hc2spCiAgICAgICAgICAgICAg
ICB0c3RfcmVzKFRDT05GLCAiS2VybmVsIGlzIHRvbyBvbGQgZm9yIHJlcXVlc3RlZCBtYXNrIik7
CgogICAgICAgIHRhaW50X21hc2sgPSBtYXNrOwotCiAgICAgICAgdGFpbnQgPSB0c3RfdGFpbnRf
cmVhZCgpOwotICAgICAgIGlmICgodGFpbnQgJiBtYXNrKSAhPSAwKQorCisgICAgICAgaWYgKHRh
aW50ICYgVFNUX1RBSU5UX1cpIHsKKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJJZ25v
cmluZyBhbHJlYWR5IHNldCBrZXJuZWwgd2FybmluZyB0YWludCIpOworICAgICAgICAgICAgICAg
dGFpbnRfbWFzayAmPSB+VFNUX1RBSU5UX1c7CisgICAgICAgfQorCisgICAgICAgaWYgKCh0YWlu
dCAmIHRhaW50X21hc2spICE9IDApCiAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiS2Vy
bmVsIGlzIGFscmVhZHkgdGFpbnRlZDogJXUiLCB0YWludCk7CiB9CgpPdGhlciB0ZXN0cyByZWx5
IG9uIFRBSU5UX1cgdG8gZGVjaWRlIHRoZSByZXN1bHQgYWxzbyByZXBvcnQgVFBBU1MgYnkKbWlz
c3Rha2UgaWYgVEFJTlRfVyB3YXMgYWxyZWFkeSBzZXQuCkluIG15IHBhdGNoIHYxIGFib3V0IENW
RS0yMDIzLTMxMjQ4IGNoZWNrIGVycm9yID09IEVOT0VOVC4gSW4gdGhpcwpjYXNlLCB0ZXN0IHJl
cG9ydHMgY29ycmVjdCByZXN1bHQuCkl0IG1heSBiZSBkaWZmaWN1bHQgdG8gaW1wbGVtZW50IHRl
c3QgbGlrZSBwYXRjaCB2MSB1c2luZyB0aGUgaW50ZXJuYWwKdHN0X25ldGxpbmsgQVBJLCBidXQg
d2Ugc2hvdWxkIGJlIGF3YXJlIG9mIHRoaXMgaXNzdWUuCgpCZXN0IHJlZ2FyZHMuClNvdXRhIEth
d2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGludXguY29tPgoKCj4KPiBPdGhlcndpc2Ug
dGhlIHBhdGNoc2V0IGxvb2tzIG9rLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IC0tCj4g
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
