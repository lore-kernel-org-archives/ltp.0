Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C09BC7619A
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 06:57:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C8B33CD2F9
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 07:57:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AF563C4C12
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 07:56:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6B86D600810
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 07:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679381811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NAiJTrS2P/sE+G5kw5FY8bA2WUpechhEpUUXssARzKs=;
 b=JPGq2P3ZmFtxMG+BIhH/2r/mpO2vWVEisap0tOLUffEn1UtD1rFZLU3ymIozNbDuFfgJuy
 EhGBdIwsS1W0FE2e9QV/vTC5uifK3oKGuKjLvFK8oo/XB+c649J1jctZUd5ZwpD0zERY01
 NPEYCjfHs3gZo+yC9Li0ZuoCZaOaJXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-JQ7BaSRCPeeKwN2I_wNOdQ-1; Tue, 21 Mar 2023 02:56:49 -0400
X-MC-Unique: JQ7BaSRCPeeKwN2I_wNOdQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay12-20020a05600c1e0c00b003ed201dcf71so6592167wmb.4
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679381808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NAiJTrS2P/sE+G5kw5FY8bA2WUpechhEpUUXssARzKs=;
 b=WOeQF89OtPv2BV7E9zVl9sFbGbPaxIZvSsPX9aofoeyqXMf9klxGa39YAsN/mTzBJJ
 RdfIox72CVEZkRaSWOlm8794k3EsnNxwdvUOn5yGGxSgh9lNzWOzQfPYNpK1eZXd+vtE
 XoI0B3QeNRn0y8QwvNtIQwCthWObZY9QkrOmFv+t27y/dWPQqJtEqDW4wa1PQ+lyQkIU
 cKHTf7zo2wYcZRDpJKTUOVPA1QZBoa1LSIE/oiJRKGfGWnQtTWpPLMH4RdqCIACWT8P5
 46WppjBK7NHXEUj5XgWEAPdaoha8tDBUf3DjmPYMNXZt/rhP8BMHpl+VgOE93E2l9sNa
 ZNKw==
X-Gm-Message-State: AO0yUKVwrbgHgxJ2/VEgDZcM4pdVctbupTGzPnMty/q/9Cg1KFHcL7mb
 SBzv3kO/TtyC+wxohX8LoQzW6AEKAcCTKGhbgHemEkpc+u0uDbypnUFv+AFsR+2wM9n33sLRMub
 bHP3Rn62MWJbWh5i0w30xme3bh4U=
X-Received: by 2002:a5d:5685:0:b0:2ca:4533:5d6a with SMTP id
 f5-20020a5d5685000000b002ca45335d6amr391674wrv.7.1679381808644; 
 Mon, 20 Mar 2023 23:56:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set8f6fYhGv0ro0k06k6Vk9RXLMDyQ9DwLQ0PGD/FJhtNz78egLbCOG7BakEIOxOT8Y6qEKMdi+i6Iuvy7C+Nw6Q=
X-Received: by 2002:a5d:5685:0:b0:2ca:4533:5d6a with SMTP id
 f5-20020a5d5685000000b002ca45335d6amr391668wrv.7.1679381808273; Mon, 20 Mar
 2023 23:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230320092332.36187-1-pifang@redhat.com>
In-Reply-To: <20230320092332.36187-1-pifang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Mar 2023 14:56:37 +0800
Message-ID: <CAEemH2edWRT1f=8wb=qQn2=3L0CXD-sQ4qQUSk+DwcRWE8xqqA@mail.gmail.com>
To: Ping Fang <pifang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getcpu01: Fix strtoul incorrectly returns 0
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
Cc: shichen@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGluZywKCkdvb2QgY2F0Y2ghCgpPbiBNb24sIE1hciAyMCwgMjAyMyBhdCA1OjIz4oCvUE0g
UGluZyBGYW5nIDxwaWZhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+IGdldF9ub2RlaWQoKSBmaW5k
IG5vZGVpZCBieSBpdGVyYXRlIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlWC9jcHVZLgo+
IEJ1dCB0aGVyZSBhcmUgY3B1bGlzdCBhbmQgY3B1bWFwLCB3aGljaCB3aWxsIHJlcG9ydCAwIGlu
IHN0cnRvdWwuCj4gT24gbXVsdGktbm9kZSBudW1hIHN5c3RlbSwgdGhlIGxhc3QgaXRlcmF0aW9u
IG5vZGVYIGRpcmVjdG9yeSBtaXNtYXRjaAo+IHRoZSBjcHUwIG5vZGUgaWQuIFRoZW4gZmFpbCB0
aGUgdGVzdC4gVGhlIGZvbGxvd2luZyBzaG93cyBvbiBhIDQgbm9kZQo+IG51bWEgc3lzdGVtLiBU
aGUgbGFzdCBpdGVyYXRpb24gc3RvcHBlZCB1bmRlciAvbm9kZTEuIHNvIGV4cGVjdGVkIG5vZGUK
PiBpZCAxLiBUaGVuIGZhaWxlZC4KPgo+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1
X2lkOjAsIGRlLT5kX25hbWU6bm9kZTIKPiBnZXRjcHUwMS5jOjk5OiBUSU5GTzogZG4tPmRfbmFt
ZTpjcHVsaXN0Cj4gZ2V0Y3B1MDEuYzo5ODogVElORk86IGNwdTowLCBjcHVfaWQ6MCwgZGUtPmRf
bmFtZTpub2RlMAo+IGdldGNwdTAxLmM6OTk6IFRJTkZPOiBkbi0+ZF9uYW1lOmNwdWxpc3QKPiBn
ZXRjcHUwMS5jOjk4OiBUSU5GTzogY3B1OjAsIGNwdV9pZDowLCBkZS0+ZF9uYW1lOm5vZGUzCj4g
Z2V0Y3B1MDEuYzo5OTogVElORk86IGRuLT5kX25hbWU6Y3B1bGlzdAo+IGdldGNwdTAxLmM6OTg6
IFRJTkZPOiBjcHU6MCwgY3B1X2lkOjAsIGRlLT5kX25hbWU6bm9kZTEKPiBnZXRjcHUwMS5jOjk5
OiBUSU5GTzogZG4tPmRfbmFtZTpjcHVsaXN0Cj4gZ2V0Y3B1MDEuYzoxMjg6IFRGQUlMOiBnZXRj
cHUoKSByZXR1cm5lZCB3cm9uZyB2YWx1ZSBleHBlY3RlZCAgbm9kZSBpZDoxCj4gcmV0dXJuZWQg
IG5vZGUgaWQ6MCwgY3B1X3NldDowCj4KPiBSZXBvcnRlZC1ieTogU2hpemhhbyBDaGVuIDxzaGlj
aGVuQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUGluZyBGYW5nIDxwaWZhbmdAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRjcHUvZ2V0Y3B1MDEu
YyB8IDUgKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dl
dGNwdTAxLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMK
PiBpbmRleCBmNmZjYzRmYzEuLjk4NDJjODk5OSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2dldGNwdS9nZXRjcHUwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9nZXRjcHUvZ2V0Y3B1MDEuYwo+IEBAIC02OSw2ICs2OSw3IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgZ2V0X25vZGVpZCh1bnNpZ25lZCBpbnQgY3B1X2lkKQo+ICAgICAgICAgRElSICpk
aXJlY3RvcnlfcGFyZW50LCAqZGlyZWN0b3J5X25vZGU7Cj4gICAgICAgICBzdHJ1Y3QgZGlyZW50
ICpkZSwgKmRuOwo+ICAgICAgICAgY2hhciBkaXJlY3RvcnlfcGF0aFtQQVRIX01BWF07Cj4gKyAg
ICAgICBjaGFyICppbnZhbGlkX251bWJlcjsKPiAgICAgICAgIHVuc2lnbmVkIGludCBjcHU7Cj4g
ICAgICAgICBpbnQgbm9kZV9pZCA9IDA7Cj4KPiBAQCAtOTEsNyArOTIsOSBAQCBzdGF0aWMgdW5z
aWduZWQgaW50IGdldF9ub2RlaWQodW5zaWduZWQgaW50IGNwdV9pZCkKPiAgICAgICAgICAgICAg
ICAgICAgICAgICB3aGlsZSAoKGRuID0gcmVhZGRpcihkaXJlY3Rvcnlfbm9kZSkpICE9IE5VTEwp
IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzdHJuY21wKGRuLT5kX25h
bWUsICJjcHUiLCAzKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUgPSBzdHJ0b3Vs
KGRuLT5kX25hbWUgKyAzLCBOVUxMLCAwKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNwdSA9IHN0cnRvdWwoZG4tPmRfbmFtZSArIDMsCj4gJmludmFsaWRfbnVtYmVyLCAwKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzdHJjbXAoaW52YWxpZF9udW1i
ZXIsICJcMCIpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250
aW51ZTsKPgoKV2h5IG9ubHkgY2hlY2sgaWYgKiplbmRwdHIgaXMgJ1wwJyBvbiByZXR1cm4/IFNo
b3VsZG4ndCB3ZSBjb25zaWRlcgphIG1vcmUgZ2VuZXJpYyBzaXR1YXRpb24gdGhhdCB3YXMgbm8g
ZGlnaXRzIGFuZCAqZW5kcHRyIHN0b3JlcyB0aGUKb3JpZ2luYWwgc3RyaW5nIChvciByZXR1cm5z
IDApPwoKCgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNwdSA9PSBjcHVf
aWQpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9kZV9pZCA9
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ0b3VsKGRl
LT5kX25hbWUgKyA0LCBOVUxMLAo+IDApOwo+IC0tCj4gMi4zMS4xCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
