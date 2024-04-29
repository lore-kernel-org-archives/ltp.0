Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0359C04FFE
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714432014; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NzZwZx5qJMqST36pTuh+C4tR5FomqzGUTxOGGm4w5dc=;
 b=GWMYCoS3IuxFTBEuIcbfuRy0ENpyUQsEWoR7eI43xrDB3j81k2PcouU/DUOydpEpYDW8r
 FlO0LNWEvK28rQq0Xjh13UCPOWiD5OLGNM9vEkV1ptDYUowXIXcLVKDrxB6R11J43eF9/Xv
 Kid4WZU5KE+0Vq7wtK8AkIq1LiqqENY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285353C8946
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 01:06:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AA143C02C7
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:06:33 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8CE572005F7
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:06:32 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b48daaaf4so15375e9.0
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714431992; x=1715036792; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+JxcxdgR5H7n4Tkg10ylojqcOXC9GGaRNGeyfE4xDM=;
 b=pvd68/6fpwI+ZXEJtArMajHxmriRTw14TveXUXyTKnmhc8aO1k+a7U663ftS6Zbre+
 djrnRR0sv4+GY8IZA7yi3WMk6iL4ogrCI/AzPYGKuuqBLB27EWHpoYUFOmhtN5gHNCvS
 Ltw4YfFNo1hmBE8PRlFFwBZKyXUlEckjiE0X6GMCApNFXn5ns5p64sjFfbG4FMUSb3iX
 fBPN2Jhx1O8qgZV5ZqDytCUQzuJKjK96Ht631sRYepOwswZDQow9IsMeHLNXEkGmhnHH
 aBrKx0dR/RiYjxPj3kJxqdlcVgkiYd4y/qNmEV8T1438uhT8CTWHJ99/uUbV61Ayw6GJ
 OMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431992; x=1715036792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+JxcxdgR5H7n4Tkg10ylojqcOXC9GGaRNGeyfE4xDM=;
 b=fp78z31VyghRcaru7zT4U5Bv4fYCgJjaj0ImHLzBqjDEiSJqbulLzWNGsR0nCT3Bze
 V3YkxvFVivoy4aXGrDQocrrGPWbfprDyEIKaJkL3E10YFv7GKpFzoqa4hu6CjVMZLulu
 yOnQTASsoDv7egWaoZslb5gJTUVs9p35U/x4cFa4rzb6VWj0sIqgnAf+5HHvsgBkI7F7
 CEvPoWhZuHu3Dqw0WI4XY3I6Ag97wDwpM+chSME6cfTuZ+Se5RvZB9dTj6+S4Cwg9DG2
 80dSoFHeU23H6r6cPIiSwJGWfsobJJxHyqX4DbH2YzGXsq1S949c3Ht9OiAJ0DoVIsll
 UB/Q==
X-Gm-Message-State: AOJu0YznQ+4LK2du3c1J3TksUl+l66Ui21kdRux+Z28Vtdez+c5avV55
 sD4q00ZY9zZAbqWTWK4UWx+zT56QxN/ad2sEVQljlJNLAiMG/FzOMqHx8AZrvpvZI8tO1JYQfNL
 2X2jE6N7JpkRRXFg2Q24c8dseFyl9nr98FqA=
X-Google-Smtp-Source: AGHT+IHIZcT5CfSHxLfUNf6SwN9uULG08wkZCGkXtEZNG5eevme38X86BnprckONCtb0KfloZY8Pz6Mtzd+UGOYqy2o=
X-Received: by 2002:a05:600c:3b95:b0:41b:e416:1073 with SMTP id
 n21-20020a05600c3b9500b0041be4161073mr91434wms.0.1714431991847; Mon, 29 Apr
 2024 16:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-4-jstultz@google.com>
 <Zi9kFxXw3mUEVcnf@yuki>
In-Reply-To: <Zi9kFxXw3mUEVcnf@yuki>
Date: Mon, 29 Apr 2024 16:06:20 -0700
Message-ID: <CANDhNCrgkuAoR2zBoJy6KiQqbYCpS=veQJfR0EWxDJHS637S7Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] sched_football: Re-add the crazy fans to
 interrupt everyone
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgMjksIDIwMjQgYXQgMjoxMeKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gICAqICAgICAgVGhpcyBpcyBhIHNjaGVkdWxlciB0
ZXN0IHRoYXQgdXNlcyBhIGZvb3RiYWxsIGFuYWxvZ3kuCj4gPiAgICogICAgICBUaGUgcHJlbWlz
ZSBpcyB0aGF0IHdlIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgbG93ZXIgcHJpb3JpdHkgdGhyZWFk
cwo+ID4gLSAqICAgICAgKGRlZmVuc2l2ZSB0ZWFtKS4gVGhlIG9mZmVuc2UgaXMgdHJ5aW5nIHRv
IGluY3JlbWVudCB0aGUgYmFsbHMgcG9zaXRpb24sCj4gPiAtICogICAgICB3aGlsZSB0aGUgZGVm
ZW5zZSBpcyB0cnlpbmcgdG8gYmxvY2sgdGhhdCBmcm9tIGhhcHBlbmluZy4KPiA+ICsgKiAgICAg
IGRvbid0IHJ1biB3aGlsZSB3ZSBoYXZlIHJ1bm5hYmxlIGhpZ2hlciBwcmlvcml0eSB0aHJlYWRz
Lgo+ID4gKyAqICAgICAgVGhlIG9mZmVuc2UgaXMgdHJ5aW5nIHRvIGluY3JlbWVudCB0aGUgYmFs
bHMgcG9zaXRpb24sIHdoaWxlIHRoZQo+ID4gKyAqICAgICAgZGVmZW5zZSBpcyB0cnlpbmcgdG8g
YmxvY2sgdGhhdCBmcm9tIGhhcHBlbmluZy4KPiA+ICAgKiAgICAgIEFuZCB0aGUgcmVmIChoaWdo
ZXN0IHByaW9yaXR5IHRocmVhZCkgd2lsbCBibG93IHRoZSB3aXN0bGUgaWYgdGhlCj4gPiAgICog
ICAgICBiYWxsIG1vdmVzLiBGaW5hbGx5LCB3ZSBoYXZlIGNyYXp5IGZhbnMgKGhpZ2VyIHByb3Jp
dHkpIHRoYXQgdHJ5IHRvCj4gPiAgICogICAgICBkaXN0cmFjdCB0aGUgZGVmZW5zZSBieSBvY2Nh
c2lvbmFsbHkgcnVubmluZyBvbnRvIHRoZSBmaWVsZC4KPiA+ICAgKgo+ID4gICAqICAgICAgU3Rl
cHM6Cj4gPiAtICogICAgICAgLSBDcmVhdGUgYSBmaXhlZCBudW1iZXIgb2Ygb2ZmZW5zZSB0aHJl
YWRzIChsb3dlciBwcmlvcml0eSkKPiA+ICsgKiAgICAgICAtIENyZWF0ZSBOUl9DUFUgb2ZmZW5z
ZSB0aHJlYWRzIChsb3dlciBwcmlvcml0eSkKPiA+ICsgKiAgICAgICAtIENyZWF0ZSBOUl9DUFUg
ZGVmZW5zZSB0aHJlYWRzIChtaWQgcHJpb3JpdHkpCj4gPiArICogICAgICAgLSBDcmVhdGUgMipO
Ul9DUFUgZmFuIHRocmVhZHMgKGhpZ2ggcHJpb3JpdHkpCj4gPiAgICogICAgICAgLSBDcmVhdGUg
YSByZWZlcmVlIHRocmVhZCAoaGlnaGVzdCBwcmlvcml0eSkKPiA+IC0gKiAgICAgICAtIE9uY2Ug
ZXZlcnlvbmUgaXMgb24gdGhlIGZpZWxkLCB0aGUgb2ZmZW5zZSB0aHJlYWQgaW5jcmVtZW50cyB0
aGUKPiA+IC0gKiAgICAgICAgIHZhbHVlIG9mICd0aGVfYmFsbCcuIFRoZSBkZWZlbnNlIHRocmVh
ZCB0cmllcyB0byBibG9jawo+ID4gLSAqICAgICAgICAgdGhlIGJhbGwgYnkgbmV2ZXIgbGV0dGlu
ZyB0aGUgb2ZmZW5zZSBwbGF5ZXJzIGdldCB0aGUgQ1BVIChpdCBqdXN0Cj4gPiAtICogICAgICAg
ICBzcGlucykuCj4gPiArICogICAgICAgLSBPbmNlIGV2ZXJ5b25lIGlzIG9uIHRoZSBmaWVsZCwg
dGhlIG9mZmVuc2UgdGhyZWFkIHNwaW5zIGluY3JlbWVudGluZwo+ID4gKyAqICAgICAgICAgdGhl
IHZhbHVlIG9mICd0aGVfYmFsbCcuIFRoZSBkZWZlbnNlIHRocmVhZCB0cmllcyB0byBibG9jayB0
aGUgYmFsbAo+ID4gKyAqICAgICAgICAgYnkgbmV2ZXIgbGV0dGluZyB0aGUgb2ZmZW5zZSBwbGF5
ZXJzIGdldCB0aGUgQ1BVIChpdCBqdXN0IHNwaW5zKS4KPiA+ICsgKiAgICAgICAgIFRoZSBjcmF6
eSBmYW5zIHNsZWVwIGEgYml0LCB0aGVuIGp1bXAgdGhlIHJhaWwgYW5kIHJ1biBhY3Jvc3MgdGhl
Cj4gPiArICogICAgICAgICBmaWVsZCwgZGlzcnVwdGluZyB0aGUgcGxheWVycyBvbiB0aGUgZmll
bGQuCj4gPiAgICogICAgICAgLSBUaGUgcmVmcmVlIHRocmVhZHMgd2FrZXMgdXAgcmVndWxhcmx5
IHRvIGNoZWNrIGlmIHRoZSBnYW1lIGlzIG92ZXIgOikKPiA+ICAgKiAgICAgICAtIEluIHRoZSBl
bmQsIGlmIHRoZSB2YWx1ZSBvZiAndGhlX2JhbGwnIGlzID4wLCB0aGUgdGVzdCBpcyBjb25zaWRl
cmVkCj4gPiAgICogICAgICAgICB0byBoYXZlIGZhaWxlZC4KPiA+IEBAIC01Miw3ICs1Niw3IEBA
Cj4gPiAgICogICAgICAgICAgIGJ1Z2ZpeGVzIGFuZCBjbGVhbnVwcy4gLS0gSm9zaCBUcmlwbGV0
dAo+ID4gICAqICAgICAyMDA5LTA2LTIzIFNpbXBsaWZpZWQgYXRvbWljIHN0YXJ0dXAgbWVjaGFu
aXNtLCBhdm9pZGluZyB0aHVuZGVyaW5nIGhlcmQKPiA+ICAgKiAgICAgICAgICAgc2NoZWR1bGlu
ZyBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBnYW1lLiAtLSBEYXJyZW4gSGFydAo+ID4gLSAqCj4g
PiArICogICAgIDIwMjQtMDQtMjMgUmUtYWRkIGNyYXp5IGZhbnMhIEFsb25nIHdpdGggbWlub3Ig
Y2xlYW51cHMgLS0gSm9obiBTdHVsdHoKPgo+IFdlIHVzZSBnaXQgbm93LCBzbyBpdCdzIGtpbmQg
b2YgcG9pbnRsZXNzIHRvIGFkZCBtb3JlIGNoYW5nZWxvZyBsaW5lcwo+IGludG8gdGhlIGZpbGUg
aXRzZWxmLgoKQWNrLiBTb3VuZHMgZ29vZC4gV2lsbCBkcm9wLgoKPiA+Cj4gPiArI2RlZmluZSBO
U0VDX1BFUl9TRUMgMTAwMDAwMDAwMFVMTAo+ID4gK3Vuc2lnbmVkIGxvbmcgbG9uZyB0c19kZWx0
YShzdHJ1Y3QgdGltZXNwZWMgKnN0YXJ0LCBzdHJ1Y3QgdGltZXNwZWMgKnN0b3ApCj4gPiArewo+
ID4gKyAgICAgdW5zaWduZWQgbG9uZyBsb25nIGEsIGI7Cj4gPiArCj4gPiArICAgICBhID0gc3Rh
cnQtPnR2X3NlYyAqIE5TRUNfUEVSX1NFQyArIHN0YXJ0LT50dl9uc2VjOwo+ID4gKyAgICAgYiA9
IHN0b3AtPnR2X3NlYyAqIE5TRUNfUEVSX1NFQyArIHN0b3AtPnR2X25zZWM7Cj4gPiArICAgICBy
ZXR1cm4gYiAtIGE7Cj4gPiArfQo+Cj4gVGhpcyBpcyB0c3RfdGltZXNwZWNfZGlmZigpIGZyb20g
aW5jbHVkZS90c3RfdGltZXIuaAo+CgpBaC4gSSBkaWRuJ3QgZXZlbiB0aGluayB0byBsb29rLCBp
dCdzIHN1Y2ggYSBoYWJpdCB0byBoYW5kIHdyaXRlIGl0IGluCm15IG93biBzbWFsbCB0ZXN0cy4K
ClRob3VnaCB0aGlzIHJ1bnMgaW50byB0aGUgc2FtZSBpc3N1ZSBvZiBjb25mbGljdGluZyBkZWZp
bmVzIGZyb20gdGhlCmxpYnJ0dGVzdC5oLCBzbyB5b3VyIHN1Z2dlc3Rpb25zIHRoZXJlIHdvdWxk
IGJlIGFwcHJlY2lhdGVkLgoKSSBjb3VsZCBwcm9iYWJseSB1dGlsaXplIHRoZSB0c19taW51cy90
c190b19uc2VjIGxvZ2ljIGFzIHdlbGwgaW4KbGlicnR0ZXN0LmggYXMgYW4gYWx0ZXJuYXRpdmUu
CgpUaGFua3MgZm9yIHRoZSByZXZpZXcgZmVlZGJhY2shCi1qb2huCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
