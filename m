Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C84C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 13:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C25133CF9E7
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 15:24:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D68F3CECEA
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 15:23:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 42C311400BDC
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 15:23:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714051426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1VA4qJr4g75mliA5v5ND61y2WLbjy7UDHbsBUYU44Y=;
 b=HlDT75bmJExogjk0Kh489azHI7GEIwU57DiVhD1t+BaFrrjyQiSZEsyasQ3rBvoUyPHiSq
 a5BUCI9oQ0RrklmLzFnRFLjlhWnVa4paWmlhMGWokvcjTxPG+xo/jiCM+HsMpYZmZGAcqo
 fnrFOvMq4/M8RmDSCpDmseQNuB1GihM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-_McPyGOONW-3HVa0s5Ru6Q-1; Thu, 25 Apr 2024 09:23:45 -0400
X-MC-Unique: _McPyGOONW-3HVa0s5Ru6Q-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-22ee151dc4bso1048795fac.1
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 06:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714051424; x=1714656224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1VA4qJr4g75mliA5v5ND61y2WLbjy7UDHbsBUYU44Y=;
 b=lO1JZoC7/RxNlrzjH+9lY5qVjlcdXu9yzq2Qggo7flP87RyNh12dphJwSohDQ0snbw
 e1qOImgCx8xKiEThQWG9hqRCEJIW2rYK7Y4f/thbApiWLoQcAqygDH58IXy21BTydXRN
 7zC0IyGs5S+jRDbC4h1bJYMLrE8YrvXApl8tHSuK3GrhtVyxMIbZTynPtcNGdx3+3OXv
 afNS7tQg47ZvFgpppbzAS7dogkQk4vwNKzJPyZGhjKQRyiBNG1soiWp0BJVrHAs6LUHk
 9HbJvtwdZbs3+35/YdbQIRCBVstZNwZ/Su7rt8+7rnTE7+ANzA90+OhWVnjg/xS8jWcu
 rnkQ==
X-Gm-Message-State: AOJu0YzfVUgyvmIxmWulU22s0cpRXuTz+92wyGfoG9VoY9jhuIvPbGZq
 iDyDfXrxibboHfdzaDEimaS0Wj7atWaSy//kP1P2HYkUXds/fPP3nWcSmdOw9WgYfhMPW/jYgtu
 u+OaLiyd7+F4a7L9p72F2XEYrra4HCP/MAgnMFmnwwUWFFD487p4MKRNhkeJDbQ79vzU+IaFyRd
 IXI0e6qRvLgRPI5UVL/ADU8Aw=
X-Received: by 2002:a05:687c:210:b0:22e:ae01:db2f with SMTP id
 ax16-20020a05687c021000b0022eae01db2fmr4735532oac.36.1714051424194; 
 Thu, 25 Apr 2024 06:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhTxbA/21X7DleCE185iCC739AflwMa5uA5ub88n/ntpMQV+KHziIxc0JM2IwMqXBQPAiYncLaYta5M1N0Cuk=
X-Received: by 2002:a05:687c:210:b0:22e:ae01:db2f with SMTP id
 ax16-20020a05687c021000b0022eae01db2fmr4735504oac.36.1714051423704; Thu, 25
 Apr 2024 06:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240423132823.194179-1-pvorel@suse.cz>
 <20240423132823.194179-2-pvorel@suse.cz>
 <CAASaF6wWtdmG6nWpWcTv=AnzJn8vSe71RQsSkcF-1wHbPb_Mjw@mail.gmail.com>
 <20240424121740.GA227922@pevik>
In-Reply-To: <20240424121740.GA227922@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Apr 2024 15:23:28 +0200
Message-ID: <CAASaF6yfGK5zHMW0wQxWM+r+6=dT_sT+5HSqJPLadhQ1O85KZw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/fs: Include lapi/fcntl.h + define
 _GNU_SOURCE
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

T24gV2VkLCBBcHIgMjQsIDIwMjQgYXQgMjoxN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+ID4gT24gVHVlLCBBcHIgMjMsIDIwMjQgYXQgMzoy
OOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiBUaGlzIGZp
eGVzIGJ1aWxkIGVycm9yIG9uIG11c2wgKGFscGluZSk6Cj4KPiA+ID4gSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIHVubGluazA5LmM6MTg6Cj4gPiA+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5o
OjU4OjE1OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ2xvZmZfdCcKPiA+ID4gICAgNTggfCBz
dGF0aWMgaW5saW5lIGxvZmZfdCB0c3RfbWF4X2xmc19maWxlc2l6ZSh2b2lkKQo+Cj4gPiA+IGxv
ZmZfdCBpcyBkZWZpbmVkIGluIDxmY250bC5oPiAoYnV0IGd1YXJkZWQgX0dOVV9TT1VSQ0UpLCBi
dXQganVzdCBmb3IKPiA+ID4gc2FmZXR5IGluY2x1ZGUgbGFwaS9mY250bC5oIGluIGNhc2UgbGFw
aS9mcy5oIGlzIGluY2x1ZGVkIGluIHRlc3Qgd2hpY2gKPiA+ID4gbmVlZHMgZmFsbGJhY2sgZGVm
aW5pdGlvbnMgZnJvbSBsYXBpL2ZzLmguCj4KPiA+IFlvdSBwcm9iYWJseSBtZWFudCBsYXBpL2Zj
bnRsLmggaGVyZSBeXgo+Cj4gKzEKPgo+ID4gPiBCZWNhdXNlIHdlIHJlcXVpcmUgX0dOVV9TT1VS
Q0UgZGVmaW5pdGlvbiBmb3IgY29kZSBpbiBsYXBpL2ZzLmgsIHRoYXQncwo+ID4gPiB3aHkgdGhl
cmUgaXMgdGhlIGRlZmluaXRpb24gaW4gYm90aCB1bmxpbmswOS5jICh0aGUgYWN0dWFsIGZpeCkg
YW5kCj4gPiA+IGxhcGkvZnMuaCBmb3IgdmlzaWJpbGl0eSBvZiB0aGUgcHJvYmxlbS4KPgo+ID4g
PiBGaXhlczogMmNmNzhmNDdhICgidW5saW5rOiBBZGQgZXJyb3IgdGVzdHMgZm9yIEVQRVJNIGFu
ZCBFUk9GUyIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+ID4gPiAtLS0KPiA+ID4gI2RlZmluZSBfR05VX1NPVVJDRSBwYWluIGFnYWluLiBXb3VsZCB5
b3Ugc29sdmUgaXQgZGlmZmVyZW50bHk/Cj4KPiA+IEknZCBsaWtlbHkgZ28gc2ltaWxhciByb3V0
ZSwgYnV0IEknZCBkcm9wIHRoZSBodW5rIGZyb20gdW5saW5rMDkuYy4KPiA+IFRoZSB0ZXN0IGlz
IG5vdCB1c2luZyBsb2ZmX3QgZGlyZWN0bHksIGl0IGluY2x1ZGVzIGEgaGVhZGVyLCBzbyBpdAo+
ID4gc2hvdWxkIGJlIHVwIHRvCj4KPiBGaXJzdCwgdGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmll
dyEKPgo+IE9LLCB0aGlzIHdpbGwgd29yaywganVzdCBsYXBpL2ZzLmggbXVzdCBiZSBsb2FkZWQg
YmVmb3JlIHRzdF90ZXN0LmgsCj4gb3RoZXdpc2UgaXQgd291bGQgZmFpbCBvbiBBbHBpbmU6CgpT
byB0aGlzIGlzIGVzc2VudGlhbGx5OgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KI2luY2x1ZGUgPGZjbnRsLmg+IC8vIGZyb20gdHN0X3Rlc3QuaCBpbmNsdWRlIGNo
YWluCiNkZWZpbmUgX0dOVV9TT1VSQ0UgLy8gZnJvbSBsYXBpL2ZzLmgKI2luY2x1ZGUgPGZjbnRs
Lmg+CgppbnQgbWFpbih2b2lkKQp7CiAgICAgICAgbG9mZl90IGFzZDsKICAgICAgICByZXR1cm4g
MDsKfQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCmFuZCBpdCBk
b2Vzbid0IGNvbXBpbGUuIEFuZCBzYW1lIGFwcGxpZXMgaWYgeW91IGluY2x1ZGUgZmlyc3QgYW55
IG9mCnRoZXNlIGZpcnN0OgppbmNsdWRlL2xhcGkvZmNudGwuaDojaW5jbHVkZSA8ZmNudGwuaD4K
aW5jbHVkZS9sYXBpL2lvX3VyaW5nLmg6I2luY2x1ZGUgPGZjbnRsLmg+CmluY2x1ZGUvbGFwaS9w
aWRmZC5oOiNpbmNsdWRlIDxmY250bC5oPgppbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmg6I2luY2x1
ZGUgPGZjbnRsLmg+CmluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6I2luY2x1ZGUgPGZjbnRsLmg+
CgpEbyB3ZSByZWFsbHkgbmVlZCBmb3IgdHN0X21heF9sZnNfZmlsZXNpemUoKSB0byByZXR1cm4g
bG9mZl90PyBJZiB3ZQpjaGFuZ2VkIGl0IHRvICJsb25nIGxvbmciLAp3ZSdkIGF2b2lkIGxvdCBv
ZiBpc3N1ZXMgd2l0aCBpbmNsdWRlcyBhbmQgX0dOVV9TT1VSQ0UgZm9yIGp1c3Qgc2luZ2xlCnVz
ZXIgb2YgdGhpcyBmdW5jdGlvbi4KCgoKCgoKPgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB1bmxp
bmswOS5jOjIwOgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5oOjYxOjE1OiBlcnJvcjog
dW5rbm93biB0eXBlIG5hbWUgJ2xvZmZfdCcKPiAgICA2MSB8IHN0YXRpYyBpbmxpbmUgbG9mZl90
IHRzdF9tYXhfbGZzX2ZpbGVzaXplKHZvaWQpCj4gICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+
fgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5oOiBJbiBmdW5jdGlvbiAndHN0X21heF9s
ZnNfZmlsZXNpemUnOgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5oOjY0OjE3OiBlcnJv
cjogJ2xvZmZfdCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQg
eW91IG1lYW4gJ29mZl90Jz8KPiAgICA2NCB8ICAgICAgICAgcmV0dXJuIChsb2ZmX3QpTExPTkdf
TUFYOwo+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fgo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgIG9mZl90Cj4gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzLmg6NjQ6MTc6IG5vdGU6
IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFj
aCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzLmg6
NjQ6MjQ6IGVycm9yOiBleHBlY3RlZCAnOycgYmVmb3JlIG51bWVyaWMgY29uc3RhbnQKPiAgICA2
NCB8ICAgICAgICAgcmV0dXJuIChsb2ZmX3QpTExPTkdfTUFYOwo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICBeCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIDsKPiBtYWtl
OiAqKiogWy4uLy4uLy4uLy4uL2luY2x1ZGUvbWsvcnVsZXMubWs6NDU6IHVubGluazA5XSBFcnJv
ciAxCj4KPiAoZ2xpYmMgaGlkZXMgbG9mZl90IGJlaGluZCBfX1VTRV9NSVNDLCB3aGljaCBJIHRo
b3VnaHQgaXQgaXQncyBpbiB0aGUgZW5kCj4gX0dOVV9TT1VSQ0UsIGJ1dCBvYnZpb3VzbHkgbm90
KS4KPgo+IEFuZCB1c2luZyBpbmNsdWRlL2xhcGkvZnMuaCBhbmQgbW9zdCBvZiBsYXBpIGhlYWRl
cnMgaXQncyBvayB0byB1c2UgdGhlbSBiZWZvcmUKPiB0c3RfdGVzdC5oIChzb21lIG9mIHRoZW0g
YXJlIHN0aWxsIHVzZWQgZm9yIHRoZSBvbGQgQVBJKS4gQnV0Cj4gaW5jbHVkZS9sYXBpL2dldHJh
bmRvbS5oIHdpbGwgYnJlYWsgdGhpcyBhc3N1bXB0aW9uIGFuZCBpdCBjYW4gY2F1c2UgdGhlCj4g
dHJvdWJsZXMgaWYgaW5jbHVkZS9sYXBpL2dldHJhbmRvbS5oIG5lZWRzIGluY2x1ZGUvbGFwaS9m
Y250bC5oIG9yIDxmY250bC5oPikuCj4KPiBBbHNvIG15IG5vdC15ZXQtZmluaXNoZWQgZWZmb3J0
IHdpdGggc2FmZV9mYWxsb2NhdGUoKSBbMV0gaGFkIHRoaXMgcHJvYmxlbQo+IChyZXF1aXJlcyA8
ZmNudGwuaD4pLCBidXQgSSdsbCBzb2x2ZSB0aGlzIHdpdGggcHJvdmlkaW5nIGZhbGxvY2F0ZSgp
IGRlY2xhcmF0aW9uCj4gYXMgeW91IHN1Z2dlc3RlZC4KPgo+ID4gdGhhdCBoZWFkZXIgdG8gd29y
ayB3aXRob3V0IHByZS1leGlzdGluZyBkZWZpbmVzLgo+Cj4KPiA+ID4gIGluY2x1ZGUvbGFwaS9m
cy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA1ICsrKystCj4gPiA+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jIHwgMiArKwo+ID4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+ID4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9sYXBpL2ZzLmggYi9pbmNsdWRlL2xhcGkvZnMuaAo+ID4gPiBpbmRleCBjMTll
ZTgyMWQuLjQ2ODBmMDA5MCAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS9sYXBpL2ZzLmgKPiA+
ID4gKysrIGIvaW5jbHVkZS9sYXBpL2ZzLmgKPiA+ID4gQEAgLTksMTUgKzksMTggQEAKPiA+ID4g
ICNpZm5kZWYgTEFQSV9GU19IX18KPiA+ID4gICNkZWZpbmUgTEFQSV9GU19IX18KPgo+ID4gPiAr
I2RlZmluZSBfR05VX1NPVVJDRSAvKiBsb2ZmX3QgaW4gPGZjbnRsLmg+ICovCj4KPiA+IEknZCBh
bHNvIGFkZCB0byBjb21tZW50IGhlcmUgdGhhdCBpdCdzIGluY2x1ZGVkIHZpYSBsYXBpL2ZjbnRs
LmgKPgo+ICsxCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2x0cC8yMDI0MDQxMjExNDYxNi5HQjQyNzc0NkBwZXZpay8KPgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
