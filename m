Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75437CC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791899187; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hdnRJgTeTDzgSIYul5L4/Rk63xv5MNaKhPZbQK8XC1Q=;
 b=XiDppYuEf5XceSy5GqQhHXZOA240raUdUXDQyF94nIbml+c2HcwMot6b0nNoTLMtD6Rpx
 IptrEsGejXUIARt54M3k5a6LcgVKozaMaG1BAA+ahIVaWGDFYnlqaEIGiT4Rp+0316HrUER
 gH/gh+GHK0htAc07Ia6pMKzm/5LAvTs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53DD43EA82A
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 15:46:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A6793C57DD
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 15:46:05 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E95D1000935
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 15:46:04 +0200 (CEST)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6711f05fb14so2387172d50.2
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 06:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791899163; cv=none;
 d=google.com; s=arc-20260327;
 b=osDs3bmy/SAvsqtp/gtVpchdVHdyMlip2sHJc87UxMqNarBiXwIGhPQ64NT/oCimiJ
 VBKXlSh1WSTWB5eqgDofWsoUYICURFIn9DzaOxBjItuYx1cP6A2NIAuaqXElg0Y1/yzr
 2eBeoCKJASVv/c7cYM92rAzIIl2Z/z3XYi+QTirEhMrYMY65dSJ8USzCzlda60j7h5TK
 ZbG89ihBSxzq6gbmnLKsUQbQaiW8aZNLwoQ6ZF+4Jv+RoKBT62PNaSj3NmpDOw7LCcZx
 U4KqUfr4QZr7Ryi2zy0yuKIZFRKc2FhBHrs7MHdVAJWrAzgQGT83DQTp1yslyfKU9TMx
 gadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p4z+9sk7E+mbZvizFgyWSJ1m31qRoCQZV+cCoqe3Z3M=;
 fh=SQ9N9guitCkSaO+xuxBzp1YyEEXMxSyWmXBWFIZoYuk=;
 b=OGlQG+7aMJoG8qRDodnH5WGXcGAw4cagetSi//qLhrKUb1bise1b5o0KP+yPIozEEC
 dl/JxCD2AkSuFgpgiBNtftO4fo3H3hUkQhsdxSiMzskPKk249gNRT7zAGP5KkL2IqCVK
 qWyXVdgMQ59eBeVTGGEAv6l5eFF6yTe44YJj8AMbxgj3YVzkIeFWCkGNHH0fvLPmevBP
 jixiLFc7LnH5xL0Kf7132xwonFEIe2gJQ1THRIIzgdQ2Q43pQ+S7lc2qIeuoxBmivMVU
 0bCXMW0l2RkNIQX5RfQaBp9rI/I4NRx853rKpDJ752HxcwVZWLjdSqgWV8FF3qYwQC0J
 2Y0A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791899163; x=1792503963; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p4z+9sk7E+mbZvizFgyWSJ1m31qRoCQZV+cCoqe3Z3M=;
 b=e59mAp6Evh09TI5YKFNJ0FJRzVF4NAd40svoOxeqJ77letLi6tVLZZjezUL/vLY2Hp
 01ihF8/YZkAFO6owExNFDPCuoVMUN4VmJZZEo0URQ0ZuP52R0SZSBD30PmTO4wIBDZsE
 Lwq2dNZlyoDQZpkFYhoL+pg5vzSMIAujA8HCrdCciKp/t3BgDuOifXOS0LyHvvI/74x2
 Pt0RdqDet/A0wVPh8QQ9lQLZxdWBDcCvUafD6i0wMiKGZaYsXD6mGeUdHvLHTIhyUj4v
 cYVK9GY8RZNFi1E+oXvnj/6lDAEJdPv+4XpUct4smvWLXaDJ/+7ZVY24OPbmz4tQkVHg
 RWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791899163; x=1792503963;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p4z+9sk7E+mbZvizFgyWSJ1m31qRoCQZV+cCoqe3Z3M=;
 b=tTQAB+L3ylU1HAfb8CimIH/gBX0FwLASdvEjaFLJeKYLbucBtpkFEs7R8/sOEfiqgg
 cjgprub052/CQPhZJ4J6FFUUprNwi9xPdoiildP9pSlaGvs46jad0MIe92xt4DOHTHtw
 tGLUf3+Wq9FxfTBXfRJS4Pxl61AmQM/EKF8Hx6oePghoeOMDAdf9p1xlatEofXNJ0gMg
 SogDnlUFoO9bGtK4mQSP04BalXbPrRPrMQ5nJl4T+RmCEashsNzJdIg1V7cynj0grCO2
 fDAdEfCIzgt8N/X83ooTMSdeukSOAfysH8M2s8FJ06hwYLI7RgSXTen8lz5PJGETUAwO
 sVKA==
X-Gm-Message-State: AFq9FYLm2ozVmHP7Rgrlu3Rm8VmfUHkBbWvO/vhMkQJcCwWi4K7y9Y3S
 ZTHaLDMHX28KZ7sVHNaZzWx2MDk3OWfP0nvM5Pulpc0t8n3PL3aECTN4ms9NgdLtF46fpfpGI0L
 eatlmqQXgWsK9Ac5ijETppyMfDZ8+GFTW3ENKkg/T
X-Gm-Gg: AYBFou2/Vmq9BQ0xZ0IXLQsVqQc+D6hYlhniPjKX2AJpZdtdaWQuoG4+0ZWPAGdsY3b
 7sEHAUYjk1MyF+qNmvFc7OSCs/bYwUycrQkrRd7EAeAMOSqoBgNcVQ533iG3FAs93JhmIJh+E17
 NmDoqLxeAPHOSw6AKsyiqpvQ9CXweU3CTs5hZuYzMP1s8PItGodEqjaEGJv2XBV+XQtmjZAUxuh
 5Xuh3CAhPJzLkGtzaJBvqcewlt8Cu/tmv2U2jtjVPq5X1ETj91VgXXqvuK0mchWV5lsgnRrt7eJ
 u9n4p0nG28cGKqDe0BTNAl6QntW3KXN7SnTFTEEvNUuDYD6Cy46UUBrxrVV5ZoHENs042DMva56
 2tN0f9GdnalwDoQATOpFMy7LcjoEubVGwLcyCHuuPVqU2m4ZE9PXf295638LxcGuNK6B85uMnnW
 1J
X-Received: by 2002:a05:690e:400b:b0:677:d719:7bb5 with SMTP id
 956f58d0204a3-679360612a8mr4882463d50.61.1791899162555; Tue, 13 Oct 2026
 06:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261005061933.4108985-1-wakel@google.com>
 <FYCFwRRq6TwmRBDes8BoKBQ3CBJXcItvx4Jm@localhost.localdomain>
In-Reply-To: <FYCFwRRq6TwmRBDes8BoKBQ3CBJXcItvx4Jm@localhost.localdomain>
Date: Tue, 13 Oct 2026 21:45:25 +0800
X-Gm-Features: AclHuK9kdS122-lLGWLJtR3tE_ehZavILtEllx5O821-gI2TaMVYXgZNuSZuq_4
Message-ID: <CAOcRiAGowTMaxdJmSS61_PmQLsuwUO+iS-NVkWJC46CHNpqNJw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pathconf01: Allow EINVAL where POSIX leaves
 support unspecified
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiA+ICsgLyogUE9TSVggbGVhdmVzIHN1cHBvcnQgZm9yIGEgZGlyZWN0b3J5
IHVuc3BlY2lmaWVkICovCj4gPiArIGludCBlaW52YWxfb2s7Cj4KPiBVc3VhbGx5LCBpbiB0aGVz
ZSBjYXNlcywgaXQncyBiZXR0ZXIgdG8gZGVmaW5lIGFuIGFycmF5IG9mIGVycm5vIHdlIG1pZ2h0
Cj4gaGF2ZSB3aGVuIHdlIHRyaWdnZXIgdGhlIHN5c2NhbGwgaW4gYSBjZXJ0YWluIHdheS4gQW5k
IHRoZW4gd2UgdXNlCj4gVFNUX0VYUF9BUlJfRkFJTCgpIG9uIGl0LgoKVGhhbmtzIGZvciB0aGUg
cmV2aWV3IQoKcGF0aGNvbmYwMSBpcyBhIHBvc2l0aXZlIHRlc3QsIGFuZCB0aGUgZWludmFsX29r
IG5hbWVzIGFjdHVhbGx5IHN1Y2NlZWQKb24gZ2xpYmMsIG11c2wgYW5kIEJpb25pYyBzaW5jZSBB
bmRyb2lkIDE1OiB0aGV5IHJldHVybiA+PSAwLCBvciAtMQp3aXRob3V0IGNoYW5naW5nIGVycm5v
LgoKVFNUX0VYUF9GQUlMX0FSUigpIGFuZCBUU1RfRVhQX0ZBSUwyX0FSUigpIGV4cGVjdCB0aGUg
Y2FsbCB0byBmYWlsLCBzbwp0aGV5IHJlcG9ydCBURkFJTCB3aGVyZXZlciB0aGVzZSBuYW1lcyBh
cmUgc3VwcG9ydGVkIGZvciBkaXJlY3Rvcmllcy4KSSB0cmllZCBUU1RfRVhQX0ZBSUwyX0FSUigp
IGFuZCBhbGwgMTAgZWludmFsX29rIG5hbWVzIGZhaWwgb24gZ2xpYmMKKCJzdWNjZWVkZWQiIG9y
ICJleHBlY3RlZCBFSU5WQUw6IFNVQ0NFU1MgKDApIikuCgpIZXJlIHdlIHN0aWxsIGV4cGVjdCBw
YXRoY29uZigpIHRvIHN1Y2NlZWQsIGFuZCBvbmx5IHdhbnQgdG8gdHJlYXQKRUlOVkFMIGFzIFRD
T05GIGZvciB0aGUgbmFtZXMgd2hlcmUgUE9TSVggbGVhdmVzIGRpcmVjdG9yeSBzdXBwb3J0CnVu
c3BlY2lmaWVkIChQT1NJWCBvbmx5IGRlZmluZXMgRUlOVkFMIGZvciB0aGlzIGNhc2UpLgoKRG9l
cyBrZWVwaW5nIHRoZSBlaW52YWxfb2sgY2hlY2sgbWFrZSBzZW5zZSB0byB5b3UsIG9yIHdvdWxk
IHlvdSBzdGlsbApwcmVmZXIgc3RvcmluZyBhbiBleHBfZXJycyBhcnJheSBpbiBzdHJ1Y3QgdGNh
c2UgYW5kIGNoZWNraW5nIGl0IHdpdGgKdHN0X2Vycm5vX2luX3NldCgpLCB0aGUgaGVscGVyIGJl
aGluZCBUU1RfRVhQX0ZBSUxfQVJSKCk/CgpCZXN0IHJlZ2FyZHMsCldha2UKCgpPbiBUdWUsIE9j
dCAxMywgMjAyNiBhdCAxMjoyMOKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkgV2FrZSwKPgo+ID4gUE9TSVggbGlzdHMgdHdvIEVJ
TlZBTCBjYXNlcyBmb3IgcGF0aGNvbmYoKS4gSXQgc2hhbGwgZmFpbCB3aXRoIEVJTlZBTAo+ID4g
d2hlbiB0aGUgdmFsdWUgb2YgbmFtZSBpcyBub3QgdmFsaWQuIEl0IG1heSBhbHNvIGZhaWwgd2l0
aCBFSU5WQUwgd2hlbgo+ID4gInRoZSBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBzdXBwb3J0IGFu
IGFzc29jaWF0aW9uIG9mIHRoZSB2YXJpYWJsZQo+ID4gbmFtZSB3aXRoIHRoZSBzcGVjaWZpZWQg
ZmlsZSIuCj4gPgo+ID4gVGhlIHRlc3QgYWx3YXlzIGNhbGxzIHBhdGhjb25mKCkgb24gYSBkaXJl
Y3RvcnkuIEZvciBhIGRpcmVjdG9yeSwgUE9TSVgKPiA+IGxlYXZlcyBpdCB1bnNwZWNpZmllZCB3
aGV0aGVyIF9QQ19NQVhfQ0FOT04sIF9QQ19NQVhfSU5QVVQgYW5kCj4gPiBfUENfVkRJU0FCTEUg
KG5vdGUgMiksIF9QQ19BU1lOQ19JTywgX1BDX1BSSU9fSU8gYW5kIF9QQ19TWU5DX0lPCj4gPiAo
bm90ZSA4KSBhbmQgdGhlIF9QQ19SRUNfKiBuYW1lcyAobm90ZSAxMCkgYXJlIHN1cHBvcnRlZCwg
c28gRUlOVkFMIGlzCj4gPiBhbGxvd2VkIGZvciB0aGVtLgo+ID4KPiA+IEJpb25pYyBiZWZvcmUg
QW5kcm9pZCAxNSByZXR1cm5zIC0xIGFuZCBzZXRzIGVycm5vIHRvIEVJTlZBTCBmb3IKPiA+IF9Q
Q19SRUNfSU5DUl9YRkVSX1NJWkUgYW5kIF9QQ19SRUNfTUFYX1hGRVJfU0laRSwgd2hpY2ggbWFr
ZXMgdGhlIHRlc3QKPiA+IGZhaWwuCj4gPgo+ID4gUmVwb3J0IEVJTlZBTCBhcyBUQ09ORiBmb3Ig
dGhlc2UgbmFtZXMuIEVJTlZBTCBmb3IgdGhlIG90aGVyIG5hbWVzIGlzCj4gPiBzdGlsbCBhIGZh
aWx1cmUuCj4gPgo+ID4gQWxzbyBwcmludCB0aGUgbmFtZSBhbmQgZXJybm8gb24gZmFpbHVyZSwg
c28gaXQgaXMgY2xlYXIgd2hpY2ggbmFtZQo+ID4gZmFpbGVkLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFdha2UgTGl1IDx3YWtlbEBnb29nbGUuY29tPgo+ID4gLS0tCj4gPiAgLi4uL2tlcm5lbC9z
eXNjYWxscy9wYXRoY29uZi9wYXRoY29uZjAxLmMgICAgIHwgMzYgKysrKysrKysrKysrLS0tLS0t
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXRoY29uZi9w
YXRoY29uZjAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdGhjb25mL3BhdGhjb25m
MDEuYwo+ID4gaW5kZXggNWFmNDVlNDE3Li42MzVjMzU2YmMgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdGhjb25mL3BhdGhjb25mMDEuYwo+ID4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXRoY29uZi9wYXRoY29uZjAxLmMKPiA+IEBAIC0xOSwy
NCArMTksMjYgQEAgc3RhdGljIGNoYXIgKnBhdGg7Cj4gPiAgc3RhdGljIHN0cnVjdCB0Y2FzZSB7
Cj4gPiAgICAgICBpbnQgdmFsdWU7Cj4gPiAgICAgICBjaGFyICpuYW1lOwo+ID4gKyAgICAgLyog
UE9TSVggbGVhdmVzIHN1cHBvcnQgZm9yIGEgZGlyZWN0b3J5IHVuc3BlY2lmaWVkICovCj4gPiAr
ICAgICBpbnQgZWludmFsX29rOwo+Cj4gVXN1YWxseSwgaW4gdGhlc2UgY2FzZXMsIGl0J3MgYmV0
dGVyIHRvIGRlZmluZSBhbiBhcnJheSBvZiBlcnJubyB3ZSBtaWdodAo+IGhhdmUgd2hlbiB3ZSB0
cmlnZ2VyIHRoZSBzeXNjYWxsIGluIGEgY2VydGFpbiB3YXkuIEFuZCB0aGVuIHdlIHVzZQo+IFRT
VF9FWFBfQVJSX0ZBSUwoKSBvbiBpdC4KPgo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0Ug
UUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20K
CgoKLS0gCkJlc3QgUmVnYXJkcywKV2FrZSBMaXUKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
