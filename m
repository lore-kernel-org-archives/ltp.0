Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F83CC6FD19
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 06:26:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B17F3CB739
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:26:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0FAD3CB077
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 07:26:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 913E6100112B
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 07:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678429557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaJhkBITyrgUV7abh9fnc6aw1PYfJ/YXHbRMonVkNKA=;
 b=YCQpIBlQSerEpB9X7CxAkUtYCI3nxFj9bK/99Yu9AamAt7kBGVJMA76uo+rNo4IfAlH1jt
 L8ztxbPywqN+TNqAXO7Aqu8LSfBmT7cWqCVSGgsR1st9d5h6j8JlsKWdhjc3hUFYTYRsZv
 x+xOLNbcF5MYYtmWD3f1rDJC3g0OqQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Z2TmYWbgPu2uiG45IouIOQ-1; Fri, 10 Mar 2023 01:25:55 -0500
X-MC-Unique: Z2TmYWbgPu2uiG45IouIOQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 f26-20020a7bcd1a000000b003e71cde0e70so2000268wmj.0
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 22:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678429554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uaJhkBITyrgUV7abh9fnc6aw1PYfJ/YXHbRMonVkNKA=;
 b=n8dYjLO6T4iRPE9yX5f0+gKUDlLMuxKjEha/H2VI8Ig/+pEcgIWZ4MD78VfHjWxCjK
 Mx4nlbyAsK0qqSqvt+x/0262g/beyY8QOHWJTtkPSFu+IIVCmoE5OSCAhGWOngHUxu6V
 OOnigCYpT6CFXbJ4RlQsWcr8xrUMENA1d3g2uvheb9rgPmKTR2f+LwR7b/ZPy4XhYKRk
 vX7saDWGXNecaz3oF1zSP9h9/lojtiFnpoydEXIlewXQXMoV8tYMvBL3RUAfB3dZGtxX
 XQsmWnsGZE54Erl6NaTI6svRIEIGajXG4YWHOmqXPSNl70Lgp2x3z64PIJXSrKG/7WYb
 cjrw==
X-Gm-Message-State: AO0yUKUeTyzUQdTnJ2xkcgF5nE0A9xVfsmg1ICPEn9xPrBD4s3J2g/5M
 rSf6W4ru3w2elHfv8lqUsQ+CI7+qc4xfiRB3+xaNWtWukX6uDsEJst7Jme3TiCIx5Fy8aAlLDgD
 TgwHYs3hlqI3NY76s3pH0LCWw7BM=
X-Received: by 2002:a05:600c:3b99:b0:3df:97b0:ba06 with SMTP id
 n25-20020a05600c3b9900b003df97b0ba06mr494613wms.7.1678429554378; 
 Thu, 09 Mar 2023 22:25:54 -0800 (PST)
X-Google-Smtp-Source: AK7set9VSSSi86bBSoGsMksz6X6F4IH29ylnoJrDDwE6nTUnuksBxgcdQEuGk/h+Iy4zVzz7rqTsxchhq39/J6B09JY=
X-Received: by 2002:a05:600c:3b99:b0:3df:97b0:ba06 with SMTP id
 n25-20020a05600c3b9900b003df97b0ba06mr494600wms.7.1678429553974; Thu, 09 Mar
 2023 22:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
In-Reply-To: <Y/yTyk9rYYsPJyVA@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Mar 2023 14:25:42 +0800
Message-ID: <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMjcsIDIwMjMgYXQgNzoyNuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBDb21taXQgYjg1N2Y4NzIzZjMwYTRiOTU1NGJmNmIw
ZmY4ZmE1MmZkMDdlOGI2MCB0cmllZCB0byBmaXggYnVpbGQgd2l0aAo+ID4gbGF0ZXN0IGdsaWJj
IHdoaWNoIHByb3ZpZGVzIG1vdW50X2F0dHIgaW4gc3lzL21vdW50LmguIFVuZm9ydHVuYXRlbHks
Cj4gPiB0aGUgZm9sbG93aW5nIGJ1aWxkIGZhaWx1cmUgaXMgc3RpbGwgcmFpc2VkIGJlY2F1c2Ug
c3lzL21vdW50IGlzIG5vdwo+ID4gdW5jb25kaXRpb25hbGx5IGluY2x1ZGVkIGluIGluY2x1ZGUv
bGFwaS9mc21vdW50Lmg6Cj4gPgo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGZzY29uZmlnMDEu
Yzo5Ogo+ID4gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDo1NTo4OiBlcnJvcjog
cmVkZWZpbml0aW9uIG9mICdzdHJ1Y3QKPiBtb3VudF9hdHRyJwo+ID4gICAgNTUgfCBzdHJ1Y3Qg
bW91bnRfYXR0ciB7Cj4gPiAgICAgICB8ICAgICAgICBefn5+fn5+fn5+Cj4gPiBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzbW91bnQuaDoxNDoKPiA+Cj4g
L2hvbWUvYXV0b2J1aWxkL2F1dG9idWlsZC9pbnN0YW5jZS00L291dHB1dC0xL2hvc3QvYXJtZWIt
YnVpbGRyb290LWxpbnV4LWdudWVhYmkvc3lzcm9vdC91c3IvaW5jbHVkZS9zeXMvbW91bnQuaDoy
MTA6ODoKPiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQo+ID4gICAyMTAgfCBzdHJ1Y3Qg
bW91bnRfYXR0cgo+ID4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+ID4KPiA+IEZpeGVzOgo+
ID4gIC0KPiBodHRwOi8vYXV0b2J1aWxkLmJ1aWxkcm9vdC5vcmcvcmVzdWx0cy80ZGJiNzJlMWJm
MDgxYWZkM2NkOTQ0NTcxYjliZWVlZmM3NjA4ODY1Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogRmFi
cmljZSBGb250YWluZSA8Zm9udGFpbmUuZmFicmljZUBnbWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBj
b25maWd1cmUuYWMgfCA2ICsrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2Nv
bmZpZ3VyZS5hYwo+ID4gaW5kZXggYzJiMGY0OGU3Li5hNmQ4YWM4MjYgMTAwNjQ0Cj4gPiAtLS0g
YS9jb25maWd1cmUuYWMKPiA+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+ID4gQEAgLTIyNSwxMCArMjI1
LDEwIEBAIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgX19rZXJuZWxfb2xkX3RpbWV2YWwsCj4gc3Ry
dWN0IF9fa2VybmVsX29sZF90aW1lc3BlYywgc3RydWMKPiA+Cj4gPiAgQUNfQ0hFQ0tfVFlQRVMo
W3N0cnVjdCBmdXRleF93YWl0dl0sLCxbI2luY2x1ZGUgPGxpbnV4L2Z1dGV4Lmg+XSkKPiA+ICBB
Q19DSEVDS19UWVBFUyhbc3RydWN0IG1vdW50X2F0dHJdLCwsWwo+ID4gLSNpZmRlZiBIQVZFX0xJ
TlVYX01PVU5UX0gKPiA+IC0jIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+Cj4gPiAtI2Vsc2UKPiA+
ICsjaWZkZWYgSEFWRV9NT1VOVF9TRVRBVFRSCj4gPiAgIyBpbmNsdWRlIDxzeXMvbW91bnQuaD4K
PiA+ICsjZWxpZiBIQVZFX0xJTlVYX01PVU5UX0gKPiA+ICsjIGluY2x1ZGUgPGxpbnV4L21vdW50
Lmg+Cj4gPiAgI2VuZGlmCj4gPiAgXSkKPgo+IEkgd29uZGVyIGlmIHdlIGNhbiBnZXQgdGhpcyB3
aG9sZSBtZXNzIG9mIHR3byBkaWZmZXJlbnQgZmFsbGJhY2sgaGVhZGVycwo+IHNpbXBsaWZpZWQu
IExvb2tpbmcgYXQgdGhlIGdsaWJjIGltcGxlbWVudGF0aW9uIGl0IHNlZW1zIHRvIGluY2x1ZGUK
PiAibGludXgvbW91bnQuaCIgaWYgaXQgZG9lcyBleGlzdC4gU28gbW9zdCByZWFzb25hYmxlIHNv
bHV0aW9uIHdvdWxkIGRvCj4gdGhlIHNhbWUgSSBndWVzcyB3aGljaCB3ZSBkaWQgYmVmb3JlIHRo
ZSBjb21taXQgeW91IHJlZmVyZW5jZS4KPgoKVGhpcyBpcyBpbmRlZWQgY29ycmVjdCBpZiBvbmx5
IGZhY2UgdGhlIGxhdGVzdCBHbGliYywgYnV0IHRoYXQgbWlnaHQgaGF2ZQpwcm9ibGVtcyB3aGVu
IGJ1aWxkaW5nIExUUCBvbiBhIG1pZGRsZSB2ZXJzaW9uIG9mIEdsaWJjL0tlcm5lbC1oZWFkZXJz
LgpUaGUgYnVnIEkgbWVudGlvbmVkIGluIHRoZSBsYXN0IGVtYWlsIHdhcyBmaXhlZCBzaW5jZSBn
bGliYy0yLjM3fjQyNi4KCkBGYWJyaWNlLCB3aGF0IGtpbmQgb2YgdmVyc2lvbiBvZiBHbGliYy9L
ZXJuZWwtaGVhZGVycyBkbyB5b3UgdXNlPyBhbmQKd2hpY2ggcGxhdGZvcm0/CgpCdHcsIHRoaXMg
cGF0Y2ggYnVpbGRzIExUUCBzdWNjZXNzZnVsbHkgaW4gQ0k6CiAgLSBodHRwczovL2dpdGh1Yi5j
b20vd2FuZ2xpNTY2NS9sdHAvYWN0aW9ucy9ydW5zLzQzODA3Mzk0NzAKQW5kIEkgbWFudWFsbHkg
dHJpZWQgd2l0aCBmZWRvcmEtcmF3aGlkZS9mZWRvcmEzNC8zNS8zNy8zOCBhbGwgbG9va3MgZ29v
ZC4KCk1heWJlIHdlIGNhbiBqdXN0IGFwcGx5IHRoaXMgcGF0Y2ggdG8ga2VlcCBldmVyeXRoaW5n
IHdpdGggbm8gYmlnIGNoYW5nZXMuCgpAQ3lyaWwsIFBldHIsIHdoYXQgZG8geW91IHRoaW5rPwoK
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
