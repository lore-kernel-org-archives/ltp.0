Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA96C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 07:47:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24C463CBE8F
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 09:47:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36293CB332
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:47:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E168E1400DEF
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682063240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwETzVdw+0PkI485G/cI9JTOBOZW+zvX6gbHKfcjRUU=;
 b=HU4yvBVUhknXi/ycLOZBt627Dr3mDmeV20uy2KB5zPI5WQvuqBEKMrIc8/qw9cFEid8fz4
 t7SxZIG3mV1urlo4S/SXNmnDO8zw8N4ektPqV1Xz0Kvttz1XnbgZQ6xaJDK53oY5veg3rV
 VkXjFUoxd/ewdSP46t557PRT8ZNJDMo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-I_35tn5fMmO8pY-9QahMmQ-1; Fri, 21 Apr 2023 03:47:18 -0400
X-MC-Unique: I_35tn5fMmO8pY-9QahMmQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f40f52c604so867667f8f.0
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 00:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682063237; x=1684655237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kwETzVdw+0PkI485G/cI9JTOBOZW+zvX6gbHKfcjRUU=;
 b=a9w56viyV1eHm6pfivdnnwGLCDZL2Zbu5h0To7R2qCExaM6LTtow1/lTAXDAngutHU
 kMqxv6pYav+ci0a3gmufSM3nCFOXa14sOF5L8h4kfciUOsoppvaY2okFoCBCm0NZK9Be
 elCaxiNvH0UUB99qE6OOuMAbm6kx5c9yUrsSdyMfatxrho3Ay11C6+5ssGiLP96zSek0
 aNl31gGHuPtICRjdQ/rQ4/8xVYxh8BQrCm8HfW6hHO2ghO0qkk2eXiQPyt9BbV4FbHNe
 RjQxwLrfJWQn+gsnxUHyq+61QPl+b1shuD+RqZAbMPlrq6ROQUaUS0K9OtmRbMNonh4U
 UApQ==
X-Gm-Message-State: AAQBX9f1BVwaH0haZWQCuruFpTrG3G7AftaBPQ1saKTy489xmEywfqBK
 ZWY10uY+gs95ctJhXCe7rbL5DGl7av//dxZICJCnbFgnQS4/vaDWdwyHZB2DCzIlK61mfpeQUby
 rqp68Oepvvv/AUD9FpYwn1kx+JPgm3oFXsTZsG26w
X-Received: by 2002:adf:db4e:0:b0:2f2:3dbf:6922 with SMTP id
 f14-20020adfdb4e000000b002f23dbf6922mr2621403wrj.22.1682063237134; 
 Fri, 21 Apr 2023 00:47:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bB7HMkQZkL+9glMelxO+A9bt918KYCh+mLTQkHTk1g7b8+5TgsvixwHZbXWTw+PJYFq6cKvh99n5e8s+tX1JI=
X-Received: by 2002:adf:db4e:0:b0:2f2:3dbf:6922 with SMTP id
 f14-20020adfdb4e000000b002f23dbf6922mr2621396wrj.22.1682063236790; Fri, 21
 Apr 2023 00:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
 <20230420160910.809091-3-teo.coupriediaz@arm.com>
In-Reply-To: <20230420160910.809091-3-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Apr 2023 15:47:05 +0800
Message-ID: <CAEemH2fJGR6TVYROcEe2NxH3SckP_W9GJtJjz_Hg+aX-YpA8Zw@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] setpgid03: Add test for PGID in different
 session
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMTI6MDnigK9BTSBUZW8gQ291cHJpZSBEaWF6IDx0ZW8u
Y291cHJpZWRpYXpAYXJtLmNvbT4Kd3JvdGU6Cgo+IFRoZSBjdXJyZW50IHRlc3QgaW4gc2V0cGdp
ZDAzIGdlbmVyYXRlcyBFUEVSTSBiZWNhdXNlIHRoZSBjaGlsZCBpcwo+IGEgc2Vzc2lvbiBsZWFk
ZXIsIGFzIGl0IGhhcyBjYWxsZWQgc2V0c2lkKCkuCj4gRVBFUk0gY2FuIGFsc28gaGFwcGVuIGJ5
IHRyeWluZyB0byBjaGFuZ2UgdG8gYSBQR0lEIGluIGFub3RoZXIgc2Vzc2lvbi4KPiBUaGlzIHdh
cyBwcmV2aW91c2x5IGRvbmUgaW4gc2V0cGdpZDAyLCBidXQgaXQgY291bGQgZmFpbCBvbiBzb21l
IHN5c3RlbXMuCj4KPiBzZXRwZ2lkMDMgcHJvdmlkZXMgYSBndWFyYW50ZWVkIHdheSB0byBnZW5l
cmF0ZSB0aGlzIGVycm9yIGJ5IGZvcmtpbmcgYW5kCj4gc2V0c2lkKCkgaW4gdGhlIGNoaWxkLCBz
byBhZGQgYSB0ZXN0IGZvciBpdCBoZXJlLgo+Cj4gVXBkYXRlIHRoZSBkZXNjcmlwdGlvbiB0byBy
ZWZsZWN0IHRoaXMgdW5kZXJzdGFuZGluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IFRlbyBDb3Vwcmll
IERpYXogPHRlby5jb3VwcmllZGlhekBhcm0uY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRw
Z2lkL3NldHBnaWQwMy5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0
cGdpZDAzLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0cGdpZC9zZXRwZ2lkMDMu
Ywo+IGluZGV4IGIyM2Q2NjJlOS4uOWNlMjYwM2Q4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc2V0cGdpZC9zZXRwZ2lkMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc2V0cGdpZC9zZXRwZ2lkMDMuYwo+IEBAIC0xMSw2ICsxMSw4IEBACj4gICAq
Cj4gICAqIFRlc3RzIHNldHBnaWQoMikgZXJyb3JzOgo+ICAgKgo+ICsgKiAtIEVQRVJNIFRoZSBw
cm9jZXNzIHNwZWNpZmllZCBieSBwaWQgbXVzdCBub3QgYmUgYSBzZXNzaW9uIGxlYWRlci4KPiAr
ICoKPiAgICogLSBFUEVSTSBUaGUgY2FsbGluZyBwcm9jZXNzLCBwcm9jZXNzIHNwZWNpZmllZCBi
eSBwaWQgYW5kIHRoZSB0YXJnZXQKPiAgICogICAgICAgICBwcm9jZXNzIGdyb3VwIG11c3QgYmUg
aW4gdGhlIHNhbWUgc2Vzc2lvbi4KPiAgICoKPiBAQCAtNDMsNiArNDUsOCBAQCBzdGF0aWMgdm9p
ZCBydW4odm9pZCkKPiAgICAgICAgIFRTVF9DSEVDS1BPSU5UX1dBSVQoMCk7Cj4KPiAgICAgICAg
IFRTVF9FWFBfRkFJTChzZXRwZ2lkKGNoaWxkX3BpZCwgZ2V0cHBpZCgpKSwgRVBFUk0pOwo+ICsg
ICAgICAgLyogQ2hpbGQgZGlkIHNldHNpZCgpLCBzbyBpdHMgUEdJRCBpcyBzZXQgdG8gaXRzIFBJ
RC4gKi8KPiArICAgICAgIFRTVF9FWFBfRkFJTChzZXRwZ2lkKDAsIGNoaWxkX3BpZCksIEVQRVJN
KTsKPgo+ICAgICAgICAgVFNUX0NIRUNLUE9JTlRfV0FLRSgwKTsKPgo+IC0tCj4gMi4zNC4xCj4K
Pgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
