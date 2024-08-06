Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5F4C3DA64
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 09:05:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 299343D1D5A
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 11:05:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9323D3CBC79
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:04:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 764901A01474
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722935085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oFZyL5Y08MGl8dggikAUTiQlRNSYxb6X9l+cR/UahzE=;
 b=icz0UuKvAMnZx4eHqEuvAuh2DdsvdJEKLm+vJW21F/wnVmS6MXVtz1ErvHxeM4TWSobu/N
 nJu57dJy/HrJEG2FhI8fC+dW5nxyOjcBRDLNC4u1yiTLayNbE68kbnaCDmkhNey3onaHXa
 jE3Zxom3SfM4fVZDQoMbnzsqjeNZA04=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-1fy_0mCsNXGua-vfQhBeXA-1; Tue, 06 Aug 2024 05:04:43 -0400
X-MC-Unique: 1fy_0mCsNXGua-vfQhBeXA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5d5ffdc9ed9so478051eaf.0
 for <ltp@lists.linux.it>; Tue, 06 Aug 2024 02:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722935083; x=1723539883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFZyL5Y08MGl8dggikAUTiQlRNSYxb6X9l+cR/UahzE=;
 b=DMGG7yEQ5683u3/+qM3AIpXFvznRvIzJhMup+S6xSSj/DHxE8ywqvrPlBUkKqVsA3x
 5Ko2vGudvStWu5X6rfDLr5ONXDHkxC7H/dspvG2TItOJOx7VT/TNusr886b0vmZaLTE2
 tz2S1XKSmLyrZRyapmpAw6VVfr76FxTXfuqOGxBhXrqY8DUN4jyTzIHnsGE9EHJLsKyk
 emOXhhzc/ST+Nz7qCMWaznhOckayviYSXODDVAVFgOEVQe3n3C89r+8BSxO49UTpVAfg
 7vbtVBLrnHSvX8blW/ZzDcu4DUel3k5aD6ZyAo0qjTUzA/y6T0Fn+ImFcyUJqwXgj+uk
 XmKA==
X-Gm-Message-State: AOJu0YyEpHU078U6bgNiUuh1dqGAPmQp5lqmu0U7VAa59hk7BZOXixf/
 sdnWb9i8xgS0VcC1p/QJwI3lMUsIvpO5EbC1prI+AelOfUP6+ywIg71dEvf4YpcfVGJLyYx2oqX
 iDazhGjrKZl8bo0dvmr/vwJtRvnD8WMo43NjqFxRyFEY+9d05bmJqSVQgkcR5RHl76Dy6GHEKE4
 G3zvH+bAOvDguhlImdKi5SLeI=
X-Received: by 2002:a05:6870:a550:b0:259:8805:b634 with SMTP id
 586e51a60fabf-26891ee302bmr17089334fac.49.1722935083010; 
 Tue, 06 Aug 2024 02:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT79g7szBxSspNJO8zo0F/RwDBvcTD57WAIMQ2taVz2nkG8VdCP84gqkYO1hk95OCi0XMIgMZYrZqvvVhHCYo=
X-Received: by 2002:a05:6870:a550:b0:259:8805:b634 with SMTP id
 586e51a60fabf-26891ee302bmr17089310fac.49.1722935082607; Tue, 06 Aug 2024
 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2eF3B41E2nv1+-oMrCUTw7zfVrgCULRBaBe=Pk9roBUiQ@mail.gmail.com>
 <20240806023105.20509-1-liwang@redhat.com> <20240806061947.GB73369@pevik>
 <CAEemH2dR-sQGkwHG5eP9mzKp=oBoLjoFSOe_+7jwnYaJ8NgFzQ@mail.gmail.com>
In-Reply-To: <CAEemH2dR-sQGkwHG5eP9mzKp=oBoLjoFSOe_+7jwnYaJ8NgFzQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 17:04:30 +0800
Message-ID: <CAEemH2ewdg-D-OvAYk31qaLOpteubBDfpHZ2oB1quVK7fbjuTw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] pkey: remove the ltp_ prefix from pkey functions
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

T24gVHVlLCBBdWcgNiwgMjAyNCBhdCAzOjM34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPiBIaSBQZXRyCj4KPiBPbiBUdWUsIEF1ZyA2LCAyMDI0IGF0IDI6MTnigK9Q
TSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gSGkgTGksCj4+Cj4+IFJl
dmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPj4gVGhhbmtzIQo+Pgo+PiBP
dGhlciB0aGluZyB3aGljaCBzaG91bGQgZm9sbG93IGlzIHRvIHVzZSAudGVzdF92YXJpYW50cy4K
Pj4KPgo+IEFzIEkgcG9pbnRlZCBvdXQgaW4gdGhlIGxhc3QgZW1haWwsIG1zZWFsKCkgaXMgdG9v
IG5ldyB0byBsaWJjLCB0aGVyZSBpcwo+IG5vIHdyYXBwZXIgaW4gR2xpYmMgc28gZmFyLgo+IFNo
b3VsZCB3ZSBhZGQgLnRlc3RfdmFyaWFudHMgbm93Pwo+CgpBbnl3YXksIEkgYm9sZGx5IHB1c2hl
ZCB0aGUgcGF0Y2hlcyBhbmQgYWRkZWQgYSBUT0RPIGluIHRoZSBjb21tZW50cy4KQFBldHIsIEkg
d291bGQgYmUgaGFwcHkgdG8gcmV2aWV3IGlmIHlvdSBwbGFuIHRvIHdyaXRlIG1vcmUgdG8gY292
ZXIgbGliYwp3cmFwcGVyLgoKPgotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFs
L21zZWFsMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEu
YwpAQCAtMTksMTIgKzE5LDE1IEBACiAgKiAgIHdoZW4gdXNlcnMgZG9u4oCZdCBoYXZlIHdyaXRl
IHBlcm1pc3Npb24gdG8gdGhlIG1lbW9yeQogICoKICAqIEFueSBvZiB0aGUgZGVzY3JpYmVkIGFj
dGlvbnMgaXMgcmVjb2duaXplZCB2aWEgRVBFUk0gZXJybm8uCisgKgorICogVE9ETzogc3VwcG9y
dCBib3RoIHJhdyBzeXNjYWxsIGFuZCBsaWJjIHdyYXBwZXIgdmlhIC50ZXN0X3ZhcmlhbnRzLgog
ICovCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
