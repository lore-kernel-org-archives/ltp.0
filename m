Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B7BC88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789480885; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wf9dji0uESc8BTGS+7vfc4cE474As1WjUS3LC4N3WQs=;
 b=MlFMjlpzlir9HyTufy9NB8hngIyHNpbxfPVsG5JY5Kd0D04qtYhXToZPixZAqR1kBu1Cv
 tenKFe+siLgrYxYGh20oh+jOZzvqNZaOZl4f9vnXoIkfpJfeuK/9UgRmMly+J1vPRzvhKDF
 fjJig/5zlUGy3GkexnVHMbbSjlfu99c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E842D3E8CCB
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 16:01:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 646583E8C96
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:01:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFD8C1000968
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789480863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bj3hUDW59wZxSznthpsd3pEjyORMaV0gjri7V+uq7gM=;
 b=JgS8VLxJv4SbXPwn35iOftn6jg6MfurGeMCeVjgHtby9Ngp2A7QbgAbCQtzaSP5MQjTKKx
 B13MH9olizATPqQFElDSCINx0PqZHdpWzL0bm33OCFimzDm7T4Sw4NroMx7BbZMiDKtKID
 mZH5qDsv+HHS/1xBBRcMe6c1p4hdnOE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-o0gYDyOGPoC4v3peLtKSDA-1; Tue, 15 Sep 2026 10:00:59 -0400
X-MC-Unique: o0gYDyOGPoC4v3peLtKSDA-1
X-Mimecast-MFC-AGG-ID: o0gYDyOGPoC4v3peLtKSDA_1789480857
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a3540f42beso31532561fa.2
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789480857; x=1790085657;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bj3hUDW59wZxSznthpsd3pEjyORMaV0gjri7V+uq7gM=;
 b=dwaxnS0LNWqos3n7+Eo86N9zAuqsjzjLvWl0JWwWGkKL+7lwVvqaj0+cZi/8MM42JQ
 Xu2TJC15O2426+FEludKSdqY4/NZCaa1UjuY7BuIfERwlx37BcRUOFrGPOcZHiKrrFC/
 It0nnT98ttLu/d98Q703HA7DfO7dVggwcWqYcCkN3RhHa8LhWtnCbWKBb+xlliMEKE6W
 jAeQF0kuxdLYU4sLajsrovnVjz5Qg2cHxt3AAfhTmAUG/1ZjMgKQ8NNhEwTUZh6IAq+n
 XVNJoyEDLij+JxO9OWy6btjMMP7tiR1rviE7OWKF7FU3sbtmAUpoiIb1/1BirKg6aSCd
 5I3Q==
X-Gm-Message-State: AFuF++lEZcU3Gpdm0jMfB9gvLrsMHDCGxjMWDGN9GXRSVswtXCBEhnBu
 uIl1jUpZXkhV+lUOh8aHp1MuSb7M/zXPqMa4u055QLVowexGEYvxc+2hOSNpnmiuM63tjXAjfNe
 5DwHvKROizK8Q4pK9GB1vjY/o06wcXBDNKpFW8Zi88ROgvz5aWVt98JPpT3rUHGXjjuzsFMba4A
 BvKO9aBxAVF8Vz/4EMcAjDB/u2Ojg=
X-Gm-Gg: AYBFou1NxWRSuA9377atWFYf7IXJrFTbYNUqJWCCejZI9HRDcKToJtYmAIjwIEndung
 H2jEA8xMY8CZ88LD7PmYufE06lnbCAO76vPTdSmmz2YB8yWE2ILo+j30Css5xRjopcUYgPdrfL+
 Zc6U/XUlG8tGIwKPZUy+NVw+VQOXJiaOqF8HURB28/7HxuiGuB6gMWYckL
X-Received: by 2002:a2e:a58c:0:b0:3a3:3170:5420 with SMTP id
 38308e7fff4ca-3a5c885c899mr12571261fa.3.1789480857391; 
 Tue, 15 Sep 2026 07:00:57 -0700 (PDT)
X-Received: by 2002:a2e:a58c:0:b0:3a3:3170:5420 with SMTP id
 38308e7fff4ca-3a5c885c899mr12570981fa.3.1789480856019; Tue, 15 Sep 2026
 07:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260908092248.15774-1-mmenashe@redhat.com>
 <aqlAt5wCGegscwBS@yuki.lan>
In-Reply-To: <aqlAt5wCGegscwBS@yuki.lan>
Date: Tue, 15 Sep 2026 17:00:39 +0300
X-Gm-Features: AcwNN1VEZlCayRZKFxNgZBa9kyjMCW2g9_w2imp4LbQ-EWxnLvx7DCaimq-N_fE
Message-ID: <CAHGiOXdkKcpTTqaTxH-xVwPP-MTDOkpe837Q-xrgO8Hro5gdTA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vuijxgAylPz93CAWHsLUmmfc72at3HgI_wfQiEu30t8_1789480857
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] read_all: Fix buffer too small for long paths
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwKVGhhbmtzIGZvciBleHBsYWluaW5nIHRoZSBwcm9ibGVtIHdpdGggdGhlIGNvZGUu
IEkgdG9vayBhIGJldHRlciBsb29rIGF0IGl0LgpIb3cgYWJvdXQgY2hlY2tpbmcgYmVmb3JlIHRo
ZSB3cml0ZSBpbnN0ZWFkOgoKICAgICAgd2hpbGUgKHEtPmRhdGFbaV0pIHsKICAgICAgICAgIGlm
IChqID49IEJVRkZFUl9TSVpFIC0gMSkKICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiQnVm
ZmVyIGlzIHRvbyBzbWFsbCBmb3IgcGF0aCIpOwoKICAgICAgICAgIHEtPnBvcHBlZFtqKytdID0g
cS0+ZGF0YVtpXTsKICAgICAgICAgIGkgPSAoaSArIDEpICUgUVVFVUVfU0laRTsKICAgICAgfQog
ICAgICBxLT5wb3BwZWRbal0gPSAnXDAnOwoKICBqIGNhbiBuZXZlciByZWFjaCBCVUZGRVJfU0la
RSB3aXRob3V0IFRCUk9LLCBhbmQgUEFUSF9NQVggLSAxIHBhdGhzCiAgc3RpbGwgZml0LiBEb2Vz
IHRoaXMgbG9vayBnb29kIHRvIHlvdT8KCiAgVGhhbmtzLAogIE1pY2hhZWwgTWVuYXNoZXJvdi4K
Ck9uIFR1ZSwgU2VwIDE1LCAyMDI2IGF0IDM6NTfigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
ZnMvcmVhZF9hbGwvcmVhZF9hbGwuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9yZWFkX2FsbC9y
ZWFkX2FsbC5jCj4gPiBpbmRleCA1NzIwZmZiOTkuLmVjOTQ1NGZjOSAxMDA2NDQKPiA+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvZnMvcmVhZF9hbGwvcmVhZF9hbGwuYwo+ID4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9mcy9yZWFkX2FsbC9yZWFkX2FsbC5jCj4gPiBAQCAtNTEsOCArNTEsOCBAQAo+
ID4gICNpbmNsdWRlICJ0c3RfdGltZXIuaCIKPiA+Cj4gPiAgI2RlZmluZSBRVUVVRV9TSVpFIDE2
Mzg0Cj4gPiAtI2RlZmluZSBCVUZGRVJfU0laRSAxMDI0Cj4gPiAtI2RlZmluZSBNQVhfUEFUSCA0
MDk2Cj4gPiArI2RlZmluZSBCVUZGRVJfU0laRSBQQVRIX01BWAo+ID4gKyNkZWZpbmUgTUFYX1BB
VEggUEFUSF9NQVgKPiA+ICAjZGVmaW5lIE1BWF9ESVNQTEFZIDQwCj4KPiBUaGlzIHBhcnQgbG9v
a3MgZ29vZC4KPgo+ID4gIHN0cnVjdCBxdWV1ZSB7Cj4gPiBAQCAtMTMxLDcgKzEzMSw3IEBAIHN0
YXRpYyBpbnQgcXVldWVfcG9wKHN0cnVjdCBxdWV1ZSAqcSkKPiA+ICAgICAgIHdoaWxlIChxLT5k
YXRhW2ldKSB7Cj4gPiAgICAgICAgICAgICAgIHEtPnBvcHBlZFtqXSA9IHEtPmRhdGFbaV07Cj4g
Pgo+ID4gLSAgICAgICAgICAgICBpZiAoKytqID49IEJVRkZFUl9TSVpFIC0gMSkKPiA+ICsgICAg
ICAgICAgICAgaWYgKCsraiA+PSBCVUZGRVJfU0laRSkKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICB0c3RfYnJrKFRCUk9LLCAiQnVmZmVyIGlzIHRvbyBzbWFsbCBmb3IgcGF0aCIpOwo+ID4KPiA+
ICAgICAgICAgICAgICAgIGkgPSAoaSArIDEpICUgUVVFVUVfU0laRTsKPgo+IEhvd2V2ZXIgaGVy
ZSB3ZSBkbzoKPgo+IHEtPnBvcHBlZFtqXSA9ICdcMCc7Cj4KPiBTbyBqIG11c3QgYmUgYXQgbW9z
dCBCVUZGRVJfU0laRS0xIGFuZCB3aXRoIHRoZSBjaGFuZ2UgYWJvdmUgaiBtYXkgZW5kCj4gdXAg
ZXF1YWwgdG8gQlVGRkVSX1NJWkUgYW5kIHdlIHdpbGwgbGFuZCBvZmYgYnkgb25lIGluIHRoZSBh
cnJheS4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gCgpN
aWNoYWVsIE1lbmFzaGVyb3YKClNvZnR3YXJlIFF1YWxpdHkgRW5naW5lZXIgLSBBdXRvbW90aXZl
IEtlcm5lbAoKUmVkIEhhdCA8aHR0cHM6Ly93d3cucmVkaGF0LmNvbS8+CjxodHRwczovL3d3dy5y
ZWRoYXQuY29tLz4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
