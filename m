Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29757C77B73
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 06:30:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42DC83CB84E
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 08:30:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3AE33CB804
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 08:30:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF3C91A0079C
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 08:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685946616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/QeCD4OX5XGbqTh9WySB0nXDPgk5rwEcVga8FOA5gnk=;
 b=RC7fX/DzMHk4sewlNWBBpK61Qg1709K6d1HTYyZBC3y07QCFlwPlijJWn3IBmb9Q58lmmw
 CcZtreGbU4ZZY72ik2raPzl8Xb3oPe3LvMQ9/zFMmtZTIx4ckreee+eT3f8n4YN5d58oQf
 5mijO1R2QmR9Ik0gfnzoUBnPfph0UeE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DV8KNeJEO9GYZBkvMMhWrA-1; Mon, 05 Jun 2023 02:30:14 -0400
X-MC-Unique: DV8KNeJEO9GYZBkvMMhWrA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b168e97cdfso30356141fa.2
 for <ltp@lists.linux.it>; Sun, 04 Jun 2023 23:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685946613; x=1688538613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/QeCD4OX5XGbqTh9WySB0nXDPgk5rwEcVga8FOA5gnk=;
 b=XLItVDY7BNFlz1fEdoBBYlWU5OTmGco/f0iMQ5H7B1jeW4Xhh/7vk3PQZ2YH7ofbED
 NTsjnBWKSJZ0FU7Tfw5YEl647M6khwayonGDt5GR/ZFGN6KhzkQFXcZhzLeHD2lcB4Qe
 quPES3ACv5IMR5t1uoZltZDnrARqWe+zLLzOihJSChqYQmVTF5AlxoTKptFNolVQdgUG
 41mEe4q7QDCdep/uNXgIVyxuptN4VW4o0kWn93T3uU48LU0uL8tJQB+DGgJPHk/ZQuin
 03GdaCl3iJKxzB9yX4daNLDCj25SVGh6pK897lYxD4o4D0pyEhwaH1/iY4Hy7o43UKst
 uWkw==
X-Gm-Message-State: AC+VfDw6OyBDuPYX3Pch/oaf2gJe+I3as0dWN1XfGCTIcUIGg0cTI1EQ
 HnssXoqE9eqfZLChHYlJOAHW1gmgnVfOX9o7cxNwq5xb2iJ5B/8ep2KF7BCLnd4aOreY+of57oI
 FlGRgbMgTYf4EPG1XVMm/HJZGJwA=
X-Received: by 2002:a2e:3a14:0:b0:2ae:e214:482f with SMTP id
 h20-20020a2e3a14000000b002aee214482fmr3518089lja.52.1685946613271; 
 Sun, 04 Jun 2023 23:30:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oG4QzphYZYUmolflEbwGyPxnwUzZ8/GFj2lJT4e4GVbnhH/UUWTWnugOT4a2vnjkkrxe2h04s0giBIoDebVc=
X-Received: by 2002:a2e:3a14:0:b0:2ae:e214:482f with SMTP id
 h20-20020a2e3a14000000b002aee214482fmr3518078lja.52.1685946612955; Sun, 04
 Jun 2023 23:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230604095117.3543342-1-jencce.kernel@gmail.com>
In-Reply-To: <20230604095117.3543342-1-jencce.kernel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Jun 2023 14:30:00 +0800
Message-ID: <CAEemH2ePfF5hgGQkaBZ=CQ0A=TH6YE3GPgpspCgOPvsyn2Y+nQ@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: print debug info about mounting
 operation
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

SGkgTXVycGh5LAoKVGhpcyBpcyBoZWxwZnVsIGZvciBrbm93aW5nIHRoZSBtb3VudCBpbmZvLgoK
QnV0IGFzIFNBRkVfTU9VTlQgaXMgbm90IG9ubHkgdXNlZCBmb3IgcmVsYXRpdmUgcGF0aCBidXQK
bW91bnQgYWJzb2x1dGUgcGF0aCwgc28gd2UnZCBiZXR0ZXIgZGV0ZXJtaW5lIHdoYXQgdGhlICcq
dGFyZ2V0JwpwYXRoIHR5cGUuCgpIb3cgYWJvdXQgY2hhbmdpbmcgdG8gYmVsb3c6CgogICAgICAg
aWYgKHRhcmdldFswXSA9PSAnLycpIHsKICAgICAgICAgICAgICAgc3RybmNweShtcGF0aCwgdGFy
Z2V0LCBQQVRIX01BWC0xKTsKICAgICAgICAgICAgICAgbXBhdGhbUEFUSF9NQVgtMV0gPSAnXDAn
OwogICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgICAgLi4uLiB5b3VyIHJlbGF0aXZlIHBhdGgg
Y29kZSAuLi4KICAgICAgIH0KCiAgICAgICB0c3RfcmVzbV8oZmlsZSwgbGluZW5vLCBUSU5GTywK
ICAgICAgICAgICAgICAgIk1vdW50aW5nICVzIHRvICVzIGZzdHlwPSVzIGZsYWdzPSV4IiwKICAg
ICAgICAgICAgICAgc291cmNlLCBtcGF0aCwgZmlsZXN5c3RlbXR5cGUsIG1vdW50ZmxhZ3MpOwoK
Ck9uIFN1biwgSnVuIDQsIDIwMjMgYXQgNTo1MeKAr1BNIE11cnBoeSBaaG91IDxqZW5jY2Uua2Vy
bmVsQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IE11cnBoeSBaaG91IDxqZW5j
Y2Uua2VybmVsQGdtYWlsLmNvbT4KPiAtLS0KPiAgbGliL3NhZmVfbWFjcm9zLmMgfCAxNyArKysr
KysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIvbGliL3NhZmVfbWFjcm9zLmMKPiBpbmRleCBh
ZjZkZDA3MTYuLmE2NjI4NWEwZSAxMDA2NDQKPiAtLS0gYS9saWIvc2FmZV9tYWNyb3MuYwo+ICsr
KyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4gQEAgLTg5OCw3ICs4OTgsMjQgQEAgaW50IHNhZmVfbW91
bnQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiB2b2lkICgqY2xlYW51cF9m
bikodm9pZCksCj4gICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAqZGF0YSkKPiAgewo+ICAgICAg
ICAgaW50IHJ2YWwgPSAtMTsKPiArICAgICAgIGNoYXIgY2RpcltQQVRIX01BWF0sIG1wYXRoW1BB
VEhfTUFYXTsKPgo+ICsgICAgICAgaWYgKCFnZXRjd2QoY2RpciwgUEFUSF9NQVgpKSB7Cj4gKyAg
ICAgICAgICAgICAgIHRzdF9yZXNtKFRXQVJOIHwgVEVSUk5PLCAiRmFpbGVkIHRvIGZpbmQgY3Vy
cmVudAo+IGRpcmVjdG9yeSIpOwo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiArICAgICAg
IH0KPiArCj4gKyAgICAgICBydmFsID0gc25wcmludGYobXBhdGgsIFBBVEhfTUFYLCAiJXMvJXMi
LCBjZGlyLCB0YXJnZXQpOwo+ICsgICAgICAgaWYgKHJ2YWwgPCAwIHx8IHJ2YWwgPj0gUEFUSF9N
QVgpIHsKPiArICAgICAgICAgICAgICAgdHN0X3Jlc20oVFdBUk4gfCBURVJSTk8sCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICJzbnByaW50ZigpIHNob3VsZCBoYXZlIHJldHVybmVkICVkIGlu
c3RlYWQgb2YKPiAlZCIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIFBBVEhfTUFYLCBydmFs
KTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKyAgICAgICB9Cj4gKwoKKyAgICAgICB0
c3RfcmVzbV8oZmlsZSwgbGluZW5vLCBUSU5GTywKPiArICAgICAgICAgICAgICAgIk1vdW50aW5n
ICVzIHRvICVzIGZzdHlwPSVzIGZsYWdzPSV4IiwKPiArICAgICAgICAgICAgICAgc291cmNlLCBt
cGF0aCwgZmlsZXN5c3RlbXR5cGUsIG1vdW50ZmxhZ3MpOwo+ICAgICAgICAgLyoKPiAgICAgICAg
ICAqIERvbid0IHRyeSB1c2luZyB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIgd2hlbiBtb3VudGlu
ZyBOVEZTLAo+IHNpbmNlCj4gICAgICAgICAgKiB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIgZG9l
c24ndCBoYXZlIHByb3BlciB3cml0ZSBzdXBwb3J0Lgo+IC0tCj4gMi4zMS4xCj4KPgo+IC0tCj4g
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4K
PgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
