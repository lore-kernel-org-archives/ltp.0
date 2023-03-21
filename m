Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7788C74A5B
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 11:27:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3209E3CD2F9
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 12:27:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A62923C4C12
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 12:27:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F1246007B6
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 12:27:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679398064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HL2noqHBwbcXX+acyLyElivivem6vhn8+k0oMW/PNWs=;
 b=We/5FYGyxv4jAzNSnCtV3LIrvc1XXjpPerAF3Kf9M/Qe549R8QZuQ1VQO2qHjepkpf+3F0
 KzKQ+GmR2PLxJ8FPOo1FhdkV/z8ZU1WUHAXAshfyDEVf2+xfx7G344ufegsBlgPqDkUtI/
 1A8WBbktSKAiHDgtZRi3FtZF5kaMfuo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-OCVquBIVPZy59x50K8TR8Q-1; Tue, 21 Mar 2023 07:27:42 -0400
X-MC-Unique: OCVquBIVPZy59x50K8TR8Q-1
Received: by mail-pg1-f197.google.com with SMTP id
 s9-20020a634509000000b004fc1c14c9daso3395953pga.23
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 04:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679398062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HL2noqHBwbcXX+acyLyElivivem6vhn8+k0oMW/PNWs=;
 b=xbN+8l9h7RIfImBj/AApiwEe17A09tT10DKe/Fhxd7dxSA4bxige3zoh7s8LdO1rJ2
 L9zP9KoqMn3dIscMlLMeQvj92NZGjG55wSfGXHjU5oD+rEzsdBGm3Nwll9S/P83nwlHy
 uIA5l4wknJa+ikGK6b5ec/oDT7c0jjBxnxr0LtQR0co+Xt+dtZj8NgHJcQmcLHarY02o
 k/ybsqxP/g+c89QEWkh+WdFZQH9zWIKPKO0m78GFzD7zTZKqp1bN9j27O6iepP1Ma5d3
 kkiHorlGVfAWLEL8oo8uVWwRaJNY9SR6lDu/ICfRNqRHmQRuHOV/wFOxYRd2OJFBu9Me
 fV1w==
X-Gm-Message-State: AO0yUKX9grl3jzNl7kurUHhHTZscSL5Xy7nyRyB8NNNVWtZrZ/bcDN7D
 4KKbYCBBYZwQYgLoUj+WhxxZ52N4U3EmQcGG3UZTe4M4TeqndqeMJQar+f+IUcaBh3qSTc6Uv8a
 iLPcoBZWtvtSNAP3D8rmMk/9Ggg==
X-Received: by 2002:a17:90a:4596:b0:23b:3ff2:fb45 with SMTP id
 v22-20020a17090a459600b0023b3ff2fb45mr561051pjg.2.1679398061849; 
 Tue, 21 Mar 2023 04:27:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set+vq0myyfsUMk2AvKDJIsU/RFuI9Rak7UXs38ovImt/bJWQ1AJ+QQQDBjGHiM4+S6i+JT0ctx2tvu7jnDGnTJk=
X-Received: by 2002:a17:90a:4596:b0:23b:3ff2:fb45 with SMTP id
 v22-20020a17090a459600b0023b3ff2fb45mr561043pjg.2.1679398061478; Tue, 21 Mar
 2023 04:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230320092332.36187-1-pifang@redhat.com>
 <CAEemH2edWRT1f=8wb=qQn2=3L0CXD-sQ4qQUSk+DwcRWE8xqqA@mail.gmail.com>
In-Reply-To: <CAEemH2edWRT1f=8wb=qQn2=3L0CXD-sQ4qQUSk+DwcRWE8xqqA@mail.gmail.com>
From: Ping Fang <pifang@redhat.com>
Date: Tue, 21 Mar 2023 19:27:04 +0800
Message-ID: <CANKfEn7M8X8vKGVAUGRLkYh82vv_xBYg=n-pyU+sA7X=4UuX=g@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMjo1NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgUGluZywKPgo+IEdvb2QgY2F0Y2ghCj4KPiBPbiBNb24sIE1hciAy
MCwgMjAyMyBhdCA1OjIz4oCvUE0gUGluZyBGYW5nIDxwaWZhbmdAcmVkaGF0LmNvbT4gd3JvdGU6
Cj4KPj4gZ2V0X25vZGVpZCgpIGZpbmQgbm9kZWlkIGJ5IGl0ZXJhdGUgL3N5cy9kZXZpY2VzL3N5
c3RlbS9ub2RlL25vZGVYL2NwdVkuCj4+IEJ1dCB0aGVyZSBhcmUgY3B1bGlzdCBhbmQgY3B1bWFw
LCB3aGljaCB3aWxsIHJlcG9ydCAwIGluIHN0cnRvdWwuCj4+IE9uIG11bHRpLW5vZGUgbnVtYSBz
eXN0ZW0sIHRoZSBsYXN0IGl0ZXJhdGlvbiBub2RlWCBkaXJlY3RvcnkgbWlzbWF0Y2gKPj4gdGhl
IGNwdTAgbm9kZSBpZC4gVGhlbiBmYWlsIHRoZSB0ZXN0LiBUaGUgZm9sbG93aW5nIHNob3dzIG9u
IGEgNCBub2RlCj4+IG51bWEgc3lzdGVtLiBUaGUgbGFzdCBpdGVyYXRpb24gc3RvcHBlZCB1bmRl
ciAvbm9kZTEuIHNvIGV4cGVjdGVkIG5vZGUKPj4gaWQgMS4gVGhlbiBmYWlsZWQuCj4+Cj4+IGdl
dGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1X2lkOjAsIGRlLT5kX25hbWU6bm9kZTIKPj4g
Z2V0Y3B1MDEuYzo5OTogVElORk86IGRuLT5kX25hbWU6Y3B1bGlzdAo+PiBnZXRjcHUwMS5jOjk4
OiBUSU5GTzogY3B1OjAsIGNwdV9pZDowLCBkZS0+ZF9uYW1lOm5vZGUwCj4+IGdldGNwdTAxLmM6
OTk6IFRJTkZPOiBkbi0+ZF9uYW1lOmNwdWxpc3QKPj4gZ2V0Y3B1MDEuYzo5ODogVElORk86IGNw
dTowLCBjcHVfaWQ6MCwgZGUtPmRfbmFtZTpub2RlMwo+PiBnZXRjcHUwMS5jOjk5OiBUSU5GTzog
ZG4tPmRfbmFtZTpjcHVsaXN0Cj4+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1X2lk
OjAsIGRlLT5kX25hbWU6bm9kZTEKPj4gZ2V0Y3B1MDEuYzo5OTogVElORk86IGRuLT5kX25hbWU6
Y3B1bGlzdAo+PiBnZXRjcHUwMS5jOjEyODogVEZBSUw6IGdldGNwdSgpIHJldHVybmVkIHdyb25n
IHZhbHVlIGV4cGVjdGVkICBub2RlIGlkOjEKPj4gcmV0dXJuZWQgIG5vZGUgaWQ6MCwgY3B1X3Nl
dDowCj4+Cj4+IFJlcG9ydGVkLWJ5OiBTaGl6aGFvIENoZW4gPHNoaWNoZW5AcmVkaGF0LmNvbT4K
Pj4gU2lnbmVkLW9mZi1ieTogUGluZyBGYW5nIDxwaWZhbmdAcmVkaGF0LmNvbT4KPj4gLS0tCj4+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGNwdS9nZXRjcHUwMS5jIHwgNSArKysrLQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRjcHUvZ2V0Y3B1MDEuYwo+
PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMKPj4gaW5kZXgg
ZjZmY2M0ZmMxLi45ODQyYzg5OTkgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9nZXRjcHUvZ2V0Y3B1MDEuYwo+PiBAQCAtNjksNiArNjksNyBAQCBzdGF0aWMgdW5zaWduZWQg
aW50IGdldF9ub2RlaWQodW5zaWduZWQgaW50IGNwdV9pZCkKPj4gICAgICAgICBESVIgKmRpcmVj
dG9yeV9wYXJlbnQsICpkaXJlY3Rvcnlfbm9kZTsKPj4gICAgICAgICBzdHJ1Y3QgZGlyZW50ICpk
ZSwgKmRuOwo+PiAgICAgICAgIGNoYXIgZGlyZWN0b3J5X3BhdGhbUEFUSF9NQVhdOwo+PiArICAg
ICAgIGNoYXIgKmludmFsaWRfbnVtYmVyOwo+PiAgICAgICAgIHVuc2lnbmVkIGludCBjcHU7Cj4+
ICAgICAgICAgaW50IG5vZGVfaWQgPSAwOwo+Pgo+PiBAQCAtOTEsNyArOTIsOSBAQCBzdGF0aWMg
dW5zaWduZWQgaW50IGdldF9ub2RlaWQodW5zaWduZWQgaW50IGNwdV9pZCkKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgd2hpbGUgKChkbiA9IHJlYWRkaXIoZGlyZWN0b3J5X25vZGUpKSAhPSBO
VUxMKSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHN0cm5jbXAoZG4t
PmRfbmFtZSwgImNwdSIsIDMpKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1ID0g
c3RydG91bChkbi0+ZF9uYW1lICsgMywgTlVMTCwgMCk7Cj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3B1ID0gc3RydG91bChkbi0+ZF9uYW1lICsgMywKPj4gJmludmFsaWRfbnVt
YmVyLCAwKTsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoc3RyY21wKGlu
dmFsaWRfbnVtYmVyLCAiXDAiKSkKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOwo+Pgo+Cj4gV2h5IG9ubHkgY2hlY2sgaWYgKiplbmRwdHIgaXMgJ1ww
JyBvbiByZXR1cm4/IFNob3VsZG4ndCB3ZSBjb25zaWRlcgo+IGEgbW9yZSBnZW5lcmljIHNpdHVh
dGlvbiB0aGF0IHdhcyBubyBkaWdpdHMgYW5kICplbmRwdHIgc3RvcmVzIHRoZQo+IG9yaWdpbmFs
IHN0cmluZyAob3IgcmV0dXJucyAwKT8KPgoKClRoZSBzdHJ0b3VsIHdpbGwgdHJ5IHRvIGNvbnZl
cnQgc3RyaW5nIGludG8gdW5zaWduZWQgbG9uZyBpbnRlZ2VyLgpJZiBzdWNjZXNzZnVsIHRoZSBl
bmRwdHIgd2lsbCBwb2ludCB0byBhICJcMCIgc3RyaW5nIHJldHVybiB0aGUgbnVtYmVyLApvdGhl
cndpc2UgdG8gdGhlIG9yaWdpbmFsIHN0cmluZyBhbmQgcmV0dXJuIDAuCkluIHRoZSBjYXNlIG9m
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS9jcHVsaXN0LCBlbmRwdHIgaXMgICJsaXN0
XDAiCmFuZCByZXR1cm4gMC4gVGhlIHN0cmNtcCBmYWxzZSBza2lwIHRvIHRoZSBuZXh0IGl0ZXJh
dGlvbi4KCgo+Cj4KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY3B1ID09
IGNwdV9pZCkgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9k
ZV9pZCA9Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dG91bChkZS0+ZF9uYW1lICsgNCwgTlVMTCwKPj4gMCk7Cj4+IC0tCj4+IDIuMzEuMQo+Pgo+Pgo+
PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAKPj4KPj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAKKi0tKgpUaGFu
a3MgJiBSZWdhcmRzLAoqUGluZyBGYW5nKgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
