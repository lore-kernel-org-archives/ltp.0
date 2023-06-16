Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CEEB64D9
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 02:51:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B03D3CC879
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 04:51:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4E563CA907
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:51:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10DF8200398
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686883869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8rx5vBcGWsxNK/QbNJL1Jfe85nndoEmC/tFFir+g/8=;
 b=Px7htC8AXPeRzswf5mqTZ/ps38xX5g5aYTbac9FffBURwFkv4Ok8JeyFRazR3lGvHAqTey
 bTyM1qT5Icq8VO16wTcV0d3GciEcaKlwz1mMzwNovDX0QyAJG3KD/F8KAbK7z2Iy/pwqsv
 rdnmVXolsiX7+iRP2fCd2MLVMajOsx8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-JaAE0yIiNtKWDhoLoHTZKw-1; Thu, 15 Jun 2023 22:51:07 -0400
X-MC-Unique: JaAE0yIiNtKWDhoLoHTZKw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b44999a963so1025031fa.1
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 19:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686883866; x=1689475866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8rx5vBcGWsxNK/QbNJL1Jfe85nndoEmC/tFFir+g/8=;
 b=lwlZYkObBcMa912+/YeCKombvp41WyzlTJAEH7C+bQUWz2ydTaSukBXhcgV4DjNjwU
 n6uQOBbJ23VNPMHJPla1Z9Q0VT5H8p278zopg0U+3xst7dQLfgP9xBKTkqnte8Al7OwG
 C+v9Cx0/ejCMyS8pCyDM39At4r1XN0tFSdY0uJt7AkUb/ksg3p9GhqLaAtbO33LYBwwk
 jBEoVdeK8EyNNHqn1/0H5iiWgjkl2XEes+yQR1BNsks072LnqH3RW6qjLDeYSJ5AjFfh
 Lu5JNLasE+FP5wiC5XUZWCwagYsNONwFUSyh4UwMQxWdggcKFhLKq/IVeNcfOItPN23j
 hhIQ==
X-Gm-Message-State: AC+VfDzXf5/cwp4lUCEeqf/0ePFzK4CU9gtTRq9HyXR+hhna9IkVZCAW
 Xgl5VbhT6SLXz3G1T7h34Vg4XdWrWT7omMkqKF0JrYLSImFqcVfBeamfeOroGwkZsQAUFrYacs4
 mxZyUg0PyIZZ7/r2v9pCXJerQegs=
X-Received: by 2002:a2e:8004:0:b0:2ac:8992:272d with SMTP id
 j4-20020a2e8004000000b002ac8992272dmr729756ljg.11.1686883865952; 
 Thu, 15 Jun 2023 19:51:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Lag1SAWUudma3utazZbvJD7OD7C0N0qnFJiQ7QRhegjJ/3p8ueAd8HXGmShpqZ/YdjykGW1mHy8n7TLxdMMY=
X-Received: by 2002:a2e:8004:0:b0:2ac:8992:272d with SMTP id
 j4-20020a2e8004000000b002ac8992272dmr729747ljg.11.1686883865611; Thu, 15 Jun
 2023 19:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230615012445.4184243-1-jencce.kernel@gmail.com>
In-Reply-To: <20230615012445.4184243-1-jencce.kernel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Jun 2023 10:50:54 +0800
Message-ID: <CAEemH2f2Rrco5fSMsmezY5sUJtM2vZpm619d5+v6Kjyhwcm1CQ@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info
 about the operation
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

T24gVGh1LCBKdW4gMTUsIDIwMjMgYXQgOToyNOKAr0FNIE11cnBoeSBaaG91IDxqZW5jY2Uua2Vy
bmVsQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IE1ha2UgdGhlIHNvdXJjZSBhbmQgdGhlIHRhcmdldCB0
byBtb3VudC91bW91bnQgdmlzaWJsZS4gSXQncwo+IGdvb2QgZm9yIGRlYnVnZ2luZy4KPgo+IFNp
Z25lZC1vZmYtYnk6IE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4KPiAtLS0K
PiB2MzoKPiAgIEFwcGx5IHN1Z2dlc3Rpb25zIGZyb20gTGkgYW5kIE1hcnRpbi4gVGhhbmtzIHZl
cnkgbXVjaCEKPgo+ICBsaWIvc2FmZV9tYWNyb3MuYyB8IDE3ICsrKysrKysrKysrKysrKysrCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvbGliL3Nh
ZmVfbWFjcm9zLmMgYi9saWIvc2FmZV9tYWNyb3MuYwo+IGluZGV4IGFmNmRkMDcxNi4uMjZmOTEz
NmFmIDEwMDY0NAo+IC0tLSBhL2xpYi9zYWZlX21hY3Jvcy5jCj4gKysrIGIvbGliL3NhZmVfbWFj
cm9zLmMKPiBAQCAtODk4LDcgKzg5OCwxNiBAQCBpbnQgc2FmZV9tb3VudChjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQgbGluZW5vLAo+IHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPiAgICAg
ICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKQo+ICB7Cj4gICAgICAgICBpbnQgcnZhbCA9IC0x
Owo+ICsgICAgICAgY2hhciBtcGF0aFtQQVRIX01BWF07Cj4KPiArICAgICAgIGlmIChyZWFscGF0
aCh0YXJnZXQsIG1wYXRoKSkgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzbV8oZmlsZSwgbGlu
ZW5vLCBUSU5GTywKPiArICAgICAgICAgICAgICAgICAgICAgICAiTW91bnRpbmcgJXMgdG8gJXMg
ZnN0eXA9JXMgZmxhZ3M9JWx4IiwKPiArICAgICAgICAgICAgICAgICAgICAgICBzb3VyY2UsIG1w
YXRoLCBmaWxlc3lzdGVtdHlwZSwgbW91bnRmbGFncyk7Cj4gKyAgICAgICB9IGVsc2Ugewo+ICsg
ICAgICAgICAgICAgICB0c3RfcmVzbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xl
YW51cF9mbiwKPgoKRm9yZ2V0IHRvIG1lbnRpb24gdGhhdCwgdGhpcyBzaG91bGQgYmUgdHN0X2Jy
a21fKC4uLCBUQlJPSyB8IFRFUlJOTywgLi4uKSwKSSBtYW51YWxseSBmaXggaXQgYW5kIHB1c2hl
ZC4KCgoKPiArICAgICAgICAgICAgICAgICAgICAgICAiQ2Fubm90IHJlc29sdmUgdGhlIGFic29s
dXRlIHBhdGggb2YgJXMiLCB0YXJnZXQpOwo+ICsgICAgICAgfQo+ICAgICAgICAgLyoKPiAgICAg
ICAgICAqIERvbid0IHRyeSB1c2luZyB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIgd2hlbiBtb3Vu
dGluZyBOVEZTLAo+IHNpbmNlCj4gICAgICAgICAgKiB0aGUga2VybmVsJ3MgTlRGUyBkcml2ZXIg
ZG9lc24ndCBoYXZlIHByb3BlciB3cml0ZSBzdXBwb3J0Lgo+IEBAIC05NDgsNiArOTU3LDE0IEBA
IGludCBzYWZlX3Vtb3VudChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+IHZv
aWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPiAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqdGFy
Z2V0KQo+ICB7Cj4gICAgICAgICBpbnQgcnZhbDsKPiArICAgICAgIGNoYXIgbXBhdGhbUEFUSF9N
QVhdOwo+ICsKPiArICAgICAgIGlmIChyZWFscGF0aCh0YXJnZXQsIG1wYXRoKSkgewo+ICsgICAg
ICAgICAgICAgICB0c3RfcmVzbV8oZmlsZSwgbGluZW5vLCBUSU5GTywgIlVtb3VudGluZyAlcyIs
IG1wYXRoKTsKPiArICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9yZXNtXyhm
aWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAo+Cgp0c3RfYnJrbV8oKQoK
Cgo+ICsgICAgICAgICAgICAgICAgICAgICAgICJDYW5ub3QgcmVzb2x2ZSB0aGUgYWJzb2x1dGUg
cGF0aCBvZiAlcyIsIHRhcmdldCk7Cj4gKyAgICAgICB9Cj4KPiAgICAgICAgIHJ2YWwgPSB0c3Rf
dW1vdW50KHRhcmdldCk7Cj4KPiAtLQo+IDIuMzEuMQo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
