Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EC0EB64D9
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 18:32:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9FFE3CB568
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 20:32:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89CE33C1812
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 20:32:28 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E366660067E
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 20:32:27 +0200 (CEST)
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-47e57b8498aso1541147e0c.2
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689013947; x=1691605947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snFD9AmedcEoLCcztnMjsVbmnwijplHBKCaIzRkxQgk=;
 b=BqPC/5agS1zoO8g9GLKlHJ89THTYtXE1OEcGCkaZ6KfG09f4nuVJVVo62ornwHj8ST
 xlsrBk3igbPvXj+hSAsZcbq7X5A7fsdTxB/FXZS5RUI6eiLLRGzBw8XRJzCkSVpLtSUz
 +53K8u3YFM2ulx19Le/iWtaoJelwD+EgK75ljHYnVASkiTKKunLbr93lwZ6BFmW6DR0z
 HBx6N39faR1dDOelEGGme0avPcW144EwnW2n0CD7jtjom3JO6MkxcmCpu1ilEjwZb2Rx
 Blat0F88MzRwIxAsCWEQYryFQcqwWQoLJkSG8Nv1JyThZhQyxocmdYMUgVk4ggn0viEg
 0L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689013947; x=1691605947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snFD9AmedcEoLCcztnMjsVbmnwijplHBKCaIzRkxQgk=;
 b=BJBZLnaytDNKPvEx7oxjwUigEDMFkM1dGPZexnuYXqUYR2yneGJbnE+uwmbytUt+EB
 z//CO/3NYZd42JlwiQxP5CGy/3GYfkZ83FOXhIXqyvYgY5MZFHIYQpN7Z71Hx8/snTMA
 Cnf3kOORXugQuvHKbvxd/LUZSN85NCIhNvVy5oRKJO+CIjM/K3rLFpgXmPgJLFYqrZZr
 /yFqyWw8Kgp0eRTEZHIydfOits9hQSLBTz+EKfwRG7h3E2HFvpqRfyanbJn6HU65nHOR
 1mL7XiJrASMz8fd1n9BED4rRog5HHy4saSEYUnys/q/m3/PpioNjKxK3HDItboMhXYwx
 gFzw==
X-Gm-Message-State: ABy/qLYiGWlUSZlicT3xnO2ndyTTF4HGKA+BB6RtUTUc0oESbVBefQa6
 t9el3bZqR1Zb5VV0NJzbeNMA8gEn04GSe+TErF8=
X-Google-Smtp-Source: APBJJlHfRu1cro8e3WtR0QbwgTBTjqFCjeuVe3VAB2vbYJLj5/YopEKaF9cXGcIfei14PLqouFI2XP9wp2x9Zd/YYFI=
X-Received: by 2002:a67:f481:0:b0:443:5b37:a5a5 with SMTP id
 o1-20020a67f481000000b004435b37a5a5mr5085830vsn.34.1689013946643; Mon, 10 Jul
 2023 11:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230710141403.1155151-1-amir73il@gmail.com>
 <20230710155006.GA659329@pevik>
In-Reply-To: <20230710155006.GA659329@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Jul 2023 21:32:15 +0300
Message-ID: <CAOQ4uxjUkLo_MX+nxM1KFp66+C6c5zr75GAgpA0RZofZm7sfgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify14: Test disallow sb/mount mark on
 anonymous pipe
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgNjo1MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFtaXIsCj4KPiA+IFRoaXMgY2FzZSB3YXMgcmV0cm9hY3RpdmVs
eSBkaXNhbGxvd2VkLgo+Cj4gPiBUaGlzIHRlc3QgaXMgbWVhbnQgdG8gZW5jb3VyYWdlIHRoZSBi
YWNrcG9ydGluZyBvZiBjb21taXQgNjk1NjJlYjBiZDNlCj4gPiAoImZhbm90aWZ5OiBkaXNhbGxv
dyBtb3VudC9zYiBtYXJrcyBvbiBrZXJuZWwgaW50ZXJuYWwgcHNldWRvIGZzIikgdG8KPiA+IGFs
bCBzdGFibGUga2VybmVscy4KPgo+ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFt
aXI3M2lsQGdtYWlsLmNvbT4KPiA+IC0tLQo+Cj4gPiBQZXRyLAo+Cj4gPiBUaGlzIHRlc3RzIGZv
ciBhIGJlaGF2aW9yIHRoYXQgd2UgY29uc2lkZXIgYnJva2VuIHNpbmNlIHRoZSBkYXduIG9mCj4g
PiBmYW5vdGlmeS4KPgo+ID4gVGhlIGZpeCB3YXMgbWVyZ2VkIHRvIHY2LjUtcmMxLgo+ID4gSSd2
ZSBhbHJlYWR5IHBvc3RlZCBiYWNrcG9ydCBwYXRjaGVzIGZvciBrZXJuZWxzID4gdjUuMC4KPiA+
IEkgYW0gbm90IHBsYW5uaW5nIHRvIHBvc3QgYmFja3BvcnQgcGF0Y2hlcyBmb3Igb2xkZXIga2Vy
bmVscy4KPgo+IEkgc2VlCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIwMjMwNzEw
MTMzMjA1LjExNTQxNjgtMS1hbWlyNzNpbEBnbWFpbC5jb20vCj4KPiBJJ2xsIHN1Z2dlc3QgdG8g
d2FpdCB0aWxsIEdyZWcgcmVsZWFzZXMgdGhlIGJhY2twb3J0IChzaG91bGQgYmUgcXVpY2sgZW5v
dWdoKS4KPgoKb2suCgo+ID4gRXZlbiB0aG91Z2ggdGhlIHR3byBuZXcgdGVzdCBjYXNlcyBkbyBu
b3QgdXNlIEZBTl9SRVBPUlRfRklELAo+ID4gZmFub3RpZnkxNCByZXF1aXJlcyBGQU5fUkVQT1JU
X0ZJRCwgc28gaXQgaXMgbm90IGdvaW5nIHRvIHJ1biB0aGVzZQo+ID4gdGVzdCBjYXNlcyBvbiBr
ZXJuZWwgPCB2NS4xIGFueXdheS4KPgo+ID4gVGhhbmtzLAo+ID4gQW1pci4KPgo+ID4gIC4uLi9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jICAgICB8IDMyICsrKysrKysrKysr
KysrKysrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkxNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTE0LmMKPiA+IGluZGV4IGJmYTAzNDlmZS4uMDYzYTlmOTZmIDEwMDY0NAo+ID4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiA+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gPiBAQCAt
MTksNiArMTksOSBAQAo+ID4gICAqCj4gPiAgICogICAgIGNlYWY2OWY4ZWFkYyBmYW5vdGlmeTog
ZG8gbm90IGFsbG93IHNldHRpbmcgZGlyZW50IGV2ZW50cyBpbiBtYXNrIG9mIG5vbi1kaXIKPiA+
ICAgKiAgICAgODY5OGUzYmFiNGRkIGZhbm90aWZ5OiByZWZpbmUgdGhlIHZhbGlkYXRpb24gY2hl
Y2tzIG9uIG5vbi1kaXIgaW5vZGUgbWFzawo+ID4gKyAqCj4gPiArICogVGhlIHBpcGVzIHRlc3Qg
Y2FzZXMgYXJlIHJlZ3Jlc3Npb24gdGVzdHMgZm9yIGNvbW1pdDoKPiA+ICsgKiAgICAgNjk1NjJl
YjBiZDNlIGZhbm90aWZ5OiBkaXNhbGxvdyBtb3VudC9zYiBtYXJrcyBvbiBrZXJuZWwgaW50ZXJu
YWwgcHNldWRvIGZzCj4gPiAgICovCj4KPiA+ICAjZGVmaW5lIF9HTlVfU09VUkNFCj4gPiBAQCAt
NDAsNiArNDMsNyBAQAo+Cj4gPiAgI2RlZmluZSBGTEFHU19ERVNDKGZsYWdzKSB7KGZsYWdzKSwg
KCNmbGFncyl9Cj4KPiA+ICtzdGF0aWMgaW50IHBpcGVzWzJdID0gey0xLCAtMX07Cj4gPiAgc3Rh
dGljIGludCBmYW5vdGlmeV9mZDsKPiA+ICBzdGF0aWMgaW50IGZhbl9yZXBvcnRfdGFyZ2V0X2Zp
ZF91bnN1cHBvcnRlZDsKPiA+ICBzdGF0aWMgaW50IGlnbm9yZV9tYXJrX3Vuc3VwcG9ydGVkOwo+
ID4gQEAgLTYwLDYgKzY0LDcgQEAgc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2VfdCB7Cj4gPiAgICAg
ICAvKiB3aGVuIG1hc2suZmxhZ3MgPT0gMCwgZmFub3RpZnlfaW5pdCgpIGlzIGV4cGVjdGVkIHRv
IGZhaWwgKi8KPiA+ICAgICAgIHN0cnVjdCB0ZXN0X2Nhc2VfZmxhZ3NfdCBtYXNrOwo+ID4gICAg
ICAgaW50IGV4cGVjdGVkX2Vycm5vOwo+ID4gKyAgICAgaW50ICpwZmQ7Cj4KPiBUaGlzIHByb2R1
Y2VzIHdhcm5pbmdzOgo+IGZhbm90aWZ5MTQuYzo3MDo5OiB3YXJuaW5nOiBtaXNzaW5nIGluaXRp
YWxpemVyIGZvciBmaWVsZCDigJhwZmTigJkgb2Yg4oCYc3RydWN0IHRlc3RfY2FzZV904oCZIFst
V21pc3NpbmctZmllbGQtaW5pdGlhbGl6ZXJzXQo+ICAgIDcwIHwgICAgICAgICB7RkxBR1NfREVT
QyhGQU5fQ0xBU1NfQ09OVEVOVCB8IEZBTl9SRVBPUlRfRklEKSwge30sIHt9LCBFSU5WQUx9LAo+
ICAgICAgIHwgICAgICAgICBeCj4gZmFub3RpZnkxNC5jOjY3OjE0OiBub3RlOiDigJhwZmTigJkg
ZGVjbGFyZWQgaGVyZQo+ICAgIDY3IHwgICAgICAgICBpbnQgKnBmZDsKPiAgICAgICB8ICAgICAg
ICAgICAgICBefn4KPiBmYW5vdGlmeTE0LmM6NzM6OTogd2FybmluZzogbWlzc2luZyBpbml0aWFs
aXplciBmb3IgZmllbGQg4oCYcGZk4oCZIG9mIOKAmHN0cnVjdCB0ZXN0X2Nhc2VfdOKAmSBbLVdt
aXNzaW5nLWZpZWxkLWluaXRpYWxpemVyc10KPiAgICA3MyB8ICAgICAgICAge0ZMQUdTX0RFU0Mo
RkFOX0NMQVNTX1BSRV9DT05URU5UIHwgRkFOX1JFUE9SVF9GSUQpLCB7fSwge30sIEVJTlZBTH0s
Cj4gICAgICAgfCAgICAgICAgIF4KPiBmYW5vdGlmeTE0LmM6Njc6MTQ6IG5vdGU6IOKAmHBmZOKA
mSBkZWNsYXJlZCBoZXJlCj4gICAgNjcgfCAgICAgICAgIGludCAqcGZkOwo+ICAgICAgIHwgICAg
ICAgICAgICAgIF5+fgo+Cj4gQ291bGQgeW91IHBsZWFzZSBmaXggdGhlbT8gSSBndWVzcyBwZmQg
bXVzdCBiZSBOVUxMIHdoZW4gdW51c2VkLgo+Cgpvay4gYnV0IEkgaGF2ZSB0byBhc2ssCndoYXQg
aXMgdGhlIHZhbHVlIG9mIGV4cGxpY2l0bHkgaW5pdGlhbGl6aW5nIGFsbCB0aGUgb2xkIHRlc3Qg
Y2FzZXMgdG8KcGZkID0gTlVMTD8KYW5kIHdoYXQgaXMgd3Jvbmcgd2l0aCBkZWZhdWx0IE5VTEwg
aW5pdGlhbGl6ZXJzPwpJcyBpdCBhIGRlbGliZXJhdGUgZGVjaXNpb24gb2YgTFRQIHRvIGNhcmUg
YWJvdXQgdGhpcyB3YXJuaW5nPwppdCdzIGEgY2xhc3NpYyBwYXR0ZXJuIGZvciB3aGF0IHRoaXMg
cGF0Y2ggZG9lcyAtCmFkZCBhIG5ldyBmaWVsZCB0byB0ZXN0IGNhc2Ugd2hpY2ggYWxsIHRoZSBl
eGlzdGluZyB0ZXN0IGNhc2VzCnNob3VsZCBub3QgY2FyZSBhYm91dC4KCkFsc28sIEkgaGF2ZSBh
bHdheXMgc2VlbiB0aGVzZSB3YXJuaW5ncyBmb3Igc3RydWN0IHRzdF90ZXN0LgoKZmFub3RpZnkx
NC5jOjI4NDoxOiB3YXJuaW5nOiBtaXNzaW5nIGluaXRpYWxpemVyIGZvciBmaWVsZAonbmVlZHNf
Y21kcycgb2YgJ3N0cnVjdCB0c3RfdGVzdCcgWy1XbWlzc2luZy1maWVsZC1pbml0aWFsaXplcnNd
CiAgMjg0IHwgfTsKICAgICAgfCBeCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBmYW5vdGlmeTE0LmM6
Mjg6Ci4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDozMjQ6MjE6IG5vdGU6ICduZWVkc19j
bWRzJyBkZWNsYXJlZCBoZXJlCiAgMzI0IHwgIGNvbnN0IGNoYXIgKmNvbnN0ICpuZWVkc19jbWRz
OwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fgoKTXVzdCB3ZSByZWFsbHkg
aW5pdGlhbGl6ZSBhbiBlbXB0eSBuZWVkc19jbWRzIGFycmF5IGZvciBldmVyeSB0ZXN0PwpTZWVt
cyBwb2ludGxlc3MgdG8gbWUsIGJ1dCBJIG1heSBub3QgaGF2ZSB0aGUgYmlnZ2VyIHBpY3R1cmUu
CgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
