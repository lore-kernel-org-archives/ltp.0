Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75140C6FD1D
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 12:32:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F5873CD308
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 13:32:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73F4C3C1D84
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 13:32:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BF661A00912
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 13:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679401948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUn2tMsT6KvRaG0mCvJr9v8WbDMGjK7howGTTVrskuY=;
 b=NqcLLId+o7dbdJ9w/yLsN5806YA50bVi6tqd8KxmO8eGqoNEq8Zih6cKVH7AfUSuomyN7L
 qlIgNf9qTSy+gzIohGs0kv9EpV8ufHjxdC1WwekySB3SvyJrngY/ypaKGJK/utZ8z3ECrz
 shs4k937RoBv1KeTJBlk3bqwwkKRpVI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-3MGpYm7gNzeKrF7YsLXf4A-1; Tue, 21 Mar 2023 08:32:27 -0400
X-MC-Unique: 3MGpYm7gNzeKrF7YsLXf4A-1
Received: by mail-wm1-f72.google.com with SMTP id
 p10-20020a05600c358a00b003edf7d484d4so2372612wmq.0
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 05:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679401946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUn2tMsT6KvRaG0mCvJr9v8WbDMGjK7howGTTVrskuY=;
 b=6RMaC+pxVv0RTp9DToicG2albvuoEcwKcKjFnsJEmKC+XGK6yzZ2yW2E1LKTshy8Do
 2o2YOXh3z1/NItC1TutJLP70Mhoblc5bcHeNzgidJuwAfx4snc2q50jga3JExYJIHOn/
 lS2J4h7x/AGBn6CIvrDt8yJ0hxMj8wpSeCvbLGaPqXsTnfUeZCpgd8JSXixhhng5fZtF
 pJDGMz6s0xy6tAK6TT3Nc5a+K+LaZt6J147K1GKqNapo+2yvdn1Bdg4zN0wEa4EgCaLe
 DsMzg99NAaNzR26Q90NQOD2KZ1el/9uIQrKNVFuhK1JgPbK3r+IN1QnCf8y9dzX0RgLl
 cyMQ==
X-Gm-Message-State: AO0yUKUj5HS+YT6C1P1tnVj/qnq7geouNA+lgrjyp188Y1GgdXKix/n8
 H7KIhodIM3YjXPgXQ4i7wCzS0P/2q2odLKJAY9IdC7sxPlPA5CH4KTVJRkAGcBfy5Sp2h8JqSns
 szL2ZGpP3vGrbKYbhJC1wzOBR32c=
X-Received: by 2002:a05:600c:210:b0:3ed:c669:8a13 with SMTP id
 16-20020a05600c021000b003edc6698a13mr678439wmi.8.1679401946093; 
 Tue, 21 Mar 2023 05:32:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set/4z5R4iOahpZNuGIBlQSdvR8lRFfIy3Q7NuogKVN/lP8PT1RhKO3yLZ8wqlyhw9bdUtkO+QSQfIDueGnwYAwA=
X-Received: by 2002:a05:600c:210:b0:3ed:c669:8a13 with SMTP id
 16-20020a05600c021000b003edc6698a13mr678434wmi.8.1679401945842; Tue, 21 Mar
 2023 05:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230320092332.36187-1-pifang@redhat.com>
 <CAEemH2edWRT1f=8wb=qQn2=3L0CXD-sQ4qQUSk+DwcRWE8xqqA@mail.gmail.com>
 <CANKfEn7M8X8vKGVAUGRLkYh82vv_xBYg=n-pyU+sA7X=4UuX=g@mail.gmail.com>
In-Reply-To: <CANKfEn7M8X8vKGVAUGRLkYh82vv_xBYg=n-pyU+sA7X=4UuX=g@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Mar 2023 20:32:14 +0800
Message-ID: <CAEemH2dRTX4Ru161v4Fosnhy9-bX6jdd4Y=7gqhfGKDqEFq0mQ@mail.gmail.com>
To: Ping Fang <pifang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgNzoyN+KAr1BNIFBpbmcgRmFuZyA8cGlmYW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKPgo+Cj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMjo1NuKAr1BNIExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPgo+PiBIaSBQaW5nLAo+Pgo+PiBHb29k
IGNhdGNoIQo+Pgo+PiBPbiBNb24sIE1hciAyMCwgMjAyMyBhdCA1OjIz4oCvUE0gUGluZyBGYW5n
IDxwaWZhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+PiBnZXRfbm9kZWlkKCkgZmluZCBub2Rl
aWQgYnkgaXRlcmF0ZSAvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZVgvY3B1WS4KPj4+IEJ1
dCB0aGVyZSBhcmUgY3B1bGlzdCBhbmQgY3B1bWFwLCB3aGljaCB3aWxsIHJlcG9ydCAwIGluIHN0
cnRvdWwuCj4+PiBPbiBtdWx0aS1ub2RlIG51bWEgc3lzdGVtLCB0aGUgbGFzdCBpdGVyYXRpb24g
bm9kZVggZGlyZWN0b3J5IG1pc21hdGNoCj4+PiB0aGUgY3B1MCBub2RlIGlkLiBUaGVuIGZhaWwg
dGhlIHRlc3QuIFRoZSBmb2xsb3dpbmcgc2hvd3Mgb24gYSA0IG5vZGUKPj4+IG51bWEgc3lzdGVt
LiBUaGUgbGFzdCBpdGVyYXRpb24gc3RvcHBlZCB1bmRlciAvbm9kZTEuIHNvIGV4cGVjdGVkIG5v
ZGUKPj4+IGlkIDEuIFRoZW4gZmFpbGVkLgo+Pj4KPj4+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBj
cHU6MCwgY3B1X2lkOjAsIGRlLT5kX25hbWU6bm9kZTIKPj4+IGdldGNwdTAxLmM6OTk6IFRJTkZP
OiBkbi0+ZF9uYW1lOmNwdWxpc3QKPj4+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1
X2lkOjAsIGRlLT5kX25hbWU6bm9kZTAKPj4+IGdldGNwdTAxLmM6OTk6IFRJTkZPOiBkbi0+ZF9u
YW1lOmNwdWxpc3QKPj4+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1X2lkOjAsIGRl
LT5kX25hbWU6bm9kZTMKPj4+IGdldGNwdTAxLmM6OTk6IFRJTkZPOiBkbi0+ZF9uYW1lOmNwdWxp
c3QKPj4+IGdldGNwdTAxLmM6OTg6IFRJTkZPOiBjcHU6MCwgY3B1X2lkOjAsIGRlLT5kX25hbWU6
bm9kZTEKPj4+IGdldGNwdTAxLmM6OTk6IFRJTkZPOiBkbi0+ZF9uYW1lOmNwdWxpc3QKPj4+IGdl
dGNwdTAxLmM6MTI4OiBURkFJTDogZ2V0Y3B1KCkgcmV0dXJuZWQgd3JvbmcgdmFsdWUgZXhwZWN0
ZWQgIG5vZGUgaWQ6MQo+Pj4gcmV0dXJuZWQgIG5vZGUgaWQ6MCwgY3B1X3NldDowCj4+Pgo+Pj4g
UmVwb3J0ZWQtYnk6IFNoaXpoYW8gQ2hlbiA8c2hpY2hlbkByZWRoYXQuY29tPgo+Pj4gU2lnbmVk
LW9mZi1ieTogUGluZyBGYW5nIDxwaWZhbmdAcmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMgfCA1ICsrKystCj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGNwdS9nZXRjcHUwMS5jCj4+PiBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMKPj4+IGluZGV4IGY2
ZmNjNGZjMS4uOTg0MmM4OTk5IDEwMDY0NAo+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9nZXRjcHUvZ2V0Y3B1MDEuYwo+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9nZXRjcHUvZ2V0Y3B1MDEuYwo+Pj4gQEAgLTY5LDYgKzY5LDcgQEAgc3RhdGljIHVuc2lnbmVk
IGludCBnZXRfbm9kZWlkKHVuc2lnbmVkIGludCBjcHVfaWQpCj4+PiAgICAgICAgIERJUiAqZGly
ZWN0b3J5X3BhcmVudCwgKmRpcmVjdG9yeV9ub2RlOwo+Pj4gICAgICAgICBzdHJ1Y3QgZGlyZW50
ICpkZSwgKmRuOwo+Pj4gICAgICAgICBjaGFyIGRpcmVjdG9yeV9wYXRoW1BBVEhfTUFYXTsKPj4+
ICsgICAgICAgY2hhciAqaW52YWxpZF9udW1iZXI7Cj4+PiAgICAgICAgIHVuc2lnbmVkIGludCBj
cHU7Cj4+PiAgICAgICAgIGludCBub2RlX2lkID0gMDsKPj4+Cj4+PiBAQCAtOTEsNyArOTIsOSBA
QCBzdGF0aWMgdW5zaWduZWQgaW50IGdldF9ub2RlaWQodW5zaWduZWQgaW50IGNwdV9pZCkKPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIHdoaWxlICgoZG4gPSByZWFkZGlyKGRpcmVjdG9yeV9u
b2RlKSkgIT0gTlVMTCkgewo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAo
c3RybmNtcChkbi0+ZF9uYW1lLCAiY3B1IiwgMykpCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNwdSA9IHN0cnRvdWwoZG4tPmRfbmFtZSArIDMsIE5VTEwsIDApOwo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUgPSBzdHJ0b3VsKGRuLT5kX25hbWUgKyAzLAo+
Pj4gJmludmFsaWRfbnVtYmVyLCAwKTsKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKHN0cmNtcChpbnZhbGlkX251bWJlciwgIlwwIikpCj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4+Pgo+Pgo+PiBXaHkgb25seSBjaGVj
ayBpZiAqKmVuZHB0ciBpcyAnXDAnIG9uIHJldHVybj8gU2hvdWxkbid0IHdlIGNvbnNpZGVyCj4+
IGEgbW9yZSBnZW5lcmljIHNpdHVhdGlvbiB0aGF0IHdhcyBubyBkaWdpdHMgYW5kICplbmRwdHIg
c3RvcmVzIHRoZQo+PiBvcmlnaW5hbCBzdHJpbmcgKG9yIHJldHVybnMgMCk/Cj4+Cj4KPgo+IFRo
ZSBzdHJ0b3VsIHdpbGwgdHJ5IHRvIGNvbnZlcnQgc3RyaW5nIGludG8gdW5zaWduZWQgbG9uZyBp
bnRlZ2VyLgo+IElmIHN1Y2Nlc3NmdWwgdGhlIGVuZHB0ciB3aWxsIHBvaW50IHRvIGEgIlwwIiBz
dHJpbmcgcmV0dXJuIHRoZSBudW1iZXIsCj4gb3RoZXJ3aXNlIHRvIHRoZSBvcmlnaW5hbCBzdHJp
bmcgYW5kIHJldHVybiAwLgo+IEluIHRoZSBjYXNlIG9mIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9k
ZS9ub2RlMS9jcHVsaXN0LCBlbmRwdHIgaXMgICJsaXN0XDAiCj4gYW5kIHJldHVybiAwLiBUaGUg
c3RyY21wIGZhbHNlIHNraXAgdG8gdGhlIG5leHQgaXRlcmF0aW9uLgo+CgpBaCwgeW91J3JlIHJp
Z2h0LiBIZXJlIHdlJ3JlIGV4cGVjdGluZyB0byBnZXQgYSB2YWxpZCBjcHVpZCwgdGhlCidkbi0+
ZF9uYW1lICsgMycgc2hvdWxkIGJlIHN0cmljdGx5IGVxdWFsIHRvICJOXDAiLgoKVGhhbmtzIGZv
ciB0aGUgZXhwbGFuYXRpb24uCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
